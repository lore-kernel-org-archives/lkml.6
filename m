Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B3C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CB420645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOMvtWf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeLODCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:02:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36567 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbeLODC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:02:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so3702825pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1fNJLUvL39cWBNfpOmnxroSKUC/RnHz0oy8A/ibN2iA=;
        b=hOMvtWf/WTmzGChczsMxD9Tel3C3DE6XJwxivQdJu64SXdwKEZeKyt8j2YXpOLC+Cb
         vSIXBhKmmLSqZwf+dN0tcGfg1iZzs6Lz+f2iLCJ0f+4QLscjVv1oQq4J+ucTuMDZRj6n
         wTLKGPCKCzCRxdE4Ab1TcKKrjLuYlXfr1FZi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1fNJLUvL39cWBNfpOmnxroSKUC/RnHz0oy8A/ibN2iA=;
        b=KSziZOlqEhNPPny2L2Yf6jveS5HFyIROumdaLxKhqTCJRrRw5PzF4E7kVPXi+Qr9Tq
         nsi6yov029SO5S7SdE1KM18P6I+SAJbH9/D99LVt4U+si6nFV8UQdHwT6EJJxKqLJd64
         F0qujW5orY9iTm/HbSMsvGJyKVU6aJND3nsK0KPvRYbtSMMfSRZ4a7jQq2lPI4Cuw9LT
         HWvtslJailHO1YyCsazQ4xaVIa7yhkNarxE5SuQHDsobsyb4KHi6kbSl9g7EkZNmwtGV
         fgCZDuI2fQRLRQSQy/i37GpHYyG+4LWOd1OWYZ6WqomThoVTP9pC7GFXnkamZyhM9SBb
         LL7w==
X-Gm-Message-State: AA+aEWZISAw73SC1r7d4g8x6K2W4vxTC3JMxY0HQY05FE34wyxgv+8sX
        J9naIEa1e0VbI3goCuX2ESE4
X-Google-Smtp-Source: AFSGD/VUUHjw8mJCSB35OM4jKcGCkNNXemYu5pjLNqMTyYB+ZEXd0J8XGBZopDzoR6Tpnceuqbi4tw==
X-Received: by 2002:a62:56c7:: with SMTP id h68mr5435897pfj.134.1544842948269;
        Fri, 14 Dec 2018 19:02:28 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6301:5419:f1e8:77a0:59f7:2cb5])
        by smtp.gmail.com with ESMTPSA id h15sm7309534pgl.43.2018.12.14.19.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 19:02:27 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     dinguyen@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, amit.kucheria@linaro.org,
        yossi@novtech.com, nazik@novtech.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] ARM: dts: Add support for 96Boards Chameleon96 board
Date:   Sat, 15 Dec 2018 08:31:52 +0530
Message-Id: <20181215030152.4386-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
References: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for 96Boards Chameleon96 board from Novtech, Inc.
based on Altera CycloneV SoC FPGA. This board is one of the Consumer
Edition boards of the 96Boards family and has the following key features:

* SoC - Intel Cyclone V SoC FPGA
* GPU - Graphics based on Intel Video Suite for FPGA
* RAM - 512MB DDR3L
* USB - 2x USB2.0 Host, 1x USB2.0 OTG
* Wireless - Wifi, BT

More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/chameleon96/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/socfpga_cyclone5_chameleon96.dts | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d625b9..d6cf081ec325 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -897,6 +897,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
+	socfpga_cyclone5_chameleon96.dtb \
 	socfpga_cyclone5_mcvevk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_de0_nano_soc.dtb \
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts b/arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts
new file mode 100644
index 000000000000..f6561766d83f
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree file for the Chameleon96
+ *
+ * Copyright (c) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Novetech Chameleon96";
+	compatible = "novtech,chameleon96", "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x20000000>; /* 512MB */
+	};
+
+	regulator_3_3v: 3-3-v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user_led1 {
+			label = "green:user1";
+			gpios = <&porta 14 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "green:user2";
+			gpios = <&porta 22 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "green:user3";
+			gpios = <&porta 25 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "none";
+		};
+
+		user_led4 {
+			label = "green:user4";
+			gpios = <&portb 3 GPIO_ACTIVE_LOW>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	/* On Low speed expansion */
+	label = "LS-I2C0";
+	status = "okay";
+};
+
+&i2c1 {
+	/* On Low speed expansion */
+	label = "LS-I2C1";
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	/* On High speed expansion */
+	label = "HS-I2C2";
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&regulator_3_3v>;
+	vqmmc-supply = <&regulator_3_3v>;
+	status = "okay";
+};
+
+&spi0 {
+	/* On High speed expansion */
+	label = "HS-SPI1";
+	status = "okay";
+};
+
+&spi1 {
+	/* On Low speed expansion */
+	label = "LS-SPI0";
+	status = "okay";
+};
+
+&uart0 {
+	/* On Low speed expansion */
+	label = "LS-UART1";
+	status = "okay";
+};
+
+&uart1 {
+	/* On Low speed expansion */
+	label = "LS-UART0";
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
-- 
2.17.1

