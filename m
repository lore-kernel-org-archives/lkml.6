Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D2AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8F52080F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8F52080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeKSLWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:22:34 -0500
Received: from mx.socionext.com ([202.248.49.38]:40693 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbeKSLWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:22:33 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Nov 2018 10:00:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5BD0060062;
        Mon, 19 Nov 2018 10:00:37 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 19 Nov 2018 10:00:37 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id C36A740387;
        Mon, 19 Nov 2018 10:00:36 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id A489C120455;
        Mon, 19 Nov 2018 10:00:36 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 06/14] dt-bindings: clock: milbeaut: add Milbeaut clock description
Date:   Mon, 19 Nov 2018 10:01:11 +0900
Message-Id: <1542589274-13878-7-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Milbeaut clock.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../devicetree/bindings/clock/milbeaut-clock.txt   | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
new file mode 100644
index 0000000..5c093c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
@@ -0,0 +1,93 @@
+Milbeaut M10V Clock Controller Binding
+----------------------------------------
+Milbeaut clock controller is consists of few oscillators, PLL, multiplexer
+and few divider modules
+
+This binding uses common clock bindings
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible: shall be "socionext,milbeaut-m10v-clk-regs"
+- reg: shall contain base address and length of clock registers
+- #clock-cells: shall be 0
+
+Example:
+	m10v-clk-tree@ {
+		compatible = "socionext,milbeaut-m10v-clk-regs";
+		reg = <0x1d021000 0x4000>;
+
+		clocks {
+			#address-cells = <0>;
+			#size-cells = <0>;
+
+			uclk40xi: uclk40xi {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <40000000>;
+			};
+		};
+	}
+
+The clock consumer shall specify the desired clock-output of the clock
+controller (as defined in [2]) by specifying output-id in its "clock"
+phandle cell
+[2] arch/arm/boot/dts/milbeaut-m10v-clk.h
+
+For example for UART1:
+	usio1:  usio_uart@1e700010 {
+		index = <0>;
+		compatible = "socionext,milbeaut-m10v-usio-uart";
+		reg = <0x1e700010 0x10>;
+		interrupts = <0 141 0x4>, <0 149 0x4>;
+		interrupt-names = "rx", "tx";
+		clocks = <&hclk>;
+	};
+
+
+
+
+Required properties:
+- compatible:
+	"socionext,milbeaut-m10v-clk-mux"
+		-clock-cells: should be 0
+		-clocks: should be two factor
+	"socionext,milbeaut-m10v-pll-fixed-factor"
+		-clock-cells: should be 0
+		-clocks: should be one factor
+		-offset: offset
+		-clock-div: div number
+		-clock-mult: multiple number
+	"socionext,milbeaut-m10v-clk-div"
+		-clock-cells: should be 0
+		-clocks: should be one factor
+		-offset: offset
+		-mask: mask bit
+		-ratios: div ratio
+
+Example
+	piclk_mux_0: spiclk_mux_0 {
+		compatible = "socionext,m10v-clk-div";
+		#clock-cells = <0>;
+		clocks = <&pll10_div_1_2>;
+		offset = <bSPICLK>;
+		mask = <0x3>;
+		ratios = <4 0x5 2 0x4>;
+	};
+
+	pll10: pll10 {
+		compatible = "socionext,m10v-pll-fixed-factor";
+		#clock-cells = <0>;
+		clocks = <&uclk40xi>;
+		offset = <10>;
+		clock-div = <5>;
+		clock-mult = <108>;
+	};
+
+	emmcclk: emmcclk {
+		compatible = "socionext,m10v-clk-div";
+		#clock-cells = <0>;
+		clocks = <&pll11>;
+		offset = <bEMMCCLK>;
+		mask = <0x3>;
+		ratios = <15 0x7 10 0x6 9 0x5 8 0x4>;
+	};
-- 
1.9.1

