Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992FBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5078F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5078F208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeGaHSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:18:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27669 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728226AbeGaHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:18:00 -0400
X-UUID: 9030fd8deb3b4d57901d093b333bc522-20180731
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1425248869; Tue, 31 Jul 2018 13:39:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 31 Jul 2018 13:39:24 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 31 Jul 2018 13:39:24 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>,
        <linux-clk@vger.kernel.org>, Ben Ho <Ben.Ho@mediatek.com>
Subject: [PATCH v4 03/10] arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and Makefile
Date:   Tue, 31 Jul 2018 13:38:00 +0800
Message-ID: <1533015487-60189-4-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Ho <Ben.Ho@mediatek.com>

Add basic chip support for Mediatek 8183

Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  23 +++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 146 ++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 7506b0d..a91d462 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
new file mode 100644
index 0000000..2a3dd5a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Ben Ho <ben.ho@mediatek.com>
+ *	   Erin Lo <erin.lo@mediatek.com>
+ */
+
+/dts-v1/;
+#include "mt8183.dtsi"
+
+/ {
+	model = "MediaTek MT8183 evaluation board";
+	compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
new file mode 100644
index 0000000..1553265
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Ben Ho <ben.ho@mediatek.com>
+ *	   Erin Lo <erin.lo@mediatek.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt8183";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x000>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@001 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x001>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@002 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x002>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@003 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x003>;
+			enable-method = "psci";
+		};
+
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x100>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x101>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x102>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x103>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible      = "arm,psci-1.0";
+		method          = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	gic: interrupt-controller@0c000000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		reg = <0 0x0c000000 0 0x40000>,  /* GICD */
+		      <0 0x0c100000 0 0x200000>, /* GICR */
+		      <0 0x0c400000 0 0x2000>,   /* GICC */
+		      <0 0x0c410000 0 0x1000>,   /* GICH */
+		      <0 0x0c420000 0 0x2000>;   /* GICV */
+
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	sysirq: intpol-controller@0c530a80 {
+		compatible = "mediatek,mt8183-sysirq",
+			     "mediatek,mt6577-sysirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		reg = <0 0x0c530a80 0 0x50>;
+	};
+};
-- 
1.9.1

