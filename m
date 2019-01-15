Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71CFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B454320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pNLYa2k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfAOMeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:34:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37100 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfAOMdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:33:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so2775216wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZoSJXtrtyktFuA6EDyaYkMwS7WZFT2t11rt0gb5clag=;
        b=pNLYa2k8DzaJ5bRo4yOsTJ+BpalhSUM0Z1/CQwVkR+BvknyK2/I5Hczdw02rfzmJU9
         Wk8X7PJFzc5POBSHyYbNZLBgmTzIshTwognX4AgIlD6bKON9QMZiTeEy3O/WxVb/x9we
         abx2936dNB/tfYeKU0C6F7UJzMsmS+N5u8I4rczT6A3ZjM2sReA+9LmGrjcVz5LDBhSY
         AIgkTSGXEMLJp7+yns7Knau8b38v4x/lrvZBT/FtkDm6FXiiTeACqygljG8e24FdadZX
         TJ3h/l1Dj5QV2A3EppaCtWsipWWJM1EMNTQtTTXBfIEskkV9Jgw5QaVqvKpv2+GEmWSF
         Sfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZoSJXtrtyktFuA6EDyaYkMwS7WZFT2t11rt0gb5clag=;
        b=qrJhFji+xTmePauXc3Lf97mHi7lP8+FOmlO/NGJoxPpaOoYPpny255DAQqoXjQl5fv
         ehNdch2zKgZdngHioLKcSemU5FO2tbKUtuYhP0N1rTlH1z0n4ikfGJtgV4P2cEhSaP2+
         +uh9y+9N/T30imGcSEaxPTTPRpDOmDngkS6pbteZcOCvLLaKI/C0oYZXsLY5L5CxJBGu
         MAGCNUqf0Sh1WkTK/Ei6xE6dgHMqYd5osRhyI+cMDwqhzvgDAgk3f7Qg520xduZ/hiiU
         0He/p83IZ9hPEflWnXu4NbZk0L/4PpkrslXW+thYCXJUNpg02E7Bqv0ulNXJJEO3JiDg
         YBOQ==
X-Gm-Message-State: AJcUukeo2GSWz8NSPAol7kl7VdIk6269Fa6TFL7YrZ98R+n4y2OVTaU2
        IhCC5RR9brtorafjiV2JlisxXw==
X-Google-Smtp-Source: ALg8bN4i58w4bkRUz3m3QOvTSyG+ZrKKVWiERMufXp0oy/32IQn5WJ/MmaVQihAG0Y3ZHnTEqBEjZw==
X-Received: by 2002:adf:8484:: with SMTP id 4mr2943238wrg.249.1547555602625;
        Tue, 15 Jan 2019 04:33:22 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x15sm75658842wrs.27.2019.01.15.04.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 04:33:21 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] drm/meson: add HDMI div40 TMDS mode
Date:   Tue, 15 Jan 2019 13:33:09 +0100
Message-Id: <20190115123315.11069-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115123315.11069-1-narmstrong@baylibre.com>
References: <20190115123315.11069-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TMDS Clock > 3.4GHz for HDMI2.0 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 807111ebfdd9..3d8decb77019 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -365,7 +365,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	unsigned int wr_clk =
 		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
 
-	DRM_DEBUG_DRIVER("%d:\"%s\"\n", mode->base.id, mode->name);
+	DRM_DEBUG_DRIVER("%d:\"%s\" div%d\n", mode->base.id, mode->name,
+			 mode->clock > 340000 ? 40 : 10);
 
 	/* Enable clocks */
 	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
@@ -385,9 +386,17 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	/* Enable normal output to PHY */
 	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
 
-	/* TMDS pattern setup (TOFIX pattern for 4k2k scrambling) */
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0x001f001f);
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23, 0x001f001f);
+	/* TMDS pattern setup (TOFIX Handle the YUV420 case) */
+	if (mode->clock > 340000) {
+		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0);
+		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
+				  0x03ff03ff);
+	} else {
+		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
+				  0x001f001f);
+		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
+				  0x001f001f);
+	}
 
 	/* Load TMDS pattern */
 	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_CNTL, 0x1);
@@ -413,6 +422,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	/* Disable clock, fifo, fifo_wr */
 	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1, 0xf, 0);
 
+	dw_hdmi_set_high_tmds_clock_ratio(hdmi);
+
 	msleep(100);
 
 	/* Reset PHY 3 times in a row */
@@ -562,6 +573,10 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 		mode->vdisplay, mode->vsync_start,
 		mode->vsync_end, mode->vtotal, mode->type, mode->flags);
 
+	/* If sink max TMDS clock, we reject the mode */
+	if (mode->clock > connector->display_info.max_tmds_clock)
+		return MODE_BAD;
+
 	/* Check against non-VIC supported modes */
 	if (!vic) {
 		status = meson_venc_hdmi_supported_mode(mode);
-- 
2.20.1

