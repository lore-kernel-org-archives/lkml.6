Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B31DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF5220881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="cNRYpbtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF5220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeGKG4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:56:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42677 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeGKG4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:56:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id g12-v6so18331114edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jTkOL3JqG/zxofwLjOnaPDc9H4xrrRGRCy3cyiaNXzM=;
        b=cNRYpbtEJ0zL9eavB1oXz+AzXu+S+NsxsbI/OTlMDlMW4hiJ1I7ivDWmTGEagz4YTV
         nt7C/gTgkBMIrgzwXMoBScDBzw6MAYjDXS8VJ0aJxPN2ffEa1QGKFHqcXFeReVe/1rIF
         sEUU/dOnWa8G9NPvfqqIjlEJI00yq+3B6R7+f71oK27W2gpRWg3+m38mAYpfmEQA4WuX
         4ayHT2QFXgesxp+PVz6d5PGB2D5gYR/Qu/kaLzgnvwzNRBPwHlZUBONvpyc0jayLI3KD
         0Hxcx0WL5YPWU69byXUv5NKLRcqJkqJcbJTP/BKtBsh345kxJ6rQ56n1RaxUGMgKlf2R
         5nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTkOL3JqG/zxofwLjOnaPDc9H4xrrRGRCy3cyiaNXzM=;
        b=HkjWz5mRQlRMgIMI/uxk/rHmevWuQAwxapr45Zn2RifTXa+fcMMJopwbmToxNe7viT
         GvwXLJRZZX4WCCMwMxmpXxdGs1NV/bC+cDJZOMLBmr51G0egiarX90q4MSPnIlMod15l
         Frwx/5QH45WPXBdfU0DDBPsKpHS0ATFEx1BESwmW2w6D1NLKQnxl09sv8HchDVzdQTEr
         H9nPBouTESzhq1cZxWYkUEzN/8YWj6v9MXnEaepIgTq9jmHsHGJxxUjsAbn1qoM1pM3+
         K4Zr2FNKtK5lexib9XE5SNCU6YE3OgXOuofBjQLLqeHbpzJ+FBYk6R/rH6LHWH7fQky2
         xnyA==
X-Gm-Message-State: APt69E3soRD+GCJlpe33qlU+ouRsztT74mJsv6gAqXlCNgS85V1IsOxI
        QBbY9zqhtCtgwNfQo8GjZMvsonzG
X-Google-Smtp-Source: AAOMgpe95kgcVIEa14Vpq9AkePigRsBSy+mpqUbxF/TVQqicQeDaX2tahHa3p3Pd5GSYJfokUuCDkA==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr30893040edd.30.1531292006533;
        Tue, 10 Jul 2018 23:53:26 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id p18-v6sm995095edc.5.2018.07.10.23.53.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:53:25 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board support
Date:   Wed, 11 Jul 2018 08:53:10 +0200
Message-Id: <1531291992-30512-3-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1531291992-30512-1-git-send-email-koen@dominion.thruhere.net>
References: <1531291992-30512-1-git-send-email-koen@dominion.thruhere.net>
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
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/am335x-sancloud-bbe.dts | 146 ++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
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
index 0000000..3d4f413
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
@@ -0,0 +1,146 @@
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
+
+/ {
+	model = "SanCloud BeagleBone Enhanced";
+	compatible = "sancloud,am335x-boneenhanced", "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
+};
+
+&cpu0_opp_table {
+	/*
+	 * All PG 2.0 silicon may not support 1GHz but some of the early
+	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
+	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
+	 */
+	oppnitro-1000000000 {
+		opp-supported-hw = <0x06 0x0100>;
+	};
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
+		compatible = "st,lps331ap";
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

