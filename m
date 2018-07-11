Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C42AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50FF208E8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNzhyYjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50FF208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeGKFJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:09:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35017 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeGKFJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:09:47 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so8619816plt.2;
        Tue, 10 Jul 2018 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xLLgEmu5ss9G2Rd2gYw96hnCUj0la1u03mTGizwiKHQ=;
        b=WNzhyYjm9YxTf4SuSHoedwHsAYqwuTSegBDHtAlrFFkB7X7vM5jjgMmZBrkEkp+Ske
         WvlVrC0sv06shTupn3IYxO80dMnuzx2n9BEdxW4ZWzsHCDEZBZ50NEsgaRzYDc4o6y6V
         SBpUYCxO4kgVcOUjYNVPoru3cQhBYKtnx7yGd5hHOQIUdkwYuTMHtxIGUcD0nzlcLDq0
         /UFK+nLo18DJP4yAYIU8IALNDjON1J6L7wtkrhY1xL6ppi4BoMFYeaxDtyeiWm8gC9yg
         yRdzDNcAt5iRcEidXO3njMDPf5IS4p7LiuIepGrc1a1y90kjgmde+7t87B0z2pcEdIew
         aJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xLLgEmu5ss9G2Rd2gYw96hnCUj0la1u03mTGizwiKHQ=;
        b=sbBa5FQGGVAjUHjp2a3v+pBCIBag66fnew61cFdoEcLkb4m/YDMdKkdJfCNfv2n+1G
         hrF6cPQqfAND0QjgMAzU0sI9sfMx9elF992FImb2hRW3XOV49tuJcu1F09XNZyBas6c+
         dPhCFZ9pHOsBqFNo+DDzpajpIqqFL35QRd8oaIIUcdH7fKduQjzj3GX+apHfs70K4ESR
         YVXAZdYa58qWvAln3K57vlxpCF8Xf5dNSqFAvQQP3wifQ4NyUJxPDgHPg4D11XzVrNon
         qvb5L7SzFwEE64skmGpU8F4QHDvQ5GOnhFBeyZHEdZtVCHlqcM69/9Csa2tV38qgNtNj
         epkA==
X-Gm-Message-State: APt69E2JwAwEBYnL8bqd3Nr7J4rzk/IPjeAyQmR+5qcsgrrrloGfq0+p
        sWZpqmYiDLKJegWV1+x+DEH9qfpL
X-Google-Smtp-Source: AAOMgpdLvkdjg/Nm5ef7aGJZORFNkSJEetEzV3qO8KLcQYuX7bZlcWol/x4UumTF7ATUFIYXKRmp3w==
X-Received: by 2002:a17:902:1703:: with SMTP id i3-v6mr26700161pli.263.1531285640722;
        Tue, 10 Jul 2018 22:07:20 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id r28-v6sm16891199pfd.37.2018.07.10.22.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 22:07:19 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Subject: [PATCH] ARM: dts: imx: Add ZII SCU3 ESB
Date:   Tue, 10 Jul 2018 22:07:04 -0700
Message-Id: <20180711050704.11492-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Zodiac Inflight Innovations i.MX51-base SCU3 Ethernet
Switch Board (ESB)

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy@gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Shawn:

Similarly to [mezz] this is a spin-off of SCU3 (AFAIU, original
submission incorrectly called it SCU2 ESB) ESB board support
originally found in [v0].

Original submission was done by Andrey Gusakov, but he is too busy on
other projects, so the honors of submitting this were delegated to me.

NOTE: RAVE SP ("zii,rave-sp-esb") node is technically supported by
upstream, but it needs some fixes from [rave-sp-fixes] to work
correctly. If you want me to drop that node until [rave-sp-fixes] is
merged, let me know.

NOTE: This patch is currently generated to be on top of [mezz], but
that can be easily change should it be accepted first

Changes since [v0]:

 - Patch converted to be a standalone file not dependent on any
   ZII-specific .dtsi

 - Added RAVE SP node with all the children that are currently
   supported by upstream

 - Droppped ecspi2 node. That node didn't have any child devices in
   [v0] because none of the chips connected to that bus are supported
   upstream. This node can be added later once anything attached to it
   has upstream drivers.

 - Dropped i2c_gpio. That bus was originally added for RAVE SP related
   prototyping and is unused in actual product.

 - Various newline fixes pointed out in [v0]

 - Most of then nodes should be sorted alphabetically (I might have
   missed some)

 - Collected Reviewed-by from Fabio (Fabio, I assumed you won't mind,
   but let me know if you want me to drop it)

[mezz] lkml.kernel.org/r/20180707024902.439-1-andrew.smirnov@gmail.com
[v0] lkml.kernel.org/r/1529603100-31958-3-git-send-email-andrey.gusakov@cogentembedded.com
[rave-sp-fixes] lkml.kernel.org/r/20180707024108.32373-1-andrew.smirnov@gmail.com

 arch/arm/boot/dts/Makefile               |   3 +-
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 459 +++++++++++++++++++++++
 2 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu3-esb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1d6acbab7062..bea41b129493 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -359,7 +359,8 @@ dtb-$(CONFIG_SOC_IMX51) += \
 	imx51-eukrea-mbimxsd51-baseboard.dtb \
 	imx51-ts4800.dtb \
 	imx51-zii-rdu1.dtb \
-	imx51-zii-scu2-mezz.dtb
+	imx51-zii-scu2-mezz.dtb \
+	imx51-zii-scu3-esb.dtb
 dtb-$(CONFIG_SOC_IMX53) += \
 	imx53-ard.dtb \
 	imx53-cx9020.dtb \
diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
new file mode 100644
index 000000000000..2941a92d40f1
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/*
+ * Copyright (C) 2018 Zodiac Inflight Innovations
+ */
+
+/dts-v1/;
+
+#include "imx51.dtsi"
+
+/ {
+	model = "ZII SCU3 ESB board";
+	compatible = "zii,imx51-scu3-esb", "fsl,imx51";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	/* Will be filled by the bootloader */
+	memory@90000000 {
+		reg = <0x90000000 0>;
+	};
+
+	usb_vbus: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_mmc_reset>;
+		gpio = <&gpio4 19 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <150000>;
+	};
+};
+
+&cpu {
+	cpu-supply = <&sw1_reg>;
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>,
+		   <&gpio4 25 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	pmic@0 {
+		compatible = "fsl,mc13892";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		spi-max-frequency = <6000000>;
+		spi-cs-high;
+		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,mc13xxx-uses-adc;
+
+		regulators {
+			sw1_reg: sw1 {
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1375000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3_reg: sw3 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vpll_reg: vpll {
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdig_reg: vdig {
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
+			};
+
+			vsd_reg: vsd {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3150000>;
+			};
+
+			vusb_reg: vusb {
+				regulator-always-on;
+			};
+
+			vusb2_reg: vusb2 {
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vvideo_reg: vvideo {
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+			};
+
+			vaudio_reg: vaudio {
+				regulator-min-microvolt = <2300000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			vcam_reg: vcam {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3150000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2900000>;
+				regulator-always-on;
+			};
+		};
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			led-control = <0x0 0x0 0x3f83f8 0x0>;
+
+			sysled3: led3@3 {
+				reg = <3>;
+				label = "system:red:power";
+				linux,default-trigger = "default-on";
+			};
+
+			sysled4: led4@4 {
+				reg = <4>;
+				label = "system:green:act";
+				linux,default-trigger = "heartbeat";
+			};
+		};
+	};
+
+	flash@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "atmel,at45", "atmel,dataflash";
+		spi-max-frequency = <25000000>;
+		reg = <1>;
+	};
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&esdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc4>;
+	bus-width = <4>;
+	no-1-8-v;
+	no-sdio;
+	cd-gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "mii";
+	status = "okay";
+
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+
+	fec_mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		switch@0 {
+			compatible = "marvell,mv88e6085";
+			reg = <0>;
+			dsa,member = <0 0>;
+			eeprom-length = <512>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "port1";
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "port2";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "port3";
+				};
+
+				port@3 {
+					reg = <3>;
+					label = "scu2scu";
+				};
+
+				port@4 {
+					reg = <4>;
+					label = "esb2host";
+				};
+
+				port@5 {
+					reg = <5>;
+					label = "esb2mezz";
+					phy-mode = "sgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					label = "cpu";
+					phy-mode = "mii";
+					ethernet = <&fec>;
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
+&ipu {
+	status = "disabled";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c04";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
+
+	lm75@48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+
+	rave-sp {
+		compatible = "zii,rave-sp-esb";
+		current-speed = <57600>;
+		#address-cells = <1>;
+		#size-cells = <1>;		
+
+		watchdog {
+			compatible = "zii,rave-sp-watchodg-legacy";
+		};
+
+		eeprom@a4 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa4 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "main-eeprom";
+		};		
+	};
+};
+
+&usbotg {
+	dr_mode = "host";
+	disable-over-current;
+	phy_type = "utmi_wide";
+	vbus-supply = <&usb_vbus>;
+	status = "okay";
+};
+
+&usbphy0 {
+	vcc-supply = <&vusb2_reg>;
+};
+
+&wdog1 {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
+			MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI	0x185
+			MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK	0x185
+			MX51_PAD_CSPI1_SS0__GPIO4_24		0x85
+			MX51_PAD_CSPI1_SS1__GPIO4_25		0x85
+		>;
+	};
+
+	pinctrl_esdhc1: esdhc1grp {
+		fsl,pins = <
+			MX51_PAD_SD1_CMD__SD1_CMD		0x400020d5
+			MX51_PAD_SD1_CLK__SD1_CLK		0x20d5
+			MX51_PAD_SD1_DATA0__SD1_DATA0		0x20d5
+			MX51_PAD_SD1_DATA1__SD1_DATA1		0x20d5
+			MX51_PAD_SD1_DATA2__SD1_DATA2		0x20d5
+			MX51_PAD_SD1_DATA3__SD1_DATA3		0x20d5
+			MX51_PAD_SD2_DATA0__SD1_DAT4		0x20d5
+			MX51_PAD_SD2_DATA1__SD1_DAT5		0x20d5
+			MX51_PAD_SD2_DATA2__SD1_DAT6		0x20d5
+			MX51_PAD_SD2_DATA3__SD1_DAT7		0x20d5
+		>;
+	};
+
+	pinctrl_esdhc4: esdhc4grp {
+		fsl,pins = <
+			MX51_PAD_NANDF_RB1__SD4_CMD		0x400020d5
+			MX51_PAD_NANDF_CS2__SD4_CLK		0x20d5
+			MX51_PAD_NANDF_CS3__SD4_DAT0		0x20d5
+			MX51_PAD_NANDF_CS4__SD4_DAT1		0x20d5
+			MX51_PAD_NANDF_CS5__SD4_DAT2		0x20d5
+			MX51_PAD_NANDF_CS6__SD4_DAT3		0x20d5
+			MX51_PAD_NANDF_D0__GPIO4_8		0x100
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX51_PAD_DISP2_DAT15__FEC_TDATA0	0x2004
+			MX51_PAD_DISP2_DAT6__FEC_TDATA1		0x2004
+			MX51_PAD_DISP2_DAT7__FEC_TDATA2		0x2004
+			MX51_PAD_DISP2_DAT8__FEC_TDATA3		0x2004
+			MX51_PAD_DISP2_DAT9__FEC_TX_EN		0x2004
+			MX51_PAD_DISP2_DAT10__FEC_COL		0x0180
+			MX51_PAD_DISP2_DAT11__FEC_RX_CLK	0x0180
+			MX51_PAD_DISP2_DAT12__FEC_RX_DV		0x20a4
+		
+			MX51_PAD_DISP2_DAT13__FEC_TX_CLK	0x2180
+			MX51_PAD_DISP2_DAT14__FEC_RDATA0	0x2180
+			MX51_PAD_DI2_DISP_CLK__FEC_RDATA1	0x0085
+			MX51_PAD_DI_GP4__FEC_RDATA2		0x0085
+			MX51_PAD_DISP2_DAT0__FEC_RDATA3		0x0085
+			MX51_PAD_DI2_PIN2__FEC_MDC		0x2004
+			MX51_PAD_DI2_PIN3__FEC_MDIO		0x01f5
+			MX51_PAD_DI2_PIN4__FEC_CRS		0x0180
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX51_PAD_KEY_COL4__I2C2_SCL		0x400001ed
+			MX51_PAD_KEY_COL5__I2C2_SDA		0x400001ed
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX51_PAD_GPIO1_4__GPIO1_4		0x85
+			MX51_PAD_GPIO1_8__GPIO1_8		0xe5
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
+			MX51_PAD_UART1_TXD__UART1_TXD		0x1c5
+			MX51_PAD_UART1_RTS__UART1_RTS		0x1c5
+			MX51_PAD_UART1_CTS__UART1_CTS		0x1c5
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX51_PAD_UART2_RXD__UART2_RXD		0x1c5
+			MX51_PAD_UART2_TXD__UART2_TXD		0x1c5
+			MX51_PAD_USBH1_DATA0__UART2_CTS		0x1c5
+			MX51_PAD_USBH1_DATA3__UART2_RTS		0x1c5
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX51_PAD_UART3_RXD__UART3_RXD		0x1c5
+			MX51_PAD_UART3_TXD__UART3_TXD		0x1c5
+		>;
+	};
+
+	pinctrl_usb_mmc_reset: usbmmcgrp {
+		fsl,pins = <
+			MX51_PAD_AUD3_BB_RXD__GPIO4_19		0x100
+		>;
+	};
+};
-- 
2.17.1

