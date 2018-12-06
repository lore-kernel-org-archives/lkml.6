Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD9C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EF020700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EF020700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbeLFKKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:10:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36461 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbeLFKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:10:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so25658984qtn.3;
        Thu, 06 Dec 2018 02:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=nbaHCr1rOrTleJfZck6q7uF/Z4+VZl11yabsEEpO5fc=;
        b=a4g6oIlNFiHM0kxqirX59VlLFsfy1U13RXZGJP171PF7hFs9X9mo2+4Z3MnsraSJTV
         SXzkK1K8uBGXc5bTgZfkcZqmz5VelGDu/IhjZhI3pF2k0sc6911cByNdAPocN4AI6vZt
         +B3FT7cc2PPAyaMre8gVqtM9RvpGAxG2sZG7YndflKR/9or2km2IfVvVNh0DpQ+ahu/A
         S0tohkmV9oNa9/3YKDw6p+yHC3pSLTGJ7633zRLFAm51yu2rjqwanm/d+y5vXKYrFN6X
         L3fRZWLHfEej2hWtEDGFMKJ7Wu+Lef72N5hlcTDItbmMK7fpLYM8GYgGBoCvAAuzaf9/
         n1cg==
X-Gm-Message-State: AA+aEWZkhLHc/8OvsOnHJNmNMHFwiVFRdgm5fM+jVvmtj7zZEL2pt3fa
        nrEIlQnZuj+Kbmp4273goXA=
X-Google-Smtp-Source: AFSGD/X4Q1AScDcASPtBtgv+1eno9R+1rKtyDo6hKbnTXGFdB9jLXObaf+aou1dSb9lHMvK85BI6DQ==
X-Received: by 2002:a0c:8164:: with SMTP id 91mr26754603qvc.100.1544091023221;
        Thu, 06 Dec 2018 02:10:23 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id v50sm14296297qtc.7.2018.12.06.02.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 02:10:22 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 06 Dec 2018 08:10:16 -0200
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
Subject: [PATCH v2 9/9] ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant
Date:   Thu,  6 Dec 2018 08:09:05 -0200
Message-Id: <20181206100905.15053-10-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

The imx7d-pico-hobbit contains a imx7d-pico SoM and a hobbit baseboard.

Add support for it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx7d-pico-hobbit.dts | 105 ++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-pico-hobbit.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1d6d916c2195..5c7dc0b4aaa8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -572,6 +572,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-colibri-emmc-eval-v3.dtb \
 	imx7d-colibri-eval-v3.dtb \
 	imx7d-nitrogen7.dtb \
+	imx7d-pico-hobbit.dtb \
 	imx7d-pico-pi.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
diff --git a/arch/arm/boot/dts/imx7d-pico-hobbit.dts b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
new file mode 100644
index 000000000000..7b2198a9372c
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+//
+// Copyright 2017 NXP
+
+#include "imx7d-pico.dtsi"
+
+/ {
+	model = "TechNexion PICO-IMX7D Board using Hobbit baseboard";
+	compatible = "technexion,imx7d-pico-hobbit", "fsl,imx7d";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led {
+			label = "gpio-led";
+			gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx7-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		};
+	};
+};
+
+&i2c1 {
+	sgtl5000: codec@a {
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		compatible = "fsl,sgtl5000";
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_vref_1v8>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	adc081c: adc@50 {
+		compatible = "ti,adc081c";
+		reg = <0x50>;
+		vref-supply = <&reg_3p3v>;
+	};
+};
+
+&ecspi3 {
+	ads7846@0 {
+		reg = <0>;
+		compatible = "ti,ads7846";
+		interrupt-parent = <&gpio2>;
+		interrupts = <7 0>;
+		spi-max-frequency = <1000000>;
+		pendown-gpio = <&gpio2 7 0>;
+		vcc-supply = <&reg_3p3v>;
+		ti,x-min = /bits/ 16 <0>;
+		ti,x-max = /bits/ 16 <4095>;
+		ti,y-min = /bits/ 16 <0>;
+		ti,y-max = /bits/ 16 <4095>;
+		ti,pressure-max = /bits/ 16 <1024>;
+		ti,x-plate-ohms = /bits/ 16 <90>;
+		ti,y-plate-ohms = /bits/ 16 <90>;
+		ti,debounce-max = /bits/ 16 <70>;
+		ti,debounce-tol = /bits/ 16 <3>;
+		ti,debounce-rep = /bits/ 16 <2>;
+		ti,settle-delay-usec = /bits/ 16 <150>;
+		wakeup-source;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14
+			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x14
+			MX7D_PAD_EPDC_DATA02__GPIO2_IO2		0x14
+			MX7D_PAD_EPDC_DATA03__GPIO2_IO3		0x14
+			MX7D_PAD_EPDC_DATA05__GPIO2_IO5		0x14
+			MX7D_PAD_EPDC_DATA12__GPIO2_IO12	0x14
+			MX7D_PAD_EPDC_DATA07__GPIO2_IO7		0x14
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x14
+		>;
+	};
+};
-- 
2.19.2

