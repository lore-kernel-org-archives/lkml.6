Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A69BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6A52089C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="aua2OFIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6A52089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbeGMGij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:38:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38255 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMGij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:38:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id t2-v6so9111755edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=imSltDTkZwvgbaqLcqr5YQACPdg7J5gh9h2V3nI8enc=;
        b=aua2OFIF+YOw7U/A/v7Guc+uxxnAldrOy+TkIdY4yJPld5LF6U+5MMGSD0aihKD8Ha
         eZDYr3T7kW103L/KxfW3KZDWUmfU63u/aPRaESTnNwMkg6Dsne1njnnT2wB3KyiX+K7c
         u5iHLadJuQEBGdC+aGzeuFdl0U45gYAI1QyKL+HXgyArEb6748w4U0R9gQtpeoXnmkLA
         5S2vfqNMuPN7uIzddAgU7I7Ljm/ASdnI5P44aU+BG2d059kS61pUt1tLuNlQ9MmhpQbT
         pPoUVbihNugocq70dlFnaw7E5T9AWPgC8PC5/Fyz4gH5uTIb3zKvyN9C/IMMA4rZ8JRT
         YEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=imSltDTkZwvgbaqLcqr5YQACPdg7J5gh9h2V3nI8enc=;
        b=gLHkO/Pgdt8iN9HX8PCSUw+FFxw+uxUVpQ/w53oI+/H+mz/mla+gIR06nbgPJQbvZq
         KZZL8XG2YtYk9WjGpWV081Pu15XSo9Ssfzr84S1Nd75Bt8z486O4fm/ym+9ZMKnQeDqi
         chDgqqBF8T7/MxC6o4HTz58pQKS1XzV8eAb0RfE5NEnYbhHlDC+2myUuVGKrbT/bNVc4
         vwROzXHGiKgfWSzQWn7t497p24Pe03jJpHpdSYo2qA8U0zUJNCCEH38MpY4Kh7DAvWC+
         rKhttaf5KemrDop2d97h/B3SpQHu3UFrExhMG+8cdG3OvCPhFAK45rGbxZ//iotPRGxo
         tEVQ==
X-Gm-Message-State: AOUpUlGnLO3k7XenyOqrb7UTOWN68n208VEQMz5eTg+daAzI64Du14jz
        4pvw3F5hZeKfHVPgk4LuwIQKRg==
X-Google-Smtp-Source: AAOMgpfYejArLpvG2LWKpg3Kr9IHbgCq7j0ysVNwidMiuJVudTZZ2VQPkEUAeLOVdQHzaX83sb5Qow==
X-Received: by 2002:a50:98a3:: with SMTP id j32-v6mr5463531edb.6.1531463129788;
        Thu, 12 Jul 2018 23:25:29 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id y6-v6sm2559460edo.46.2018.07.12.23.25.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 23:25:29 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board support
Date:   Fri, 13 Jul 2018 08:25:20 +0200
Message-Id: <1531463123-30340-3-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1531463123-30340-1-git-send-email-koen@dominion.thruhere.net>
References: <1531463123-30340-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone Black,
but with the following differences:

 * Gigabit capable PHY
 * Extra USB hub, optional i2c control
 * lps3331ap barometer connected over i2c
 * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
 * 1GiB DDR3 RAM
 * RTL8723 Wifi/Bluetooth connected over USB

Tested on a revision G board.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---
v4: No changes
v3: Drop oppnitro-1000000000, not needed on the versions Sancloud is using
v2: * Add missing #include <dt-bindings/interrupt-controller/irq.h>
    * Fix Barometer compatible string
v1: Initial submission

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/am335x-sancloud-bbe.dts | 136 ++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-sancloud-bbe.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de7..83a4d61 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -695,6 +695,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-pepper.dtb \
 	am335x-phycore-rdk.dtb \
 	am335x-pocketbeagle.dtb \
+	am335x-sancloud-bbe.dtb \
 	am335x-shc.dtb \
 	am335x-sbc-t335.dtb \
 	am335x-sl50.dtb \
diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe.dts b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
new file mode 100644
index 0000000..ba5f4bd
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
@@ -0,0 +1,136 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "am33xx.dtsi"
+#include "am335x-bone-common.dtsi"
+#include "am335x-boneblack-common.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "SanCloud BeagleBone Enhanced";
+	compatible = "sancloud,am335x-boneenhanced", "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
+			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+		>;
+	};
+
+	cpsw_sleep: cpsw_sleep {
+		pinctrl-single,pins = <
+			/* Slave 1 reset value */
+			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins = <
+			/* MDIO */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+		>;
+	};
+
+	davinci_mdio_sleep: davinci_mdio_sleep {
+		pinctrl-single,pins = <
+			/* MDIO reset value */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	usb_hub_ctrl: usb_hub_ctrl {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLUP | MUX_MODE7)     /* rmii1_refclk.gpio0_29 */
+		>;
+	};
+
+	mpu6050_pins: pinmux_mpu6050_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x968, PIN_INPUT | MUX_MODE7)    /* uart0_ctsn.gpio1_8 */
+		>;
+	};
+
+	lps3331ap_pins: pinmux_lps3331ap_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)     /* gpmc_a10.gpio1_26 */
+		>;
+	};
+};
+
+&mac {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_default>;
+	pinctrl-1 = <&cpsw_sleep>;
+	status = "okay";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_default>;
+	pinctrl-1 = <&davinci_mdio_sleep>;
+	status = "okay";
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rgmii-txid";
+};
+
+&i2c0 {
+	lps331ap: lps331ap@5C {
+		compatible = "st,lps331ap-press";
+		st,drdy-int-pin = <1>;
+		reg = <0x5C>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <26 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	mpu6050: mpu6050@68 {
+		compatible = "invensense,mpu6050";
+		reg = <0x68>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+		orientation = <0xff 0 0 0 1 0 0 0 0xff>;
+	};
+
+	usb2512b@2c {
+		compatible = "microchip,usb2512b";
+		reg = <0x2c>;
+		reset-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
+		/* wifi on port 4 */
+	};
+};
-- 
2.0.1

