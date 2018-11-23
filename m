Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D567EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDC4206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/FIamLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDC4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502327AbeKWSPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:15:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35605 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393517AbeKWSPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:15:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so11335137wrb.2;
        Thu, 22 Nov 2018 23:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G2J3bt6SoagR5RjSKBaYfNBKxYjv+pU4idhIJyB2Z5U=;
        b=s/FIamLmTZVTRwxbGP4BdrqxopzQlshvSa3SKThzhmJE2dUSoSX4d1gX/SKMh+eby8
         yreTYNh86HJocKuscFXkvuzyL7OAnJX/apQ62dOkkTKPSqi4DV15RciC+Mp6/l9Op/3C
         +szE946G+74nELAgrgUgE20aWQAuuPIvkQ62DDURQSlGr1Qtmy+fOocvQQrdP4BJO9PY
         VwUxTMK03K216WkkwTkFNBccZgpluil8zjDCZcnoRGkLBZg3rnpdS3KvegG093Ngx+qT
         Zah715SDlkLGlEiJrFijw+XoaP1yihiZ8YCt1rEkXDrZ1rLPgbnBj7zZ/BOexn2pqj1a
         +9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=G2J3bt6SoagR5RjSKBaYfNBKxYjv+pU4idhIJyB2Z5U=;
        b=ocYjU/3YZ9xhE/F0orH+wPjBjYNhTr7Tt0Jdg5FjK7Gi7nU3MGJkXnFYV7kAc0By/9
         kws3TS1a9v5yQ5woAEZ7gOzaMeEtMMDsnPeZiztSTVgvXExU8YLBZryAg+p5UoLyBkeC
         JeQmc4IwBmDVuFIAOxDy5APu6HK5p+HvYkYBd9tIq0byX1gQ5m42gj1JaZig7jyAIFwc
         Ds09EeukgBrHLDFpl213Uh4qbx7njBEOEi1fiTS7bAFK7rJDPFh9+R3LyAJhQOySXnGD
         bP7VAqvLijH9DPjlyQ0bdlTMWhA0hJx8oCDkJQwbWvv5KcCnwZM/ma18Ies0/4nMwGfE
         5tjA==
X-Gm-Message-State: AA+aEWbNSYCSjfmTLXA9S3VXeIjy710cigKjT2fW58Tdx+s1/j+j/bIw
        GeL3BbyJYR6xOnl+p+BwoHU=
X-Google-Smtp-Source: AFSGD/WPdCh1oDmkMZ3hnTNFA+gVZIMg/Z66gIrpnk1Vw7HD1o+QOQdjJ2RvlT59NUwOLaTgXK9eHg==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr12961425wrn.171.1542958321997;
        Thu, 22 Nov 2018 23:32:01 -0800 (PST)
Received: from cizrna.lan ([109.72.12.77])
        by smtp.gmail.com with ESMTPSA id x81sm4482093wmg.17.2018.11.22.23.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 23:32:01 -0800 (PST)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     heiko@sntech.de
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add DT for nanopc-t4
Date:   Fri, 23 Nov 2018 08:26:04 +0100
Message-Id: <20181123073120.6250-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a device tree for the NanoPC-T4 SBC, which is based on the
Rockchip RK3399 SoC and marketed by FriendlyELEC.

Known working:

- Serial
- Ethernet
- HDMI
- USB 2.0

All of the interesting stuff is in a .dtsi because there are at least
two other boards that share most of it: NanoPi M4 and NanoPi NEO4.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 .../devicetree/bindings/arm/rockchip.txt      |   4 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts    |  18 +
 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     | 782 ++++++++++++++++++
 4 files changed, 805 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 0cc71236d639..57e048dfec1f 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -71,6 +71,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
 
+- FriendlyElec NanoPC-T4 board:
+    Required root node properties:
+      - compatible = "friendlyelec,nanopc-t4", "rockchip,rk3399";
+
 - ChipSPARK PopMetal-RK3288 board:
     Required root node properties:
       - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 49042c477870..ed90cd1e5a8b 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -20,3 +20,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
new file mode 100644
index 000000000000..8e716c790d60
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * FriendlyElec NanoPC-T4 board device tree source
+ *
+ * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * Copyright (c) 2018 Collabora Ltd.
+ */
+
+/dts-v1/;
+#include "rk3399-nanopi4.dtsi"
+
+/ {
+	model = "FriendlyElec NanoPC-T4";
+	compatible = "friendlyelec,nanopc-t4", "rockchip,rk3399";
+};
+
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
new file mode 100644
index 000000000000..01be5cc57213
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -0,0 +1,782 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * RK3399-based FriendlyElec boards device tree source
+ *
+ * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * Copyright (c) 2018 Collabora Ltd.
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/linux-event-codes.h>
+#include "rk3399.dtsi"
+#include "rk3399-opp.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	clkin_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clkin_gmac";
+		#clock-cells = <0>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_host";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vccadc_ref: vccadc-ref {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vcc_sd: vcc-sd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc_sd_h>;
+		regulator-name = "vcc_sd";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vcc_phy: vcc-phy-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_phy";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_lcd: vcc-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_lcd";
+		gpio = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <20000>;
+		enable-active-high;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_typec: vcc5v0-typec-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vcc5v0_typec";
+		regulator-always-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vdd_log: vdd-log {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 25000 1>;
+		regulator-name = "vdd_log";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+
+		/* for rockchip boot on */
+		rockchip,pwm_id = <2>;
+		rockchip,pwm_voltage = <900000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&power_key>;
+
+		button@0 {
+			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			label = "GPIO Key Power";
+			linux,input-type = <1>;
+			gpio-key,wakeup = <1>;
+			debounce-interval = <100>;
+		};
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		poll-interval = <100>;
+		keyup-threshold-microvolt = <1800000>;
+
+		button-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-microvolt = <100000>;
+		};
+
+		button-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-microvolt = <300000>;
+		};
+	};
+
+	leds: gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 =<&leds_gpio>;
+
+		led@1 {
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+			label = "status_led";
+			linux,default-trigger = "heartbeat";
+			linux,default-trigger-delay-ms = <0>;
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+
+		/*
+		 * On the module itself this is one of these (depending
+		 * on the actual card populated):
+		 * - SDIO_RESET_L_WL_REG_ON
+		 * - PDN (power down when low)
+		 */
+		reset-gpios = <&gpio0 10 GPIO_ACTIVE_LOW>; /* GPIO0_B2 */
+	};
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&gpu {
+	status = "okay";
+	mali-supply = <&vdd_gpu>;
+};
+
+&gmac {
+	phy-supply = <&vcc_phy>;
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+	snps,reset-gpio = <&gpio3 15 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 50000>;
+	assigned-clocks = <&cru SCLK_RMII_SRC>;
+	assigned-clock-parents = <&clkin_gmac>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	tx_delay = <0x28>;
+	rx_delay = <0x11>;
+	status = "okay";
+};
+
+&spi1 {
+	status = "disabled";
+	cs-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+
+	spidev0: spidev@0 {
+		compatible = "rockchip,spidev";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		status = "okay";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
+
+&rga {
+	status = "disabled";
+};
+
+&cdn_dp {
+// TODO: typec/fusb302 doesn't have extcon support yet
+//	status = "enabled";
+	extcon = <&fusb0>;
+	phys = <&tcphy0_dp>;
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c7>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <160>;
+	i2c-scl-falling-time-ns = <30>;
+	clock-frequency = <400000>;
+
+	vdd_cpu_b: syr827@40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		vin-supply = <&vcc3v3_sys>;
+		regulator-compatible = "fan53555-reg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel1_gpio>;
+		vsel-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vdd_cpu_b";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-initial-state = <3>;
+			regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_gpu: syr828@41 {
+		compatible = "silergy,syr828";
+		reg = <0x41>;
+		vin-supply = <&vcc3v3_sys>;
+		regulator-compatible = "fan53555-reg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel2_gpio>;
+		vsel-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-initial-state = <3>;
+			regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	rk808: pmic@1b {
+		compatible = "rockchip,rk808";
+		reg = <0x1b>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells = <1>;
+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
+
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		vcc10-supply = <&vcc3v3_sys>;
+		vcc11-supply = <&vcc3v3_sys>;
+		vcc12-supply = <&vcc3v3_sys>;
+		vddio-supply = <&vcc_3v0>;
+
+		regulators {
+			vdd_center: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-name = "vdd_center";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_l: DCDC_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-name = "vdd_cpu_l";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_ddr";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc1v8_dvp: LDO_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8_dvp";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v0_tp: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc3v0_tp";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc1v8_pmu: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vccio_sd: LDO_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-init-microvolt = <3000000>;
+				regulator-name = "vccio_sd";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcca3v0_codec: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcca3v0_codec";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v5: LDO_REG6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-name = "vcc_1v5";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1500000>;
+				};
+			};
+
+			vcca1v8_codec: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_codec";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v0: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc_3v0";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc3v3_s3: SWITCH_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc3v3_s3";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_s0: SWITCH_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc3v3_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <150>;
+	i2c-scl-falling-time-ns = <30>;
+	clock-frequency = <200000>;
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <160>;
+	i2c-scl-falling-time-ns = <30>;
+	clock-frequency = <400000>;
+
+	fusb0: typec-portc@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&fusb0_int>;
+		vbus-supply = <&vcc5v0_typec>;
+		status = "okay";
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+
+&io_domains {
+	status = "okay";
+
+	bt656-supply = <&vcc1v8_dvp>;		/* bt656_gpio2ab_ms */
+	audio-supply = <&vcca1v8_codec>;
+	sdmmc-supply = <&vccio_sd>;		/* sdmmc_gpio4b_ms */
+	gpio1830-supply = <&vcc_3v0>;		/* gpio1833_gpio4cd_ms */
+};
+
+&pmu_io_domains {
+	status = "okay";
+	pmu1830-supply = <&vcc_3v0>;
+};
+
+&pcie_phy {
+	status = "okay";
+	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
+	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
+	assigned-clock-rates = <100000000>;
+};
+
+&pcie0 {
+	status = "okay";
+	ep-gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	max-link-speed = <2>;
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+	pinctrl-names = "active";
+	pinctrl-0 = <&pwm2_pin_pull_down>;
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vccadc_ref>; /* TBD */
+};
+
+&sdhci {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	supports-emmc;
+	non-removable;
+	keep-power-in-suspend;
+	mmc-hs400-enhanced-strobe;
+	status = "okay";
+};
+
+&emmc_phy {
+	status = "okay";
+};
+
+&sdio0 {
+	clock-frequency = <50000000>;
+	clock-freq-min-max = <200000 50000000>;
+	supports-sdio;
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&sdmmc {
+	clock-frequency = <150000000>;
+	clock-freq-min-max = <100000 150000000>;
+	supports-sd;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	num-slots = <1>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	status = "okay";
+};
+
+&tsadc {
+	/* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-mode = <1>;
+	/* tshut polarity 0:LOW 1:HIGH */
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
+
+&tcphy0 {
+	extcon = <&fusb0>;
+	status = "okay";
+};
+
+&tcphy1 {
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+	extcon = <&fusb0>;
+
+	u2phy0_otg: otg-port {
+		status = "okay";
+	};
+
+	u2phy0_host: host-port {
+		phy-supply = <&vcc5v0_host>;
+		status = "okay";
+	};
+};
+
+&u2phy1 {
+	status = "okay";
+
+	u2phy1_otg: otg-port {
+		status = "okay";
+	};
+
+	u2phy1_host: host-port {
+		phy-supply = <&vcc5v0_host>;
+		status = "okay";
+	};
+};
+
+&usbdrd3_0 {
+	status = "okay";
+	extcon = <&fusb0>;
+};
+
+&usbdrd3_1 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&pinctrl {
+
+	hdmi {
+		/delete-node/ hdmi-i2c-xfer;
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <1 21 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		vsel1_gpio: vsel1-gpio {
+			rockchip,pins = <1 17 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+		vsel2_gpio: vsel2-gpio {
+			rockchip,pins = <1 14 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	vcc_sd {
+		vcc_sd_h: vcc-sd-h {
+			rockchip,pins = <0 1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	fusb30x {
+		fusb0_int: fusb0-int {
+			rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	rockchip-key {
+		power_key: power-key {
+			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	gpio-leds {
+		leds_gpio: leds-gpio {
+			rockchip,pins = <0 13 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
-- 
2.19.1

