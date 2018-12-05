Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC74C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820CA2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZLR/45U4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820CA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeLEPDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:03:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47986 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeLEPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:03:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB5F3fYw081786;
        Wed, 5 Dec 2018 09:03:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544022221;
        bh=7zc/aeUK4/I38VepvGBAxbd/CRUK7BxkBTM7szegQfc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZLR/45U4K/7wSbK7yu53QF+yqnxthiYJHgUaBEl289MToEmyd+ZDa9bNGcUChX2vJ
         PwZ9eL2sABeHPNbVN8OsN8Fp15Ng0EEDSTnafbINYdrQZ2Aord9EKfx01K9fcGPI/q
         CBu+QWg+8HdK1q/VzmGGKpkTLUOZhYkwQPdTm4eI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB5F3fb8069593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 09:03:41 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 09:03:39 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 09:03:39 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5F3dve002336;
        Wed, 5 Dec 2018 09:03:39 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.247])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5F3S9u023981;
        Wed, 5 Dec 2018 09:03:37 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/4] phy: ti: usb2: Add support for AM654 USB2 PHY
Date:   Wed, 5 Dec 2018 17:03:26 +0200
Message-ID: <1544022206-2300-5-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544022206-2300-1-git-send-email-rogerq@ti.com>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the USB2 PHY on the AM654 SoC.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/ti/Kconfig         |  4 ++--
 drivers/phy/ti/phy-omap-usb2.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 4fdbe06..a55959b 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -33,11 +33,11 @@ config OMAP_CONTROL_PHY
 
 config OMAP_USB2
 	tristate "OMAP USB2 PHY Driver"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS || ARCH_K3
 	depends on USB_SUPPORT
 	select GENERIC_PHY
 	select USB_PHY
-	select OMAP_CONTROL_PHY
+	select OMAP_CONTROL_PHY if ARCH_OMAP2PLUS
 	help
 	  Enable this to support the transceiver that is part of SOC. This
 	  driver takes care of all the PHY functionality apart from comparator.
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 418e7f1..e871f29 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -36,6 +36,10 @@
 #define USB2PHY_DISCON_BYP_LATCH (1 << 31)
 #define USB2PHY_ANA_CONFIG1 0x4c
 
+#define AM654_USB2_OTG_PD		BIT(8)
+#define AM654_USB2_VBUS_DET_EN		BIT(5)
+#define AM654_USB2_VBUSVALID_DET_EN	BIT(4)
+
 /**
  * omap_usb2_set_comparator - links the comparator present in the sytem with
  *	this phy
@@ -245,6 +249,15 @@ static const struct usb_phy_data am437x_usb2_data = {
 	.power_off = AM437X_USB2_PHY_PD | AM437X_USB2_OTG_PD,
 };
 
+static const struct usb_phy_data am654_usb2_data = {
+	.label = "am654_usb2",
+	.flags = OMAP_USB2_CALIBRATE_FALSE_DISCONNECT,
+	.mask = AM654_USB2_OTG_PD | AM654_USB2_VBUS_DET_EN |
+		AM654_USB2_VBUSVALID_DET_EN,
+	.power_on = AM654_USB2_VBUS_DET_EN | AM654_USB2_VBUSVALID_DET_EN,
+	.power_off = AM654_USB2_OTG_PD,
+};
+
 static const struct of_device_id omap_usb2_id_table[] = {
 	{
 		.compatible = "ti,omap-usb2",
@@ -266,6 +279,10 @@ static const struct of_device_id omap_usb2_id_table[] = {
 		.compatible = "ti,am437x-usb2",
 		.data = &am437x_usb2_data,
 	},
+	{
+		.compatible = "ti,am654-usb2",
+		.data = &am654_usb2_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_usb2_id_table);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

