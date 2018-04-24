Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755791AbeDXJVB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:21:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35233 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932259AbeDXJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:19:44 -0400
X-Google-Smtp-Source: AIpwx4/HV8N1EtPBOg/3Oe8lNE68/DI9qlmInm1wgO2o5wUMwrQoOgfg6lzM4bXhchLV3B91s8Ubag==
From: Neil Armstrong <narmstrong@baylibre.com>
To: maxime.ripard@bootlin.com, wens@csie.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, clabbe@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: sun8i-h3-libretech-all-h3-cc: Move board definition to common dtsi
Date: Tue, 24 Apr 2018 11:19:35 +0200
Message-Id: <1524561576-2201-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the libretech-all-h3-cc can use either the H2+, H3 or H5, move the
content of the dts file to a common dtsi file to be included by the H3 variant
and in a following patch the H5 variant.

By the way, update the SPDX licence tag position.

Suggested-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 209 +-------------------
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi   | 211 +++++++++++++++++++++
 2 files changed, 213 insertions(+), 207 deletions(-)
 create mode 100644 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi

diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index b20a710..50f2fb3 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -1,218 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
 #include "sun8i-h3.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
+#include "sunxi-libretech-all-h3-cc.dtsi"
 
 / {
 	model = "Libre Computer Board ALL-H3-CC H3";
 	compatible = "libretech,all-h3-cc-h3", "allwinner,sun8i-h3";
-
-	aliases {
-		ethernet0 = &emac;
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	connector {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con_in: endpoint {
-				remote-endpoint = <&hdmi_out_con>;
-			};
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		pwr_led {
-			label = "librecomputer:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
-			default-state = "on";
-		};
-
-		status_led {
-			label = "librecomputer:blue:status";
-			gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
-		};
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-
-		power {
-			label = "power";
-			linux,code = <KEY_POWER>;
-			gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
-		};
-	};
-
-	reg_vcc1v2: vcc1v2 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc1v2";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&reg_vcc5v0>;
-		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
-		enable-active-high;
-	};
-
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&reg_vcc5v0>;
-	};
-
-	/* This represents the board's 5V input */
-	reg_vcc5v0: vcc5v0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	reg_vcc_dram: vcc-dram {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc-dram";
-		regulator-min-microvolt = <1500000>;
-		regulator-max-microvolt = <1500000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&reg_vcc5v0>;
-		gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
-		enable-active-high;
-	};
-
-	reg_vcc_io: vcc-io {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc-io";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&reg_vcc3v3>;
-		gpio = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL5 */
-	};
-
-	reg_vdd_cpux: vdd-cpux {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd-cpux";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&reg_vcc5v0>;
-		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
-		enable-active-high;
-	};
-};
-
-&codec {
-	allwinner,audio-routing =
-		"Line Out", "LINEOUT",
-		"MIC1", "Mic",
-		"Mic",  "MBIAS";
-	status = "okay";
-};
-
-&de {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&ehci2 {
-	status = "okay";
-};
-
-&ehci3 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&int_mii_phy>;
-	phy-mode = "mii";
-	allwinner,leds-active-low;
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&hdmi_out {
-	hdmi_out_con: endpoint {
-		remote-endpoint = <&hdmi_con_in>;
-	};
-};
-
-&ir {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
-	status = "okay";
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc_io>;
-	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&ohci2 {
-	status = "okay";
-};
-
-&ohci3 {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphy {
-	/* VBUS on USB ports are always on */
-	usb0_vbus-supply = <&reg_vcc5v0>;
-	usb1_vbus-supply = <&reg_vcc5v0>;
-	usb2_vbus-supply = <&reg_vcc5v0>;
-	usb3_vbus-supply = <&reg_vcc5v0>;
-	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
new file mode 100644
index 0000000..ff42c16
--- /dev/null
+++ b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	aliases {
+		ethernet0 = &emac;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pwr_led {
+			label = "librecomputer:green:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+			default-state = "on";
+		};
+
+		status_led {
+			label = "librecomputer:blue:status";
+			gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+		};
+	};
+
+	reg_vcc1v2: vcc1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v2";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&reg_vcc5v0>;
+		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		enable-active-high;
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vcc5v0>;
+	};
+
+	/* This represents the board's 5V input */
+	reg_vcc5v0: vcc5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_vcc_dram: vcc-dram {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-dram";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&reg_vcc5v0>;
+		gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
+		enable-active-high;
+	};
+
+	reg_vcc_io: vcc-io {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-io";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&reg_vcc3v3>;
+		gpio = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL5 */
+	};
+
+	reg_vdd_cpux: vdd-cpux {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpux";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&reg_vcc5v0>;
+		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		enable-active-high;
+	};
+};
+
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins_a>;
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc_io>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	/* VBUS on USB ports are always on */
+	usb0_vbus-supply = <&reg_vcc5v0>;
+	usb1_vbus-supply = <&reg_vcc5v0>;
+	usb2_vbus-supply = <&reg_vcc5v0>;
+	usb3_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
-- 
2.7.4
