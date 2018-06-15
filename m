Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A7450C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5235E208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsTkhKmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5235E208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965960AbeFONng (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:43:36 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37590 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965805AbeFONm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:42:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id d8-v6so10000630wro.4;
        Fri, 15 Jun 2018 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HEOPI46B/XV4wthIsWISHAGGXIOgnZfKg/CnltTV5sM=;
        b=YsTkhKmL581+zTJ5CXS7vsBF4GpAy/vpQB5XrbO/md4vToDx+0TidVP6b/+xVVeJYY
         D3SllauIFDJ47OtlkMwh3etFhKq2VetkVnXkd6QrliVtJMMZXbu5/Houxu/9yB1XG1vP
         gb+p52UdoozLjGWn3gzUpO/1ljJdn5jMjAOlShl+CB2XqFM1DYAxFDfMLubmHvQJxp71
         Vxh69q7MBDcljd4J8uWXdbkOmPYe6vnjVqZj4n8D0QPp2YniQGEaKSDsBLdXMeuD6DRS
         bfk0hPeNFJ2SJQiLCPs6wjoMTXC/lRTQ6MvzC+L7DyeWFs8GhDYO4guI/Ba3NqFmVnU/
         h3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=HEOPI46B/XV4wthIsWISHAGGXIOgnZfKg/CnltTV5sM=;
        b=KtCjni7vi+IW/fx+cacOoo3HRwjFgGEoDAV67YXvjNGw3CLKfdR0Db9L0+CEoxVTPK
         kaTBo2Xoj5GVb/6YqskZMvd4oSS5bxevJx9lKerNf3OXWrDcB3Poq1w8XNWzQDGfaWqo
         YBuf2kC9Gw0DOu3MD8CidZusXFGeA00BT5eAEM0O7Az1mFzC9EPGxDGo6ZL3WBUBAtYF
         RhdiDHJRecaq3a896j34eig0cEF0+3VPTSxLXSWFX724M0cItUL18+Fzmfvi0/mYy3hY
         gpKQLPSBWi1QLJjoVXfGFP8RT7dr8eW2f+ShihQET12VgJf95ufqk3/7aN35GcIli82p
         tbCA==
X-Gm-Message-State: APt69E1+diWxHMJy4bN5dK+k2L73sdVWKfFlEeE/1cmRkJrOrOqaDT+N
        1QdjIAMe56ZmBbonRaKsHn80aaacspw=
X-Google-Smtp-Source: ADUXVKKuM+JnuVmJul0bdZOY0vubweXHY3FjUZR0xpjp1gQgJlYuezRB5Mn3oQ2djgNWbg7PO2mBkQ==
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr1704163wra.114.1529070148155;
        Fri, 15 Jun 2018 06:42:28 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id d5-v6sm9816346wrp.64.2018.06.15.06.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 06:42:26 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        Ben Whitten <ben.whitten@lairdtech.com>
Subject: [PATCH v2 3/6] arm: dts: add support for Laird WB45N cpu module and DVK
Date:   Fri, 15 Jun 2018 14:40:52 +0100
Message-Id: <1529070055-18701-3-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Lairds combo CPU module, featuring on board
Atheros wifi, CSR Bluetooth radio and, Atmel CPU.
https://www.lairdtech.com/products/wb45nbt

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/at91-wb45n.dts  |  64 +++++++++++++++
 arch/arm/boot/dts/at91-wb45n.dtsi | 165 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e24249..04604d2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -38,6 +38,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91-ariettag25.dtb \
 	at91-cosino_mega2560.dtb \
 	at91-kizboxmini.dtb \
+	at91-wb45n.dtb \
 	at91sam9g15ek.dtb \
 	at91sam9g25ek.dtb \
 	at91sam9g35ek.dtb \
diff --git a/arch/arm/boot/dts/at91-wb45n.dts b/arch/arm/boot/dts/at91-wb45n.dts
new file mode 100644
index 0000000..64ce150
--- /dev/null
+++ b/arch/arm/boot/dts/at91-wb45n.dts
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-wb45n.dts - Device Tree file for WB45NBT board
+ *
+ *  Copyright (C) 2018 Laird
+ *
+*/
+/dts-v1/;
+#include "at91-wb45n.dtsi"
+
+/ {
+	model = "Laird Workgroup Bridge 45N - Atmel AT91SAM (dt)";
+	compatible = "laird,wb45n", "laird,wbxx", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		irqbtn@18 {
+			reg = <18>;
+			label = "IRQBTN";
+			linux,code = <99>;
+			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
+			gpio-key,wakeup = <1>;
+		};
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&macb0 {
+	status = "okay";
+};
+
+&dbgu {
+	status = "okay";
+};
+
+&usart0 {
+	status = "okay";
+};
+
+&usart3 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/at91-wb45n.dtsi b/arch/arm/boot/dts/at91-wb45n.dtsi
new file mode 100644
index 0000000..ebe61a2
--- /dev/null
+++ b/arch/arm/boot/dts/at91-wb45n.dtsi
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-wb45n.dtsi - Device Tree file for WB45NBT board
+ *
+ *  Copyright (C) 2018 Laird
+ *
+ */
+
+#include "at91sam9g25.dtsi"
+
+/ {
+	model = "Laird Workgroup Bridge 45N - Atmel AT91SAM (dt)";
+	compatible = "laird,wb45n", "laird,wbxx", "atmel,at91sam9x5", "atmel,at91sam9";
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
+	atheros {
+		compatible = "atheros,ath6kl";
+		atheros,board-id = "SD32";
+	};
+};
+
+&reset_controller {
+	compatible = "atmel,sama5d3-rstc";
+};
+
+&shutdown_controller {
+	atmel,wakeup-mode = "low";
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
+&ebi {
+	status = "okay";
+	nand_controller: nand-controller {
+		pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb &pinctrl_nand_oe_we>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		nand@3 {
+			reg = <0x3 0x0 0x800000>;
+			rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+			cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <4>;
+			nand-ecc-step-size = <512>;
+			nand-on-flash-bbt;
+			label = "atmel_nand";
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				at91bootstrap@0 {
+					label = "at91bs";
+					reg = <0x0 0x20000>;
+				};
+
+				uboot@20000 {
+					label = "u-boot";
+					reg = <0x20000 0x80000>;
+				};
+
+				ubootenv@a0000 {
+					label = "u-boot-env";
+					reg = <0xa0000 0x20000>;
+				};
+
+				ubootenv@c0000 {
+					label = "redund-env";
+					reg = <0xc0000 0x20000>;
+				};
+
+				kernel-a@e0000 {
+					label = "kernel-a";
+					reg = <0xe0000 0x280000>;
+				};
+
+				kernel-b@360000 {
+					label = "kernel-b";
+					reg = <0x360000 0x280000>;
+				};
+
+				rootfs-a@5e0000 {
+					label = "rootfs-a";
+					reg = <0x5e0000 0x2600000>;
+				};
+
+				rootfs-b@2be0000 {
+					label = "rootfs-b";
+					reg = <0x2be0000 0x2600000>;
+				};
+
+				user@51e0000 {
+					label = "user";
+					reg = <0x51e0000 0x2dc0000>;
+				};
+
+				logs@7fa0000 {
+					label = "logs";
+					reg = <0x7fa0000 0x60000>;
+				};
+
+			};
+		};
+	};
+};
+
+&usb0 {
+	num-ports = <2>;
+	atmel,vbus-gpio = <
+		&pioB 12 GPIO_ACTIVE_HIGH
+		&pioA 31 GPIO_ACTIVE_HIGH
+		>;
+	atmel,oc-gpio = <&pioB 13 GPIO_ACTIVE_LOW>;
+};
+
+&macb0 {
+	phy-mode = "rmii";
+};
+
+&spi0 {
+	cs-gpios = <&pioA 14 0>, <&pioA 7 0>, <0>, <0>;
+};
+
+&usb2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_board_usb2>;
+	atmel,vbus-gpio = <&pioB 11 GPIO_ACTIVE_HIGH>;
+};
+
+&mmc0 {
+	pinctrl-0 = <
+		&pinctrl_mmc0_slot0_clk_cmd_dat0
+		&pinctrl_mmc0_slot0_dat1_3>;
+	slot@0 {
+		reg = <0>;
+		bus-width = <4>;
+	};
+};
+
+&pinctrl {
+	usb2 {
+		pinctrl_board_usb2: usb2-board {
+			atmel,pins =
+				<AT91_PIOB 11 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;		/* PB11 gpio vbus sense, deglitch */
+		};
+	};
+};
+
-- 
2.7.4

