Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2005C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8854820869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VYbRk5ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbeLTHAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:00:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46433 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeLTHAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:00:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so769780edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mIhST+iVbAL5KTp771n6Q0HNklWlQVNUNPnDhfg/ZYE=;
        b=VYbRk5ky0FHCq5EYpxQlwRkQDK0eRl0OTBD25KSGiYk2clIkxcSYp0Q/kR/mQouI7A
         8sw1Xi/ESQ++hDG5Ht6S4l8BpVDtx5kf/t1GRFO5FlRVwmtZ5/+uGOOhm5eIJJhcaz8s
         Qzkn3V2E+024yXVoBl/zlTnMWaf7MhXC0WFCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mIhST+iVbAL5KTp771n6Q0HNklWlQVNUNPnDhfg/ZYE=;
        b=eIBu9A08fpLQ8zilK8P3txAWJ7PkVWJdrocB8gWtmEvyy/K6Uc+Blw+4nq06EV1Of/
         FTnYr9Aa9a5TjrgvZVEqkNiPjAkBOAAC3p7zH5VtivnzPyU6AH3nnX3SeKKMSGyeAEeM
         deCR860V9Q69HH7vMRX47xu64SfNBopMnjGC3hhowKHtk6tuSEKNcWwfBk+lvPm2IYjP
         9uJmA2Fv/Cjo5VyxF75XTgzloQEPZRbeWUYx3P1cflqyinPJmsjguvNGZYhLvlhw4wSJ
         WOStMJqOwyrrHSWGmEMS8fQE/BN9vw79JgtyYHsADXrVqcqHv0qRecNIBlKlhGSxy2+5
         /aPA==
X-Gm-Message-State: AA+aEWa2vBDdjlX0W7+lZC9kscPigj1wNw2U65Xhc3fViV3+2AZ5A8I8
        DQOsQhVtFdIBB6KzUnq1AF+/u0JJri8=
X-Google-Smtp-Source: AFSGD/Wuaq7h1p/U2TjXFfMWrjuzKJ2C+bqUa8mJsRfj+vVkXO0pc1DDSnCpUxbQjfOzJvnuJWjZ6Q==
X-Received: by 2002:a50:b7d6:: with SMTP id i22mr22026051ede.27.1545289242300;
        Wed, 19 Dec 2018 23:00:42 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g40sm5875391edg.39.2018.12.19.23.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 23:00:41 -0800 (PST)
Date:   Thu, 20 Dec 2018 08:00:38 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/7] drm: msm: Cleanup drm_display_mode print string
Message-ID: <20181220070038.GA21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <cover.1545254191.git.shayenneluzmoura@gmail.com>
 <24aeab722bc1d37fce75f6f8bf4b6dd4c6fee8b1.1545254191.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24aeab722bc1d37fce75f6f8bf4b6dd4c6fee8b1.1545254191.git.shayenneluzmoura@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 07:21:41PM -0200, Shayenne Moura wrote:
> This patch adjust the print string of drm_display_mode object
> to remove drm_mode_object dependency in msm files.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Please have a per-patch changelog of what changed compared to earlier
versions, e.g. here:

v2: Use DRM_MODE_FMT/ARG macros (Daniel).

Or something like that. Patch series threading looks correct now.
-Daniel
> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         | 10 ++--------
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  9 +--------
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  9 +--------
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  9 +--------
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  9 +--------
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         |  9 +--------
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c      |  9 +--------
>  drivers/gpu/drm/msm/dsi/dsi_manager.c             |  9 +--------
>  drivers/gpu/drm/msm/edp/edp_bridge.c              |  9 +--------
>  9 files changed, 10 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> index 457c29dba4a1..7b028f778960 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> @@ -244,14 +244,8 @@ static void mdp4_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  
>  	mode = &crtc->state->adjusted_mode;
>  
> -	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mdp4_crtc->name, mode->base.id, mode->name,
> -			mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal,
> -			mode->type, mode->flags);
> +	DBG("%s: set mode: " DRM_MODE_FMT,
> +			mdp4_crtc->name, DRM_MODE_ARG(mode));
>  
>  	mdp4_write(mdp4_kms, REG_MDP4_DMA_SRC_SIZE(dma),
>  			MDP4_DMA_SRC_SIZE_WIDTH(mode->hdisplay) |
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> index 6a1ebdace391..f2009e317820 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> @@ -58,14 +58,7 @@ static void mdp4_dsi_encoder_mode_set(struct drm_encoder *encoder,
>  
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> -			mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal,
> -			mode->type, mode->flags);
> +	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG()):
>  
>  	ctrl_pol = 0;
>  	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> index ba8e587f734b..f6bc86a35d8d 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> @@ -104,14 +104,7 @@ static void mdp4_dtv_encoder_mode_set(struct drm_encoder *encoder,
>  
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> -			mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal,
> -			mode->type, mode->flags);
> +	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
>  
>  	mdp4_dtv_encoder->pixclock = mode->clock * 1000;
>  
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> index 2bfb39082f54..d47b8f4af991 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> @@ -273,14 +273,7 @@ static void mdp4_lcdc_encoder_mode_set(struct drm_encoder *encoder,
>  
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> -			mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal,
> -			mode->type, mode->flags);
> +	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
>  
>  	mdp4_lcdc_encoder->pixclock = mode->clock * 1000;
>  
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> index d6f79dc755b4..33972c1816ed 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> @@ -134,14 +134,7 @@ void mdp5_cmd_encoder_mode_set(struct drm_encoder *encoder,
>  {
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> -			mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal,
> -			mode->type, mode->flags);
> +	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
>  	pingpong_tearcheck_setup(encoder, mode);
>  	mdp5_crtc_set_pipeline(encoder->crtc);
>  }
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> index b1da9ce54379..66f5402484d4 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> @@ -384,14 +384,7 @@ static void mdp5_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  
>  	mode = &crtc->state->adjusted_mode;
>  
> -	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			crtc->name, mode->base.id, mode->name,
> -			mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal,
> -			mode->type, mode->flags);
> +	DBG("%s: set mode: " DMR_MODE_FMT, crtc->name, DRM_MODE_ARG(mode));
>  
>  	mixer_width = mode->hdisplay;
>  	if (r_mixer)
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> index fcd44d1d1068..d2a56e55e53d 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> @@ -118,14 +118,7 @@ static void mdp5_vid_encoder_mode_set(struct drm_encoder *encoder,
>  
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> -			mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal,
> -			mode->type, mode->flags);
> +	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
>  
>  	ctrl_pol = 0;
>  
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 80aa6344185e..7c8352a8ea97 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -536,14 +536,7 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
>  	struct mipi_dsi_host *host = msm_dsi->host;
>  	bool is_dual_dsi = IS_DUAL_DSI();
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> -			mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal,
> -			mode->type, mode->flags);
> +	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
>  
>  	if (is_dual_dsi && !IS_MASTER_DSI_LINK(id))
>  		return;
> diff --git a/drivers/gpu/drm/msm/edp/edp_bridge.c b/drivers/gpu/drm/msm/edp/edp_bridge.c
> index 931a5c97cccf..153f350ce017 100644
> --- a/drivers/gpu/drm/msm/edp/edp_bridge.c
> +++ b/drivers/gpu/drm/msm/edp/edp_bridge.c
> @@ -60,14 +60,7 @@ static void edp_bridge_mode_set(struct drm_bridge *bridge,
>  	struct edp_bridge *edp_bridge = to_edp_bridge(bridge);
>  	struct msm_edp *edp = edp_bridge->edp;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> -			mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal,
> -			mode->type, mode->flags);
> +	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
>  
>  	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
>  		if ((connector->encoder != NULL) &&
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
