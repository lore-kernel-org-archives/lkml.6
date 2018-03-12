Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeCLEYE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:24:04 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47720 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbeCLEX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:23:59 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: sun8i: a33: Enable PMIC power supplies on A33-OLinuXino
Date: Mon, 12 Mar 2018 12:23:55 +0800
Message-Id: <20180312042356.18625-4-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312042356.18625-1-wens@csie.org>
References: <20180312042356.18625-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A33-OLinuXino has a DC jack wired to the onboard PMIC's ACIN pins.
There is also a battery connector, wired to the PMIC's battery charger.

Enable the power supplies for both these components.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 925a5339711f..7f8a481af570 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -101,6 +101,14 @@
 
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
 	regulator-min-microvolt = <3300000>;
-- 
2.16.2
