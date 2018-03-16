Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbeCPOFS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:05:18 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44133 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752984AbeCPOFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:05:15 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 6/9] dt-bindings: add device tree binding for Allwinner H6 main CCU
Date: Fri, 16 Mar 2018 22:02:12 +0800
Message-Id: <20180316140215.28663-7-icenowy@aosc.io>
In-Reply-To: <20180316140215.28663-1-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 main CCU uses the internal oscillator of the SoC, which
is different with old SoCs' main CCU.

Add device tree binding for the Allwinner H6 main CCU.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Extracted in v4.

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 4ca21c3a6fc9..460ef27b1008 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -20,6 +20,7 @@ Required properties :
 		- "allwinner,sun50i-a64-ccu"
 		- "allwinner,sun50i-a64-r-ccu"
 		- "allwinner,sun50i-h5-ccu"
+		- "allwinner,sun50i-h6-ccu"
 		- "nextthing,gr8-ccu"
 
 - reg: Must contain the registers base address and length
@@ -31,6 +32,9 @@ Required properties :
 - #clock-cells : must contain 1
 - #reset-cells : must contain 1
 
+For the main CCU on H6, one more clock is needed:
+- "iosc": the SoC's internal frequency oscillator
+
 For the PRCM CCUs on A83T/H3/A64, two more clocks are needed:
 - "pll-periph": the SoC's peripheral PLL from the main CCU
 - "iosc": the SoC's internal frequency oscillator
-- 
2.15.1
