Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C22BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224C2204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224C2204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeLNJKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:10:31 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:34099 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbeLNJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:10:29 -0500
X-IronPort-AV: E=Sophos;i="5.56,352,1539615600"; 
   d="scan'208";a="2629705"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2018 18:10:27 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.37.69])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 041D74023AB3;
        Fri, 14 Dec 2018 18:10:24 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 1/9] arm64: dts: renesas: Initial device tree for r8a774c0
Date:   Fri, 14 Dec 2018 09:10:05 +0000
Message-Id: <1544778613-24279-2-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basic support for the RZ/G2E SoC (a.k.a. r8a774c0).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 186 ++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
new file mode 100644
index 0000000..f425d0b
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the RZ/G2E (R8A774C0) SoC
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/r8a774c0-sysc.h>
+
+/ {
+	compatible = "renesas,r8a774c0";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	/*
+	 * The external audio clocks are configured as 0 Hz fixed frequency
+	 * clocks by default.
+	 * Boards that provide audio clocks should override them.
+	 */
+	audio_clk_a: audio_clk_a {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_b: audio_clk_b {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_c: audio_clk_c {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 1 core only at this point */
+		a53_0: cpu@0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A774C0_PD_CA53_CPU0>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		L2_CA53: cache-controller-0 {
+			compatible = "cache";
+			power-domains = <&sysc R8A774C0_PD_CA53_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	/* External PCIe clock - can be overridden by the board */
+	pcie_bus_clk: pcie_bus {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a53_0>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cpg: clock-controller@e6150000 {
+			compatible = "renesas,r8a774c0-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>;
+			clock-names = "extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		rst: reset-controller@e6160000 {
+			compatible = "renesas,r8a774c0-rst";
+			reg = <0 0xe6160000 0 0x0200>;
+		};
+
+		sysc: system-controller@e6180000 {
+			compatible = "renesas,r8a774c0-sysc";
+			reg = <0 0xe6180000 0 0x0400>;
+			#power-domain-cells = <1>;
+		};
+
+		scif2: serial@e6e88000 {
+			compatible = "renesas,scif-r8a774c0",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 310>,
+				 <&cpg CPG_CORE R8A774C0_CLK_S3D1C>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 310>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@f1010000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xf1010000 0 0x1000>,
+			      <0x0 0xf1020000 0 0x20000>,
+			      <0x0 0xf1040000 0 0x20000>,
+			      <0x0 0xf1060000 0 0x20000>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
+		};
+
+		prr: chipid@fff00044 {
+			compatible = "renesas,prr";
+			reg = <0 0xfff00044 0 4>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	/* External USB clocks - can be overridden by the board */
+	usb3s0_clk: usb3s0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	usb_extal_clk: usb_extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+};
-- 
2.7.4

