Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753771AbeBZOhJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:37:09 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:57343 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753298AbeBZOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:37:06 -0500
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, avifishman70@gmail.com, brendanhiggins@google.com,
        joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 1/2] dt-binding: timer: document NPCM7xx timer DT bindings
Date: Mon, 26 Feb 2018 16:36:08 +0200
Message-Id: <1519655769-25836-2-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1519655769-25836-1-git-send-email-tmaimon77@gmail.com>
References: <1519655769-25836-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton NPCM7xx timer.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 .../bindings/timer/nuvoton,npcm7xx-timer.txt       | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
new file mode 100644
index 000000000000..c5150522e618
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
@@ -0,0 +1,25 @@
+Nuvoton NPCM7xx timer
+
+Nuvoton NPCM7xx have three timer modules, each timer module provides five 24-bit
+timer counters.
+
+Required properties:
+- compatible      : "nuvoton,npcm750-timer" for Poleg NPCM750.
+- reg             : Offset and length of the register set for the device.
+- interrupts      : Contain the timer interrupt with flags for
+                    falling edge.
+
+Required clocking property, have to be one of:
+- clocks          : phandle of timer reference clock.
+- clock-frequency : The frequency in Hz of the clock that drives the NPCM7xx
+                    timer (usually 25000000).
+
+Example:
+
+timer@f0008000 {
+    compatible = "nuvoton,npcm750-timer";
+    interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    reg = <0xf0008000 0x1000>;
+    clocks = <&clk NPCM7XX_CLK_TIMER>;
+};
+
-- 
2.14.1
