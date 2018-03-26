Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeCZISh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:18:37 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:51335 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeCZISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:18:35 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 3/3] ARM64: dts: meson: fix clock source of the pclk for UART_AO
Date: Mon, 26 Mar 2018 16:18:09 +0800
Message-ID: <20180326081809.49493-4-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180326081809.49493-1-yixun.lan@amlogic.com>
References: <20180326081809.49493-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From the hardware perspective, the clk81 is the parent of
the UART_AO clocks. So it make more sense to mark
the CLKID_AO_UART1/2 as the pclk.

Previous we had flag=CLK_IGNORE_UNUSED in AO clock driver.
This will make kernel leave clock as it is while bootloader
set the clock on.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 48584d5a329b..e538e2448bb5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -533,7 +533,7 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
@@ -542,7 +542,7 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 3290a4dc3522..a458ea50c2ef 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -783,12 +783,12 @@
 };
 
 &uart_AO {
-	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_AO_B {
-	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 4f355f17eed6..474f4f9630e4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -733,12 +733,12 @@
 };
 
 &uart_AO {
-	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_AO_B {
-	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
-- 
2.15.1
