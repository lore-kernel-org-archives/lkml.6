Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428693AbeCBTWO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:22:14 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41574 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427224AbeCBTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:21:46 -0500
X-Google-Smtp-Source: AG47ELsY2DMGnWnY7Sih+aZAdIZj7LRMqMbdJnWP92Ud6v2u2LIJiblcNfJhM8eqJxriabUct/8Yrg==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robherring2@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/5] arm: zynq: Add support for Xilinx zc770 xm012 dc3 board
Date: Fri,  2 Mar 2018 20:21:36 +0100
Message-Id: <5f7541dd383dea947a5d74230c58b52cedab4075.1520018484.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520018484.git.michal.simek@xilinx.com>
References: <cover.1520018484.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1520018484.git.michal.simek@xilinx.com>
References: <cover.1520018484.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zc770 is based board which is extended by FMC/DC cards for SoC
validation. FMCs/DCs are supposed to cover all SoC configurations.
FMC/DC contains can, 2x i2c, nor flash, spi and uart.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None
Changes in v2:
- Record compatible string to xilinx.txt

 Documentation/devicetree/bindings/arm/xilinx.txt |  1 +
 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/zynq-zc770-xm012.dts           | 64 ++++++++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm012.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 80139a7cfcdc..745c898f2f7f 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -14,6 +14,7 @@ Additional compatible strings:
 - Xilinx internal board zc770 with different FMC cards
   "xlnx,zynq-zc770-xm010"
   "xlnx,zynq-zc770-xm011"
+  "xlnx,zynq-zc770-xm012"
 
 ---------------------------------------------------------------
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 801a46a88e93..2c74b935ad1c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1069,6 +1069,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-zc706.dtb \
 	zynq-zc770-xm010.dtb \
 	zynq-zc770-xm011.dtb \
+	zynq-zc770-xm012.dtb \
 	zynq-zed.dtb \
 	zynq-zybo.dtb
 dtb-$(CONFIG_MACH_ARMADA_370) += \
diff --git a/arch/arm/boot/dts/zynq-zc770-xm012.dts b/arch/arm/boot/dts/zynq-zc770-xm012.dts
new file mode 100644
index 000000000000..c3169d63600d
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zc770-xm012.dts
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZC770 XM012 board DTS
+ *
+ * Copyright (C) 2013-2018 Xilinx, Inc.
+ */
+/dts-v1/;
+#include "zynq-7000.dtsi"
+
+/ {
+	compatible = "xlnx,zynq-zc770-xm012", "xlnx,zynq-7000";
+	model = "Xilinx Zynq";
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		serial0 = &uart1;
+		spi0 = &spi1;
+	};
+
+	chosen {
+		bootargs = "";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+	};
+};
+
+&can1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom0: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom1: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+	};
+};
+
+&spi1 {
+	status = "okay";
+	num-cs = <4>;
+	is-decoded-cs = <0>;
+};
+
+&uart1 {
+	status = "okay";
+};
-- 
1.9.1
