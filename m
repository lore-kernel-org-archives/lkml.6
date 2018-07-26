Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D7EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCCD2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hGr+hDdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCCD2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeGZFRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:17:53 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42621 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeGZFRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:17:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3D563886B5;
        Thu, 26 Jul 2018 16:03:01 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532577781;
        bh=8l3IANGl3EoAtn6MLBdl2C8WwfV1QBP32gez+NegjmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hGr+hDdJblTS88duP/sQp32K+e7OHWJ4Oyxg2JvTN2sK7ObfJQjVhfgPh2ejVMUW2
         WengxzCr9qj4hSsxwJC/YC9kqWaUaapOayCpo8k967q5GSEYGawzDj3MlWNKO9Gs0A
         Ka7NdDzF5fY1RlfZSnTfcB+hRGvztEJoOiUd2m2M=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5947f50004>; Thu, 26 Jul 2018 16:03:01 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 72B9B13ED1C;
        Thu, 26 Jul 2018 16:03:02 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 18B641E262C; Thu, 26 Jul 2018 16:03:01 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jason@lakedaemon.net,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 4/4] ARM: dts: mvebu: Add device tree for db-88f6820-amc board
Date:   Thu, 26 Jul 2018 16:02:57 +1200
Message-Id: <20180726040257.22285-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
References: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board is a plugin card for some of Marvell's switch development
kits. It's similar to the non-amc board except that it has no SATA
support.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/armada-385-db-88f6820-amc.dts    | 147 ++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de760d40..e4212b7b7d9e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1126,6 +1126,7 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
 dtb-$(CONFIG_MACH_ARMADA_375) += \
 	armada-375-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_38X) += \
+	armada-385-db-88f6820-amc.dtb \
 	armada-385-db-ap.dtb \
 	armada-385-linksys-caiman.dtb \
 	armada-385-linksys-cobra.dtb \
diff --git a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
new file mode 100644
index 000000000000..d87614057e3f
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree file for Marvell Armada 385 AMC board
+ * (DB-88F6820-AMC)
+ *
+ * Copyright (C) 2017 Allied Telesis Labs
+ */
+
+/dts-v1/;
+#include "armada-385.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Marvell Armada 385 AMC";
+	compatible = "marvell,a385-db-amc", "marvell,armada385", "marvell,armada380";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
+		spi1 = &spi1;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000>; /* 2GB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&uart0 {
+	/*
+	 * Exported on the micro USB connector CON3
+	 * through an FTDI
+	 */
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+
+&eth0 {
+	pinctrl-names = "default";
+	/*
+	 * The Reference Clock 0 is used to provide a
+	 * clock to the PHY
+	 */
+	pinctrl-0 = <&ge0_rgmii_pins>, <&ref_clk0_pins>;
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+};
+
+&eth2 {
+	status = "okay";
+	phy = <&phy1>;
+	phy-mode = "sgmii";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+	};
+
+	phy1: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&nand_controller {
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partition@user {
+			reg = <0x00000000 0x40000000>;
+			label = "user";
+		};
+	};
+};
+
+&pciec {
+	status = "okay";
+};
+
+&pcie1 {
+	/* Port 0, Lane 0 */
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	status = "okay";
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		partition@u-boot {
+			reg = <0x00000000 0x00100000>;
+			label = "u-boot";
+		};
+		partition@u-boot-env {
+			reg = <0x00100000 0x00040000>;
+			label = "u-boot-env";
+		};
+	};
+};
+
+&refclk {
+	clock-frequency = <20000000>;
+};
-- 
2.18.0

