Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeDFHvx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:51:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49346 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbeDFHvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:51:51 -0400
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: vireshk@kernel.org, shiraz.linux.kernel@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 1/2] ARM: SPEAr600: add DT description of the watchdog
Date: Fri,  6 Apr 2018 09:50:44 +0200
Message-Id: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPEAr600 has a built-in watchdog which already has a DT binding
described in Documentation/devicetree/bindings/watchdog/sp805-wdt.txt.

Let's add the description of the watchdog device in the SPEAr600 Device
Tree.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/arm/boot/dts/spear600.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index 00166eb..d7c3096 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -213,6 +213,14 @@
 				interrupts = <6>;
 				status = "disabled";
 			};
+
+			wdt: wdt@fc880000 {
+				compatible = "arm,sp805", "arm,primecell";
+				reg = <0xfc880000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <20>;
+				status = "disabled";
+			};
 		};
 	};
 };

base-commit: 5e1dacccbb87780856219e29122f1eccec912ebb
-- 
git-series 0.9.1
