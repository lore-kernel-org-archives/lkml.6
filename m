Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87784C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629FA20818
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBTHoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:44:17 -0500
Received: from mx.socionext.com ([202.248.49.38]:4138 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfBTHoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:44:17 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Feb 2019 16:44:15 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id B0E5E180097;
        Wed, 20 Feb 2019 16:44:15 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 20 Feb 2019 16:44:15 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 2185440368;
        Wed, 20 Feb 2019 16:44:15 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 0A80F120459;
        Wed, 20 Feb 2019 16:44:15 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v3 8/9] ARM: dts: milbeaut: Add device tree set for the Milbeaut M10V board
Date:   Wed, 20 Feb 2019 16:44:53 +0900
Message-Id: <1550648693-11382-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree for Milbeaut M10V SoC and M10V Evaluation board.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dts | 32 +++++++++++
 arch/arm/boot/dts/milbeaut-m10v.dtsi    | 95 +++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dts
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148..f697d87 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1233,6 +1233,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7623n-bananapi-bpi-r2.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
+dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
diff --git a/arch/arm/boot/dts/milbeaut-m10v-evb.dts b/arch/arm/boot/dts/milbeaut-m10v-evb.dts
new file mode 100644
index 0000000..614f60c
--- /dev/null
+++ b/arch/arm/boot/dts/milbeaut-m10v-evb.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Socionext Milbeaut M10V Evaluation Board */
+/dts-v1/;
+#include "milbeaut-m10v.dtsi"
+
+/ {
+	model = "Socionext M10V EVB";
+	compatible = "socionext,milbeaut-m10v-evb", "socionext,sc2000a";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		bootargs = "rootwait earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		uclk40xi: uclk40xi {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <40000000>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000  0x80000000>;
+	};
+
+};
diff --git a/arch/arm/boot/dts/milbeaut-m10v.dtsi b/arch/arm/boot/dts/milbeaut-m10v.dtsi
new file mode 100644
index 0000000..aa7c6ca
--- /dev/null
+++ b/arch/arm/boot/dts/milbeaut-m10v.dtsi
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "socionext,sc2000a";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "socionext,milbeaut-m10v-smp";
+		cpu@f00 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0xf00>;
+		};
+		cpu@f01 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0xf01>;
+		};
+		cpu@f02 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0xf02>;
+		};
+		cpu@f03 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0xf03>;
+		};
+	};
+
+	timer { /* The Generic Timer */
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			<GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			<GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			<GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		clock-frequency = <40000000>;
+		always-on;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&gic>;
+
+		gic: interrupt-controller@1d000000 {
+			compatible = "arm,cortex-a7-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x1d001000 0x1000>,
+			      <0x1d002000 0x1000>; /* CPU I/f base and size */
+		};
+
+		timer@1e000050 { /* 32-bit Reload Timers */
+			compatible = "socionext,milbeaut-timer";
+			reg = <0x1e000050 0x20>;
+			interrupts = <0 91 4>;
+		};
+
+		uart1: serial@1e700010 { /* PE4, PE5 */
+			/* Enable this as ttyUSI0 */
+			compatible = "socionext,milbeaut-usio-uart";
+			reg = <0x1e700010 0x10>;
+			interrupts = <0 141 0x4>, <0 149 0x4>;
+			interrupt-names = "rx", "tx";
+		};
+
+	};
+
+	sram@0 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0x10000>;
+		smp-sram@f100 {
+			compatible = "socionext,milbeaut-smp-sram";
+			reg = <0xf100 0x20>;
+		};
+	};
+};
-- 
1.9.1

