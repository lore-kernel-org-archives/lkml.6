Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92906C6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D5720C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QUoLjsty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D5720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeJIHEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:04:07 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53458 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeJIHEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:04:07 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98Nnr4k030754;
        Mon, 8 Oct 2018 18:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539042593;
        bh=wL/p1xowDla28x2ETkZQaanZgPfzVV7FK2duJyx2Hj8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QUoLjstymZE+n7xFOV3u2vuoN3pC5niUO/ohe6uDCHCesfehhYtVcAEV+REasHvWn
         oFKi7knHhtTenZAgdpjO1TAA9Wykv5iw+P4QAHq4nvo+YnlRZ9UYBd9Zpb8ckM49Nf
         p7Wcma7wIfR2O1mN/bMfN05YMZ5sZB9UlvbqoFXk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98Nnr4u023976;
        Mon, 8 Oct 2018 18:49:53 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 18:49:53 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 18:49:53 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98NnrAW031134;
        Mon, 8 Oct 2018 18:49:53 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w98Nnrx25244;
        Mon, 8 Oct 2018 18:49:53 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 09/11] ARM: dts: am335x: switch to use phy-gmii-sel
Date:   Mon, 8 Oct 2018 18:49:47 -0500
Message-ID: <20181008234949.15416-10-grygorii.strashko@ti.com>
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

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am335x-baltos-ir2110.dts     |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir3220.dts     |  3 ---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts     |  3 ---
 arch/arm/boot/dts/am335x-chiliboard.dts        |  3 ---
 arch/arm/boot/dts/am335x-icev2.dts             |  4 ----
 arch/arm/boot/dts/am335x-igep0033.dtsi         |  3 ---
 arch/arm/boot/dts/am335x-lxm.dts               |  3 ---
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts |  5 -----
 arch/arm/boot/dts/am335x-phycore-som.dtsi      |  3 ---
 arch/arm/boot/dts/am33xx.dtsi                  | 14 ++++++++------
 10 files changed, 8 insertions(+), 37 deletions(-)

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
index 1b215c4..44f7858 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -115,6 +115,3 @@
 	phy-handle = <&phy1>;
 };
 
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 832ead8..1e10813 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -133,9 +133,6 @@
 	phy-handle = <&phy1>;
 };
 
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
 
 &dcan1 {
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
index 59431b2..7b77315 100644
--- a/arch/arm/boot/dts/am335x-chiliboard.dts
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -147,9 +147,6 @@
 	phy-mode = "rmii";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
 
 /* USB */
 &usb {
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
index a5769a8..2bc8456 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -114,9 +114,6 @@
 	phy-mode = "rmii";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
 
 &elm {
 	status = "okay";
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index 1d6c6fa..56b354b1 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -328,9 +328,6 @@
 	dual_emac_res_vlan = <3>;
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
 
 &mac {
 	pinctrl-names = "default", "sleep";
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
index f82233c..5563e92 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -438,11 +438,6 @@
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
index 428a25e..cf40a2b 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -100,9 +100,6 @@
 	status = "okay";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
 
 /* I2C Busses */
 &am33xx_pinmux {
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index d3dd6a1..3179b24 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -222,6 +222,12 @@
 					#size-cells = <1>;
 					ranges = <0 0 0x800>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,am3352-phy-gmii-sel";
+						syscon-scm = <&scm_conf>;
+						#phy-cells = <2>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -890,17 +896,13 @@
 			cpsw_emac0: slave@4a100200 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
+				phys = <&phy_gmii_sel 1 1>;
 			};
 
 			cpsw_emac1: slave@4a100300 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
-			};
-
-			phy_sel: cpsw-phy-sel@44e10650 {
-				compatible = "ti,am3352-cpsw-phy-sel";
-				reg= <0x44e10650 0x4>;
-				reg-names = "gmii-sel";
+				phys = <&phy_gmii_sel 2 1>;
 			};
 		};
 
-- 
2.10.5

