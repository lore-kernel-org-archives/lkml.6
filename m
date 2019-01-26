Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E03C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175C0218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lraksk99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfAZELU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 23:11:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37450 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbfAZELU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 23:11:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so5012798pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 20:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6n/1pZVNoLogyX+K/gR163sI6cwrL7Mu1c32gRBtLNk=;
        b=Lraksk99Qc/bC8ojQxeOsDr8dDsOFF+pmDXRQUpvi12Kr9E6bWep1TFsPLaWPqhx9s
         ivZL7SjJWV5VdhtUO7vMvFO9Vi29dYJD6pe3xG32YMUrVAYt8NQ/jzmTqezEdRc5dJtP
         puGEn7GNNh45dQMYt1hk71cj1+VGU0Ky+tbBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6n/1pZVNoLogyX+K/gR163sI6cwrL7Mu1c32gRBtLNk=;
        b=Pn2VndAIMZdPFfVGSE3Q8gz5qDytE04ZrJj6D1a9TwEyXAgxzBOP6yGW+8A2KtHgDA
         ZIilO0CHqKsm41Wo7GvAOmi3RbPMpzdsFV2GO2atPlPlfh0788k7mlD2d8tHC1L3vJz3
         8FWAinL/t+lHNAVDTTC7bRsptQ0k7ECUJlkEt+981TZsoMPoUS/T8DAbrkkaTnuzRUXc
         w9UrB6XUllm3q0yd1KaBloO8BegL1TwUpFJqlc9eHuUe98ddoJC3Jz/6rKhvASt+p4cB
         546K9fo5M8Xkcral0H5VCLNrPlcSR8+wK5OZ5sLz+gggy8k3Zw1w4YIkzchNU0zk9Lt7
         sRvA==
X-Gm-Message-State: AJcUukcodTdujoIsKZoLPiuPlRpSw/A2xVGCimEtxJITn4SSgMLuAw3c
        htq4kdC4vBNbwZ6SDix1iQ9owEdelA==
X-Google-Smtp-Source: ALg8bN5cwSYVgL/82NOA6+KtHdjnHiUFUCZBeId1ZrqYuzrssOF4FZUYzIvzwWyxOAj0iOdZNKMyiw==
X-Received: by 2002:a63:f615:: with SMTP id m21mr12605200pgh.428.1548475879189;
        Fri, 25 Jan 2019 20:11:19 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
        by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 20:11:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] arm64: dts: bitmain: Add BM1880 SoC support
Date:   Sat, 26 Jan 2019 09:40:39 +0530
Message-Id: <20190126041041.13173-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for Bitmain BM1880 SoC, consisting of a Dual
core ARM Cortex A53 subsystem, a Single core RISC-V subsystem and a Tensor
Processor subsystem. Only ARM Cortex A53 Application processor subsystem
support is enabled for now.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/Makefile            |   1 +
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 119 ++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 4690364d584b..5bc7533a12c7 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -7,6 +7,7 @@ subdir-y += amd
 subdir-y += amlogic
 subdir-y += apm
 subdir-y += arm
+subdir-y += bitmain
 subdir-y += broadcom
 subdir-y += cavium
 subdir-y += exynos
diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
new file mode 100644
index 000000000000..55a4769e0de2
--- /dev/null
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "bitmain,bm1880";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secmon@100000000 {
+			reg = <0x1 0x00000000 0x0 0x20000>;
+			no-map;
+		};
+
+		jpu@130000000 {
+			reg = <0x1 0x30000000 0x0 0x08000000>; // 128M
+			no-map;
+		};
+
+		vpu@138000000 {
+			reg = <0x1 0x38000000 0x0 0x08000000>; // 128M
+			no-map;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@50001000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0x50001000 0x0 0x1000>,
+			      <0x0 0x50002000 0x0 0x2000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		uart0: serial@58018000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x58018000 0x0 0x2000>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial@5801A000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x5801a000 0x0 0x2000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart2: serial@5801C000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x5801c000 0x0 0x2000>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@5801E000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x5801e000 0x0 0x2000>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.17.1

