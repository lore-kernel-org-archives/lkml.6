Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7702DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4053E2184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfBFDcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:32:48 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33792 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfBFDcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:32:47 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id A783E5FD06; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 3/9] ARM: dts: sun9i: a80-optimus: Add GPIO pin-bank regulator supplies
Date:   Wed,  6 Feb 2019 11:32:33 +0800
Message-Id: <20190206033239.3619-4-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A80 Optimus has the PMIC providing voltage to all the pin-bank
supply rails from its various regulator outputs. All pin-banks that
have supply rails are accounted for. PN pin-bank does not have a
supply rail.

Also remove any "regulator-always-on" properties from regulators that
were only marked to provide pin-bank power.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 1ee2792b3a27..9c25176e69dc 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -172,10 +172,26 @@
 	clocks = <&ac100_rtc 0>;
 };
 
+&pio {
+	vcc-pa-supply = <&reg_ldo_io1>;
+	vcc-pb-supply = <&reg_aldo2>;
+	vcc-pc-supply = <&reg_dcdc1>;
+	vcc-pd-supply = <&reg_dcdc1>;
+	vcc-pe-supply = <&reg_eldo2>;
+	vcc-pf-supply = <&reg_dcdc1>;
+	vcc-pg-supply = <&reg_ldo_io0>;
+	vcc-ph-supply = <&reg_dcdc1>;
+};
+
 &r_ir {
 	status = "okay";
 };
 
+&r_pio {
+	vcc-pl-supply = <&reg_dldo2>;
+	vcc-pm-supply = <&reg_eldo3>;
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -264,7 +280,6 @@
 			};
 
 			reg_dldo2: dldo2 {
-				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-name = "vcc-pl";
@@ -283,14 +298,12 @@
 			};
 
 			reg_eldo3: eldo3 {
-				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-name = "vcc-pm-codec-io1";
 			};
 
 			reg_ldo_io0: ldo_io0 {
-				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-name = "vcc-pg";
-- 
2.20.1

