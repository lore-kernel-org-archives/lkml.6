Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeB1NLz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:11:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60489 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752569AbeB1NLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:11:51 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@bootlin.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 2/3] ARM: dts: sun8i: a711: set regulator for each cluster of CPUs
Date: Wed, 28 Feb 2018 14:11:21 +0100
Message-Id: <07883d44949420891c1ed2411ff15199d53075c0.1519823347.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
References: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
References: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner A83T is a SoC with two clusters of 4 A7 which have a
different clock and regulator.

Set the CPU regulator.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 1de362f..d65162c 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -128,6 +128,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&cpu100 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
 &de {
 	status = "okay";
 };
@@ -136,6 +144,7 @@
  * An USB-2 hub is connected here, which also means we don't need to
  * enable the OHCI controller.
  */
+
 &ehci0 {
 	status = "okay";
 };
-- 
git-series 0.9.1
