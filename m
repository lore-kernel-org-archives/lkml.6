Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F0EFAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1F6208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV1nWlAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1F6208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754924AbeFNIxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:53:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50242 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbeFNIxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:53:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so9165160wmd.0;
        Thu, 14 Jun 2018 01:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kcH5V+3EqQ+JBPdgze4Eg/wv/eAvc8Nd6L8aOxl8hdE=;
        b=TV1nWlAjhe6Plco36AoU9vCaBoKiJbEn22cRTVEdTGljSdIvwQlmWnxODEYL7OhW8x
         LPlfgdoq3FNOEiz8u+8taHaos3Zc4eW7WbpbyJq54ZNB9JnMBSp1DHGlxrcnKe81lGPh
         LfVBQnqdCwdSzlrHRV46EYZY+CS1i7509PmuAl4eZEaMFAtYWQysFL0xzhdRzxU/R2Gi
         wIzwx5naqVYWuZQQFPthx2m/QCt+EY/Fxu83x/eo8FgXZ8uJWdRuK02/dAMkh9QzUBoH
         nMrLSBcRth41gFOmoM4IopvYCqP7OqTWFjiBFAGzSLeq+LSPWS4a/3QCUBE/hBkPRJXq
         Pc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=kcH5V+3EqQ+JBPdgze4Eg/wv/eAvc8Nd6L8aOxl8hdE=;
        b=YzsctjfXhcs3o0fjBmOw2HyUDOzOosLU8zp8wMsmpXyjz0PZCeSBjbuceQ5LPp1dk2
         WiCpw8Ytmxm+G513DWb76UZu9Yt+rew8AOes/VSEZvhMRJs8bS1QKRGxZNj1nJ/XQIWO
         craEdclsv1XeKsh41dq3TxIPM25xLJ4b65CyU9wHuHqkOIId56dAse+XMLr6flfOD2kV
         mOIGioyVAJj7KGsJv1guYsxgsombsRyzGaJjZne2nJBU8eSZwzKkfYSvOAGBvEhFVKHN
         KMMkAaOl1Gn8xi/oEg4Ih5xuIYFwuuGCxSDwHyon51BI2nw8OCO55u56BaPj+rXXgjes
         uImQ==
X-Gm-Message-State: APt69E2LRd8GAJuKUkoNSrN4sVCIyfkI8TpJy4MjwmeZ+YZ/HUPq0ysJ
        u6fwU6AJ1VDK2HldNZHE+In+bt45Fto=
X-Google-Smtp-Source: ADUXVKKFMzOI+FQkf6EbVwxO7QsDhHA0gOymubAZdBknMXk0sk8ZQw1aLmnVrQjbUMvfBwuUk4jcRg==
X-Received: by 2002:a1c:6d85:: with SMTP id b5-v6mr1011794wmi.135.1528966381729;
        Thu, 14 Jun 2018 01:53:01 -0700 (PDT)
Received: from Sarah.lan (83-167-250-20.static.masterinter.net. [83.167.250.20])
        by smtp.gmail.com with ESMTPSA id 72-v6sm5452204wrb.22.2018.06.14.01.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 01:53:00 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     devicetree@vger.kernel.org
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] arm: dts: add support for Gatwick board based on WB50N
Date:   Thu, 14 Jun 2018 09:51:56 +0100
Message-Id: <1528966340-23216-3-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 arch/arm/boot/dts/Makefile         |   3 +-
 arch/arm/boot/dts/at91-gatwick.dts | 125 +++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91-gatwick.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fd5f8a6..486ab59 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -62,7 +62,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d4_xplained.dtb \
 	at91-sama5d4ek.dtb \
 	at91-vinco.dtb \
-	at91-wb50n.dtb
+	at91-wb50n.dtb \
+	at91-gatwick.dtb
 dtb-$(CONFIG_ARCH_ATLAS6) += \
 	atlas6-evb.dtb
 dtb-$(CONFIG_ARCH_ATLAS7) += \
diff --git a/arch/arm/boot/dts/at91-gatwick.dts b/arch/arm/boot/dts/at91-gatwick.dts
new file mode 100644
index 0000000..1350c08
--- /dev/null
+++ b/arch/arm/boot/dts/at91-gatwick.dts
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-gatwick.dts - Device Tree file for the Gatwick board
+ *
+ *  Copyright (C) 2018 Laird
+ *
+ */
+/dts-v1/;
+#include "at91-wb50n.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Laird Workgroup Bridge 50N - Project Gatwick";
+	compatible = "laird,gatwick", "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
+
+	ahb {
+		apb {
+			pinctrl@fffff200 {
+				board {
+					pinctrl_key_gpio: key_gpio_0 {
+					  atmel,pins =
+						  <AT91_PIOE 31 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PE31 GPIO with pullup deglitch */
+				  };
+				};
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio>;
+
+		reset-button {
+			label = "Reset Button";
+			linux,code = <KEY_SETUP>;
+			gpios = <&pioE 31 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		ethernet {
+			label = "gatwick:yellow:ethernet";
+			gpios = <&pioA 10 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		wifi {
+			label = "gatwick:green:wifi";
+			gpios = <&pioA 28 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		ble {
+			label = "gatwick:blue:ble";
+			gpios = <&pioA 22 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		lora {
+			label = "gatwick:orange:lora";
+			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		blank {
+			label = "gatwick:green:blank";
+			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		user {
+			label = "gatwick:yellow:user";
+			gpios = <&pioA 12 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+};
+
+&mmc0 {
+	status = "okay";
+};
+
+&macb1 {
+	status = "okay";
+};
+
+&dbgu {
+	status = "okay";
+};
+
+/* FTDI USART */
+&usart0 {
+	status = "okay";
+};
+
+/* GPS USART */
+&usart1 {
+	pinctrl-0 = <&pinctrl_usart1>;
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+
+	spidev@0 {
+		compatible = "semtech,sx1301";
+		reg = <0>;
+		spi-max-frequency = <8000000>;
+	};
+};
+
+&usb1 {
+	status = "okay";
+	/delete-property/atmel,oc-gpio;
+};
+
+&usb2 {
+	status = "okay";
+};
-- 
2.7.4

