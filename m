Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6601C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9457920672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9457920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeLFKKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:10:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46395 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:10:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id y20so25605347qtm.13;
        Thu, 06 Dec 2018 02:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=BXcoAYV0VGEgzVpj2DLs9vLGGu6/9WBGwYXVxCkYZTI=;
        b=CJSYKETJ/+4438eFk19k+Uf/OKvGXpwFMNFFPQ5TyJUF/Uzmu7qZvHh15zvK0KZgI3
         kG7xLMlsWQnMGvfNSsuQQ5ronxb8hDIDP65Wuvhwuv/LNE+ZokzmrINTgnT7jxfh/G7N
         9HtXbxnPZn1f4XKtm4PsA/UMKCGkrMdbkuyO7w3+x0K8S3RPje3Yb7AHSO3DNCabj9kt
         JM+mAzfW5NluACzQjieRDxMiR+AzFWy9MEbbXz3Jw1rPHcxE+5r7+z+CI10NJpY/v0s6
         ssqj96wLN8zDUNKRWOtV9/Q1zJOer9Q2FFdLqsXpfyjCbtvuJ5jCXQhcNBYkxrSj5ZuO
         ZWWA==
X-Gm-Message-State: AA+aEWb1fxSwt2eIGD6lg2k8L/Pp2X18p42uR0eHcPi1FfZ6oKq+vqjJ
        yhU1kAqaNkQrT/XGwjWuYA8=
X-Google-Smtp-Source: AFSGD/XYL7Yx+n4trZrdJjoFLvOreMRbRZsSjVlI7vQEuWAJSdN5qkJ35QldjPAGNb1KVJtwYtmsaA==
X-Received: by 2002:a0c:a045:: with SMTP id b63mr27160920qva.164.1544091015573;
        Thu, 06 Dec 2018 02:10:15 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id 5sm14552824qtw.50.2018.12.06.02.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 02:10:14 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 06 Dec 2018 08:10:08 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 8/9] ARM: dts: imx7d-pico-pi: Extend peripherals support
Date:   Thu,  6 Dec 2018 08:09:04 -0200
Message-Id: <20181206100905.15053-9-otavio@ossystems.com.br>
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

This adds following peripherals for the imx7d-pico-pi as:

 - LED
 - Touchscreen
 - GPIO

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/imx7d-pico-pi.dts | 56 +++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico-pi.dts b/arch/arm/boot/dts/imx7d-pico-pi.dts
index 039c17066fe0..70bea95c06d8 100644
--- a/arch/arm/boot/dts/imx7d-pico-pi.dts
+++ b/arch/arm/boot/dts/imx7d-pico-pi.dts
@@ -8,6 +8,17 @@
 	model = "TechNexion PICO-IMX7D Board and PI baseboard";
 	compatible = "technexion,imx7d-pico-pi", "fsl,imx7d";
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led {
+			label = "gpio-led";
+			gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "imx7-sgtl5000";
@@ -35,3 +46,48 @@
 		VDDIO-supply = <&reg_vref_1v8>;
 	};
 };
+
+&i2c4 {
+	polytouch: touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touchscreen>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
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
+			MX7D_PAD_EPDC_DATA06__GPIO2_IO6		0x14
+		>;
+	};
+
+	pinctrl_touchscreen: touchscreengrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x14
+			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x14
+		>;
+	};
+
+};
-- 
2.19.2

