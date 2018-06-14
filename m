Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4AE65C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF36208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlTF5R2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF36208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754845AbeFNIwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:52:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35705 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbeFNIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:52:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so10466255wme.0;
        Thu, 14 Jun 2018 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=f/+ni1yiQWA9KpaF63Sq0/30LM25q1FUtFjX2o4cK6k=;
        b=AlTF5R2MCY6X7zIvvSQD00wKN8Am3f/CZXpsf9rn987nNjL3HiBko8yOPPOP6N04Gy
         6kg+FzFsVheS6V9yfz9wvFl8LOyeom/+H/UAWsrSkZCNlBMPe+BKdQVU+FNaZorHbvTH
         foirvgq8dCYQtSPm7SdCaEMw24gzYhNrv/oL/p3c/l72ED+KyEum7Qf38qUjzQdsLGCx
         lTywuRZgJipistazNWvigrFLljz4fE50Zu3RzDbBBjNtrzR1DlgGX/WKqP16QiGPS6Bz
         aFdyILrnjjws4XxVqTDhcxLE+NjOIcxNZH4mGl4ZGg6vh/t9xFpoKLKiGpJbwPu3XPhu
         CV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=f/+ni1yiQWA9KpaF63Sq0/30LM25q1FUtFjX2o4cK6k=;
        b=qR2Zr0NgRmdoVPCHit4OXZBeX5o0nZh4tCUmzOpbtLDW/z0n3criUwNuW1D2eGSs5w
         QLIkSPbZ6iTSYToRLU+xm8bHMVM+q8M77ikmyUDjA7t02hSmgJWHi961ZbvQPLQq7+VI
         7W81gggUTJVNqA4Xw9dV3MuWC6cWMizGaj/mhPF6wfoC4SVyPRnVIN9MrA+BiZYd49Oa
         tX+CKeZfOm3Nj66khErnb+S8A25dhpRJ/0ddMeJ1amNyzCUO1j8M2dW5EQQ9NqatmZNK
         7vO+sLETtnqcWKtSDCIopr8jSNCUxiWcPxM/oBx3sDpN5GMztq8gTQ0N3hue2K2jlz58
         813g==
X-Gm-Message-State: APt69E0WHMRmCompYx0hy2Jaebn6ZCPEZnFYIt4VYNzbf+2Vg3fLvo7Z
        zz1rN8MdIeQRzt9/e5HSt1tvH0QpvlY=
X-Google-Smtp-Source: ADUXVKKYrgHhlWGca8MMF9i7E+5lVMiPpNc1+egHqcscs3hcdB54Jp/P5m9C1RVmMip6zM81jxAM9Q==
X-Received: by 2002:a1c:6fce:: with SMTP id c75-v6mr1055789wmi.83.1528966348661;
        Thu, 14 Jun 2018 01:52:28 -0700 (PDT)
Received: from Sarah.lan (83-167-250-20.static.masterinter.net. [83.167.250.20])
        by smtp.gmail.com with ESMTPSA id 72-v6sm5452204wrb.22.2018.06.14.01.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 01:52:27 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     devicetree@vger.kernel.org
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] arm: dts: add support for Laird WB45N cpu module and DVK
Date:   Thu, 14 Jun 2018 09:51:54 +0100
Message-Id: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 arch/arm/boot/dts/Makefile        |   3 +-
 arch/arm/boot/dts/at91-wb45n.dts  |  66 +++++++++++++++
 arch/arm/boot/dts/at91-wb45n.dtsi | 169 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e24249..1ee94ee 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -42,7 +42,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91sam9g25ek.dtb \
 	at91sam9g35ek.dtb \
 	at91sam9x25ek.dtb \
-	at91sam9x35ek.dtb
+	at91sam9x35ek.dtb \
+	at91-wb45n.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2.dtb \
 	at91-nattis-2-natte-2.dtb \
diff --git a/arch/arm/boot/dts/at91-wb45n.dts b/arch/arm/boot/dts/at91-wb45n.dts
new file mode 100644
index 0000000..4e88815
--- /dev/null
+++ b/arch/arm/boot/dts/at91-wb45n.dts
@@ -0,0 +1,66 @@
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
+	ahb {
+		apb {
+			watchdog@fffffe40 {
+				status = "okay";
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		irqbtn@pb18 {
+			label = "IRQBTN";
+			linux,code = <99>;
+			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
+			gpio-key,wakeup = <1>;
+		};
+	};
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
index 0000000..2fa58e2
--- /dev/null
+++ b/arch/arm/boot/dts/at91-wb45n.dtsi
@@ -0,0 +1,169 @@
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
+	ahb {
+		apb {
+			shdwc@fffffe10 {
+				atmel,wakeup-mode = "low";
+			};
+
+			pinctrl@fffff400 {
+				usb2 {
+					pinctrl_board_usb2: usb2-board {
+						atmel,pins =
+							<AT91_PIOB 11 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;		/* PB11 gpio vbus sense, deglitch */
+					};
+				};
+			};
+
+			rstc@fffffe00 {
+				compatible = "atmel,sama5d3-rstc";
+			};
+
+		};
+	};
+
+	atheros {
+		compatible = "atheros,ath6kl";
+		atheros,board-id = "SD32";
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
-- 
2.7.4

