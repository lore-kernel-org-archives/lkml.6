Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0328D2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="D5x672NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0328D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeGQJNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:13:40 -0400
Received: from onstation.org ([52.200.56.107]:58362 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbeGQJNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:13:39 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A6BC81A54;
        Tue, 17 Jul 2018 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531816928;
        bh=XLErcqMtn4szdvw487CA4i02dUnD1C8TDnfA0Jm7RsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5x672NP+EBun2w+/N7UByP3+h1cMK3kp8eTEmvmjKhW0pP8pZKwpqs2McQTdNRvr
         sruGuD6jPFd9+jydrPuxpcepXQKgY99fcfL5yPxKPI6YHJS5kM4FhEZNe5SnFhm9gO
         6XmmYp64QfpmrKmktpxRbJP3ziGcAhzEwnfVoUAU=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: [PATCH v2 7/7] ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for ALS / proximity
Date:   Tue, 17 Jul 2018 04:41:58 -0400
Message-Id: <20180717084158.23532-8-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717084158.23532-1-masneyb@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree bindings for the tsl2772 ALS / proximity
sensor for the LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 27 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 928affae1885..63c09e2a2eb2 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -3,6 +3,7 @@
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/iio/amstaos,tsl2772.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
@@ -242,6 +243,15 @@
 			};
 		};
 
+		i2c3_pins: i2c3 {
+			mux {
+				pins = "gpio10", "gpio11";
+				function = "blsp_i2c3";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
 		i2c12_pins: i2c12 {
 			mux {
 				pins = "gpio87", "gpio88";
@@ -333,6 +343,23 @@
 			};
 		};
 	};
+
+	i2c@f9925000 {
+		status = "ok";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_pins>;
+		clock-frequency = <100000>;
+		qcom,src-freq = <50000000>;
+
+		avago_apds993@39 {
+			compatible = "avago,apds9930";
+			reg = <0x39>;
+			interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+			vdd-supply = <&pm8941_l17>;
+			vddio-supply = <&pm8941_lvs1>;
+			amstaos,prox_diode = <TSL2772_DIODE0>;
+		};
+	};
 };
 
 &spmi_bus {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index cebb6ae9143a..6dcf2bee66fb 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -713,6 +713,17 @@
 			#size-cells = <0>;
 		};
 
+		blsp_i2c3: i2c@f9925000 {
+			status = "disabled";
+			compatible = "qcom,i2c-qup-v2.1.1";
+			reg = <0xf9925000 0x1000>;
+			interrupts = <0 97 IRQ_TYPE_NONE>;
+			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		blsp_i2c8: i2c@f9964000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
-- 
2.17.1

