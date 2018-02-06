Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbeBFJzz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:55:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37286 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752680AbeBFJx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:53:26 -0500
X-UUID: 6aaeedcf6266446699ccc92919c2c7f1-20180206
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>, Zhi Mao <zhi.mao@mediatek.com>,
        Jun Gao <jun.gao@mediatek.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH v2 08/16] arm64: dts: mt7622: add SoC and peripheral related device nodes
Date: Tue, 6 Feb 2018 17:52:57 +0800
Message-ID: <4b3b08ce27a54e15d967ce9f90c922c5a97e4ae7.1517910489.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1517910489.git.sean.wang@mediatek.com>
References: <cover.1517910489.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add watchdog, rtc, auxadc, cir, efuse, rng, uart[1-4], pwm, i2c[0-2],
spi[0-1] and btif nodes

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: Zhi Mao <zhi.mao@mediatek.com>
Cc: Jun Gao <jun.gao@mediatek.com>
Cc: Leilk Liu <leilk.liu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts |  54 ++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 194 +++++++++++++++++++++++++++
 2 files changed, 248 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index bbf4d03..2a2247b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -235,6 +235,34 @@
 	};
 };
 
+&btif {
+	status = "okay";
+};
+
+&cir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&irrx_pins>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm7_pins>;
+	status = "okay";
+};
+
 &pwrap {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pmic_bus_pins>;
@@ -242,6 +270,32 @@
 	status = "okay";
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spic0_pins>;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spic1_pins>;
+	status = "okay";
+};
+
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
+&watchdog {
+	pinctrl-names = "default";
+	pinctrl-0 = <&watchdog_pins>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 845fc11..2330ddc 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -173,6 +173,16 @@
 		clock-names = "hif_sel";
 	};
 
+	cir: cir@10009000 {
+		compatible = "mediatek,mt7622-cir";
+		reg = <0 0x10009000 0 0x1000>;
+		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_IRRX_PD>,
+			 <&topckgen CLK_TOP_AXI_SEL>;
+		clock-names = "clk", "bus";
+		status = "disabled";
+	};
+
 	sysirq: interrupt-controller@10200620 {
 		compatible = "mediatek,mt7622-sysirq",
 			     "mediatek,mt6577-sysirq";
@@ -182,6 +192,18 @@
 		reg = <0 0x10200620 0 0x20>;
 	};
 
+	efuse: efuse@10206000 {
+		compatible = "mediatek,mt7622-efuse",
+			     "mediatek,efuse";
+		reg = <0 0x10206000 0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		thermal_calibration: calib@198 {
+			reg = <0x198 0x8>;
+		};
+	};
+
 	apmixedsys: apmixedsys@10209000 {
 		compatible = "mediatek,mt7622-apmixedsys",
 			     "syscon";
@@ -196,6 +218,14 @@
 		#clock-cells = <1>;
 	};
 
+	rng: rng@1020f000 {
+		compatible = "mediatek,mt7622-rng",
+			     "mediatek,mt7623-rng";
+		reg = <0 0x1020f000 0 0x1000>;
+		clocks = <&infracfg CLK_INFRA_TRNG>;
+		clock-names = "rng";
+	};
+
 	pio: pinctrl@10211000 {
 		compatible = "mediatek,mt7622-pinctrl";
 		reg = <0 0x10211000 0 0x1000>;
@@ -203,6 +233,21 @@
 		#gpio-cells = <2>;
 	};
 
+	watchdog: watchdog@10212000 {
+		compatible = "mediatek,mt7622-wdt",
+			     "mediatek,mt6589-wdt";
+		reg = <0 0x10212000 0 0x800>;
+	};
+
+	rtc: rtc@10212800 {
+		compatible = "mediatek,mt7622-rtc",
+			     "mediatek,soc-rtc";
+		reg = <0 0x10212800 0 0x200>;
+		interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_RTC>;
+		clock-names = "rtc";
+	};
+
 	gic: interrupt-controller@10300000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
@@ -214,6 +259,14 @@
 		      <0 0x10360000 0 0x2000>;
 	};
 
+	auxadc: adc@11001000 {
+		compatible = "mediatek,mt7622-auxadc";
+		reg = <0 0x11001000 0 0x1000>;
+		clocks = <&pericfg CLK_PERI_AUXADC_PD>;
+		clock-names = "main";
+		#io-channel-cells = <1>;
+	};
+
 	uart0: serial@11002000 {
 		compatible = "mediatek,mt7622-uart",
 			     "mediatek,mt6577-uart";
@@ -225,6 +278,147 @@
 		status = "disabled";
 	};
 
+	uart1: serial@11003000 {
+		compatible = "mediatek,mt7622-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11003000 0 0x400>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UART_SEL>,
+			 <&pericfg CLK_PERI_UART1_PD>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	uart2: serial@11004000 {
+		compatible = "mediatek,mt7622-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11004000 0 0x400>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UART_SEL>,
+			 <&pericfg CLK_PERI_UART2_PD>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	uart3: serial@11005000 {
+		compatible = "mediatek,mt7622-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11005000 0 0x400>;
+		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UART_SEL>,
+			 <&pericfg CLK_PERI_UART3_PD>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	pwm: pwm@11006000 {
+		compatible = "mediatek,mt7622-pwm";
+		reg = <0 0x11006000 0 0x1000>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_PWM_SEL>,
+			 <&pericfg CLK_PERI_PWM_PD>,
+			 <&pericfg CLK_PERI_PWM1_PD>,
+			 <&pericfg CLK_PERI_PWM2_PD>,
+			 <&pericfg CLK_PERI_PWM3_PD>,
+			 <&pericfg CLK_PERI_PWM4_PD>,
+			 <&pericfg CLK_PERI_PWM5_PD>,
+			 <&pericfg CLK_PERI_PWM6_PD>;
+		clock-names = "top", "main", "pwm1", "pwm2", "pwm3", "pwm4",
+			      "pwm5", "pwm6";
+		status = "disabled";
+	};
+
+	i2c0: i2c@11007000 {
+		compatible = "mediatek,mt7622-i2c";
+		reg = <0 0x11007000 0 0x90>,
+		      <0 0x11000100 0 0x80>;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <16>;
+		clocks = <&pericfg CLK_PERI_I2C0_PD>,
+			 <&pericfg CLK_PERI_AP_DMA_PD>;
+		clock-names = "main", "dma";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c1: i2c@11008000 {
+		compatible = "mediatek,mt7622-i2c";
+		reg = <0 0x11008000 0 0x90>,
+		      <0 0x11000180 0 0x80>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <16>;
+		clocks = <&pericfg CLK_PERI_I2C1_PD>,
+			 <&pericfg CLK_PERI_AP_DMA_PD>;
+		clock-names = "main", "dma";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@11009000 {
+		compatible = "mediatek,mt7622-i2c";
+		reg = <0 0x11009000 0 0x90>,
+		      <0 0x11000200 0 0x80>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <16>;
+		clocks = <&pericfg CLK_PERI_I2C2_PD>,
+			 <&pericfg CLK_PERI_AP_DMA_PD>;
+		clock-names = "main", "dma";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi0: spi@1100a000 {
+		compatible = "mediatek,mt7622-spi";
+		reg = <0 0x1100a000 0 0x100>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+			 <&topckgen CLK_TOP_SPI0_SEL>,
+			 <&pericfg CLK_PERI_SPI0_PD>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	btif: serial@1100c000 {
+		compatible = "mediatek,mt7622-btif",
+			     "mediatek,mtk-btif";
+		reg = <0 0x1100c000 0 0x1000>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_BTIF_PD>;
+		clock-names = "main";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	spi1: spi@11016000 {
+		compatible = "mediatek,mt7622-spi";
+		reg = <0 0x11016000 0 0x100>;
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+			 <&topckgen CLK_TOP_SPI1_SEL>,
+			 <&pericfg CLK_PERI_SPI1_PD>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	uart4: serial@11019000 {
+		compatible = "mediatek,mt7622-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11019000 0 0x400>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UART_SEL>,
+			 <&pericfg CLK_PERI_UART4_PD>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
 	ssusbsys: ssusbsys@1a000000 {
 		compatible = "mediatek,mt7622-ssusbsys",
 			     "syscon";
-- 
2.7.4
