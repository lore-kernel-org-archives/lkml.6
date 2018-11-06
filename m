Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E86CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F8520869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jig0AcOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F8520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbeKFTEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:04:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45349 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbeKFTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:04:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id k15-v6so9686441wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YMPZQne4wUan7df4g8gFxVwUrGV9bfUR3u22/xGaIzs=;
        b=jig0AcORLDHNX//PV/6pIZypy01PeaqMqM/OdUgmpbx3dalzH6Emzs+kJt88bJ8Lhi
         A6dOYJidT7tf3EtVexmK/VfzAP1ww+FsIhtImyd4+T/s6WD4Aph5uFjyrg1tMr0JNrbo
         5/y74PnFoSjDD4m8Giy1iQfHKbimhzTcbvYNCC4l8sIQlb4UoJmJVcX0v8ct7PCePGKh
         wAVuyztT+/RXrC1axHDAZNu/4M3/SVMaPh5jm+VrKlLskjIX615gaUdSsCfDjmLav0Wu
         aN+RqtCS3OTM9tdFq5nhMnlCCQGBufgC++RVbatITqJZbMZ8bWV+pUjGOx/NrAxrsqW8
         UrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YMPZQne4wUan7df4g8gFxVwUrGV9bfUR3u22/xGaIzs=;
        b=jnYDlAUQUKCpNK8PMS2JFJ2VdTN4Wf8L0hXcfBjHmLRTNyP4/sR2YqirCz91FD+gDo
         sHc8TOHSzXWyYlZj2CX731zO22AFZo8bWda10PH5AfIxd9uB6jvg951PLG7Xmj+ibhbk
         77lOY2hGlGnjJxbCmU1OwzR1r0BPIQBpbrwpJ1OxhEgfOgoLBLgXf0J1aSGuu2GeWtex
         H7sp1JBiL9QTS4M7B2e69zZVN7hPzjvIUwUy/03c8zIHzd+PEBG0v3n3O4kUDzzZ1ekD
         rHS1LinfsfPxZKVGRxpLWAKt9d04rTjxjQkHVBolhQKK3V+HbMjepvhNIibeW1FunAcj
         kzng==
X-Gm-Message-State: AGRZ1gJz2hLlTL1lZQUceuK2ypG89wGAqsnv9ngh1IWPW6BUrGgQTO2X
        GNBL6ulY1PizzTnvNKI7DdQH5w==
X-Google-Smtp-Source: AJdET5dZxww1M2Jo2Xzo6VIk0mlrVfd1dm59JUFo/Syhy0ZuKfTjZSjzgbeJklKtw4NQ6D7tKaht6w==
X-Received: by 2002:adf:c752:: with SMTP id b18-v6mr20580131wrh.197.1541497207668;
        Tue, 06 Nov 2018 01:40:07 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u13-v6sm29682434wrn.11.2018.11.06.01.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 01:40:07 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/meson: move OSD scaler management into plane atomic update
Date:   Tue,  6 Nov 2018 10:40:01 +0100
Message-Id: <1541497202-20570-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
References: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support the Primary Plane scaling, move the basic
OSD Interlace-Only scaler setup code into the primary plane atomic
update callback and handle the vsync scaler update like the overlay
plane scaling registers update.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c  | 35 ++++++++++++++++------------
 drivers/gpu/drm/meson/meson_drv.h   | 10 ++++++++
 drivers/gpu/drm/meson/meson_plane.c | 39 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_vpp.c   | 46 -------------------------------------
 4 files changed, 68 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 38686c9..d78168f 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -189,21 +189,26 @@ void meson_crtc_irq(struct meson_drm *priv)
 				priv->io_base + _REG(VIU_OSD1_BLK0_CFG_W3));
 		writel_relaxed(priv->viu.osd1_blk0_cfg[4],
 				priv->io_base + _REG(VIU_OSD1_BLK0_CFG_W4));
-
-		/* If output is interlace, make use of the Scaler */
-		if (priv->viu.osd1_interlace) {
-			struct drm_plane *plane = priv->primary_plane;
-			struct drm_plane_state *state = plane->state;
-			struct drm_rect dest = {
-				.x1 = state->crtc_x,
-				.y1 = state->crtc_y,
-				.x2 = state->crtc_x + state->crtc_w,
-				.y2 = state->crtc_y + state->crtc_h,
-			};
-
-			meson_vpp_setup_interlace_vscaler_osd1(priv, &dest);
-		} else
-			meson_vpp_disable_interlace_vscaler_osd1(priv);
+		writel_relaxed(priv->viu.osd_sc_ctrl0,
+				priv->io_base + _REG(VPP_OSD_SC_CTRL0));
+		writel_relaxed(priv->viu.osd_sc_i_wh_m1,
+				priv->io_base + _REG(VPP_OSD_SCI_WH_M1));
+		writel_relaxed(priv->viu.osd_sc_o_h_start_end,
+				priv->io_base + _REG(VPP_OSD_SCO_H_START_END));
+		writel_relaxed(priv->viu.osd_sc_o_v_start_end,
+				priv->io_base + _REG(VPP_OSD_SCO_V_START_END));
+		writel_relaxed(priv->viu.osd_sc_v_ini_phase,
+				priv->io_base + _REG(VPP_OSD_VSC_INI_PHASE));
+		writel_relaxed(priv->viu.osd_sc_v_phase_step,
+				priv->io_base + _REG(VPP_OSD_VSC_PHASE_STEP));
+		writel_relaxed(priv->viu.osd_sc_h_ini_phase,
+				priv->io_base + _REG(VPP_OSD_HSC_INI_PHASE));
+		writel_relaxed(priv->viu.osd_sc_h_phase_step,
+				priv->io_base + _REG(VPP_OSD_HSC_PHASE_STEP));
+		writel_relaxed(priv->viu.osd_sc_h_ctrl0,
+				priv->io_base + _REG(VPP_OSD_HSC_CTRL0));
+		writel_relaxed(priv->viu.osd_sc_v_ctrl0,
+				priv->io_base + _REG(VPP_OSD_VSC_CTRL0));
 
 		if (priv->canvas)
 			meson_canvas_config(priv->canvas, priv->canvas_id_osd1,
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index c971557..a955354 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -54,6 +54,16 @@ struct meson_drm {
 		uint32_t osd1_addr;
 		uint32_t osd1_stride;
 		uint32_t osd1_height;
+		uint32_t osd_sc_ctrl0;
+		uint32_t osd_sc_i_wh_m1;
+		uint32_t osd_sc_o_h_start_end;
+		uint32_t osd_sc_o_v_start_end;
+		uint32_t osd_sc_v_ini_phase;
+		uint32_t osd_sc_v_phase_step;
+		uint32_t osd_sc_h_ini_phase;
+		uint32_t osd_sc_h_phase_step;
+		uint32_t osd_sc_h_ctrl0;
+		uint32_t osd_sc_v_ctrl0;
 
 		bool vd1_enabled;
 		bool vd1_commit;
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 51bec8e..f915a79 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -143,13 +143,50 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 		break;
 	};
 
+	/*
+	 * When the output is interlaced, the OSD must switch between
+	 * each field using the INTERLACE_SEL_ODD (0) of VIU_OSD1_BLK0_CFG_W0
+	 * at each vsync.
+	 * But the vertical scaler can provide such funtionnality if
+	 * is configured for 2:1 scaling with interlace options enabled.
+	 */
 	if (state->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE) {
 		priv->viu.osd1_interlace = true;
 
 		dest.y1 /= 2;
 		dest.y2 /= 2;
-	} else
+
+		priv->viu.osd_sc_ctrl0 = BIT(3) | /* Enable scaler */
+					 BIT(2); /* Select OSD1 */
+
+		/* 2:1 scaling */
+		priv->viu.osd_sc_i_wh_m1 = ((drm_rect_width(&dest) - 1) << 16) |
+					   (drm_rect_height(&dest) - 1);
+		priv->viu.osd_sc_o_h_start_end = (dest.x1 << 16) | dest.x2;
+		priv->viu.osd_sc_o_v_start_end = (dest.y1 << 16) | dest.y2;
+
+		/* 2:1 vertical scaling values */
+		priv->viu.osd_sc_v_ini_phase = BIT(16);
+		priv->viu.osd_sc_v_phase_step = BIT(25);
+		priv->viu.osd_sc_v_ctrl0 =
+			(4 << 0) | /* osd_vsc_bank_length */
+			(4 << 3) | /* osd_vsc_top_ini_rcv_num0 */
+			(1 << 8) | /* osd_vsc_top_rpt_p0_num0 */
+			(6 << 11) | /* osd_vsc_bot_ini_rcv_num0 */
+			(2 << 16) | /* osd_vsc_bot_rpt_p0_num0 */
+			BIT(23)	| /* osd_prog_interlace */
+			BIT(24); /* Enable vertical scaler */
+
+		/* No horizontal scaling */
+		priv->viu.osd_sc_h_ini_phase = 0;
+		priv->viu.osd_sc_h_phase_step = 0;
+		priv->viu.osd_sc_h_ctrl0 = 0;
+	} else {
 		priv->viu.osd1_interlace = false;
+		priv->viu.osd_sc_ctrl0 = 0;
+		priv->viu.osd_sc_h_ctrl0 = 0;
+		priv->viu.osd_sc_v_ctrl0 = 0;
+	}
 
 	/*
 	 * The format of these registers is (x2 << 16 | x1),
diff --git a/drivers/gpu/drm/meson/meson_vpp.c b/drivers/gpu/drm/meson/meson_vpp.c
index 5dc24a9..f9efb43 100644
--- a/drivers/gpu/drm/meson/meson_vpp.c
+++ b/drivers/gpu/drm/meson/meson_vpp.c
@@ -51,52 +51,6 @@ void meson_vpp_setup_mux(struct meson_drm *priv, unsigned int mux)
 	writel(mux, priv->io_base + _REG(VPU_VIU_VENC_MUX_CTRL));
 }
 
-/*
- * When the output is interlaced, the OSD must switch between
- * each field using the INTERLACE_SEL_ODD (0) of VIU_OSD1_BLK0_CFG_W0
- * at each vsync.
- * But the vertical scaler can provide such funtionnality if
- * is configured for 2:1 scaling with interlace options enabled.
- */
-void meson_vpp_setup_interlace_vscaler_osd1(struct meson_drm *priv,
-					    struct drm_rect *input)
-{
-	writel_relaxed(BIT(3) /* Enable scaler */ |
-		       BIT(2), /* Select OSD1 */
-			priv->io_base + _REG(VPP_OSD_SC_CTRL0));
-
-	writel_relaxed(((drm_rect_width(input) - 1) << 16) |
-		       (drm_rect_height(input) - 1),
-			priv->io_base + _REG(VPP_OSD_SCI_WH_M1));
-	/* 2:1 scaling */
-	writel_relaxed(((input->x1) << 16) | (input->x2),
-			priv->io_base + _REG(VPP_OSD_SCO_H_START_END));
-	writel_relaxed(((input->y1 >> 1) << 16) | (input->y2 >> 1),
-			priv->io_base + _REG(VPP_OSD_SCO_V_START_END));
-
-	/* 2:1 scaling values */
-	writel_relaxed(BIT(16), priv->io_base + _REG(VPP_OSD_VSC_INI_PHASE));
-	writel_relaxed(BIT(25), priv->io_base + _REG(VPP_OSD_VSC_PHASE_STEP));
-
-	writel_relaxed(0, priv->io_base + _REG(VPP_OSD_HSC_CTRL0));
-
-	writel_relaxed((4 << 0) /* osd_vsc_bank_length */ |
-		       (4 << 3) /* osd_vsc_top_ini_rcv_num0 */ |
-		       (1 << 8) /* osd_vsc_top_rpt_p0_num0 */ |
-		       (6 << 11) /* osd_vsc_bot_ini_rcv_num0 */ |
-		       (2 << 16) /* osd_vsc_bot_rpt_p0_num0 */ |
-		       BIT(23)	/* osd_prog_interlace */ |
-		       BIT(24), /* Enable vertical scaler */
-			priv->io_base + _REG(VPP_OSD_VSC_CTRL0));
-}
-
-void meson_vpp_disable_interlace_vscaler_osd1(struct meson_drm *priv)
-{
-	writel_relaxed(0, priv->io_base + _REG(VPP_OSD_SC_CTRL0));
-	writel_relaxed(0, priv->io_base + _REG(VPP_OSD_VSC_CTRL0));
-	writel_relaxed(0, priv->io_base + _REG(VPP_OSD_HSC_CTRL0));
-}
-
 static unsigned int vpp_filter_coefs_4point_bspline[] = {
 	0x15561500, 0x14561600, 0x13561700, 0x12561800,
 	0x11551a00, 0x11541b00, 0x10541c00, 0x0f541d00,
-- 
2.7.4

