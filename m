Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F04C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C218921741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVlRNE2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeLTMZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:25:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37905 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbeLTMZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:25:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id p17so1530992qtl.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wc+h2nJ2tmHyTnnvjthkajBu9k0dkenoaGPPG9SbMV8=;
        b=CVlRNE2CsIsC+UTWRH8q6FtDg1YZeSqWjftVIGzuWOeHnZ3NuD3FLrYQM55iQMiqIW
         p3i6slbqKWQ601t8YS4/GWSii35dgh/ySHMcHQuFzeqoK6E/W0Lya5/uec8FWG284uTI
         /li+t63QipIfele5sNXFW72runIOLV5eH5zmsqzimWOCOc8kJcRG8GIReJQdouMNtGNi
         RKE+1QcSdTOT+KiVGaPYQyDwJP9uhWmws1+brnDlRwQXIp8vECW2onMfaHi3lWs9/j+R
         Ibxzwy0ZBRUA5ptzsEi85w/a0wCLPiIgh1jBMMEmGDF0/XVewfcPtqkCA0jstrCZmBnK
         v+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wc+h2nJ2tmHyTnnvjthkajBu9k0dkenoaGPPG9SbMV8=;
        b=NW9fmxk8j4Y97OJTErkBDJy8n1983mYm0SPztXVHmYfwdQPLB6FhWpUbbgncv8pU7J
         VWK46y4+v/76/1N/qPeIavEq5ii5+rMO5MznA0zUg0ahdEN5VioswkwtMAzza4F0M2X5
         2hpBmiRT1r5uMb75ahvcKI4Ed3Oe93OdeXHT94BqsVpeg6ZevemyCq4qyyJb5rnGDcxt
         uTiR6JdxMaEiMYrRbPBodiCmiL3yDp3DmhqA1nMubAZ2mP5GmSnN3PY64ELpAShuiHhb
         MaNZq45gkHWK1xdbVrEi+rYl5+p9fiO+JiFbyzfhHdB2dk+NQZUdR10mxBJK/gYnVMeo
         VNWQ==
X-Gm-Message-State: AA+aEWabg5Y9M4P3e4GLT1Ozd+JepDWw1nBgGR9OM3U9pS5vAEoMepnf
        dFEQYvv0luy9zVMO7kJTSAA=
X-Google-Smtp-Source: AFSGD/U41CR/rUhaCg40jhOXkwa21cpWjpN02twsvykSdtygAWHjOWx9fTnbth4cSMITnRQzG0ET0Q==
X-Received: by 2002:a0c:aca7:: with SMTP id m36mr25079755qvc.237.1545308727467;
        Thu, 20 Dec 2018 04:25:27 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 20sm4471443qtp.54.2018.12.20.04.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:25:27 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:25:21 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] drm: msm: Cleanup drm_display_mode print str
Message-ID: <8a801b11893c519b0b7ebcd7baa5d7de4390f467.1545308167.git.shayenneluzmoura@gmail.com>
References: <cover.1545308167.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545308167.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in msm files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel).
  - Make the commit message more clear

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

