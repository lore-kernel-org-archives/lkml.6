Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF083ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB7F20832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Kvpnwl9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB7F20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJYKAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:00:19 -0400
Received: from onstation.org ([52.200.56.107]:46332 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeJYKAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:00:19 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 805401A6F;
        Thu, 25 Oct 2018 01:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1540430989;
        bh=o0MTDFdq63z91RO9TQSGYBrk3lFFsq/DVq2WVA+pFjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kvpnwl9nmCt4WzPfEWhqN/W4QuUgNg52IUBCR7mOU5ClZp9AsPbWnMOWkDYwQI2/J
         mY5R6hzq/cRKEcWXquHSKhDx8mpDDC35DCmQeC2sodjeeHHZLBf3Bjz/D1tkPqn21s
         ddZ3BZdOlj/BTSvW63ZAV0+hZb0FSa/Ul1NGTvEk=
From:   Brian Masney <masneyb@onstation.org>
To:     dmitry.torokhov@gmail.com, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, masneyb@onstation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH v3 3/3] ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for vibrator
Date:   Wed, 24 Oct 2018 21:29:37 -0400
Message-Id: <20181025012937.2154-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181025012937.2154-1-masneyb@onstation.org>
References: <20181025012937.2154-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device device tree bindings for the vibrator found on
the LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index ed8f064d0895..de956eea31ac 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -5,6 +5,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/clock/qcom,mmcc-msm8974.h>
 
 / {
 	model = "LGE MSM 8974 HAMMERHEAD";
@@ -268,6 +269,36 @@
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
+	vibrator@fd8c3450 {
+		compatible = "qcom,msm8974-vibrator";
+		reg = <0xfd8c3450 0x400>;
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
 	};
 
 	sdhci@f9824900 {
-- 
2.17.2

