Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCACC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D79F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GE1NxwD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D79F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbeKTLwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:52:03 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60202 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:52:02 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK1OSWf084611;
        Mon, 19 Nov 2018 19:24:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542677068;
        bh=oKefmNkJUdXXI/3zH4TweOmINTp7T6RTZLRwZwQDIvI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GE1NxwD+j5su1Por6oNJIEd3VDowNoJ2S5ITMxxCNSWvD4xHJupO2NV1UnQvY9j7X
         wWH6aNihUZAmnoWxvLyEAa9Clag8j6fkyYD4iP1/soGMUTOtOdNZwS7rlndxSsBTIT
         Q39kQ+V7WQBZd8ns/VDBMXOPcCKdXwo4DrMWV8vQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK1OSOs000831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 19:24:28 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 19:24:27 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 19:24:27 -0600
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK1OR5Q029717;
        Mon, 19 Nov 2018 19:24:27 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAK1ORx26501;
        Mon, 19 Nov 2018 19:24:27 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3 4/5] phy: mvebu-cp110-comphy: convert to use eth phy mode and submode
Date:   Mon, 19 Nov 2018 19:24:23 -0600
Message-ID: <20181120012424.11802-5-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181120012424.11802-1-grygorii.strashko@ti.com>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mvebu-cp110-comphy PHY driver to use recently introduced
PHY_MODE_ETHERNET and phy_set_mode_ext().

Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 19 +-----
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 90 ++++++++++++++-----------
 2 files changed, 53 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 7a37a37..731793a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1165,28 +1165,13 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
  */
 static int mvpp22_comphy_init(struct mvpp2_port *port)
 {
-	enum phy_mode mode;
 	int ret;
 
 	if (!port->comphy)
 		return 0;
 
-	switch (port->phy_interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		mode = PHY_MODE_SGMII;
-		break;
-	case PHY_INTERFACE_MODE_2500BASEX:
-		mode = PHY_MODE_2500SGMII;
-		break;
-	case PHY_INTERFACE_MODE_10GKR:
-		mode = PHY_MODE_10GKR;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = phy_set_mode(port->comphy, mode);
+	ret = phy_set_mode_ext(port->comphy, PHY_MODE_ETHERNET,
+			       port->phy_interface);
 	if (ret)
 		return ret;
 
diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index 79b52c3..2b4462a 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -9,6 +9,7 @@
 #include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -116,41 +117,43 @@
 
 struct mvebu_comhy_conf {
 	enum phy_mode mode;
+	int submode;
 	unsigned lane;
 	unsigned port;
 	u32 mux;
 };
 
-#define MVEBU_COMPHY_CONF(_lane, _port, _mode, _mux)	\
+#define MVEBU_COMPHY_CONF(_lane, _port, _submode, _mux)	\
 	{						\
 		.lane = _lane,				\
 		.port = _port,				\
-		.mode = _mode,				\
+		.mode = PHY_MODE_ETHERNET,		\
+		.submode = _submode,			\
 		.mux = _mux,				\
 	}
 
 static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
 	/* lane 0 */
-	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
-	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_2500SGMII, 0x1),
+	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_2500BASEX, 0x1),
 	/* lane 1 */
-	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_SGMII, 0x1),
-	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_2500SGMII, 0x1),
+	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
 	/* lane 2 */
-	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_SGMII, 0x1),
-	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_2500SGMII, 0x1),
-	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_10GKR, 0x1),
+	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_2500BASEX, 0x1),
+	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_10GKR, 0x1),
 	/* lane 3 */
-	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_SGMII, 0x2),
-	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_2500SGMII, 0x2),
+	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_SGMII, 0x2),
+	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_2500BASEX, 0x2),
 	/* lane 4 */
-	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_SGMII, 0x2),
-	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_2500SGMII, 0x2),
-	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_10GKR, 0x2),
-	MVEBU_COMPHY_CONF(4, 1, PHY_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_SGMII, 0x2),
+	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_2500BASEX, 0x2),
+	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_10GKR, 0x2),
+	MVEBU_COMPHY_CONF(4, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
 	/* lane 5 */
-	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_SGMII, 0x1),
-	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_2500SGMII, 0x1),
+	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
+	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
 };
 
 struct mvebu_comphy_priv {
@@ -163,10 +166,12 @@ struct mvebu_comphy_lane {
 	struct mvebu_comphy_priv *priv;
 	unsigned id;
 	enum phy_mode mode;
+	int submode;
 	int port;
 };
 
-static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
+static int mvebu_comphy_get_mux(int lane, int port,
+				enum phy_mode mode, int submode)
 {
 	int i, n = ARRAY_SIZE(mvebu_comphy_cp110_modes);
 
@@ -177,7 +182,8 @@ static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
 	for (i = 0; i < n; i++) {
 		if (mvebu_comphy_cp110_modes[i].lane == lane &&
 		    mvebu_comphy_cp110_modes[i].port == port &&
-		    mvebu_comphy_cp110_modes[i].mode == mode)
+		    mvebu_comphy_cp110_modes[i].mode == mode &&
+		    mvebu_comphy_cp110_modes[i].submode == submode)
 			break;
 	}
 
@@ -187,8 +193,7 @@ static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
 	return mvebu_comphy_cp110_modes[i].mux;
 }
 
-static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
-					     enum phy_mode mode)
+static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane)
 {
 	struct mvebu_comphy_priv *priv = lane->priv;
 	u32 val;
@@ -206,14 +211,14 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
 		 MVEBU_COMPHY_SERDES_CFG0_HALF_BUS |
 		 MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xf) |
 		 MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xf));
-	if (mode == PHY_MODE_10GKR)
+	if (lane->submode == PHY_INTERFACE_MODE_10GKR)
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xe) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xe);
-	else if (mode == PHY_MODE_2500SGMII)
+	else if (lane->submode == PHY_INTERFACE_MODE_2500BASEX)
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x8) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x8) |
 		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
-	else if (mode == PHY_MODE_SGMII)
+	else if (lane->submode == PHY_INTERFACE_MODE_SGMII)
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x6) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x6) |
 		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
@@ -243,7 +248,7 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
 	/* refclk selection */
 	val = readl(priv->base + MVEBU_COMPHY_MISC_CTRL0(lane->id));
 	val &= ~MVEBU_COMPHY_MISC_CTRL0_REFCLK_SEL;
-	if (mode == PHY_MODE_10GKR)
+	if (lane->submode == PHY_INTERFACE_MODE_10GKR)
 		val |= MVEBU_COMPHY_MISC_CTRL0_ICP_FORCE;
 	writel(val, priv->base + MVEBU_COMPHY_MISC_CTRL0(lane->id));
 
@@ -261,8 +266,7 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
 	writel(val, priv->base + MVEBU_COMPHY_LOOPBACK(lane->id));
 }
 
-static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane,
-				  enum phy_mode mode)
+static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane)
 {
 	struct mvebu_comphy_priv *priv = lane->priv;
 	u32 val;
@@ -303,13 +307,13 @@ static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane,
 	return 0;
 }
 
-static int mvebu_comphy_set_mode_sgmii(struct phy *phy, enum phy_mode mode)
+static int mvebu_comphy_set_mode_sgmii(struct phy *phy)
 {
 	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
 	struct mvebu_comphy_priv *priv = lane->priv;
 	u32 val;
 
-	mvebu_comphy_ethernet_init_reset(lane, mode);
+	mvebu_comphy_ethernet_init_reset(lane);
 
 	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
 	val &= ~MVEBU_COMPHY_RX_CTRL1_CLK8T_EN;
@@ -330,7 +334,7 @@ static int mvebu_comphy_set_mode_sgmii(struct phy *phy, enum phy_mode mode)
 	val |= MVEBU_COMPHY_GEN1_S0_TX_EMPH(0x1);
 	writel(val, priv->base + MVEBU_COMPHY_GEN1_S0(lane->id));
 
-	return mvebu_comphy_init_plls(lane, PHY_MODE_SGMII);
+	return mvebu_comphy_init_plls(lane);
 }
 
 static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
@@ -339,7 +343,7 @@ static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
 	struct mvebu_comphy_priv *priv = lane->priv;
 	u32 val;
 
-	mvebu_comphy_ethernet_init_reset(lane, PHY_MODE_10GKR);
+	mvebu_comphy_ethernet_init_reset(lane);
 
 	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
 	val |= MVEBU_COMPHY_RX_CTRL1_RXCLK2X_SEL |
@@ -469,7 +473,7 @@ static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
 	val |= MVEBU_COMPHY_EXT_SELV_RX_SAMPL(0x1a);
 	writel(val, priv->base + MVEBU_COMPHY_EXT_SELV(lane->id));
 
-	return mvebu_comphy_init_plls(lane, PHY_MODE_10GKR);
+	return mvebu_comphy_init_plls(lane);
 }
 
 static int mvebu_comphy_power_on(struct phy *phy)
@@ -479,7 +483,8 @@ static int mvebu_comphy_power_on(struct phy *phy)
 	int ret, mux;
 	u32 val;
 
-	mux = mvebu_comphy_get_mux(lane->id, lane->port, lane->mode);
+	mux = mvebu_comphy_get_mux(lane->id, lane->port,
+				   lane->mode, lane->submode);
 	if (mux < 0)
 		return -ENOTSUPP;
 
@@ -492,12 +497,12 @@ static int mvebu_comphy_power_on(struct phy *phy)
 	val |= mux << MVEBU_COMPHY_SELECTOR_PHY(lane->id);
 	regmap_write(priv->regmap, MVEBU_COMPHY_SELECTOR, val);
 
-	switch (lane->mode) {
-	case PHY_MODE_SGMII:
-	case PHY_MODE_2500SGMII:
-		ret = mvebu_comphy_set_mode_sgmii(phy, lane->mode);
+	switch (lane->submode) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		ret = mvebu_comphy_set_mode_sgmii(phy);
 		break;
-	case PHY_MODE_10GKR:
+	case PHY_INTERFACE_MODE_10GKR:
 		ret = mvebu_comphy_set_mode_10gkr(phy);
 		break;
 	default:
@@ -517,10 +522,17 @@ static int mvebu_comphy_set_mode(struct phy *phy,
 {
 	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
 
-	if (mvebu_comphy_get_mux(lane->id, lane->port, mode) < 0)
+	if (mode != PHY_MODE_ETHERNET)
+		return -EINVAL;
+
+	if (submode == PHY_INTERFACE_MODE_1000BASEX)
+		submode = PHY_INTERFACE_MODE_SGMII;
+
+	if (mvebu_comphy_get_mux(lane->id, lane->port, mode, submode) < 0)
 		return -EINVAL;
 
 	lane->mode = mode;
+	lane->submode = submode;
 	return 0;
 }
 
-- 
2.10.5

