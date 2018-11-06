Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860B8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3810D2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="klECkeKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3810D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbeKFUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:19:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45686 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKFUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:19:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id k15-v6so9962122wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4GUprm9HmbWPoDJRU2zuoLJ8O3xIDWpcOXQKbm06s7Y=;
        b=klECkeKvIejdZFcg5RmGjvdaKXtw4HEJHWFX0AxJ0OnxqIRe6QH+gd/NLgbjQEXYDo
         JFsZ7LdHwhAl5Sgs5DIn2vSygabO/xWD7MMtUAY1vCmmmhc2xcAkGqAyImLCtPL4SFvh
         /5oqOVUF6mEEe2JA3jgcehtDEHkfomWizo0aDEYPhvcVi56rGObxfSmvtAfz8weR5wLQ
         NSZJjngveq0BbD1Oeod8rFHHmXQdRO/LtQrk/fUPK3nM5uioia/uojfBITXlmmMmblG/
         bKmhbdPnxi84mNtyYDkpECrwaEFO/DTQzKkeYXDBRJ7h9VT21Ptj06hCsQxZ0iJriRl3
         IB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4GUprm9HmbWPoDJRU2zuoLJ8O3xIDWpcOXQKbm06s7Y=;
        b=fGQr4aOn8xKU6/Lb4fa0ojUa2xyVf2TKkMbMZ9XhoEmiM0YB5dyrXiCLgqQFhn0okM
         +asMhSYeGfdhAych7FsjO4s9GyNUmWYeS2c8EeBuUXmLDhlA62ISVjpCYLmbhMU7OwE3
         dn5sDWSVLhgqauxsdH/FLhLcrBtaDnjX8hJYLUsr04PBkkfywXW2ON7tJHb1g0YVbdXs
         h+9CHrBsupSVrhI+iNMsxXoDxo0+fQBLJrWoSkvlv6jiTsH4GLs81fF6y4kcEqIl3jQd
         3IdyyWRSMjBVtmqKF8isAPGXF907N7bVhBUGBGMvNYy132xaqeedtjVtMFDJ9hJLUXiW
         jd2g==
X-Gm-Message-State: AGRZ1gLzGOWYfoTgsQLechQmgsIxHeo1YrV1fnlhP5P7SbDxzutzTXw9
        MB5EMI67ZwG9jxp/Tq4LGdF+tg==
X-Google-Smtp-Source: AJdET5c9o2Q8/t3T3B9Bn7Ln57+p3tKSHUUv8GAxwKwnEq0xw6NuhQC1qzCJ0ILHRYxgWGm1O9uH5w==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14-v6mr23334565wrt.326.1541501680374;
        Tue, 06 Nov 2018 02:54:40 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b204-v6sm641147wmh.0.2018.11.06.02.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 02:54:39 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: Add support for VIC alternate timings
Date:   Tue,  6 Nov 2018 11:54:35 +0100
Message-Id: <1541501675-3928-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is an attempt to handle the alternate clock for the CEA mode.
60Hz vs. 59.94Hz, 30Hz vs 29.97Hz or 24Hz vs 23.97Hz on the Amlogic Meson SoC
DRM Driver pixel clock generation.

The actual clock generation will be moved to the Common Clock framework once
all the video clock are handled by the Amlogic Meson SoC clock driver,
then these alternate timings will be handled in the same time in a cleaner
fashion.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c |  12 +---
 drivers/gpu/drm/meson/meson_vclk.c    | 127 +++++++++++++++++++++++-----------
 drivers/gpu/drm/meson/meson_vclk.h    |   2 +
 3 files changed, 89 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index df7247c..d8c5cc3 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -594,17 +594,7 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 	dev_dbg(connector->dev->dev, "%s: vclk:%d venc=%d hdmi=%d\n", __func__,
 		vclk_freq, venc_freq, hdmi_freq);
 
-	/* Finally filter by configurable vclk frequencies for VIC modes */
-	switch (vclk_freq) {
-	case 54000:
-	case 74250:
-	case 148500:
-	case 297000:
-	case 594000:
-		return MODE_OK;
-	}
-
-	return MODE_CLOCK_RANGE;
+	return meson_vclk_vic_supported_freq(vclk_freq);
 }
 
 /* Encoder */
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index ae54732..5accceb 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -117,6 +117,8 @@
 #define HDMI_PLL_RESET		BIT(28)
 #define HDMI_PLL_LOCK		BIT(31)
 
+#define FREQ_1000_1001(_freq)	DIV_ROUND_CLOSEST(_freq * 1000, 1001)
+
 /* VID PLL Dividers */
 enum {
 	VID_PLL_DIV_1 = 0,
@@ -323,7 +325,7 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
 enum {
 /* PLL	O1 O2 O3 VP DV     EN TX */
 /* 4320 /4 /4 /1 /5 /1  => /2 /2 */
-	MESON_VCLK_HDMI_ENCI_54000 = 1,
+	MESON_VCLK_HDMI_ENCI_54000 = 0,
 /* 4320 /4 /4 /1 /5 /1  => /1 /2 */
 	MESON_VCLK_HDMI_DDR_54000,
 /* 2970 /4 /1 /1 /5 /1  => /1 /2 */
@@ -339,6 +341,7 @@ enum {
 };
 
 struct meson_vclk_params {
+	unsigned int pixel_freq;
 	unsigned int pll_base_freq;
 	unsigned int pll_od1;
 	unsigned int pll_od2;
@@ -347,6 +350,7 @@ struct meson_vclk_params {
 	unsigned int vclk_div;
 } params[] = {
 	[MESON_VCLK_HDMI_ENCI_54000] = {
+		.pixel_freq = 54000,
 		.pll_base_freq = 4320000,
 		.pll_od1 = 4,
 		.pll_od2 = 4,
@@ -355,6 +359,7 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_DDR_54000] = {
+		.pixel_freq = 54000,
 		.pll_base_freq = 4320000,
 		.pll_od1 = 4,
 		.pll_od2 = 4,
@@ -363,6 +368,7 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_DDR_148500] = {
+		.pixel_freq = 148500,
 		.pll_base_freq = 2970000,
 		.pll_od1 = 4,
 		.pll_od2 = 1,
@@ -371,6 +377,7 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_74250] = {
+		.pixel_freq = 74250,
 		.pll_base_freq = 2970000,
 		.pll_od1 = 2,
 		.pll_od2 = 2,
@@ -379,6 +386,7 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_148500] = {
+		.pixel_freq = 148500,
 		.pll_base_freq = 2970000,
 		.pll_od1 = 1,
 		.pll_od2 = 2,
@@ -387,6 +395,7 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_297000] = {
+		.pixel_freq = 297000,
 		.pll_base_freq = 2970000,
 		.pll_od1 = 1,
 		.pll_od2 = 1,
@@ -395,6 +404,7 @@ struct meson_vclk_params {
 		.vclk_div = 2,
 	},
 	[MESON_VCLK_HDMI_594000] = {
+		.pixel_freq = 594000,
 		.pll_base_freq = 5940000,
 		.pll_od1 = 1,
 		.pll_od2 = 1,
@@ -402,6 +412,7 @@ struct meson_vclk_params {
 		.vid_pll_div = VID_PLL_DIV_5,
 		.vclk_div = 1,
 	},
+	{ /* sentinel */ },
 };
 
 static inline unsigned int pll_od_to_reg(unsigned int od)
@@ -626,12 +637,37 @@ static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
 		  pll_freq);
 }
 
+enum drm_mode_status
+meson_vclk_vic_supported_freq(unsigned int freq)
+{
+	int i;
+
+	DRM_DEBUG_DRIVER("freq = %d\n", freq);
+
+	for (i = 0 ; params[i].pixel_freq ; ++i) {
+		DRM_DEBUG_DRIVER("i = %d pixel_freq = %d alt = %d\n",
+				 i, params[i].pixel_freq,
+				 FREQ_1000_1001(params[i].pixel_freq));
+		/* Match strict frequency */
+		if (freq == params[i].pixel_freq)
+			return MODE_OK;
+		/* Match 1000/1001 variant */
+		if (freq == FREQ_1000_1001(params[i].pixel_freq))
+			return MODE_OK;
+	}
+
+	return MODE_CLOCK_RANGE;
+}
+EXPORT_SYMBOL_GPL(meson_vclk_vic_supported_freq);
+
 static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
 			   unsigned int od1, unsigned int od2, unsigned int od3,
 			   unsigned int vid_pll_div, unsigned int vclk_div,
 			   unsigned int hdmi_tx_div, unsigned int venc_div,
-			   bool hdmi_use_enci)
+			   bool hdmi_use_enci, bool vic_alternate_clock)
 {
+	unsigned int m, frac;
+
 	/* Set HDMI-TX sys clock */
 	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL,
 			   CTS_HDMI_SYS_SEL_MASK, 0);
@@ -646,34 +682,38 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
 	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
 		switch (pll_base_freq) {
 		case 2970000:
-			meson_hdmi_pll_set_params(priv, 0x3d, 0xe00,
-						  od1, od2, od3);
+			m = 0x3d;
+			frac = vic_alternate_clock ? 0xd02 : 0xe00;
 			break;
 		case 4320000:
-			meson_hdmi_pll_set_params(priv, 0x5a, 0,
-						  od1, od2, od3);
+			m = vic_alternate_clock ? 0x59 : 0x5a;
+			frac = vic_alternate_clock ? 0xe8f : 0;
 			break;
 		case 5940000:
-			meson_hdmi_pll_set_params(priv, 0x7b, 0xc00,
-						  od1, od2, od3);
+			m = 0x7b;
+			frac = vic_alternate_clock ? 0xa05 : 0xc00;
 			break;
 		}
+
+		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
 	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
 		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
 		switch (pll_base_freq) {
 		case 2970000:
-			meson_hdmi_pll_set_params(priv, 0x7b, 0x300,
-						  od1, od2, od3);
+			m = 0x7b;
+			frac = vic_alternate_clock ? 0x281 : 0x300;
 			break;
 		case 4320000:
-			meson_hdmi_pll_set_params(priv, 0xb4, 0,
-						  od1, od2, od3);
+			m = vic_alternate_clock ? 0xb3 : 0xb4;
+			frac = vic_alternate_clock ? 0x347 : 0;
 			break;
 		case 5940000:
-			meson_hdmi_pll_set_params(priv, 0xf7, 0x200,
-						  od1, od2, od3);
+			m = 0xf7;
+			frac = vic_alternate_clock ? 0x102 : 0x200;
 			break;
 		}
+
+		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
 	}
 
 	/* Setup vid_pll divider */
@@ -826,6 +866,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 		      unsigned int vclk_freq, unsigned int venc_freq,
 		      unsigned int dac_freq, bool hdmi_use_enci)
 {
+	bool vic_alternate_clock = false;
 	unsigned int freq;
 	unsigned int hdmi_tx_div;
 	unsigned int venc_div;
@@ -843,7 +884,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 		 * - encp encoder
 		 */
 		meson_vclk_set(priv, vclk_freq * 10, 0, 0, 0,
-			       VID_PLL_DIV_5, 2, 1, 1, false);
+			       VID_PLL_DIV_5, 2, 1, 1, false, false);
 		return;
 	}
 
@@ -863,31 +904,35 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 		return;
 	}
 
-	switch (vclk_freq) {
-	case 54000:
-		if (hdmi_use_enci)
-			freq = MESON_VCLK_HDMI_ENCI_54000;
-		else
-			freq = MESON_VCLK_HDMI_DDR_54000;
-		break;
-	case 74250:
-		freq = MESON_VCLK_HDMI_74250;
-		break;
-	case 148500:
-		if (dac_freq != 148500)
-			freq = MESON_VCLK_HDMI_DDR_148500;
-		else
-			freq = MESON_VCLK_HDMI_148500;
-		break;
-	case 297000:
-		freq = MESON_VCLK_HDMI_297000;
-		break;
-	case 594000:
-		freq = MESON_VCLK_HDMI_594000;
-		break;
-	default:
-		pr_err("Fatal Error, invalid HDMI vclk freq %d\n",
-		       vclk_freq);
+	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
+		if (vclk_freq == params[freq].pixel_freq ||
+		    vclk_freq == FREQ_1000_1001(params[freq].pixel_freq)) {
+			if (vclk_freq != params[freq].pixel_freq)
+				vic_alternate_clock = true;
+			else
+				vic_alternate_clock = false;
+
+			if (freq == MESON_VCLK_HDMI_ENCI_54000 &&
+			    !hdmi_use_enci)
+				continue;
+
+			if (freq == MESON_VCLK_HDMI_DDR_54000 &&
+			    hdmi_use_enci)
+				continue;
+
+			if (freq == MESON_VCLK_HDMI_DDR_148500 &&
+			    dac_freq == vclk_freq)
+				continue;
+
+			if (freq == MESON_VCLK_HDMI_148500 &&
+			    dac_freq != vclk_freq)
+				continue;
+			break;
+		}
+	}
+
+	if (!params[freq].pixel_freq) {
+		pr_err("Fatal Error, invalid HDMI vclk freq %d\n", vclk_freq);
 		return;
 	}
 
@@ -895,6 +940,6 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 		       params[freq].pll_od1, params[freq].pll_od2,
 		       params[freq].pll_od3, params[freq].vid_pll_div,
 		       params[freq].vclk_div, hdmi_tx_div, venc_div,
-		       hdmi_use_enci);
+		       hdmi_use_enci, vic_alternate_clock);
 }
 EXPORT_SYMBOL_GPL(meson_vclk_setup);
diff --git a/drivers/gpu/drm/meson/meson_vclk.h b/drivers/gpu/drm/meson/meson_vclk.h
index 869fa3a..4bd8752 100644
--- a/drivers/gpu/drm/meson/meson_vclk.h
+++ b/drivers/gpu/drm/meson/meson_vclk.h
@@ -32,6 +32,8 @@ enum {
 
 enum drm_mode_status
 meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned int freq);
+enum drm_mode_status
+meson_vclk_vic_supported_freq(unsigned int freq);
 
 void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 		      unsigned int vclk_freq, unsigned int venc_freq,
-- 
2.7.4

