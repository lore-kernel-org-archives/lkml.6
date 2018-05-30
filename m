Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeE3OKu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:10:50 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:59110 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeE3OKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:10:45 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC: <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module node for MCAN
Date: Wed, 30 May 2018 19:41:32 +0530
Message-ID: <20180530141133.3711-6-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530141133.3711-1-faiz_abbas@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti-sysc driver provides support for manipulating the idlemodes
and interconnect level resets.

Add the generic interconnect target module node for MCAN to support
the same.

CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76x.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index bfc82636999c..57b8dc0fe719 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -11,6 +11,25 @@
 / {
 	compatible = "ti,dra762", "ti,dra7";
 
+	ocp {
+
+		target-module@0x42c00000 {
+			compatible = "ti,sysc-dra7-mcan";
+			ranges = <0x0 0x42c00000 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x42c01900 0x4>,
+			      <0x42c01904 0x4>,
+			      <0x42c01908 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP4_SOFTRESET |
+					 SYSC_DRA7_MCAN_ENAWAKEUP)>;
+			ti,syss-mask = <1>;
+			clocks = <&wkupaon_clkctrl DRA7_ADC_CLKCTRL 0>;
+			clock-names = "fck";
+		};
+	};
+
 };
 
 /* MCAN interrupts are hard-wired to irqs 67, 68 */
-- 
2.17.0
