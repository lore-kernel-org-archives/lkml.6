Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeE2JBL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:01:11 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:16931 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbeE2JBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:01:08 -0400
From: Roger Quadros <rogerq@ti.com>
To: <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        "[4.16+]" <stable@vger.kernel.org>
Subject: [PATCH 2/5] ARM: dts: am57xx-idk: Enable dual role for USB2 port
Date: Tue, 29 May 2018 12:00:55 +0300
Message-ID: <1527584458-6257-3-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527584458-6257-1-git-send-email-rogerq@ti.com>
References: <1527584458-6257-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dual-role support was added in v4.12. We should be using
it for USB2 port on the am57xx-idk.

Cc: <stable@vger.kernel.org>        [4.16+]
Reported-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts         | 4 ----
 arch/arm/boot/dts/am572x-idk-common.dtsi | 4 ----
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 7 ++++++-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index a255514..86301ae 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -65,10 +65,6 @@
 	};
 };
 
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &extcon_usb2 {
 	id-gpio = <&gpio5 7 GPIO_ACTIVE_HIGH>;
 	vbus-gpio = <&gpio7 22 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/am572x-idk-common.dtsi b/arch/arm/boot/dts/am572x-idk-common.dtsi
index c6d858b..784639d 100644
--- a/arch/arm/boot/dts/am572x-idk-common.dtsi
+++ b/arch/arm/boot/dts/am572x-idk-common.dtsi
@@ -57,10 +57,6 @@
 	};
 };
 
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &extcon_usb2 {
 	id-gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
 	vbus-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 43cdf52..697cd1a 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -406,8 +406,13 @@
 	dr_mode = "host";
 };
 
+&omap_dwc3_2 {
+	extcon = <&extcon_usb2>;
+};
+
 &usb2 {
-	dr_mode = "peripheral";
+	extcon = <&extcon_usb2>;
+	dr_mode = "otg";
 };
 
 &mmc1 {
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
