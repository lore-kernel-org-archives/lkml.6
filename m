Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeEUSjM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:39:12 -0400
Received: from anholt.net ([50.246.234.109]:50278 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeEUSjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:39:11 -0400
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH v2] arm: bcm2835: Add the PMU to the devicetree.
Date: Mon, 21 May 2018 11:39:07 -0700
Message-Id: <20180521183907.27563-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This only probes on arm64 so far, but hopefully that driver will be
generalized soon.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2837.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index 7704bb029605..beb6c502dadc 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -17,6 +17,12 @@
 		};
 	};
 
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupt-parent = <&local_intc>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&local_intc>;
-- 
2.17.0
