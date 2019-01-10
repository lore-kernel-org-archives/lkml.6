Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368F0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05937206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yy3ZX90W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfAJIIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:08:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33937 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfAJIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:08:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so4864333plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 00:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SRHhc+5Wq5F+eOh1TPssYo4IwZz8sRcNierx3amv9Og=;
        b=Yy3ZX90Ww1M0ZpN7QdbvokfQemmR4c9FNcWuHaCR/YrkQ/U6SPJUmQujSqzyTCYeM6
         o2KbANzkrjSut0WmrqXq+GAMXSM+8Ry2dBPoKbdFTMh11Gm6I4fFfuQkzYVfVb2esQMz
         GjpNqhiDaAE7GED3jXPeQwN9c/163hIW+dlTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SRHhc+5Wq5F+eOh1TPssYo4IwZz8sRcNierx3amv9Og=;
        b=q5+Sn0CvNU1rl58VV6xiQ+mGFCILM9QsjTGkg81fvH4RPx4EfKkJLZbzovgfMLtAeK
         Vasf58F5Y7ky1OczSRTwXdTVkpVaLMoCeugAIFcnK6J8sbsntctrD3huvp3knXbCSR4g
         XmZZNQ54x1Fee7gbgHU38bDc9O1jgQu/aRSZEvHzVnfCWpzro6I+bz48M5OPmI9Vo2EL
         yG3mZNkELJOLz1nBDpgKYrUx30+fxWHWH4OhxLtfKfcMfbMr3wjLAq/MEk3EWa18LWaF
         CeUlivdLHHJRR+nqnUdwmsuOEzQWNBEinU3AWVzG3zR4yeC4FqAOaMvTya+1lI4VnEVU
         Nb7Q==
X-Gm-Message-State: AJcUukeVmRR1j8oKVFIMydzW3ZEWqEEk051zS3xKDLKIyPZ7dtBa5e7V
        qdGsC9DVMM9AUg0l+LA7xlcS
X-Google-Smtp-Source: ALg8bN6cLJRgM4qAh5AwNuIpD+CeVY8ee9j+gvKhTKao57whpRwb80m2GLXtvaxLymXOnpPTlLvgRQ==
X-Received: by 2002:a17:902:d911:: with SMTP id c17mr9619883plz.151.1547107731095;
        Thu, 10 Jan 2019 00:08:51 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:89d:654d:749c:afde:a8a6:224d])
        by smtp.gmail.com with ESMTPSA id w23sm27401007pgc.72.2019.01.10.00.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 00:08:50 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] arm64: dts: freescale: Add devicetree for Oxalis
Date:   Thu, 10 Jan 2019 13:38:21 +0530
Message-Id: <20190110080821.30280-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
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
index 000000000000..760a3e258c96
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
+	codec: sgtl5000@a {
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

