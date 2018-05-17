Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeEQNRc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:17:32 -0400
Received: from anholt.net ([50.246.234.109]:45426 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeEQNRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:17:31 -0400
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
Date: Thu, 17 May 2018 14:17:27 +0100
Message-Id: <20180517131727.29263-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The a53 and a7 counters seem to match up, so we advertise a7 so that
arm32 can probe.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2837.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index 7704bb029605..1f5e5c782835 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -17,6 +17,12 @@
 		};
 	};
 
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu", "arm,cortex-a7-pmu";
+		interrupt-parent = <&local_intc>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&local_intc>;
-- 
2.17.0
