Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C0F92C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C6120660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C6120660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934549AbeFLUCp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:02:45 -0400
Received: from mailoutvs60.siol.net ([185.57.226.251]:38716 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934398AbeFLUCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id A8D05522148;
        Tue, 12 Jun 2018 22:02:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rt3bZRLfIuhT; Tue, 12 Jun 2018 22:02:39 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 1FB9B522020;
        Tue, 12 Jun 2018 22:02:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 95410522148;
        Tue, 12 Jun 2018 22:02:36 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 20/27] drm/sun4i: Don't change clock bits in DW HDMI PHY driver
Date:   Tue, 12 Jun 2018 22:00:29 +0200
Message-Id: <20180612200036.21483-21-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW HDMI PHY driver and PHY clock driver share same registers. Make sure
that DW HDMI PHY setup code doesn't change any clock related bits and
set them to 0 during initialization.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  2 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 79154f0f674a..3ba71aff92fc 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -98,7 +98,7 @@
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN		BIT(29)
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN		BIT(28)
 #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33	BIT(27)
-#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL	BIT(26)
+#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK	BIT(26)
 #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN		BIT(25)
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)	((x) << 22)
 #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)	((x) << 20)
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 966688f04741..cd07ceb71601 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -183,7 +183,13 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *hdmi,
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
 			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
 
-	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
+	/*
+	 * NOTE: We have to be careful not to overwrite PHY parent
+	 * clock selection bit and clock divider.
+	 */
+	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
+			   (u32)~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
+			   pll_cfg1_init);
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
 			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
 			   pll_cfg2_init);
@@ -352,6 +358,10 @@ static void sun8i_hdmi_phy_init_h3(struct sun8i_hdmi_phy *phy)
 			   SUN8I_HDMI_PHY_ANA_CFG3_SCLEN |
 			   SUN8I_HDMI_PHY_ANA_CFG3_SDAEN);
 
+	/* reset PLL clock configuration */
+	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, 0);
+	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG, 0);
+
 	/* set HW control of CEC pins */
 	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG, 0);
 
-- 
2.17.1

