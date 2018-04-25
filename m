Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeDYHkI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:40:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39820 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeDYHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:40:06 -0400
X-Google-Smtp-Source: AIpwx486V6uH6E/yuARuWhleJIUMwl55sAMoRP6mk3ba7UlJy0Qe+mGcJrxISSTX9aGMNoy7kjdjnA==
Date: Wed, 25 Apr 2018 09:40:02 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] drm/virtio: fix mode_valid's return type
Message-ID: <20180425074002.GP25142@phenom.ffwll.local>
Mail-Followup-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20180424131524.2510-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131524.2510-1-luc.vanoostenryck@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:15:24PM +0200, Luc Van Oostenryck wrote:
> The method struct drm_connector_helper_funcs::mode_valid is defined
> as returning an 'enum drm_mode_status' but the driver implementation
> for this method uses an 'int' for it.
> 
> Fix this by using 'enum drm_mode_status' in the driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Ok, applied all the others that have been stuck in moderation or
something, except for any patch touching nouveau/radeon/amdgpu. Those need
ot go in through other trees.

All merged into drm-misc-next.

Thanks, Daniel
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 8cc8c34d6..a5edd8660 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -208,7 +208,7 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
>  	return count;
>  }
>  
> -static int virtio_gpu_conn_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status virtio_gpu_conn_mode_valid(struct drm_connector *connector,
>  				      struct drm_display_mode *mode)
>  {
>  	struct virtio_gpu_output *output =
> -- 
> 2.17.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
