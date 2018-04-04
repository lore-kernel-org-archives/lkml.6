Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeDDLL6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:11:58 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:59426 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751306AbeDDLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:11:54 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, avifishman70@gmail.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/6] arm: dts: add watchdog device to NPCM750 device tree
Date: Wed,  4 Apr 2018 14:10:57 +0300
Message-Id: <1522840262-21635-2-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1522840262-21635-1-git-send-email-tmaimon77@gmail.com>
References: <1522840262-21635-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add watchdog device node to a common device tree for all Nuvoton
NPCM750 BMCs and a board specific device tree for the NPCM750 (Poleg)
evaluation board.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts |  4 ++++
 arch/arm/boot/dts/nuvoton-npcm750.dtsi    | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index cabde3d5be8a..4416dd6c7c17 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -18,6 +18,10 @@
 	};
 };
 
+&watchdog1 {
+	status = "okay";
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
index 839e45cfd695..cacd0fde5914 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750.dtsi
+++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
@@ -125,6 +125,30 @@
 				clocks = <&clk 15>;
 			};
 
+			watchdog0: watchdog@801C {
+				compatible = "nuvoton,npcm750-wdt";
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x801C 0x4>;
+				status = "disabled";
+				clocks = <&clk 5>;
+			};
+
+			watchdog1: watchdog@901C {
+				compatible = "nuvoton,npcm750-wdt";
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x901C 0x4>;
+				status = "disabled";
+				clocks = <&clk 5>;
+			};
+
+			watchdog2: watchdog@a01C {
+				compatible = "nuvoton,npcm750-wdt";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xa01C 0x4>;
+				status = "disabled";
+				clocks = <&clk 5>;
+			};
+
 			serial0: serial@1000 {
 				compatible = "ns16550a";
 				reg = <0x1000 0x1000>;
-- 
2.14.1
