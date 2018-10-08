Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C15C6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AFA2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r2c6fYl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AFA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJIHEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:04:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53464 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeJIHEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:04:08 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98Nns1O030760;
        Mon, 8 Oct 2018 18:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539042594;
        bh=85hfGuh+Ks3roiNMaMUxBKOuiJrYoqG3YSSqK90z+B4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=r2c6fYl7FIF2X0wiTSi6FbhsX+7epjDRSA3VwO6MchS1FytTZ4Vicdrqw7ET4bX7F
         5HKIQtqSBU2coY1262+9iTPIPlkozf4i3Wz7oXES/O4Z7gIJ/XqB13UiXnGkDN/55G
         tXTB+cp+wEjPoBM6KEDATRh/FFObMnz1j9m0jqM0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98NnsKV023979;
        Mon, 8 Oct 2018 18:49:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 18:49:54 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 18:49:54 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98NnrAw027756;
        Mon, 8 Oct 2018 18:49:53 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w98Nnrx25252;
        Mon, 8 Oct 2018 18:49:53 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 11/11] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
Date:   Mon, 8 Oct 2018 18:49:49 -0500
Message-ID: <20181008234949.15416-12-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181008234949.15416-1-grygorii.strashko@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
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

