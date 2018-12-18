Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CF9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B693D21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsU/TKgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeLRNiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:38:12 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:40403 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:38:12 -0500
Received: by mail-qk1-f179.google.com with SMTP id y16so9458571qki.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eViXAmmD7+WR08OUX7WaphSgrXoemWdtBQ/hmShVUx8=;
        b=qsU/TKggt+bCXBpxSPKFkVE1mtFX25IzLHydOKPi1mRmFwoH/1fr1zeLiXVgGXaoOb
         EwxGfNyDZW6uGRld6iAxsc3HcQmy/aC/xRdFvnCWl2V2xJgyIcQqeGaRu3PN0b1Gq1uC
         msjIScEyLM3xDF+RWz2y56LjFYBTXDZ6BFGJUB9UlxoPLkAl1NdsW2iHlxQn+9D+cIUY
         fPPw3Y9OOlQ/zJ4wXZSQl7yennlOyfrLRq2k7zzOlIaxK/gSbli2doJmNfTTlY7FxRCd
         MVozyinzChpesgAQ0HOhmt6AuqcAguIfFxEbSfHZvC+A/ZiEoq1kv+qOjgKJz2uCWUI3
         Ux5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eViXAmmD7+WR08OUX7WaphSgrXoemWdtBQ/hmShVUx8=;
        b=tsSpiwQcGpPxDqDilklJ826AmG0Hd/eVrLPL4mOkIp4Q1pdveDqTZwrwMYV5Ys1UXB
         IXXW9zbvqhNaYE1oqIJS7DliF+DwVbp7+iHcwmW0qdNoPkZMSv1WfGiUZeBO2kDhYMVW
         9oqeH13rI1UK52DaHm8WGOyLuguIkHhmuFzfOTM8wl8tyCksoIHvFAalSZ36ouPGzei0
         Ce5wAch72EdxGJNRnTaAm8tr9TuFZryPALX/29u56tecBo+HbIIo/lkWml9zBTf1JOVy
         8Ol81hwidR7YTcMg/Vgy57paRjpVlbqxFTf//4mlt8n0DGViBzZdBosaD9RdrBuCYXr0
         QxEw==
X-Gm-Message-State: AA+aEWbRIeQzD67ChR9TL3fK1+KgBZvBp/F01l6l7DYJ4WvtR83HotKX
        7Kq1kZR4e6LFPIeOqO5Y6U8=
X-Google-Smtp-Source: AFSGD/Vm2w1ndh3X3gvguhAU/3PYGiEkNyn0HK0HyoEPIu/Hy/kiVkHSGG4lHoMVclUHPq5ZmcaYAQ==
X-Received: by 2002:a37:27d2:: with SMTP id n201mr15799964qkn.63.1545140288041;
        Tue, 18 Dec 2018 05:38:08 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 126sm7895162qkj.70.2018.12.18.05.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:38:07 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:38:03 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] drm: msm: Delete base.id prints
Message-ID: <20181218133803.hfp62heugg4eeqcx@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes base.id prints from drm_display_mode
objects in msm files. It removes dependency from drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         | 4 ++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  | 4 ++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  | 4 ++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 4 ++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  | 4 ++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         | 4 ++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c      | 4 ++--
 drivers/gpu/drm/msm/dsi/dsi_manager.c             | 4 ++--
 drivers/gpu/drm/msm/edp/edp_bridge.c              | 4 ++--
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
index 457c29dba4a1..4d35fe5b8c07 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
@@ -244,8 +244,8 @@ static void mdp4_crtc_mode_set_nofb(struct drm_crtc *crtc)
 
 	mode = &crtc->state->adjusted_mode;
 
-	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mdp4_crtc->name, mode->base.id, mode->name,
+	DBG("%s: set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			mdp4_crtc->name, mode->name,
 			mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
index 6a1ebdace391..a12ad73f08c7 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
@@ -58,8 +58,8 @@ static void mdp4_dsi_encoder_mode_set(struct drm_encoder *encoder,
 
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
+	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			mode->name,
 			mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
index ba8e587f734b..3ace21e116a0 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
@@ -104,8 +104,8 @@ static void mdp4_dtv_encoder_mode_set(struct drm_encoder *encoder,
 
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
+	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			mode->name,
 			mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index 2bfb39082f54..21be7640d3a8 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -273,8 +273,8 @@ static void mdp4_lcdc_encoder_mode_set(struct drm_encoder *encoder,
 
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
+	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			mode->name,
 			mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
index d6f79dc755b4..ac61a10b79cc 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
@@ -134,8 +134,8 @@ void mdp5_cmd_encoder_mode_set(struct drm_encoder *encoder,
 {
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
+	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			mode->name,
 			mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index b1da9ce54379..ef2ee5888777 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -384,8 +384,8 @@ static void mdp5_crtc_mode_set_nofb(struct drm_crtc *crtc)
 
 	mode = &crtc->state->adjusted_mode;
 
-	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			crtc->name, mode->base.id, mode->name,
+	DBG("%s: set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			crtc->name, mode->name,
 			mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
index fcd44d1d1068..b5e4ef236589 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
@@ -118,8 +118,8 @@ static void mdp5_vid_encoder_mode_set(struct drm_encoder *encoder,
 
 	mode = adjusted_mode;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
+	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			mode->name,
 			mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 80aa6344185e..e72ba60f4db8 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -536,8 +536,8 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
 	struct mipi_dsi_host *host = msm_dsi->host;
 	bool is_dual_dsi = IS_DUAL_DSI();
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
+	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			mode->name,
 			mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
diff --git a/drivers/gpu/drm/msm/edp/edp_bridge.c b/drivers/gpu/drm/msm/edp/edp_bridge.c
index 931a5c97cccf..160e8d91eda2 100644
--- a/drivers/gpu/drm/msm/edp/edp_bridge.c
+++ b/drivers/gpu/drm/msm/edp/edp_bridge.c
@@ -60,8 +60,8 @@ static void edp_bridge_mode_set(struct drm_bridge *bridge,
 	struct edp_bridge *edp_bridge = to_edp_bridge(bridge);
 	struct msm_edp *edp = edp_bridge->edp;
 
-	DBG("set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-			mode->base.id, mode->name,
+	DBG("set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			mode->name,
 			mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
-- 
2.17.1

