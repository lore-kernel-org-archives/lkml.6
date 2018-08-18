Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6DEC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B48C215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B48C215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeHRTLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:11:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9016 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbeHRTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:11:31 -0400
X-UUID: f297c5733bb54a7aaad95bdfea237c4d-20180819
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1368151359; Sun, 19 Aug 2018 00:03:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sun, 19 Aug 2018 00:03:09 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sun, 19 Aug 2018 00:03:09 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 4/5] arm64: dts: mt7622: add bananapi BPI-R64 board
Date:   Sun, 19 Aug 2018 00:02:27 +0800
Message-ID: <69a61903d53e5a818d1ddabd0613d237217c62a8.1534607107.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
References: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the bananapi R64 (BPI-R64) development board from
BIPAI KEJI. Detailed hardware information for BPI-R64 which could be
found on http://wiki.banana-pi.org/Banana_Pi_BPI-R64

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v1:
- add missing sata nodes.
- fix pinctrl-0 for pcie@1,0.
- switch goio keys from polling mode to intterupt mode.
- add gpio-led nodes.
---
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  | 530 +++++++++++++++++++++
 2 files changed, 531 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 5b7fd6a..e8f952f 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -5,4 +5,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
new file mode 100644
index 0000000..5d6005c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -0,0 +1,530 @@
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0 OR MIT)
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
+#include "mt7622.dtsi"
+#include "mt6380.dtsi"
+
+/ {
+	model = "Bananapi BPI-R64";
+	compatible = "bananapi,bpi-r64", "mediatek,mt7622";
+
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0x11002000 console=ttyS0,115200n1 swiotlb=512";
+	};
+
+	cpus {
+		cpu@0 {
+			proc-supply = <&mt6380_vcpu_reg>;
+			sram-supply = <&mt6380_vm_reg>;
+		};
+
+		cpu@1 {
+			proc-supply = <&mt6380_vcpu_reg>;
+			sram-supply = <&mt6380_vm_reg>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		factory {
+			label = "factory";
+			linux,code = <BTN_0>;
+			gpios = <&pio 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 102 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		green {
+			label = "bpi-r64:pio:green";
+			gpios = <&pio 89 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		red {
+			label = "bpi-r64:pio:red";
+			gpios = <&pio 88 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	memory {
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&bch {
+	status = "disabled";
+};
+
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
+&eth {
+	pinctrl-names = "default";
+	pinctrl-0 = <&eth_pins>;
+	status = "okay";
+
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-handle = <&phy5>;
+	};
+
+	mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy5: ethernet-phy@5 {
+			reg = <5>;
+			phy-mode = "sgmii";
+		};
+	};
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
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&emmc_pins_default>;
+	pinctrl-1 = <&emmc_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
+	non-removable;
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&sd0_pins_default>;
+	pinctrl-1 = <&sd0_pins_uhs>;
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	cap-sd-highspeed;
+	r_smpl = <1>;
+	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
+};
+
+&nandc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&parallel_nand_pins>;
+	status = "disabled";
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_nor_pins>;
+	status = "disabled";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins>, <&pcie1_pins>;
+	status = "okay";
+
+	pcie@0,0 {
+		status = "okay";
+	};
+
+	pcie@1,0 {
+		status = "okay";
+	};
+};
+
+&pio {
+	/* Attention: GPIO 90 is used to switch between PCIe@1,0 and
+	 * SATA functions. i.e. output-high: PCIe, output-low: SATA
+	 */
+	asm_sel {
+		gpio-hog;
+		gpios = <90 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+
+	/* eMMC is shared pin with parallel NAND */
+	emmc_pins_default: emmc-pins-default {
+		mux {
+			function = "emmc", "emmc_rst";
+			groups = "emmc";
+		};
+
+		/* "NDL0","NDL1","NDL2","NDL3","NDL4","NDL5","NDL6","NDL7",
+		 * "NRB","NCLE" pins are used as DAT0,DAT1,DAT2,DAT3,DAT4,
+		 * DAT5,DAT6,DAT7,CMD,CLK for eMMC respectively
+		 */
+		conf-cmd-dat {
+			pins = "NDL0", "NDL1", "NDL2",
+			       "NDL3", "NDL4", "NDL5",
+			       "NDL6", "NDL7", "NRB";
+			input-enable;
+			bias-pull-up;
+		};
+
+		conf-clk {
+			pins = "NCLE";
+			bias-pull-down;
+		};
+	};
+
+	emmc_pins_uhs: emmc-pins-uhs {
+		mux {
+			function = "emmc";
+			groups = "emmc";
+		};
+
+		conf-cmd-dat {
+			pins = "NDL0", "NDL1", "NDL2",
+			       "NDL3", "NDL4", "NDL5",
+			       "NDL6", "NDL7", "NRB";
+			input-enable;
+			drive-strength = <4>;
+			bias-pull-up;
+		};
+
+		conf-clk {
+			pins = "NCLE";
+			drive-strength = <4>;
+			bias-pull-down;
+		};
+	};
+
+	eth_pins: eth-pins {
+		mux {
+			function = "eth";
+			groups = "mdc_mdio", "rgmii_via_gmac2";
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		mux {
+			function = "i2c";
+			groups =  "i2c1_0";
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		mux {
+			function = "i2c";
+			groups =  "i2c2_0";
+		};
+	};
+
+	i2s1_pins: i2s1-pins {
+		mux {
+			function = "i2s";
+			groups =  "i2s_out_mclk_bclk_ws",
+				  "i2s1_in_data",
+				  "i2s1_out_data";
+		};
+
+		conf {
+			pins = "I2S1_IN", "I2S1_OUT", "I2S_BCLK",
+			       "I2S_WS", "I2S_MCLK";
+			drive-strength = <12>;
+			bias-pull-down;
+		};
+	};
+
+	irrx_pins: irrx-pins {
+		mux {
+			function = "ir";
+			groups =  "ir_1_rx";
+		};
+	};
+
+	irtx_pins: irtx-pins {
+		mux {
+			function = "ir";
+			groups =  "ir_1_tx";
+		};
+	};
+
+	/* Parallel nand is shared pin with eMMC */
+	parallel_nand_pins: parallel-nand-pins {
+		mux {
+			function = "flash";
+			groups = "par_nand";
+		};
+	};
+
+	pcie0_pins: pcie0-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie0_pad_perst",
+				 "pcie0_1_waken",
+				 "pcie0_1_clkreq";
+		};
+	};
+
+	pcie1_pins: pcie1-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie1_pad_perst",
+				 "pcie1_0_waken",
+				 "pcie1_0_clkreq";
+		};
+	};
+
+	pmic_bus_pins: pmic-bus-pins {
+		mux {
+			function = "pmic";
+			groups = "pmic_bus";
+		};
+	};
+
+	pwm7_pins: pwm1-2-pins {
+		mux {
+			function = "pwm";
+			groups = "pwm_ch7_2";
+		};
+	};
+
+	wled_pins: wled-pins {
+		mux {
+			function = "led";
+			groups = "wled";
+		};
+	};
+
+	sd0_pins_default: sd0-pins-default {
+		mux {
+			function = "sd";
+			groups = "sd_0";
+		};
+
+		/* "I2S2_OUT, "I2S4_IN"", "I2S3_IN", "I2S2_IN",
+		 *  "I2S4_OUT", "I2S3_OUT" are used as DAT0, DAT1,
+		 *  DAT2, DAT3, CMD, CLK for SD respectively.
+		 */
+		conf-cmd-data {
+			pins = "I2S2_OUT", "I2S4_IN", "I2S3_IN",
+			       "I2S2_IN","I2S4_OUT";
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+		conf-clk {
+			pins = "I2S3_OUT";
+			drive-strength = <12>;
+			bias-pull-down;
+		};
+		conf-cd {
+			pins = "TXD3";
+			bias-pull-up;
+		};
+	};
+
+	sd0_pins_uhs: sd0-pins-uhs {
+		mux {
+			function = "sd";
+			groups = "sd_0";
+		};
+
+		conf-cmd-data {
+			pins = "I2S2_OUT", "I2S4_IN", "I2S3_IN",
+			       "I2S2_IN","I2S4_OUT";
+			input-enable;
+			bias-pull-up;
+		};
+
+		conf-clk {
+			pins = "I2S3_OUT";
+			bias-pull-down;
+		};
+	};
+
+	/* Serial NAND is shared pin with SPI-NOR */
+	serial_nand_pins: serial-nand-pins {
+		mux {
+			function = "flash";
+			groups = "snfi";
+		};
+	};
+
+	spic0_pins: spic0-pins {
+		mux {
+			function = "spi";
+			groups = "spic0_0";
+		};
+	};
+
+	spic1_pins: spic1-pins {
+		mux {
+			function = "spi";
+			groups = "spic1_0";
+		};
+	};
+
+	/* SPI-NOR is shared pin with serial NAND */
+	spi_nor_pins: spi-nor-pins {
+		mux {
+			function = "flash";
+			groups = "spi_nor";
+		};
+	};
+
+	/* serial NAND is shared pin with SPI-NOR */
+	serial_nand_pins: serial-nand-pins {
+		mux {
+			function = "flash";
+			groups = "snfi";
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		mux {
+			function = "uart";
+			groups = "uart0_0_tx_rx" ;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		mux {
+			function = "uart";
+			groups = "uart2_1_tx_rx" ;
+		};
+	};
+
+	watchdog_pins: watchdog-pins {
+		mux {
+			function = "watchdog";
+			groups = "watchdog";
+		};
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm7_pins>;
+	status = "okay";
+};
+
+&pwrap {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_bus_pins>;
+
+	status = "okay";
+};
+
+&sata {
+	status = "disable";
+};
+
+&sata_phy {
+	status = "disable";
+};
+
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
+&ssusb {
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
+	status = "okay";
+};
+
+&u3phy {
+	status = "okay";
+};
+
+&uart0 {
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
+	status = "okay";
+};
-- 
1.9.1

