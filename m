Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeCBVpx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:45:53 -0500
Received: from mail.blih.net ([212.83.177.182]:60004 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbeCBVpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:45:51 -0500
From: Emmanuel Vadot <manu@freebsd.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org,
        devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH] dts: sunxi: Add eMMC for NanoPi M1 Plus
Date: Fri,  2 Mar 2018 22:38:52 +0100
Message-Id: <20180302213852.64588-1-manu@freebsd.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NanoPi-M1-Plus have a 8GB eMMC, add a node for it.
This eMMC is always powered with 3.3V.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index a6e61915d648..0ca988e8c72f 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -119,6 +119,16 @@
 	};
 };
 
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bits_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
-- 
2.15.1
