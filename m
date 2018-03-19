Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755391AbeCSIMl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:12:41 -0400
Received: from hermes.aosc.io ([199.195.250.187]:36941 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751747AbeCSIMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:12:33 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/2] arm64: allwinner: h6: temporarily drop the usage of CCU headers in DTSI
Date: Mon, 19 Mar 2018 16:11:08 +0800
Message-Id: <20180319081108.23496-2-icenowy@aosc.io>
In-Reply-To: <20180319081108.23496-1-icenowy@aosc.io>
References: <20180319081108.23496-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the CCU driver will be merged in different tree with the device tree,
temporarily drop the usage of CCU headers in the DTSI file, and replace
macros with the corresponding numbers.

After they are both merged into Linus' tree, it can be switched back to
use the CCU headers.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 4debc3962830..56563150d61a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -4,8 +4,6 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/sun50i-h6-ccu.h>
-#include <dt-bindings/reset/sun50i-h6-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -117,7 +115,7 @@
 				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_APB1>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu 26>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -136,8 +134,8 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART0>;
-			resets = <&ccu RST_BUS_UART0>;
+			clocks = <&ccu 70>;
+			resets = <&ccu 21>;
 			status = "disabled";
 		};
 
@@ -147,8 +145,8 @@
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART1>;
-			resets = <&ccu RST_BUS_UART1>;
+			clocks = <&ccu 71>;
+			resets = <&ccu 22>;
 			status = "disabled";
 		};
 
@@ -158,8 +156,8 @@
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART2>;
-			resets = <&ccu RST_BUS_UART2>;
+			clocks = <&ccu 72>;
+			resets = <&ccu 23>;
 			status = "disabled";
 		};
 
@@ -169,8 +167,8 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART3>;
-			resets = <&ccu RST_BUS_UART3>;
+			clocks = <&ccu 73>;
+			resets = <&ccu 24>;
 			status = "disabled";
 		};
 	};
-- 
2.15.1
