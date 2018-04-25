Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeDYHIX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:08:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32879 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeDYHIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:08:16 -0400
X-Google-Smtp-Source: AIpwx49pvAUgMS5bNue1LZw7ErKyC+99vinoCCoTyx11pG5ewrLSVeKFgmLOKtxGvsVfzF3vG3rVwQ==
Date: Wed, 25 Apr 2018 09:08:12 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Lars-Peter Clausen <lars@metafoo.de>,
        Bhumika Goyal <bhumirks@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, Inki Dae <inki.dae@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: adv7511: fix mode_valid's return type
Message-ID: <20180425070812.GK25142@phenom.ffwll.local>
Mail-Followup-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bhumika Goyal <bhumirks@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org
References: <20180424131450.1910-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131450.1910-1-luc.vanoostenryck@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:14:47PM +0200, Luc Van Oostenryck wrote:
> The method struct drm_connector_helper_funcs::mode_valid is defined
> as returning an 'enum drm_mode_status' but the driver implementation
> for this method uses an 'int' for it.
> 
> Fix this by using 'enum drm_mode_status' in the driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index efa29db5f..1b74ee00b 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -654,7 +654,7 @@ adv7511_detect(struct adv7511 *adv7511, struct drm_connector *connector)
>  	return status;
>  }
>  
> -static int adv7511_mode_valid(struct adv7511 *adv7511,
> +static enum drm_mode_status adv7511_mode_valid(struct adv7511 *adv7511,
>  			      struct drm_display_mode *mode)
>  {
>  	if (mode->clock > 165000)
> -- 
> 2.17.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
