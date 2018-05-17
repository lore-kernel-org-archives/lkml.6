Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEQKkP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:40:15 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:20697 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeEQKkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:40:13 -0400
From: Emmanuel Vadot <manu@freebsd.org>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH] ARM64: dts: sun50i: h5: Add spi flash node for OrangePi PC2
Date: Thu, 17 May 2018 12:34:35 +0200
Message-Id: <20180517103435.92874-1-manu@freebsd.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OrangePi PC2 have an mx25l1606e spi flash.
Add a node for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 98862c7c7258..0b870e4b4fad 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -207,6 +207,18 @@
 	status = "okay";
 };
 
+&spi0  {
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mx25l1606e", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.17.0
