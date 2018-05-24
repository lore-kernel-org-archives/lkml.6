Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966020AbeEXJe0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:34:26 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:56218 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965664AbeEXJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:34:22 -0400
X-IronPort-AV: E=Sophos;i="5.49,436,1520866800";
   d="scan'208";a="281940851"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
Date: Thu, 24 May 2018 10:28:40 +0100
Message-Id: <1527154169-32380-3-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas R9A06G032 SYSCTRL node description.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 .../bindings/clock/renesas,r9a06g032-sysctrl.txt   | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt

diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
new file mode 100644
index 0000000..63eb66cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
@@ -0,0 +1,32 @@
+* Renesas R9A06G032 SYSCTRL
+
+Required Properties:
+
+  - compatible: Must be:
+    - "renesas,r9a06g032-sysctrl"
+  - reg: Base address and length of the SYSCTRL IO block.
+  - #clock-cells: Must be 1
+
+Examples
+--------
+
+  - SYSCTRL node:
+
+	sysctrl: sysctrl@4000c000 {
+		compatible = "renesas,r9a06g032-sysctrl";
+		reg = <0x4000c000 0x1000>;
+		#clock-cells = <1>;
+	};
+
+  - Other nodes can use the clocks provided by SYSCTRL as in:
+
+	#include <dt-bindings/clock/r9a06g032-sysctrl.h>
+	uart0: serial@40060000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x40060000 0x400>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&sysctrl R9A06G032_CLK_UART0>;
+		clock-names = "baudclk";
+	};
-- 
2.7.4
