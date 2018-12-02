Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413B8C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104EC2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104EC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLBV0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:26:32 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39052 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBV0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:26:31 -0500
Received: by mail-qt1-f194.google.com with SMTP id n21so11654056qtl.6;
        Sun, 02 Dec 2018 13:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=6+EbYhMNCoRKxIlDp8uCMOsfP2XKpOLu0mPsX2uEr0Y=;
        b=ie/rUb9gV16dyHv3M/4oGy+IZ9Al8rfcqvMegomtogdm4FofgTiA2yIAI5pX6Yt6C9
         PxgIrEpfaCj79zxtJR4ruLfInwK1bVdRJAWbmN0Y7/7aRlV2cAs9Zl1vzyYrvzAWOKrP
         WqHt5T6OccEV2JMtfJ+GfPTYG82V8OjtN6uaidrIrBN4ofiFdt/H8XwQuXfoMMGMR3bs
         w8FUJcjAnxueU54GnTg7zJdcY3NpqsP/GLRZRKJGBfCC1P04s6zQzCImqXuDpCArmRV0
         5Hqqtk8xL03CSsh4rzAoEC4C1JBKOw/PuenPh5mrZP3he4eDhVsxDYuoFgfuY1ot9R7C
         j6VA==
X-Gm-Message-State: AA+aEWZVQ42L05i09EPnoYeD0SJncxRho+0ilMdaq2qGMq6JpqYM8GKx
        0PytW0ZCNGn8l89UzODeikQ=
X-Google-Smtp-Source: AFSGD/X9ZRGM0qOwJ4MB+T9xQymKRBArWEpveQVyfU6rzEl86KWCrNSJqURWowg6wu2DcmbHWg6/Wg==
X-Received: by 2002:ac8:208a:: with SMTP id 10mr13176419qtd.79.1543785987524;
        Sun, 02 Dec 2018 13:26:27 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id f19sm7804498qtf.1.2018.12.02.13.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:26:26 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:26:20 -0200
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
Subject: [PATCH 8/9] ARM: dts: imx7d-pico-pi: Extend peripherals support
Date:   Sun,  2 Dec 2018 19:25:19 -0200
Message-Id: <20181202212520.16650-9-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
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

