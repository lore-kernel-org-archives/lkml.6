Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeBIRxT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:53:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39155 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBIRwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:52:41 -0500
X-Google-Smtp-Source: AH8x227nMNZxyGGGJgfA1cPdKGzpa5ZQU7iLAcfJ4bHrMbg8tC1vjKJHw7dn40uweQvLhcAnTpCd1A==
From: Philipp Rossak <embed3d@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 1/3] arm: dts: sun6i: a31s: bpi-m2: update mmc supply nodes
Date: Fri,  9 Feb 2018 18:52:34 +0100
Message-Id: <20180209175236.21215-2-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180209175236.21215-1-embed3d@gmail.com>
References: <20180209175236.21215-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the vmmc-supply properties on the mmc0 and mmc2
node to use the allready existent regulators.
We can now remove the sunxi-common-regulators.dtsi include since we
don't need it anymore.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 51e6f1d21c32..a8d86211c8f3 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -42,7 +42,6 @@
 
 /dts-v1/;
 #include "sun6i-a31s.dtsi"
-#include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -118,7 +117,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bpi_m2>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 4 GPIO_ACTIVE_HIGH>; /* PA4 */
 	cd-inverted;
@@ -132,7 +131,7 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_a>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_dcdc1>;
 	mmc-pwrseq = <&mmc2_pwrseq>;
 	bus-width = <4>;
 	non-removable;
-- 
2.11.0
