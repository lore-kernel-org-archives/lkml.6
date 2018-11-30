Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC20C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517602145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qCHLXK7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517602145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeLAAwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:52:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34643 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeLAAw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:52:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so5358907wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJ/wHCT9A5Hgbiug3pEAgTUcxhEEU46YzYDd7i4hsM8=;
        b=qCHLXK7+E/G9sKCBzSLooSbpPG1k1hW8xhw6NAPD7Pv3Wvz2yqOxbxb6ynFo/HmemP
         r4rzaxsEFE9L6qsN18xP+SgDJu0PwuZm+L8Mg1d0IFlyMunNBWE6XS0KjHMcQJl4lY5N
         C+66WJyzWBdjEPWc8zTAbWYPOCsNop9F3IuuBddo9gGanbEFPVdZhWST00P8NIjlGCVz
         EN3S8Ymm+gHpotTvUGEXB3z38/EMA1dgdQQIJHN37LmG1RQv8T66fckZK1DIWi/PerDZ
         Lfk2OQsW/eN/Qd6dKVTW6rRux6bnPplQ/6rfJvH4GJ2C6bkGBd0euuY5632sC6krMwL4
         p1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJ/wHCT9A5Hgbiug3pEAgTUcxhEEU46YzYDd7i4hsM8=;
        b=Wpqyw+gTNrLANgy3SIR7b19fiv8TDw2ed9VsDwn0he0nK7koo9KrTJlJvpZgncHnVt
         6/ol3TxsXlXa6UV9HWAlf89z/2zC2gR/xzjYDiYFxN+Zc2GUnU8RiKzlcStSE6IxLT46
         KcYJAGy0qRSV2By9Qmb1ZVau6Ilt7/VKGFkYsL2qT1pwUWinwz+upeXykXhUyNdGMFGN
         BtYCNEyxX4E6I/dQOo0lgxKHYs1zy5OmzuPMUuVQYd4cj2VfFB1A4FC59XUMbk0ukRIS
         PTAtk9cV1rcLriDF9PBxC/SUbTGSpJ4aD6qQPgLwAvfuKYZ5AhU/VOgsm67r9Z3rGKHz
         rPSw==
X-Gm-Message-State: AA+aEWbPE5ffwsIEH+NkRdn0d5I0PaH2ejBeZJ+/OOifB9tQTCFW1Xou
        h4kjCZBkeWEQzhCRa6nWRv1b5Q==
X-Google-Smtp-Source: AFSGD/WaDGIQ6dCxjaD5ILlgxzIzVOcfWabOeivthI7kQleo43mesCmXERcmhsdKS04Q/+ThGHHNnw==
X-Received: by 2002:adf:83e7:: with SMTP id 94mr5040067wre.278.1543585386694;
        Fri, 30 Nov 2018 05:43:06 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 125sm6864898wml.35.2018.11.30.05.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 05:43:06 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 2/8] drm/meson: add HDMI div40 TMDS mode
Date:   Fri, 30 Nov 2018 14:42:55 +0100
Message-Id: <20181130134301.17963-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130134301.17963-1-narmstrong@baylibre.com>
References: <20181130134301.17963-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TMDS Clock > 3.4GHz for HDMI2.0 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 807111ebfdd9..b8775102b100 100644
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
@@ -562,6 +573,11 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 		mode->vdisplay, mode->vsync_start,
 		mode->vsync_end, mode->vtotal, mode->type, mode->flags);
 
+	/* If sink max TMDS clock < 340MHz, we reject the HDMI2.0 modes */
+	if (mode->clock > 340000 &&
+	    connector->display_info.max_tmds_clock < 340000)
+		return MODE_BAD;
+
 	/* Check against non-VIC supported modes */
 	if (!vic) {
 		status = meson_venc_hdmi_supported_mode(mode);
-- 
2.19.2

