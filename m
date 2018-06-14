Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7E9A9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FAE208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXznysiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FAE208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754887AbeFNIww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:52:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54259 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbeFNIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:52:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so9116385wmc.3;
        Thu, 14 Jun 2018 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YSwbf7xBzgd95VGG+ME0uk6obRo1L377inL5OL/Fm2A=;
        b=TXznysiCDpiQ7XPklX/T8UhzH6UYCth/SOtOnTrk9ZD2bf/X46OAP7NnWowL5wPppZ
         XEEdo64FdxO6wIKjwR+kKHa82MOK6yTZfChR2ZAsYzoau1yEVjOgIR2BGSPUghOfpPPw
         bM7mYLDMFn0hU7vm3+qsLjbAGTZC7mV4ck29nCu2pExs5+RsjlwYsaTDHAvsey+lIYOk
         DaFOXnKoQbZa2wCp+CnQMV+TN8FY2BfhMOvvmwkX3+u78ezLIw4DOJv+65zAbKM9hpUs
         DfhQ+6t5qnHxwsnjrqIvXsz66USZ16lqcAaDugWQoDnx16ILv5vaq3n7JfY7rvuqyUCg
         7VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=YSwbf7xBzgd95VGG+ME0uk6obRo1L377inL5OL/Fm2A=;
        b=Pi8Q5gIdvEaRjRW27WUBBQHHJ5gJ1jB4zaTlxiflYdRmrd6pMPx1DE/yXJdEAvw580
         x5Z5Fs/nVwxvIjYT4mvyHx1YM4UDyQL9ilLbQFU9L130N4urVlJEthuro4x2ETo+fMCQ
         PcI2i82/p+VkbsabEz4HDOH97PhcUmORLfvzmIXrPyWE+XeGDBPAq0H2W6PIAUedbK27
         MCGO8CoaHMg+gl5f0EYlysixSFTOCqs786rzs+g7RjwD2rgDwBucPVucvAWXa7XS+kgS
         w+yW10XjtbFmG9JgIRnrSn0sPfN26vMPTHJLnckS190LlLDPeV1VBclsEc7qXvDK/qst
         P1iA==
X-Gm-Message-State: APt69E1Fu1sS/Z2Xpq4dm0MRggPpr5Nf7U01OHN3kDk7VlqypSrCEKAn
        rlgGpYIWsyJoNjkoaoFd9VCEsznIpNQ=
X-Google-Smtp-Source: ADUXVKK7YaNyUkkWc9rHRmFrEtQgN8WSdFcYBIvbCiT/7WUr1NJFEHxm5wPswo6qvw8+vW4zagyQnQ==
X-Received: by 2002:a1c:256:: with SMTP id 83-v6mr1179157wmc.41.1528966367301;
        Thu, 14 Jun 2018 01:52:47 -0700 (PDT)
Received: from Sarah.lan (83-167-250-20.static.masterinter.net. [83.167.250.20])
        by smtp.gmail.com with ESMTPSA id 72-v6sm5452204wrb.22.2018.06.14.01.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 01:52:46 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     devicetree@vger.kernel.org
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] arm: dts: add support for Laird WB50N cpu module and DVK
Date:   Thu, 14 Jun 2018 09:51:55 +0100
Message-Id: <1528966340-23216-2-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 arch/arm/boot/dts/Makefile        |   3 +-
 arch/arm/boot/dts/at91-wb50n.dts  | 116 ++++++++++++++++++++++
 arch/arm/boot/dts/at91-wb50n.dtsi | 202 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1ee94ee..fd5f8a6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -61,7 +61,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d4_ma5d4evk.dtb \
 	at91-sama5d4_xplained.dtb \
 	at91-sama5d4ek.dtb \
-	at91-vinco.dtb
+	at91-vinco.dtb \
+	at91-wb50n.dtb
 dtb-$(CONFIG_ARCH_ATLAS6) += \
 	atlas6-evb.dtb
 dtb-$(CONFIG_ARCH_ATLAS7) += \
diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-wb50n.dts
new file mode 100644
index 0000000..ee4f823
--- /dev/null
+++ b/arch/arm/boot/dts/at91-wb50n.dts
@@ -0,0 +1,116 @@
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
+	ahb {
+		apb {
+			watchdog@fffffe40 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfffffe40 0x10>;
+				clocks = <&clk32k>;
+				status = "okay";
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		btn0@pa10 {
+			label = "BTNESC";
+			linux,code = <1>; /* ESC button */
+			gpios = <&pioA 10 GPIO_ACTIVE_LOW>;
+			gpio-key,wakeup = <1>;
+		};
+
+		irqbtn@pe31 {
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
index 0000000..11d8cc1
--- /dev/null
+++ b/arch/arm/boot/dts/at91-wb50n.dtsi
@@ -0,0 +1,202 @@
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
+
+	ahb {
+		apb {
+			pinctrl@fffff200 {
+				board {
+					pinctrl_mmc0_cd: mmc0_cd {
+						atmel,pins = <AT91_PIOC 26 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PC26 GPIO with pullup deglitch */
+					};
+
+					pinctrl_usba_vbus: usba_vbus {
+						atmel,pins = <AT91_PIOB 13 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>; /* PB13 GPIO with deglitch */
+					};
+				};
+			};
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

