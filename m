Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD2CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B880F20877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RnTDncWX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Uw/8vSCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B880F20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeGIKXi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:23:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60998 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932445AbeGIKXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:23:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04C2360B18; Mon,  9 Jul 2018 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531131815;
        bh=t4mIdFItCfiM8aAfZWq7h21rzjqxaDoxnSv8JG6qVT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnTDncWXAgWIGSm+lxcVD5JfFJwM3rQ0sZ5/QX7ar+C4exa2MTVXP4QN1DfGEyrce
         rfunOTYV1PDM+ipPxQC0RBQvh2zf5Q5EPRclhiquBJdHlAIT6x+SI1yQ67aF0iaY46
         mNEgze6OAXcPAmOnKDBWXxZL77pwOGovGrXNOFPI=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91C406078C;
        Mon,  9 Jul 2018 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531131814;
        bh=t4mIdFItCfiM8aAfZWq7h21rzjqxaDoxnSv8JG6qVT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uw/8vSCi8ccCRNiBttb2WkXgcXAE6x3VKjQmp+jfH7TY30UzyPM8Mf8oVEaEyF1Sc
         PhHfyAOBkI1ghd9NqTl3Bzpu76AAXgm7S6ps8Fs0lZahizAPtzAMhuExhB3DWIvMTw
         FT00U2fTd2CkNkGvnokCkP5l3JpofxWrJCVyKQ08=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91C406078C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V4 3/8] backlight: qcom-wled: Add new properties for PMI8998
Date:   Mon,  9 Jul 2018 15:52:16 +0530
Message-Id: <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the bindings with the new properties used for
PMI8998.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
Changes from V3:
	- Removed the default values.
	- Removed pmi8998 example.

 .../bindings/leds/backlight/qcom-wled.txt          | 76 ++++++++++++++++++----
 1 file changed, 62 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
index 14f28f2..3f22ced 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
@@ -20,8 +20,7 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
 - default-brightness
 	Usage:        optional
 	Value type:   <u32>
-	Definition:   brightness value on boot, value from: 0-4095
-		      Default: 2048
+	Definition:   brightness value on boot, value from: 0-4095.
 
 - label
 	Usage:        required
@@ -48,20 +47,24 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
 - qcom,current-limit
 	Usage:        optional
 	Value type:   <u32>
-	Definition:   mA; per-string current limit
-		      value: For pm8941: from 0 to 25 with 5 mA step
-			     Default 20 mA.
-			     For pmi8998: from 0 to 30 with 5 mA step
-			     Default 25 mA.
+	Definition:   mA; per-string current limit; value from 0 to 25 with
+		      1 mA step.
+		      This property is supported only for pm8941.
+
+- qcom,current-limit-microamp
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   uA; per-string current limit; value from 0 to 30000 with
+		      2500 uA step.
 
 - qcom,current-boost-limit
 	Usage:        optional
 	Value type:   <u32>
 	Definition:   mA; boost current limit.
 		      For pm8941: one of: 105, 385, 525, 805, 980, 1260, 1400,
-		      1680. Default: 805 mA
+		      1680.
 		      For pmi8998: one of: 105, 280, 450, 620, 970, 1150, 1300,
-		      1500. Default: 970 mA
+		      1500.
 
 - qcom,switching-freq
 	Usage:        optional
@@ -69,22 +72,66 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
 	 Definition:   kHz; switching frequency; one of: 600, 640, 685, 738,
 		       800, 872, 960, 1066, 1200, 1371, 1600, 1920, 2400, 3200,
 		       4800, 9600.
-		       Default: for pm8941: 1600 kHz
-				for pmi8998: 800 kHz
 
 - qcom,ovp
 	Usage:        optional
 	Value type:   <u32>
 	Definition:   V; Over-voltage protection limit; one of:
-		      27, 29, 32, 35. default: 29V
+		      27, 29, 32, 35.
 		      This property is supported only for PM8941.
 
+- qcom,ovp-millivolt
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   mV; Over-voltage protection limit;
+		      For pmi8998: one of 18100, 19600, 29600, 31100
+		      If this property is not specified for PM8941, it
+		      falls back to "qcom,ovp" property.
+
 - qcom,num-strings
 	Usage:        optional
 	Value type:   <u32>
 	Definition:   #; number of led strings attached;
-		      value from 1 to 3. default: 2
-		      This property is supported only for PM8941.
+		      value: For PM8941 from 1 to 3.
+			     For PMI8998 from 1 to 4.
+
+- interrupts
+	Usage:        optional
+	Value type:   <prop encoded array>
+	Definition:   Interrupts associated with WLED. This should be
+		      "short" and "ovp" interrupts. Interrupts can be
+		      specified as per the encoding listed under
+		      Documentation/devicetree/bindings/spmi/
+		      qcom,spmi-pmic-arb.txt.
+
+- interrupt-names
+	Usage:        optional
+	Value type:   <string>
+	Definition:   Interrupt names associated with the interrupts.
+		      Must be "short" and "ovp". The short circuit detection
+		      is not supported for PM8941.
+
+- qcom,enabled-strings
+	Usage:        optional
+	Value tyoe:   <u32 array>
+	Definition:   Array of the WLED strings numbered from 0 to 3. Each
+		      string of leds are operated individually. Specify the
+		      list of strings used by the device. Any combination of
+		      led strings can be used.
+
+- qcom,external-pfet
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   Specify if external PFET control for short circuit
+		      protection is used. This property is supported only
+		      for PMI8998.
+
+- qcom,auto-string-detection
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   Enables auto-detection of the WLED string configuration.
+		      This feature is not supported for PM8941.
+
 
 Example:
 
@@ -99,4 +146,5 @@ pm8941-wled@d800 {
 	qcom,switching-freq = <1600>;
 	qcom,ovp = <29>;
 	qcom,num-strings = <2>;
+	qcom,enabled-strings = <0x00 0x01>;
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

