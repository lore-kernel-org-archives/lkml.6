Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D35C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEF2217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfBEPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:00:58 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33604 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbfBEPAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:00:52 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 3B3555F92C; Tue,  5 Feb 2019 23:00:47 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 2/2] arm64: dts: allwinner: a64: Enable PMIC power supplies on various boards
Date:   Tue,  5 Feb 2019 23:00:40 +0800
Message-Id: <20190205150040.12343-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205150040.12343-1-wens@csie.org>
References: <20190205150040.12343-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On these A64 devices, the DC input jacks are wired to the ACIN pins of
the PMIC, which is represented by the AC power supply. With the
exception of the Nanopi A64, all devices include LiPo batteries or have
connectors for them, which are represented by the battery power supply.

Enable these power supplies in the device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 8 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 8 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 8 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       | 8 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts      | 8 ++++++++
 6 files changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 9d0afd7d50ec..7793ebb5d2b8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -222,6 +222,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	/*
 	 * This regulator also drives the PE pingroup GPIOs,
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 31884dbc8838..f4e78531f639 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -186,6 +186,10 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1800000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index f7a4bccaa5d4..01a9a52edae4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -177,6 +177,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <2800000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 8974b5a1d3b1..510f661229dc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -194,6 +194,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 216f2f5db5ef..c0b9cc7a6b3a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -169,6 +169,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1800000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index f9eede0a8bd3..7b7b14ba58e6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -145,6 +145,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <2800000>;
-- 
2.20.1

