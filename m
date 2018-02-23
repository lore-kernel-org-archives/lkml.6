Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeBWKRE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:17:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59743 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751329AbeBWKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:55 -0500
X-UUID: fd6b1f6efc43454cb6de4a901ce93de9-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 13/19] arm: dts: mt7623: move node mt6323 leds to mt6323.dtsi
Date: Fri, 23 Feb 2018 18:16:33 +0800
Message-ID: <e8a515a1aeaf06a7162b8b0e390bee615b323303.1519378872.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Since those LEDs are parts of PMIC MT6323, it is reasonable to merge
those LEDs node definition back into mt6323.dtsi. This way can improve
the reusability of those nodes among different boards with the same PMIC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/mt6323.dtsi                 | 26 ++++++++++++++++++++++++-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 28 ---------------------------
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mt6323.dtsi
index 7c783d6..44c5642 100644
--- a/arch/arm/boot/dts/mt6323.dtsi
+++ b/arch/arm/boot/dts/mt6323.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2017 MediaTek Inc.
+ * Copyright (c) 2017-2018 MediaTek Inc.
  * Author: John Crispin <john@phrozen.org>
  *	   Sean Wang <sean.wang@mediatek.com>
  * This program is free software; you can redistribute it and/or modify
@@ -237,5 +237,29 @@
 				regulator-enable-ramp-delay = <216>;
 			};
 		};
+
+		leds {
+			compatible = "mediatek,mt6323-led";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				label = "mt6323:isink:green";
+				default-state = "off";
+			};
+
+			led@1 {
+				reg = <1>;
+				label = "mt6323:isink:red";
+				default-state = "off";
+			};
+
+			led@2 {
+				reg = <2>;
+				label = "mt6323:isink:blue";
+				default-state = "off";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 75e61c4..767b225 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -483,34 +483,6 @@
 	status = "okay";
 };
 
-&pwrap {
-	mt6323 {
-		mt6323led: led {
-			compatible = "mediatek,mt6323-led";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			led@0 {
-				reg = <0>;
-				label = "bpi-r2:isink:green";
-				default-state = "off";
-			};
-
-			led@1 {
-				reg = <1>;
-				label = "bpi-r2:isink:red";
-				default-state = "off";
-			};
-
-			led@2 {
-				reg = <2>;
-				label = "bpi-r2:isink:blue";
-				default-state = "off";
-			};
-		};
-	};
-};
-
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins_a>;
-- 
2.7.4
