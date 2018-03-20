Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbeCTNJ7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:09:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42736 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753281AbeCTNIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:08:14 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v6 2/6] dt-bindings: mips: Add bindings for Microsemi SoCs
Date: Tue, 20 Mar 2018 14:07:57 +0100
Message-Id: <20180320130801.9247-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
References: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Microsemi SoCs. Currently only Ocelot is supported.

Reviewed-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/mips/mscc.txt | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt

diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
new file mode 100644
index 000000000000..ae15ec333542
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/mscc.txt
@@ -0,0 +1,43 @@
+* Microsemi MIPS CPUs
+
+Boards with a SoC of the Microsemi MIPS family shall have the following
+properties:
+
+Required properties:
+- compatible: "mscc,ocelot"
+
+
+* Other peripherals:
+
+o CPU chip regs:
+
+The SoC has a few registers (DEVCPU_GCB:CHIP_REGS) handling miscellaneous
+functionalities: chip ID, general purpose register for software use, reset
+controller, hardware status and configuration, efuses.
+
+Required properties:
+- compatible: Should be "mscc,ocelot-chip-regs", "simple-mfd", "syscon"
+- reg : Should contain registers location and length
+
+Example:
+	syscon@71070000 {
+		compatible = "mscc,ocelot-chip-regs", "simple-mfd", "syscon";
+		reg = <0x71070000 0x1c>;
+	};
+
+
+o CPU system control:
+
+The SoC has a few registers (ICPU_CFG:CPU_SYSTEM_CTRL) handling configuration of
+the CPU: 8 general purpose registers, reset control, CPU en/disabling, CPU
+endianness, CPU bus control, CPU status.
+
+Required properties:
+- compatible: Should be "mscc,ocelot-cpu-syscon", "syscon"
+- reg : Should contain registers location and length
+
+Example:
+	syscon@70000000 {
+		compatible = "mscc,ocelot-cpu-syscon", "syscon";
+		reg = <0x70000000 0x2c>;
+	};
-- 
2.16.2
