Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3320FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CAF24103
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rken8yL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CAF24103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936318AbeF2MQm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:16:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54731 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936299AbeF2MQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:16:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so1961150wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7ywq7Li4rz2xS97BOyR0+k4S0rtmWRInBNEi+PCo0KY=;
        b=rken8yL5g76lXers2XSozWXRPgFBLG2BCOFVS2TmjNZjsgbInD9oZlQg6vAmZtGTSE
         8dzCHpPmMcQVN2Q2mqan0biAvJBiwBEWwHCkWn6imRR79LO4oMpN73Tnq4uKOoLge6/H
         /IgzWHzE07mh2HOP27kJ8CVwyd0j9wU+dBqqK8kDpI1a3F1eYUTK8o+6Newb3l0O1ksT
         fSPATZbu0FpQiFThRPcqSESRlRSP5S40tKuYt5EsZLaWe8IEC6IgqlQ4ls05bAbOEI/c
         Nt0OjjvIHx8itjxTpI/V6Hif12xbdvNX0fHBJa3xf7UzL4vmdIEwC8fhOfIuF0QgW/Tb
         YKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ywq7Li4rz2xS97BOyR0+k4S0rtmWRInBNEi+PCo0KY=;
        b=eE5Jruw+Vgf6Px1dLrPauh8Ao8vY1D1VkGaXZqVZR4zD9vr+rI2Tisx7Opp1c1Mdv/
         /DMRT1b1yoqeQKWBo1Y6AaoTqWxumhWlOagvPAPTbuAX40bWXW/CXN2vajA+rOqxL/Z1
         UsOBLIYW8soRDRF15LPnFpUsP03HoYHsQ63E8dKP+ZonsulTDw1QtpU63U6ZOSsm/AtP
         8xWIg0k2s+V/1Ky8+5cgFQszJTtjmC4qMB0D8YUs0J9J020TD9yoUz54xsMWKaGZ4hMV
         OCqPzl5HoYdDav+2NI/oCY12fclbDzbUutOvvRODtB0EFwxsnUrwrf16LtEQH6YHKc1k
         6Fig==
X-Gm-Message-State: APt69E0Ztvnp/rvH/CjETZxd4CvvrQHK//cjZR1MeFmc+9oyHwKl0Otx
        YjO+4x5NpgcCy1kMpdH8EG2c0A==
X-Google-Smtp-Source: AAOMgpe5P3ZD/8wLLCEjlVQQUyQ0IWq7FeC4gaEXN+Jxmute+FpERGoTq97Pk0zHCri4zhdQsm5GjA==
X-Received: by 2002:a1c:647:: with SMTP id 68-v6mr1714449wmg.82.1530274595050;
        Fri, 29 Jun 2018 05:16:35 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 13-v6sm2456868wmi.2.2018.06.29.05.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 05:16:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: Make DMT timings parameters and pixel clock generic
Date:   Fri, 29 Jun 2018 14:16:32 +0200
Message-Id: <1530274592-18013-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the modes timings tables for DMT modes and calculate the HW
paremeters from the modes timings.

Switch the DMT modes pixel clock calculation out of the static frequency
list to a generic calculation from a range of possible PLL dividers.

This setup permits setting non-CEA modes like :
- 1600x900-60Hz
- 1280x1024-75Hz
- 1280x1024-60Hz
- 1440x900-60Hz
- 1366x768-60Hz
- 1280x800-60Hz
- 1152x864-75Hz
- 1024x768-75Hz
- 1024x768-70Hz
- 1024x768-60Hz
- 832x624-75Hz
- 800x600-75Hz
- 800x600-72Hz
- 800x600-60Hz
- 640x480-75Hz
- 640x480-73Hz
- 640x480-67Hz

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c |  22 +-
 drivers/gpu/drm/meson/meson_vclk.c    | 672 +++++++++++++++-------------------
 drivers/gpu/drm/meson/meson_vclk.h    |   4 +
 drivers/gpu/drm/meson/meson_venc.c    | 377 +++----------------
 drivers/gpu/drm/meson/meson_venc.h    |   3 +-
 5 files changed, 358 insertions(+), 720 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index c9ad456..df7247c 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -329,6 +329,12 @@ static void dw_hdmi_set_vclk(struct meson_dw_hdmi *dw_hdmi,
 
 	vclk_freq = mode->clock;
 
+	if (!vic) {
+		meson_vclk_setup(priv, MESON_VCLK_TARGET_DMT, vclk_freq,
+				 vclk_freq, vclk_freq, false);
+		return;
+	}
+
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		vclk_freq *= 2;
 
@@ -542,10 +548,12 @@ static enum drm_mode_status
 dw_hdmi_mode_valid(struct drm_connector *connector,
 		   const struct drm_display_mode *mode)
 {
+	struct meson_drm *priv = connector->dev->dev_private;
 	unsigned int vclk_freq;
 	unsigned int venc_freq;
 	unsigned int hdmi_freq;
 	int vic = drm_match_cea_mode(mode);
+	enum drm_mode_status status;
 
 	DRM_DEBUG_DRIVER("Modeline %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
 		mode->base.id, mode->name, mode->vrefresh, mode->clock,
@@ -556,8 +564,11 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 
 	/* Check against non-VIC supported modes */
 	if (!vic) {
-		if (!meson_venc_hdmi_supported_mode(mode))
-			return MODE_BAD;
+		status = meson_venc_hdmi_supported_mode(mode);
+		if (status != MODE_OK)
+			return status;
+
+		return meson_vclk_dmt_supported_freq(priv, mode->clock);
 	/* Check against supported VIC modes */
 	} else if (!meson_venc_hdmi_supported_vic(vic))
 		return MODE_BAD;
@@ -583,16 +594,11 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 	dev_dbg(connector->dev->dev, "%s: vclk:%d venc=%d hdmi=%d\n", __func__,
 		vclk_freq, venc_freq, hdmi_freq);
 
-	/* Finally filter by configurable vclk frequencies */
+	/* Finally filter by configurable vclk frequencies for VIC modes */
 	switch (vclk_freq) {
-	case 25175:
-	case 40000:
 	case 54000:
-	case 65000:
 	case 74250:
-	case 108000:
 	case 148500:
-	case 162000:
 	case 297000:
 	case 594000:
 		return MODE_OK;
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index f051122..0b17788 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -320,32 +320,23 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
 				CTS_VDAC_EN, CTS_VDAC_EN);
 }
 
-
+enum {
 /* PLL	O1 O2 O3 VP DV     EN TX */
 /* 4320 /4 /4 /1 /5 /1  => /2 /2 */
-#define MESON_VCLK_HDMI_ENCI_54000	1
+	MESON_VCLK_HDMI_ENCI_54000 = 1,
 /* 4320 /4 /4 /1 /5 /1  => /1 /2 */
-#define MESON_VCLK_HDMI_DDR_54000	2
+	MESON_VCLK_HDMI_DDR_54000,
 /* 2970 /4 /1 /1 /5 /1  => /1 /2 */
-#define MESON_VCLK_HDMI_DDR_148500	3
-/* 4028 /4 /4 /1 /5 /2  => /1 /1 */
-#define MESON_VCLK_HDMI_25175		4
-/* 3200 /4 /2 /1 /5 /2  => /1 /1 */
-#define MESON_VCLK_HDMI_40000		5
-/* 5200 /4 /2 /1 /5 /2  => /1 /1 */
-#define MESON_VCLK_HDMI_65000		6
+	MESON_VCLK_HDMI_DDR_148500,
 /* 2970 /2 /2 /2 /5 /1  => /1 /1 */
-#define MESON_VCLK_HDMI_74250		7
-/* 4320 /4 /1 /1 /5 /2  => /1 /1 */
-#define MESON_VCLK_HDMI_108000		8
+	MESON_VCLK_HDMI_74250,
 /* 2970 /1 /2 /2 /5 /1  => /1 /1 */
-#define MESON_VCLK_HDMI_148500		9
-/* 3240 /2 /1 /1 /5 /2  => /1 /1 */
-#define MESON_VCLK_HDMI_162000		10
+	MESON_VCLK_HDMI_148500,
 /* 2970 /1 /1 /1 /5 /2  => /1 /1 */
-#define MESON_VCLK_HDMI_297000		11
+	MESON_VCLK_HDMI_297000,
 /* 5940 /1 /1 /2 /5 /1  => /1 /1 */
-#define MESON_VCLK_HDMI_594000		12
+	MESON_VCLK_HDMI_594000
+};
 
 struct meson_vclk_params {
 	unsigned int pll_base_freq;
@@ -411,46 +402,6 @@ struct meson_vclk_params {
 		.vid_pll_div = VID_PLL_DIV_5,
 		.vclk_div = 1,
 	},
-	[MESON_VCLK_HDMI_25175] = {
-		.pll_base_freq = 4028000,
-		.pll_od1 = 4,
-		.pll_od2 = 4,
-		.pll_od3 = 1,
-		.vid_pll_div = VID_PLL_DIV_5,
-		.vclk_div = 2,
-	},
-	[MESON_VCLK_HDMI_40000] = {
-		.pll_base_freq = 3200000,
-		.pll_od1 = 4,
-		.pll_od2 = 2,
-		.pll_od3 = 1,
-		.vid_pll_div = VID_PLL_DIV_5,
-		.vclk_div = 2,
-	},
-	[MESON_VCLK_HDMI_65000] = {
-		.pll_base_freq = 5200000,
-		.pll_od1 = 4,
-		.pll_od2 = 2,
-		.pll_od3 = 1,
-		.vid_pll_div = VID_PLL_DIV_5,
-		.vclk_div = 2,
-	},
-	[MESON_VCLK_HDMI_108000] = {
-		.pll_base_freq = 4320000,
-		.pll_od1 = 4,
-		.pll_od2 = 1,
-		.pll_od3 = 1,
-		.vid_pll_div = VID_PLL_DIV_5,
-		.vclk_div = 2,
-	},
-	[MESON_VCLK_HDMI_162000] = {
-		.pll_base_freq = 3240000,
-		.pll_od1 = 2,
-		.pll_od2 = 1,
-		.pll_od3 = 1,
-		.vid_pll_div = VID_PLL_DIV_5,
-		.vclk_div = 2,
-	},
 };
 
 static inline unsigned int pll_od_to_reg(unsigned int od)
@@ -470,358 +421,217 @@ static inline unsigned int pll_od_to_reg(unsigned int od)
 	return 0;
 }
 
-void meson_hdmi_pll_set(struct meson_drm *priv,
-			unsigned int base,
-			unsigned int od1,
-			unsigned int od2,
-			unsigned int od3)
+void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
+			       unsigned int frac, unsigned int od1,
+			       unsigned int od2, unsigned int od3)
 {
 	unsigned int val;
 
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
-		switch (base) {
-		case 2970000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x5800023d);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00000000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x0d5c5091);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x801da72c);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x58000200 | m);
+		if (frac)
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2,
+				     0x00004000 | frac);
+		else
+			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2,
+				     0x00000000);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x0d5c5091);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x801da72c);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
 
-			/* Enable and unreset */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-						0x7 << 28, 0x4 << 28);
+		/* Enable and unreset */
+		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
+				0x7 << 28, 0x4 << 28);
 
-			/* Poll for lock bit */
-			regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
-					val, (val & HDMI_PLL_LOCK), 10, 0);
-
-			/* div_frac */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
-						0xFFFF,  0x4e00);
-			break;
-
-		case 3200000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x58000242);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00000000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x0d5c5091);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x801da72c);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
-
-			/* unreset */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-						BIT(28), 0);
-
-			/* Poll for lock bit */
-			regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
-					val, (val & HDMI_PLL_LOCK), 10, 0);
-
-			/* div_frac */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
-						0xFFFF,  0x4aab);
-			break;
-
-		case 3240000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x58000243);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00000000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x0d5c5091);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x801da72c);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
-
-			/* unreset */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-						BIT(28), 0);
-
-			/* Poll for lock bit */
-			regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
-					val, (val & HDMI_PLL_LOCK), 10, 0);
-
-			/* div_frac */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
-						0xFFFF,  0x4800);
-			break;
-
-		case 3865000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x58000250);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00000000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x0d5c5091);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x801da72c);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
-
-			/* unreset */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-						BIT(28), 0);
-
-			/* Poll for lock bit */
-			regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
-					val, (val & HDMI_PLL_LOCK), 10, 0);
-
-			/* div_frac */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
-						0xFFFF,  0x4855);
-			break;
-
-		case 4028000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x58000253);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00000000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x0d5c5091);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x801da72c);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
-
-			/* unreset */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-						BIT(28), 0);
-
-			/* Poll for lock bit */
-			regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
-					val, (val & HDMI_PLL_LOCK), 10, 0);
-
-			/* div_frac */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
-						0xFFFF,  0x4eab);
-			break;
-
-		case 4320000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x5800025a);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00000000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x0d5c5091);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x801da72c);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
-
-			/* unreset */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-						BIT(28), 0);
-
-			/* Poll for lock bit */
-			regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
-					val, (val & HDMI_PLL_LOCK), 10, 0);
-			break;
-
-		case 5940000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x5800027b);
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
-						0xFFFF,  0x4c00);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x135c5091);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x801da72c);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
-
-			/* unreset */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-						BIT(28), 0);
-
-			/* Poll for lock bit */
-			regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
-					val, (val & HDMI_PLL_LOCK), 10, 0);
-			break;
-
-		case 5200000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x5800026c);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00000000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x135c5091);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x801da72c);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
-
-			/* unreset */
-			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-						BIT(28), 0);
-
-			/* Poll for lock bit */
-			regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
-					val, (val & HDMI_PLL_LOCK), 10, 0);
-			break;
-		};
+		/* Poll for lock bit */
+		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
+				val, (val & HDMI_PLL_LOCK), 10, 0);
 	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
-		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
-		switch (base) {
-		case 2970000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x4000027b);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb300);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0c8e0000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x001fa729);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x01a31500);
-			break;
-
-		case 3200000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x40000285);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb155);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0c8e0000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x001fa729);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x01a31500);
-			break;
-
-		case 3240000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x40000287);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0c8e0000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x001fa729);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x01a31500);
-			break;
-
-		case 3865000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x400002a1);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb02b);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0c8e0000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x001fa729);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x01a31500);
-			break;
-
-		case 4028000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x400002a7);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb355);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0c8e0000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x001fa729);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x01a31500);
-			break;
-
-		case 4320000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x400002b4);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0c8e0000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x001fa729);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x01a31500);
-			break;
-
-		case 5940000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x400002f7);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb200);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0c8e0000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x001fa729);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x01a31500);
-			break;
-
-		case 5200000:
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x400002d8);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb2ab);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0c8e0000);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x001fa729);
-			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x01a31500);
-			break;
-
-		};
+			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x40000200 | m);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x800cb000 | frac);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x860f30c4);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0c8e0000);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x001fa729);
+		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x01a31500);
 
 		/* Reset PLL */
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-					HDMI_PLL_RESET, HDMI_PLL_RESET);
+				HDMI_PLL_RESET, HDMI_PLL_RESET);
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-					HDMI_PLL_RESET, 0);
+				HDMI_PLL_RESET, 0);
 
 		/* Poll for lock bit */
 		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
 				(val & HDMI_PLL_LOCK), 10, 0);
-	};
+	}
 
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
-				   3 << 16, pll_od_to_reg(od1) << 16);
+				3 << 16, pll_od_to_reg(od1) << 16);
 	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
-		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
+			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
-				   3 << 21, pll_od_to_reg(od1) << 21);
+				3 << 21, pll_od_to_reg(od1) << 21);
 
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
-				   3 << 22, pll_od_to_reg(od2) << 22);
+				3 << 22, pll_od_to_reg(od2) << 22);
 	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
-		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
+			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
-				   3 << 23, pll_od_to_reg(od2) << 23);
+				3 << 23, pll_od_to_reg(od2) << 23);
 
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
-				   3 << 18, pll_od_to_reg(od3) << 18);
+				3 << 18, pll_od_to_reg(od3) << 18);
 	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
-		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
+			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
-				   3 << 19, pll_od_to_reg(od3) << 19);
+				3 << 19, pll_od_to_reg(od3) << 19);
+
 }
 
-void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
-		      unsigned int vclk_freq, unsigned int venc_freq,
-		      unsigned int dac_freq, bool hdmi_use_enci)
+#define XTAL_FREQ 24000
+
+static unsigned int meson_hdmi_pll_get_m(struct meson_drm *priv,
+					 unsigned int pll_freq)
 {
-	unsigned int freq;
-	unsigned int hdmi_tx_div;
-	unsigned int venc_div;
+	/* The GXBB PLL has a /2 pre-multiplier */
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
+		pll_freq /= 2;
+
+	return pll_freq / XTAL_FREQ;
+}
+
+#define HDMI_FRAC_MAX_GXBB	4096
+#define HDMI_FRAC_MAX_GXL	1024
+
+static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
+					    unsigned int m,
+					    unsigned int pll_freq)
+{
+	unsigned int parent_freq = XTAL_FREQ;
+	unsigned int frac_max = HDMI_FRAC_MAX_GXL;
+	unsigned int frac_m;
+	unsigned int frac;
+
+	/* The GXBB PLL has a /2 pre-multiplier and a larger FRAC width */
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
+		frac_max = HDMI_FRAC_MAX_GXBB;
+		parent_freq *= 2;
+	}
+
+	/* We can have a perfect match !*/
+	if (pll_freq / m == parent_freq &&
+	    pll_freq % m == 0)
+		return 0;
+
+	frac = div_u64((u64)pll_freq * (u64)frac_max, parent_freq);
+	frac_m = m * frac_max;
+	if (frac_m > frac)
+		return frac_max;
+	frac -= frac_m;
+
+	return min((u16)frac, (u16)(frac_max - 1));
+}
+
+static bool meson_hdmi_pll_validate_params(struct meson_drm *priv,
+					   unsigned int m,
+					   unsigned int frac)
+{
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
+		/* Empiric supported min/max dividers */
+		if (m < 53 || m > 123)
+			return false;
+		if (frac >= HDMI_FRAC_MAX_GXBB)
+			return false;
+	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
+		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
+		/* Empiric supported min/max dividers */
+		if (m < 106 || m > 247)
+			return false;
+		if (frac >= HDMI_FRAC_MAX_GXL)
+			return false;
+	}
+
+	return true;
+}
+
+static bool meson_hdmi_pll_find_params(struct meson_drm *priv,
+				       unsigned int freq,
+				       unsigned int *m,
+				       unsigned int *frac,
+				       unsigned int *od)
+{
+	/* Cycle from /16 to /2 */
+	for (*od = 16 ; *od > 1 ; *od >>= 1) {
+		*m = meson_hdmi_pll_get_m(priv, freq * *od);
+		if (!*m)
+			continue;
+		*frac = meson_hdmi_pll_get_frac(priv, *m, freq * *od);
+
+		DRM_DEBUG_DRIVER("PLL params for %dkHz: m=%x frac=%x od=%d\n",
+				 freq, *m, *frac, *od);
+
+		if (meson_hdmi_pll_validate_params(priv, *m, *frac))
+			return true;
+	}
+
+	return false;
+}
+
+/* pll_freq is the frequency after the OD dividers */
+enum drm_mode_status
+meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned int freq)
+{
+	unsigned int od, m, frac;
+
+	/* In DMT mode, path after PLL is always /10 */
+	freq *= 10;
+
+	if (meson_hdmi_pll_find_params(priv, freq, &m, &frac, &od))
+		return MODE_OK;
+
+	return MODE_CLOCK_RANGE;
+}
+EXPORT_SYMBOL_GPL(meson_vclk_dmt_supported_freq);
+
+/* pll_freq is the frequency after the OD dividers */
+static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
+				       unsigned int pll_freq)
+{
+	unsigned int od, m, frac, od1, od2, od3;
+
+	if (meson_hdmi_pll_find_params(priv, pll_freq, &m, &frac, &od)) {
+		od3 = 1;
+		if (od < 4) {
+			od1 = 2;
+			od2 = 1;
+		} else {
+			od2 = od / 4;
+			od1 = od / od2;
+		}
+
+		DRM_DEBUG_DRIVER("PLL params for %dkHz: m=%x frac=%x od=%d/%d/%d\n",
+				 pll_freq, m, frac, od1, od2, od3);
+
+		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
 
-	if (target == MESON_VCLK_TARGET_CVBS) {
-		meson_venci_cvbs_clock_config(priv);
 		return;
 	}
 
-	hdmi_tx_div = vclk_freq / dac_freq;
-
-	if (hdmi_tx_div == 0) {
-		pr_err("Fatal Error, invalid HDMI-TX freq %d\n",
-				dac_freq);
-		return;
-	}
-
-	venc_div = vclk_freq / venc_freq;
-
-	if (venc_div == 0) {
-		pr_err("Fatal Error, invalid HDMI venc freq %d\n",
-				venc_freq);
-		return;
-	}
-
-	switch (vclk_freq) {
-	case 54000:
-		if (hdmi_use_enci)
-			freq = MESON_VCLK_HDMI_ENCI_54000;
-		else
-			freq = MESON_VCLK_HDMI_DDR_54000;
-		break;
-	case 25175:
-		freq = MESON_VCLK_HDMI_25175;
-		break;
-	case 40000:
-		freq = MESON_VCLK_HDMI_40000;
-		break;
-	case 65000:
-		freq = MESON_VCLK_HDMI_65000;
-		break;
-	case 74250:
-		freq = MESON_VCLK_HDMI_74250;
-		break;
-	case 108000:
-		freq = MESON_VCLK_HDMI_108000;
-		break;
-	case 148500:
-		if (dac_freq != 148500)
-			freq = MESON_VCLK_HDMI_DDR_148500;
-		else
-			freq = MESON_VCLK_HDMI_148500;
-		break;
-	case 162000:
-		freq = MESON_VCLK_HDMI_162000;
-		break;
-	case 297000:
-		freq = MESON_VCLK_HDMI_297000;
-		break;
-	case 594000:
-		freq = MESON_VCLK_HDMI_594000;
-		break;
-	default:
-		pr_err("Fatal Error, invalid HDMI vclk freq %d\n",
-			vclk_freq);
-		return;
-	}
+	DRM_ERROR("Fatal, unable to find parameters for PLL freq %d\n",
+		  pll_freq);
+}
 
+static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
+			   unsigned int od1, unsigned int od2, unsigned int od3,
+			   unsigned int vid_pll_div, unsigned int vclk_div,
+			   unsigned int hdmi_tx_div, unsigned int venc_div,
+			   bool hdmi_use_enci)
+{
 	/* Set HDMI-TX sys clock */
 	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL,
 			   CTS_HDMI_SYS_SEL_MASK, 0);
@@ -831,19 +641,49 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 			   CTS_HDMI_SYS_EN, CTS_HDMI_SYS_EN);
 
 	/* Set HDMI PLL rate */
-	meson_hdmi_pll_set(priv, params[freq].pll_base_freq,
-			   params[freq].pll_od1,
-			   params[freq].pll_od2,
-			   params[freq].pll_od3);
+	if (!od1 && !od2 && !od3)
+		meson_hdmi_pll_generic_set(priv, pll_base_freq);
+	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
+		switch (pll_base_freq) {
+		case 2970000:
+			meson_hdmi_pll_set_params(priv, 0x3d, 0xe00,
+						  od1, od2, od3);
+			break;
+		case 4320000:
+			meson_hdmi_pll_set_params(priv, 0x5a, 0,
+						  od1, od2, od3);
+			break;
+		case 5940000:
+			meson_hdmi_pll_set_params(priv, 0x7b, 0xc00,
+						  od1, od2, od3);
+			break;
+		}
+	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
+		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
+		switch (pll_base_freq) {
+		case 2970000:
+			meson_hdmi_pll_set_params(priv, 0x7b, 0x300,
+						  od1, od2, od3);
+			break;
+		case 4320000:
+			meson_hdmi_pll_set_params(priv, 0xb4, 0,
+						  od1, od2, od3);
+			break;
+		case 5940000:
+			meson_hdmi_pll_set_params(priv, 0xf7, 0x200,
+						  od1, od2, od3);
+			break;
+		}
+	}
 
 	/* Setup vid_pll divider */
-	meson_vid_pll_set(priv, params[freq].vid_pll_div);
+	meson_vid_pll_set(priv, vid_pll_div);
 
 	/* Set VCLK div */
 	regmap_update_bits(priv->hhi, HHI_VID_CLK_CNTL,
 			   VCLK_SEL_MASK, 0);
 	regmap_update_bits(priv->hhi, HHI_VID_CLK_DIV,
-			   VCLK_DIV_MASK, params[freq].vclk_div - 1);
+			   VCLK_DIV_MASK, vclk_div - 1);
 
 	/* Set HDMI-TX source */
 	switch (hdmi_tx_div) {
@@ -981,4 +821,80 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	regmap_update_bits(priv->hhi, HHI_VID_CLK_CNTL, VCLK_EN, VCLK_EN);
 }
+
+void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
+		      unsigned int vclk_freq, unsigned int venc_freq,
+		      unsigned int dac_freq, bool hdmi_use_enci)
+{
+	unsigned int freq;
+	unsigned int hdmi_tx_div;
+	unsigned int venc_div;
+
+	if (target == MESON_VCLK_TARGET_CVBS) {
+		meson_venci_cvbs_clock_config(priv);
+		return;
+	} else if (target == MESON_VCLK_TARGET_DMT) {
+		/* The DMT clock path is fixed after the PLL:
+		 * - automatic PLL freq + OD management
+		 * - vid_pll_div = VID_PLL_DIV_5
+		 * - vclk_div = 2
+		 * - hdmi_tx_div = 1
+		 * - venc_div = 1
+		 * - encp encoder
+		 */
+		meson_vclk_set(priv, vclk_freq * 10, 0, 0, 0,
+			       VID_PLL_DIV_5, 2, 1, 1, false);
+		return;
+	}
+
+	hdmi_tx_div = vclk_freq / dac_freq;
+
+	if (hdmi_tx_div == 0) {
+		pr_err("Fatal Error, invalid HDMI-TX freq %d\n",
+				dac_freq);
+		return;
+	}
+
+	venc_div = vclk_freq / venc_freq;
+
+	if (venc_div == 0) {
+		pr_err("Fatal Error, invalid HDMI venc freq %d\n",
+				venc_freq);
+		return;
+	}
+
+	switch (vclk_freq) {
+	case 54000:
+		if (hdmi_use_enci)
+			freq = MESON_VCLK_HDMI_ENCI_54000;
+		else
+			freq = MESON_VCLK_HDMI_DDR_54000;
+		break;
+	case 74250:
+		freq = MESON_VCLK_HDMI_74250;
+		break;
+	case 148500:
+		if (dac_freq != 148500)
+			freq = MESON_VCLK_HDMI_DDR_148500;
+		else
+			freq = MESON_VCLK_HDMI_148500;
+		break;
+	case 297000:
+		freq = MESON_VCLK_HDMI_297000;
+		break;
+	case 594000:
+		freq = MESON_VCLK_HDMI_594000;
+		break;
+	default:
+		pr_err("Fatal Error, invalid HDMI vclk freq %d\n",
+			vclk_freq);
+		return;
+	}
+
+	meson_vclk_set(priv, params[freq].pll_base_freq,
+		       params[freq].pll_od1, params[freq].pll_od2,
+		       params[freq].pll_od3, params[freq].vid_pll_div,
+		       params[freq].vclk_div, hdmi_tx_div, venc_div,
+		       hdmi_use_enci);
+}
 EXPORT_SYMBOL_GPL(meson_vclk_setup);
diff --git a/drivers/gpu/drm/meson/meson_vclk.h b/drivers/gpu/drm/meson/meson_vclk.h
index 0401b52..869fa3a 100644
--- a/drivers/gpu/drm/meson/meson_vclk.h
+++ b/drivers/gpu/drm/meson/meson_vclk.h
@@ -24,11 +24,15 @@
 enum {
 	MESON_VCLK_TARGET_CVBS = 0,
 	MESON_VCLK_TARGET_HDMI = 1,
+	MESON_VCLK_TARGET_DMT = 2,
 };
 
 /* 27MHz is the CVBS Pixel Clock */
 #define MESON_VCLK_CVBS			27000
 
+enum drm_mode_status
+meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned int freq);
+
 void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 		      unsigned int vclk_freq, unsigned int venc_freq,
 		      unsigned int dac_freq, bool hdmi_use_enci);
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 6e27013..d9f33b0 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -697,314 +697,6 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p60 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_640x480_60 = {
-	.encp = {
-		.dvi_settings = 0x21,
-		.video_mode = 0x4040,
-		.video_mode_adv = 0x18,
-		/* video_prog_mode */
-		/* video_sync_mode */
-		/* video_yc_dly */
-		/* video_rgb_ctrl */
-		/* video_filt_ctrl */
-		/* video_ofld_voav_ofst */
-		/* yfp1_htime */
-		/* yfp2_htime */
-		.max_pxcnt = 0x31f,
-		/* hspuls_begin */
-		/* hspuls_end */
-		/* hspuls_switch */
-		/* vspuls_begin */
-		/* vspuls_end */
-		/* vspuls_bline */
-		/* vspuls_eline */
-		.havon_begin = 0x90,
-		.havon_end = 0x30f,
-		.vavon_bline = 0x23,
-		.vavon_eline = 0x202,
-		/* eqpuls_begin */
-		/* eqpuls_end */
-		/* eqpuls_bline */
-		/* eqpuls_eline */
-		.hso_begin = 0,
-		.hso_end = 0x60,
-		.vso_begin = 0x1e,
-		.vso_end = 0x32,
-		.vso_bline = 0,
-		.vso_eline = 2,
-		.vso_eline_present = true,
-		/* sy_val */
-		/* sy2_val */
-		.max_lncnt = 0x20c,
-	},
-};
-
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_800x600_60 = {
-	.encp = {
-		.dvi_settings = 0x21,
-		.video_mode = 0x4040,
-		.video_mode_adv = 0x18,
-		/* video_prog_mode */
-		/* video_sync_mode */
-		/* video_yc_dly */
-		/* video_rgb_ctrl */
-		/* video_filt_ctrl */
-		/* video_ofld_voav_ofst */
-		/* yfp1_htime */
-		/* yfp2_htime */
-		.max_pxcnt = 0x41f,
-		/* hspuls_begin */
-		/* hspuls_end */
-		/* hspuls_switch */
-		/* vspuls_begin */
-		/* vspuls_end */
-		/* vspuls_bline */
-		/* vspuls_eline */
-		.havon_begin = 0xD8,
-		.havon_end = 0x3f7,
-		.vavon_bline = 0x1b,
-		.vavon_eline = 0x272,
-		/* eqpuls_begin */
-		/* eqpuls_end */
-		/* eqpuls_bline */
-		/* eqpuls_eline */
-		.hso_begin = 0,
-		.hso_end = 0x80,
-		.vso_begin = 0x1e,
-		.vso_end = 0x32,
-		.vso_bline = 0,
-		.vso_eline = 4,
-		.vso_eline_present = true,
-		/* sy_val */
-		/* sy2_val */
-		.max_lncnt = 0x273,
-	},
-};
-
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1024x768_60 = {
-	.encp = {
-		.dvi_settings = 0x21,
-		.video_mode = 0x4040,
-		.video_mode_adv = 0x18,
-		/* video_prog_mode */
-		/* video_sync_mode */
-		/* video_yc_dly */
-		/* video_rgb_ctrl */
-		/* video_filt_ctrl */
-		/* video_ofld_voav_ofst */
-		/* yfp1_htime */
-		/* yfp2_htime */
-		.max_pxcnt = 1343,
-		/* hspuls_begin */
-		/* hspuls_end */
-		/* hspuls_switch */
-		/* vspuls_begin */
-		/* vspuls_end */
-		/* vspuls_bline */
-		/* vspuls_eline */
-		.havon_begin = 296,
-		.havon_end = 1319,
-		.vavon_bline = 35,
-		.vavon_eline = 802,
-		/* eqpuls_begin */
-		/* eqpuls_end */
-		/* eqpuls_bline */
-		/* eqpuls_eline */
-		.hso_begin = 0,
-		.hso_end = 136,
-		.vso_begin = 30,
-		.vso_end = 50,
-		.vso_bline = 0,
-		.vso_eline = 6,
-		.vso_eline_present = true,
-		/* sy_val */
-		/* sy2_val */
-		.max_lncnt = 805,
-	},
-};
-
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1152x864_75 = {
-	.encp = {
-		.dvi_settings = 0x21,
-		.video_mode = 0x4040,
-		.video_mode_adv = 0x18,
-		/* video_prog_mode */
-		/* video_sync_mode */
-		/* video_yc_dly */
-		/* video_rgb_ctrl */
-		/* video_filt_ctrl */
-		/* video_ofld_voav_ofst */
-		/* yfp1_htime */
-		/* yfp2_htime */
-		.max_pxcnt = 0x63f,
-		/* hspuls_begin */
-		/* hspuls_end */
-		/* hspuls_switch */
-		/* vspuls_begin */
-		/* vspuls_end */
-		/* vspuls_bline */
-		/* vspuls_eline */
-		.havon_begin = 0x180,
-		.havon_end = 0x5ff,
-		.vavon_bline = 0x23,
-		.vavon_eline = 0x382,
-		/* eqpuls_begin */
-		/* eqpuls_end */
-		/* eqpuls_bline */
-		/* eqpuls_eline */
-		.hso_begin = 0,
-		.hso_end = 0x80,
-		.vso_begin = 0x1e,
-		.vso_end = 0x32,
-		.vso_bline = 0,
-		.vso_eline = 3,
-		.vso_eline_present = true,
-		/* sy_val */
-		/* sy2_val */
-		.max_lncnt = 0x383,
-	},
-};
-
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1280x1024_60 = {
-	.encp = {
-		.dvi_settings = 0x21,
-		.video_mode = 0x4040,
-		.video_mode_adv = 0x18,
-		/* video_prog_mode */
-		/* video_sync_mode */
-		/* video_yc_dly */
-		/* video_rgb_ctrl */
-		/* video_filt_ctrl */
-		/* video_ofld_voav_ofst */
-		/* yfp1_htime */
-		/* yfp2_htime */
-		.max_pxcnt = 0x697,
-		/* hspuls_begin */
-		/* hspuls_end */
-		/* hspuls_switch */
-		/* vspuls_begin */
-		/* vspuls_end */
-		/* vspuls_bline */
-		/* vspuls_eline */
-		.havon_begin = 0x168,
-		.havon_end = 0x667,
-		.vavon_bline = 0x29,
-		.vavon_eline = 0x428,
-		/* eqpuls_begin */
-		/* eqpuls_end */
-		/* eqpuls_bline */
-		/* eqpuls_eline */
-		.hso_begin = 0,
-		.hso_end = 0x70,
-		.vso_begin = 0x1e,
-		.vso_end = 0x32,
-		.vso_bline = 0,
-		.vso_eline = 3,
-		.vso_eline_present = true,
-		/* sy_val */
-		/* sy2_val */
-		.max_lncnt = 0x429,
-	},
-};
-
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1600x1200_60 = {
-	.encp = {
-		.dvi_settings = 0x21,
-		.video_mode = 0x4040,
-		.video_mode_adv = 0x18,
-		/* video_prog_mode */
-		/* video_sync_mode */
-		/* video_yc_dly */
-		/* video_rgb_ctrl */
-		/* video_filt_ctrl */
-		/* video_ofld_voav_ofst */
-		/* yfp1_htime */
-		/* yfp2_htime */
-		.max_pxcnt = 0x86f,
-		/* hspuls_begin */
-		/* hspuls_end */
-		/* hspuls_switch */
-		/* vspuls_begin */
-		/* vspuls_end */
-		/* vspuls_bline */
-		/* vspuls_eline */
-		.havon_begin = 0x1f0,
-		.havon_end = 0x82f,
-		.vavon_bline = 0x31,
-		.vavon_eline = 0x4e0,
-		/* eqpuls_begin */
-		/* eqpuls_end */
-		/* eqpuls_bline */
-		/* eqpuls_eline */
-		.hso_begin = 0,
-		.hso_end = 0xc0,
-		.vso_begin = 0x1e,
-		.vso_end = 0x32,
-		.vso_bline = 0,
-		.vso_eline = 3,
-		.vso_eline_present = true,
-		/* sy_val */
-		/* sy2_val */
-		.max_lncnt = 0x4e1,
-	},
-};
-
-struct meson_hdmi_venc_dmt_mode {
-	struct drm_display_mode drm_mode;
-	union meson_hdmi_venc_mode *mode;
-} meson_hdmi_venc_dmt_modes[] = {
-	/* 640x480@60Hz */
-	{
-		{ DRM_MODE("640x480", DRM_MODE_TYPE_DRIVER, 25175, 640, 656,
-		  752, 800, 0, 480, 490, 492, 525, 0,
-		  DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC) },
-		&meson_hdmi_encp_mode_640x480_60,
-	},
-	/* 800x600@60Hz */
-	{
-		{ DRM_MODE("800x600", DRM_MODE_TYPE_DRIVER, 40000, 800, 840,
-		  968, 1056, 0, 600, 601, 605, 628, 0,
-		  DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-		&meson_hdmi_encp_mode_800x600_60,
-	},
-	/* 1024x768@60Hz */
-	{
-		{ DRM_MODE("1024x768", DRM_MODE_TYPE_DRIVER, 65000, 1024,
-		  1048, 1184, 1344, 0, 768, 771, 777, 806, 0,
-		  DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC) },
-		&meson_hdmi_encp_mode_1024x768_60,
-	},
-	/* 1152x864@75Hz */
-	{
-		{ DRM_MODE("1152x864", DRM_MODE_TYPE_DRIVER, 108000, 1152,
-		  1216, 1344, 1600, 0, 864, 865, 868, 900, 0,
-		  DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-		&meson_hdmi_encp_mode_1152x864_75,
-	},
-	/* 1280x1024@60Hz */
-	{
-		{ DRM_MODE("1280x1024", DRM_MODE_TYPE_DRIVER, 108000, 1280,
-		  1328, 1440, 1688, 0, 1024, 1025, 1028, 1066, 0,
-		  DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-		&meson_hdmi_encp_mode_1280x1024_60,
-	},
-	/* 1600x1200@60Hz */
-	{
-		{ DRM_MODE("1600x1200", DRM_MODE_TYPE_DRIVER, 162000, 1600,
-		  1664, 1856, 2160, 0, 1200, 1201, 1204, 1250, 0,
-		  DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-		&meson_hdmi_encp_mode_1600x1200_60,
-	},
-	/* 1920x1080@60Hz */
-	{
-		{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 148500, 1920,
-		  2008, 2052, 2200, 0, 1080, 1084, 1089, 1125, 0,
-		  DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC) },
-		&meson_hdmi_encp_mode_1080p60
-	},
-	{ }, /* sentinel */
-};
-
 struct meson_hdmi_venc_vic_mode {
 	unsigned int vic;
 	union meson_hdmi_venc_mode *mode;
@@ -1044,17 +736,20 @@ static unsigned long modulo(unsigned long a, unsigned long b)
 		return a;
 }
 
-bool meson_venc_hdmi_supported_mode(const struct drm_display_mode *mode)
+enum drm_mode_status
+meson_venc_hdmi_supported_mode(const struct drm_display_mode *mode)
 {
-	struct meson_hdmi_venc_dmt_mode *vmode = meson_hdmi_venc_dmt_modes;
+	if (mode->flags & ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC |
+			    DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC))
+		return MODE_BAD;
 
-	while (vmode->mode) {
-		if (drm_mode_equal(&vmode->drm_mode, mode))
-			return true;
-		vmode++;
-	}
+	if (mode->hdisplay < 640 || mode->hdisplay > 1920)
+		return MODE_BAD_HVALUE;
 
-	return false;
+	if (mode->vdisplay < 480 || mode->vdisplay > 1200)
+		return MODE_BAD_VVALUE;
+
+	return MODE_OK;
 }
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_supported_mode);
 
@@ -1072,18 +767,29 @@ bool meson_venc_hdmi_supported_vic(int vic)
 }
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_supported_vic);
 
-static union meson_hdmi_venc_mode
-*meson_venc_hdmi_get_dmt_vmode(const struct drm_display_mode *mode)
+void meson_venc_hdmi_get_dmt_vmode(const struct drm_display_mode *mode,
+				   union meson_hdmi_venc_mode *dmt_mode)
 {
-	struct meson_hdmi_venc_dmt_mode *vmode = meson_hdmi_venc_dmt_modes;
+	memset(dmt_mode, 0, sizeof(*dmt_mode));
 
-	while (vmode->mode) {
-		if (drm_mode_equal(&vmode->drm_mode, mode))
-			return vmode->mode;
-		vmode++;
-	}
-
-	return NULL;
+	dmt_mode->encp.dvi_settings = 0x21;
+	dmt_mode->encp.video_mode = 0x4040;
+	dmt_mode->encp.video_mode_adv = 0x18;
+	dmt_mode->encp.max_pxcnt = mode->htotal - 1;
+	dmt_mode->encp.havon_begin = mode->htotal - mode->hsync_start;
+	dmt_mode->encp.havon_end = dmt_mode->encp.havon_begin +
+				   mode->hdisplay - 1;
+	dmt_mode->encp.vavon_bline = mode->vtotal - mode->vsync_start;
+	dmt_mode->encp.vavon_eline = dmt_mode->encp.vavon_bline +
+				     mode->vdisplay - 1;
+	dmt_mode->encp.hso_begin = 0;
+	dmt_mode->encp.hso_end = mode->hsync_end - mode->hsync_start;
+	dmt_mode->encp.vso_begin = 30;
+	dmt_mode->encp.vso_end = 50;
+	dmt_mode->encp.vso_bline = 0;
+	dmt_mode->encp.vso_eline = mode->vsync_end - mode->vsync_start;
+	dmt_mode->encp.vso_eline_present = true;
+	dmt_mode->encp.max_lncnt = mode->vtotal - 1;
 }
 
 static union meson_hdmi_venc_mode *meson_venc_hdmi_get_vic_vmode(int vic)
@@ -1120,6 +826,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 			      struct drm_display_mode *mode)
 {
 	union meson_hdmi_venc_mode *vmode = NULL;
+	union meson_hdmi_venc_mode vmode_dmt;
 	bool use_enci = false;
 	bool venc_repeat = false;
 	bool hdmi_repeat = false;
@@ -1147,14 +854,18 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	unsigned int sof_lines;
 	unsigned int vsync_lines;
 
-	if (meson_venc_hdmi_supported_vic(vic))
+	if (meson_venc_hdmi_supported_vic(vic)) {
 		vmode = meson_venc_hdmi_get_vic_vmode(vic);
-	else
-		vmode = meson_venc_hdmi_get_dmt_vmode(mode);
-	if (!vmode) {
-		dev_err(priv->dev, "%s: Fatal Error, unsupported mode "
-			DRM_MODE_FMT "\n", __func__, DRM_MODE_ARG(mode));
-		return;
+		if (!vmode) {
+			dev_err(priv->dev, "%s: Fatal Error, unsupported mode "
+				DRM_MODE_FMT "\n", __func__,
+				DRM_MODE_ARG(mode));
+			return;
+		}
+	}
+	else {
+		meson_venc_hdmi_get_dmt_vmode(mode, &vmode_dmt);
+		vmode = &vmode_dmt;
 	}
 
 	/* Use VENCI for 480i and 576i and double HDMI pixels */
diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
index 7c18a36..97eaebb 100644
--- a/drivers/gpu/drm/meson/meson_venc.h
+++ b/drivers/gpu/drm/meson/meson_venc.h
@@ -58,7 +58,8 @@ struct meson_cvbs_enci_mode {
 };
 
 /* HDMI Clock parameters */
-bool meson_venc_hdmi_supported_mode(const struct drm_display_mode *mode);
+enum drm_mode_status
+meson_venc_hdmi_supported_mode(const struct drm_display_mode *mode);
 bool meson_venc_hdmi_supported_vic(int vic);
 bool meson_venc_hdmi_venc_repeat(int vic);
 
-- 
2.7.4

