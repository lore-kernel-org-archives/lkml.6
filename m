Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeBQT6W (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:58:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:18001 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751270AbeBQTzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:55:07 -0500
X-UUID: 70c2f59c6cbf43fda434e2c1e40b1582-20180218
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 04/15] arm64: dts: mt7622: add pinctrl related device nodes
Date: Sun, 18 Feb 2018 03:54:39 +0800
Message-ID: <5bf0248c9c39ebe76b9790458832fc37b067b0d4.1518895232.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add pinctrl device nodes and rfb1 board, additionally include all pin
groups possible being used on rfb1 board and available gpio keys.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 200 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     |   7 +
 2 files changed, 207 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index c08309d..fc8ef78 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -7,6 +7,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
+
 #include "mt7622.dtsi"
 
 / {
@@ -17,11 +19,209 @@
 		bootargs = "console=ttyS0,115200n1";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		factory {
+			label = "factory";
+			linux,code = <BTN_0>;
+			gpios = <&pio 0 0>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 102 0>;
+		};
+	};
+
 	memory {
 		reg = <0 0x40000000 0 0x3F000000>;
 	};
 };
 
+&pio {
+	/* eMMC is shared pin with parallel NAND */
+	emmc_pins_default: emmc-pins-default {
+		mux {
+			function = "emmc", "emmc_rst";
+			groups = "emmc";
+		};
+	};
+
+	emmc_pins_uhs: emmc-pins-uhs {
+		mux {
+			function = "emmc";
+			groups = "emmc";
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
+			groups =  "i2s_out_bclk_ws_mclk",
+				  "i2s1_in_data",
+				  "i2s1_out_data";
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
+	};
+
+	sd0_pins_uhs: sd0-pins-uhs {
+		mux {
+			function = "sd";
+			groups = "sd_0";
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
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 81207e6..8211bf7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -147,6 +147,13 @@
 		#clock-cells = <1>;
 	};
 
+	pio: pinctrl@10211000 {
+		compatible = "mediatek,mt7622-pinctrl";
+		reg = <0 0x10211000 0 0x1000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gic: interrupt-controller@10300000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.7.4
