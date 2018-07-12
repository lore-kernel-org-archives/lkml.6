Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A379C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CD720883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpPlh2nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CD720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeGLIsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:48:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41369 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732508AbeGLIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:48:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so14267335wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Z/Epa84MInFKAspg0c1M9qw1LPPX0QzXvaRtMaKoXvI=;
        b=XpPlh2nmPQe9Q1iTS+L3nE04p1J3EeifQ+V0qTbLqfghrjK2wryGCzAzc9wtDIJc6+
         +z8k+XImaeGz7SnyswlG4azQ3HB20Hw/zigxdcvDZw0W2XZ5Sc27tn87ZOXhbhATbn2H
         4auyTxKM3TkZWTT9tYjkyyMdIflDwYzxekBtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Z/Epa84MInFKAspg0c1M9qw1LPPX0QzXvaRtMaKoXvI=;
        b=dMKnJStmjaEWGV6BlQBmTfaemWp7GF3KZ9AKHLY+r0gFq1KTdI+1Q1lWGh3o5N0K6a
         KICjMaPw7/fGSHIYel94zrtVanuhZ/CpN/9dY1+RL6RQNTrpnupumC7U2xvMbLds3kA7
         6XuaiFA5bM+wag4UhrCODziKIqAiYiEVa3gFp+huwlKwwrsO1Ga5j9U9AvUOyeVwbcEA
         yrFDGW0xHIdhX0/0o3KLmYxyzgTyJ87yL0ojWUAwXGLcUv0UGKjPCk+BfbujTJYvMR4P
         F8R+8io2/3rzUeOMf3JicuPwTffuqVTpBP/xSD5RxjmSfveNigFZ4T6n3P1tvc3eRUsg
         GMYg==
X-Gm-Message-State: AOUpUlEkfbbrL7lWhfBxKm3zyIhQ2PtpocyLclUI5dD9ABzeBl6IJcyV
        F9MSJrRQEl2IQoEF6oo+mMM96zUnevY=
X-Google-Smtp-Source: AAOMgpd/nJAyCMTI0MfDIpBv3L9KT2gFX4/swrzaZj6y5niK7XssGMlt4JNjkYbVIE4niFrT087SSA==
X-Received: by 2002:adf:9d46:: with SMTP id o6-v6mr973758wre.51.1531384815812;
        Thu, 12 Jul 2018 01:40:15 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id y203-v6sm5760396wme.42.2018.07.12.01.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 01:40:15 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 5/7] dt: thermal: tsens: Document the fallback DT property for v2 of TSENS IP
Date:   Thu, 12 Jul 2018 14:09:06 +0530
Message-Id: <a385dfac661b04befd221f3012b2ca56576aada9.1531384019.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to create common code for v2 of the TSENS IP block that is used in
a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
most of the common functionality start with a common get_temp() function.

It is also necessary to split out the memory regions for the TM and SROT
register banks because their offsets are not constant across SoC families.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 06195e8..b5312a8 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -1,18 +1,28 @@
 * QCOM SoC Temperature Sensor (TSENS)
 
 Required properties:
-- compatible :
- - "qcom,msm8916-tsens" : For 8916 Family of SoCs
- - "qcom,msm8974-tsens" : For 8974 Family of SoCs
- - "qcom,msm8996-tsens" : For 8996 Family of SoCs
+- compatible:
+  Must be one of the following:
+    - "qcom,msm8916-tsens" (MSM8916)
+    - "qcom,msm8974-tsens" (MSM8974)
+    - "qcom,msm8996-tsens" (MSM8996)
+    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
+    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
+  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
+  with version 2 of the TSENS IP. MSM8996 is the only exception beacause the
+  generic property did not exist when support was added.
+
+- reg: Address range of the thermal registers.
+  New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
+  register spaces separately, with order being TM before SROT.
+  See Example 2, below.
 
-- reg: Address range of the thermal registers
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
 - #qcom,sensors: Number of sensors in tsens block
 - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
 nvmem cells
 
-Example:
+Example 1 (legacy support before a fallback tsens-v2 propoerty was introduced):
 tsens: thermal-sensor@900000 {
 		compatible = "qcom,msm8916-tsens";
 		reg = <0x4a8000 0x2000>;
@@ -20,3 +30,12 @@ tsens: thermal-sensor@900000 {
 		nvmem-cell-names = "caldata", "calsel";
 		#thermal-sensor-cells = <1>;
 	};
+
+Example 2 (for any platform containing v2 of the TSENS IP):
+tsens0: thermal-sensor@c263000 {
+		compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+		reg = <0xc263000 0x1ff>, /* TM */
+			<0xc222000 0x1ff>; /* SROT */
+		#qcom,sensors = <13>;
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.7.4

