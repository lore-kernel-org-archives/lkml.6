Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34943C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA4B208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DorHfkOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA4B208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965914AbeFONmj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:42:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46803 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936252AbeFONmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:42:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id v13-v6so9961713wrp.13;
        Fri, 15 Jun 2018 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPioVH2mnsPJaYDd22xH9WF9j6WkBBupLOzML1a8SLk=;
        b=DorHfkOQnAbq34TCl4ALWIOYHa9DhhK9futGaTOnSRPDyPI7TfGvcWtoM/Hnx2tDBj
         iIBnGBen3FLf1Pvbd3ZZMXIYNS3ZqsoQzvKZj7nvIMi8W+Rave3LPeqBLr/2u3apcvHP
         Vrx8LoV/LY0a7shNjN6A0PX+Bu3WWLIDTjGCkf7CtGic+DjSY4YSL+1SOAgxaC/IPRw2
         mEpzmPQCspUBcTuIO+sNidKzdsdBYCbQrKJgirA+VsA7ZGfprbYguBUQB5RMwJ9mJH4+
         TXO9xBekRA3xFrkTiP2zXikIstGYL26wgFMs7/sWQqoemKdJYoDQ2utFfBOzzKZlAbdp
         8EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JPioVH2mnsPJaYDd22xH9WF9j6WkBBupLOzML1a8SLk=;
        b=BRZ8GbzsRTd1dRTXTKUtJN+Nf7lx1/+SJhr8w7QQC7elu9HrvHWsmfvzW2Z0VkStpB
         ziWMfn7cgqHMNUKgitAudkITcHUtAoj0M9Be5EOUX8iIBe9SIi3NQNZDuB1n90Sx5BZ/
         kUWuiH/h1bSPq7+mQlp7n1eU9xuto2s5oKZtzmmUdrZo6BsMp1oqqC3GBYZalB7ElQoM
         MvsIg6Td0hGoRkVdOIX2lh4dcOur2tgtREv6lKzzGyQjA+AgXue9u1KN1pcthKZtrNJp
         Yz2RLJ8ZxBzaqINQ1O/hhy1s1tuWmOF5VKe8zV6Ms/n5MI1J77+WLRoHUb2cfpIDLnnT
         sOdA==
X-Gm-Message-State: APt69E205HM1YVIiQOUJDKH+0BqhVJAx09n66sepzB7rA3O6TAKbLBuN
        IhaYHgeMwjdx2i2Kdc7rU8has+q8rwI=
X-Google-Smtp-Source: ADUXVKJWjhy1GVaIaJO8UrkkahBOXSVVBSPr1/2o1uqcFwOVmy4bOvYHzmizz85Nqz9jeOUaj+J9Rg==
X-Received: by 2002:adf:a792:: with SMTP id j18-v6mr1787040wrc.187.1529070151471;
        Fri, 15 Jun 2018 06:42:31 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id d5-v6sm9816346wrp.64.2018.06.15.06.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 06:42:30 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        Ben Whitten <ben.whitten@lairdtech.com>
Subject: [PATCH v2 5/6] arm: dts: add support for Gatwick board based on WB50N
Date:   Fri, 15 Jun 2018 14:40:54 +0100
Message-Id: <1529070055-18701-5-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LoRa gateway from Laird, the RG1xx.
This board houses the WB50NBT CPU module along with a Semtech SX1301 based
concentrator card.
https://www.lairdtech.com/products/rg1xx-lora-gateway

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>

# Conflicts:
#	arch/arm/boot/dts/Makefile
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/at91-gatwick.dts | 121 +++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-gatwick.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 07823be..214d5d9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d2_ptc_ek.dtb \
 	at91-sama5d2_xplained.dtb \
 	at91-sama5d3_xplained.dtb \
+	at91-gatwick.dtb \
 	at91-tse850-3.dtb \
 	at91-wb50n.dtb \
 	sama5d31ek.dtb \
diff --git a/arch/arm/boot/dts/at91-gatwick.dts b/arch/arm/boot/dts/at91-gatwick.dts
new file mode 100644
index 0000000..5a81cab
--- /dev/null
+++ b/arch/arm/boot/dts/at91-gatwick.dts
@@ -0,0 +1,121 @@
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
+&pinctrl {
+	board {
+		pinctrl_key_gpio: key_gpio_0 {
+		  atmel,pins =
+			  <AT91_PIOE 31 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PE31 GPIO with pullup deglitch */
+	  };
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

