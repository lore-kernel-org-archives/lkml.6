Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65CAC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 18:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F69720841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 18:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m5kMTLd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F69720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbeG1Tyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 15:54:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42264 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbeG1Tyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 15:54:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so5021386pgp.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VgOVzSvF9k5Kg9/DBUbWAuK2tsYxC3IxrvVjbHMwMcU=;
        b=m5kMTLd2AKLaI5sAmEZx8RAcMYcW6BaJZIqQ1SggOJCtXPPTLsh2RWIgFKS8OQcUEJ
         N2IVxy2IS38PTRt8M0vvF0Xn5KgQmZPieiorBNoQEq110FUdTaSJTODGOTU2hIc2+dUy
         voWGBc+ja7NzZhluo3TU9zCjNc46OQQOtxEUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VgOVzSvF9k5Kg9/DBUbWAuK2tsYxC3IxrvVjbHMwMcU=;
        b=DMzqaT2Wx5Q9NCUSjgKvIlhRokZoZQQmb3SLzmNl16ljfP9LfTm0+Ggw7DdyVM612I
         8+8vjPNXzCmRWLFLBpsjMKarbWeq7aKwioF8jHRoEHutA6bOqGj99dZtmqC/ssK1IG6v
         1yq8A+NSnHlA4K9nQInwfPWszofCreBU/IJRNfXh8SZW0x55kw83XkphS+eNzGdkUd+X
         T2vO1IY+wScZeZdUgkylssCqjIvK5M4/FuUpw9cM9ZzkxkOJwMeXyQEt3uXX15ynXQSd
         kVsJqYtFAj3mnU6BoDApHv/kj5r9Wp/GIILOWEcx9E/nfae4v0VP+SE/ieGwjfDwCKcp
         BG0Q==
X-Gm-Message-State: AOUpUlEF7PSVDEWBcV8N/NZGc1iJ8oo7e1KbbFO2um3VLWPCPi3cpgQh
        43+wpKHOX7GMeDBHcGZiom127frwpZ4=
X-Google-Smtp-Source: AAOMgpcSo3BhPWqElKL5UKTvUMBuXqHo1t34dOu5/qj3a/KurUOkKg9h/BNp5sREd5ZshH+qIUWBxQ==
X-Received: by 2002:a62:2304:: with SMTP id j4-v6mr11486763pfj.98.1532802449943;
        Sat, 28 Jul 2018 11:27:29 -0700 (PDT)
Received: from localhost.localdomain ([183.82.228.206])
        by smtp.gmail.com with ESMTPSA id y86-v6sm22831154pfk.84.2018.07.28.11.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 11:27:29 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: allwinner: h6: Add OrangePi One Plus initial support
Date:   Sat, 28 Jul 2018 23:56:15 +0530
Message-Id: <20180728182615.20845-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi One Plus is Allwinner H6 based open-source SBC,
which support:
- Allwinner H6 Quad-core 64-bit ARM Cortex-A53
- GPU Mali-T720
- 1GB LPDDR3 RAM
- AXP805 PMIC
- 1Gbps GMAC via RTL8211
- USB 2.0 Host, OTG
- HDMI port
- 5V/2A DC power supply

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun50i-h6-orangepi-one-plus.dts | 150 ++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 9ffa7a038791..c38f326e7fec 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -15,4 +15,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
new file mode 100644
index 000000000000..0612c19cd994
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2018 Amarula Solutions
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h6.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "OrangePi One Plus";
+	compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_cldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp805: pmic@36 {
+		compatible = "x-powers,axp805", "x-powers,axp806";
+		reg = <0x36>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		x-powers,self-working-mode;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-pl";
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-ac200";
+			};
+
+			reg_aldo3: aldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc25-dram";
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-bias-pll";
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-efuse-pcie-hdmi-io";
+			};
+
+			reg_bldo3: bldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-dcxoio";
+			};
+
+			bldo4 {
+				/* unused */
+			};
+
+			reg_cldo1: cldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-3v3";
+			};
+
+			reg_cldo2: cldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-wifi-1";
+			};
+
+			reg_cldo3: cldo3 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-wifi-2";
+			};
+
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1080000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdcc: dcdcc {
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1080000>;
+				regulator-name = "vdd-gpu";
+			};
+
+			reg_dcdcd: dcdcd {
+				regulator-always-on;
+				regulator-min-microvolt = <960000>;
+				regulator-max-microvolt = <960000>;
+				regulator-name = "vdd-sys";
+			};
+
+			reg_dcdce: dcdce {
+				regulator-always-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vcc-dram";
+			};
+
+			sw {
+				/* unused */
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
-- 
2.17.1

