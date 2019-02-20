Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D26DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055AF2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TTGa4ki9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfBTP0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:26:47 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43018 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBTP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:26:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KFQ4M5127263;
        Wed, 20 Feb 2019 09:26:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550676364;
        bh=MlJ1Ct4/G7vc0vGnmopDdnlbzOaq/tosiy3N86uCRBg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TTGa4ki9oYsY8jCrpkbXvJkLxlxnTnAUuotFzVUmIUXXGOZEjuF+J7nWSY5k9g9Ca
         kkc/mkxdWyGkIqP/icgVUlKzGz/6kW+fYbvT8nPUGv5FqSLstAwZVof2cG2vbca25D
         0vTNtTU+RhcnQBLu3s9ycoR8BLef4usLHGR5oyDo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KFQ3ut070209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 09:26:04 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 09:26:02 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 09:26:02 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KFQ1rt009519;
        Wed, 20 Feb 2019 09:26:02 -0600
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
Subject: [PATCH 3/6] ARM: dts: am4372: switch to use phy-gmii-sel
Date:   Wed, 20 Feb 2019 17:25:16 +0200
Message-ID: <1550676319-6440-4-git-send-email-grygorii.strashko@ti.com>
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

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am437x-l4.dtsi     | 17 +++++++++--------
 arch/arm/boot/dts/am43x-epos-evm.dts |  5 +----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index ca0896f80248..85c6f4ff1824 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -280,12 +280,6 @@
 				#size-cells = <1>;
 				ranges = <0 0 0x4000>;
 
-				phy_sel: cpsw-phy-sel@650 {
-					compatible = "ti,am43xx-cpsw-phy-sel";
-					reg= <0x650 0x4>;
-					reg-names = "gmii-sel";
-				};
-
 				am43xx_pinmux: pinmux@800 {
 					compatible = "ti,am437-padconf",
 						     "pinctrl-single";
@@ -300,11 +294,17 @@
 				};
 
 				scm_conf: scm_conf@0 {
-					compatible = "syscon";
+					compatible = "syscon", "simple-bus";
 					reg = <0x0 0x800>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,am43xx-phy-gmii-sel";
+						reg = <0x650 0x4>;
+						#phy-cells = <2>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -555,7 +555,6 @@
 				cpts_clock_shift = <29>;
 				ranges = <0 0 0x8000>;
 				syscon = <&scm_conf>;
-				cpsw-phy-sel = <&phy_sel>;
 
 				davinci_mdio: mdio@1000 {
 					compatible = "ti,am4372-mdio","ti,cpsw-mdio","ti,davinci_mdio";
@@ -572,11 +571,13 @@
 				cpsw_emac0: slave@200 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 1 0>;
 				};
 
 				cpsw_emac1: slave@300 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 2 0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 4ea753b3ee43..9dfd80e3b76e 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -584,10 +584,7 @@
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
 	phy-mode = "rmii";
-};
-
-&phy_sel {
-	rmii-clock-ext;
+	phys = <&phy_gmii_sel 1 1>;
 };
 
 &i2c0 {
-- 
2.17.1

