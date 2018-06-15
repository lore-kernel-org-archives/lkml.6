Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1E565C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ACF20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIfp13v1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ACF20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965893AbeFONmh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:42:37 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40582 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936144AbeFONmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:42:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id l41-v6so9982903wre.7;
        Fri, 15 Jun 2018 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9In5Dz1Cu5/hVW3EFEOS1cabOKfwsp1ILN5+DAlZqrs=;
        b=HIfp13v1qnQUBwq+G/14SsZsNguuf7B6Ac5dT+pNTNA3SR94LCrMp7F+gL+lqPZqhF
         nChRIRwHcnDg/81OZAw0GitFWcShcGRXdtHUq5cIwlB/0OX0M4P3q6Uhe/Da5vyN4XyK
         Q1eHrmmlc0PPr0a5Kdb6SBpfMJNIgI1gAakZUCsrfrmJXlQULuypXBTGZYhBszR9FOtQ
         fFulJLRfoBbgCmJoLig2o0Mvv4b/mqq7otETQjwCc3ia1vp/qnBX/0fMQu/usvui/nkn
         rSQ2CoLs3rM9U/w/YP/xK7XjwsW0ccc9GZdzXF7fmfiBrlWkS3u/I8qsPiI6ci90qrwP
         P3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=9In5Dz1Cu5/hVW3EFEOS1cabOKfwsp1ILN5+DAlZqrs=;
        b=nUzUgva2u+qsKcLV8SXl5NkDHhaPA3BCt8OKLug0AMF1upAKhITgqjtIJxo5zcA8Qo
         YXiueGBYPRy5nsCv8iZMynRMGyoiHwq9GWkKOvdfGRbejuoi8X8P5+PyknJuyK0FL3XE
         MMDp3LqHM6kIIAdkxAjR8VlxdyN6pwOmaz4/3gyBQ3SOT4K7aF8iC20KQwjJ2J/eh+ah
         YTkLmCwcx6HgyPaiAZJwPmeTd6s/lF69nLVGSeK/vCDs4Q9GVrC0VayM2BMPePU6uUHf
         n50BwCjCaqbIxKUQbxxgoT/WRkff4i+Lkb+TKBwM4aTJLNISgSuQeDz9gnK2X/cn9Jiu
         27Ww==
X-Gm-Message-State: APt69E1aLtDEWFemlHvuXKAnQ4OuE15kwEQw0TcZ0iK4d6Uz7J6fIofT
        r5M5usIDJgscXM1qL4frhtmVP3ktLwY=
X-Google-Smtp-Source: ADUXVKLjG43YFwQVkHgoSxofJANDhbOKRR9oUVFMw4cEO6usKiH00Ava4hQm3bH6AK3VA6Hcx3F2yw==
X-Received: by 2002:adf:fc8c:: with SMTP id g12-v6mr1724837wrr.216.1529070149837;
        Fri, 15 Jun 2018 06:42:29 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id d5-v6sm9816346wrp.64.2018.06.15.06.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 06:42:28 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        Ben Whitten <ben.whitten@lairdtech.com>
Subject: [PATCH v2 4/6] arm: dts: add support for Laird WB50N cpu module and DVK
Date:   Fri, 15 Jun 2018 14:40:53 +0100
Message-Id: <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Lairds CPU module, featuring Atheros wifi, CSR
Bluetooth and, Atmel SAMA5D3 CPU.
https://www.lairdtech.com/products/wb50nbt-wi-fi-bluetooth-module

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/at91-wb50n.dts  | 112 +++++++++++++++++++++
 arch/arm/boot/dts/at91-wb50n.dtsi | 198 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 04604d2..07823be 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -52,6 +52,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d2_xplained.dtb \
 	at91-sama5d3_xplained.dtb \
 	at91-tse850-3.dtb \
+	at91-wb50n.dtb \
 	sama5d31ek.dtb \
 	sama5d33ek.dtb \
 	sama5d34ek.dtb \
diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-wb50n.dts
new file mode 100644
index 0000000..8cecc70
--- /dev/null
+++ b/arch/arm/boot/dts/at91-wb50n.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-wb50n.dts - Device Tree file for wb50n evaluation board
+ *
+ *  Copyright (C) 2018 Laird
+ *
+ */
+
+/dts-v1/;
+#include "at91-wb50n.dtsi"
+
+/ {
+	model = "Laird Workgroup Bridge 50N - Atmel SAMA5D";
+	compatible = "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		btn0@10 {
+			reg = <10>;
+			label = "BTNESC";
+			linux,code = <1>; /* ESC button */
+			gpios = <&pioA 10 GPIO_ACTIVE_LOW>;
+			gpio-key,wakeup = <1>;
+		};
+
+		irqbtn@31 {
+			reg = <31>;
+			label = "IRQBTN";
+			linux,code = <99>; /* SysReq button */
+			gpios = <&pioE 31 GPIO_ACTIVE_LOW>;
+			gpio-key,wakeup = <1>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "wb50n:blue:led0";
+			gpios = <&pioA 12 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led1 {
+			label = "wb50n:green:led1";
+			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led2 {
+			label = "wb50n:red:led2";
+			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+};
+
+&watchdog {
+	status = "okay";
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
+/* On BB40 this port is labeled UART1 */
+&usart0 {
+	status = "okay";
+};
+
+/* On BB40 this port is labeled UART0 */
+&usart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+
+	spidev@0 {
+		compatible = "spidev";
+		reg = <0>;
+		spi-max-frequency = <8000000>;
+	};
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/at91-wb50n.dtsi b/arch/arm/boot/dts/at91-wb50n.dtsi
new file mode 100644
index 0000000..85692c8
--- /dev/null
+++ b/arch/arm/boot/dts/at91-wb50n.dtsi
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-wb50n.dtsi - Device Tree include file for wb50n cpu module
+ *
+ *  Copyright (C) 2018 Laird
+ *
+ */
+
+#include "sama5d31.dtsi"
+
+/ {
+	model = "Laird Workgroup Bridge 50N - Atmel SAMA5D";
+	compatible = "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
+
+	chosen {
+		bootargs = "ubi.mtd=6 root=ubi0:rootfs rootfstype=ubifs rw";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0x20000000 0x4000000>;
+	};
+};
+
+&pinctrl {
+	board {
+		pinctrl_mmc0_cd: mmc0_cd {
+			atmel,pins = <AT91_PIOC 26 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PC26 GPIO with pullup deglitch */
+		};
+
+		pinctrl_usba_vbus: usba_vbus {
+			atmel,pins = <AT91_PIOB 13 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>; /* PB13 GPIO with deglitch */
+		};
+	};
+};
+
+&slow_xtal {
+	clock-frequency = <32768>;
+};
+
+&main_xtal {
+	clock-frequency = <12000000>;
+};
+
+&slow_osc {
+	atmel,osc-bypass;
+};
+
+&usart1_clk {
+	atmel,clk-output-range = <0 132000000>;
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_cd>;
+	cd-gpios = <&pioC 26 GPIO_ACTIVE_LOW>;
+	slot@0 {
+		reg = <0>;
+		bus-width = <4>;
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
+	status = "okay";
+	atheros@0 {
+		compatible = "atheros,ath6kl";
+		atheros,board-id = "SD32";
+		reg = <0>;
+		bus-width = <4>;
+	};
+};
+
+&macb1 {
+	phy-mode = "rmii";
+};
+
+&dbgu {
+	dmas = <0>, <0>;	/*  Do not use DMA for dbgu */
+};
+
+/* On BB40 this port is labeled UART1 */
+&usart0 {
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts_cts>;
+};
+
+/* On BB40 this port is labeled UART0 */
+&usart1 {
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
+	dtr-gpios = <&pioD 13 GPIO_ACTIVE_LOW>;
+	dsr-gpios = <&pioD 11 GPIO_ACTIVE_LOW>;
+	dcd-gpios = <&pioD 7 GPIO_ACTIVE_LOW>;
+	rng-gpios = <&pioD 8 GPIO_ACTIVE_LOW>;
+};
+
+/* USART3 is direct-connect to the Bluetooth UART on the radio SIP */
+&usart3 {
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart3 &pinctrl_usart3_rts_cts>;
+	status = "okay";
+};
+
+&spi1 {
+	cs-gpios = <&pioC 25 0>, <0>, <0>, <0>;
+};
+
+&ebi {
+	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&nand_controller {
+	status = "okay";
+
+	nand: nand@3 {
+		reg = <0x3 0x0 0x2>;
+		atmel,rb = <0>;
+		nand-bus-width = <8>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <8>;
+		nand-ecc-step-size = <512>;
+		nand-on-flash-bbt;
+		label = "atmel_nand";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			at91bootstrap@0 {
+				label = "at91bs";
+				reg = <0x0 0x20000>;
+			};
+
+			uboot@20000 {
+				label = "u-boot";
+				reg = <0x20000 0x80000>;
+			};
+
+			ubootenv@a0000 {
+				label = "u-boot-env";
+				reg = <0xa0000 0x20000>;
+			};
+
+			ubootenv@c0000 {
+				label = "u-boot-env";
+				reg = <0xc0000 0x20000>;
+			};
+
+			kernel-a@e0000 {
+				label = "kernel-a";
+				reg = <0xe0000 0x500000>;
+			};
+
+			kernel-b@5e0000 {
+				label = "kernel-b";
+				reg = <0x5e0000 0x500000>;
+			};
+
+			rootfs-a@ae0000 {
+				label = "rootfs-a";
+				reg = <0xae0000 0x3000000>;
+			};
+
+			rootfs-b@3ae0000 {
+				label = "rootfs-b";
+				reg = <0x3ae0000 0x3000000>;
+			};
+
+			user@6ae0000 {
+				label = "user";
+				reg = <0x6ae0000 0x14e0000>;
+			};
+		};
+	};
+};
+
+&usb0 {
+	atmel,vbus-gpio = <&pioB 13 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+};
+
+&usb1 {
+	num-ports = <3>;
+	atmel,vbus-gpio = <&pioA 2 GPIO_ACTIVE_LOW>;
+	atmel,oc-gpio = <&pioA 4 GPIO_ACTIVE_LOW>;
+};
-- 
2.7.4

