Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEVJmt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:42:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49745 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbeEVJlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:41:06 -0400
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Haim Boot <hayim@marvell.com>,
        Hanna Hawa <hannah@marvell.com>, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 15/16] arm64: dts: marvell: use new bindings for CP110 interrupts
Date: Tue, 22 May 2018 11:40:41 +0200
Message-Id: <20180522094042.24770-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an ICU subnode for the NSR interrupts. This subnode becomes the
CP110 interrupt parent, removing the need for the ICU_GRP_NSR parameter.
Move all DT110 nodes to use these new bindings.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 114 +++++++++++++-------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 9fa41c54f69c..5637ff2601c9 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -25,7 +25,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	compatible = "simple-bus";
-	interrupt-parent = <&CP110_LABEL(icu)>;
+	interrupt-parent = <&CP110_LABEL(icu_nsr)>;
 	ranges;
 
 	config-space@CP110_BASE {
@@ -46,12 +46,12 @@
 			dma-coherent;
 
 			CP110_LABEL(eth0): eth0 {
-				interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <39 IRQ_TYPE_LEVEL_HIGH>,
+					     <43 IRQ_TYPE_LEVEL_HIGH>,
+					     <47 IRQ_TYPE_LEVEL_HIGH>,
+					     <51 IRQ_TYPE_LEVEL_HIGH>,
+					     <55 IRQ_TYPE_LEVEL_HIGH>,
+					     <129 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
 					"tx-cpu3", "rx-shared", "link";
 				port-id = <0>;
@@ -60,12 +60,12 @@
 			};
 
 			CP110_LABEL(eth1): eth1 {
-				interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <40 IRQ_TYPE_LEVEL_HIGH>,
+					     <44 IRQ_TYPE_LEVEL_HIGH>,
+					     <48 IRQ_TYPE_LEVEL_HIGH>,
+					     <52 IRQ_TYPE_LEVEL_HIGH>,
+					     <56 IRQ_TYPE_LEVEL_HIGH>,
+					     <128 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
 					"tx-cpu3", "rx-shared", "link";
 				port-id = <1>;
@@ -74,12 +74,12 @@
 			};
 
 			CP110_LABEL(eth2): eth2 {
-				interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <41 IRQ_TYPE_LEVEL_HIGH>,
+					     <45 IRQ_TYPE_LEVEL_HIGH>,
+					     <49 IRQ_TYPE_LEVEL_HIGH>,
+					     <53 IRQ_TYPE_LEVEL_HIGH>,
+					     <57 IRQ_TYPE_LEVEL_HIGH>,
+					     <127 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
 					"tx-cpu3", "rx-shared", "link";
 				port-id = <2>;
@@ -147,16 +147,20 @@
 		CP110_LABEL(icu): interrupt-controller@1e0000 {
 			compatible = "marvell,cp110-icu";
 			reg = <0x1e0000 0x440>;
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			msi-parent = <&gicp>;
+
+			CP110_LABEL(icu_nsr): icu-nsr {
+				compatible = "marvell,cp110-icu-nsr";
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				msi-parent = <&gicp>;
+			};
 		};
 
 		CP110_LABEL(rtc): rtc@284000 {
 			compatible = "marvell,armada-8k-rtc";
 			reg = <0x284000 0x20>, <0x284080 0x24>;
 			reg-names = "rtc", "rtc-soc";
-			interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <77 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		CP110_LABEL(thermal): thermal@400078 {
@@ -182,10 +186,10 @@
 				#gpio-cells = <2>;
 				gpio-ranges = <&CP110_LABEL(pinctrl) 0 0 32>;
 				interrupt-controller;
-				interrupts = <ICU_GRP_NSR 86 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 85 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 84 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 83 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <86 IRQ_TYPE_LEVEL_HIGH>,
+					     <85 IRQ_TYPE_LEVEL_HIGH>,
+					     <84 IRQ_TYPE_LEVEL_HIGH>,
+					     <83 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
@@ -197,10 +201,10 @@
 				#gpio-cells = <2>;
 				gpio-ranges = <&CP110_LABEL(pinctrl) 0 32 31>;
 				interrupt-controller;
-				interrupts = <ICU_GRP_NSR 82 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 81 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 80 IRQ_TYPE_LEVEL_HIGH>,
-					<ICU_GRP_NSR 79 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <82 IRQ_TYPE_LEVEL_HIGH>,
+					     <81 IRQ_TYPE_LEVEL_HIGH>,
+					     <80 IRQ_TYPE_LEVEL_HIGH>,
+					     <79 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 		};
@@ -210,7 +214,7 @@
 			"generic-xhci";
 			reg = <0x500000 0x4000>;
 			dma-coherent;
-			interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <106 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "reg";
 			clocks = <&CP110_LABEL(clk) 1 22>,
 				 <&CP110_LABEL(clk) 1 16>;
@@ -222,7 +226,7 @@
 			"generic-xhci";
 			reg = <0x510000 0x4000>;
 			dma-coherent;
-			interrupts = <ICU_GRP_NSR 105 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <105 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "reg";
 			clocks = <&CP110_LABEL(clk) 1 23>,
 				 <&CP110_LABEL(clk) 1 16>;
@@ -233,7 +237,7 @@
 			compatible = "marvell,armada-8k-ahci",
 			"generic-ahci";
 			reg = <0x540000 0x30000>;
-			interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&CP110_LABEL(clk) 1 15>,
 				 <&CP110_LABEL(clk) 1 16>;
 			status = "disabled";
@@ -286,7 +290,7 @@
 			reg = <0x701000 0x20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <ICU_GRP_NSR 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <120 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "reg";
 			clocks = <&CP110_LABEL(clk) 1 21>,
 				 <&CP110_LABEL(clk) 1 17>;
@@ -298,7 +302,7 @@
 			reg = <0x701100 0x20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <ICU_GRP_NSR 121 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <121 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "reg";
 			clocks = <&CP110_LABEL(clk) 1 21>,
 				 <&CP110_LABEL(clk) 1 17>;
@@ -309,7 +313,7 @@
 			compatible = "snps,dw-apb-uart";
 			reg = <0x702000 0x100>;
 			reg-shift = <2>;
-			interrupts = <ICU_GRP_NSR 122 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <122 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <1>;
 			clock-names = "baudclk", "apb_pclk";
 			clocks = <&CP110_LABEL(clk) 1 21>,
@@ -321,7 +325,7 @@
 			compatible = "snps,dw-apb-uart";
 			reg = <0x702100 0x100>;
 			reg-shift = <2>;
-			interrupts = <ICU_GRP_NSR 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <1>;
 			clock-names = "baudclk", "apb_pclk";
 			clocks = <&CP110_LABEL(clk) 1 21>,
@@ -333,7 +337,7 @@
 			compatible = "snps,dw-apb-uart";
 			reg = <0x702200 0x100>;
 			reg-shift = <2>;
-			interrupts = <ICU_GRP_NSR 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <124 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <1>;
 			clock-names = "baudclk", "apb_pclk";
 			clocks = <&CP110_LABEL(clk) 1 21>,
@@ -345,7 +349,7 @@
 			compatible = "snps,dw-apb-uart";
 			reg = <0x702300 0x100>;
 			reg-shift = <2>;
-			interrupts = <ICU_GRP_NSR 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <125 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <1>;
 			clock-names = "baudclk", "apb_pclk";
 			clocks = <&CP110_LABEL(clk) 1 21>,
@@ -364,7 +368,7 @@
 			reg = <0x720000 0x54>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <115 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "reg";
 			clocks = <&CP110_LABEL(clk) 1 2>,
 				 <&CP110_LABEL(clk) 1 17>;
@@ -376,7 +380,7 @@
 			compatible = "marvell,armada-8k-rng",
 			"inside-secure,safexcel-eip76";
 			reg = <0x760000 0x7d>;
-			interrupts = <ICU_GRP_NSR 95 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "reg";
 			clocks = <&CP110_LABEL(clk) 1 25>,
 				 <&CP110_LABEL(clk) 1 17>;
@@ -386,7 +390,7 @@
 		CP110_LABEL(sdhci0): sdhci@780000 {
 			compatible = "marvell,armada-cp110-sdhci";
 			reg = <0x780000 0x300>;
-			interrupts = <ICU_GRP_NSR 27 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "axi";
 			clocks = <&CP110_LABEL(clk) 1 4>, <&CP110_LABEL(clk) 1 18>;
 			dma-coherent;
@@ -396,12 +400,12 @@
 		CP110_LABEL(crypto): crypto@800000 {
 			compatible = "inside-secure,safexcel-eip197";
 			reg = <0x800000 0x200000>;
-			interrupts = <ICU_GRP_NSR 87 IRQ_TYPE_LEVEL_HIGH>,
-				<ICU_GRP_NSR 88 IRQ_TYPE_LEVEL_HIGH>,
-				<ICU_GRP_NSR 89 IRQ_TYPE_LEVEL_HIGH>,
-				<ICU_GRP_NSR 90 IRQ_TYPE_LEVEL_HIGH>,
-				<ICU_GRP_NSR 91 IRQ_TYPE_LEVEL_HIGH>,
-				<ICU_GRP_NSR 92 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <87 IRQ_TYPE_LEVEL_HIGH>,
+				     <88 IRQ_TYPE_LEVEL_HIGH>,
+				     <89 IRQ_TYPE_LEVEL_HIGH>,
+				     <90 IRQ_TYPE_LEVEL_HIGH>,
+				     <91 IRQ_TYPE_LEVEL_HIGH>,
+				     <92 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mem", "ring0", "ring1",
 				"ring2", "ring3", "eip";
 			clock-names = "core", "reg";
@@ -430,8 +434,8 @@
 		/* non-prefetchable memory */
 		0x82000000 0 CP110_PCIEx_MEM_BASE(0) 0  CP110_PCIEx_MEM_BASE(0) 0 0xf00000>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
-		interrupts = <ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map = <0 0 0 0 &CP110_LABEL(icu_nsr) 22 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP110_LABEL(clk) 1 13>, <&CP110_LABEL(clk) 1 14>;
@@ -457,8 +461,8 @@
 		/* non-prefetchable memory */
 		0x82000000 0 CP110_PCIEx_MEM_BASE(1) 0  CP110_PCIEx_MEM_BASE(1) 0 0xf00000>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
-		interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map = <0 0 0 0 &CP110_LABEL(icu_nsr) 24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
 
 		num-lanes = <1>;
 		clock-names = "core", "reg";
@@ -485,8 +489,8 @@
 		/* non-prefetchable memory */
 		0x82000000 0 CP110_PCIEx_MEM_BASE(2) 0  CP110_PCIEx_MEM_BASE(2) 0 0xf00000>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
-		interrupts = <ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map = <0 0 0 0 &CP110_LABEL(icu_nsr) 23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
 
 		num-lanes = <1>;
 		clock-names = "core", "reg";
-- 
2.14.1
