Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F617C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466572075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XMOrpeRS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P2hRHnsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466572075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966150AbeFSLO6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:14:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965953AbeFSLO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:14:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C81360B10; Tue, 19 Jun 2018 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406896;
        bh=mWuQNdeQsmMXzrTqZzR7YbnrcSLboivWF595/toZotU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMOrpeRSIJTpEaml6f2n1rG+B/pMHJd8g31bjMAtP6xsH//gr61zZefJFc3w6pIRN
         GLRaoByw0V4iPNIXu1F6iFTVQXGL+ZH0SG7nrUPIF8dcY9iDKYujufWSjZpF3XeONO
         tCpNzuj4En9f+j+e8QzsZa/gf/d9fdAhWBCDYh2g=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C183960558;
        Tue, 19 Jun 2018 11:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406894;
        bh=mWuQNdeQsmMXzrTqZzR7YbnrcSLboivWF595/toZotU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2hRHnsKED4bQt2WUs/8qBqSK2lnl42lWtM2TtSTzDEJOPTerTne6SbsvgzMTy3DI
         gKYebqpz/uQcIXgYPT5k49RAagjr+C9rtqIHItorvDr0MqO8but9wlQeEeWjKM9QNC
         vd2pBgXiJr8FQIjmdeGBXFUAyWqZfRLGdKBZcqA0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C183960558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V3 2/7] backlight: qcom-wled: restructure the qcom-wled bindings
Date:   Tue, 19 Jun 2018 16:43:37 +0530
Message-Id: <1529406822-15379-3-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restructure the qcom-wled bindings for the better readability.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 .../bindings/leds/backlight/qcom-wled.txt          | 110 ++++++++++++++++-----
 1 file changed, 85 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
index fb39e32..14f28f2 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
@@ -1,30 +1,90 @@
 Binding for Qualcomm Technologies, Inc. WLED driver
 
-Required properties:
-- compatible: should be "qcom,pm8941-wled"
-- reg: slave address
-
-Optional properties:
-- default-brightness: brightness value on boot, value from: 0-4095
-	default: 2048
-- label: The name of the backlight device
-- qcom,cs-out: bool; enable current sink output
-- qcom,cabc: bool; enable content adaptive backlight control
-- qcom,ext-gen: bool; use externally generated modulator signal to dim
-- qcom,current-limit: mA; per-string current limit; value from 0 to 25
-	default: 20mA
-- qcom,current-boost-limit: mA; boost current limit; one of:
-	105, 385, 525, 805, 980, 1260, 1400, 1680
-	default: 805mA
-- qcom,switching-freq: kHz; switching frequency; one of:
-	600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371,
-	1600, 1920, 2400, 3200, 4800, 9600,
-	default: 1600kHz
-- qcom,ovp: V; Over-voltage protection limit; one of:
-	27, 29, 32, 35
-	default: 29V
-- qcom,num-strings: #; number of led strings attached; value from 1 to 3
-	default: 2
+WLED (White Light Emitting Diode) driver is used for controlling display
+backlight that is part of PMIC on Qualcomm Technologies, Inc. reference
+platforms. The PMIC is connected to the host processor via SPMI bus.
+
+- compatible
+	Usage:        required
+	Value type:   <string>
+	Definition:   should be one of:
+			"qcom,pm8941-wled"
+			"qcom,pmi8998-wled"
+			"qcom,pm660l-wled"
+
+- reg
+	Usage:        required
+	Value type:   <prop encoded array>
+	Definition:   Base address of the WLED modules.
+
+- default-brightness
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   brightness value on boot, value from: 0-4095
+		      Default: 2048
+
+- label
+	Usage:        required
+	Value type:   <string>
+	Definition:   The name of the backlight device
+
+- qcom,cs-out
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   enable current sink output.
+		      This property is supported only for PM8941.
+
+- qcom,cabc
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   enable content adaptive backlight control.
+
+- qcom,ext-gen
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   use externally generated modulator signal to dim.
+		      This property is supported only for PM8941.
+
+- qcom,current-limit
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   mA; per-string current limit
+		      value: For pm8941: from 0 to 25 with 5 mA step
+			     Default 20 mA.
+			     For pmi8998: from 0 to 30 with 5 mA step
+			     Default 25 mA.
+
+- qcom,current-boost-limit
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   mA; boost current limit.
+		      For pm8941: one of: 105, 385, 525, 805, 980, 1260, 1400,
+		      1680. Default: 805 mA
+		      For pmi8998: one of: 105, 280, 450, 620, 970, 1150, 1300,
+		      1500. Default: 970 mA
+
+- qcom,switching-freq
+	Usage:        optional
+	Value type:   <u32>
+	 Definition:   kHz; switching frequency; one of: 600, 640, 685, 738,
+		       800, 872, 960, 1066, 1200, 1371, 1600, 1920, 2400, 3200,
+		       4800, 9600.
+		       Default: for pm8941: 1600 kHz
+				for pmi8998: 800 kHz
+
+- qcom,ovp
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   V; Over-voltage protection limit; one of:
+		      27, 29, 32, 35. default: 29V
+		      This property is supported only for PM8941.
+
+- qcom,num-strings
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   #; number of led strings attached;
+		      value from 1 to 3. default: 2
+		      This property is supported only for PM8941.
 
 Example:
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

