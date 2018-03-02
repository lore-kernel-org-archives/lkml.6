Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422724AbeCBGiU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 01:38:20 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46294 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422690AbeCBGiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 01:38:08 -0500
X-Google-Smtp-Source: AG47ELsWCCKJO4aV3BTBBumUBSG4OFHxcYJruO+ir6GRIWBRsvq4jb4NlZ4DtAvYbOwyTNIHKAKROw==
From: Joel Stanley <joel@jms.id.au>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH 1/2] dt-bindings: watchdog: Add Nuvoton NPCM description
Date: Fri,  2 Mar 2018 17:07:45 +1030
Message-Id: <20180302063746.10993-2-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180302063746.10993-1-joel@jms.id.au>
References: <20180302063746.10993-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These bindings describe the watchdog IP as used by the Nuvoton NPCM750
(Poleg) BMC SoC.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../bindings/watchdog/nuvoton,npcm-wdt.txt         | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
new file mode 100644
index 000000000000..599db288337e
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
@@ -0,0 +1,25 @@
+Nuvoton NPCM Watchdog
+
+Nuvoton NPCM timer module provides five 24-bit timer counters, and a watchdog.
+The watchdog supports a pre-timeout interrupt that fires 10ms before the
+expiry.
+
+Required properties:
+- compatible      : "nuvoton,npcm750-wdt" for NPCM750 (Poleg).
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
+timer@f00080c1 {
+    compatible = "nuvoton,npcm750-wdt";
+    interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+    reg = <0xf00080c1 0x4>;
+    clocks = <&clk NPCM7XX_CLK_TIMER>;
+};
-- 
2.15.1
