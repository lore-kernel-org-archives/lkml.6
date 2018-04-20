Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755644AbeDTPp6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:45:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47256 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755315AbeDTPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:45:57 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH] ARM: dts: imx53-ppd: Use IRQ_TYPE_* constants
Date: Fri, 20 Apr 2018 17:45:53 +0200
Message-Id: <20180420154553.18070-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace magic numbers with IRQ_TYPE_* constants to improve
DT readability.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index d5628af2e301..d02d07470ad3 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -300,7 +300,7 @@
 		compatible = "dlg,da9053-aa";
 		reg = <0>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <12 0x8>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
 		spi-max-frequency = <1000000>;
 		dlg,tsi-as-adc;
 		tsiref-supply = <&reg_tsiref>;
@@ -473,7 +473,7 @@
 				compatible = "fsl,mma8453";
 				reg = <0x1c>;
 				interrupt-parent = <&gpio1>;
-				interrupts = <6 0>;
+				interrupts = <6 IRQ_TYPE_NONE>;
 				interrupt-names = "INT1";
 			};
 
@@ -539,7 +539,7 @@
 		reset-gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;
 		reg = <0x4b>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <4 0x8>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.17.0
