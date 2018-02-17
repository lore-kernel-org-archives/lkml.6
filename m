Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeBQT5L (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:57:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:18001 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751278AbeBQTzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:55:09 -0500
X-UUID: ad26a9646bf94092b8381e85302f1b56-20180218
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 07/15] arm64: dts: mt7622: turn uart0 clock to real ones
Date: Sun, 18 Feb 2018 03:54:42 +0800
Message-ID: <adc8e8585824abbd571e9c1a32db7b2cb084995b.1518895232.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This patch also cleans up two oscillators that provide clocks for MT7623.
Switch the uart clocks to the real ones while at it.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 7256879..d8a17d1 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -91,18 +91,6 @@
 		};
 	};
 
-	uart_clk: dummy25m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	bus_clk: dummy280m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <280000000>;
-	};
-
 	pwrap_clk: dummy40m {
 		compatible = "fixed-clock";
 		clock-frequency = <40000000>;
@@ -234,7 +222,8 @@
 			     "mediatek,mt6577-uart";
 		reg = <0 0x11002000 0 0x400>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>, <&bus_clk>;
+		clocks = <&topckgen CLK_TOP_UART_SEL>,
+			 <&pericfg CLK_PERI_UART1_PD>;
 		clock-names = "baud", "bus";
 		status = "disabled";
 	};
-- 
2.7.4
