Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F9EC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426C02086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdEfYyXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfASVSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 16:18:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37268 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfASVSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 16:18:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so7507743wmd.2;
        Sat, 19 Jan 2019 13:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EcXNpdimy0F9xsPDYLjaUasTNqD0XXtOzr8O0QQSlgQ=;
        b=IdEfYyXapNkjimfQkDICQcO6Fm6aC8jBBTFH6aZlKU96yr0MH790LF21psju+LcLh9
         f/oJKtPmtvrNSwkfLUSe/ujalVO27O4JpvyhnmSW0gAL/1/KFmExDuL5o3U408MwbuDy
         5zTjqkuNCHTIW9pcAEr9PkUMZRPq2aaM5jTrNZrhbojTuCW8jUojGc85wXVrMeIRwXbV
         9ZoG902LGlzDvg5JcWa1RVIJf8NXjfsOvnx6evVF11zyBN8cuzrREQ9vFUQD8i3oO6bU
         kLAb3xMbbHftO1jehT17ysyyK/lOCVJdYtGDed2y0iPGQB9Pfakwn9YwbYGYb2JVs8GS
         8ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EcXNpdimy0F9xsPDYLjaUasTNqD0XXtOzr8O0QQSlgQ=;
        b=PSkwF3koTpDN9QJkd6p5VfxByrsFrW+7QevHcx/whEPfTHPaKz2ZvAQR0R/XUYZciU
         saNmOF3FC2C2lB8S2Ew4sdO4/Bn2QUhEjhVntYjlIxVeKX8aYEGHoCIbxDeaCmfM/FQj
         TjWn5dkFupAR/kMG82nzpvh896YaOduxglJFdXPllmjOtgygd8sturhIUdTawGVbE/ER
         NvXO1QF7cs6yTzO+FQ/cEa/jVTCFdRzrUE8vOPAalZ/obvaqkk2VLo03vZ3Jw5kMwRbi
         TJYEDKQq92NcVKeW1Y/iJ7j+QXfRB1KKjtMFN2ly53F7Uon0SOL0jQYDN+GEvfwDp2me
         RO+g==
X-Gm-Message-State: AJcUukeb5VMNyaL8RBXPwXLO8xG9YQK6MpsTufPwI0Yzt3imD2Ai3/NX
        KpFaBguJbwXJMSN3WVcwueLNrg8t
X-Google-Smtp-Source: ALg8bN7h/K2L9PPkiGbjiQ7AYo+5JdIB6Y7t7tznfLo112/r+AldBNb2kQbauXGSo22otdgMr4nMAQ==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr2808944wmf.8.1547932713390;
        Sat, 19 Jan 2019 13:18:33 -0800 (PST)
Received: from mappy.world.mentorg.com (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id v6sm55737019wrd.88.2019.01.19.13.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 13:18:32 -0800 (PST)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ARM: dts: imx53-smd: Add OV5642 video capture support
Date:   Sat, 19 Jan 2019 13:18:15 -0800
Message-Id: <20190119211815.25101-3-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119211815.25101-1-slongerbeam@gmail.com>
References: <20190119211815.25101-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add video capture support from the OV5642 to IPU CSI0 on
the i.MX53 SMD.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 arch/arm/boot/dts/imx53-smd.dts | 75 +++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 09071ca11c6c..2d6fc07629e6 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -185,6 +185,31 @@
 			>;
 		};
 
+		pinctrl_ipu_csi0: ipucsi0grp {
+			fsl,pins = <
+				MX53_PAD_CSI0_DAT12__IPU_CSI0_D_12    0x1c4
+				MX53_PAD_CSI0_DAT13__IPU_CSI0_D_13    0x1c4
+				MX53_PAD_CSI0_DAT14__IPU_CSI0_D_14    0x1c4
+				MX53_PAD_CSI0_DAT15__IPU_CSI0_D_15    0x1c4
+				MX53_PAD_CSI0_DAT16__IPU_CSI0_D_16    0x1c4
+				MX53_PAD_CSI0_DAT17__IPU_CSI0_D_17    0x1c4
+				MX53_PAD_CSI0_DAT18__IPU_CSI0_D_18    0x1c4
+				MX53_PAD_CSI0_DAT19__IPU_CSI0_D_19    0x1c4
+				MX53_PAD_CSI0_PIXCLK__IPU_CSI0_PIXCLK 0x1e4
+				MX53_PAD_CSI0_VSYNC__IPU_CSI0_VSYNC   0x1e4
+				MX53_PAD_CSI0_MCLK__IPU_CSI0_HSYNC    0x1e4
+				MX53_PAD_CSI0_DATA_EN__IPU_CSI0_DATA_EN 0x1e4
+			>;
+		};
+
+		pinctrl_ov5642: ov5642grp {
+			fsl,pins = <
+				MX53_PAD_NANDF_WP_B__GPIO6_9   0x1e4
+				MX53_PAD_NANDF_RB0__GPIO6_10   0x1e4
+				MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK 0x1c4
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX53_PAD_CSI0_DAT10__UART1_TXD_MUX	0x1e4
@@ -256,11 +281,49 @@
 	camera: ov5642@3c {
 		compatible = "ovti,ov5642";
 		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5642>;
+		assigned-clocks = <&clks IMX5_CLK_SSI_EXT1_SEL>,
+				  <&clks IMX5_CLK_SSI_EXT1_COM_SEL>;
+		assigned-clock-parents = <&clks IMX5_CLK_PLL2_SW>,
+					 <&clks IMX5_CLK_SSI_EXT1_PODF>;
+		assigned-clock-rates = <0>, <24000000>;
+		clocks = <&clks IMX5_CLK_SSI_EXT1_GATE>;
+		clock-names = "xclk";
+		DVDD-supply = <&ldo9_reg>;
+		AVDD-supply = <&ldo7_reg>;
+		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>;
+		powerdown-gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>;
+
+		port {
+			ov5642_to_ipu_csi0: endpoint {
+				remote-endpoint = <&ipu_csi0_from_parallel_sensor>;
+				bus-width = <8>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+		};
 	};
 
 	pmic: dialog@48 {
 		compatible = "dlg,da9053", "dlg,da9052";
 		reg = <0x48>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* low-level active IRQ at GPIO7_11 */
+
+		regulators {
+			ldo7_reg: ldo7 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-always-on;
+			};
+
+			ldo9_reg: ldo9 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3650000>;
+				regulator-always-on;
+			};
+		};
 	};
 };
 
@@ -271,3 +334,15 @@
 	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&ipu_csi0_from_parallel_sensor {
+	remote-endpoint = <&ov5642_to_ipu_csi0>;
+	data-shift = <12>; /* Lines 19:12 used */
+	hsync-active = <1>;
+	vsync-active = <1>;
+};
+
+&ipu_csi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ipu_csi0>;
+};
-- 
2.17.1

