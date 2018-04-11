Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeDKNRK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:17:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35848 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbeDKNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:17:08 -0400
X-Google-Smtp-Source: AIpwx4+RLYqQLAQnvEV3DUmgURj2+4/J8gArzRoVaMKPeyjNz9y83Zp5qLoVmeCGiXMqPbon5rzkAg==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        monstr@monstr.eu, VNSL Durga <vnsl.durga.challa@xilinx.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kedareswara rao Appana <appanad@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Alistair Francis <alistair.francis@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH] arm64: zynqmp: Remove ep108 board
Date: Wed, 11 Apr 2018 15:17:05 +0200
Message-Id: <052cdf7d45bb94e106ae33c972a050089ef75803.1523452618.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP Emulation board is no longer tested and there is no reason to
keep maintaining it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/Makefile           |   1 -
 .../boot/dts/xilinx/zynqmp-ep108-clk.dtsi     | 137 ----------------
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts   | 154 ------------------
 3 files changed, 292 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
 delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index c2a0c00272e2..d452f80e7601 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1232-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1254-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1275-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
deleted file mode 100644
index 9f5eedbc2139..000000000000
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
+++ /dev/null
@@ -1,137 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * clock specification for Xilinx ZynqMP ep108 development board
- *
- * (C) Copyright 2015, Xilinx, Inc.
- *
- * Michal Simek <michal.simek@xilinx.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- */
-
-/ {
-	misc_clk: misc_clk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	i2c_clk: i2c_clk {
-		compatible = "fixed-clock";
-		#clock-cells = <0x0>;
-		clock-frequency = <111111111>;
-	};
-
-	sata_clk: sata_clk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <75000000>;
-	};
-
-	clk100: clk100 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	clk600: clk600 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <600000000>;
-	};
-};
-
-&can0 {
-	clocks = <&misc_clk &misc_clk>;
-};
-
-&can1 {
-	clocks = <&misc_clk &misc_clk>;
-};
-
-&fpd_dma_chan1 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan2 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan3 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan4 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan5 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan6 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan7 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan8 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&gem0 {
-	clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
-};
-
-&gpio {
-	clocks = <&misc_clk>;
-};
-
-&i2c0 {
-	clocks = <&i2c_clk>;
-};
-
-&i2c1 {
-	clocks = <&i2c_clk>;
-};
-
-&sata {
-	clocks = <&sata_clk>;
-};
-
-&sdhci0 {
-	clocks = <&misc_clk>, <&misc_clk>;
-};
-
-&sdhci1 {
-	clocks = <&misc_clk>, <&misc_clk>;
-};
-
-&spi0 {
-	clocks = <&misc_clk &misc_clk>;
-};
-
-&spi1 {
-	clocks = <&misc_clk &misc_clk>;
-};
-
-&uart0 {
-	clocks = <&misc_clk &misc_clk>;
-};
-
-&usb0 {
-	clocks = <&misc_clk>, <&misc_clk>;
-};
-
-&usb1 {
-	clocks = <&misc_clk>, <&misc_clk>;
-};
-
-&watchdog0 {
-	clocks= <&misc_clk>;
-};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
deleted file mode 100644
index 4b0684911626..000000000000
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ /dev/null
@@ -1,154 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * dts file for Xilinx ZynqMP ep108 development board
- *
- * (C) Copyright 2014 - 2015, Xilinx, Inc.
- *
- * Michal Simek <michal.simek@xilinx.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- */
-
-/dts-v1/;
-
-#include "zynqmp.dtsi"
-#include "zynqmp-ep108-clk.dtsi"
-
-/ {
-	model = "ZynqMP EP108";
-
-	aliases {
-		mmc0 = &sdhci0;
-		mmc1 = &sdhci1;
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x40000000>;
-	};
-};
-
-&can0 {
-	status = "okay";
-};
-
-&can1 {
-	status = "okay";
-};
-
-&gem0 {
-	status = "okay";
-	phy-handle = <&phy0>;
-	phy-mode = "rgmii-id";
-	phy0: phy@0 {
-		reg = <0>;
-		max-speed = <100>;
-	};
-};
-
-&gpio {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-	clock-frequency = <400000>;
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
-	};
-};
-
-&i2c1 {
-	status = "okay";
-	clock-frequency = <400000>;
-	eeprom@55 {
-		compatible = "atmel,24c64";
-		reg = <0x55>;
-	};
-};
-
-&sata {
-	status = "okay";
-	ceva,broken-gen2;
-	/* SATA Phy OOB timing settings */
-	ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
-	ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
-	ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
-	ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
-	ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
-	ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
-	ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
-	ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
-};
-
-&sdhci0 {
-	status = "okay";
-	bus-width = <8>;
-};
-
-&sdhci1 {
-	status = "okay";
-};
-
-&spi0 {
-	status = "okay";
-	num-cs = <1>;
-	spi0_flash0: spi0_flash0@0 {
-		compatible = "m25p80";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-
-		spi0_flash0@0 {
-			label = "spi0_flash0";
-			reg = <0x0 0x100000>;
-		};
-	};
-};
-
-&spi1 {
-	status = "okay";
-	num-cs = <1>;
-	spi1_flash0: spi1_flash0@0 {
-		compatible = "m25p80";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-
-		spi1_flash0@0 {
-			label = "spi1_flash0";
-			reg = <0x0 0x100000>;
-		};
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	dr_mode = "peripheral";
-	maximum-speed = "high-speed";
-};
-
-&usb1 {
-	status = "okay";
-	dr_mode = "host";
-	maximum-speed = "high-speed";
-};
-
-&watchdog0 {
-	status = "okay";
-};
-- 
2.17.0
