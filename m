Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEEAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2632192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436755AbfBOLvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:51:09 -0500
Received: from olimex.com ([184.105.72.32]:60368 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394552AbfBOLvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:51:09 -0500
Received: from localhost.localdomain ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 03:50:57 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC
        DEVICE DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v2 7/8] ARM: dts: sun7i: Enable AXP209 CHGLED for Olimex boards
Date:   Fri, 15 Feb 2019 13:50:12 +0200
Message-Id: <20190215115013.11098-8-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215115013.11098-1-stefan@olimex.com>
References: <20190215115013.11098-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olimex A20-OLinuXino based boards (MICRO, SOM, SOM204, LIME2)
commes with populated LED connected to AXP209.

By default the LED is controlled by AXP209, so this binding
actually doesn't modify any registers. However this can can be
used as general purpose LED, if the control mode is overridden.

Also this binding is enabled only for OLIMEX boards, since I have
no knowlegde if the other manifactures are populating this LED.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts    | 6 ++++++
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts | 6 ++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts   | 6 ++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts   | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index f0e6a96e5785..677ee1c2795a 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -243,6 +243,12 @@
 
 #include "axp209.dtsi"
 
+&axp_led {
+	label = "a20-olimex-som-evb:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
index 823aabce0462..31a3ab5ad4e3 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
@@ -205,6 +205,12 @@
 	status = "okay";
 };
 
+&axp_led {
+	label = "a20-som204-evb:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &battery_power_supply {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 4e1c590eb098..66dd80ced1fa 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -200,6 +200,12 @@
 
 #include "axp209.dtsi"
 
+&axp_led {
+	label = "a20-olinuxino-lime2:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 840ae1194a66..700de909eb49 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -272,6 +272,12 @@
 	status = "okay";
 };
 
+&axp_led {
+	label = "a20-olinuxino-micro:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &battery_power_supply {
 	status = "okay";
 };
-- 
2.17.1

