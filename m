Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F9C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3F920879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078417;
	bh=Yq+Y/7x/mLk8L1iI5DI9wmAN0IphjDGvyqqJpeMJrB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O8NtFzRRKyQ6hLBWKTz3Kr+CvWZf6zTFwptC8Vts/YLJg1/iMvm++5QjVkciJLUbJ
	 NJdKDdW+bXKG0WYxdlclxrhQFrtxgHnNKKkw4XuCUYBw0Hrm4/vlkhmHVXT+nUAbNE
	 aDKyg67hO6XdeTUgZTghAI0Cgzj2/v8rSU0JbWSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfAUNqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbfAUNqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:46:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED7D20870;
        Mon, 21 Jan 2019 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078411;
        bh=Yq+Y/7x/mLk8L1iI5DI9wmAN0IphjDGvyqqJpeMJrB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6DOHqDVs1+G54JmY5cURD5DOhALXzh9Bpk/9s4PqTSxlA7aUfm4kr1fxP+c4PywH
         OhsoG2PZUmIPxGmUJET58x6T7/LeJxgtDtXF4gwC+935CdlDT2jpWnc3LkXb1hF2t7
         cD8zk2jeShN7ayq1B3/aGN2mt/JfJSv7OwXr9n2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Camelia Groza <camelia.groza@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 023/111] net: phy: Add missing features to PHY drivers
Date:   Mon, 21 Jan 2019 14:42:17 +0100
Message-Id: <20190121122458.357769671@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 9e857a40dc4eba15a739b4194d7db873d82c28a0 ]

The bcm87xx and micrel driver has PHYs which are missing the .features
value. Add them. The bcm87xx is a 10G FEC only PHY. Add the needed
features definition of this PHY.

Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
Reported-by: Scott Wood <oss@buserror.net>
Reported-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/bcm87xx.c    |    2 ++
 drivers/net/phy/micrel.c     |    1 +
 drivers/net/phy/phy_device.c |   12 ++++++++++++
 include/linux/phy.h          |    2 ++
 4 files changed, 17 insertions(+)

--- a/drivers/net/phy/bcm87xx.c
+++ b/drivers/net/phy/bcm87xx.c
@@ -193,6 +193,7 @@ static struct phy_driver bcm87xx_driver[
 	.phy_id		= PHY_ID_BCM8706,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Broadcom BCM8706",
+	.features	= PHY_10GBIT_FEC_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm87xx_config_init,
 	.config_aneg	= bcm87xx_config_aneg,
@@ -205,6 +206,7 @@ static struct phy_driver bcm87xx_driver[
 	.phy_id		= PHY_ID_BCM8727,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Broadcom BCM8727",
+	.features	= PHY_10GBIT_FEC_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm87xx_config_init,
 	.config_aneg	= bcm87xx_config_aneg,
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1105,6 +1105,7 @@ static struct phy_driver ksphy_driver[]
 	.phy_id		= PHY_ID_KSZ8873MLL,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ8873MLL Switch",
+	.features	= PHY_BASIC_FEATURES,
 	.config_init	= kszphy_config_init,
 	.config_aneg	= ksz8873mll_config_aneg,
 	.read_status	= ksz8873mll_read_status,
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -61,6 +61,9 @@ EXPORT_SYMBOL_GPL(phy_gbit_all_ports_fea
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_10gbit_features);
 
+__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_fec_features) __ro_after_init;
+EXPORT_SYMBOL_GPL(phy_10gbit_fec_features);
+
 static const int phy_basic_ports_array[] = {
 	ETHTOOL_LINK_MODE_Autoneg_BIT,
 	ETHTOOL_LINK_MODE_TP_BIT,
@@ -102,6 +105,11 @@ static const int phy_10gbit_features_arr
 	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
 };
 
+const int phy_10gbit_fec_features_array[1] = {
+	ETHTOOL_LINK_MODE_10000baseR_FEC_BIT,
+};
+EXPORT_SYMBOL_GPL(phy_10gbit_fec_features_array);
+
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_10gbit_full_features);
 
@@ -184,6 +192,10 @@ static void features_init(void)
 	linkmode_set_bit_array(phy_10gbit_full_features_array,
 			       ARRAY_SIZE(phy_10gbit_full_features_array),
 			       phy_10gbit_full_features);
+	/* 10G FEC only */
+	linkmode_set_bit_array(phy_10gbit_fec_features_array,
+			       ARRAY_SIZE(phy_10gbit_fec_features_array),
+			       phy_10gbit_fec_features);
 }
 
 void phy_device_free(struct phy_device *phydev)
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -48,6 +48,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_fibre_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_all_ports_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_features) __ro_after_init;
+extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_fec_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_init;
 
 #define PHY_BASIC_FEATURES ((unsigned long *)&phy_basic_features)
@@ -56,6 +57,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(
 #define PHY_GBIT_FIBRE_FEATURES ((unsigned long *)&phy_gbit_fibre_features)
 #define PHY_GBIT_ALL_PORTS_FEATURES ((unsigned long *)&phy_gbit_all_ports_features)
 #define PHY_10GBIT_FEATURES ((unsigned long *)&phy_10gbit_features)
+#define PHY_10GBIT_FEC_FEATURES ((unsigned long *)&phy_10gbit_fec_features)
 #define PHY_10GBIT_FULL_FEATURES ((unsigned long *)&phy_10gbit_full_features)
 
 /*


