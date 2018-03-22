Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754950AbeCVPPq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:15:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47241 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbeCVPPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:15:45 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 1/2] dt-bindings: interrupt-controller: Add binding for the Microsemi Ocelot interrupt controller
Date: Thu, 22 Mar 2018 16:15:23 +0100
Message-Id: <20180322151524.13902-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Device Tree binding documentation for the Microsemi Ocelot
interrupt controller that is part of the ICPU. It is connected directly to
the MIPS core interrupt controller.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changes since v2:
 - none

 .../interrupt-controller/mscc,ocelot-icpu-intr.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
new file mode 100644
index 000000000000..b47a8a02b17b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
@@ -0,0 +1,22 @@
+Microsemi Ocelot SoC ICPU Interrupt Controller
+
+Required properties:
+
+- compatible : should be "mscc,ocelot-icpu-intr"
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- interrupt-parent : phandle of the CPU interrupt controller.
+- interrupts : Specifies the CPU interrupt the controller is connected to.
+
+Example:
+
+		intc: interrupt-controller@70000070 {
+			compatible = "mscc,ocelot-icpu-intr";
+			reg = <0x70000070 0x70>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&cpuintc>;
+			interrupts = <2>;
+		};
-- 
2.16.2
