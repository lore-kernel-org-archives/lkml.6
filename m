Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeECSlb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:41:31 -0400
Received: from hermes.aosc.io ([199.195.250.187]:35911 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbeECSl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:41:29 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/7] arm64: allwinner: h6: add PRCM CCU device node
Date: Fri,  4 May 2018 02:38:42 +0800
Message-Id: <20180503183847.11046-3-icenowy@aosc.io>
In-Reply-To: <20180503183847.11046-1-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has also a PRCM CCU.

Add its device node into the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 4debc3962830..db9da343ba46 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -173,5 +173,15 @@
 			resets = <&ccu RST_BUS_UART3>;
 			status = "disabled";
 		};
+
+		r_ccu: clock@7010000 {
+			compatible = "allwinner,sun50i-h6-r-ccu";
+			reg = <0x07010000 0x400>;
+			clocks = <&osc24M>, <&osc32k>, <&iosc>,
+				 <&ccu CLK_PLL_PERIPH0>;
+			clock-names = "hosc", "losc", "iosc", "pll-periph";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.15.1
