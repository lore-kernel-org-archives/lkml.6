Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4650C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A722150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A722150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbeISSXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:23:32 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:39113 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbeISSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:23:32 -0400
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="20156471"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Sep 2018 05:45:45 -0700
Received: from eh-station.microchip.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 19 Sep 2018 05:45:44 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <ludovic.desroches@microchip.com>
CC:     <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d27_som1_ek: add adc regulators
Date:   Wed, 19 Sep 2018 15:39:53 +0300
Message-ID: <1537360793-10264-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fixed regulators for the ADC. This board does not have
a programmable PMIC, but fixed regulators.
Adding them to DT so the ADC can probe correctly.

Tested-by: Swapna Gurumani <swapna.gurumani@microchip.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index e86e0c0..363a43d 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -283,6 +283,13 @@
 				status = "okay";
 			};
 
+			adc: adc@fc030000 {
+				vddana-supply = <&vddana>;
+				vref-supply = <&advref>;
+
+				status = "disabled";
+			};
+
 			pinctrl@fc038000 {
 
 				pinctrl_can1_default: can1_default {
@@ -549,4 +556,39 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	vddin_3v3: fixed-regulator-vddin_3v3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDDIN_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		status = "okay";
+	};
+
+	vddana: fixed-regulator-vddana {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDDANA";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vddin_3v3>;
+		status = "okay";
+	};
+
+	advref: fixed-regulator-advref {
+		compatible = "regulator-fixed";
+
+		regulator-name = "advref";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vddana>;
+		status = "okay";
+	};
 };
-- 
2.7.4

