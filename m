Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0ACC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4922C224E2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4922C224E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeGDBx1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:53:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15286 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932652AbeGDBxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:53:03 -0400
X-UUID: 38b481575c334ce99052cffb5f724b18-20180704
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 115308734; Wed, 04 Jul 2018 09:52:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 4 Jul 2018 09:52:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 4 Jul 2018 09:52:57 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v3 4/4] arm64: dts: mediatek: add mt6765 support
Date:   Wed, 4 Jul 2018 09:52:54 +0800
Message-ID: <1530669174-17623-5-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds basic chip support for MT6765 SoC.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile       |    1 +
 arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
 arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  155 +++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index ac17f60..7506b0d 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6765-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt6765-evb.dts b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
new file mode 100644
index 0000000..36dddff2
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Mediatek MT6765
+ *
+ * (C) Copyright 2018. Mediatek, Inc.
+ *
+ * Mars Cheng <mars.cheng@mediatek.com>
+ */
+
+/dts-v1/;
+#include "mt6765.dtsi"
+
+/ {
+	model = "MediaTek MT6765 EVB";
+	compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x1e800000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt6765.dtsi b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
new file mode 100644
index 0000000..051545b
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Mediatek MT6765
+ *
+ * (C) Copyright 2018. Mediatek, Inc.
+ *
+ * Mars Cheng <mars.cheng@mediatek.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt6765";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x000>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x001>;
+		};
+
+		cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x002>;
+		};
+
+		cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x003>;
+		};
+
+		cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x100>;
+		};
+
+		cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x101>;
+		};
+
+		cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x102>;
+		};
+
+		cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x103>;
+		};
+	};
+
+	baud_clk: dummy26m {
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+		#clock-cells = <0>;
+	};
+
+	sys_clk: dummyclk {
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+		#clock-cells = <0>;
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
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		sysirq: interrupt-controller@10200a80 {
+			compatible = "mediatek,mt6765-sysirq",
+				     "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0 0x10200a80 0 0x50>;
+		};
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#redistributor-regions = <1>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x0c000000 0 0x40000>, // distributor
+			      <0 0x0c100000 0 0x200000>, // redistributor
+			      <0 0x0c400000 0 0x40000>; // gicc
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt6765-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x400>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&baud_clk>, <&sys_clk>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		uart1: serial@11003000 {
+			compatible = "mediatek,mt6765-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x400>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&baud_clk>, <&sys_clk>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+	}; /* end of soc */
+};
-- 
1.7.9.5

