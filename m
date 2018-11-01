Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94373C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691AE20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691AE20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeKBFHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:07:18 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:46046 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeKBFHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:07:18 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 42822BFA47;
        Thu,  1 Nov 2018 21:02:50 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id B023AC1084; Thu,  1 Nov 2018 21:02:49 +0100 (CET)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 6FE77C105C;
        Thu,  1 Nov 2018 21:00:35 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH NOT FOR MERGE v2 7/7] ARM: dts: sun7i-a20-bananapi: Add bindings for the LeMaker 3.5" LCD
Date:   Thu,  1 Nov 2018 21:00:45 +0100
Message-Id: <20181101200045.6078-8-contact@paulk.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101200045.6078-1-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the backlight panel, power, pwm and tcon0 device-tree bindings
required for supporting the 3.5" LCD from LeMaker on the BananaPi M1.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 89 ++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 70dfc4ac0bb5..dd2f8bc41fae 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -48,6 +48,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "LeMaker Banana Pi";
@@ -63,6 +64,75 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 0>;
+		brightness-levels = <  0   1   1   1   1   2   2   2
+				       2   3   3   3   3   4   4   4
+				       5   5   5   6   6   6   7   7
+				       8   8   8   9   9   9  10  10
+				      10  11  11  12  12  12  13  13
+				      14  14  14  15  15  16  16  17
+				      17  17  18  18  19  19  20  20
+				      21  21  21  22  22  23  23  24
+				      24  25  25  26  26  27  27  28
+				      28  29  30  30  31  31  32  32
+				      33  33  34  35  35  36  36  37
+				      38  38  39  39  40  41  41  42
+				      43  43  44  44  45  46  47  47
+				      48  49  49  50  51  51  52  53
+				      54  54  55  56  57  57  58  59
+				      60  61  61  62  63  64  65  65
+				      66  67  68  69  70  71  71  72
+				      73  74  75  76  77  78  79  80
+				      81  82  83  84  85  86  87  88
+				      89  90  91  92  93  94  95  96
+				      97  98  99 101 102 103 104 105
+				     106 108 109 110 111 112 114 115
+				     116 117 119 120 121 123 124 125
+				     127 128 129 131 132 133 135 136
+				     138 139 141 142 144 145 147 148
+				     150 151 153 154 156 157 159 161
+				     162 164 166 167 169 171 173 174
+				     176 178 180 181 183 185 187 189
+				     191 192 194 196 198 200 202 204
+				     206 208 210 212 214 216 219 221
+				     223 225 227 229 232 234 236 238
+				     241 242 244 246 248 250 253 255>;
+		default-brightness-level = <128>;
+		enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+	};
+
+	panel: panel {
+		compatible = "lemaker,bl035";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-supply = <&panel_power>;
+		backlight = <&backlight>;
+
+		port@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_out_panel>;
+			};
+		};
+	};
+
+	panel_power: panel_power {
+		compatible = "regulator-fixed";
+		regulator-name = "panel-power";
+		regulator-min-microvolt = <10400000>;
+		regulator-max-microvolt = <10400000>;
+		gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
+		enable-active-high;
+		regulator-boot-on;
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -275,6 +345,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>;
+	status = "okay";
+};
+
 #include "axp209.dtsi"
 
 &reg_dcdc2 {
@@ -322,6 +398,19 @@
 	status = "okay";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd0_rgb888_pins>;
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_panel: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.19.1

