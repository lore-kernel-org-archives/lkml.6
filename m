Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeC1DCD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:02:03 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:62686 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752817AbeC1DCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:02:00 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Yixun Lan <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Rob Herring <robh@kernel.org>, Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 3/3] ARM64: dts: meson: fix clock source of the pclk for UART_AO
Date: Wed, 28 Mar 2018 11:01:30 +0800
Message-ID: <20180328030130.240336-4-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180328030130.240336-1-yixun.lan@amlogic.com>
References: <20180328030130.240336-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From the hardware perspective, the actual pclk of the AO uarts
is the corresponding clkc_ao uart gate, not the main clock controller clk81.
This was not problem so far, because the uart_gate had
the CLK_IGNORE_UNUSED flag, which kept the gate open.

We plan to remove the CLK_IGNORE_UNUSED flag in another patch,
but before doing that, we need to fix the clock in the DTS file.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 40ca49fb94a6..dc6ca0895f11 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -798,7 +798,7 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
@@ -807,7 +807,7 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 562c26a0ba33..ea6898f62044 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -749,12 +749,12 @@
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
index e1a39cbed8c9..472106ce9a75 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -697,12 +697,12 @@
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
