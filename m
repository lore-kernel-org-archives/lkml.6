Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C30C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1910D208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnVHgGjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfAJSNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:13:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39944 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfAJSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:13:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so14416849qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=69z6h0/wP3T3HNMZCBrAO0RT67nqYlaWZqCmS6tVrbc=;
        b=fnVHgGjpjcEeUAen+OSJ++H1VEMbCXFhtCw/hXPW0oocsyspoVPzfB6pfKU5TKFM/y
         W+kSRJiBb1kTMwQjk40a+eOJPgerRD1LXLE34lDWBFRrOdXwCRKAJPteNkTYMcZ7U8Mi
         vfduTZFWT7Mbp4gri3AHCUK8G9P9TAMXrDlXCumSJCjeEgaDF6/ko1B02wSKRKonEePv
         WqEoY9JkSscr2qSWAAVL9fLgez9hn8xjizYRq/3H8W93z3NAeQZYZHwH4FjHHrudjO57
         B9v3Ihazko/PRpj5lMHZ9DB/agX5a5hn82SiqFMSNx4GaQN4NSum5IcDRQ/HnFt8lNE9
         GD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=69z6h0/wP3T3HNMZCBrAO0RT67nqYlaWZqCmS6tVrbc=;
        b=MqowYfZDswmnQe3dvy6acGVl+v1Zcx3JZF/le/N4gkItnMCmxVeLjo84Qfvozw112v
         MaZxCtdgRoTC0+eV1DVAeYNgzV1Z/RQAqQ4E55syyyHeVM6LFIsOnpZxzU3I5OomH4pd
         F7/uL5EsdPemJJuKb73VlxnZadpnxZyN+tF8lZoIhgjHm495eohbWWl/ToDIgZJYgg0V
         h0w8q6jYt1RWvqAL4O7O3KrhYbo1ej3X6iz+HqDJchgZxuRmBcUWkE0Wp1x+Jcx5knAU
         /7b9w7rf2CSCDliljIqNGeKiwGbvse0GrY1qsQvq3LBOo9ozymdoPZlI1q3nrpbiCoJa
         T3fw==
X-Gm-Message-State: AJcUukcq6hf31OzbXG8zjxWC3v05JwX3zr6EekhLLDdp6sbagaIRWdQ/
        C+I2ORao3vRzDBtYJqSQ70g=
X-Google-Smtp-Source: ALg8bN7M8U5TxZWgQ6r4M0BYg5h/MVbgTmdwhWr/udxG2eBGfoKr/bBITl0RcqoSz97X4we4FQkICA==
X-Received: by 2002:a37:ab03:: with SMTP id u3mr10075545qke.24.1547143988525;
        Thu, 10 Jan 2019 10:13:08 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q72sm37504873qki.24.2019.01.10.10.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:13:07 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:13:01 -0200
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
Subject: [PATCH v4 1/3] drm: msm: Cleanup drm_display_mode print str
Message-ID: <3e2dcd38c964061f245b0ae22186c71da06e9742.1547143069.git.shayenneluzmoura@gmail.com>
References: <cover.1547143069.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547143069.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in msm files.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel).
  - Make the commit message more clear

Changes in v3:
  - Resolve typo in v2 patch

Changes in v4:
  - No changes

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
index 6a1ebdace391..48ce218b8463 100644
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
+	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
 
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
index b1da9ce54379..4878b81c96fb 100644
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
+	DBG("%s: set mode: " DRM_MODE_FMT, crtc->name, DRM_MODE_ARG(mode));
 
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

