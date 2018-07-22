Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B235C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EC220874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EC220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeGVRsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:48:09 -0400
Received: from mout.perfora.net ([74.208.4.194]:43363 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbeGVRsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:48:08 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfAKc-1gMtmD0OUK-00ojh9; Sun, 22 Jul 2018 18:50:41 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 28/28] ARM: tegra: apalis_t30: support v1.1 hardware revision
Date:   Sun, 22 Jul 2018 18:49:36 +0200
Message-Id: <20180722164936.20581-29-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:c8+oiR3na3wuHdbWS/8ArMej1DfKMnH85oPBuLfi+Z2YlYLRq0u
 hT8cYoJl+s5ALccSU+WsQWjBqa3wb7cpkRRZ36lWhjqWS9HwAQ8IEySbyjJn2ONqttDXSUz
 rsEj4+KJ+Y/0YkPfw+Fib1TwTKSXY7CdVsbWdA2QAu6/PaN2FOyKfQXWkR44902ZDd3hwvh
 8RffaDqyxOVcY0zBnVoJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dTztSUS10t0=:8EWw5EWui+OCIbrTQCQGNY
 QgIZgUzaE85YLuR664z95ehNWfaNQYuNqZDrIZw+AK+FFDGYyETIkhM4c0cOEGYRl4j8QXkW/
 7w9bvsmvn7lEyFrN7JBNCIKzkewfRHXojv4g1Kks/E1AZJt9UP0YH+2v+xtdUsY+JE6y+AnlW
 X0sMgFjmzQ1AhfWdr3h3sKBJJqW515fGTtwBJiRPTgDl9QAcJCqn33+3BiKmLS6sSuBsfjWw8
 dfVxlb+c03oU0O1Dsk4Z50Fp1j3oyUxO1SdHXqjw5TdngtJMTtsGBIwg+wfl4ga2g1fmCu5we
 xTHwiwCshS1tiWytKq3rJ8Gf8gy4OLEhU8SmK2V/pmFqekFiKkcoJjDcaEfR3J5zkQ4y7+o51
 3pG4eZsNkwVPlqNY6AFIxBdRjAx4JUV/jtnzFwyFVtBwidcklubqbKAskCN9/fv9HrvRfPRCj
 8mUq+y+rYGF+xcRTrnn9Ss6LjlQZELdJIVFeF6ZPiIQhq3+Bp70b6kjpI9xx1yC6cJhTow+sZ
 aLxldWLHr4Netf+wBREwlBZ6JAwT0Lnw8Fq/PlpahNHN7a35EAIi5IAe0KoOmtxwb+8hh0j0K
 8yDkRuI40AKMFUcx/IX9fN/azhNmuZs8zQEvhSdq6rh43AuHFSPSJu8+qIswYB2uvPPtaLl7e
 F3YH2HU446CZMBvc76BKyfaYItEMlYP8LiIhGqiYXMGbGHVSbxpCzCAEBtKgu90v0WVM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Support the V1.1 hardware revisions with the following change:

Changed power rail for MMC1 interface to a 3.3V/1.8V switchable rail in
order to be able to run UHS SD cards in ultra high speed 1.8V mode.

[  207.502011] mmc2: host does not support reading read-only switch,
 assuming write-enable
[  207.517011] mmc2: new ultra high speed SDR104 SDHC card at address
 aaaa
[  207.534190] mmcblk2: mmc2:aaaa SE32G 29.7 GiB
[  207.545096]  mmcblk2: p1

root@apalis-t30:~# cat /sys/kernel/debug/mmc2/ios
clock:          208000000 Hz
actual clock:   204000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    6 (sd uhs SDR104)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
root@apalis-t30:~# hdparm -t /dev/mmcblk2

/dev/mmcblk2:
 Timing buffered disk reads: 256 MB in  3.02 seconds =  84.71 MB/sec

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 Documentation/devicetree/bindings/arm/tegra.txt |    2 +
 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts  |  280 ++++++
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi      | 1189 +++++++++++++++++++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi           |    3 +-
 5 files changed, 1473 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index 32f62bb7006d..1073a5e66122 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -47,6 +47,8 @@ board-specific compatible values:
   nvidia,ventana
   toradex,apalis_t30
   toradex,apalis_t30-eval
+  toradex,apalis_t30-v1.1
+  toradex,apalis_t30-v1.1-eval
   toradex,apalis-tk1
   toradex,apalis-tk1-eval
   toradex,colibri_t20-512
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ea25a14f3bad..93de8ca32873 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1068,6 +1068,7 @@ dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
 	tegra20-ventana.dtb
 dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
 	tegra30-apalis-eval.dtb \
+	tegra30-apalis-v1.1-eval.dtb \
 	tegra30-beaver.dtb \
 	tegra30-cardhu-a02.dtb \
 	tegra30-cardhu-a04.dtb \
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts b/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
new file mode 100644
index 000000000000..bf952a09c650
--- /dev/null
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra30-apalis-v1.1.dtsi"
+
+/ {
+	model = "Toradex Apalis T30 on Apalis Evaluation Board";
+	compatible = "toradex,apalis_t30-v1.1-eval", "toradex,apalis_t30-eval",
+		     "toradex,apalis_t30-v1.1", "toradex,apalis_t30",
+		     "nvidia,tegra30";
+
+	aliases {
+		rtc0 = "/i2c@7000c000/rtc@68";
+		rtc1 = "/i2c@7000d000/tps65911@2d";
+		rtc2 = "/rtc@7000e000";
+		serial0 = &uarta;
+		serial1 = &uartb;
+		serial2 = &uartc;
+		serial3 = &uartd;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	pcie@3000 {
+		status = "okay";
+
+		pci@1,0 {
+			status = "okay";
+		};
+
+		pci@2,0 {
+			status = "okay";
+		};
+
+		pci@3,0 {
+			status = "okay";
+		};
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			rgb {
+				status = "okay";
+				nvidia,panel = <&panel>;
+			};
+		};
+		hdmi@54280000 {
+			status = "okay";
+			hdmi-supply = <&reg_5v0>;
+		};
+	};
+
+	/* Apalis UART1 */
+	serial@70006000 {
+		status = "okay";
+	};
+
+	/* Apalis UART2 */
+	serial@70006040 {
+		compatible = "nvidia,tegra30-hsuart";
+		status = "okay";
+	};
+
+	/* Apalis UART3 */
+	serial@70006200 {
+		compatible = "nvidia,tegra30-hsuart";
+		status = "okay";
+	};
+
+	/* Apalis UART4 */
+	serial@70006300 {
+		compatible = "nvidia,tegra30-hsuart";
+		status = "okay";
+	};
+
+	pwm@7000a000 {
+		status = "okay";
+	};
+
+	/*
+	 * GEN1_I2C: I2C1_SDA/SCL on MXM3 pin 209/211 (e.g. RTC on carrier
+	 * board)
+	 */
+	i2c@7000c000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		pcie-switch@58 {
+			compatible = "brcm,pex8605";
+			reg = <0x58>;
+		};
+
+		/* M41T0M6 real time clock on carrier board */
+		rtc@68 {
+			compatible = "st,m41t0";
+			reg = <0x68>;
+		};
+	};
+
+	/* GEN2_I2C: unused */
+
+	/*
+	 * CAM_I2C: I2C3_SDA/SCL on MXM3 pin 201/203 (e.g. camera sensor on
+	 * carrier board)
+	 */
+	i2c@7000c500 {
+		status = "okay";
+		clock-frequency = <400000>;
+	};
+
+	/* DDC: I2C2_SDA/SCL on MXM3 pin 205/207 (e.g. display EDID) */
+	hdmiddc: i2c@7000c700 {
+		status = "okay";
+	};
+
+	/* SPI1: Apalis SPI1 */
+	spi@7000d400 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+
+		spidev0: spidev@1 {
+			compatible = "spidev";
+			reg = <1>;
+			spi-max-frequency = <25000000>;
+		};
+	};
+
+	/* SPI5: Apalis SPI2 */
+	spi@7000dc00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+
+		spidev1: spidev@2 {
+			compatible = "spidev";
+			reg = <2>;
+			spi-max-frequency = <25000000>;
+		};
+	};
+
+	hda@70030000 {
+		status = "okay";
+	};
+
+	/* Apalis SD1 */
+	sdhci@78000000 {
+		status = "okay";
+		bus-width = <4>;
+		/* SD1_CD# */
+		cd-gpios = <&gpio TEGRA_GPIO(CC, 5) GPIO_ACTIVE_LOW>;
+		no-1-8-v;
+	};
+
+	/* Apalis MMC1 */
+	sdhci@78000400 {
+		status = "okay";
+		bus-width = <8>;
+		/* MMC1_CD# */
+		cd-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
+		vqmmc-supply = <&reg_vddio_sdmmc3>;
+	};
+
+	/* EHCI instance 0: USB1_DP/N -> USBO1_DP/N */
+	usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	usb-phy@7d000000 {
+		status = "okay";
+		vbus-supply = <&reg_usbo1_vbus>;
+	};
+
+	/* EHCI instance 1: USB2_DP/N -> USBH2_DP/N */
+	usb@7d004000 {
+		status = "okay";
+	};
+
+	usb-phy@7d004000 {
+		status = "okay";
+		vbus-supply = <&reg_usbh_vbus>;
+	};
+
+	/* EHCI instance 2: USB3_DP/N -> USBH3_DP/N */
+	usb@7d008000 {
+		status = "okay";
+	};
+
+	usb-phy@7d008000 {
+		status = "okay";
+		vbus-supply = <&reg_usbh_vbus>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <255 231 223 207 191 159 127 0>;
+		default-brightness-level = <6>;
+		/* BKL1_ON */
+		enable-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
+		pwms = <&pwm 0 5000000>; /* BKL1_PWM */
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		wakeup {
+			label = "WAKE1_MICO";
+			gpios = <&gpio TEGRA_GPIO(V, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
+	panel: panel {
+		/*
+		 * edt,et057090dhu: EDT 5.7" LCD TFT
+		 * edt,et070080dh6: EDT 7.0" LCD TFT
+		 */
+		compatible = "edt,et057090dhu", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V_SW";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_SW";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	/* USBO1_EN */
+	reg_usbo1_vbus: regulator-usbo1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USBO1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(T, 5) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_5v0>;
+	};
+
+	/* USBH_EN */
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USBH(2A|2C|2D|3|4)";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(DD, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_5v0>;
+	};
+
+	/*
+	 * 1.8 volt resp. 3.3 volt VDDIO_SDMMC3 depending on
+	 * EN_+3.3_SDMMC3 GPIO
+	 */
+	reg_vddio_sdmmc3: regulator-vddio-sdmmc3 {
+		compatible = "regulator-gpio";
+		regulator-name = "VDDIO_SDMMC3";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-type = "voltage";
+		gpios = <&gpio TEGRA_GPIO(J, 5) GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0
+			  3300000 0x1>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vddio_sdmmc_1v8_reg>;
+	};
+};
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
new file mode 100644
index 000000000000..8b69e9185cee
--- /dev/null
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
@@ -0,0 +1,1189 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+#include "tegra30.dtsi"
+
+/*
+ * Toradex Apalis T30 Module Device Tree
+ * Compatible for Revisions 1GB: V1.1A, V1.1B; 1GB IT: V1.1A, V1.1B;
+ * 2GB: V1.1A, V1.1B
+ */
+/ {
+	model = "Toradex Apalis T30";
+	compatible = "toradex,apalis_t30", "nvidia,tegra30";
+
+	memory@80000000 {
+		reg = <0x80000000 0x40000000>;
+	};
+
+	pcie@3000 {
+		avdd-pexa-supply = <&vdd2_reg>;
+		avdd-pexb-supply = <&vdd2_reg>;
+		avdd-pex-pll-supply = <&vdd2_reg>;
+		avdd-plle-supply = <&ldo6_reg>;
+		hvdd-pex-supply = <&reg_module_3v3>;
+		vddio-pex-ctl-supply = <&reg_module_3v3>;
+		vdd-pexa-supply = <&vdd2_reg>;
+		vdd-pexb-supply = <&vdd2_reg>;
+
+		/* Apalis type specific */
+		pci@1,0 {
+			nvidia,num-lanes = <4>;
+		};
+
+		/* Apalis PCIe */
+		pci@2,0 {
+			nvidia,num-lanes = <1>;
+		};
+
+		/* I210/I211 Gigabit Ethernet Controller (on-module) */
+		pci@3,0 {
+			nvidia,num-lanes = <1>;
+			pcie@0 {
+				reg = <0 0 0 0 0>;
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
+
+	host1x@50000000 {
+		hdmi@54280000 {
+			nvidia,ddc-i2c-bus = <&hdmiddc>;
+			nvidia,hpd-gpio =
+				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+			pll-supply = <&reg_1v8_avdd_hdmi_pll>;
+			vdd-supply = <&reg_3v3_avdd_hdmi>;
+		};
+	};
+
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* Analogue Audio (On-module) */
+			clk1_out_pw4 {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap3_fs_pp0 {
+				nvidia,pins = "dap3_fs_pp0",
+					      "dap3_sclk_pp3",
+					      "dap3_din_pp1",
+					      "dap3_dout_pp2";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis BKL1_ON */
+			pv2 {
+				nvidia,pins = "pv2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis BKL1_PWM */
+			uart3_rts_n_pc0 {
+				nvidia,pins = "uart3_rts_n_pc0";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/* BKL1_PWM_EN#, disable TPS65911 PMIC PWM backlight */
+			uart3_cts_n_pa1 {
+				nvidia,pins = "uart3_cts_n_pa1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis CAN1 on SPI6 */
+			spi2_cs0_n_px3 {
+				nvidia,pins = "spi2_cs0_n_px3",
+					      "spi2_miso_px1",
+					      "spi2_mosi_px0",
+					      "spi2_sck_px2";
+				nvidia,function = "spi6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			/* CAN_INT1 */
+			spi2_cs1_n_pw2 {
+				nvidia,pins = "spi2_cs1_n_pw2";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis CAN2 on SPI4 */
+			gmi_a16_pj7 {
+				nvidia,pins = "gmi_a16_pj7",
+					      "gmi_a17_pb0",
+					      "gmi_a18_pb1",
+					      "gmi_a19_pk7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* CAN_INT2 */
+			spi2_cs2_n_pw3 {
+				nvidia,pins = "spi2_cs2_n_pw3";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis Digital Audio */
+			clk1_req_pee2 {
+				nvidia,pins = "clk1_req_pee2";
+				nvidia,function = "hda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			clk2_out_pw5 {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "extperiph2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap1_fs_pn0 {
+				nvidia,pins = "dap1_fs_pn0",
+					      "dap1_din_pn1",
+					      "dap1_dout_pn2",
+					      "dap1_sclk_pn3";
+				nvidia,function = "hda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis GPIO */
+			kb_col0_pq0 {
+				nvidia,pins = "kb_col0_pq0",
+					      "kb_col1_pq1",
+					      "kb_row10_ps2",
+					      "kb_row11_ps3",
+					      "kb_row12_ps4",
+					      "kb_row13_ps5",
+					      "kb_row14_ps6",
+					      "kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* Multiplexed and therefore disabled */
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis HDMI1 */
+			hdmi_cec_pee3 {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+			hdmi_int_pn7 {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis I2C1 */
+			gen1_i2c_scl_pc4 {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+					      "gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis I2C2 (DDC) */
+			ddc_scl_pv4 {
+				nvidia,pins = "ddc_scl_pv4",
+					      "ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis I2C3 (CAM) */
+			cam_i2c_scl_pbb1 {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+					      "cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis LCD1 */
+			lcd_d0_pe0 {
+				nvidia,pins = "lcd_d0_pe0",
+					      "lcd_d1_pe1",
+					      "lcd_d2_pe2",
+					      "lcd_d3_pe3",
+					      "lcd_d4_pe4",
+					      "lcd_d5_pe5",
+					      "lcd_d6_pe6",
+					      "lcd_d7_pe7",
+					      "lcd_d8_pf0",
+					      "lcd_d9_pf1",
+					      "lcd_d10_pf2",
+					      "lcd_d11_pf3",
+					      "lcd_d12_pf4",
+					      "lcd_d13_pf5",
+					      "lcd_d14_pf6",
+					      "lcd_d15_pf7",
+					      "lcd_d16_pm0",
+					      "lcd_d17_pm1",
+					      "lcd_d18_pm2",
+					      "lcd_d19_pm3",
+					      "lcd_d20_pm4",
+					      "lcd_d21_pm5",
+					      "lcd_d22_pm6",
+					      "lcd_d23_pm7",
+					      "lcd_de_pj1",
+					      "lcd_hsync_pj3",
+					      "lcd_pclk_pb3",
+					      "lcd_vsync_pj4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis MMC1 */
+			sdmmc3_clk_pa6 {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			sdmmc3_dat0_pb7 {
+				nvidia,pins = "sdmmc3_cmd_pa7",
+					      "sdmmc3_dat0_pb7",
+					      "sdmmc3_dat1_pb6",
+					      "sdmmc3_dat2_pb5",
+					      "sdmmc3_dat3_pb4",
+					      "sdmmc3_dat4_pd1",
+					      "sdmmc3_dat5_pd0",
+					      "sdmmc3_dat6_pd3",
+					      "sdmmc3_dat7_pd4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			/* Apalis MMC1_CD# */
+			pv3 {
+				nvidia,pins = "pv3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis Parallel Camera */
+			cam_mclk_pcc0 {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			vi_vsync_pd6 {
+				nvidia,pins = "vi_d0_pt4",
+					      "vi_d1_pd5",
+					      "vi_d2_pl0",
+					      "vi_d3_pl1",
+					      "vi_d4_pl2",
+					      "vi_d5_pl3",
+					      "vi_d6_pl4",
+					      "vi_d7_pl5",
+					      "vi_d8_pl6",
+					      "vi_d9_pl7",
+					      "vi_d10_pt2",
+					      "vi_d11_pt3",
+					      "vi_hsync_pd7",
+					      "vi_pclk_pt0",
+					      "vi_vsync_pd6";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* Multiplexed and therefore disabled */
+			kb_col2_pq2 {
+				nvidia,pins = "kb_col2_pq2",
+					      "kb_col3_pq3",
+					      "kb_col4_pq4",
+					      "kb_row4_pr4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb_row0_pr0 {
+				nvidia,pins = "kb_row0_pr0",
+					      "kb_row1_pr1",
+					      "kb_row2_pr2",
+					      "kb_row3_pr3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb_row5_pr5 {
+				nvidia,pins = "kb_row5_pr5",
+					      "kb_row6_pr6",
+					      "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/*
+			 * VI level-shifter direction
+			 * (pull-down => default direction input)
+			 */
+			vi_mclk_pt1 {
+				nvidia,pins = "vi_mclk_pt1";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis PWM1 */
+			pu6 {
+				nvidia,pins = "pu6";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis PWM2 */
+			pu5 {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis PWM3 */
+			pu4 {
+				nvidia,pins = "pu4";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis PWM4 */
+			pu3 {
+				nvidia,pins = "pu3";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis RESET_MOCI# */
+			gmi_rst_n_pi4 {
+				nvidia,pins = "gmi_rst_n_pi4";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis SATA1_ACT# */
+			pex_l0_prsnt_n_pdd0 {
+				nvidia,pins = "pex_l0_prsnt_n_pdd0";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis SD1 */
+			sdmmc1_clk_pz0 {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			sdmmc1_cmd_pz1 {
+				nvidia,pins = "sdmmc1_cmd_pz1",
+					      "sdmmc1_dat0_py7",
+					      "sdmmc1_dat1_py6",
+					      "sdmmc1_dat2_py5",
+					      "sdmmc1_dat3_py4";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			/* Apalis SD1_CD# */
+			clk2_req_pcc5 {
+				nvidia,pins = "clk2_req_pcc5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis SPDIF1 */
+			spdif_out_pk5 {
+				nvidia,pins = "spdif_out_pk5",
+					      "spdif_in_pk6";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis SPI1 */
+			spi1_sck_px5 {
+				nvidia,pins = "spi1_sck_px5",
+					      "spi1_mosi_px4",
+					      "spi1_miso_px7",
+					      "spi1_cs0_n_px6";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis SPI2 */
+			lcd_sck_pz4 {
+				nvidia,pins = "lcd_sck_pz4",
+					      "lcd_sdout_pn5",
+					      "lcd_sdin_pz2",
+					      "lcd_cs0_n_pn4";
+				nvidia,function = "spi5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/*
+			 * Apalis TS (Low-speed type specific)
+			 * pins may be used as GPIOs
+			 */
+			kb_col5_pq5 {
+				nvidia,pins = "kb_col5_pq5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb_col6_pq6 {
+				nvidia,pins = "kb_col6_pq6",
+					      "kb_col7_pq7",
+					      "kb_row8_ps0",
+					      "kb_row9_ps1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis UART1 */
+			ulpi_data0 {
+				nvidia,pins = "ulpi_data0_po1",
+					      "ulpi_data1_po2",
+					      "ulpi_data2_po3",
+					      "ulpi_data3_po4",
+					      "ulpi_data4_po5",
+					      "ulpi_data5_po6",
+					      "ulpi_data6_po7",
+					      "ulpi_data7_po0";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis UART2 */
+			ulpi_clk_py0 {
+				nvidia,pins = "ulpi_clk_py0",
+					      "ulpi_dir_py1",
+					      "ulpi_nxt_py2",
+					      "ulpi_stp_py3";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis UART3 */
+			uart2_rxd_pc3 {
+				nvidia,pins = "uart2_rxd_pc3",
+					      "uart2_txd_pc2";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis UART4 */
+			uart3_rxd_pw7 {
+				nvidia,pins = "uart3_rxd_pw7",
+					      "uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis USBH_EN */
+			pex_l0_rst_n_pdd1 {
+				nvidia,pins = "pex_l0_rst_n_pdd1";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis USBH_OC# */
+			pex_l0_clkreq_n_pdd2 {
+				nvidia,pins = "pex_l0_clkreq_n_pdd2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis USBO1_EN */
+			gen2_i2c_scl_pt5 {
+				nvidia,pins = "gen2_i2c_scl_pt5";
+				nvidia,function = "rsvd4";
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis USBO1_OC# */
+			gen2_i2c_sda_pt6 {
+				nvidia,pins = "gen2_i2c_sda_pt6";
+				nvidia,function = "rsvd4";
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis VGA1 not supported and therefore disabled */
+			crt_hsync_pv6 {
+				nvidia,pins = "crt_hsync_pv6",
+					      "crt_vsync_pv7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis WAKE1_MICO */
+			pv1 {
+				nvidia,pins = "pv1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* eMMC (On-module) */
+			sdmmc4_clk_pcc4 {
+				nvidia,pins = "sdmmc4_clk_pcc4",
+					      "sdmmc4_cmd_pt7",
+					      "sdmmc4_rst_n_pcc3";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4_dat0_paa0 {
+				nvidia,pins = "sdmmc4_dat0_paa0",
+					      "sdmmc4_dat1_paa1",
+					      "sdmmc4_dat2_paa2",
+					      "sdmmc4_dat3_paa3",
+					      "sdmmc4_dat4_paa4",
+					      "sdmmc4_dat5_paa5",
+					      "sdmmc4_dat6_paa6",
+					      "sdmmc4_dat7_paa7";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* EN_+3.3_SDMMC3 */
+			uart2_cts_n_pj5 {
+				nvidia,pins = "uart2_cts_n_pj5";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* LAN i210/i211 DEV_OFF_N, PE_RST_N (On-module) */
+			pex_l2_prsnt_n_pdd7 {
+				nvidia,pins = "pex_l2_prsnt_n_pdd7",
+					      "pex_l2_rst_n_pcc6";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/* LAN i210/i211 PE_WAKE_N, SDP3 (On-module) */
+			pex_wake_n_pdd3 {
+				nvidia,pins = "pex_wake_n_pdd3",
+					      "pex_l2_clkreq_n_pcc7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* LAN i210/i211 SMB_ALERT_N (On-module) */
+			sys_clk_req_pz5 {
+				nvidia,pins = "sys_clk_req_pz5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* LVDS Transceiver Configuration */
+			pbb0 {
+				nvidia,pins = "pbb0",
+					      "pbb7",
+					      "pcc1",
+					      "pcc2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pbb3 {
+				nvidia,pins = "pbb3",
+					      "pbb4",
+					      "pbb5",
+					      "pbb6";
+				nvidia,function = "displayb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Not connected and therefore disabled */
+			clk_32k_out_pa0 {
+				nvidia,pins = "clk3_out_pee0",
+					      "clk3_req_pee1",
+					      "clk_32k_out_pa0",
+					      "dap4_din_pp5",
+					      "dap4_dout_pp6",
+					      "dap4_fs_pp4",
+					      "dap4_sclk_pp7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap2_fs_pa2 {
+				nvidia,pins = "dap2_fs_pa2",
+					      "dap2_sclk_pa3",
+					      "dap2_din_pa4",
+					      "dap2_dout_pa5",
+					      "lcd_dc0_pn6",
+					      "lcd_m1_pw1",
+					      "lcd_pwr1_pc1",
+					      "pex_l1_clkreq_n_pdd6",
+					      "pex_l1_prsnt_n_pdd4",
+					      "pex_l1_rst_n_pdd5";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_ad0_pg0 {
+				nvidia,pins = "gmi_ad0_pg0",
+					      "gmi_ad2_pg2",
+					      "gmi_ad3_pg3",
+					      "gmi_ad4_pg4",
+					      "gmi_ad5_pg5",
+					      "gmi_ad6_pg6",
+					      "gmi_ad7_pg7",
+					      "gmi_ad8_ph0",
+					      "gmi_ad9_ph1",
+					      "gmi_ad10_ph2",
+					      "gmi_ad11_ph3",
+					      "gmi_ad12_ph4",
+					      "gmi_ad13_ph5",
+					      "gmi_ad14_ph6",
+					      "gmi_ad15_ph7",
+					      "gmi_adv_n_pk0",
+					      "gmi_clk_pk1",
+					      "gmi_cs4_n_pk2",
+					      "gmi_cs2_n_pk3",
+					      "gmi_dqs_pi2",
+					      "gmi_iordy_pi5",
+					      "gmi_oe_n_pi1",
+					      "gmi_wait_pi7",
+					      "gmi_wr_n_pi0",
+					      "lcd_cs1_n_pw0",
+					      "pu0",
+					      "pu1",
+					      "pu2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_cs0_n_pj0 {
+				nvidia,pins = "gmi_cs0_n_pj0",
+					      "gmi_cs1_n_pj2",
+					      "gmi_cs3_n_pk4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_cs6_n_pi3 {
+				nvidia,pins = "gmi_cs6_n_pi3";
+				nvidia,function = "sata";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_cs7_n_pi6 {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "gmi_alt";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd_pwr0_pb2 {
+				nvidia,pins = "lcd_pwr0_pb2",
+					      "lcd_pwr2_pc6",
+					      "lcd_wr_n_pz3";
+				nvidia,function = "hdcp";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			uart2_rts_n_pj6 {
+				nvidia,pins = "uart2_rts_n_pj6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Power I2C (On-module) */
+			pwr_i2c_scl_pz6 {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+					      "pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			/*
+			 * THERMD_ALERT#, unlatched I2C address pin of LM95245
+			 * temperature sensor therefore requires disabling for
+			 * now
+			 */
+			lcd_dc1_pd2 {
+				nvidia,pins = "lcd_dc1_pd2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* TOUCH_PEN_INT# (On-module) */
+			pv0 {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
+
+	hdmiddc: i2c@7000c700 {
+		clock-frequency = <10000>;
+	};
+
+	/*
+	 * PWR_I2C: power I2C to audio codec, PMIC, temperature sensor and
+	 * touch screen controller
+	 */
+	i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <100000>;
+
+		/* SGTL5000 audio codec */
+		sgtl5000: codec@a {
+			compatible = "fsl,sgtl5000";
+			reg = <0x0a>;
+			VDDA-supply = <&reg_module_3v3_audio>;
+			VDDD-supply = <&reg_1v8_vio>;
+			VDDIO-supply = <&reg_module_3v3>;
+			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
+		};
+
+		pmic: tps65911@2d {
+			compatible = "ti,tps65911";
+			reg = <0x2d>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			ti,system-power-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			vcc1-supply = <&reg_module_3v3>;
+			vcc2-supply = <&reg_module_3v3>;
+			vcc3-supply = <&reg_1v8_vio>;
+			vcc4-supply = <&reg_module_3v3>;
+			vcc5-supply = <&reg_module_3v3>;
+			vcc6-supply = <&reg_1v8_vio>;
+			vcc7-supply = <&reg_5v0_charge_pump>;
+			vccio-supply = <&reg_module_3v3>;
+
+			regulators {
+				vdd1_reg: vdd1 {
+					regulator-name = "+V1.35_VDDIO_DDR";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-always-on;
+				};
+
+				vdd2_reg: vdd2 {
+					regulator-name = "+V1.05";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+				};
+
+				vddctrl_reg: vddctrl {
+					regulator-name = "+V1.0_VDD_CPU";
+					regulator-min-microvolt = <1150000>;
+					regulator-max-microvolt = <1150000>;
+					regulator-always-on;
+				};
+
+				reg_1v8_vio: vio {
+					regulator-name = "+V1.8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				/*
+				 * 1.8 volt +VDDIO_SDMMC3 in case EN_+3.3_SDMMC3
+				 * is off
+				 */
+				vddio_sdmmc_1v8_reg: ldo1 {
+					regulator-name = "+VDDIO_SDMMC3_1V8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				/*
+				 * EN_+V3.3 switching via FET:
+				 * +V3.3_AUDIO_AVDD_S, +V3.3
+				 * see also +V3.3 fixed supply
+				 */
+				ldo2_reg: ldo2 {
+					regulator-name = "EN_+V3.3";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				ldo3_reg: ldo3 {
+					regulator-name = "+V1.2_CSI";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				ldo4_reg: ldo4 {
+					regulator-name = "+V1.2_VDD_RTC";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				/*
+				 * +V2.8_AVDD_VDAC:
+				 * only required for (unsupported) analog RGB
+				 */
+				ldo5_reg: ldo5 {
+					regulator-name = "+V2.8_AVDD_VDAC";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-always-on;
+				};
+
+				/*
+				 * +V1.05_AVDD_PLLE: avdd_plle should be 1.05V
+				 * but LDO6 can't set voltage in 50mV
+				 * granularity
+				 */
+				ldo6_reg: ldo6 {
+					regulator-name = "+V1.05_AVDD_PLLE";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+				};
+
+				ldo7_reg: ldo7 {
+					regulator-name = "+V1.2_AVDD_PLL";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				ldo8_reg: ldo8 {
+					regulator-name = "+V1.0_VDD_DDR_HS";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+			};
+		};
+
+		/* STMPE811 touch screen controller */
+		stmpe811@41 {
+			compatible = "st,stmpe811";
+			reg = <0x41>;
+			irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			id = <0>;
+			blocks = <0x5>;
+			irq-trigger = <0x1>;
+
+			stmpe_touchscreen {
+				compatible = "st,stmpe-ts";
+				/* 3.25 MHz ADC clock speed */
+				st,adc-freq = <1>;
+				/* 8 sample average control */
+				st,ave-ctrl = <3>;
+				/* 7 length fractional part in z */
+				st,fraction-z = <7>;
+				/*
+				 * 50 mA typical 80 mA max touchscreen drivers
+				 * current limit value
+				 */
+				st,i-drive = <1>;
+				/* 12-bit ADC */
+				st,mod-12b = <1>;
+				/* internal ADC reference */
+				st,ref-sel = <0>;
+				/* ADC converstion time: 80 clocks */
+				st,sample-time = <4>;
+				/* 1 ms panel driver settling time */
+				st,settling = <3>;
+				/* 5 ms touch detect interrupt delay */
+				st,touch-det-delay = <5>;
+			};
+		};
+
+		/*
+		 * LM95245 temperature sensor
+		 * Note: OVERT1# directly connected to TPS65911 PMIC PWRDN
+		 */
+		temp-sensor@4c {
+			compatible = "national,lm95245";
+			reg = <0x4c>;
+		};
+
+		/* SW: +V1.2_VDD_CORE */
+		tps62362@60 {
+			compatible = "ti,tps62362";
+			reg = <0x60>;
+
+			regulator-name = "tps62362-vout";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1400000>;
+			regulator-boot-on;
+			regulator-always-on;
+			ti,vsel0-state-low;
+			/* VSEL1: EN_CORE_DVFS_N low for DVFS */
+			ti,vsel1-state-low;
+		};
+	};
+
+	/* SPI4: CAN2 */
+	spi@7000da00 {
+		status = "okay";
+		spi-max-frequency = <10000000>;
+
+		can@1 {
+			compatible = "microchip,mcp2515";
+			reg = <1>;
+			clocks = <&clk16m>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_EDGE_RISING>;
+			spi-max-frequency = <10000000>;
+		};
+	};
+
+	/* SPI6: CAN1 */
+	spi@7000de00 {
+		status = "okay";
+		spi-max-frequency = <10000000>;
+
+		can@0 {
+			compatible = "microchip,mcp2515";
+			reg = <0>;
+			clocks = <&clk16m>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(W, 2) IRQ_TYPE_EDGE_RISING>;
+			spi-max-frequency = <10000000>;
+		};
+	};
+
+	pmc@7000e400 {
+		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <1>;
+		nvidia,cpu-pwr-good-time = <5000>;
+		nvidia,cpu-pwr-off-time = <5000>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <0>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
+
+		/* Set DEV_OFF bit in DCDC control register of TPS65911 PMIC */
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <4>;
+			nvidia,bus-addr = <0x2d>;
+			nvidia,reg-addr = <0x3e>;
+			nvidia,reg-data = <0x1>;
+		};
+	};
+
+	ahub@70080000 {
+		i2s@70080500 {
+			status = "okay";
+		};
+	};
+
+	/* eMMC */
+	sdhci@78000600 {
+		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		bus-width = <8>;
+		non-removable;
+		vmmc-supply = <&reg_module_3v3>; /* VCC */
+		vqmmc-supply = <&reg_1v8_vio>; /* VCCQ */
+		mmc-ddr-1_8v;
+
+		emmc: emmc@0 {
+			reg = <0>;
+			compatible = "mmc-card";
+			broken-hpi;
+		};
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock@0 {
+			compatible = "fixed-clock";
+			reg = <0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+
+		clk16m: clock@1 {
+			compatible = "fixed-clock";
+			reg = <1>;
+			#clock-cells = <0>;
+			clock-frequency = <16000000>;
+			clock-output-names = "clk16m";
+		};
+	};
+
+	reg_1v8_avdd_hdmi_pll: regulator-1v8-avdd-hdmi-pll {
+		compatible = "regulator-fixed";
+		regulator-name = "+V1.8_AVDD_HDMI_PLL";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_1v8_vio>;
+	};
+
+	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_AVDD_HDMI";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_module_3v3>;
+	};
+
+	reg_5v0_charge_pump: regulator-5v0-charge-pump {
+		compatible = "regulator-fixed";
+		regulator-name = "+V5.0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_module_3v3: regulator-module-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_module_3v3_audio: regulator-module-3v3-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_AUDIO_AVDD_S";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "toradex,tegra-audio-sgtl5000-apalis_t30",
+			     "nvidia,tegra-audio-sgtl5000";
+		nvidia,model = "Toradex Apalis T30";
+		nvidia,audio-routing =
+			"Headphone Jack", "HP_OUT",
+			"LINE_IN", "Line In Jack",
+			"MIC_IN", "Mic Jack";
+		nvidia,i2s-controller = <&tegra_i2s2>;
+		nvidia,audio-codec = <&sgtl5000>;
+		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
+	};
+};
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index ee6750247c57..4c0a313f6a9d 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -3,8 +3,7 @@
 
 /*
  * Toradex Apalis T30 Module Device Tree
- * Compatible for Revisions 1GB: V1.0A, V1.1A; 1GB IT: V1.1A;
- * 2GB: V1.0B, V1.0C, V1.0E, V1.1A
+ * Compatible for Revisions 1GB: V1.0A; 2GB: V1.0B, V1.0C, V1.0E
  */
 / {
 	model = "Toradex Apalis T30";
-- 
2.14.4

