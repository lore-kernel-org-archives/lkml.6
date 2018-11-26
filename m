Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3051DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0359D2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0359D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbeKZLI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:08:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51986 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeKZLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:08:25 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ0FZ6P097212;
        Sun, 25 Nov 2018 18:15:35 -0600
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ0FZl5020867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 18:15:35 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 25
 Nov 2018 18:15:35 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 25 Nov 2018 18:15:35 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ0FZLK010640;
        Sun, 25 Nov 2018 18:15:35 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAQ0FZU04374;
        Sun, 25 Nov 2018 18:15:35 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 10/10] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
Date:   Sun, 25 Nov 2018 18:15:31 -0600
Message-ID: <20181126001531.12974-11-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate cpsw-phy-sel driver as it's been replaced with new
TI phy-gmii-sel PHY driver.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Kconfig | 6 +++---
 drivers/net/ethernet/ti/cpsw.h  | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index f932923..96415da 100644
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
index cf111db..907e05fc 100644
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
2.10.5

