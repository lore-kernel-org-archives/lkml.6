Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B985ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0405520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jye5i6AB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0405520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeGQEhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:37:43 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39917 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeGQEhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:37:43 -0400
Received: by mail-pl0-f67.google.com with SMTP id p23-v6so4965130plo.6;
        Mon, 16 Jul 2018 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X9o6hDImuZDSbUhi1dQnYkAOv4sdQkvVtpGAndIoa7A=;
        b=Jye5i6ABS/w+jOG94MBqNeiTGqeTf/F7PP8stfLYYoQ7+BiqWlil6Op/QbRn5Ap6+e
         Bi9CQd3nywdDxi/TXy6pv6vyHNt0f4qqoCsk0E0kvm6CipGlkFFpaf+C+L0/N/MY73b0
         pd7AVdFblpp5ugZXJBivj6RZVKi/STneyaDfC88bBSBQhsTKNyUrHIlZmVOqJ4TDRLMd
         CLfpHb5LgSBVtdQECcmFJsXPSha0JdP0jIuNa/2jaj1zZnkm17upPJw/naDsEk6ID2/d
         7gqYMVqullmSmJRBnFLNq7slz3WNhRAEtWn0AMM24JGlBz3F5ZAxTm2Kk1+kL1Xzi0yL
         483A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X9o6hDImuZDSbUhi1dQnYkAOv4sdQkvVtpGAndIoa7A=;
        b=B7DAzVXBJljS6k4pEfX49XzS7tzmX9nE3DbcxQVoVrgXLm8aDY1pQgTKxbgxC4ngNr
         PLHOWDomIiTg3oiVGdw7znV56gMVGOab+YCTD8GmmWpSMFYmQ8Q9pTZh8aUy0PmGNPWl
         UcARpOaP/2W1O/LOmYHhNBPZ1IAgAw0W6vOV2WVbSecvn4rmBW8fmhP/J6JcmhhYb9Z6
         eD3wuiiXaOKVWVsAVHOdV2pQLFhgem1x/0m/Vjk/HfnWmktmadrPZp7pjrYMmaxTJpDR
         rcZU6LW7IpASj8lJTNnMUn3eXRIYnN+KKWGkCJ6BvdynB+i5Tkgp8hHkaW+rxKEav6yQ
         SFlQ==
X-Gm-Message-State: AOUpUlEemekmCDUueFfPn7m+9O3QRNKl/RHmK6fLZ/sftW25a8f7YJws
        GAo+AJM6gflUuHOzB9HPPm95t2Ds
X-Google-Smtp-Source: AAOMgpdqrDI9UgTDGfvodsk1zAtpHwnV8IInn5HcIm4hwvKtgwOyV/E9Iesu6E62IqlbW2ya/8A6NA==
X-Received: by 2002:a17:902:6902:: with SMTP id j2-v6mr19110533plk.323.1531800430884;
        Mon, 16 Jul 2018 21:07:10 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a11-v6sm59823526pfl.66.2018.07.16.21.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:07:10 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
Date:   Mon, 16 Jul 2018 21:06:51 -0700
Message-Id: <20180717040651.641-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Zodiac Inflight Innovations SSMB SPU3
board (VF610-based).

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 343 ++++++++++++++++++++++
 2 files changed, 345 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bea41b129493..e331b2c16539 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -570,7 +570,8 @@ dtb-$(CONFIG_SOC_VF610) += \
 	vf610m4-cosmic.dtb \
 	vf610-twr.dtb \
 	vf610-zii-dev-rev-b.dtb \
-	vf610-zii-dev-rev-c.dtb
+	vf610-zii-dev-rev-c.dtb \
+	vf610-zii-ssmb-spu3.dtb
 dtb-$(CONFIG_ARCH_MXS) += \
 	imx23-evk.dtb \
 	imx23-olinuxino.dtb \
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
new file mode 100644
index 000000000000..b692117d7839
--- /dev/null
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/*
+ * Device tree file for ZII's SSMB SPU3 board
+ *
+ * SSMB - SPU3 Switch Management Board
+ * SPU - Seat Power Unit
+ *
+ * Copyright (C) 2015, 2016 Zodiac Inflight Innovations
+ *
+ * Based on an original 'vf610-twr.dts' which is Copyright 2015,
+ * Freescale Semiconductor, Inc.
+ */
+
+/dts-v1/;
+#include "vf610.dtsi"
+
+/ {
+	model = "ZII VF610 SSMB SPU3 Board";
+	compatible = "zii,vf610spu3", "zii,vf610dev", "fsl,vf610";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	memory {
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
+	};
+
+	reg_vcc_3v3_mcu: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_mcu";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
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
+	/*
+	 * Some SPU3s come with SPI-NOR chip DNPed, so we leave this
+	 * node disabled by default and rely on bootloader to enable
+	 * it when appropriate.
+	 */
+	status = "disabled";
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
+			compatible = "marvell,mv88e6190";
+			pinctrl-0 = <&pinctrl_gpio_switch0>;
+			pinctrl-names = "default";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			eeprom-length = <65536>;
+			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "cpu";
+					ethernet = <&fec1>;
+
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "eth_cu_1000_1";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "eth_cu_1000_2";
+				};
+
+				port@3 {
+					reg = <3>;
+					label = "eth_cu_1000_3";
+				};
+
+				port@4 {
+					reg = <4>;
+					label = "eth_cu_1000_4";
+				};
+
+				port@5 {
+					reg = <5>;
+					label = "eth_cu_1000_5";
+				};
+
+				port@6 {
+					reg = <6>;
+					label = "eth_cu_1000_6";
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
+	gpio6: pca9505@22 {
+		compatible = "nxp,pca9554";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	lm75@48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+
+	at24c04@50 {
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		label = "nameplate";
+	};
+
+	at24c04@52 {
+		compatible = "atmel,24c04";
+		reg = <0x52>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu2";
+		current-speed = <1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		watchdog {
+			compatible = "zii,rave-sp-watchdog";
+		};
+
+		eeprom@a3 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa3 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "main-eeprom";
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_dspi1: dspi1grp {
+		fsl,pins = <
+			VF610_PAD_PTD5__DSPI1_CS0		0x1182
+			VF610_PAD_PTD4__DSPI1_CS1		0x1182
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
+			VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
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
+	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
+		fsl,pins = <
+			VF610_PAD_PTE2__GPIO_107		0x31c2
+			VF610_PAD_PTB28__GPIO_98		0x219d
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
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			VF610_PAD_PTB16__I2C1_SCL		0x37ff
+			VF610_PAD_PTB17__I2C1_SDA		0x37ff
+		>;
+	};
+
+	pinctrl_leds_debug: pinctrl-leds-debug {
+		fsl,pins = <
+			VF610_PAD_PTD3__GPIO_82			0x31c2
+		>;
+	};
+
+	pinctrl_uart0: uart0grp {
+		fsl,pins = <
+			VF610_PAD_PTB10__UART0_TX		0x21a2
+			VF610_PAD_PTB11__UART0_RX		0x21a1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			VF610_PAD_PTB23__UART1_TX		0x21a2
+			VF610_PAD_PTB24__UART1_RX		0x21a1
+		>;
+	};
+};
-- 
2.17.1

