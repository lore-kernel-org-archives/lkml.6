Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F855C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007D2208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007D2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbeGaHST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:18:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28301 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729723AbeGaHSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:18:06 -0400
X-UUID: ed2d74117e1e429d814622a75946b2d7-20180731
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1204511737; Tue, 31 Jul 2018 13:39:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 31 Jul 2018 13:39:29 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 31 Jul 2018 13:39:30 +0800
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
        <linux-clk@vger.kernel.org>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 08/10] arm64: dts: mt8183: Add clock controller device nodes
Date:   Tue, 31 Jul 2018 13:38:05 +0800
Message-ID: <1533015487-60189-9-git-send-email-erin.lo@mediatek.com>
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

From: Weiyi Lu <weiyi.lu@mediatek.com>

Add clock controller nodes for MT8183, include topckgen, infracfg,
apmixedsys and subsystem.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 92 ++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 1553265..6b87a24 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -5,6 +5,7 @@
  *	   Erin Lo <erin.lo@mediatek.com>
  */
 
+#include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -112,6 +113,13 @@
 		method          = "smc";
 	};
 
+	clk26m: oscillator@0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
@@ -143,4 +151,88 @@
 		interrupt-parent = <&gic>;
 		reg = <0 0x0c530a80 0 0x50>;
 	};
+
+	topckgen: syscon@10000000 {
+		compatible = "mediatek,mt8183-topckgen", "syscon";
+		reg = <0 0x10000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	infracfg: syscon@10001000 {
+		compatible = "mediatek,mt8183-infracfg", "syscon";
+		reg = <0 0x10001000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	apmixedsys: syscon@1000c000 {
+		compatible = "mediatek,mt8183-apmixedsys", "syscon";
+		reg = <0 0x1000c000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	audiosys: syscon@11220000 {
+		compatible = "mediatek,mt8183-audiosys", "syscon";
+		reg = <0 0x11220000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	mfgcfg: syscon@13000000 {
+		compatible = "mediatek,mt8183-mfgcfg", "syscon";
+		reg = <0 0x13000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	mmsys: syscon@14000000 {
+		compatible = "mediatek,mt8183-mmsys", "syscon";
+		reg = <0 0x14000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	imgsys: syscon@15020000 {
+		compatible = "mediatek,mt8183-imgsys", "syscon";
+		reg = <0 0x15020000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	vdecsys: syscon@16000000 {
+		compatible = "mediatek,mt8183-vdecsys", "syscon";
+		reg = <0 0x16000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	vencsys: syscon@17000000 {
+		compatible = "mediatek,mt8183-vencsys", "syscon";
+		reg = <0 0x17000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_conn: syscon@19000000 {
+		compatible = "mediatek,mt8183-ipu_conn", "syscon";
+		reg = <0 0x19000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_adl: syscon@19010000 {
+		compatible = "mediatek,mt8183-ipu_adl", "syscon";
+		reg = <0 0x19010000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_core0: syscon@19180000 {
+		compatible = "mediatek,mt8183-ipu_core0", "syscon";
+		reg = <0 0x19180000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_core1: syscon@19280000 {
+		compatible = "mediatek,mt8183-ipu_core1", "syscon";
+		reg = <0 0x19280000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	camsys: syscon@1a000000 {
+		compatible = "mediatek,mt8183-camsys", "syscon";
+		reg = <0 0x1a000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
 };
-- 
1.9.1

