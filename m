Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5C7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B33521568
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="qaiiTuL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B33521568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeI0GGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:06:45 -0400
Received: from onstation.org ([52.200.56.107]:46912 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeI0GGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:06:41 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2435F1A5D;
        Wed, 26 Sep 2018 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538005876;
        bh=AbijTUlqJEINkKBnFEwxoR55EO04oXxqQCEAq2xE4Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qaiiTuL8uM+2h+hEWg1yV9rcMO7mlG4BSoWLhOXbyi0SH6/76BrcwqOsOmjkYlpMa
         DPb1B2GIuQYvIt6SmH3IL+FgsI0kA6+M3ai5oziwjUCJnV3MoOzX63olRgnJi3kcTJ
         CG8sIQbmTc0V9kmBAdPxR9tC2Yqd5xVnNzOdNmFQ=
From:   Brian Masney <masneyb@onstation.org>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     masneyb@onstation.org, jonathan@marek.ca, ctatlor97@gmail.com
Subject: [PATCH v2 3/3] ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for vibrator
Date:   Wed, 26 Sep 2018 19:51:12 -0400
Message-Id: <20180926235112.25710-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926235112.25710-1-masneyb@onstation.org>
References: <20180926235112.25710-1-masneyb@onstation.org>
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
index ed8f064d0895..e67d61f25a96 100644
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
+	msm_pwm_vibrator_enable: pwm@fd8c3450 {
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

