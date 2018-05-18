Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeERSeZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:34:25 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46053 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeERSeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:34:19 -0400
X-Google-Smtp-Source: AB8JxZpZGrUBlyI424gCvoP9UpmA9+8XS531+yBXSgzmQWBl267gaEAPqmhCrxa15iOre18A4ssdbw==
From: Scott Branden <scott.branden@broadcom.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Ray Jui <rjui@broadcom.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] arm64: dts: stingray: use NUM_SATA to configure number of sata ports
Date: Fri, 18 May 2018 11:34:06 -0700
Message-Id: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move remaining sata configuration to stingray-sata.dtsi and enable
ports based on NUM_SATA defined.
Now, all that needs to be done is define NUM_SATA per board.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 64 --------------------
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |  2 +
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |  2 +
 .../boot/dts/broadcom/stingray/stingray-sata.dtsi  | 68 ++++++++++++++++++++++
 4 files changed, 72 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index 8862ec9..cacc25e 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -72,70 +72,6 @@
 	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
 };
 
-&sata0 {
-	status = "okay";
-};
-
-&sata_phy0{
-	status = "okay";
-};
-
-&sata1 {
-	status = "okay";
-};
-
-&sata_phy1{
-	status = "okay";
-};
-
-&sata2 {
-	status = "okay";
-};
-
-&sata_phy2{
-	status = "okay";
-};
-
-&sata3 {
-	status = "okay";
-};
-
-&sata_phy3{
-	status = "okay";
-};
-
-&sata4 {
-	status = "okay";
-};
-
-&sata_phy4{
-	status = "okay";
-};
-
-&sata5 {
-	status = "okay";
-};
-
-&sata_phy5{
-	status = "okay";
-};
-
-&sata6 {
-	status = "okay";
-};
-
-&sata_phy6{
-	status = "okay";
-};
-
-&sata7 {
-	status = "okay";
-};
-
-&sata_phy7{
-	status = "okay";
-};
-
 &mdio_mux_iproc {
 	mdio@10 {
 		gphy0: eth-phy@10 {
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
index 77efa28..a515346 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
@@ -32,6 +32,8 @@
 
 /dts-v1/;
 
+#define NUM_SATA	8
+
 #include "bcm958742-base.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
index 5084b03..6a4d19e 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
@@ -32,6 +32,8 @@
 
 /dts-v1/;
 
+#define NUM_SATA	8
+
 #include "bcm958742-base.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
index 8c68e0c..7f6d176 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
@@ -43,7 +43,11 @@
 			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 0)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata0_port0: sata-port@0 {
 				reg = <0>;
@@ -58,7 +62,11 @@
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 0)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata0_phy0: sata-phy@0 {
 				reg = <0>;
@@ -73,7 +81,11 @@
 			interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 1)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata1_port0: sata-port@0 {
 				reg = <0>;
@@ -88,7 +100,11 @@
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 1)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata1_phy0: sata-phy@0 {
 				reg = <0>;
@@ -103,7 +119,11 @@
 			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 2)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata2_port0: sata-port@0 {
 				reg = <0>;
@@ -118,7 +138,11 @@
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 2)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata2_phy0: sata-phy@0 {
 				reg = <0>;
@@ -133,7 +157,11 @@
 			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 3)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata3_port0: sata-port@0 {
 				reg = <0>;
@@ -148,7 +176,11 @@
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 3)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata3_phy0: sata-phy@0 {
 				reg = <0>;
@@ -163,7 +195,11 @@
 			interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 4)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata4_port0: sata-port@0 {
 				reg = <0>;
@@ -178,7 +214,11 @@
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 4)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata4_phy0: sata-phy@0 {
 				reg = <0>;
@@ -193,7 +233,11 @@
 			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 5)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata5_port0: sata-port@0 {
 				reg = <0>;
@@ -208,7 +252,11 @@
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 5)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata5_phy0: sata-phy@0 {
 				reg = <0>;
@@ -223,7 +271,11 @@
 			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 6)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata6_port0: sata-port@0 {
 				reg = <0>;
@@ -238,7 +290,11 @@
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 6)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata6_phy0: sata-phy@0 {
 				reg = <0>;
@@ -253,7 +309,11 @@
 			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 7)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata7_port0: sata-port@0 {
 				reg = <0>;
@@ -268,11 +328,19 @@
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
+#if (NUM_SATA > 7)
+			status = "okay";
+#else
 			status = "disabled";
+#endif
 
 			sata7_phy0: sata-phy@0 {
 				reg = <0>;
 				#phy-cells = <0>;
 			};
 		};
+
+#if (NUM_SATA > 8)
+#error "NUM_SATA > 8"
+#endif
 	};
-- 
2.5.0
