Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEC5C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6DB20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPorLxcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6DB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeILMdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:33:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35480 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:33:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so580380pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6a2K6qNZh60/sMvmbkck3n+/n6PkI3DTt1DQ2AdQSgY=;
        b=iPorLxcRqqnX36iDXtgmi7Uj/mY/V2wO58pdn9ts1QvQjMjGFgApquqSnqj+VJxtXQ
         Ye20L4jSxMA9Z1wn9zN9gg+jkhKpwm0tgxSy2TOM7On5c19ONvuisZCXAnqL9De6jocQ
         Bqafvr3uG2rdZTUHJ31dTxvL7XysfnQUMSH0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6a2K6qNZh60/sMvmbkck3n+/n6PkI3DTt1DQ2AdQSgY=;
        b=tgdxWLsA6M1tyZe/ra4sATbeRlAaYMm6orACkhJfG/pazR/6j07ekQ2ZnopF/ApIzR
         8h0m0iMSyNM8iySallLQAnlJbQr7hsmE7FFPKdU7HN1x69mJ51Q2FV3omAQoA8XxeK6o
         JvvmQ9+xdmPQcJsTPT68zhmALG3vlZy6MaMxECUIoaS1Hp7WdYRg0Bf+liqT43sdXvnD
         qJgJoOajbCXDI2iLNbUAJYtZZom1r46G16cl9WVQzj+7se63Mfj6f2Sqvg8vbtsga72i
         UnhRcrMK5fwrvGp9A3dxD9G9DkP/cDFy99MNdg9fQhYvIk9iYjShRT6aJSAhosdBIjZr
         cpAA==
X-Gm-Message-State: APzg51BZzG6GTUmtp6uJgKy1e0cO76013tKQR6oOzUVN/uD9YlmJ0fjZ
        EXY4CtRI+IbPFr4+pzUAd/E+ow==
X-Google-Smtp-Source: ANB0VdYV65omcXOQ4TkODt9E9TqncsJkdfLEIppG0ahYeQgjrOIHvmXyv0ysdW5LPiMmyviTy39igA==
X-Received: by 2002:a63:221b:: with SMTP id i27-v6mr629030pgi.212.1536737417455;
        Wed, 12 Sep 2018 00:30:17 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y69-v6sm624695pfd.36.2018.09.12.00.30.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 00:30:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge unit documentation
Date:   Wed, 12 Sep 2018 15:29:38 +0800
Message-Id: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
fuel gauge unit device, which is used to calculate the battery capacity.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |   55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
new file mode 100644
index 0000000..7447bae
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -0,0 +1,55 @@
+Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
+
+Required properties:
+- compatible: Should be one of the following:
+  "sprd,sc2720-fgu",
+  "sprd,sc2721-fgu",
+  "sprd,sc2723-fgu",
+  "sprd,sc2730-fgu",
+  "sprd,sc2731-fgu".
+- reg: The address offset of fuel gauge unit.
+- bat-detect-gpio: GPIO for battery detection.
+- io-channels: Specify the IIO ADC channel to get temperature.
+- io-channel-names: Should be "bat-temp".
+- sprd,inner-resist: Specify the the battery inner resistance (mOhm).
+- sprd,ocv-cap-table: Provide the battery capacity percent with corresponding
+  open circuit voltage (ocv) of the battery, which is used to look up current
+  battery capacity according to current baterry ocv values.
+- monitored-battery: Phandle of battery characteristics devicetree node.
+  The fuel gauge uses the following battery properties:
+- charge-full-design-microamp-hours: battery design capacity.
+- constant-charge-voltage-max-microvolt: maximum constant input voltage.
+  See Documentation/devicetree/bindings/power/supply/battery.txt
+
+Example:
+
+	bat: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <1900000>;
+		constant-charge-voltage-max-microvolt = <4350000>;
+		......
+	};
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fgu@a00 {
+			compatible = "sprd,sc2731-fgu";
+			reg = <0xa00>;
+			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+			io-channels = <&pmic_adc 5>;
+			io-channel-names = "bat-temp";
+			sprd,inner-resist = <250>;
+			sprd,ocv-cap-table = <4185 100>, <4113 95>, <4066 90>, <4022 85>, <3983 80>, <3949 75>, <3917 70>,
+				<3889 65>, <3864 60>, <3835 55>, <3805 50>, <3787 45>, <3777 40>, <3773 35>, <3770 30>,
+				<3765 25>, <3752 20>, <3724 15>, <3680 10>, <3605 5>, <3400 0>;
+			monitored-battery = <&bat>;
+		};
+	};
-- 
1.7.9.5

