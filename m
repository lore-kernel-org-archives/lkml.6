Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeCIXgo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:36:44 -0500
Received: from anholt.net ([50.246.234.109]:38368 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeCIXgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:36:42 -0500
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH] ARM: bcm2835: Add the DPI hardware to the device tree.
Date: Fri,  9 Mar 2018 15:36:39 -0800
Message-Id: <20180309233639.2029-1-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's currently marked disabled, as it's not useful without a panel
associated with it and the GPIO pins routed to ALT2.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

This patch got misplaced as part of the original VC4 DPI work (which
included the binding).  I've got a full branch demoing a panel at
https://github.com/anholt/linux/commits/drm-vc4-dpi

 arch/arm/boot/dts/bcm283x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 18db25a5a66e..4359cb2aae22 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -438,6 +438,17 @@
 			interrupts = <2 14>; /* pwa1 */
 		};
 
+		dpi: dpi@7e208000 {
+			compatible = "brcm,bcm2835-dpi";
+			reg = <0x7e208000 0x8c>;
+			clocks = <&clocks BCM2835_CLOCK_VPU>,
+				 <&clocks BCM2835_CLOCK_DPI>;
+			clock-names = "core", "pixel";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		dsi0: dsi@7e209000 {
 			compatible = "brcm,bcm2835-dsi0";
 			reg = <0x7e209000 0x78>;
-- 
2.16.2
