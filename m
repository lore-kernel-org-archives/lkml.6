Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51291C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22882218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Mpu3V7TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfBAMIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:08:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51423 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfBAMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:08:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so5883429wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6aa/GzlhP8ObDc4Qw7/JY3Cu5N8hkn77bsJ9zMHN4fU=;
        b=Mpu3V7TGaftA27EPpE0+ewC8WyoXuDFn/33ELQ2gB3NBMXE5jf9GuMH/bZIcMrnY6g
         8QLGZ/1MmOOGtXlsrLP5UpFg1wJBZbiUKrU40JS+QsPjK7s3xaSXrwld29tkHm14LX38
         n1HheEcauEyA05zCEV8DwsYfTrvSvqa0WwQwkcrewN9DUzD1XeF+kQFxenAkLp1lKpnQ
         iv7BRc72tMgGJ7nBwlPXed/qbMmfrOaBJysiEPG+4HjhAyJxjAMQTEqFGQuLzmk125LC
         VvZYsOzwTOHZ5qiIexWblc6JnYDpNi+siMjlKpn9nKODlHvOpno3mQI68IpnziyeTlA8
         f04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6aa/GzlhP8ObDc4Qw7/JY3Cu5N8hkn77bsJ9zMHN4fU=;
        b=KhardWzv4GQzoXPWy3Mw1yTy1/6XksgVfhvcTgWQw5Sgss4jgedX4qMFnmQb7grQL3
         zkrHvubPuHshVBUkRx5ASdJxhEgcFfQv1SmyZSxMEbPq854Nlig3pvQDZg0DMut72P62
         syUxg+bGDOwIYwH3wgxCUg5JWsRPzUYZmHRbKdD68kVxz2V9z1T466QcGzgUrGr8MzZy
         G3i0kMdZl6i7PRLIArFlTVNPRlRg2wGURz5YDy0Veh44jDhIKSIdYUcC1HVl3TuS12LH
         /NXTdIS5gF6AXaCZ/zcfmbpFeNEqc5W0OZPXRCyk4i0JFjsYc5x/wREHvuU0wod1K3Dr
         BO0Q==
X-Gm-Message-State: AHQUAuZQOhXYhbd8utYRsFiHI0ZVPD1xG5q9zMk2i4WvyLXZhvwvtBOf
        4mmhaJfNnLo5E/BAlebYJrvIgA==
X-Google-Smtp-Source: AHgI3IbfRmqImr8JQ8pHCn8Xy7Vpo/mkQqVrp7SgDWw7dlc/Y7z857uEhNxS5lfmeAQuQB8jSwD0Iw==
X-Received: by 2002:a1c:c303:: with SMTP id t3mr2026891wmf.94.1549022878008;
        Fri, 01 Feb 2019 04:07:58 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id m13sm2577103wmd.6.2019.02.01.04.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 04:07:57 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, Sandy Huang <hjc@rock-chips.com>,
        heiko@sntech.de, maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] drm/meson: add HDMI div40 TMDS mode
Date:   Fri,  1 Feb 2019 12:07:47 +0000
Message-Id: <1549022873-40549-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
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
index 83585b3..e28814f 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -365,7 +365,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	unsigned int wr_clk =
 		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
 
-	DRM_DEBUG_DRIVER("\"%s\"\n", mode->name);
+	DRM_DEBUG_DRIVER("\"%s\" div%d\n", mode->name,
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
@@ -557,6 +568,10 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 
 	DRM_DEBUG_DRIVER("Modeline " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 
+	/* If sink max TMDS clock, we reject the mode */
+	if (mode->clock > connector->display_info.max_tmds_clock)
+		return MODE_BAD;
+
 	/* Check against non-VIC supported modes */
 	if (!vic) {
 		status = meson_venc_hdmi_supported_mode(mode);
-- 
2.7.4

