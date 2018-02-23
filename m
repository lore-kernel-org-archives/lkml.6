Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeBWNlg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:41:36 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53717 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeBWNld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:41:33 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: arnd@arndb.de, geert@linux-m68k.org, horms@verge.net.au,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] arm64: dts: renesas: r8a77965: Add #address-cells and #size-cells
Date: Fri, 23 Feb 2018 14:40:54 +0100
Message-Id: <1519393259-26108-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "#address-cells" and "#size-cells" properties to all place-holder nodes
that have children nodes defined by salvator-x[s].dtsi device tree.

This silences the following DTC compiler warnings:
Warning (reg_format): "reg" property in /soc/.. has invalid length (4 bytes)
(#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells
value for /soc/...
Warning (avoid_default_addr_size): Relying on default #size-cells value
for /soc/...

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 4286453..61efb2d 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -521,6 +521,9 @@
 		};
 
 		avb: ethernet@e6800000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
 			/* placeholder */
 		};
@@ -528,11 +531,21 @@
 		csi20: csi2@fea80000 {
 			reg = <0 0xfea80000 0 0x10000>;
 			/* placeholder */
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		csi40: csi2@feaa0000 {
 			reg = <0 0xfeaa0000 0 0x10000>;
 			/* placeholder */
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		vin0: video@e6ef0000 {
@@ -611,6 +624,9 @@
 		};
 
 		i2c2: i2c@e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			reg = <0 0xe6510000 0 0x40>;
 			/* placeholder */
 		};
@@ -621,6 +637,9 @@
 		};
 
 		i2c4: i2c@e66d8000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			reg = <0 0xe66d8000 0 0x40>;
 			/* placeholder */
 		};
@@ -636,6 +655,9 @@
 		};
 
 		i2c_dvfs: i2c@e60b0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			reg = <0 0xe60b0000 0 0x425>;
 			/* placeholder */
 		};
@@ -681,6 +703,9 @@
 			/* placeholder */
 
 			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
 				port@0 {
 					reg = <0>;
 					du_out_rgb: endpoint {
-- 
2.7.4
