Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E04C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B472084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byoPntrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B472084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbeGSUmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:42:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45585 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeGSUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:42:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so4681127pgq.12;
        Thu, 19 Jul 2018 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KrBr3hKSf4crUJH8StXG9JhhiBfZ9YPJ1ObelX61xKM=;
        b=byoPntrFOABAedcVAoSSJdw3gLSkUiydTJQa7q/kbUbGF7J/lB6ekwgBIKRwSdM1Ow
         bgc6R8QHPlUPbZNhcec5COWs6ZP5e5VOsV8zwp3sL3h6WFJac2R4qsAAQIEksPcs+GWp
         yW3rwwNrHfbHf2RUmxqWxsAalVTQcvoSYvdk6aySfAJfu5xh5ZzYtq8znrYMyQGzy7MH
         hHZxM3068iKtf3UQdZugpq3MjLxW6OoRgUelYCZDTp5RSC6XDK/mWWEudVz5scb4KHs0
         GzAt5vikEsKZm08RQm2uHtjZB4+gOqW7DFkO23/GGBNkAsXefn7W739qp9bvTRsDzgxV
         4b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KrBr3hKSf4crUJH8StXG9JhhiBfZ9YPJ1ObelX61xKM=;
        b=E1Rg/GZz2EUrH4CKbAZ2WsicDDYShVJISQYGuWl+jeTp6dj5U4BhLhcDhcaOLga59E
         gPBaHhqucFxo1Z45H/rV2wa7ow6m7qtbJ2wNxhIyqBxlyhNVmBleAorbOgFR0r6yCuIl
         IG0vH5ObTCiR8cavxio+/87EEMErws8tFo13na3TmUnCY4MdeBPikwvCKhqDAxS1TynO
         6ioQjIDFI2WlEbf06LCwb7cyJUqsNFsT2J1088Pk5ICR7N0TwTjt6nTS8JHjJ4zeCUVo
         hhh+41Mnm5Gz4srhsItekH0DsELQLkR2I163K85b9cgPiL+K2J6J4ZiD3e7QYmTzkwmS
         Xdgw==
X-Gm-Message-State: AOUpUlEm/veS1mfCN1iwVH/FwwFa4WGq3PEC5RFCKnYGQzERXu+SW2N6
        ocb1jWGtNEUVWLERwvLWrng=
X-Google-Smtp-Source: AAOMgpcKdNIALRi/45slQ4dvi2NIKURDdxSU7B5Jt7H+2HS/xCERy6eG3SAkSkUGUnzfXr2rYJuElw==
X-Received: by 2002:a62:d646:: with SMTP id r67-v6mr10953168pfg.130.1532030265833;
        Thu, 19 Jul 2018 12:57:45 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id j75-v6sm16455pfj.102.2018.07.19.12.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 12:57:44 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2] ARM: dts: vf610: Add ZII CFU1 board
Date:   Thu, 19 Jul 2018 12:57:24 -0700
Message-Id: <20180719195724.15563-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Zodiac Inflight Innovations CFU1
board (VF610-based).

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v1]:

    - Fixed DT warning when compiling with W=1

    - Collected Reviewed-by from Fabio

[v1] lkml.kernel.org/r/20180719005941.10458-1-andrew.smirnov@gmail.com

 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/vf610-zii-cfu1.dts | 305 +++++++++++++++++++++++++++
 2 files changed, 306 insertions(+)
 create mode 100644 arch/arm/boot/dts/vf610-zii-cfu1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e331b2c16539..85797819fdd9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -569,6 +569,7 @@ dtb-$(CONFIG_SOC_VF610) += \
 	vf610-cosmic.dtb \
 	vf610m4-cosmic.dtb \
 	vf610-twr.dtb \
+	vf610-zii-cfu1.dtb \
 	vf610-zii-dev-rev-b.dtb \
 	vf610-zii-dev-rev-c.dtb \
 	vf610-zii-ssmb-spu3.dtb
diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
new file mode 100644
index 000000000000..37777cf22e67
--- /dev/null
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/*
+ * Copyright (C) 2018 Zodiac Inflight Innovations
+ */
+
+/dts-v1/;
+#include "vf610.dtsi"
+
+/ {
+	model = "ZII VF610 CFU1 Board";
+	compatible = "zii,vf610cfu1", "zii,vf610dev", "fsl,vf610";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pinctrl_leds_debug>;
+		pinctrl-names = "default";
+
+		led-debug {
+			label = "zii:green:debug1";
+			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			max-brightness = <1>;
+		};
+
+		led-fail {
+			label = "zii:red:fail";
+			gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+			max-brightness = <1>;
+		};
+
+		led-status {
+			label = "zii:green:status";
+			gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			max-brightness = <1>;
+		};
+
+		led-debug-a {
+			label = "zii:green:debug_a";
+			gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			max-brightness = <1>;
+		};
+
+		led-debug-b {
+			label = "zii:green:debug_b";
+			gpios = <&gpio3 15 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			max-brightness = <1>;
+		};
+	};
+
+	reg_vcc_3v3_mcu: regulator-vcc-3v3-mcu {
+		 compatible = "regulator-fixed";
+		 regulator-name = "vcc_3v3_mcu";
+		 regulator-min-microvolt = <3300000>;
+		 regulator-max-microvolt = <3300000>;
+	};
+};
+
+&adc0 {
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
+};
+
+&adc1 {
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
+};
+
+&dspi1 {
+	bus-num = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dspi1>;
+	status = "okay";
+
+	m25p128@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+
+		partition@0 {
+			label = "m25p128-0";
+			reg = <0x0 0x01000000>;
+		};
+	};
+};
+
+&edma0 {
+	status = "okay";
+};
+
+&edma1 {
+	status = "okay";
+};
+
+&esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc0>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&fec1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	status = "okay";
+
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+
+	mdio1: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		switch0: switch0@0 {
+			compatible = "marvell,mv88e6085";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_switch>;
+			reg = <0>;
+			eeprom-length = <512>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "eth_cu_1000_1";
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "eth_cu_1000_2";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "eth_cu_1000_3";
+				};
+
+				port@6 {
+					reg = <6>;
+					label = "cpu";
+					ethernet = <&fec1>;
+
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+			};
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	status = "okay";
+
+	pca9554@22 {
+		compatible = "nxp,pca9554";
+		reg = <0x22>;
+		gpio-controller;
+	};
+
+	lm75@48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+
+	at24c04@52 {
+		compatible = "atmel,24c04";
+		reg = <0x52>;
+		label = "nvm";
+	};
+
+	at24c04@54 {
+		compatible = "atmel,24c04";
+		reg = <0x54>;
+		label = "nameplate";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_dspi1: dspi1grp {
+		fsl,pins = <
+			VF610_PAD_PTD5__DSPI1_CS0		0x1182
+			VF610_PAD_PTC6__DSPI1_SIN		0x1181
+			VF610_PAD_PTC7__DSPI1_SOUT		0x1182
+			VF610_PAD_PTC8__DSPI1_SCK		0x1182
+		>;
+	};
+
+	pinctrl_esdhc0: esdhc0grp {
+		fsl,pins = <
+			VF610_PAD_PTC0__ESDHC0_CLK		0x31ef
+			VF610_PAD_PTC1__ESDHC0_CMD		0x31ef
+			VF610_PAD_PTC2__ESDHC0_DAT0		0x31ef
+			VF610_PAD_PTC3__ESDHC0_DAT1		0x31ef
+			VF610_PAD_PTC4__ESDHC0_DAT2		0x31ef
+			VF610_PAD_PTC5__ESDHC0_DAT3		0x31ef
+			VF610_PAD_PTD23__ESDHC0_DAT4		0x31ef
+			VF610_PAD_PTD22__ESDHC0_DAT5		0x31ef
+			VF610_PAD_PTD21__ESDHC0_DAT6		0x31ef
+			VF610_PAD_PTD20__ESDHC0_DAT7		0x31ef
+		>;
+	};
+
+	pinctrl_esdhc1: esdhc1grp {
+		fsl,pins = <
+			VF610_PAD_PTA24__ESDHC1_CLK		0x31ef
+			VF610_PAD_PTA25__ESDHC1_CMD		0x31ef
+			VF610_PAD_PTA26__ESDHC1_DAT0		0x31ef
+			VF610_PAD_PTA27__ESDHC1_DAT1		0x31ef
+			VF610_PAD_PTA28__ESDHC1_DATA2		0x31ef
+			VF610_PAD_PTA29__ESDHC1_DAT3		0x31ef
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			VF610_PAD_PTA6__RMII_CLKIN		0x30d1
+			VF610_PAD_PTC9__ENET_RMII1_MDC		0x30fe
+			VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
+			VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
+			VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
+			VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
+			VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
+			VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
+			VF610_PAD_PTC16__ENET_RMII1_TXD0	0x30d2
+			VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
+		>;
+	};
+
+	pinctrl_i2c0: i2c0grp {
+		fsl,pins = <
+			VF610_PAD_PTB14__I2C0_SCL		0x37ff
+			VF610_PAD_PTB15__I2C0_SDA		0x37ff
+		>;
+	};
+
+	pinctrl_leds_debug: pinctrl-leds-debug {
+		fsl,pins = <
+			VF610_PAD_PTD3__GPIO_82			0x31c2
+			VF610_PAD_PTE3__GPIO_108		0x31c2
+			VF610_PAD_PTE4__GPIO_109		0x31c2
+			VF610_PAD_PTE5__GPIO_110		0x31c2
+			VF610_PAD_PTE6__GPIO_111		0x31c2
+		>;
+	};
+
+	pinctrl_switch: switch-grp {
+		fsl,pins = <
+			VF610_PAD_PTB28__GPIO_98		0x3061
+			VF610_PAD_PTE2__GPIO_107		0x1042
+		>;
+	};
+
+	pinctrl_uart0: uart0grp {
+		fsl,pins = <
+			VF610_PAD_PTB10__UART0_TX		0x21a2
+			VF610_PAD_PTB11__UART0_RX		0x21a1
+		>;
+	};
+};
-- 
2.17.1

