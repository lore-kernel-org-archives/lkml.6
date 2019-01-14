Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0084C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA4420873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wb1K3ojJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfANKVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41168 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfANKVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so10145930pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ySRluh8UnQNx0w0kOBma0DodxOKHroSYUhNhVj/8Uo=;
        b=Wb1K3ojJ9WYDw5IY72tUVaBYTEMiIkllvaeXLbjWrD0awjhnlymmOz78d1twh1VRej
         q98292ySiZa4HFm1KDcBpfS51UIR8EqCWP3s4U2fsXYE4HpDyfJb+D9AZfhDkIgm2Bnq
         I0bLkoEYseF1uAjrnRMdWN8nxGiAvrU2LMRXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ySRluh8UnQNx0w0kOBma0DodxOKHroSYUhNhVj/8Uo=;
        b=Siqf3vn8SX0qbGIq2ciUgSbWPwabTqZIrO2KoudNNg+pYj4jibNWlyDJMQF6iHw4C0
         /sOoNaDCvbPVzIfR38noX7nKDLAsjQpn/v5UuGR1+1simwgt0DLbaKYSSlYvAzfYIu/c
         GA+ClQtMA4DBH73fmx4VBE6L90RJ78XStgjBSw4zjcr7Re6rme1W5GWYaIAK5A1nazRL
         /LaX1J9KjDrBDITX5+qnGkFo/aJ3nImPO4Eakdw1dXgOuAU4nSEwrIC8fB9QeUNAx1pO
         K10iKdm/plNYFWgJf6gXqq9My8lYeWGN+RTikwog55NpfZ9N5cnRziX+itETnCr34hmk
         5iNQ==
X-Gm-Message-State: AJcUukfwODozJ5IHpEf2878MPgaLBO2a1xVbXlk2hyzgWiSRRJ+gHRbu
        wSPW+AqYEqhk/xQBmTtP2E+W
X-Google-Smtp-Source: ALg8bN7Q/Gzeiu84Y9s0Sq+NX0l3zeR8XI82rdejLcqZl7gExEX60Z+D2M/jufxy8H6U4FFRLi3q/A==
X-Received: by 2002:a63:fb4c:: with SMTP id w12mr12202724pgj.321.1547461282130;
        Mon, 14 Jan 2019 02:21:22 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
        by smtp.gmail.com with ESMTPSA id 15sm36429pfr.55.2019.01.14.02.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 02:21:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: freescale: Add devicetree for Oxalis
Date:   Mon, 14 Jan 2019 15:50:53 +0530
Message-Id: <20190114102053.16013-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
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

