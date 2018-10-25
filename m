Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE392ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F74820832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="koAvXDre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F74820832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeJYKAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:00:19 -0400
Received: from onstation.org ([52.200.56.107]:46308 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbeJYKAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:00:18 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 7A959991;
        Thu, 25 Oct 2018 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1540430988;
        bh=lJwE9ymz86PqtBWUJqWMXmN16Sjz+LGl4mG6Sg7ckIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koAvXDrePiuCxauzhaGAmEDvw2kO4c6QN7RX6wCR0wT5ao6By1xHeNqKaab5fom+Y
         HgIbOL/Vq0Zb8L3fuoUmqgOD/Kluvb2ZbBUkkO6FIf7P0GGPQ34ZERdYQeTUC0PxyE
         rO8qHoTRX6WRV78xuvU1p6G/R8LL0WaeNSfdtjXM=
From:   Brian Masney <masneyb@onstation.org>
To:     dmitry.torokhov@gmail.com, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, masneyb@onstation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH v3 1/3] dt-bindings: Input: new bindings for MSM vibrator
Date:   Wed, 24 Oct 2018 21:29:35 -0400
Message-Id: <20181025012937.2154-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181025012937.2154-1-masneyb@onstation.org>
References: <20181025012937.2154-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings for the vibrator found on
various Qualcomm MSM SOCs.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../bindings/input/msm-vibrator.txt           | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/msm-vibrator.txt

diff --git a/Documentation/devicetree/bindings/input/msm-vibrator.txt b/Documentation/devicetree/bindings/input/msm-vibrator.txt
new file mode 100644
index 000000000000..8dcf014ef2e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/msm-vibrator.txt
@@ -0,0 +1,36 @@
+* Device tree bindings for the Qualcomm MSM vibrator
+
+Required properties:
+
+  - compatible: Should be one of
+		"qcom,msm8226-vibrator"
+		"qcom,msm8974-vibrator"
+  - reg: the base address and length of the IO memory for the registers.
+  - pinctrl-names: set to default.
+  - pinctrl-0: phandles pointing to pin configuration nodes. See
+               Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+  - clock-names: set to pwm
+  - clocks: phandle of the clock. See
+            Documentation/devicetree/bindings/clock/clock-bindings.txt
+  - enable-gpios: GPIO that enables the vibrator.
+
+Optional properties:
+
+  - vcc-supply: phandle to the regulator that provides power to the sensor.
+
+Example from a LG Nexus 5 (hammerhead) phone:
+
+vibrator@fd8c3450 {
+	reg = <0xfd8c3450 0x400>;
+	compatible = "qcom,msm8974-vibrator";
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
2.17.2

