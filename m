Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B5CC04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F6D20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F6D20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbeKTRUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:20:53 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47680 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbeKTRUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:20:53 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 84BE65FCA7; Tue, 20 Nov 2018 14:53:16 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 2/3] arm64: dts: allwinner: h6: orangepi: Enable USB 2.0 host and OTG ports
Date:   Tue, 20 Nov 2018 14:53:10 +0800
Message-Id: <20181120065311.30009-3-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120065311.30009-1-wens@csie.org>
References: <20181120065311.30009-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Orange Pi Lite 2 and Orange Pi One Plus share the same design for
their USB 2.0 ports. VBUS is directly tied to the board wide 5V rail,
which is also directly tied to the DC jack. There is no current limiting
in this design.

This patch enables all the USB 2.0 related device nodes, and sets the
VBUS regulator supplies and OTG ID detection GPIO.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index f910d5eb9267..f16b7ffbe797 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -32,6 +32,14 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -41,6 +49,14 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
 &r_i2c {
 	status = "okay";
 
@@ -165,3 +181,15 @@
 	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
+
+&usb2otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb2phy {
+	usb0_id_det-gpios = <&pio 2 6 GPIO_ACTIVE_HIGH>; /* PC6 */
+	usb0_vbus-supply = <&reg_vcc5v>;
+	usb3_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
-- 
2.19.1

