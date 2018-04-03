Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeDCNBq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:01:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38338 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeDCNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:01:45 -0400
X-Google-Smtp-Source: AIpwx4+b7RayYe+7RqDdUStTJP4tj6+n0q1mYv5e9dxYkuTXSMM8XJ7ClffExjYCWjXun30yWkqslg==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 1/6] dt-binding: timer: document NPCM7xx timer DT bindings
Date: Tue,  3 Apr 2018 15:00:25 +0200
Message-Id: <1522760432-32048-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org>
References: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Maimon <tmaimon77@gmail.com>

Added device tree binding documentation for Nuvoton NPCM7xx timer.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/timer/nuvoton,npcm7xx-timer.txt        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
new file mode 100644
index 0000000..ea22dfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
@@ -0,0 +1,21 @@
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
+- clocks          : phandle of timer reference clock (usually a 25 MHz clock).
+
+Example:
+
+timer@f0008000 {
+    compatible = "nuvoton,npcm750-timer";
+    interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    reg = <0xf0008000 0x50>;
+    clocks = <&clk NPCM7XX_CLK_TIMER>;
+};
+
-- 
2.7.4
