Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74ECC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A597C20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A597C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLBVTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:19:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40915 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeLBVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:19:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so11632905qtf.7;
        Sun, 02 Dec 2018 13:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=55pQVhEpgT5gvpJTmZIDiBlXiFeCfhLW8JmA+NU3SGU=;
        b=XDdwsryO/nv0Qp46ELDvntpRkmWoPrtpplvMFn1qAlH4GKgOaaLFMF54vf0BS9Pzoy
         FfQi30e0YdT/01V53lRksg0ynqVhKWJ7ZGuPYT1dyyYGLaqn1V+RgXsyzmQOqakpsi6O
         JvBJDbezynugpMhKLSNxu9cqYWQaO+YlgZ55Wj9h+/E+e3XLYxUeeSHywU4eks28ugtE
         hE5dkzaZXI7uQcuTN38ClX/s0DmyN38ShvOlfIumBCjm2ye2E0rutMFmSRHpaLF4t2wk
         3RJBP8ELnCtQW3bAp217+iJLoiFr6Fa2AfZjhU7XGXDsJ2lOAstv/9TiLmbEuf3oUKk6
         cEuw==
X-Gm-Message-State: AA+aEWYhp/i51Qaj01SC9s+3JxpR4n/rUhBqt1blOgD1NzxWB2i/Tnou
        vDV62A2gQQi3ASoAF4FG9Q4=
X-Google-Smtp-Source: AFSGD/XT1vTeuR6YazMkcoMhEgarJmuWBWvnHJgqR0WTVfXsX7ASEPbCsVPTkKa3bJIA/14/icUxjg==
X-Received: by 2002:aed:34e6:: with SMTP id x93mr13622285qtd.156.1543785538864;
        Sun, 02 Dec 2018 13:18:58 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id l12sm5524343qkk.40.2018.12.02.13.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:18:57 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:18:51 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 5/5] ARM: dts: imx6ul-pico: Add the imx6ul-pico-pi variant
Date:   Sun,  2 Dec 2018 19:18:09 -0200
Message-Id: <20181202211809.11621-6-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202211809.11621-1-otavio@ossystems.com.br>
References: <20181202211809.11621-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

The imx6ul-pico-pi contains a imx6ul-pico SoM and a pi baseboard:
https://www.technexion.com/products/pico-baseboards/detail/PICO-PI

Add support for it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/imx6ul-pico-pi.dts | 97 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-pico.dtsi   | 32 ---------
 3 files changed, 98 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-pi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 12a3cfb7d280..f26591295497 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -557,6 +557,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-liteboard.dtb \
 	imx6ul-opos6uldev.dtb \
 	imx6ul-pico-hobbit.dtb \
+	imx6ul-pico-pi.dtb \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-pico-pi.dts b/arch/arm/boot/dts/imx6ul-pico-pi.dts
new file mode 100644
index 000000000000..de07357b27fc
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-pico-pi.dts
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2015 Technexion Ltd.
+//
+// Author: Wig Cheng  <wig.cheng@technexion.com>
+//	   Richard Hu <richard.hu@technexion.com>
+//	   Tapani Utriainen <tapani@technexion.com>
+/dts-v1/;
+
+#include "imx6ul-pico.dtsi"
+/ {
+	model = "TechNexion PICO-IMX6UL and PI baseboard";
+	compatible = "technexion,imx6ul-pico-pi", "fsl,imx6ul";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led {
+			label = "gpio-led";
+			gpios = <&gpio4 20 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx6ul-sgtl5000";
+		audio-cpu = <&sai1>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"LINE_IN", "Line In Jack",
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+	};
+
+	sys_mclk: clock-sys-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+};
+
+&i2c2 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	sgtl5000: codec@a {
+		reg = <0x0a>;
+		compatible = "fsl,sgtl5000";
+		clocks = <&sys_mclk>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+};
+
+&i2c3 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	polytouch: touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x10b0
+			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x10b0
+			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x10b0
+			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x10b0
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x10b0
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x10b0
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x10b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ul-pico.dtsi b/arch/arm/boot/dts/imx6ul-pico.dtsi
index 89269955440b..de9f83189ba8 100644
--- a/arch/arm/boot/dts/imx6ul-pico.dtsi
+++ b/arch/arm/boot/dts/imx6ul-pico.dtsi
@@ -72,24 +72,6 @@
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <200000>;
 	};
-
-	sound {
-		compatible = "fsl,imx-audio-sgtl5000";
-		model = "imx6ul-sgtl5000";
-		audio-cpu = <&sai1>;
-		audio-codec = <&codec>;
-		audio-routing =
-			"LINE_IN", "Line In Jack",
-			"MIC_IN", "Mic Jack",
-			"Mic Jack", "Mic Bias",
-			"Headphone Jack", "HP_OUT";
-	};
-
-	sys_mclk: clock-sys-mclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24576000>;
-	};
 };
 
 &can1 {
@@ -169,20 +151,6 @@
 	};
 };
 
-&i2c2 {
-	clock_frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-};
-
-&i2c3 {
-	clock_frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-};
-
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat &pinctrl_lcdif_ctrl>;
-- 
2.19.2

