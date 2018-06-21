Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5DEC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550DE218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="cVRLeD3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550DE218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933237AbeFURl6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:41:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33376 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933100AbeFURlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:41:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id y20-v6so5555044lfy.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o7rvTvJkEFwNcbTIOX+TXLPR+qt6ft12pmtEuy+Z4BQ=;
        b=cVRLeD3EWtoT1aZCRBEdCNaDyJXuG6KO4Xsrb8r/c4uGcJVyxMJ7OO6iq3aKAUi4co
         BvTWEJ4IyUfXIQP755/hgiAl9AZdBJVZJMpDNYz9XQx/KBfta21Ofg36s0jRjxqo8ZA5
         UDw7WUf8xsN5SMf3SFdSuD6XkXyGrNwpPToL05bQC0mcNPFyko52RjRbeZlES307Ze3n
         tAczVq7ReUH5rOZ4WvKSMMFc5VqoBgN1J0nufScEHHoqbbEEVRWXl0dZNgAHGM9Hj8th
         8saEFVZkypOFHR7VZ/xOx0Ik/O3cdkkhvj09fBHhA0FaVseoIaCz+lG+nJCP3aPiXkjd
         HSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o7rvTvJkEFwNcbTIOX+TXLPR+qt6ft12pmtEuy+Z4BQ=;
        b=bgG1MByZ9wR9Ntc64lUF+Z6rZXvMEsIShtEHbes2Hs+H/iwNPKx1oBpZY+VHDLuA87
         GW97x28bb10MaRJQencuayhZyHSZkjuSnoRRa3oDQbpsArI/WTVqQkj7IVR4KD29aUip
         oJ2ikluQvTeAkbqd8DjQzNTRSH0AFk0zIcDbhw/fY6zU2WZMdACR7rx7gd2ebSgA81QL
         LFcpdPB3Dfr5ikOgvP0IbpwSw2bjjSlULxS7gOkBo49OYwm6tiVBb9iLZ7hyyimzjY/w
         E8sJlKGp+hWjbCkL6evuOzLoriVWmyIV+5P2WmKGxUf0QruKhxRLYDkw9hjRm9/aTEX0
         fqiQ==
X-Gm-Message-State: APt69E15Aa2A71cVEvJrUxAM8BZ6JS8Pt/2LGJa7mLZRcN5hwX4zo/hI
        ZllCbIZdJxFnlKeoi1TlzQV/IA==
X-Google-Smtp-Source: ADUXVKKg0C9RViBbYF1cpBBExBhi/MyaWLAGbAwD8GN0yPx2Mz2HXOGg/2WIZwkoONYaUK7vnOIWmQ==
X-Received: by 2002:a19:d744:: with SMTP id o65-v6mr15989964lfg.124.1529602913464;
        Thu, 21 Jun 2018 10:41:53 -0700 (PDT)
Received: from localhost.localdomain (178-16-155-142.obit.ru. [178.16.155.142])
        by smtp.gmail.com with ESMTPSA id s5-v6sm951756ljj.93.2018.06.21.10.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:41:52 -0700 (PDT)
From:   Andrey Gusakov <andrey.gusakov@cogentembedded.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, cphealy@gmail.com,
        andrew.smirnov@gmail.com, l.stach@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrey.gusakov@cogentembedded.com
Subject: [PATCH 2/3] ARM: dts: imx: add ZII SCU2 ESB board
Date:   Thu, 21 Jun 2018 20:44:59 +0300
Message-Id: <1529603100-31958-3-git-send-email-andrey.gusakov@cogentembedded.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
References: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Zodiac Inflight Innovations SCU2 Ethernet
Switch Board, which is based on the i.MX51.

Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
---
 arch/arm/boot/dts/Makefile               |   3 +-
 arch/arm/boot/dts/imx51-zii-scu2-esb.dts | 178 +++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-esb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de7..d8900f4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -358,7 +358,8 @@ dtb-$(CONFIG_SOC_IMX51) += \
 	imx51-digi-connectcore-jsk.dtb \
 	imx51-eukrea-mbimxsd51-baseboard.dtb \
 	imx51-ts4800.dtb \
-	imx51-zii-rdu1.dtb
+	imx51-zii-rdu1.dtb \
+	imx51-zii-scu2-esb.dtb
 dtb-$(CONFIG_SOC_IMX53) += \
 	imx53-ard.dtb \
 	imx53-cx9020.dtb \
diff --git a/arch/arm/boot/dts/imx51-zii-scu2-esb.dts b/arch/arm/boot/dts/imx51-zii-scu2-esb.dts
new file mode 100644
index 0000000..e052133
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-zii-scu2-esb.dts
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2018 Zodiac Inflight Innovations
+
+/dts-v1/;
+#include "imx51-zii-common.dtsi"
+
+/ {
+	model = "ZII SCU2 ESB board";
+	compatible = "zii,imx51-scu2-esb", "fsl,imx51";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_4bit &pinctrl_esdhc1_8bit>;
+	bus-width = <8>;
+};
+
+&fec {
+	phy-reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
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
+&i2c2 {
+	lm75@48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+};
+
+&i2c_gpio {
+	gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>, /* sda */
+		<&gpio3 0 GPIO_ACTIVE_HIGH>; /* scl */
+};
+
+&ipu {
+	status = "disabled";
+};
+
+&usb_vbus {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_mmc_reset>;
+	gpio = <&gpio4 19 GPIO_ACTIVE_LOW>;
+	startup-delay-us = <150000>;
+};
+
+&iomuxc {
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
+			MX51_PAD_DISP2_DAT13__FEC_TX_CLK	0x2180
+			MX51_PAD_DISP2_DAT14__FEC_RDATA0	0x2180
+			MX51_PAD_DI2_DISP_CLK__FEC_RDATA1	0x0085
+			MX51_PAD_DI_GP4__FEC_RDATA2		0x0085
+			MX51_PAD_DISP2_DAT0__FEC_RDATA3		0x0085
+			MX51_PAD_DI2_PIN2__FEC_MDC		0x2004
+			MX51_PAD_DI2_PIN3__FEC_MDIO		0x01f5
+			MX51_PAD_DI2_PIN4__FEC_CRS		0x0180
+			MX51_PAD_AUD3_BB_FS__GPIO4_21		0x0000
+		>;
+	};
+
+	pinctrl_swi2c: swi2cgrp {
+		fsl,pins = <
+			MX51_PAD_DI1_PIN11__GPIO3_0		0x100
+			MX51_PAD_DI1_PIN12__GPIO3_1		0x100
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
1.9.1

