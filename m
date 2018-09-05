Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F06C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C832077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KCX8rHaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C832077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeIEPsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:48:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52288 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIEPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:47:59 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w85BHkwL117898;
        Wed, 5 Sep 2018 06:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536146266;
        bh=DVEufoPFXoh+RaEiKBcVe+3CEBbJ1YoIgnRL/SGs6FA=;
        h=From:To:CC:Subject:Date;
        b=KCX8rHaHN8nZa2Teeo3vo/iWdMbbAHEAJYwr44+OKSFID710WRe7ZwTn0X69BmGzm
         L4k4flrfBtIEwqH6/zTUD4j+fNEOeZ0TEpfvzogRmQsPUKPb3qZyGxdnfIXwsSWXvE
         2qc+GcUEKBia3NwCc3jyKB4sR8EqnsfdAm6i7yLA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85BHkTY002965;
        Wed, 5 Sep 2018 06:17:46 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 5 Sep
 2018 06:17:46 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 5 Sep 2018 06:17:46 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85BHgRC018099;
        Wed, 5 Sep 2018 06:17:42 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh R <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-am65: Change #address-cells and #size-cells of interconnect to 2
Date:   Wed, 5 Sep 2018 16:47:38 +0530
Message-ID: <20180905111738.8280-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM65 has two PCIe controllers and each PCIe controller has '2' address
spaces one within the 4GB address space of the SoC and the other above
the 4GB address space of the SoC (cbass_main) in addition to the
register space. The size of the address space above the 4GB SoC address
space is 4GB. These address ranges will be used by CPU/DMA to access
the PCIe address space. In order to represent the address space above
the 4GB SoC address space and to represent the size of this address
space as 4GB, change address-cells and size-cells of interconnect to 2.

Since OSPI has similar need in MCU Domain Memory Map, change
address-cells and size-cells of cbass_mcu interconnect also to 2.

Fixes: ea47eed33a3fe3d919 ("arm64: dts: ti: Add Support for AM654 SoC")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Vignesh R <vigneshr@ti.com>
---
Changes from v2:
Added Fixes tag.

Changes from v1:
Changed address-cells and size-cells of cbass_mcu to "2" since OSPI has
a region of size 4GB above the 4GB space.
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 10 +++---
 arch/arm64/boot/dts/ti/k3-am65.dtsi      | 44 ++++++++++++------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 2409344df4fa..faace3805c01 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -8,13 +8,13 @@
 &cbass_main {
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		ranges;
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x01800000 0x10000>,	/* GICD */
-		      <0x01880000 0x90000>;	/* GICR */
+		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
+		      <0x00 0x01880000 0x00 0x90000>;	/* GICR */
 		/*
 		 * vcpumntirq:
 		 * virtual CPU interface maintenance interrupt
@@ -23,7 +23,7 @@
 
 		gic_its: gic-its@18200000 {
 			compatible = "arm,gic-v3-its";
-			reg = <0x01820000 0x10000>;
+			reg = <0x00 0x01820000 0x00 0x10000>;
 			msi-controller;
 			#msi-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index cede1fa0983c..ded364d20835 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -46,38 +46,38 @@
 
 	cbass_main: interconnect@100000 {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00100000 0x00 0x00100000 0x00020000>, /* ctrl mmr */
-			 <0x00600000 0x00 0x00600000 0x00001100>, /* GPIO */
-			 <0x00900000 0x00 0x00900000 0x00012000>, /* serdes */
-			 <0x01000000 0x00 0x01000000 0x0af02400>, /* Most peripherals */
-			 <0x30800000 0x00 0x30800000 0x0bc00000>, /* MAIN NAVSS */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
+			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
+			 <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>, /* MAIN NAVSS */
 			 /* MCUSS Range */
-			 <0x28380000 0x00 0x28380000 0x03880000>,
-			 <0x40200000 0x00 0x40200000 0x00900100>,
-			 <0x42040000 0x00 0x42040000 0x03ac2400>,
-			 <0x45100000 0x00 0x45100000 0x00c24000>,
-			 <0x46000000 0x00 0x46000000 0x00200000>,
-			 <0x47000000 0x00 0x47000000 0x00068400>;
+			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
+			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00900100>,
+			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
+			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
+			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
+			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>;
 
 		cbass_mcu: interconnect@28380000 {
 			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
-				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
-				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
-				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
-				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
-				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
+				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00900100>, /* First peripheral window */
+				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP */
+				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
+				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>; /* OSPI space 1 */
 
 			cbass_wakeup: interconnect@42040000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				/* WKUP  Basic peripherals */
-				ranges = <0x42040000 0x42040000 0x03ac2400>;
+				ranges = <0x42040000 0x00 0x42040000 0x03ac2400>;
 			};
 		};
 	};
-- 
2.17.1

