Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB94C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C7A20676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="uCZN+Q91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C7A20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeI0GGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:06:40 -0400
Received: from onstation.org ([52.200.56.107]:46896 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeI0GGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:06:40 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 148BE1961;
        Wed, 26 Sep 2018 23:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538005875;
        bh=arYUYH37EkF9d6ga4jhX24uN13STTPPoNQBo1q2Y/dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCZN+Q91EHA4biUSjHIzWd3jKMAu7F02K7zncCz37FuSqwIisbROGKIqiq3dD08f9
         WBhawyimUqFK0RnASzkbBZ8rvI07z7nJZMwZ+JpZ90TuAxEGAQDMj6F++3muJwmfgt
         wYG5durBrjaE8wqnQ2u6sngpA5uugv/dGfvSRJFo=
From:   Brian Masney <masneyb@onstation.org>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     masneyb@onstation.org, jonathan@marek.ca, ctatlor97@gmail.com
Subject: [PATCH v2 1/3] dt-bindings: pwm: msm-vibrator: new bindings for MSM vibrator PWM
Date:   Wed, 26 Sep 2018 19:51:10 -0400
Message-Id: <20180926235112.25710-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926235112.25710-1-masneyb@onstation.org>
References: <20180926235112.25710-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings for the vibrator PWM found on
various Qualcomm MSM SOCs.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../bindings/pwm/pwm-msm-vibrator.txt         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt b/Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt
new file mode 100644
index 000000000000..44bb8b979c60
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt
@@ -0,0 +1,38 @@
+* Device tree bindings for the vibrator PWM on various MSM SOCs.
+
+Required properties:
+
+  - compatible: Should be one of
+		"qcom,msm8226-pwm-vibrator"
+		"qcom,msm8974-pwm-vibrator"
+  - reg: the base address and length of the IO memory for the registers.
+  - #pwm-cells: set to 3.
+  - pinctrl-names: set to default.
+  - pinctrl-0: phandles pointing to pin configuration nodes. See
+               Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+  - clock-names: set to pwm
+  - clocks: phandle of the clock used by the PWM module. See
+            Documentation/devicetree/bindings/clock/clock-bindings.txt
+  - enable-gpios: GPIO that enables the PWM.
+
+Optional properties:
+
+  - vcc-supply: phandle to the regulator that provides power to the sensor.
+
+Example from a LG Nexus 5 (hammerhead) phone:
+
+msm_pwm_vibrator_enable: pwm@fd8c3450 {
+	reg = <0xfd8c3450 0x400>;
+	compatible = "qcom,msm8974-pwm-vibrator";
+	#pwm-cells = <3>;
+
+	vcc-supply = <&pm8941_l19>;
+
+	clocks = <&mmcc CAMSS_GP1_CLK>;
+	clock-names = "pwm";
+
+	enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&vibrator_pin>;
+};
-- 
2.17.1

