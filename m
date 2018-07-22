Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA0DECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5549820850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5549820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbeGVWSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:18:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38668 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730261AbeGVWSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93A2DADDF;
        Sun, 22 Jul 2018 21:20:18 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        James Hartley <james.hartley@sondrel.com>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 01/15] MIPS: dts: img: pistachio_marduk: Reorder nodes
Date:   Sun, 22 Jul 2018 23:19:56 +0200
Message-Id: <20180722212010.3979-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistently order nodes referenced by label alphabetically.
No functional changes. This prepares for adding nodes.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/mips/boot/dts/img/pistachio_marduk.dts | 76 ++++++++++++++---------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
index cf9cebd52294..f03f4114e645 100644
--- a/arch/mips/boot/dts/img/pistachio_marduk.dts
+++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
@@ -74,40 +74,34 @@
 	};
 };
 
-&internal_dac {
-	VDD-supply = <&internal_dac_supply>;
-};
-
-&spfi1 {
+&adc {
 	status = "okay";
-
-	pinctrl-0 = <&spim1_pins>, <&spim1_quad_pins>, <&spim1_cs0_pin>,
-		    <&spim1_cs1_pin>;
-	pinctrl-names = "default";
-	cs-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>, <&gpio0 1 GPIO_ACTIVE_HIGH>;
-
-	flash@0 {
-		compatible = "spansion,s25fl016k", "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <50000000>;
-	};
+	vref-supply = <&reg_1v8>;
+	adc-reserved-channels = <0x10>;
 };
 
-&uart0 {
+&enet {
 	status = "okay";
-	assigned-clock-rates = <114278400>, <1843200>;
 };
 
-&uart1 {
+&i2c2 {
 	status = "okay";
+	clock-frequency = <400000>;
+
+	tpm@20 {
+		compatible = "infineon,slb9645tt";
+		reg = <0x20>;
+	};
+
 };
 
-&usb {
+&i2c3 {
 	status = "okay";
+	clock-frequency = <400000>;
 };
 
-&enet {
-	status = "okay";
+&internal_dac {
+	VDD-supply = <&internal_dac_supply>;
 };
 
 &pin_enet {
@@ -118,12 +112,6 @@
 	drive-strength = <2>;
 };
 
-&sdhost {
-	status = "okay";
-	bus-width = <4>;
-	disable-wp;
-};
-
 &pin_sdhost_cmd {
 	drive-strength = <2>;
 };
@@ -140,24 +128,36 @@
 	pinctrl-names = "default";
 };
 
-&adc {
+&sdhost {
 	status = "okay";
-	vref-supply = <&reg_1v8>;
-	adc-reserved-channels = <0x10>;
+	bus-width = <4>;
+	disable-wp;
 };
 
-&i2c2 {
+&spfi1 {
 	status = "okay";
-	clock-frequency = <400000>;
 
-	tpm@20 {
-		compatible = "infineon,slb9645tt";
-		reg = <0x20>;
+	pinctrl-0 = <&spim1_pins>, <&spim1_quad_pins>, <&spim1_cs0_pin>,
+		    <&spim1_cs1_pin>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>, <&gpio0 1 GPIO_ACTIVE_HIGH>;
+
+	flash@0 {
+		compatible = "spansion,s25fl016k", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
 	};
+};
 
+&uart0 {
+	status = "okay";
+	assigned-clock-rates = <114278400>, <1843200>;
 };
 
-&i2c3 {
+&uart1 {
+	status = "okay";
+};
+
+&usb {
 	status = "okay";
-	clock-frequency = <400000>;
 };
-- 
2.16.4

