Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9CBC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DAC20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DAC20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbeLBVSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:18:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45096 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeLBVSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:18:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so6206704qka.12;
        Sun, 02 Dec 2018 13:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=kF8o7Epwdu0dEA3UUb5PAzGLGYppW/4YWqYMcTCaLOc=;
        b=LcTN1UyiQxKmMgYdZXkeXh7TcVJBcnuI2afa/Z1IoLs1coKP4osYnbJ+Ya7PXxagsg
         8FpBa7lmiHQ4CESt9YqEJ4nFN7YKlTHOE7LuiNdfUPyECGpCR1vkzexQ1Gu41N7Hctba
         KLKdPKOmLQJ2qqDXxtZ4XqUuYrZ4V4HJw1ZDeWjgQjpdJA8ZHmhPLkZblqvsvebZZVRa
         +o2cCf9tkGhGHM9s4Kg+CZu6c3eEovFDo9hvBhKsCrbtbk50CcVItXHpwjKj7VQ8+Gyt
         WRqdTiSghSATI0LUTA9kfM72Z8UZ7thqdk6ZqR4kW3ry+BwrPRzoTsuGFE2CfAkCbYKJ
         jfbg==
X-Gm-Message-State: AA+aEWb7hS8+21hItK9EfKFyoDU8cRKhp17oHABM+k9CUiXKFCil8eah
        k0dSVtQizQFazRdnabppQGg=
X-Google-Smtp-Source: AFSGD/UvyLZGz/r+GwgCgbwSAHh35VTrREwcL+2T/yJFhdNoVAZk5XrnD1vtFiC2YwPta1Dx4LwIew==
X-Received: by 2002:a37:4289:: with SMTP id p131mr12678332qka.3.1543785531314;
        Sun, 02 Dec 2018 13:18:51 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id j38sm10247759qtj.72.2018.12.02.13.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:18:50 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:18:44 -0200
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
Subject: [PATCH 4/5] ARM: dts: imx6ul-pico-hobbit: Extend peripherals support
Date:   Sun,  2 Dec 2018 19:18:08 -0200
Message-Id: <20181202211809.11621-5-otavio@ossystems.com.br>
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

This adds following peripherals support:

 - ADC
 - GPIO LED
 - GPIOs

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 8656ccbb5a06..f2dd6945e98c 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -14,6 +14,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		led {
 			label = "gpio-led";
@@ -58,6 +60,12 @@
 &i2c3 {
 	status = "okay";
 
+	adc081c: adc@50 {
+		compatible = "ti,adc081c";
+		reg = <0x50>;
+		vref-supply = <&reg_3p3v>;
+	};
+
 	polytouch: touchscreen@38 {
 		compatible = "edt,edt-ft5x06";
 		reg = <0x38>;
@@ -68,3 +76,25 @@
 		touchscreen-size-y = <480>;
 	};
 };
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
+			MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29	0x10b0
+		>;
+	};
+};
-- 
2.19.2

