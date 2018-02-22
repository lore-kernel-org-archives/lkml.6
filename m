Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeBVPXu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:23:50 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:37650 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932945AbeBVPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:23:47 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jesper Nilsson <jespern@axis.com>, Lars Persson <larper@axis.com>,
        Niklas Cassel <niklass@axis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@axis.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: pinctrl: artpec6: add smaller groups for uarts
Date: Thu, 22 Feb 2018 16:22:47 +0100
Message-Id: <20180222152247.10554-2-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180222152247.10554-1-niklas.cassel@axis.com>
References: <20180222152247.10554-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add group configuration for uarts that are cut down
variants, the standard being full, i.e. all signals,
flow control, i.e. rx/tx and cts/rts, and rx/tx only.

This allows us to be more precise in which pins we're
actually using.

Unfortunately the existing naming scheme leaves things
to be desired, e.g. uart3grp0 means RX/TX and CTS/RTS,
yet uart0grp0 means all pins.
Since the exising suffixes have different meaning for
different uarts, and the fact that we cannot change
the name of existing groups, makes it hard to use a
descriptive name for the newly added groups.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 .../devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt  | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
index c3f9826692bc..678f5097058e 100644
--- a/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
@@ -19,8 +19,9 @@ Required subnode-properties:
 	Available functions and groups (function: group0, group1...):
 		gpio: cpuclkoutgrp0, udlclkoutgrp0, i2c1grp0, i2c2grp0,
 		      i2c3grp0, i2s0grp0, i2s1grp0, i2srefclkgrp0, spi0grp0,
-		      spi1grp0, pciedebuggrp0, uart0grp0, uart0grp1, uart1grp0,
-		      uart2grp0, uart2grp1, uart3grp0, uart4grp0, uart5grp0,
+		      spi1grp0, pciedebuggrp0, uart0grp0, uart0grp1, uart0grp2,
+		      uart1grp0, uart1grp1, uart2grp0, uart2grp1, uart2grp2,
+		      uart3grp0, uart4grp0, uart4grp1, uart5grp0, uart5grp1,
 		      uart5nocts
 		cpuclkout: cpuclkoutgrp0
 		udlclkout: udlclkoutgrp0
@@ -33,12 +34,12 @@ Required subnode-properties:
 		spi0: spi0grp0
 		spi1: spi1grp0
 		pciedebug: pciedebuggrp0
-		uart0: uart0grp0, uart0grp1
-		uart1: uart1grp0
-		uart2: uart2grp0, uart2grp1
+		uart0: uart0grp0, uart0grp1, uart0grp2
+		uart1: uart1grp0, uart1grp1
+		uart2: uart2grp0, uart2grp1, uart2grp2
 		uart3: uart3grp0
-		uart4: uart4grp0
-		uart5: uart5grp0, uart5nocts
+		uart4: uart4grp0, uart4grp1
+		uart5: uart5grp0, uart5grp1, uart5nocts
 		nand: nandgrp0
 		sdio0: sdio0grp0
 		sdio1: sdio1grp0
-- 
2.14.2
