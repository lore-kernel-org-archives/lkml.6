Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB69ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA642098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="XvLdQhTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA642098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbeISUsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:48:13 -0400
Received: from onstation.org ([52.200.56.107]:45548 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731253AbeISUsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:48:02 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 0ECD21A6F;
        Wed, 19 Sep 2018 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1537369780;
        bh=NqPYWbDGuUG8FDP3Q5nP6D0UIg/fee/Vm4/o5PJY7tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvLdQhTTh6VGJb9BD53pXxxAtHxjL+Rot8m6NvzhMoY67Vrg2xoZ/PysB1GdmKTxX
         DmNiA3Mpf9SimbFKswIxhDAmMl3mqZDToo3W4o4J3bwuoCu+6l5ob15XplAQISLgF6
         GWSlrSS3g8RLlbyT3PjHyMY1pGYggVVNQZy88juM=
From:   Brian Masney <masneyb@onstation.org>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sebastian.reichel@collabora.co.uk, masneyb@onstation.org
Subject: [PATCH 3/3] ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for vibrator
Date:   Wed, 19 Sep 2018 11:09:12 -0400
Message-Id: <20180919150912.8948-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919150912.8948-1-masneyb@onstation.org>
References: <20180919150912.8948-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device device tree bindings for the vibrator found on
the LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index ed8f064d0895..e738a472cb99 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -5,6 +5,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/clock/qcom,mmcc-msm8974.h>
 
 / {
 	model = "LGE MSM 8974 HAMMERHEAD";
@@ -268,6 +269,44 @@
 				input-enable;
 			};
 		};
+
+		vibrator_pin: vibrator {
+			pwm {
+				pins = "gpio27";
+				function = "gp1_clk";
+
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			enable {
+				pins = "gpio60";
+				function = "gpio";
+			};
+		};
+	};
+
+	msm_pwm_vibrator_enable: msm_pwm_vibrator@fd8c3450 {
+		compatible = "qcom,msm8974-pwm-vibrator";
+		reg = <0xfd8c3450 0x400>;
+		#pwm-cells = <3>;
+
+		vcc-supply = <&pm8941_l19>;
+
+		clocks = <&mmcc CAMSS_GP1_CLK>;
+		clock-names = "pwm";
+
+		enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vibrator_pin>;
+	};
+
+	vibrator {
+		compatible = "pwm-vibrator";
+
+		pwms = <&msm_pwm_vibrator_enable 0 1000000000 0>;
+		pwm-names = "enable";
 	};
 
 	sdhci@f9824900 {
-- 
2.17.1

