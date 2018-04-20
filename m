Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932071AbeDTP5U (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:57:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18363 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755837AbeDTP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:57:09 -0400
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH 1/5] ARM: dts: stih407-family: Fix complain about IRQ_TYPE_NONE usage
Date: Fri, 20 Apr 2018 17:54:40 +0200
Message-ID: <1524239684-25463-2-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
References: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG3NODE4.st.com (10.75.127.71) To GPXDAG6NODE6.st.com
 (10.75.127.82)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE")
kernel is complaining about the IRQ_TYPE_NONE usage which shouldn't
be used.

Use IRQ_TYPE_LEVEL_HIGH instead.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 52 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index f7362c31de29..9e29a4499938 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -206,19 +206,19 @@
 		vtg_main: sti-vtg-main@8d02800 {
 			compatible = "st,vtg";
 			reg = <0x8d02800 0x200>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		vtg_aux: sti-vtg-aux@8d00200 {
 			compatible = "st,vtg";
 			reg = <0x8d00200 0x100>;
-			interrupts = <GIC_SPI 109 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial@9830000 {
 			compatible = "st,asc";
 			reg = <0x9830000 0x2c>;
-			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
 			/* Pinctrl moved out to a per-board configuration */
 
@@ -228,7 +228,7 @@
 		serial@9831000 {
 			compatible = "st,asc";
 			reg = <0x9831000 0x2c>;
-			interrupts = <GIC_SPI 123 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_serial1>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
@@ -239,7 +239,7 @@
 		serial@9832000 {
 			compatible = "st,asc";
 			reg = <0x9832000 0x2c>;
-			interrupts = <GIC_SPI 124 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_serial2>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
@@ -251,7 +251,7 @@
 		sbc_serial0: serial@9530000 {
 			compatible = "st,asc";
 			reg = <0x9530000 0x2c>;
-			interrupts = <GIC_SPI 138 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sbc_serial0>;
 			clocks = <&clk_sysin>;
@@ -262,7 +262,7 @@
 		serial@9531000 {
 			compatible = "st,asc";
 			reg = <0x9531000 0x2c>;
-			interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sbc_serial1>;
 			clocks = <&clk_sysin>;
@@ -574,7 +574,7 @@
 			status = "disabled";
 			reg = <0x09060000 0x7ff>, <0x9061008 0x20>;
 			reg-names = "mmc", "top-mmc-delay";
-			interrupts = <GIC_SPI 92 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mmcirq";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_mmc0>;
@@ -589,7 +589,7 @@
 			status = "disabled";
 			reg = <0x09080000 0x7ff>;
 			reg-names = "mmc";
-			interrupts = <GIC_SPI 90 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mmcirq";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sd1>;
@@ -623,7 +623,7 @@
 			compatible = "st,ahci";
 			reg = <0x9b20000 0x1000>;
 
-			interrupts = <GIC_SPI 159 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hostc";
 
 			phys = <&phy_port0 PHY_TYPE_SATA>;
@@ -646,7 +646,7 @@
 			compatible = "st,ahci";
 			reg = <0x9b28000 0x1000>;
 
-			interrupts = <GIC_SPI 170 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hostc";
 
 			phys = <&phy_port1 PHY_TYPE_SATA>;
@@ -687,7 +687,7 @@
 			dwc3: dwc3@9900000 {
 				compatible	= "snps,dwc3";
 				reg		= <0x09900000 0x100000>;
-				interrupts	= <GIC_SPI 155 IRQ_TYPE_NONE>;
+				interrupts	= <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode		= "host";
 				phy-names	= "usb2-phy", "usb3-phy";
 				phys		= <&usb2_picophy0>,
@@ -701,7 +701,7 @@
 			compatible	= "st,sti-pwm";
 			#pwm-cells	= <2>;
 			reg		= <0x9810000 0x68>;
-			interrupts      = <GIC_SPI 128 IRQ_TYPE_NONE>;
+			interrupts      = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names	= "default";
 			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
 			clock-names	= "pwm";
@@ -716,7 +716,7 @@
 			compatible	= "st,sti-pwm";
 			#pwm-cells	= <2>;
 			reg		= <0x9510000 0x68>;
-			interrupts      = <GIC_SPI 131 IRQ_TYPE_NONE>;
+			interrupts      = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names	= "default";
 			pinctrl-0	= <&pinctrl_pwm1_chan0_default
 					&pinctrl_pwm1_chan1_default
@@ -755,8 +755,8 @@
 			resets = <&softreset STIH407_ETH1_SOFTRESET>;
 			reset-names = "stmmaceth";
 
-			interrupts = <GIC_SPI 98 IRQ_TYPE_NONE>,
-				     <GIC_SPI 99 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "eth_wake_irq";
 
 			/* DMA Bus Mode */
@@ -787,7 +787,7 @@
 		mailbox0: mailbox@8f00000  {
 			compatible	= "st,stih407-mailbox";
 			reg		= <0x8f00000 0x1000>;
-			interrupts	= <GIC_SPI 1 IRQ_TYPE_NONE>;
+			interrupts	= <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			#mbox-cells	= <2>;
 			mbox-name	= "a9";
 			status		= "okay";
@@ -857,7 +857,7 @@
 				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
 				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
 				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
-			interrupts = <GIC_SPI 5 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			dma-channels = <16>;
 			#dma-cells = <3>;
 		};
@@ -875,7 +875,7 @@
 				<&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
 				<&clk_s_c0_flexgen CLK_EXT2F_A9>;
 
-			interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			dma-channels = <16>;
 			#dma-cells = <3>;
 
@@ -890,7 +890,7 @@
 			      <0x8e77000 0x1000>,
 			      <0x8e78000 0x8000>;
 			reg-names = "slimcore", "dmem", "peripherals", "imem";
-			interrupts = <GIC_SPI 9 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			dma-channels = <16>;
 			#dma-cells = <3>;
 			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
@@ -910,7 +910,7 @@
 			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 0>;
 			assigned-clock-rates = <50000000>;
 			reg = <0x8d80000 0x158>;
-			interrupts = <GIC_SPI 84 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&fdma0 2 0 1>;
 			dma-names = "tx";
 
@@ -926,7 +926,7 @@
 			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 1>;
 			assigned-clock-rates = <50000000>;
 			reg = <0x8d81000 0x158>;
-			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&fdma0 3 0 1>;
 			dma-names = "tx";
 
@@ -942,7 +942,7 @@
 			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 2>;
 			assigned-clock-rates = <50000000>;
 			reg = <0x8d82000 0x158>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&fdma0 4 0 1>;
 			dma-names = "tx";
 
@@ -958,7 +958,7 @@
 			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 3>;
 			assigned-clock-rates = <50000000>;
 			reg = <0x8d85000 0x158>;
-			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&fdma0 7 0 1>;
 			dma-names = "tx";
 
@@ -970,7 +970,7 @@
 			#sound-dai-cells = <0>;
 			st,syscfg = <&syscfg_core>;
 			reg = <0x8d83000 0x158>;
-			interrupts = <GIC_SPI 87 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&fdma0 5 0 1>;
 			dma-names = "rx";
 
@@ -982,7 +982,7 @@
 			#sound-dai-cells = <0>;
 			st,syscfg = <&syscfg_core>;
 			reg = <0x8d84000 0x158>;
-			interrupts = <GIC_SPI 88 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&fdma0 6 0 1>;
 			dma-names = "rx";
 
-- 
1.9.1
