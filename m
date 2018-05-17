Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeEQPGZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:06:25 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:15600 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeEQPGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:06:24 -0400
From: Emmanuel Vadot <manu@freebsd.org>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH] ARM64: dts: sun50i: a64: Add spi flash node for sopine
Date: Thu, 17 May 2018 17:06:13 +0200
Message-Id: <20180517150613.11916-1-manu@freebsd.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sopine and Pine64-LTS have a winbond w25q128 spi flash on spi0.
Add a node for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 43418bd881d8..3285aebc06d9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -66,6 +66,18 @@
 	};
 };
 
+&spi0  {
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 #include "axp803.dtsi"
 
 &reg_aldo2 {
-- 
2.17.0
