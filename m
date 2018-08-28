Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F261DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A041820842
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SXATzYYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A041820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeH1OSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:18:50 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57974 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH1OSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:18:50 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7SARHij079209;
        Tue, 28 Aug 2018 05:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535452037;
        bh=Jdmvrhy+Ymdi4PuDYj5SmpJ/I3pbIvQxNaOIHazFU9g=;
        h=From:To:CC:Subject:Date;
        b=SXATzYYOyKkUxfypLXQTUUVUqU3iVYHl2P6Vf19G0p7sQ69rhPyrk7ScsofzlC1hn
         s5h8NTXJs69xhq/RTSiZPmZExc0EZEYcuvSjL4SlAtoM/BvRK4Ku+68xI3HD9N2p9P
         mJxpM5rzrwX6jZp75vnbWJeibM//r8P38hKvobao=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7SARHTe007893;
        Tue, 28 Aug 2018 05:27:17 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 28
 Aug 2018 05:27:17 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 28 Aug 2018 05:27:17 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7SARCqO024922;
        Tue, 28 Aug 2018 05:27:13 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am65: Change #address-cells and #size-cells of interconnect to 2
Date:   Tue, 28 Aug 2018 15:56:42 +0530
Message-ID: <20180828102642.26482-1-kishon@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM65 has two PCIe controllers and each PCIe controller has '2' address
spaces one within the 4GB address space of the SoC and the other above
the 4GB address space of the SoC in addition to the register space. The
size of the address space above the 4GB SoC address space is 4GB. These
address ranges will be used by CPU/DMA to access the PCIe address space.
In order to represent the address space above the 4GB SoC address space
and to represent the size of this address space as 4GB, change
address-cells and size-cells of interconnect to 2.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 10 +++----
 arch/arm64/boot/dts/ti/k3-am65.dtsi      | 38 ++++++++++++------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 569618b411f0..fbd6fab8dd5e 100644
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
index 17a053552852..5d1eb877e128 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -54,31 +54,31 @@
 
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
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
-				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
-				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
-				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
-				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
-				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
+			ranges = <0x28380000 0x00 0x28380000 0x03880000>, /* MCU NAVSS*/
+				 <0x40200000 0x00 0x40200000 0x00900100>, /* First peripheral window */
+				 <0x42040000 0x00 0x42040000 0x03ac2400>, /* WKUP */
+				 <0x45100000 0x00 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x46000000 0x00 0x46000000 0x00200000>, /* CPSW */
+				 <0x47000000 0x00 0x47000000 0x00068400>; /* OSPI space 1 */
 
 			cbass_wakeup: interconnect@42040000 {
 				compatible = "simple-bus";
-- 
2.18.0

