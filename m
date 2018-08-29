Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33551C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432EB20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D75iiys5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432EB20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeH2Tnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:43:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41118 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeH2Tnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:43:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so5286835wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=GWB7N+kdrRSz7E9FW4Yt+iWssS9n8FGKqL/kITp6doE=;
        b=D75iiys5HwH//hMY3xhq4sDAjuaAJmi3YKDxoXdsakuWtCZQUDimWURugSI9aF1hcI
         Maa7ONYRT6mDVFVHLkd0Qd/1muFubq5BNSk/2D6QMqNAPWbhBWsJ5xU9JNEjs9km+r3y
         rXLqfsqZPv7LkLp2q/x2X/shhHjwyDbQKUPC1MLsXzCeL1NsqGZV9QBc9lcKdpqfZWF3
         HcW/9RUVUjiFZbUzOsjl4PGr3ZY8dJ4eRK86lcYW7s+dGrDZ+pSaQuDp9q1f7kSqv3OH
         vKUdkBJQ3RyZ1tbH9xu4UJWFDvtoFWeTK0QHxiLMgTSHJ+7yEjKafqNXxBC3DJYbI5Pv
         ifIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GWB7N+kdrRSz7E9FW4Yt+iWssS9n8FGKqL/kITp6doE=;
        b=tGkyu8dYloP2FHaCLHZxpVvQ94oV8IgsrWlK91u/8GRzfyPQfKpkt1x3o0mmRopliF
         MzHOu6p1YLIQCQzyINIT7E44WcysBZwrxWj3qLLvUUB9rFMgMnitADDGHUaQrS4NuVWN
         FATG54u+dxKstUvRE0lI6rDJXn3Fm5FWNlxbxm4AWzqn0RS9MshT/nsRuK+tnL0227lJ
         Aqb9h28xbT7mmHdqTBkohsIgwFhAIdVpZ6WEw0fZjFWdqapF9rvZUOPTSaPzOv8WSqBf
         Jkmo06cL/JFUORflgwjhJq3HF1KLlvLMotoTcv+6a54ozJwjU8zl5lky/lmx0TF5fKZG
         pKXA==
X-Gm-Message-State: APzg51AqveR4OlsAME0gbyhDgW5NGgOxEVEhNMKyerPbH0ZdFWkBYpOT
        2Mu1QoYBf+qHGK1sLP8uI47T+g==
X-Google-Smtp-Source: ANB0VdZI2o/QgXXXXwWJ+MK1T6ukoBwNMCkreNuKX7ek2WZd6Y7pLdmQojg5P/hKxYxdoKSPOjeWCQ==
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr4598244wrf.46.1535557564200;
        Wed, 29 Aug 2018 08:46:04 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x16-v6sm2623531wro.84.2018.08.29.08.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 08:46:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: meson-axg: sort nodes consistently
Date:   Wed, 29 Aug 2018 17:45:51 +0200
Message-Id: <20180829154551.26729-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort DT nodes by address when possible, by node node name otherwise.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Hi Kevin,

This patch is same kind of clean-up we already did on gxbb and gxl some
time ago. In the same fashion, it ends up being and ugly and almost unreadable
patch, sorry about that :( I don't think there was a way to avoid it.

The patch applies on top v4.19-rc1 + 3 DT audio patches which are in your
v4.19/dt64 branch [0]

There should be no functional change after applying this patch.
I've tested it in on the s400 and so far, so good.

[0]: https://lkml.kernel.org/r/20180801134033.21739-1-jbrunet@baylibre.com

---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  212 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 1758 ++++++++---------
 2 files changed, 985 insertions(+), 985 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d399078d1f0c..ff64c429d432 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -60,6 +60,37 @@
 		serial1 = &uart_A;
 	};
 
+	linein: audio-codec@0 {
+		#sound-dai-cells = <0>;
+		compatible = "everest,es7241";
+		VDDA-supply = <&vcc_3v3>;
+		VDDP-supply = <&vcc_3v3>;
+		VDDD-supply = <&vcc_3v3>;
+		status = "okay";
+		sound-name-prefix = "Linein";
+	};
+
+	lineout: audio-codec@1 {
+		#sound-dai-cells = <0>;
+		compatible = "everest,es7154";
+		VDD-supply = <&vcc_3v3>;
+		PVDD-supply = <&vcc_5v>;
+		status = "okay";
+		sound-name-prefix = "Lineout";
+	};
+
+	spdif_dit: audio-codec@2 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
 	main_12v: regulator-main_12v {
 		compatible = "regulator-fixed";
 		regulator-name = "12V";
@@ -68,15 +99,26 @@
 		regulator-always-on;
 	};
 
-	vddio_boot: regulator-vddio_boot {
+	vcc_3v3: regulator-vcc_3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "VDDIO_BOOT";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vddao_3v3>;
 		regulator-always-on;
 	};
 
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&main_12v>;
+
+		gpio = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	vddao_3v3: regulator-vddao_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDAO_3V3";
@@ -95,26 +137,15 @@
 		regulator-always-on;
 	};
 
-	vcc_3v3: regulator-vcc_3v3 {
+	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
 		vin-supply = <&vddao_3v3>;
 		regulator-always-on;
 	};
 
-	vcc_5v: regulator-vcc_5v {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC5V";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&main_12v>;
-
-		gpio = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	usb_pwr: regulator-usb_pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "USB_PWR";
@@ -126,11 +157,6 @@
 		enable-active-high;
 	};
 
-	emmc_pwrseq: emmc-pwrseq {
-		compatible = "mmc-pwrseq-emmc";
-		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
-	};
-
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
@@ -138,13 +164,6 @@
 		clock-names = "ext_clock";
 	};
 
-	wifi32k: wifi32k {
-		compatible = "pwm-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
-	};
-
 	speaker-leds {
 		compatible = "gpio-leds";
 
@@ -179,32 +198,6 @@
 		};
 	};
 
-	linein: audio-codec@0 {
-		#sound-dai-cells = <0>;
-		compatible = "everest,es7241";
-		VDDA-supply = <&vcc_3v3>;
-		VDDP-supply = <&vcc_3v3>;
-		VDDD-supply = <&vcc_3v3>;
-		status = "okay";
-		sound-name-prefix = "Linein";
-	};
-
-	lineout: audio-codec@1 {
-		#sound-dai-cells = <0>;
-		compatible = "everest,es7154";
-		VDD-supply = <&vcc_3v3>;
-		PVDD-supply = <&vcc_5v>;
-		status = "okay";
-		sound-name-prefix = "Lineout";
-	};
-
-	spdif_dit: audio-codec@2 {
-		#sound-dai-cells = <0>;
-		compatible = "linux,spdif-dit";
-		status = "okay";
-		sound-name-prefix = "DIT";
-	};
-
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "AXG-S400";
@@ -311,6 +304,13 @@
 			};
 		};
 	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
+	};
 };
 
 &ethmac {
@@ -345,18 +345,6 @@
 	status = "okay";
 };
 
-&uart_A {
-	status = "okay";
-	pinctrl-0 = <&uart_a_pins>;
-	pinctrl-names = "default";
-};
-
-&uart_AO {
-	status = "okay";
-	pinctrl-0 = <&uart_ao_a_pins>;
-	pinctrl-names = "default";
-};
-
 &ir {
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
@@ -403,24 +391,9 @@
 	pinctrl-names = "default";
 };
 
-/* emmc storage */
-&sd_emmc_c {
+&saradc {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
-	pinctrl-1 = <&emmc_clk_gate_pins>;
-	pinctrl-names = "default", "clk-gate";
-
-	bus-width = <8>;
-	cap-sd-highspeed;
-	cap-mmc-highspeed;
-	max-frequency = <180000000>;
-	non-removable;
-	disable-wp;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&vddio_boot>;
+	vref-supply = <&vddio_ao18>;
 };
 
 /* wifi module */
@@ -450,9 +423,24 @@
 	};
 };
 
-&saradc {
+/* emmc storage */
+&sd_emmc_c {
 	status = "okay";
-	vref-supply = <&vddio_ao18>;
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	max-frequency = <180000000>;
+	non-removable;
+	disable-wp;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vddio_boot>;
 };
 
 &spdifout {
@@ -461,45 +449,45 @@
 	status = "okay";
 };
 
-&tdmin_a {
+&tdmif_a {
+	pinctrl-0 = <&tdma_sclk_pins>, <&tdma_fs_pins>,
+		    <&tdma_din0_pins>, <&tdma_dout0_x15_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 };
 
-&tdmin_b {
+&tdmif_b {
+	pinctrl-0 = <&tdmb_sclk_pins>, <&tdmb_fs_pins>,
+		    <&tdmb_din3_pins>, <&mclk_b_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 };
 
-&tdmin_c {
+&tdmif_c {
+	pinctrl-0 = <&tdmc_sclk_pins>, <&tdmc_fs_pins>,
+		    <&tdmc_din1_pins>, <&tdmc_dout2_pins>,
+		    <&mclk_c_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 };
 
-&tdmin_lb {
+&tdmin_a {
 	status = "okay";
 };
 
-&tdmout_c {
+&tdmin_b {
 	status = "okay";
 };
 
-&tdmif_a {
-	pinctrl-0 = <&tdma_sclk_pins>, <&tdma_fs_pins>,
-		    <&tdma_din0_pins>, <&tdma_dout0_x15_pins>;
-	pinctrl-names = "default";
+&tdmin_c {
 	status = "okay";
 };
 
-&tdmif_b {
-	pinctrl-0 = <&tdmb_sclk_pins>, <&tdmb_fs_pins>,
-		    <&tdmb_din3_pins>, <&mclk_b_pins>;
-	pinctrl-names = "default";
+&tdmin_lb {
 	status = "okay";
 };
 
-&tdmif_c {
-	pinctrl-0 = <&tdmc_sclk_pins>, <&tdmc_fs_pins>,
-		    <&tdmc_din1_pins>, <&tdmc_dout2_pins>,
-		    <&mclk_c_pins>;
-	pinctrl-names = "default";
+&tdmout_c {
 	status = "okay";
 };
 
@@ -514,3 +502,15 @@
 &toddr_c {
 	status = "okay";
 };
+
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>;
+	pinctrl-names = "default";
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 32f6dcacc2bc..36be63d69e7f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -3,15 +3,15 @@
  * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
  */
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axg-aoclkc.h>
 #include <dt-bindings/clock/axg-audio-clkc.h>
 #include <dt-bindings/clock/axg-clkc.h>
-#include <dt-bindings/clock/axg-aoclkc.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/meson-axg-gpio.h>
-#include <dt-bindings/reset/amlogic,meson-axg-reset.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
+#include <dt-bindings/reset/amlogic,meson-axg-reset.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -20,22 +20,53 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
+	tdmif_a: audio-controller@0 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_A";
+		clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
+		clock-names = "mclk", "sclk", "lrclk";
+		status = "disabled";
+	};
 
-		/* 16 MiB reserved for Hardware ROM Firmware */
-		hwrom_reserved: hwrom@0 {
-			reg = <0x0 0x0 0x0 0x1000000>;
-			no-map;
-		};
+	tdmif_b: audio-controller@1 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_B";
+		clocks = <&clkc_audio AUD_CLKID_MST_B_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>;
+		clock-names = "mclk", "sclk", "lrclk";
+		status = "disabled";
+	};
 
-		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
-		secmon_reserved: secmon@5000000 {
-			reg = <0x0 0x05000000 0x0 0x300000>;
-			no-map;
-		};
+	tdmif_c: audio-controller@2 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_C";
+		clocks = <&clkc_audio AUD_CLKID_MST_C_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_LRCLK>;
+		clock-names = "mclk", "sclk", "lrclk";
+		status = "disabled";
+	};
+
+	ao_alt_xtal: ao_alt_xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <32000000>;
+		clock-output-names = "ao_alt_xtal";
+		#clock-cells = <0>;
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
 	};
 
 	cpus {
@@ -79,77 +110,27 @@
 		};
 	};
 
-	arm-pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
-	};
-
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 	};
 
-	tdmif_a: audio-controller@0 {
-		compatible = "amlogic,axg-tdm-iface";
-		#sound-dai-cells = <0>;
-		sound-name-prefix = "TDM_A";
-		clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
-			 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
-			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
-		clock-names = "mclk", "sclk", "lrclk";
-		status = "disabled";
-	};
-
-	tdmif_b: audio-controller@1 {
-		compatible = "amlogic,axg-tdm-iface";
-		#sound-dai-cells = <0>;
-		sound-name-prefix = "TDM_B";
-		clocks = <&clkc_audio AUD_CLKID_MST_B_MCLK>,
-			 <&clkc_audio AUD_CLKID_MST_B_SCLK>,
-			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>;
-		clock-names = "mclk", "sclk", "lrclk";
-		status = "disabled";
-	};
-
-	tdmif_c: audio-controller@2 {
-		compatible = "amlogic,axg-tdm-iface";
-		#sound-dai-cells = <0>;
-		sound-name-prefix = "TDM_C";
-		clocks = <&clkc_audio AUD_CLKID_MST_C_MCLK>,
-			 <&clkc_audio AUD_CLKID_MST_C_SCLK>,
-			 <&clkc_audio AUD_CLKID_MST_C_LRCLK>;
-		clock-names = "mclk", "sclk", "lrclk";
-		status = "disabled";
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
-	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
 
-	xtal: xtal-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "xtal";
-		#clock-cells = <0>;
-	};
+		/* 16 MiB reserved for Hardware ROM Firmware */
+		hwrom_reserved: hwrom@0 {
+			reg = <0x0 0x0 0x0 0x1000000>;
+			no-map;
+		};
 
-	ao_alt_xtal: ao_alt_xtal-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <32000000>;
-		clock-output-names = "ao_alt_xtal";
-		#clock-cells = <0>;
+		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
+		secmon_reserved: secmon@5000000 {
+			reg = <0x0 0x05000000 0x0 0x300000>;
+			no-map;
+		};
 	};
 
 	soc {
@@ -158,469 +139,127 @@
 		#size-cells = <2>;
 		ranges;
 
-		apb: apb@ffe00000 {
+		ethmac: ethernet@ff3f0000 {
+			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+			reg = <0x0 0xff3f0000 0x0 0x10000
+			       0x0 0xff634540 0x0 0x8>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "macirq";
+			clocks = <&clkc CLKID_ETH>,
+				 <&clkc CLKID_FCLK_DIV2>,
+				 <&clkc CLKID_MPLL2>;
+			clock-names = "stmmaceth", "clkin0", "clkin1";
+			status = "disabled";
+		};
+
+		periphs: bus@ff634000 {
 			compatible = "simple-bus";
-			reg = <0x0 0xffe00000 0x0 0x200000>;
+			reg = <0x0 0xff634000 0x0 0x2000>;
 			#address-cells = <2>;
 			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
+			ranges = <0x0 0x0 0x0 0xff634000 0x0 0x2000>;
 
-			sd_emmc_b: sd@5000 {
-				compatible = "amlogic,meson-axg-mmc";
-				reg = <0x0 0x5000 0x0 0x800>;
-				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
-				status = "disabled";
-				clocks = <&clkc CLKID_SD_EMMC_B>,
-					<&clkc CLKID_SD_EMMC_B_CLK0>,
-					<&clkc CLKID_FCLK_DIV2>;
-				clock-names = "core", "clkin0", "clkin1";
-				resets = <&reset RESET_SD_EMMC_B>;
+			hwrng: rng@18 {
+				compatible = "amlogic,meson-rng";
+				reg = <0x0 0x18 0x0 0x4>;
+				clocks = <&clkc CLKID_RNG0>;
+				clock-names = "core";
 			};
 
-			sd_emmc_c: mmc@7000 {
-				compatible = "amlogic,meson-axg-mmc";
-				reg = <0x0 0x7000 0x0 0x800>;
-				interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>;
-				status = "disabled";
-				clocks = <&clkc CLKID_SD_EMMC_C>,
-					<&clkc CLKID_SD_EMMC_C_CLK0>,
-					<&clkc CLKID_FCLK_DIV2>;
-				clock-names = "core", "clkin0", "clkin1";
-				resets = <&reset RESET_SD_EMMC_C>;
-			};
-		};
+			pinctrl_periphs: pinctrl@480 {
+				compatible = "amlogic,meson-axg-periphs-pinctrl";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
 
-		audio: bus@ff642000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xff642000 0x0 0x2000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff642000 0x0 0x2000>;
+				gpio: bank@480 {
+					reg = <0x0 0x00480 0x0 0x40>,
+					      <0x0 0x004e8 0x0 0x14>,
+					      <0x0 0x00520 0x0 0x14>,
+					      <0x0 0x00430 0x0 0x3c>;
+					reg-names = "mux", "pull", "pull-enable", "gpio";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-ranges = <&pinctrl_periphs 0 0 86>;
+				};
 
-			clkc_audio: clock-controller@0 {
-				compatible = "amlogic,axg-audio-clkc";
-				reg = <0x0 0x0 0x0 0xb4>;
-				#clock-cells = <1>;
+				i2c0_pins: i2c0 {
+					mux {
+						groups = "i2c0_sck",
+							 "i2c0_sda";
+						function = "i2c0";
+					};
+				};
 
-				clocks = <&clkc CLKID_AUDIO>,
-					 <&clkc CLKID_MPLL0>,
-					 <&clkc CLKID_MPLL1>,
-					 <&clkc CLKID_MPLL2>,
-					 <&clkc CLKID_MPLL3>,
-					 <&clkc CLKID_HIFI_PLL>,
-					 <&clkc CLKID_FCLK_DIV3>,
-					 <&clkc CLKID_FCLK_DIV4>,
-					 <&clkc CLKID_GP0_PLL>;
-				clock-names = "pclk",
-					      "mst_in0",
-					      "mst_in1",
-					      "mst_in2",
-					      "mst_in3",
-					      "mst_in4",
-					      "mst_in5",
-					      "mst_in6",
-					      "mst_in7";
+				i2c1_x_pins: i2c1_x {
+					mux {
+						groups = "i2c1_sck_x",
+							 "i2c1_sda_x";
+						function = "i2c1";
+					};
+				};
 
-				resets = <&reset RESET_AUDIO>;
-			};
+				i2c1_z_pins: i2c1_z {
+					mux {
+						groups = "i2c1_sck_z",
+							 "i2c1_sda_z";
+						function = "i2c1";
+					};
+				};
 
-			toddr_a: audio-controller@100 {
-				compatible = "amlogic,axg-toddr";
-				reg = <0x0 0x100 0x0 0x1c>;
-				#sound-dai-cells = <0>;
-				sound-name-prefix = "TODDR_A";
-				interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
-				resets = <&arb AXG_ARB_TODDR_A>;
-				status = "disabled";
-			};
-
-			toddr_b: audio-controller@140 {
-				compatible = "amlogic,axg-toddr";
-				reg = <0x0 0x140 0x0 0x1c>;
-				#sound-dai-cells = <0>;
-				sound-name-prefix = "TODDR_B";
-				interrupts = <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
-				resets = <&arb AXG_ARB_TODDR_B>;
-				status = "disabled";
-			};
-
-			toddr_c: audio-controller@180 {
-				compatible = "amlogic,axg-toddr";
-				reg = <0x0 0x180 0x0 0x1c>;
-				#sound-dai-cells = <0>;
-				sound-name-prefix = "TODDR_C";
-				interrupts = <GIC_SPI 86 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
-				resets = <&arb AXG_ARB_TODDR_C>;
-				status = "disabled";
-			};
-
-			frddr_a: audio-controller@1c0 {
-				compatible = "amlogic,axg-frddr";
-				reg = <0x0 0x1c0 0x0 0x1c>;
-				#sound-dai-cells = <0>;
-				sound-name-prefix = "FRDDR_A";
-				interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
-				resets = <&arb AXG_ARB_FRDDR_A>;
-				status = "disabled";
-			};
-
-			frddr_b: audio-controller@200 {
-				compatible = "amlogic,axg-frddr";
-				reg = <0x0 0x200 0x0 0x1c>;
-				#sound-dai-cells = <0>;
-				sound-name-prefix = "FRDDR_B";
-				interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
-				resets = <&arb AXG_ARB_FRDDR_B>;
-				status = "disabled";
-			};
-
-			frddr_c: audio-controller@240 {
-				compatible = "amlogic,axg-frddr";
-				reg = <0x0 0x240 0x0 0x1c>;
-				#sound-dai-cells = <0>;
-				sound-name-prefix = "FRDDR_C";
-				interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
-				resets = <&arb AXG_ARB_FRDDR_C>;
-				status = "disabled";
-			};
-
-			arb: reset-controller@280 {
-				compatible = "amlogic,meson-axg-audio-arb";
-				reg = <0x0 0x280 0x0 0x4>;
-				#reset-cells = <1>;
-				clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
-			};
-
-			tdmin_a: audio-controller@300 {
-				compatible = "amlogic,axg-tdmin";
-				reg = <0x0 0x300 0x0 0x40>;
-				sound-name-prefix = "TDMIN_A";
-				clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
-					 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
-					 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
-					 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
-					 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
-				clock-names = "pclk", "sclk", "sclk_sel",
-					      "lrclk", "lrclk_sel";
-				status = "disabled";
-			};
-
-			tdmin_b: audio-controller@340 {
-				compatible = "amlogic,axg-tdmin";
-				reg = <0x0 0x340 0x0 0x40>;
-				sound-name-prefix = "TDMIN_B";
-				clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
-					 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
-					 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
-					 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
-					 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
-				clock-names = "pclk", "sclk", "sclk_sel",
-					      "lrclk", "lrclk_sel";
-				status = "disabled";
-			};
-
-			tdmin_c: audio-controller@380 {
-				compatible = "amlogic,axg-tdmin";
-				reg = <0x0 0x380 0x0 0x40>;
-				sound-name-prefix = "TDMIN_C";
-				clocks = <&clkc_audio AUD_CLKID_TDMIN_C>,
-					 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
-					 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
-					 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>,
-					 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>;
-				clock-names = "pclk", "sclk", "sclk_sel",
-					      "lrclk", "lrclk_sel";
-				status = "disabled";
-			};
-
-			tdmin_lb: audio-controller@3c0 {
-				compatible = "amlogic,axg-tdmin";
-				reg = <0x0 0x3c0 0x0 0x40>;
-				sound-name-prefix = "TDMIN_LB";
-				clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
-					 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
-					 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
-					 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
-					 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
-				clock-names = "pclk", "sclk", "sclk_sel",
-					      "lrclk", "lrclk_sel";
-				status = "disabled";
-			};
-
-			spdifout: audio-controller@480 {
-				compatible = "amlogic,axg-spdifout";
-				reg = <0x0 0x480 0x0 0x50>;
-				#sound-dai-cells = <0>;
-				sound-name-prefix = "SPDIFOUT";
-				clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
-					 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
-				clock-names = "pclk", "mclk";
-				status = "disabled";
-			};
-
-			tdmout_a: audio-controller@500 {
-				compatible = "amlogic,axg-tdmout";
-				reg = <0x0 0x500 0x0 0x40>;
-				sound-name-prefix = "TDMOUT_A";
-				clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
-				clock-names = "pclk", "sclk", "sclk_sel",
-					      "lrclk", "lrclk_sel";
-				status = "disabled";
-			};
-
-			tdmout_b: audio-controller@540 {
-				compatible = "amlogic,axg-tdmout";
-				reg = <0x0 0x540 0x0 0x40>;
-				sound-name-prefix = "TDMOUT_B";
-				clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
-				clock-names = "pclk", "sclk", "sclk_sel",
-					      "lrclk", "lrclk_sel";
-				status = "disabled";
-			};
-
-			tdmout_c: audio-controller@580 {
-				compatible = "amlogic,axg-tdmout";
-				reg = <0x0 0x580 0x0 0x40>;
-				sound-name-prefix = "TDMOUT_C";
-				clocks = <&clkc_audio AUD_CLKID_TDMOUT_C>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>,
-					 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>;
-				clock-names = "pclk", "sclk", "sclk_sel",
-					      "lrclk", "lrclk_sel";
-				status = "disabled";
-			};
-		};
-
-		cbus: bus@ffd00000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xffd00000 0x0 0x25000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
-
-			gpio_intc: interrupt-controller@f080 {
-				compatible = "amlogic,meson-gpio-intc";
-				reg = <0x0 0xf080 0x0 0x10>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
-				status = "disabled";
-			};
-
-			pwm_ab: pwm@1b000 {
-				compatible = "amlogic,meson-axg-ee-pwm";
-				reg = <0x0 0x1b000 0x0 0x20>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			pwm_cd: pwm@1a000 {
-				compatible = "amlogic,meson-axg-ee-pwm";
-				reg = <0x0 0x1a000 0x0 0x20>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			reset: reset-controller@1004 {
-				compatible = "amlogic,meson-axg-reset";
-				reg = <0x0 0x01004 0x0 0x9c>;
-				#reset-cells = <1>;
-			};
-
-			spicc0: spi@13000 {
-				compatible = "amlogic,meson-axg-spicc";
-				reg = <0x0 0x13000 0x0 0x3c>;
-				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clkc CLKID_SPICC0>;
-				clock-names = "core";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				status = "disabled";
-			};
-
-			spicc1: spi@15000 {
-				compatible = "amlogic,meson-axg-spicc";
-				reg = <0x0 0x15000 0x0 0x3c>;
-				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clkc CLKID_SPICC1>;
-				clock-names = "core";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				status = "disabled";
-			};
-
-			i2c0: i2c@1f000 {
-				compatible = "amlogic,meson-axg-i2c";
-				reg = <0x0 0x1f000 0x0 0x20>;
-				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_I2C>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				status = "disabled";
-			};
-
-			i2c1: i2c@1e000 {
-				compatible = "amlogic,meson-axg-i2c";
-				reg = <0x0 0x1e000 0x0 0x20>;
-				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_I2C>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				status = "disabled";
-			};
-
-			i2c2: i2c@1d000 {
-				compatible = "amlogic,meson-axg-i2c";
-				reg = <0x0 0x1d000 0x0 0x20>;
-				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_I2C>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				status = "disabled";
-			};
-
-			i2c3: i2c@1c000 {
-				compatible = "amlogic,meson-axg-i2c";
-				reg = <0x0 0x1c000 0x0 0x20>;
-				interrupts = <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_I2C>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				status = "disabled";
-			};
-
-			uart_A: serial@24000 {
-				compatible = "amlogic,meson-gx-uart";
-				reg = <0x0 0x24000 0x0 0x18>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
-				status = "disabled";
-				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
-				clock-names = "xtal", "pclk", "baud";
-			};
-
-			uart_B: serial@23000 {
-				compatible = "amlogic,meson-gx-uart";
-				reg = <0x0 0x23000 0x0 0x18>;
-				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
-				status = "disabled";
-				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
-				clock-names = "xtal", "pclk", "baud";
-			};
-		};
-
-		ethmac: ethernet@ff3f0000 {
-			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
-			reg = <0x0 0xff3f0000 0x0 0x10000
-				0x0 0xff634540 0x0 0x8>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "macirq";
-			clocks = <&clkc CLKID_ETH>,
-				 <&clkc CLKID_FCLK_DIV2>,
-				 <&clkc CLKID_MPLL2>;
-			clock-names = "stmmaceth", "clkin0", "clkin1";
-			status = "disabled";
-		};
-
-		gic: interrupt-controller@ffc01000 {
-			compatible = "arm,gic-400";
-			reg = <0x0 0xffc01000 0 0x1000>,
-			      <0x0 0xffc02000 0 0x2000>,
-			      <0x0 0xffc04000 0 0x2000>,
-			      <0x0 0xffc06000 0 0x2000>;
-			interrupt-controller;
-			interrupts = <GIC_PPI 9
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-		};
-
-		hiubus: bus@ff63c000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xff63c000 0x0 0x1c00>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
-
-			sysctrl: system-controller@0 {
-				compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
-				reg = <0 0 0 0x400>;
-
-				clkc: clock-controller {
-					compatible = "amlogic,axg-clkc";
-					#clock-cells = <1>;
+				i2c2_a_pins: i2c2_a {
+					mux {
+						groups = "i2c2_sck_a",
+							 "i2c2_sda_a";
+						function = "i2c2";
+					};
 				};
-			};
-		};
-
-		mailbox: mailbox@ff63dc00 {
-			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
-			reg = <0 0xff63dc00 0 0x400>;
-			interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>;
-			#mbox-cells = <1>;
-		};
 
-		periphs: periphs@ff634000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xff634000 0x0 0x2000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff634000 0x0 0x2000>;
+				i2c2_x_pins: i2c2_x {
+					mux {
+						groups = "i2c2_sck_x",
+							 "i2c2_sda_x";
+						function = "i2c2";
+					};
+				};
 
-			hwrng: rng {
-				compatible = "amlogic,meson-rng";
-				reg = <0x0 0x18 0x0 0x4>;
-				clocks = <&clkc CLKID_RNG0>;
-				clock-names = "core";
-			};
+				i2c3_a6_pins: i2c3_a6 {
+					mux {
+						groups = "i2c3_sda_a6",
+							 "i2c3_sck_a7";
+						function = "i2c3";
+					};
+				};
 
-			pinctrl_periphs: pinctrl@480 {
-				compatible = "amlogic,meson-axg-periphs-pinctrl";
-				#address-cells = <2>;
-				#size-cells = <2>;
-				ranges;
+				i2c3_a12_pins: i2c3_a12 {
+					mux {
+						groups = "i2c3_sda_a12",
+							 "i2c3_sck_a13";
+						function = "i2c3";
+					};
+				};
 
-				gpio: bank@480 {
-					reg = <0x0 0x00480 0x0 0x40>,
-						<0x0 0x004e8 0x0 0x14>,
-						<0x0 0x00520 0x0 0x14>,
-						<0x0 0x00430 0x0 0x3c>;
-					reg-names = "mux", "pull", "pull-enable", "gpio";
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&pinctrl_periphs 0 0 86>;
+				i2c3_a19_pins: i2c3_a19 {
+					mux {
+						groups = "i2c3_sda_a19",
+							 "i2c3_sck_a20";
+						function = "i2c3";
+					};
 				};
 
 				emmc_pins: emmc {
 					mux {
 						groups = "emmc_nand_d0",
-							"emmc_nand_d1",
-							"emmc_nand_d2",
-							"emmc_nand_d3",
-							"emmc_nand_d4",
-							"emmc_nand_d5",
-							"emmc_nand_d6",
-							"emmc_nand_d7",
-							"emmc_clk",
-							"emmc_cmd",
-							"emmc_ds";
+							 "emmc_nand_d1",
+							 "emmc_nand_d2",
+							 "emmc_nand_d3",
+							 "emmc_nand_d4",
+							 "emmc_nand_d5",
+							 "emmc_nand_d6",
+							 "emmc_nand_d7",
+							 "emmc_clk",
+							 "emmc_cmd",
+							 "emmc_ds";
 						function = "emmc";
 					};
 				};
@@ -636,40 +275,57 @@
 					};
 				};
 
-				sdio_pins: sdio {
+				eth_rgmii_x_pins: eth-x-rgmii {
 					mux {
-						groups = "sdio_d0",
-							"sdio_d1",
-							"sdio_d2",
-							"sdio_d3",
-							"sdio_cmd",
-							"sdio_clk";
-						function = "sdio";
+						groups = "eth_mdio_x",
+							 "eth_mdc_x",
+							 "eth_rgmii_rx_clk_x",
+							 "eth_rx_dv_x",
+							 "eth_rxd0_x",
+							 "eth_rxd1_x",
+							 "eth_rxd2_rgmii",
+							 "eth_rxd3_rgmii",
+							 "eth_rgmii_tx_clk",
+							 "eth_txen_x",
+							 "eth_txd0_x",
+							 "eth_txd1_x",
+							 "eth_txd2_rgmii",
+							 "eth_txd3_rgmii";
+						function = "eth";
 					};
 				};
 
-				sdio_clk_gate_pins: sdio_clk_gate {
+				eth_rgmii_y_pins: eth-y-rgmii {
 					mux {
-						groups = "GPIOX_4";
-						function = "gpio_periphs";
-					};
-					cfg-pull-down {
-						pins = "GPIOX_4";
-						bias-pull-down;
+						groups = "eth_mdio_y",
+							 "eth_mdc_y",
+							 "eth_rgmii_rx_clk_y",
+							 "eth_rx_dv_y",
+							 "eth_rxd0_y",
+							 "eth_rxd1_y",
+							 "eth_rxd2_rgmii",
+							 "eth_rxd3_rgmii",
+							 "eth_rgmii_tx_clk",
+							 "eth_txen_y",
+							 "eth_txd0_y",
+							 "eth_txd1_y",
+							 "eth_txd2_rgmii",
+							 "eth_txd3_rgmii";
+						function = "eth";
 					};
 				};
 
 				eth_rmii_x_pins: eth-x-rmii {
 					mux {
 						groups = "eth_mdio_x",
-						       "eth_mdc_x",
-						       "eth_rgmii_rx_clk_x",
-						       "eth_rx_dv_x",
-						       "eth_rxd0_x",
-						       "eth_rxd1_x",
-						       "eth_txen_x",
-						       "eth_txd0_x",
-						       "eth_txd1_x";
+							 "eth_mdc_x",
+							 "eth_rgmii_rx_clk_x",
+							 "eth_rx_dv_x",
+							 "eth_rxd0_x",
+							 "eth_rxd1_x",
+							 "eth_txen_x",
+							 "eth_txd0_x",
+							 "eth_txd1_x";
 						function = "eth";
 					};
 				};
@@ -677,55 +333,29 @@
 				eth_rmii_y_pins: eth-y-rmii {
 					mux {
 						groups = "eth_mdio_y",
-						       "eth_mdc_y",
-						       "eth_rgmii_rx_clk_y",
-						       "eth_rx_dv_y",
-						       "eth_rxd0_y",
-						       "eth_rxd1_y",
-						       "eth_txen_y",
-						       "eth_txd0_y",
-						       "eth_txd1_y";
+							 "eth_mdc_y",
+							 "eth_rgmii_rx_clk_y",
+							 "eth_rx_dv_y",
+							 "eth_rxd0_y",
+							 "eth_rxd1_y",
+							 "eth_txen_y",
+							 "eth_txd0_y",
+							 "eth_txd1_y";
 						function = "eth";
 					};
 				};
 
-				eth_rgmii_x_pins: eth-x-rgmii {
+				mclk_b_pins: mclk_b {
 					mux {
-						groups = "eth_mdio_x",
-						       "eth_mdc_x",
-						       "eth_rgmii_rx_clk_x",
-						       "eth_rx_dv_x",
-						       "eth_rxd0_x",
-						       "eth_rxd1_x",
-						       "eth_rxd2_rgmii",
-						       "eth_rxd3_rgmii",
-						       "eth_rgmii_tx_clk",
-						       "eth_txen_x",
-						       "eth_txd0_x",
-						       "eth_txd1_x",
-						       "eth_txd2_rgmii",
-						       "eth_txd3_rgmii";
-						function = "eth";
+						groups = "mclk_b";
+						function = "mclk_b";
 					};
 				};
 
-				eth_rgmii_y_pins: eth-y-rgmii {
+				mclk_c_pins: mclk_c {
 					mux {
-						groups = "eth_mdio_y",
-						       "eth_mdc_y",
-						       "eth_rgmii_rx_clk_y",
-						       "eth_rx_dv_y",
-						       "eth_rxd0_y",
-						       "eth_rxd1_y",
-						       "eth_rxd2_rgmii",
-						       "eth_rxd3_rgmii",
-						       "eth_rgmii_tx_clk",
-						       "eth_txen_y",
-						       "eth_txd0_y",
-						       "eth_txd1_y",
-						       "eth_txd2_rgmii",
-						       "eth_txd3_rgmii";
-						function = "eth";
+						groups = "mclk_c";
+						function = "mclk_c";
 					};
 				};
 
@@ -855,298 +485,199 @@
 					};
 				};
 
-				spdif_in_z_pins: spdif_in_z {
+				sdio_pins: sdio {
 					mux {
-						groups = "spdif_in_z";
-						function = "spdif_in";
+						groups = "sdio_d0",
+							 "sdio_d1",
+							 "sdio_d2",
+							 "sdio_d3",
+							 "sdio_cmd",
+							 "sdio_clk";
+						function = "sdio";
 					};
 				};
 
-				spdif_in_a1_pins: spdif_in_a1 {
+				sdio_clk_gate_pins: sdio_clk_gate {
 					mux {
-						groups = "spdif_in_a1";
-						function = "spdif_in";
+						groups = "GPIOX_4";
+						function = "gpio_periphs";
 					};
-				};
-
-				spdif_in_a7_pins: spdif_in_a7 {
-					mux {
-						groups = "spdif_in_a7";
-						function = "spdif_in";
+					cfg-pull-down {
+						pins = "GPIOX_4";
+						bias-pull-down;
 					};
 				};
 
-				spdif_in_a19_pins: spdif_in_a19 {
+				spdif_in_z_pins: spdif_in_z {
 					mux {
-						groups = "spdif_in_a19";
+						groups = "spdif_in_z";
 						function = "spdif_in";
 					};
 				};
 
-				spdif_in_a20_pins: spdif_in_a20 {
+				spdif_in_a1_pins: spdif_in_a1 {
 					mux {
-						groups = "spdif_in_a20";
+						groups = "spdif_in_a1";
 						function = "spdif_in";
 					};
 				};
 
-				spdif_out_z_pins: spdif_out_z {
-					mux {
-						groups = "spdif_out_z";
-						function = "spdif_out";
-					};
-				};
-
-				spdif_out_a1_pins: spdif_out_a1 {
-					mux {
-						groups = "spdif_out_a1";
-						function = "spdif_out";
-					};
-				};
-
-				spdif_out_a11_pins: spdif_out_a11 {
-					mux {
-						groups = "spdif_out_a11";
-						function = "spdif_out";
-					};
-				};
-
-				spdif_out_a19_pins: spdif_out_a19 {
-					mux {
-						groups = "spdif_out_a19";
-						function = "spdif_out";
-					};
-				};
-
-				spdif_out_a20_pins: spdif_out_a20 {
-					mux {
-						groups = "spdif_out_a20";
-						function = "spdif_out";
-					};
-				};
-
-				spi0_pins: spi0 {
-					mux {
-						groups = "spi0_miso",
-							"spi0_mosi",
-							"spi0_clk";
-						function = "spi0";
-					};
-				};
-
-				spi0_ss0_pins: spi0_ss0 {
-					mux {
-						groups = "spi0_ss0";
-						function = "spi0";
-					};
-				};
-
-				spi0_ss1_pins: spi0_ss1 {
-					mux {
-						groups = "spi0_ss1";
-						function = "spi0";
-					};
-				};
-
-				spi0_ss2_pins: spi0_ss2 {
-					mux {
-						groups = "spi0_ss2";
-						function = "spi0";
-					};
-				};
-
-
-				spi1_a_pins: spi1_a {
-					mux {
-						groups = "spi1_miso_a",
-							"spi1_mosi_a",
-							"spi1_clk_a";
-						function = "spi1";
-					};
-				};
-
-				spi1_ss0_a_pins: spi1_ss0_a {
-					mux {
-						groups = "spi1_ss0_a";
-						function = "spi1";
-					};
-				};
-
-				spi1_ss1_pins: spi1_ss1 {
-					mux {
-						groups = "spi1_ss1";
-						function = "spi1";
-					};
-				};
-
-				spi1_x_pins: spi1_x {
+				spdif_in_a7_pins: spdif_in_a7 {
 					mux {
-						groups = "spi1_miso_x",
-							"spi1_mosi_x",
-							"spi1_clk_x";
-						function = "spi1";
+						groups = "spdif_in_a7";
+						function = "spdif_in";
 					};
 				};
 
-				spi1_ss0_x_pins: spi1_ss0_x {
+				spdif_in_a19_pins: spdif_in_a19 {
 					mux {
-						groups = "spi1_ss0_x";
-						function = "spi1";
+						groups = "spdif_in_a19";
+						function = "spdif_in";
 					};
 				};
 
-				i2c0_pins: i2c0 {
+				spdif_in_a20_pins: spdif_in_a20 {
 					mux {
-						groups = "i2c0_sck",
-							"i2c0_sda";
-						function = "i2c0";
+						groups = "spdif_in_a20";
+						function = "spdif_in";
 					};
 				};
 
-				i2c1_z_pins: i2c1_z {
+				spdif_out_a1_pins: spdif_out_a1 {
 					mux {
-						groups = "i2c1_sck_z",
-							"i2c1_sda_z";
-						function = "i2c1";
+						groups = "spdif_out_a1";
+						function = "spdif_out";
 					};
 				};
 
-				i2c1_x_pins: i2c1_x {
+				spdif_out_a11_pins: spdif_out_a11 {
 					mux {
-						groups = "i2c1_sck_x",
-							"i2c1_sda_x";
-						function = "i2c1";
+						groups = "spdif_out_a11";
+						function = "spdif_out";
 					};
 				};
 
-				i2c2_x_pins: i2c2_x {
+				spdif_out_a19_pins: spdif_out_a19 {
 					mux {
-						groups = "i2c2_sck_x",
-							"i2c2_sda_x";
-						function = "i2c2";
+						groups = "spdif_out_a19";
+						function = "spdif_out";
 					};
 				};
 
-				i2c2_a_pins: i2c2_a {
+				spdif_out_a20_pins: spdif_out_a20 {
 					mux {
-						groups = "i2c2_sck_a",
-							"i2c2_sda_a";
-						function = "i2c2";
+						groups = "spdif_out_a20";
+						function = "spdif_out";
 					};
 				};
 
-				i2c3_a6_pins: i2c3_a6 {
+				spdif_out_z_pins: spdif_out_z {
 					mux {
-						groups = "i2c3_sda_a6",
-							"i2c3_sck_a7";
-						function = "i2c3";
+						groups = "spdif_out_z";
+						function = "spdif_out";
 					};
 				};
 
-				i2c3_a12_pins: i2c3_a12 {
+				spi0_pins: spi0 {
 					mux {
-						groups = "i2c3_sda_a12",
-							"i2c3_sck_a13";
-						function = "i2c3";
+						groups = "spi0_miso",
+							 "spi0_mosi",
+							 "spi0_clk";
+						function = "spi0";
 					};
 				};
 
-				i2c3_a19_pins: i2c3_a19 {
+				spi0_ss0_pins: spi0_ss0 {
 					mux {
-						groups = "i2c3_sda_a19",
-							"i2c3_sck_a20";
-						function = "i2c3";
+						groups = "spi0_ss0";
+						function = "spi0";
 					};
 				};
 
-				uart_a_pins: uart_a {
+				spi0_ss1_pins: spi0_ss1 {
 					mux {
-						groups = "uart_tx_a",
-							"uart_rx_a";
-						function = "uart_a";
+						groups = "spi0_ss1";
+						function = "spi0";
 					};
 				};
 
-				uart_a_cts_rts_pins: uart_a_cts_rts {
+				spi0_ss2_pins: spi0_ss2 {
 					mux {
-						groups = "uart_cts_a",
-							"uart_rts_a";
-						function = "uart_a";
+						groups = "spi0_ss2";
+						function = "spi0";
 					};
 				};
 
-				uart_b_x_pins: uart_b_x {
+				spi1_a_pins: spi1_a {
 					mux {
-						groups = "uart_tx_b_x",
-							"uart_rx_b_x";
-						function = "uart_b";
+						groups = "spi1_miso_a",
+							 "spi1_mosi_a",
+							 "spi1_clk_a";
+						function = "spi1";
 					};
 				};
 
-				uart_b_x_cts_rts_pins: uart_b_x_cts_rts {
+				spi1_ss0_a_pins: spi1_ss0_a {
 					mux {
-						groups = "uart_cts_b_x",
-							"uart_rts_b_x";
-						function = "uart_b";
+						groups = "spi1_ss0_a";
+						function = "spi1";
 					};
 				};
 
-				uart_b_z_pins: uart_b_z {
+				spi1_ss1_pins: spi1_ss1 {
 					mux {
-						groups = "uart_tx_b_z",
-							"uart_rx_b_z";
-						function = "uart_b";
+						groups = "spi1_ss1";
+						function = "spi1";
 					};
 				};
 
-				uart_b_z_cts_rts_pins: uart_b_z_cts_rts {
+				spi1_x_pins: spi1_x {
 					mux {
-						groups = "uart_cts_b_z",
-							"uart_rts_b_z";
-						function = "uart_b";
+						groups = "spi1_miso_x",
+							 "spi1_mosi_x",
+							 "spi1_clk_x";
+						function = "spi1";
 					};
 				};
 
-				uart_ao_b_z_pins: uart_ao_b_z {
+				spi1_ss0_x_pins: spi1_ss0_x {
 					mux {
-						groups = "uart_ao_tx_b_z",
-							"uart_ao_rx_b_z";
-						function = "uart_ao_b_z";
+						groups = "spi1_ss0_x";
+						function = "spi1";
 					};
 				};
 
-				uart_ao_b_z_cts_rts_pins: uart_ao_b_z_cts_rts {
+				tdma_din0_pins: tdma_din0 {
 					mux {
-						groups = "uart_ao_cts_b_z",
-							"uart_ao_rts_b_z";
-						function = "uart_ao_b_z";
+						groups = "tdma_din0";
+						function = "tdma";
 					};
 				};
 
-				mclk_b_pins: mclk_b {
+				tdma_dout0_x14_pins: tdma_dout0_x14 {
 					mux {
-						groups = "mclk_b";
-						function = "mclk_b";
+						groups = "tdma_dout0_x14";
+						function = "tdma";
 					};
 				};
 
-				mclk_c_pins: mclk_c {
+				tdma_dout0_x15_pins: tdma_dout0_x15 {
 					mux {
-						groups = "mclk_c";
-						function = "mclk_c";
+						groups = "tdma_dout0_x15";
+						function = "tdma";
 					};
 				};
 
-				tdma_sclk_pins: tdma_sclk {
+				tdma_dout1_pins: tdma_dout1 {
 					mux {
-						groups = "tdma_sclk";
+						groups = "tdma_dout1";
 						function = "tdma";
 					};
 				};
 
-				tdma_sclk_slv_pins: tdma_sclk_slv {
+				tdma_din1_pins: tdma_din1 {
 					mux {
-						groups = "tdma_sclk_slv";
+						groups = "tdma_din1";
 						function = "tdma";
 					};
 				};
@@ -1165,122 +696,115 @@
 					};
 				};
 
-				tdma_din0_pins: tdma_din0 {
-					mux {
-						groups = "tdma_din0";
-						function = "tdma";
-					};
-				};
-
-				tdma_dout0_x14_pins: tdma_dout0_x14 {
+				tdma_sclk_pins: tdma_sclk {
 					mux {
-						groups = "tdma_dout0_x14";
+						groups = "tdma_sclk";
 						function = "tdma";
 					};
 				};
 
-				tdma_dout0_x15_pins: tdma_dout0_x15 {
+				tdma_sclk_slv_pins: tdma_sclk_slv {
 					mux {
-						groups = "tdma_dout0_x15";
+						groups = "tdma_sclk_slv";
 						function = "tdma";
 					};
 				};
 
-				tdma_dout1_pins: tdma_dout1 {
+				tdmb_din0_pins: tdmb_din0 {
 					mux {
-						groups = "tdma_dout1";
-						function = "tdma";
+						groups = "tdmb_din0";
+						function = "tdmb";
 					};
 				};
 
-				tdma_din1_pins: tdma_din1 {
+				tdmb_din1_pins: tdmb_din1 {
 					mux {
-						groups = "tdma_din1";
-						function = "tdma";
+						groups = "tdmb_din1";
+						function = "tdmb";
 					};
 				};
 
-				tdmb_sclk_pins: tdmb_sclk {
+				tdmb_din2_pins: tdmb_din2 {
 					mux {
-						groups = "tdmb_sclk";
+						groups = "tdmb_din2";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_sclk_slv_pins: tdmb_sclk_slv {
+				tdmb_din3_pins: tdmb_din3 {
 					mux {
-						groups = "tdmb_sclk_slv";
+						groups = "tdmb_din3";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_fs_pins: tdmb_fs {
+				tdmb_dout0_pins: tdmb_dout0 {
 					mux {
-						groups = "tdmb_fs";
+						groups = "tdmb_dout0";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_fs_slv_pins: tdmb_fs_slv {
+				tdmb_dout1_pins: tdmb_dout1 {
 					mux {
-						groups = "tdmb_fs_slv";
+						groups = "tdmb_dout1";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_din0_pins: tdmb_din0 {
+				tdmb_dout2_pins: tdmb_dout2 {
 					mux {
-						groups = "tdmb_din0";
+						groups = "tdmb_dout2";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_dout0_pins: tdmb_dout0 {
+				tdmb_dout3_pins: tdmb_dout3 {
 					mux {
-						groups = "tdmb_dout0";
+						groups = "tdmb_dout3";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_din1_pins: tdmb_din1 {
+				tdmb_fs_pins: tdmb_fs {
 					mux {
-						groups = "tdmb_din1";
+						groups = "tdmb_fs";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_dout1_pins: tdmb_dout1 {
+				tdmb_fs_slv_pins: tdmb_fs_slv {
 					mux {
-						groups = "tdmb_dout1";
+						groups = "tdmb_fs_slv";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_din2_pins: tdmb_din2 {
+				tdmb_sclk_pins: tdmb_sclk {
 					mux {
-						groups = "tdmb_din2";
+						groups = "tdmb_sclk";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_dout2_pins: tdmb_dout2 {
+				tdmb_sclk_slv_pins: tdmb_sclk_slv {
 					mux {
-						groups = "tdmb_dout2";
+						groups = "tdmb_sclk_slv";
 						function = "tdmb";
 					};
 				};
 
-				tdmb_din3_pins: tdmb_din3 {
+				tdmc_fs_pins: tdmc_fs {
 					mux {
-						groups = "tdmb_din3";
-						function = "tdmb";
+						groups = "tdmc_fs";
+						function = "tdmc";
 					};
 				};
 
-				tdmb_dout3_pins: tdmb_dout3 {
+				tdmc_fs_slv_pins: tdmc_fs_slv {
 					mux {
-						groups = "tdmb_dout3";
-						function = "tdmb";
+						groups = "tdmc_fs_slv";
+						function = "tdmc";
 					};
 				};
 
@@ -1298,23 +822,30 @@
 					};
 				};
 
-				tdmc_fs_pins: tdmc_fs {
+				tdmc_din0_pins: tdmc_din0 {
 					mux {
-						groups = "tdmc_fs";
+						groups = "tdmc_din0";
 						function = "tdmc";
 					};
 				};
 
-				tdmc_fs_slv_pins: tdmc_fs_slv {
+				tdmc_din1_pins: tdmc_din1 {
 					mux {
-						groups = "tdmc_fs_slv";
+						groups = "tdmc_din1";
 						function = "tdmc";
 					};
 				};
 
-				tdmc_din0_pins: tdmc_din0 {
+				tdmc_din2_pins: tdmc_din2 {
 					mux {
-						groups = "tdmc_din0";
+						groups = "tdmc_din2";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_din3_pins: tdmc_din3 {
+					mux {
+						groups = "tdmc_din3";
 						function = "tdmc";
 					};
 				};
@@ -1326,65 +857,335 @@
 					};
 				};
 
-				tdmc_din1_pins: tdmc_din1 {
+				tdmc_dout1_pins: tdmc_dout1 {
 					mux {
-						groups = "tdmc_din1";
+						groups = "tdmc_dout1";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_dout2_pins: tdmc_dout2 {
+					mux {
+						groups = "tdmc_dout2";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_dout3_pins: tdmc_dout3 {
+					mux {
+						groups = "tdmc_dout3";
 						function = "tdmc";
 					};
 				};
 
-				tdmc_dout1_pins: tdmc_dout1 {
+				uart_a_pins: uart_a {
+					mux {
+						groups = "uart_tx_a",
+							 "uart_rx_a";
+						function = "uart_a";
+					};
+				};
+
+				uart_a_cts_rts_pins: uart_a_cts_rts {
+					mux {
+						groups = "uart_cts_a",
+							 "uart_rts_a";
+						function = "uart_a";
+					};
+				};
+
+				uart_b_x_pins: uart_b_x {
+					mux {
+						groups = "uart_tx_b_x",
+							 "uart_rx_b_x";
+						function = "uart_b";
+					};
+				};
+
+				uart_b_x_cts_rts_pins: uart_b_x_cts_rts {
 					mux {
-						groups = "tdmc_dout1";
-						function = "tdmc";
+						groups = "uart_cts_b_x",
+							 "uart_rts_b_x";
+						function = "uart_b";
 					};
 				};
 
-				tdmc_din2_pins: tdmc_din2 {
+				uart_b_z_pins: uart_b_z {
 					mux {
-						groups = "tdmc_din2";
-						function = "tdmc";
+						groups = "uart_tx_b_z",
+							 "uart_rx_b_z";
+						function = "uart_b";
 					};
 				};
 
-				tdmc_dout2_pins: tdmc_dout2 {
+				uart_b_z_cts_rts_pins: uart_b_z_cts_rts {
 					mux {
-						groups = "tdmc_dout2";
-						function = "tdmc";
+						groups = "uart_cts_b_z",
+							 "uart_rts_b_z";
+						function = "uart_b";
 					};
 				};
 
-				tdmc_din3_pins: tdmc_din3 {
+				uart_ao_b_z_pins: uart_ao_b_z {
 					mux {
-						groups = "tdmc_din3";
-						function = "tdmc";
+						groups = "uart_ao_tx_b_z",
+							 "uart_ao_rx_b_z";
+						function = "uart_ao_b_z";
 					};
 				};
 
-				tdmc_dout3_pins: tdmc_dout3 {
+				uart_ao_b_z_cts_rts_pins: uart_ao_b_z_cts_rts {
 					mux {
-						groups = "tdmc_dout3";
-						function = "tdmc";
+						groups = "uart_ao_cts_b_z",
+							 "uart_ao_rts_b_z";
+						function = "uart_ao_b_z";
 					};
 				};
 			};
 		};
 
-		sram: sram@fffc0000 {
-			compatible = "amlogic,meson-axg-sram", "mmio-sram";
-			reg = <0x0 0xfffc0000 0x0 0x20000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x0 0xfffc0000 0x20000>;
+		hiubus: bus@ff63c000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff63c000 0x0 0x1c00>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
 
-			cpu_scp_lpri: scp-shmem@0 {
-				compatible = "amlogic,meson-axg-scp-shmem";
-				reg = <0x13000 0x400>;
+			sysctrl: system-controller@0 {
+				compatible = "amlogic,meson-axg-hhi-sysctrl",
+					     "syscon", "simple-mfd";
+				reg = <0 0 0 0x400>;
+
+				clkc: clock-controller {
+					compatible = "amlogic,axg-clkc";
+					#clock-cells = <1>;
+				};
+			};
+		};
+
+		mailbox: mailbox@ff63dc00 {
+			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
+			reg = <0 0xff63dc00 0 0x400>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>;
+			#mbox-cells = <1>;
+		};
+
+		audio: bus@ff642000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff642000 0x0 0x2000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff642000 0x0 0x2000>;
+
+			clkc_audio: clock-controller@0 {
+				compatible = "amlogic,axg-audio-clkc";
+				reg = <0x0 0x0 0x0 0xb4>;
+				#clock-cells = <1>;
+
+				clocks = <&clkc CLKID_AUDIO>,
+					 <&clkc CLKID_MPLL0>,
+					 <&clkc CLKID_MPLL1>,
+					 <&clkc CLKID_MPLL2>,
+					 <&clkc CLKID_MPLL3>,
+					 <&clkc CLKID_HIFI_PLL>,
+					 <&clkc CLKID_FCLK_DIV3>,
+					 <&clkc CLKID_FCLK_DIV4>,
+					 <&clkc CLKID_GP0_PLL>;
+				clock-names = "pclk",
+					      "mst_in0",
+					      "mst_in1",
+					      "mst_in2",
+					      "mst_in3",
+					      "mst_in4",
+					      "mst_in5",
+					      "mst_in6",
+					      "mst_in7";
+
+				resets = <&reset RESET_AUDIO>;
+			};
+
+			toddr_a: audio-controller@100 {
+				compatible = "amlogic,axg-toddr";
+				reg = <0x0 0x100 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "TODDR_A";
+				interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
+				resets = <&arb AXG_ARB_TODDR_A>;
+				status = "disabled";
+			};
+
+			toddr_b: audio-controller@140 {
+				compatible = "amlogic,axg-toddr";
+				reg = <0x0 0x140 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "TODDR_B";
+				interrupts = <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
+				resets = <&arb AXG_ARB_TODDR_B>;
+				status = "disabled";
+			};
+
+			toddr_c: audio-controller@180 {
+				compatible = "amlogic,axg-toddr";
+				reg = <0x0 0x180 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "TODDR_C";
+				interrupts = <GIC_SPI 86 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
+				resets = <&arb AXG_ARB_TODDR_C>;
+				status = "disabled";
+			};
+
+			frddr_a: audio-controller@1c0 {
+				compatible = "amlogic,axg-frddr";
+				reg = <0x0 0x1c0 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "FRDDR_A";
+				interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+				resets = <&arb AXG_ARB_FRDDR_A>;
+				status = "disabled";
+			};
+
+			frddr_b: audio-controller@200 {
+				compatible = "amlogic,axg-frddr";
+				reg = <0x0 0x200 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "FRDDR_B";
+				interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
+				resets = <&arb AXG_ARB_FRDDR_B>;
+				status = "disabled";
+			};
+
+			frddr_c: audio-controller@240 {
+				compatible = "amlogic,axg-frddr";
+				reg = <0x0 0x240 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "FRDDR_C";
+				interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
+				resets = <&arb AXG_ARB_FRDDR_C>;
+				status = "disabled";
+			};
+
+			arb: reset-controller@280 {
+				compatible = "amlogic,meson-axg-audio-arb";
+				reg = <0x0 0x280 0x0 0x4>;
+				#reset-cells = <1>;
+				clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
+			};
+
+			tdmin_a: audio-controller@300 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x300 0x0 0x40>;
+				sound-name-prefix = "TDMIN_A";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmin_b: audio-controller@340 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x340 0x0 0x40>;
+				sound-name-prefix = "TDMIN_B";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmin_c: audio-controller@380 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x380 0x0 0x40>;
+				sound-name-prefix = "TDMIN_C";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_C>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmin_lb: audio-controller@3c0 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x3c0 0x0 0x40>;
+				sound-name-prefix = "TDMIN_LB";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			spdifout: audio-controller@480 {
+				compatible = "amlogic,axg-spdifout";
+				reg = <0x0 0x480 0x0 0x50>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "SPDIFOUT";
+				clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+					 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+				clock-names = "pclk", "mclk";
+				status = "disabled";
+			};
+
+			tdmout_a: audio-controller@500 {
+				compatible = "amlogic,axg-tdmout";
+				reg = <0x0 0x500 0x0 0x40>;
+				sound-name-prefix = "TDMOUT_A";
+				clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmout_b: audio-controller@540 {
+				compatible = "amlogic,axg-tdmout";
+				reg = <0x0 0x540 0x0 0x40>;
+				sound-name-prefix = "TDMOUT_B";
+				clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
 			};
 
-			cpu_scp_hpri: scp-shmem@200 {
-				compatible = "amlogic,meson-axg-scp-shmem";
-				reg = <0x13400 0x400>;
+			tdmout_c: audio-controller@580 {
+				compatible = "amlogic,axg-tdmout";
+				reg = <0x0 0x580 0x0 0x40>;
+				sound-name-prefix = "TDMOUT_C";
+				clocks = <&clkc_audio AUD_CLKID_TDMOUT_C>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
 			};
 		};
 
@@ -1414,8 +1215,8 @@
 
 				gpio_ao: bank@14 {
 					reg = <0x0 0x00014 0x0 0x8>,
-						<0x0 0x0002c 0x0 0x4>,
-						<0x0 0x00024 0x0 0x8>;
+					      <0x0 0x0002c 0x0 0x4>,
+					      <0x0 0x00024 0x0 0x8>;
 					reg-names = "mux", "pull", "gpio";
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -1474,7 +1275,7 @@
 				uart_ao_a_pins: uart_ao_a {
 					mux {
 						groups = "uart_ao_tx_a",
-							"uart_ao_rx_a";
+							 "uart_ao_rx_a";
 						function = "uart_ao_a";
 					};
 				};
@@ -1482,7 +1283,7 @@
 				uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
 					mux {
 						groups = "uart_ao_cts_a",
-							"uart_ao_rts_a";
+							 "uart_ao_rts_a";
 						function = "uart_ao_a";
 					};
 				};
@@ -1490,7 +1291,7 @@
 				uart_ao_b_pins: uart_ao_b {
 					mux {
 						groups = "uart_ao_tx_b",
-							"uart_ao_rx_b";
+							 "uart_ao_rx_b";
 						function = "uart_ao_b";
 					};
 				};
@@ -1498,7 +1299,7 @@
 				uart_ao_b_cts_rts_pins: uart_ao_b_cts_rts {
 					mux {
 						groups = "uart_ao_cts_b",
-							"uart_ao_rts_b";
+							 "uart_ao_rts_b";
 						function = "uart_ao_b";
 					};
 				};
@@ -1510,13 +1311,6 @@
 				amlogic,has-chip-id;
 			};
 
-			pwm_AO_ab: pwm@7000 {
-				compatible = "amlogic,meson-axg-ao-pwm";
-				reg = <0x0 0x07000 0x0 0x20>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
 			pwm_AO_cd: pwm@2000 {
 				compatible = "amlogic,meson-axg-ao-pwm";
 				reg = <0x0 0x02000  0x0 0x20>;
@@ -1524,16 +1318,6 @@
 				status = "disabled";
 			};
 
-			i2c_AO: i2c@5000 {
-				compatible = "amlogic,meson-axg-i2c";
-				reg = <0x0 0x05000 0x0 0x20>;
-				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_AO_I2C>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				status = "disabled";
-			};
-
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
@@ -1552,6 +1336,23 @@
 				status = "disabled";
 			};
 
+			i2c_AO: i2c@5000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x05000 0x0 0x20>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_AO_I2C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			pwm_AO_ab: pwm@7000 {
+				compatible = "amlogic,meson-axg-ao-pwm";
+				reg = <0x0 0x07000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			ir: ir@8000 {
 				compatible = "amlogic,meson-gxbb-ir";
 				reg = <0x0 0x8000 0x0 0x20>;
@@ -1566,12 +1367,211 @@
 				#io-channel-cells = <1>;
 				interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>,
-					<&clkc_AO CLKID_AO_SAR_ADC>,
-					<&clkc_AO CLKID_AO_SAR_ADC_CLK>,
-					<&clkc_AO CLKID_AO_SAR_ADC_SEL>;
+					 <&clkc_AO CLKID_AO_SAR_ADC>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_CLK>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_SEL>;
 				clock-names = "clkin", "core", "adc_clk", "adc_sel";
 				status = "disabled";
 			};
 		};
+
+		gic: interrupt-controller@ffc01000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0xffc01000 0 0x1000>,
+			      <0x0 0xffc02000 0 0x2000>,
+			      <0x0 0xffc04000 0 0x2000>,
+			      <0x0 0xffc06000 0 0x2000>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+		};
+
+		cbus: bus@ffd00000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xffd00000 0x0 0x25000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
+
+			reset: reset-controller@1004 {
+				compatible = "amlogic,meson-axg-reset";
+				reg = <0x0 0x01004 0x0 0x9c>;
+				#reset-cells = <1>;
+			};
+
+			gpio_intc: interrupt-controller@f080 {
+				compatible = "amlogic,meson-gpio-intc";
+				reg = <0x0 0xf080 0x0 0x10>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
+				status = "disabled";
+			};
+
+			pwm_ab: pwm@1b000 {
+				compatible = "amlogic,meson-axg-ee-pwm";
+				reg = <0x0 0x1b000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@1a000 {
+				compatible = "amlogic,meson-axg-ee-pwm";
+				reg = <0x0 0x1a000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			spicc0: spi@13000 {
+				compatible = "amlogic,meson-axg-spicc";
+				reg = <0x0 0x13000 0x0 0x3c>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_SPICC0>;
+				clock-names = "core";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spicc1: spi@15000 {
+				compatible = "amlogic,meson-axg-spicc";
+				reg = <0x0 0x15000 0x0 0x3c>;
+				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_SPICC1>;
+				clock-names = "core";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c3: i2c@1c000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x1c000 0x0 0x20>;
+				interrupts = <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@1d000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x1d000 0x0 0x20>;
+				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@1e000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x1e000 0x0 0x20>;
+				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c0: i2c@1f000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x1f000 0x0 0x20>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart_B: serial@23000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x23000 0x0 0x18>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+			};
+
+			uart_A: serial@24000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x24000 0x0 0x18>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+			};
+		};
+
+		apb: bus@ffe00000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xffe00000 0x0 0x200000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
+
+			sd_emmc_b: sd@5000 {
+				compatible = "amlogic,meson-axg-mmc";
+				reg = <0x0 0x5000 0x0 0x800>;
+				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&clkc CLKID_SD_EMMC_B>,
+					<&clkc CLKID_SD_EMMC_B_CLK0>,
+					<&clkc CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+				resets = <&reset RESET_SD_EMMC_B>;
+			};
+
+			sd_emmc_c: mmc@7000 {
+				compatible = "amlogic,meson-axg-mmc";
+				reg = <0x0 0x7000 0x0 0x800>;
+				interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&clkc CLKID_SD_EMMC_C>,
+					<&clkc CLKID_SD_EMMC_C_CLK0>,
+					<&clkc CLKID_FCLK_DIV2>;
+				clock-names = "core", "clkin0", "clkin1";
+				resets = <&reset RESET_SD_EMMC_C>;
+			};
+		};
+
+		sram: sram@fffc0000 {
+			compatible = "amlogic,meson-axg-sram", "mmio-sram";
+			reg = <0x0 0xfffc0000 0x0 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0xfffc0000 0x20000>;
+
+			cpu_scp_lpri: scp-shmem@0 {
+				compatible = "amlogic,meson-axg-scp-shmem";
+				reg = <0x13000 0x400>;
+			};
+
+			cpu_scp_hpri: scp-shmem@200 {
+				compatible = "amlogic,meson-axg-scp-shmem";
+				reg = <0x13400 0x400>;
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
 	};
 };
-- 
2.17.1

