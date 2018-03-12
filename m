Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbeCLEVV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:21:21 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47688 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbeCLEVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:21:20 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i: reference tablet design: Enable PMIC power supplies
Date: Mon, 12 Mar 2018 12:21:16 +0800
Message-Id: <20180312042116.18513-1-wens@csie.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A23/A33 reference tablet design has a DC barrel tied to the ACIN
of the PMIC. And being a tablet, it has a Li-Po battery.

Enable both power supplies in the device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index f51f37cc721d..880096c7e252 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -124,6 +124,14 @@
 
 #include "axp223.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <3000000>;
-- 
2.16.2
