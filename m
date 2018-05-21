Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeEULyh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:54:37 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:11076 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbeEULyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:54:35 -0400
From: Emmanuel Vadot <manu@freebsd.org>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH v2] ARM64: dts: sun50i: h5: Add spi flash node for OrangePi PC2
Date: Mon, 21 May 2018 13:54:26 +0200
Message-Id: <20180521115426.92115-1-manu@freebsd.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OrangePi PC2 have an mx25l1606e spi flash.
Add a node for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
Changes in v2:
 - Only use the compatible 'jedec,spi-nor' since the device answer to
 the jedec command 0x9F

 arch/arm64//boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 98862c7c7258..3e0d5a9c096d 100644
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
+		compatible = "jedec,spi-nor";
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
