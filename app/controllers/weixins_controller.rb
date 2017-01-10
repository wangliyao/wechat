class WeixinsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_weixin_legality
  @@token = "weixin_ceshisssss"
  def show
    return  render plain: params[:echostr]
  end

  def create
    if params[:xml][:MsgType] == "text"
      render "echo", :formats => :xml
    end
  end
  private

  def check_weixin_legality
    array = [@@token, params[:timestamp], params[:nonce]].sort
    render :plain => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end
