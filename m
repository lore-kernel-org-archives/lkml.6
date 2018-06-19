Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504A5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004872075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cn5y3fC/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Up56Nea9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004872075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937690AbeFSLPG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:15:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936108AbeFSLPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:15:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CC4460B22; Tue, 19 Jun 2018 11:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406903;
        bh=zLzfmx6mH4nMgqEEmbVZ85m35oEf6TFlc0nMU0x9lMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cn5y3fC/Vd+9jASBmAWhXI8QyzxWq1ooV2n4TiOy/N3RoCPi+sJSK9Mo8g/3eXG7t
         RlujI8WC+8J45o5nJWx6Lrg/7XjcDp3+H/adXyMhtG/qBTxD28TddSNhvqm1soJpZR
         Lpe5/pEqRA+ujQSqqCWZBfrmxuglaqUa7NG3yjTI=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76D9460558;
        Tue, 19 Jun 2018 11:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406901;
        bh=zLzfmx6mH4nMgqEEmbVZ85m35oEf6TFlc0nMU0x9lMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Up56Nea9jMY55O+osWQgk1ndqAN0p2NluDGd03tZQ6hOSV3prn5UV6usMa3E2d7BS
         QEwGW4/Qy0VbTljAWmt0Wlk+fNwFQ6gCy7eGZXWDiViyK1I4nU+NmNE8UA7aItMcAZ
         fNywQlyfyBH/cPRlEJISz0z5EIe2Hpv8kD7f4+uc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76D9460558
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
Subject: [PATCH V3 3/7] backlight: qcom-wled: Add new properties for PMI8998
Date:   Tue, 19 Jun 2018 16:43:38 +0530
Message-Id: <1529406822-15379-4-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the bindings with the new properties used for
PMI8998.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 .../bindings/leds/backlight/qcom-wled.txt          | 84 ++++++++++++++++++++--
 1 file changed, 77 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
index 14f28f2..503ce87 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
@@ -48,11 +48,15 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
 - qcom,current-limit
 	Usage:        optional
 	Value type:   <u32>
-	Definition:   mA; per-string current limit
-		      value: For pm8941: from 0 to 25 with 5 mA step
-			     Default 20 mA.
-			     For pmi8998: from 0 to 30 with 5 mA step
-			     Default 25 mA.
+	Definition:   mA; per-string current limit; value from 0 to 25 with
+		      1 mA step. Default 20 mA.
+		      This property is supported only for pm8941.
+
+- qcom,current-limit-microamp
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   uA; per-string current limit; value from 0 to 30000 with
+		      2500 uA step. Default 25000 uA.
 
 - qcom,current-boost-limit
 	Usage:        optional
@@ -79,12 +83,61 @@ platforms. The PMIC is connected to the host processor via SPMI bus.
 		      27, 29, 32, 35. default: 29V
 		      This property is supported only for PM8941.
 
+- qcom,ovp-millivolt
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   mV; Over-voltage protection limit;
+		      For pmi8998: one of 18100, 19600, 29600, 31100
+		      Default: 29600 mV
+		      If this property is not specified for PM8941, it
+		      falls back to "qcom,ovp" property.
+
 - qcom,num-strings
 	Usage:        optional
 	Value type:   <u32>
 	Definition:   #; number of led strings attached;
-		      value from 1 to 3. default: 2
-		      This property is supported only for PM8941.
+		      value: For PM8941 from 1 to 3. default: 2
+			     For PMI8998 from 1 to 4. default: 4
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
+		      for pm8941: Default values are [00 01].
+		      for pmi8998: Default values are [00 01 02 03].
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
 
@@ -99,4 +152,21 @@ pm8941-wled@d800 {
 	qcom,switching-freq = <1600>;
 	qcom,ovp = <29>;
 	qcom,num-strings = <2>;
+	qcom,enabled-strings = <0x00 0x01>;
+};
+
+pmi8998-wled@d800 {
+	compatible = "qcom,pmi8998-wled";
+	reg = <0xd800 0xd900>;
+	label = "backlight";
+
+	interrupts = <3 0xd8 2 IRQ_TYPE_EDGE_RISING>,
+		     <3 0xd8 1 IRQ_TYPE_EDGE_RISING>;
+	interrupt-names = "short", "ovp";
+	qcom,current-limit-microamp = <25000>;
+	qcom,current-boost-limit = <805>;
+	qcom,switching-freq = <1600>;
+	qcom,ovp-millivolt = <29600>;
+	qcom,num-strings = <4>;
+	qcom,enabled-strings = <0x00 0x01 0x02 0x03>;
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

