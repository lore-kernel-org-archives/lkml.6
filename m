Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A5FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B36720873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr1lU/Nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B36720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbeK0UKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:10:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55609 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbeK0UKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:10:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so20876559wmc.5;
        Tue, 27 Nov 2018 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aEfDEzNHQBxRuz1/JQS3cXHwOL3DxswQRyyx8c2lIA0=;
        b=Lr1lU/Nd9LGGAkejXm3U5uufL/YAr5bVifgDEYt+YQBuMNqeSPfhYn+qqavSEz0adO
         KBRUbPdAfkiOhv3awleVaw4Th1gv2p5qZrpCeVthx1xrDcUEUJaKn4JwqtujQHX25DPR
         ufmbiio7hvyKkDovl70kFP4Ng2SaEh7Q+n/9f/ywIv/CJY879Ec+iEahQBbaFcSz8R2c
         phO/KVDTMsgPYr10YHgW/t63hV3n/I0a8WkBfFAAtMdTTCKl8oFTaBoSiHAAXrxMSlyb
         DVPkrIMv3RYxda56pBEoLF8BAx/FZ/f9QfReXOy4sU0eGsSFDlMJ1s/b39IWHNEzEj2P
         OoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aEfDEzNHQBxRuz1/JQS3cXHwOL3DxswQRyyx8c2lIA0=;
        b=GNjpVh634sEP17ayZEbZ/mzU/vrFxa52qH+eNwxMMnGUAMeVfSRh4yxwOMtdsazviB
         EJpW357vASYBhXjR12zuZG+pMcRXXpphlxJSQWn3kHbVrmwci7e9/zXbWn2TMzZq9OH0
         wv8tbydOu5/j3ob5gXx88cUoDZDwVHhjEMeu0GlPLBsN16/+HaAd/w90am4B7tpp7ueI
         zN6HXDHNOCOI7fMErG+dMN45IOmsE+9Qv3NQQlu9LgsTbCSrtfn2rBYw+WBuM1g9dmsp
         ULbnC9s6jUnnWAAO78uzMQtzRJXOoeztL1VBBNVk3WPqwr4TaPrK3uiou0I+RHVUpxZ6
         0MJA==
X-Gm-Message-State: AGRZ1gILDAd19DL2L1qyLp8i9yhc60iE3cBqRPhZlabJ+Ec1NdxEH1nu
        KYJfrpKCpxLohf/Mikw+j/I=
X-Google-Smtp-Source: AJdET5dxkOoW0kMPiQD5T6xXXr7wp9qrERqXVObidRYBKnucfb6EXv8qW01W5MXGGY3icXjRj+Py2A==
X-Received: by 2002:a1c:e701:: with SMTP id e1mr26110423wmh.21.1543309971173;
        Tue, 27 Nov 2018 01:12:51 -0800 (PST)
Received: from cizrna.lan ([109.72.12.198])
        by smtp.gmail.com with ESMTPSA id 6-v6sm2968762wmd.45.2018.11.27.01.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 01:12:50 -0800 (PST)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     heiko@sntech.de
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Liang Chen <cl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm64: dts: rockchip: Add DT for nanopc-t4
Date:   Tue, 27 Nov 2018 10:07:03 +0100
Message-Id: <20181127091235.50351-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123073120.6250-1-tomeu.vizoso@collabora.com>
References: <20181123073120.6250-1-tomeu.vizoso@collabora.com>
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

v2: - Rename compatible from friendlyelec to friendlyarm, to match
      existing bindings
    - Remove superfluous node spi1

v3: - Rewrite regulator tree to match the schematics (Heiko)
    - Sort top-level nodes alphabetically (Heiko)
    - Used defines for GPIO numbers (Heiko)
    - Enabled rga (Heiko)
    - Removed cdn_dp node (Heiko)
    - Removed dependencies to fusb0 as extcon (Heiko)
    - Removed superfluous properties (Heiko)

v4: - Replace underscores in node names (Heiko)
    - Reorder entry in makefile (Heiko)
    - Remove superfluous properties and nodes (Heiko and Shawn)
    - Use xin32k as one of the clock outputs of the RK808 (Heiko)
---
 .../devicetree/bindings/arm/rockchip.txt      |   4 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts    |  18 +
 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     | 732 ++++++++++++++++++
 4 files changed, 755 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 0cc71236d639..e907d309486e 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -71,6 +71,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
 
+- FriendlyElec NanoPC-T4 board:
+    Required root node properties:
+      - compatible = "friendlyarm,nanopc-t4", "rockchip,rk3399";
+
 - ChipSPARK PopMetal-RK3288 board:
     Required root node properties:
       - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 49042c477870..19c129702e06 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-ficus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
new file mode 100644
index 000000000000..0965712b4464
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
+	compatible = "friendlyarm,nanopc-t4", "rockchip,rk3399";
+};
+
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
new file mode 100644
index 000000000000..e10b98d637d3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -0,0 +1,732 @@
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
+	vdd_5v: vdd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_5v";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc5v0_core: vcc5v0-core {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_core";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vdd_5v>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_core>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vdd_5v>;
+	};
+
+	vcc5v0_usb1: vcc5v0-usb1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb1";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_usb2: vcc5v0-usb2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb2";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	/* switched by pmic_sleep */
+	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_1v8>;
+	};
+
+	vcc3v0_sd: vcc3v0-sd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc0_pwr_h>;
+		regulator-always-on;
+		regulator-max-microvolt = <3000000>;
+		regulator-min-microvolt = <3000000>;
+		regulator-name = "vcc3v0_sd";
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vbus_typec: vbus-typec {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vbus_typec";
+		regulator-always-on;
+		vin-supply = <&vdd_5v>;
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
+			debounce-interval = <100>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+			label = "GPIO Key Power";
+			linux,code = <KEY_POWER>;
+			linux,input-type = <1>;
+			wakeup-source;
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
+			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
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
+		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
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
+&emmc_phy {
+	status = "okay";
+};
+
+&gmac {
+	phy-supply = <&vcc3v3_s3>;
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
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
+&gpu {
+	status = "okay";
+	mali-supply = <&vdd_gpu>;
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
+	vdd_cpu_b: regulator@40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		vin-supply = <&vcc3v3_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel1_gpio>;
+		regulator-name = "vdd_cpu_b";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-initial-state = <3>;
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_gpu: regulator@41 {
+		compatible = "silergy,syr828";
+		reg = <0x41>;
+		vin-supply = <&vcc3v3_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel2_gpio>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-initial-state = <3>;
+		regulator-state-mem {
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
+		clock-output-names = "xin32k", "rk808-clkout2";
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
+		vbus-supply = <&vbus_typec>;
+		status = "okay";
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&io_domains {
+	status = "okay";
+
+	bt656-supply = <&vcc1v8_dvp>;
+	audio-supply = <&vcca1v8_codec>;
+	sdmmc-supply = <&vccio_sd>;
+	gpio1830-supply = <&vcc_3v0>;
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
+	ep-gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	max-link-speed = <2>;
+};
+
+&pinctrl {
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <RK_GPIO1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		vsel1_gpio: vsel1-gpio {
+			rockchip,pins = <RK_GPIO1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+		vsel2_gpio: vsel2-gpio {
+			rockchip,pins = <RK_GPIO1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	sd {
+		sdmmc0_pwr_h: sdmmc0-pwr-h {
+			rockchip,pins =
+				<RK_GPIO0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	fusb30x {
+		fusb0_int: fusb0-int {
+			rockchip,pins = <RK_GPIO1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <RK_GPIO0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	rockchip-key {
+		power_key: power-key {
+			rockchip,pins = <RK_GPIO0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	gpio-leds {
+		leds_gpio: leds-gpio {
+			rockchip,pins = <RK_GPIO0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	status = "okay";
+	pmu1830-supply = <&vcc_3v0>;
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
+	vref-supply = <&vcca1v8_s3>;
+};
+
+&sdhci {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	non-removable;
+	mmc-hs400-enhanced-strobe;
+	status = "okay";
+};
+
+&sdio0 {
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	vmmc-supply = <&vcc3v0_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&tcphy0 {
+	status = "okay";
+};
+
+&tcphy1 {
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
+&u2phy0 {
+	status = "okay";
+
+	u2phy0_otg: otg-port {
+		status = "okay";
+	};
+
+	u2phy0_host: host-port {
+		phy-supply = <&vcc5v0_usb1>;
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
+		phy-supply = <&vcc5v0_usb2>;
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
+&usbdrd3_0 {
+	status = "okay";
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
-- 
2.19.1

