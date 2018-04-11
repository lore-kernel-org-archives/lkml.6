Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756963AbeDKTdI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:33:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:53407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753602AbeDKTdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:33:05 -0400
Date: Wed, 11 Apr 2018 21:32:43 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-X-Sender: lyakh@axis700.grange
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
cc: linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Edgar Thier <info@edgarthier.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: uvcvideo: Prevent setting unavailable flags
In-Reply-To: <1521646988-803-1-git-send-email-kieran.bingham@ideasonboard.com>
Message-ID: <alpine.DEB.2.20.1804112131160.25028@axis700.grange>
References: <1521646988-803-1-git-send-email-kieran.bingham@ideasonboard.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3GDsCnK5lR8nvUZudPOqSlTlC4+Ft0sMwuvu9MM+ca/D/TH9I3X
 A/3pWcla1hfvEIJx8aIeVhji7bCKuFzDqHWH17Lau38L7Z9uobn2CNIj54K58ZiT/3pWKcd
 io2LHoDvR8jZZyY+3UwQn3uWMG4u5vOAQQKPBC9X/U51n+PwhMa0VFt0hAKZCdkjliGFMiU
 8qLFxoR1ciEWMLLR+9DsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MHFpAqBlpJI=:BSPT7XKdDXXxu4VN9XqqYL
 ZDBLwj5jWmWSI39eYgqmGBMuCZZNlczZKDxutMS40M0RL+/jl/yb2gudouZ/bTPRkyqaQitBc
 8sncVY6+BvAY6r3U1uAdSJDiwsNkLmCX+HfMbAE4aoeWFqIpjX9IRb0wDB1VSCrke/2m9Lyis
 xWxEACRyUZ7jIh4KBpRqZT3SVTehO24/z1ukainoZhoC2pUWmCaQFXUzEo+JYgYKRZqIc9vAl
 /K4CzaPoKWh0NteLJlFRq4g9fPy6pJfVEbO/WVRfvRZ2Dhp+QbqHU5QLNnn/Mnl/GFnPHtXKv
 e3tUJidyu1/8u0nl6BG5uaISGIrf3dIOtTPbtmx+lc0w2kROU+vRFz7hMgAiC3aKqVDhCwew9
 ykIJJRBXo+GwZf/FCNMsps7Pr4fSRcfmFO2ryIow+Asnsr0+Wrecjtq7zlnkxb/1VhU+e8bcw
 UcgPpppbEvvr9OVUf4avCH7OOhKV+DZzbaPqEfr/wt7S7czFYxnHrrMDaJQtsn4ty9E/m77UT
 eVthfCwueX86DPa+JfAgWLFnL3MjJK+8hFd5of47qoylS+7lhxUeoH66aZ+tq0FtMkZ65dA/x
 soKRmTyBGaqno4DLNoUWabS0kbBFYah2DCQZ2yT/gCCUj5eBuLHOX/IUwKnMrStIwvfEDJ06m
 FCs4LaHsG32TfK/QFl/10Tjx7oPwZmaJqJZjNE7Lp09WsbsGFODQ12UciQ55sAg15+YhaTT+a
 3mCgIAU9GPJfRmMKcd6DjAczewUaMo+L2P6qJiQVi9hnpbluB/WJfwxiuD5SRq7pEviqlfQ4s
 FGpH0ErEPp+mtEjrtVZvcXkp8QGxFf4/LoCUJdzx3jlYQDO1No=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thanks for the patch, it fixed a problem I was having with media master, 
working with a Logitech UVC 1.5 camera.

On Wed, 21 Mar 2018, Kieran Bingham wrote:

> The addition of an extra operation to use the GET_INFO command
> overwrites all existing flags from the uvc_ctrls table. This includes
> setting all controls as supporting  GET_MIN, GET_MAX, GET_RES, and
> GET_DEF regardless of whether they do or not.
> 
> Move the initialisation of these control capabilities directly to the
> uvc_ctrl_fill_xu_info() call where they were originally located in that
> use case, and ensure that the new functionality in uvc_ctrl_get_flags()
> will only set flags based on their reported capability from the GET_INFO
> call.
> 
> Fixes: 859086ae3636 ("media: uvcvideo: Apply flags from device to actual
> properties")
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Tested-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>

Thanks
Guennadi

> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 1daf444371be..4042cbdb721b 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1607,14 +1607,12 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
>  	ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id, dev->intfnum,
>  			     info->selector, data, 1);
>  	if (!ret)
> -		info->flags = UVC_CTRL_FLAG_GET_MIN | UVC_CTRL_FLAG_GET_MAX
> -			    | UVC_CTRL_FLAG_GET_RES | UVC_CTRL_FLAG_GET_DEF
> -			    | (data[0] & UVC_CONTROL_CAP_GET ?
> -			       UVC_CTRL_FLAG_GET_CUR : 0)
> -			    | (data[0] & UVC_CONTROL_CAP_SET ?
> -			       UVC_CTRL_FLAG_SET_CUR : 0)
> -			    | (data[0] & UVC_CONTROL_CAP_AUTOUPDATE ?
> -			       UVC_CTRL_FLAG_AUTO_UPDATE : 0);
> +		info->flags |= (data[0] & UVC_CONTROL_CAP_GET ?
> +				UVC_CTRL_FLAG_GET_CUR : 0)
> +			    |  (data[0] & UVC_CONTROL_CAP_SET ?
> +				UVC_CTRL_FLAG_SET_CUR : 0)
> +			    |  (data[0] & UVC_CONTROL_CAP_AUTOUPDATE ?
> +				UVC_CTRL_FLAG_AUTO_UPDATE : 0);
>  
>  	kfree(data);
>  	return ret;
> @@ -1689,6 +1687,9 @@ static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
>  
>  	info->size = le16_to_cpup((__le16 *)data);
>  
> +	info->flags = UVC_CTRL_FLAG_GET_MIN | UVC_CTRL_FLAG_GET_MAX
> +		    | UVC_CTRL_FLAG_GET_RES | UVC_CTRL_FLAG_GET_DEF;
> +
>  	ret = uvc_ctrl_get_flags(dev, ctrl, info);
>  	if (ret < 0) {
>  		uvc_trace(UVC_TRACE_CONTROL,
> -- 
> 2.7.4
> 
