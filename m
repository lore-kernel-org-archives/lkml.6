Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB1FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FEF2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ciEIpdWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FEF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeKZLIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:08:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41988 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeKZLIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:08:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ0FZ7f042459;
        Sun, 25 Nov 2018 18:15:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543191335;
        bh=LdDVBQDPrXpSqnm+KHgQPiIxy1AsjEdjCNb6I+3CUPw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ciEIpdWc1aUNx0Nm1nDylcnZ3Xq054xpEuSXiwospvjlg3PqWygUAAsoeB5U5C0v0
         aPQU33/QdT3PbVtNZvwsJ45p7Nta7nGbRy8bqZOKTHNQrWsHS56rEBHNAIKoSKyifG
         RBlD8KKksFelUul6OG6El9aES1M3qzG//CQTfJFI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ0FZfl101851
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 18:15:35 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 25
 Nov 2018 18:15:34 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 25 Nov 2018 18:15:34 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ0FYKf010624;
        Sun, 25 Nov 2018 18:15:34 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAQ0FYU04366;
        Sun, 25 Nov 2018 18:15:34 -0600 (CST)
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
Subject: [PATCH linux-next 08/10] ARM: dts: am335x: switch to use phy-gmii-sel
Date:   Sun, 25 Nov 2018 18:15:29 -0600
Message-ID: <20181126001531.12974-9-grygorii.strashko@ti.com>
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

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am335x-baltos-ir2110.dts        |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir3220.dts        |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir5221.dts        |  4 ----
 arch/arm/boot/dts/am335x-chiliboard.dts           |  4 ----
 arch/arm/boot/dts/am335x-icev2.dts                |  4 ----
 arch/arm/boot/dts/am335x-igep0033.dtsi            |  4 ----
 arch/arm/boot/dts/am335x-lxm.dts                  |  4 ----
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi |  5 -----
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts    |  5 -----
 arch/arm/boot/dts/am335x-phycore-som.dtsi         |  4 ----
 arch/arm/boot/dts/am33xx-l4.dtsi                  | 15 ++++++++-------
 11 files changed, 8 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
index 75de1e7..50dcf12 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir2110.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
@@ -72,7 +72,3 @@
 	dual_emac_res_vlan = <2>;
 	phy-handle = <&phy1>;
 };
-
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index 1b215c4..f3f1abd 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -114,7 +114,3 @@
 	dual_emac_res_vlan = <2>;
 	phy-handle = <&phy1>;
 };
-
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 832ead8..42f473f 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -133,10 +133,6 @@
 	phy-handle = <&phy1>;
 };
 
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
-
 &dcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dcan1_pins>;
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
index 9c2a947..4a86953 100644
--- a/arch/arm/boot/dts/am335x-chiliboard.dts
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -151,10 +151,6 @@
 	phy-mode = "rmii";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 /* USB */
 &usb {
 	status = "okay";
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index f2005ec..9ac775c 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -484,10 +484,6 @@
 	dual_emac;
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 &davinci_mdio {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&davinci_mdio_default>;
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 55b4c94..cbd22f2 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -123,10 +123,6 @@
 	phy-mode = "rmii";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 &elm {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index 481edcf..d0e8e72 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -328,10 +328,6 @@
 	dual_emac_res_vlan = <3>;
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 &mac {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&cpsw_default>;
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
index 14f7819..cb5913a 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -159,11 +159,6 @@
 	status = "okay";
 };
 
-&phy_sel {
-	reg= <0x44e10650 0xf5>;
-	rmii-clock-ext;
-};
-
 &sham {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
index 5a58efc..e562ce4 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -446,11 +446,6 @@
 	dual_emac_res_vlan = <2>;
 };
 
-&phy_sel {
-	reg= <0x44e10650 0xf5>;
-	rmii-clock-ext;
-};
-
 &sham {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 428a25e..015adb6 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -100,10 +100,6 @@
 	status = "okay";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 /* I2C Busses */
 &am33xx_pinmux {
 	i2c0_pins: pinmux_i2c0 {
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 918bf57..d9aacb5 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -279,12 +279,6 @@
 				#pinctrl-cells = <1>;
 				ranges = <0 0 0x2000>;
 
-				phy_sel: cpsw-phy-sel@650 {
-					compatible = "ti,am3352-cpsw-phy-sel";
-					reg= <0x650 0x4>;
-					reg-names = "gmii-sel";
-				};
-
 				am33xx_pinmux: pinmux@800 {
 					compatible = "pinctrl-single";
 					reg = <0x800 0x238>;
@@ -302,6 +296,12 @@
 					#size-cells = <1>;
 					ranges = <0 0 0x800>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,am3352-phy-gmii-sel";
+						reg = <0x650 0x4>;
+						#phy-cells = <2>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -717,7 +717,6 @@
 				interrupts = <40 41 42 43>;
 				ranges = <0 0 0x8000>;
 				syscon = <&scm_conf>;
-				cpsw-phy-sel = <&phy_sel>;
 				status = "disabled";
 
 				davinci_mdio: mdio@1000 {
@@ -733,11 +732,13 @@
 				cpsw_emac0: slave@200 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 1 1>;
 				};
 
 				cpsw_emac1: slave@300 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 2 1>;
 				};
 			};
 		};
-- 
2.10.5

