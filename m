Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BBCC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D9D20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bHKufhl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D9D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbeKFTEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:04:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39554 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbeKFTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:04:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so12653279wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8JiROxiO15xoghzW/LXrGRjO7cHBnT3Yw+XkDwFkkJ8=;
        b=bHKufhl8SlBjBKrOXP5/E541PjW9fBJrt0I9o4/aMCkijA5OFRkckv3Jp78iVHTxkr
         KLa8HIbPwtvRX448KLtq8r6VoSDg9jB31nBkooEp4bVu0i2I0g2g99yYNC4mNcmDvdjp
         2Z7YgJFsQNGlJIyoQcHlIMKZWf55JIOD4+DOrCx7a8GRYAzu8dqPg5qrO7Lz+f12VJNL
         sJ+LF0z1hqP6bDg4mmzAAl50hZXSJAQzsMUDFqA0gUB3bBLj/B54dCCB1xljiCCGhWJN
         WqwLeq4G4PFuPzrriqwzUrzQZNKAvcLtrN90iNolaDyVIN2u0+tuH5P0fT57sImeDcx0
         5maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8JiROxiO15xoghzW/LXrGRjO7cHBnT3Yw+XkDwFkkJ8=;
        b=mW9y7rGGaU5jV/YJcCP7xwxymQCo/P0cXW+/nown+j3StzThe03TE9rG1OaEDFrl6H
         MspJGGxf9McwM3l4EX8WXmyR7WEVUbjGN0mZYL3J3NO59rN3IIh7tlBWUegct27Rx5hH
         wiKk+9SPD1ajrMgyR1qJTgwjL11JF+NrpNcSA+qZyuGvsHx6LZQhcmmElUQiMZVJ7RWi
         gFq8vF1DQC0mQIvuml1I4hcF6+mbIQyvMvp0A6KgWJGZv1lTBz+0KU8FS5mlJnXC+NS/
         hYVlubwhgOl8AinVoAdIvmuCvp0Mhv+q37nSDEJ/pjtxi+j9+H5kfZlyi07vcoYxax8c
         PGJg==
X-Gm-Message-State: AGRZ1gLmWJ5rXnnk4sYnnPwayEPYaZxbC5wYERA96HdbrdnTVBn89QTD
        tAtOZRJpzft+StBjDpLdMIVx5g==
X-Google-Smtp-Source: AJdET5d77FDQTi6cvr6ideuhaLeTPQzqUr8Bd1W5ZvsDCx9+2htNFGQwcZH2jKubQlExuRGnQBPzWg==
X-Received: by 2002:adf:80ab:: with SMTP id 40-v6mr5143856wrl.158.1541497208840;
        Tue, 06 Nov 2018 01:40:08 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u13-v6sm29682434wrn.11.2018.11.06.01.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 01:40:08 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/meson: Add primary plane scaling
Date:   Tue,  6 Nov 2018 10:40:02 +0100
Message-Id: <1541497202-20570-4-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
References: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Primary Plane scaling.

On the Amlogic GX SoCs, the primary plane is used as On-Screen-Display
layer on top of video, and it's needed to keep the OSD layer to a lower
size as the physical display size to :
- lower the memory bandwidth
- lower the OSD rendering
- lower the memory usage

This use-case is used when setting the display mode to 3840x2160 and the
OSD layer is rendered using the GPU. In this case, the GXBB & GXL cannot
work on more than 2000x2000 buffer, thus needing the OSD layer to be kept
at 1920x1080 and upscaled to 3840x2160 in hardware.

The primary plane atomic check still allow 1:1 scaling, allowing native
3840x2160 if needed by user-space applications.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_plane.c | 186 +++++++++++++++++++++++++++---------
 1 file changed, 141 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index f915a79..12a47b4 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/bitfield.h>
 #include <linux/platform_device.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
@@ -39,12 +40,50 @@
 #include "meson_canvas.h"
 #include "meson_registers.h"
 
+/* OSD_SCI_WH_M1 */
+#define SCI_WH_M1_W(w)			FIELD_PREP(GENMASK(28, 16), w)
+#define SCI_WH_M1_H(h)			FIELD_PREP(GENMASK(12, 0), h)
+
+/* OSD_SCO_H_START_END */
+/* OSD_SCO_V_START_END */
+#define SCO_HV_START(start)		FIELD_PREP(GENMASK(27, 16), start)
+#define SCO_HV_END(end)			FIELD_PREP(GENMASK(11, 0), end)
+
+/* OSD_SC_CTRL0 */
+#define SC_CTRL0_PATH_EN		BIT(3)
+#define SC_CTRL0_SEL_OSD1		BIT(2)
+
+/* OSD_VSC_CTRL0 */
+#define VSC_BANK_LEN(value)		FIELD_PREP(GENMASK(2, 0), value)
+#define VSC_TOP_INI_RCV_NUM(value)	FIELD_PREP(GENMASK(6, 3), value)
+#define VSC_TOP_RPT_L0_NUM(value)	FIELD_PREP(GENMASK(9, 8), value)
+#define VSC_BOT_INI_RCV_NUM(value)	FIELD_PREP(GENMASK(14, 11), value)
+#define VSC_BOT_RPT_L0_NUM(value)	FIELD_PREP(GENMASK(17, 16), value)
+#define VSC_PROG_INTERLACE		BIT(23)
+#define VSC_VERTICAL_SCALER_EN		BIT(24)
+
+/* OSD_VSC_INI_PHASE */
+#define VSC_INI_PHASE_BOT(bottom)	FIELD_PREP(GENMASK(31, 16), bottom)
+#define VSC_INI_PHASE_TOP(top)		FIELD_PREP(GENMASK(15, 0), top)
+
+/* OSD_HSC_CTRL0 */
+#define HSC_BANK_LENGTH(value)		FIELD_PREP(GENMASK(2, 0), value)
+#define HSC_INI_RCV_NUM0(value)		FIELD_PREP(GENMASK(6, 3), value)
+#define HSC_RPT_P0_NUM0(value)		FIELD_PREP(GENMASK(9, 8), value)
+#define HSC_HORIZ_SCALER_EN		BIT(22)
+
+/* VPP_OSD_VSC_PHASE_STEP */
+/* VPP_OSD_HSC_PHASE_STEP */
+#define SC_PHASE_STEP(value)		FIELD_PREP(GENMASK(27, 0), value)
+
 struct meson_plane {
 	struct drm_plane base;
 	struct meson_drm *priv;
 };
 #define to_meson_plane(x) container_of(x, struct meson_plane, base)
 
+#define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
+
 static int meson_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_plane_state *state)
 {
@@ -57,10 +96,15 @@ static int meson_plane_atomic_check(struct drm_plane *plane,
 	if (IS_ERR(crtc_state))
 		return PTR_ERR(crtc_state);
 
+	/*
+	 * Only allow :
+	 * - Upscaling up to 5x, vertical and horizontal
+	 * - Final coordinates must match crtc size
+	 */
 	return drm_atomic_helper_check_plane_state(state, crtc_state,
+						   FRAC_16_16(1, 5),
 						   DRM_PLANE_HELPER_NO_SCALING,
-						   DRM_PLANE_HELPER_NO_SCALING,
-						   true, true);
+						   false, true);
 }
 
 /* Takes a fixed 16.16 number and converts it to integer. */
@@ -74,22 +118,19 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 {
 	struct meson_plane *meson_plane = to_meson_plane(plane);
 	struct drm_plane_state *state = plane->state;
-	struct drm_framebuffer *fb = state->fb;
+	struct drm_rect dest = drm_plane_state_dest(state);
 	struct meson_drm *priv = meson_plane->priv;
+	struct drm_framebuffer *fb = state->fb;
 	struct drm_gem_cma_object *gem;
-	struct drm_rect src = {
-		.x1 = (state->src_x),
-		.y1 = (state->src_y),
-		.x2 = (state->src_x + state->src_w),
-		.y2 = (state->src_y + state->src_h),
-	};
-	struct drm_rect dest = {
-		.x1 = state->crtc_x,
-		.y1 = state->crtc_y,
-		.x2 = state->crtc_x + state->crtc_w,
-		.y2 = state->crtc_y + state->crtc_h,
-	};
 	unsigned long flags;
+	int vsc_ini_rcv_num, vsc_ini_rpt_p0_num;
+	int vsc_bot_rcv_num, vsc_bot_rpt_p0_num;
+	int hsc_ini_rcv_num, hsc_ini_rpt_p0_num;
+	int hf_phase_step, vf_phase_step;
+	int src_w, src_h, dst_w, dst_h;
+	int bot_ini_phase;
+	int hf_bank_len;
+	int vf_bank_len;
 	u8 canvas_id_osd1;
 
 	/*
@@ -143,6 +184,27 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 		break;
 	};
 
+	/* Default scaler parameters */
+	vsc_bot_rcv_num = 0;
+	vsc_bot_rpt_p0_num = 0;
+	hf_bank_len = 4;
+	vf_bank_len = 4;
+
+	if (state->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE) {
+		vsc_bot_rcv_num = 6;
+		vsc_bot_rpt_p0_num = 2;
+	}
+
+	hsc_ini_rcv_num = hf_bank_len;
+	vsc_ini_rcv_num = vf_bank_len;
+	hsc_ini_rpt_p0_num = (hf_bank_len / 2) - 1;
+	vsc_ini_rpt_p0_num = (vf_bank_len / 2) - 1;
+
+	src_w = fixed16_to_int(state->src_w);
+	src_h = fixed16_to_int(state->src_h);
+	dst_w = state->crtc_w;
+	dst_h = state->crtc_h;
+
 	/*
 	 * When the output is interlaced, the OSD must switch between
 	 * each field using the INTERLACE_SEL_ODD (0) of VIU_OSD1_BLK0_CFG_W0
@@ -151,41 +213,73 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 	 * is configured for 2:1 scaling with interlace options enabled.
 	 */
 	if (state->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE) {
-		priv->viu.osd1_interlace = true;
-
 		dest.y1 /= 2;
 		dest.y2 /= 2;
+		dst_h /= 2;
+	}
 
-		priv->viu.osd_sc_ctrl0 = BIT(3)| /* Enable scaler */
-					 BIT(2); /* Select OSD1 */
+	hf_phase_step = ((src_w << 18) / dst_w) << 6;
+	vf_phase_step = (src_h << 20) / dst_h;
 
-		/* 2:1 scaling */
-		priv->viu.osd_sc_i_wh_m1 = ((drm_rect_width(&dest) - 1) << 16) |
-					   (drm_rect_height(&dest) - 1);
-		priv->viu.osd_sc_o_h_start_end = (dest.x1 << 16) | dest.x2;
-		priv->viu.osd_sc_o_v_start_end = (dest.y1 << 16) | dest.y2;
+	if (state->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE)
+		bot_ini_phase = ((vf_phase_step / 2) >> 4);
+	else
+		bot_ini_phase = 0;
+
+	vf_phase_step = (vf_phase_step << 4);
+
+	/* In interlaced mode, scaler is always active */
+	if (src_h != dst_h || src_w != dst_w) {
+		priv->viu.osd_sc_i_wh_m1 = SCI_WH_M1_W(src_w - 1) |
+					   SCI_WH_M1_H(src_h - 1);
+		priv->viu.osd_sc_o_h_start_end = SCO_HV_START(dest.x1) |
+						 SCO_HV_END(dest.x2 - 1);
+		priv->viu.osd_sc_o_v_start_end = SCO_HV_START(dest.y1) |
+						 SCO_HV_END(dest.y2 - 1);
+		/* Enable OSD Scaler */
+		priv->viu.osd_sc_ctrl0 = SC_CTRL0_PATH_EN | SC_CTRL0_SEL_OSD1;
+	} else {
+		priv->viu.osd_sc_i_wh_m1 = 0;
+		priv->viu.osd_sc_o_h_start_end = 0;
+		priv->viu.osd_sc_o_v_start_end = 0;
+		priv->viu.osd_sc_ctrl0 = 0;
+	}
 
-		/* 2:1 vertical scaling values */
-		priv->viu.osd_sc_v_ini_phase = BIT(16);
-		priv->viu.osd_sc_v_phase_step = BIT(25);
+	/* In interlaced mode, vertical scaler is always active */
+	if (src_h != dst_h) {
 		priv->viu.osd_sc_v_ctrl0 =
-			(4 << 0) | /* osd_vsc_bank_length */
-			(4 << 3) | /* osd_vsc_top_ini_rcv_num0 */
-			(1 << 8) | /* osd_vsc_top_rpt_p0_num0 */
-			(6 << 11) | /* osd_vsc_bot_ini_rcv_num0 */
-			(2 << 16) | /* osd_vsc_bot_rpt_p0_num0 */
-			BIT(23)	| /* osd_prog_interlace */
-			BIT(24); /* Enable vertical scaler */
-
-		/* No horizontal scaling */
+					VSC_BANK_LEN(vf_bank_len) |
+					VSC_TOP_INI_RCV_NUM(vsc_ini_rcv_num) |
+					VSC_TOP_RPT_L0_NUM(vsc_ini_rpt_p0_num) |
+					VSC_VERTICAL_SCALER_EN;
+
+		if (state->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE)
+			priv->viu.osd_sc_v_ctrl0 |=
+					VSC_BOT_INI_RCV_NUM(vsc_bot_rcv_num) |
+					VSC_BOT_RPT_L0_NUM(vsc_bot_rpt_p0_num) |
+					VSC_PROG_INTERLACE;
+
+		priv->viu.osd_sc_v_phase_step = SC_PHASE_STEP(vf_phase_step);
+		priv->viu.osd_sc_v_ini_phase = VSC_INI_PHASE_BOT(bot_ini_phase);
+	} else {
+		priv->viu.osd_sc_v_ctrl0 = 0;
+		priv->viu.osd_sc_v_phase_step = 0;
+		priv->viu.osd_sc_v_ini_phase = 0;
+	}
+
+	/* Horizontal scaler is only used if width does not match */
+	if (src_w != dst_w) {
+		priv->viu.osd_sc_h_ctrl0 =
+					HSC_BANK_LENGTH(hf_bank_len) |
+					HSC_INI_RCV_NUM0(hsc_ini_rcv_num) |
+					HSC_RPT_P0_NUM0(hsc_ini_rpt_p0_num) |
+					HSC_HORIZ_SCALER_EN;
+		priv->viu.osd_sc_h_phase_step = SC_PHASE_STEP(hf_phase_step);
 		priv->viu.osd_sc_h_ini_phase = 0;
-		priv->viu.osd_sc_h_phase_step = 0;
-		priv->viu.osd_sc_h_ctrl0 = 0;
 	} else {
-		priv->viu.osd1_interlace = false;
-		priv->viu.osd_sc_ctrl0 = 0;
 		priv->viu.osd_sc_h_ctrl0 = 0;
-		priv->viu.osd_sc_v_ctrl0 = 0;
+		priv->viu.osd_sc_h_phase_step = 0;
+		priv->viu.osd_sc_h_ini_phase = 0;
 	}
 
 	/*
@@ -193,10 +287,12 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 	 * where x2 is exclusive.
 	 * e.g. +30x1920 would be (1919 << 16) | 30
 	 */
-	priv->viu.osd1_blk0_cfg[1] = ((fixed16_to_int(src.x2) - 1) << 16) |
-					fixed16_to_int(src.x1);
-	priv->viu.osd1_blk0_cfg[2] = ((fixed16_to_int(src.y2) - 1) << 16) |
-					fixed16_to_int(src.y1);
+	priv->viu.osd1_blk0_cfg[1] =
+				((fixed16_to_int(state->src.x2) - 1) << 16) |
+				fixed16_to_int(state->src.x1);
+	priv->viu.osd1_blk0_cfg[2] =
+				((fixed16_to_int(state->src.y2) - 1) << 16) |
+				fixed16_to_int(state->src.y1);
 	priv->viu.osd1_blk0_cfg[3] = ((dest.x2 - 1) << 16) | dest.x1;
 	priv->viu.osd1_blk0_cfg[4] = ((dest.y2 - 1) << 16) | dest.y1;
 
-- 
2.7.4

