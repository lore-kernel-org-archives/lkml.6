Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeBFJ3B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:29:01 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46571 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeBFJ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:28:49 -0500
X-Google-Smtp-Source: AH8x2268F8epp31CLfRSFrAlWrIO6Y1GCA0iUv8gOKB3pxdRGX2fJalOPPZxxfVAgYq85oaHYv4njQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de
Cc: chunyan.zhang@spreadtrum.com, orson.zhai@spreadtrum.com,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/7] arm64: dts: Add hwspinlock node for Spreadtrum SC9860
Date: Tue,  6 Feb 2018 17:28:20 +0800
Message-Id: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum SC9860 platform only has one hardware spinlock device,
which is located on AON system of Spreadtrum SC9860 platform.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 328009c..b9cc0fb 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -6,6 +6,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/clock/sprd,sc9860-clk.h>
+
 / {
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
@@ -104,6 +106,21 @@
 				status = "disabled";
 			};
 		};
+
+		aon {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			hwlock: hwspinlock@40500000 {
+				compatible = "sprd,hwspinlock-r3p0";
+				reg = <0 0x40500000 0 0x1000>;
+				#hwlock-cells = <1>;
+				clock-names = "enable";
+				clocks = <&aon_gate CLK_SPLK_EB>;
+			};
+		};
 	};
 
 	ext_32k: ext_32k {
-- 
1.7.9.5
