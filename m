Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030514AbeBPNRX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:17:23 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030433AbeBPNRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:17:19 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: add RTC support on STM32H743
Date: Fri, 16 Feb 2018 14:16:39 +0100
Message-ID: <1518787000-10675-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
References: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for RTC on STM32H743 SoC.
It also adds dt-bindings/interrupt-controller/irq.h include and uses it to
configure RTC alarm interrupt.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 38d7cb8..b4487d1 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -44,6 +44,7 @@
 #include "armv7-m.dtsi"
 #include <dt-bindings/clock/stm32h7-clks.h>
 #include <dt-bindings/mfd/stm32h7-rcc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	clocks {
@@ -326,6 +327,20 @@
 			status = "disabled";
 		};
 
+		rtc: rtc@58004000 {
+			compatible = "st,stm32h7-rtc";
+			reg = <0x58004000 0x400>;
+			clocks = <&rcc RTCAPB_CK>, <&rcc RTC_CK>;
+			clock-names = "pclk", "rtc_ck";
+			assigned-clocks = <&rcc RTC_CK>;
+			assigned-clock-parents = <&rcc LSE_CK>;
+			interrupt-parent = <&exti>;
+			interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "alarm";
+			st,syscfg = <&pwrcfg>;
+			status = "disabled";
+		};
+
 		rcc: reset-clock-controller@58024400 {
 			compatible = "st,stm32h743-rcc", "st,stm32-rcc";
 			reg = <0x58024400 0x400>;
-- 
2.7.4
