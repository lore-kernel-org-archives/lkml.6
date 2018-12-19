Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D485DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D7E20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKAKI2JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbeLSVVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:21:50 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42187 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbeLSVVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:21:50 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so23895288qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TFY4gd+AkyTeKPHQ/B5HqBX5P7h6tPseaXk7W+UUhnY=;
        b=tKAKI2JS8E4ghHjPndFWpataoOdGJYHSLY0xq7bIuxFZ30y6t4wcMw7aDypxn/+zxg
         TbWygfI+mG/0dyofKBGF19fUhgCkCtrdKk+Cy0RgUna1T/8u9erRnR8+iBLW7zgXHbWl
         hbixOHp+qW14xRfAKvIYN7Y0ZzETWygxJy1CK3XwDzqe+i72oFakF8esn/GYeRwHcDAs
         3BWP4As0AwcHzuJG66HPhkPDeR/mg+x/E/NDdnMvE4+JqsZ8RJshheG/hltmqsaTgxdl
         RHeaEYvToQDXQMM2nFlC0uP+r3DM4cmnn+0azFG0w9gxAYrxqKyd1TIisAdmsnbatRkC
         EKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TFY4gd+AkyTeKPHQ/B5HqBX5P7h6tPseaXk7W+UUhnY=;
        b=iHJCuxEH/CpIt1BCi/m+HHV/GpLgx+h+sy605DSNf4NCrcQIxDgXKJjElHYoDaPpdr
         4gA3zWsZLUD7vAHZEbGKUEz/gLbl29mACA26Rwj/rD850PUhzICh3Xb7OET64iArBToQ
         1BLFQmA++r3HS+QgI+MbCVQ+c7DIwUdfwpjLiYZaEOitthACT/hq0EpYdILEP3XUtyZq
         F0Mews/akGNNHw0sPkxwH2pblgcheFhiZPjNiF+SXQoKb+xuA4xQ9UhYSvtQ91J5jQF6
         0IrBFpLtROizvxl+qBbAdeYQgvPi+qObAwlQe5sLxJlXjcr6+HrA4e31cz4gCjMxwFHO
         siPQ==
X-Gm-Message-State: AA+aEWaXR2rQigY5rnM/eEidiY+Ckn3jy7DSi4CGGJWK2zH6sVeMkkMs
        VJ0F8xzTvSbsOl9xlSQO3Gc=
X-Google-Smtp-Source: AFSGD/WXDgDM2xBVkJRfDu9sNRJAXO4gb1zkvj64vglPd3OVXFa24GOEqfHgoeqdPOPjPdme+K6biA==
X-Received: by 2002:aed:3084:: with SMTP id 4mr6731136qtf.30.1545254508593;
        Wed, 19 Dec 2018 13:21:48 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id r67sm3013114qkr.28.2018.12.19.13.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 13:21:48 -0800 (PST)
Date:   Wed, 19 Dec 2018 19:21:41 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] drm: msm: Cleanup drm_display_mode print string
Message-ID: <24aeab722bc1d37fce75f6f8bf4b6dd4c6fee8b1.1545254191.git.shayenneluzmoura@gmail.com>
References: <cover.1545254191.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545254191.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in msm files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         | 10 ++--------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  9 +--------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  9 +--------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  9 +--------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  9 +--------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         |  9 +--------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c      |  9 +--------
 drivers/gpu/drm/msm/dsi/dsi_manager.c             |  9 +--------
 drivers/gpu/drm/msm/edp/edp_bridge.c              |  9 +--------
 9 files changed, 10 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
index 457c29dba4a1..7b028f778960 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
@@ -244,14 +244,8 @@ static void mdp4_crtc_mode_set_nofb(struct drm_crtc *crtc)
 
 	mode = &crtc->state->adjusted_mode;
 
-	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mdp4_crtc->name, mode->base.id, mode->name,
-			mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal,
-			mode->type, mode->flags);
+	DBG("%s: set mode: " DRM_MODE_FMT,
+			mdp4_crtc->name, DRM_MODE_ARG(mode));
 
 	mdp4_write(mdp4_kms, REG_MDP4_DMA_SRC_SIZE(dma),
 			MDP4_DMA_SRC_SIZE_WIDTH(mode->hdisplay) |
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
index 6a1ebdace391..f2009e317820 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
@@ -58,14 +58,7 @@ static void mdp4_dsi_encoder_mode_set(struct drm_encoder *encoder,
 
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
-			mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal,
-			mode->type, mode->flags);
+	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG()):
 
 	ctrl_pol = 0;
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
index ba8e587f734b..f6bc86a35d8d 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
@@ -104,14 +104,7 @@ static void mdp4_dtv_encoder_mode_set(struct drm_encoder *encoder,
 
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
-			mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal,
-			mode->type, mode->flags);
+	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
 
 	mdp4_dtv_encoder->pixclock = mode->clock * 1000;
 
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index 2bfb39082f54..d47b8f4af991 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -273,14 +273,7 @@ static void mdp4_lcdc_encoder_mode_set(struct drm_encoder *encoder,
 
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
-			mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal,
-			mode->type, mode->flags);
+	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
 
 	mdp4_lcdc_encoder->pixclock = mode->clock * 1000;
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
index d6f79dc755b4..33972c1816ed 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
@@ -134,14 +134,7 @@ void mdp5_cmd_encoder_mode_set(struct drm_encoder *encoder,
 {
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
-			mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal,
-			mode->type, mode->flags);
+	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
 	pingpong_tearcheck_setup(encoder, mode);
 	mdp5_crtc_set_pipeline(encoder->crtc);
 }
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index b1da9ce54379..66f5402484d4 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -384,14 +384,7 @@ static void mdp5_crtc_mode_set_nofb(struct drm_crtc *crtc)
 
 	mode = &crtc->state->adjusted_mode;
 
-	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			crtc->name, mode->base.id, mode->name,
-			mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal,
-			mode->type, mode->flags);
+	DBG("%s: set mode: " DMR_MODE_FMT, crtc->name, DRM_MODE_ARG(mode));
 
 	mixer_width = mode->hdisplay;
 	if (r_mixer)
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
index fcd44d1d1068..d2a56e55e53d 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
@@ -118,14 +118,7 @@ static void mdp5_vid_encoder_mode_set(struct drm_encoder *encoder,
 
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
-			mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal,
-			mode->type, mode->flags);
+	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
 
 	ctrl_pol = 0;
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 80aa6344185e..7c8352a8ea97 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -536,14 +536,7 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
 	struct mipi_dsi_host *host = msm_dsi->host;
 	bool is_dual_dsi = IS_DUAL_DSI();
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
-			mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal,
-			mode->type, mode->flags);
+	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
 
 	if (is_dual_dsi && !IS_MASTER_DSI_LINK(id))
 		return;
diff --git a/drivers/gpu/drm/msm/edp/edp_bridge.c b/drivers/gpu/drm/msm/edp/edp_bridge.c
index 931a5c97cccf..153f350ce017 100644
--- a/drivers/gpu/drm/msm/edp/edp_bridge.c
+++ b/drivers/gpu/drm/msm/edp/edp_bridge.c
@@ -60,14 +60,7 @@ static void edp_bridge_mode_set(struct drm_bridge *bridge,
 	struct edp_bridge *edp_bridge = to_edp_bridge(bridge);
 	struct msm_edp *edp = edp_bridge->edp;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
-			mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal,
-			mode->type, mode->flags);
+	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
 
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		if ((connector->encoder != NULL) &&
-- 
2.17.1

