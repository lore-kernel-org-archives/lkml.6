Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeECSmi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:42:38 -0400
Received: from hermes.aosc.io ([199.195.250.187]:35989 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbeECSmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:42:37 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 5/7] arm64: allwinner: h6: add R_INTC interrupt controller
Date: Fri,  4 May 2018 02:38:45 +0800
Message-Id: <20180503183847.11046-6-icenowy@aosc.io>
In-Reply-To: <20180503183847.11046-1-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC has also a R_INTC interrupt controller like Allwinner
A64 SoC, but has its base address changed due to the memory map change
in H6.

Add it into the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index a18b78fb4850..b0b342c8c189 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -184,6 +184,15 @@
 			#reset-cells = <1>;
 		};
 
+		r_intc: interrupt-controller@7021000 {
+			compatible = "allwinner,sun50i-h6-r-intc",
+				     "allwinner,sun6i-a31-r-intc";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x07021000 0x400>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_pio: pinctrl@7022000 {
 			compatible = "allwinner,sun50i-h6-r-pinctrl";
 			reg = <0x07022000 0x400>;
-- 
2.15.1
