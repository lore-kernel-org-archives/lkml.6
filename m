Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69225C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A7217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Xy3RVlnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeLSNJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:09:14 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36657 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeLSNJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:09:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so16911177edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pb3Pxkaw+9pKzkcVeu30YOVI+GbMGiXC1mjkbOgZqkM=;
        b=Xy3RVlnjgsNyGiAXME7zhx2fx3BSitMZQks2Xais2qBiGQ6hgkxHy7fz3hfnUdDAci
         PTWkTN+sWubfwxnXcuvn1Q+h6uUJHqHWnG9BkBlZni30murcmmDxR/2fw8AIwIACGPae
         qcTt2ofeuzorodO8ltI9cwbldDY+kXbMGOUAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pb3Pxkaw+9pKzkcVeu30YOVI+GbMGiXC1mjkbOgZqkM=;
        b=fIaMrWfAbAwVaI+21huCjIra+Jy9YTX7PD1AL4/5otD9yYo9Fo06PFaldl8v82LVrD
         bNWEYAAGEfFeHlBXzQa1qJkLofb+5OzVWQwj45QTJH3XCiW3BTqNuFSfrXivTNFtOvod
         2bT5JbQ9VQHcZtxhfGNAV74QLMl3PKB5ZNAgClimCjcI7TNTpT+xf8N6euzfg80NiLBs
         n8/grHuSMK5NHJlfmPbdwv991boIHk8uAk261PG8QntasCvHcKmJ9zD6QA/UI1DJ7NOA
         AHzppRW+12+g/cXBM9Q7yN16EGLDF/CjamOsyKRytO3QZD1VJSOqr3HVzW9wGwK0bphn
         8u3Q==
X-Gm-Message-State: AA+aEWaWh7aNdOCi6TMlzz/uKtQasU+0mlj+IfS0smG7eP9Yx1zo74NN
        JewpZzJfpDem7yBFyF+W1P35MB1SunY=
X-Google-Smtp-Source: AFSGD/UELR7x/DLR4klbc1M92bywQ19z65qHBheZCofd3Sy52+Cd60f2XijGl2urhl4jGe2if5S40w==
X-Received: by 2002:a50:d6c5:: with SMTP id l5mr20113130edj.145.1545224952247;
        Wed, 19 Dec 2018 05:09:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c23-v6sm2704993ejb.62.2018.12.19.05.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:09:11 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:09:09 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/7] drm: msm: Delete base.id prints
Message-ID: <20181219130909.GO21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181218133803.hfp62heugg4eeqcx@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218133803.hfp62heugg4eeqcx@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:38:03AM -0200, Shayenne Moura wrote:
> This patch removes base.id prints from drm_display_mode
> objects in msm files. It removes dependency from drm_mode_object.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

I think switching these over to the DRM_MODE_FMT and DRM_MODE_ARG like
drm_mode_debug_printmodeline() would be a really nice cleanup. Since you
need to touch them all anyway.

Same for all the other places that just print a modeline.
-Daniel


> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         | 4 ++--
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  | 4 ++--
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  | 4 ++--
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 4 ++--
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  | 4 ++--
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         | 4 ++--
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c      | 4 ++--
>  drivers/gpu/drm/msm/dsi/dsi_manager.c             | 4 ++--
>  drivers/gpu/drm/msm/edp/edp_bridge.c              | 4 ++--
>  9 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> index 457c29dba4a1..4d35fe5b8c07 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> @@ -244,8 +244,8 @@ static void mdp4_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  
>  	mode = &crtc->state->adjusted_mode;
>  
> -	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mdp4_crtc->name, mode->base.id, mode->name,
> +	DBG("%s: set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			mdp4_crtc->name, mode->name,
>  			mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> index 6a1ebdace391..a12ad73f08c7 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> @@ -58,8 +58,8 @@ static void mdp4_dsi_encoder_mode_set(struct drm_encoder *encoder,
>  
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> +	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			mode->name,
>  			mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> index ba8e587f734b..3ace21e116a0 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> @@ -104,8 +104,8 @@ static void mdp4_dtv_encoder_mode_set(struct drm_encoder *encoder,
>  
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> +	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			mode->name,
>  			mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> index 2bfb39082f54..21be7640d3a8 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> @@ -273,8 +273,8 @@ static void mdp4_lcdc_encoder_mode_set(struct drm_encoder *encoder,
>  
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> +	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			mode->name,
>  			mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> index d6f79dc755b4..ac61a10b79cc 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> @@ -134,8 +134,8 @@ void mdp5_cmd_encoder_mode_set(struct drm_encoder *encoder,
>  {
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> +	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			mode->name,
>  			mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> index b1da9ce54379..ef2ee5888777 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> @@ -384,8 +384,8 @@ static void mdp5_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  
>  	mode = &crtc->state->adjusted_mode;
>  
> -	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			crtc->name, mode->base.id, mode->name,
> +	DBG("%s: set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			crtc->name, mode->name,
>  			mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> index fcd44d1d1068..b5e4ef236589 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> @@ -118,8 +118,8 @@ static void mdp5_vid_encoder_mode_set(struct drm_encoder *encoder,
>  
>  	mode = adjusted_mode;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> +	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			mode->name,
>  			mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 80aa6344185e..e72ba60f4db8 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -536,8 +536,8 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
>  	struct mipi_dsi_host *host = msm_dsi->host;
>  	bool is_dual_dsi = IS_DUAL_DSI();
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> +	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			mode->name,
>  			mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
> diff --git a/drivers/gpu/drm/msm/edp/edp_bridge.c b/drivers/gpu/drm/msm/edp/edp_bridge.c
> index 931a5c97cccf..160e8d91eda2 100644
> --- a/drivers/gpu/drm/msm/edp/edp_bridge.c
> +++ b/drivers/gpu/drm/msm/edp/edp_bridge.c
> @@ -60,8 +60,8 @@ static void edp_bridge_mode_set(struct drm_bridge *bridge,
>  	struct edp_bridge *edp_bridge = to_edp_bridge(bridge);
>  	struct msm_edp *edp = edp_bridge->edp;
>  
> -	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -			mode->base.id, mode->name,
> +	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +			mode->name,
>  			mode->vrefresh, mode->clock,
>  			mode->hdisplay, mode->hsync_start,
>  			mode->hsync_end, mode->htotal,
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
