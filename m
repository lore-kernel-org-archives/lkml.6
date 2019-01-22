Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A9C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F42820855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4qG3Pxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfAVEW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:22:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfAVEW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:22:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so11096817pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 20:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ySRluh8UnQNx0w0kOBma0DodxOKHroSYUhNhVj/8Uo=;
        b=H4qG3Pxw3GuM2FQUpr/htirtCGys1NP2JsDeCvOWzLVz+I6R9/rPIxERk4WNst9jwe
         iV0F83gw40ucBCcQgLmJ4DhK092gHV0uOiwELilHJ6unHFV9Ozbs0Qhv7r/9OXx2Ifyb
         nlmHCmBCSf4Z7k1ofT7AvE/KC2Xgh4e6X9+DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ySRluh8UnQNx0w0kOBma0DodxOKHroSYUhNhVj/8Uo=;
        b=ISAsBvj5utVR3FaucCL22l9BdMQmvYKkzd5GIMOtoEQ1QIlIsRNDh8x6tDliehRuc3
         S9Ol7pQkD0mpL0egcTgqv94dIURnGtP2mk+B010mBEO5KSX63bZa4koDNkLKJL4eufid
         Rfov+ISN70ssbJeTRepwlJo2RFSqauN4j+27h06+Z2s2JGAT+f7PYtcaCwyYgPQnBhac
         3cPHj+0ujqeHwqy4JR9fctKWAOCY6BX5/c/9Zrgz2oWU+5h6a1qDwm0lunN22Jr+xEJs
         0sozmQg0vomIVbL5rtn6OIUz+1ec3F3b4k0bjWUqgnk6ZlVoX93EEnCJc/CT1udyYzlM
         fT5Q==
X-Gm-Message-State: AJcUukfFbtPEFotBL2pa7a6asbm1qoJR7IXeGa4t/KIKaYcrTW+qIos6
        h+uuHDM1rGmBGvA0szMLzl2R
X-Google-Smtp-Source: ALg8bN5DUBDakDdApjwY/HUFxu0GgUpUbp7wc+TBJsHYoE3I9AVtjQyDPpL0QC6/rKdRbXzLvM9owA==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr31548723pfu.3.1548130946623;
        Mon, 21 Jan 2019 20:22:26 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
        by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 20:22:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/5] arm64: dts: freescale: Add devicetree for Oxalis
Date:   Tue, 22 Jan 2019 09:51:47 +0530
Message-Id: <20190122042147.5424-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for Oxalis SoM board from EBS-SYSTART. This
board is one of the 96Boards Enterprise Edition platform. Below are some
of the key features of this board:

* SoC: NXP Layerscape LS1012A
* RAM: 1GB DDR3L
* PMU: NXP VR5100
* Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
* Connectivity: 2x Ethernet
* USB: 2x USB3.0

More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/oxalis/

Ethernet and SPI flash are not supported yet!

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index f9be2426f83c..d8152cc06b3f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frwy.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-oxalis.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
new file mode 100644
index 000000000000..7c726267ec8f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Oxalis
+ *
+ * Copyright (c) 2019 Manivannan Sadhasivam
+ *
+ */
+
+/dts-v1/;
+
+#include "fsl-ls1012a.dtsi"
+
+/ {
+	model = "Oxalis";
+	compatible = "ebs-systart,oxalis", "fsl,ls1012a";
+
+	sys_mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker Ext",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+			frame-master;
+			bitclock-master;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+			frame-master;
+			bitclock-master;
+			system-clock-frequency = <25000000>;
+		};
+	};
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	codec: audio-codec@a {
+		#sound-dai-cells = <0>;
+		compatible = "fsl,sgtl5000";
+		reg = <0xa>;
+		VDDA-supply = <&reg_1p8v>;
+		VDDIO-supply = <&reg_1p8v>;
+		clocks = <&sys_mclk>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&sai2 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
-- 
2.17.1

