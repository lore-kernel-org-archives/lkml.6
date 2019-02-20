Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE16C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAFB2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UPbq++Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfBTP0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:26:19 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43024 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBTP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:26:14 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KFQ7P3127287;
        Wed, 20 Feb 2019 09:26:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550676367;
        bh=ZFTu1cJyEVVxnhkDc9dv5bVTCgTlym42DjxwxaOL2Fg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UPbq++DzvRcg8D1oGK5QsVVe5YKVOcEX1VOS2aG7hZcfvlBuugiWz8W196ZEC1DsG
         9i5cyJsB+Av8liaReXVyaAofNa+awjNt4l0HecLH84Bf48X1x9239JRyjp5iye7AOn
         8y/cNiPArrS/3Lr2lzjwxGCwo09AdvKoJKj2yLgg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KFQ75q115746
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 09:26:07 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 09:26:07 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 09:26:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KFQ6tU009828;
        Wed, 20 Feb 2019 09:26:06 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
Date:   Wed, 20 Feb 2019 17:25:19 +0200
Message-ID: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate cpsw-phy-sel driver as it's been replaced with new
TI phy-gmii-sel PHY driver.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Kconfig | 6 +++---
 drivers/net/ethernet/ti/cpsw.h  | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index bb126be1eb72..8b21b40a9fe5 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -49,10 +49,11 @@ config TI_DAVINCI_CPDMA
 	  will be called davinci_cpdma.  This is recommended.
 
 config TI_CPSW_PHY_SEL
-	bool
+	bool "TI CPSW Phy mode Selection (DEPRECATED)"
+	default n
 	---help---
 	  This driver supports configuring of the phy mode connected to
-	  the CPSW.
+	  the CPSW. DEPRECATED: use PHY_TI_GMII_SEL.
 
 config TI_CPSW_ALE
 	tristate "TI CPSW ALE Support"
@@ -64,7 +65,6 @@ config TI_CPSW
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
 	select TI_DAVINCI_CPDMA
 	select TI_DAVINCI_MDIO
-	select TI_CPSW_PHY_SEL
 	select TI_CPSW_ALE
 	select MFD_SYSCON
 	select REGMAP
diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index cf111db3dc27..907e05fc22e4 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -21,7 +21,13 @@
 			 ((mac)[2] << 16) | ((mac)[3] << 24))
 #define mac_lo(mac)	(((mac)[4] << 0) | ((mac)[5] << 8))
 
+#if IS_ENABLED(CONFIG_TI_CPSW_PHY_SEL)
 void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave);
+#else
+static inline
+void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave)
+{}
+#endif
 int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr);
 
 #endif /* __CPSW_H__ */
-- 
2.17.1

