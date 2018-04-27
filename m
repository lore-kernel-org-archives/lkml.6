Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757389AbeD0ATH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:19:07 -0400
Received: from vern.gendns.com ([206.190.152.46]:46426 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757357AbeD0ATA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:19:00 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v9 24/27] dt-bindings: timer: new bindings for TI DaVinci timer
Date: Thu, 26 Apr 2018 19:17:42 -0500
Message-Id: <20180427001745.4116-25-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427001745.4116-1-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds new device tree bindings for the timer IP block of TI
DaVinci-like SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v9 changes:
- new patch in v9


 .../bindings/timer/ti,davinci-timer.txt       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ti,davinci-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/ti,davinci-timer.txt b/Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
new file mode 100644
index 000000000000..2091eca46981
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
@@ -0,0 +1,24 @@
+* Device tree bindings for Texas Instruments DaVinci timer
+
+This document provides bindings for the 64-bit timer in the DaVinci
+architecture devices. The timer can be configured as a general-purpose 64-bit
+timer, dual general-purpose 32-bit timers. When configured as dual 32-bit
+timers, each half can operate in conjunction (chain mode) or independently
+(unchained mode) of each other.
+
+It is global timer is a free running up-counter and can generate interrupt
+when the counter reaches preset counter values.
+
+Required properties:
+
+- compatible : should be "ti,davinci-timer".
+- reg : specifies base physical address and count of the registers.
+- clocks : the clock feeding the timer clock.
+
+Example:
+
+	clocksource: timer@20000 {
+		compatible = "ti,davinci-timer";
+		reg = <0x20000 0x1000>;
+		clocks = <&pll0_auxclk>;
+	};
-- 
2.17.0
