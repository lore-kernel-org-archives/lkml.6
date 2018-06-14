Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67F0CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274D7208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274D7208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964881AbeFNLCv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:02:51 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:20798 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964851AbeFNLCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:02:50 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 14 Jun 2018 20:02:46 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id B8C6C63FC2;
        Thu, 14 Jun 2018 20:02:46 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,222,1526310000"; 
   d="scan'208";a="282525626"
Received: from unknown (HELO be1yocto.ree.adwin.renesas.com) ([172.29.43.62])
  by relmlii1.idc.renesas.com with ESMTP; 14 Jun 2018 20:02:43 +0900
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/5] ARM: dts: Renesas R9A06G032 base device tree file
Date:   Thu, 14 Jun 2018 11:56:32 +0100
Message-Id: <1528973829-25493-4-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Renesas R9A06G032 bare bone support.

This currently only handles the SYSCTRL block note,
generic parts (gic, architected timer) and a UART.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 114 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/r9a06g032.dtsi

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
new file mode 100644
index 0000000..353e06f
--- /dev/null
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base Device Tree Source for the Renesas RZ/N1D (R9A06G032)
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r9a06g032-sysctrl.h>
+
+/ {
+	compatible = "renesas,r9a06g032";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			clocks = <&sysctrl R9A06G032_CLK_A7MP>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			clocks = <&sysctrl R9A06G032_CLK_A7MP>;
+		};
+	};
+
+	ext_jtag_clk: extjtagclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	ext_mclk: extmclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+	};
+
+	ext_rgmii_ref: extrgmiiref {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	ext_rtc_clk: extrtcclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupt-parent = <&gic>;
+		ranges;
+
+		sysctrl: system-controller@4000c000 {
+			compatible = "renesas,r9a06g032-sysctrl";
+			reg = <0x4000c000 0x1000>;
+			status = "okay";
+			#clock-cells = <1>;
+
+			clocks = <&ext_mclk>, <&ext_rtc_clk>,
+					<&ext_jtag_clk>, <&ext_rgmii_ref>;
+			clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
+		};
+
+		uart0: serial@40060000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x40060000 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&sysctrl R9A06G032_CLK_UART0>;
+			clock-names = "baudclk";
+			status = "disabled";
+		};
+
+		gic: gic@44101000 {
+			compatible = "arm,cortex-a7-gic", "arm,gic-400";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x44101000 0x1000>, /* Distributer */
+			      <0x44102000 0x2000>, /* CPU interface */
+			      <0x44104000 0x2000>, /* Virt interface control */
+			      <0x44106000 0x2000>; /* Virt CPU interface */
+			interrupts =
+				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+
+	timer {
+		compatible = "arm,cortex-a7-timer",
+			     "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		arm,cpu-registers-not-fw-configured;
+		always-on;
+		interrupts =
+			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
-- 
2.7.4

