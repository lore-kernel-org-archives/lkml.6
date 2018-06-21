Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42BEC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AAF218E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="f+M7XyVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AAF218E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeFURmO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:42:14 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33383 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933135AbeFURl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:41:56 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so5555140lfy.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=meXxbVg7rFT4t/l1cDPoMRP0YBtP589ZpD9I66Rljm4=;
        b=f+M7XyVwcGEhiCaAnz0A2snji17atk5KOVdiJ0vyJZnzLiSC3/jJSuRh4qdKdd4XmF
         +UdO/Eg7booEbNOQCFyflNbNd5ze6OitnCn9S+rmaZPVo6f92vYfqYaCQ6XFKc8oEDGa
         X6xDNAKxHsWBWFORfLfqW4AUA+JoaCcqy/jtjWl/rdZKu4Dz7HP5K31qWyJ4Xpn5Fyck
         3Wk2ptQ2qcG1lsOT+NmW5fne2f62DRJSePv4hXwDDd3m0F6QcdyfTb+DCq346nFFGvvX
         oJfg8d7sdumBZ0v7pM0QX+o/bSUezNoMmo4uedaalhXXaytnSVfm8tO2lV+1CtXvU/gq
         6lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=meXxbVg7rFT4t/l1cDPoMRP0YBtP589ZpD9I66Rljm4=;
        b=l5BTZiBr8ATwHPXZisdbRJIpk+xMrQhKqCtaVm8kh9YUTYWGu4yBuDMSGt/MRrwQV9
         sHYc8B4ZaeVlKV5oeEJU3gyHjDiy9/U/8btE72dvF1BP/jb1xBEKw1OEeIYBW/sOacE3
         KH1+Y5tEpRyJkQQHKPbf8x8B0sO4l3QyWIYE0p3dq7ZeTOeNWwflL296erd9N6vjyK8e
         Tfn9fTzb3i0S4o/tXs/B/s9UtCxVrroVTBIj79YKbEr8wt0R3swBF6ZyodO8WMoaHD1U
         W3OhHscVQRYxHqbTeU9sM+AisVNPJgKGBh1+cNmM7H7Uc0XBb07RbM42tbUadYBqrp3n
         Yicw==
X-Gm-Message-State: APt69E01j4c391n0bGdi2suXpPdEObL2DNS21FC1ma/sG0V0XOsO0j02
        25gPxYPnXWVEXqwV/tymy2/tSw==
X-Google-Smtp-Source: ADUXVKKlU2QtQZPZk2H5Pgg0vY3DedYAAB+j5jFGBqrXwfYeVUjPRHKKxZETIS7gBuzPgiS7XNFN7g==
X-Received: by 2002:a19:910d:: with SMTP id t13-v6mr4378717lfd.94.1529602914802;
        Thu, 21 Jun 2018 10:41:54 -0700 (PDT)
Received: from localhost.localdomain (178-16-155-142.obit.ru. [178.16.155.142])
        by smtp.gmail.com with ESMTPSA id s5-v6sm951756ljj.93.2018.06.21.10.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:41:53 -0700 (PDT)
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
Subject: [PATCH 3/3] ARM: dts: imx: add ZII SCU2 Mezz board
Date:   Thu, 21 Jun 2018 20:45:00 +0300
Message-Id: <1529603100-31958-4-git-send-email-andrey.gusakov@cogentembedded.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
References: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Zodiac Inflight Innovations SCU2 Mezz
board, which is based on the i.MX51.

Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
---
 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts | 190 ++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d8900f4..e0dc187 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -359,7 +359,8 @@ dtb-$(CONFIG_SOC_IMX51) += \
 	imx51-eukrea-mbimxsd51-baseboard.dtb \
 	imx51-ts4800.dtb \
 	imx51-zii-rdu1.dtb \
-	imx51-zii-scu2-esb.dtb
+	imx51-zii-scu2-esb.dtb \
+	imx51-zii-scu2-mezz.dtb
 dtb-$(CONFIG_SOC_IMX53) += \
 	imx53-ard.dtb \
 	imx53-cx9020.dtb \
diff --git a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
new file mode 100644
index 0000000..f58572a
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2018 Zodiac Inflight Innovations
+
+/dts-v1/;
+#include "imx51-zii-common.dtsi"
+
+/ {
+	model = "ZII SCU2 Mezz Board";
+	compatible = "zii,imx51-scu2-mezz", "fsl,imx51";
+
+	aliases {
+		mdio-gpio0 = &mdio_gpio;
+	};
+
+	mdio_gpio: mdio-gpio {
+		compatible = "virtual,mdio-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_swmdio>;
+		gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>, /* mdc */
+			<&gpio2 6 GPIO_ACTIVE_HIGH>; /* mdio */
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch@0 {
+			compatible = "marvell,mv88e6085";
+			reg = <0>;
+			dsa,member = <0 0>;
+			eeprom-length = <512>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "port4";
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "port5";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "port6";
+				};
+
+				port@3 {
+					reg = <3>;
+					label = "port7";
+				};
+
+				port@4 {
+					reg = <4>;
+					label = "cpu";
+					ethernet = <&fec>;
+
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					label = "mezz2esb";
+					phy-mode = "sgmii";
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
+	};
+};
+
+&usb_vbus {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_mmc_reset>;
+	gpio = <&gpio3 13 GPIO_ACTIVE_LOW>;
+	startup-delay-us = <150000>;
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_4bit &pinctrl_esdhc1_8bit>;
+	bus-width = <8>;
+};
+
+&fec {
+	phy-reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <1>;
+	phy-supply = <&vgen3_reg>;
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@0 {
+			reg = <0>;
+			max-speed = <100>;
+		};
+	};
+};
+
+
+&i2c_gpio {
+	gpios = <&gpio3 2 GPIO_ACTIVE_HIGH>, /* sda */
+		<&gpio3 1 GPIO_ACTIVE_HIGH>; /* scl */
+};
+
+&uart2 {
+	status = "disabled";
+};
+
+&vsd_reg {
+	regulator-always-on;
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
+			MX51_PAD_DISP2_DAT1__FEC_RX_ER		0x20a4
+			MX51_PAD_DISP2_DAT13__FEC_TX_CLK	0x2180
+			MX51_PAD_DI_GP3__FEC_TX_ER		0x2004
+			MX51_PAD_DISP2_DAT14__FEC_RDATA0	0x2180
+			MX51_PAD_DI2_DISP_CLK__FEC_RDATA1	0x0085
+			MX51_PAD_DI_GP4__FEC_RDATA2		0x0085
+			MX51_PAD_DISP2_DAT0__FEC_RDATA3		0x0085
+			MX51_PAD_DI2_PIN2__FEC_MDC		0x2004
+			MX51_PAD_DI2_PIN3__FEC_MDIO		0x01f5
+			MX51_PAD_DI2_PIN4__FEC_CRS		0x0180
+			MX51_PAD_EIM_A20__GPIO2_14		0x0085
+			MX51_PAD_EIM_A21__GPIO2_15		0x00e5
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
+			MX51_PAD_UART1_TXD__UART1_TXD		0x1c5
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
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
+			MX51_PAD_CSI1_D9__GPIO3_13		0x85
+		>;
+	};
+
+	pinctrl_swmdio: swmdiogrp {
+		fsl,pins = <
+			MX51_PAD_EIM_D22__GPIO2_6		0x100
+			MX51_PAD_EIM_D23__GPIO2_7		0x100
+		>;
+	};
+
+	pinctrl_swi2c: swi2cgrp {
+		fsl,pins = <
+			MX51_PAD_DI1_PIN12__GPIO3_1		0x100
+			MX51_PAD_DI1_PIN13__GPIO3_2		0x100
+		>;
+	};
+};
-- 
1.9.1

