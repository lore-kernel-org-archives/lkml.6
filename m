Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F182C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADB221904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUcYK4rC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfBGM5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:57:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46034 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfBGM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:57:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id j3so2595193pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=weNMC1WOncVzrjA84l2O07eMcZ540Q8KJY50toWf3Z8=;
        b=cUcYK4rCNJFDiEGFjIMegVOFyeAXH42gm+HBUQUYfnP0NK+CEDN/WuiyjKGFlJTxkb
         L448RL2WEo3FdpcmRgEqXZ4vVw/T/88S2+LBLuYEmZJEVXo6rauTfiqt/+0Ei7uMYnYH
         354o8YG0vPqGFfzrSOWm/zxBarnbn0Umv+9o2PUkcBjxZtItSkE1EllvCHpy6GS5Cn83
         kmstKiUmEWFM8oOMH+OZI8ks9y1icZLmD6v8S4RKQmUCwtzW0JnsdCJqGkqGoWuGToUP
         aEi1rpDiV4zDwu0K+9+LFjW/nK5LeMhnzijHsZbbzoVGir1aNdyPQg0SbJOr7H8aJC4j
         NeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=weNMC1WOncVzrjA84l2O07eMcZ540Q8KJY50toWf3Z8=;
        b=ogrxvVj7e2aMFEhj7GDklG7LeEhQQAfqjl36ISIEcznGsEa0RSUG3GixCdbyA/C1ar
         TfgeUqbrbwUQOIfsBfE5S0avz9wu6XBCmnmntMQJ9n8goUo8SHIp98i/OSbMhqRLFwoF
         w4shkSWpkBbvjeuTLz6Fbh3TJr3cUzB46QUCXl0PlqOI/S61N/bv4b0XRTu1On384ySh
         ssCst3/ReHNCiqZy9YjQkJFLUEM43uNG6WFI0iCn24d5fur+rW9sgC+hPRhJCHDJI4i2
         nzTGmC5lHC3nihg6qIOIsfRU5Zt4u5Vf6p/WRGzghuKFkQAw59K4BPT7H4qPqkpLm9zc
         rdsA==
X-Gm-Message-State: AHQUAuY9gkJEtX0JqPl8tTnJ9Z5xTProZjhraYM9tA8WmZPTzzu/vezu
        hRa/0uVUU52njYhdjbkQWuibrzxEES0=
X-Google-Smtp-Source: AHgI3Ibd1rLmcRu3sVCvBA6NIcK4GxTK+t+GEpgchagcuQG5fPQsOoMjhmcgLjZgmUC7FyXRvlZQyw==
X-Received: by 2002:a62:4549:: with SMTP id s70mr15873687pfa.233.1549544236077;
        Thu, 07 Feb 2019 04:57:16 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id r6sm13488289pgk.91.2019.02.07.04.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:57:15 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 20/24] dt: thermal: tsens: Add bindings for qcs404
Date:   Thu,  7 Feb 2019 16:19:38 +0530
Message-Id: <3f5a9282e815d2244b633a65e126494d23c16a7a.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 uses v1 of the TSENS IP block. Create a fallback DT property
"qcom,tsens-v1" to gather common code

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.txt     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 1d9e8cf61018..673cc1831ee9 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -6,11 +6,14 @@ Required properties:
     - "qcom,msm8916-tsens" (MSM8916)
     - "qcom,msm8974-tsens" (MSM8974)
     - "qcom,msm8996-tsens" (MSM8996)
+    - "qcom,qcs404-tsens", "qcom,tsens-v1" (QCS404)
     - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
     - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
   The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
   with version 2 of the TSENS IP. MSM8996 is the only exception because the
   generic property did not exist when support was added.
+  Similarly, the generic "qcom,tsens-v1" property must be used as a fallback for
+  any SoC with version 1 of the TSENS IP.
 
 - reg: Address range of the thermal registers.
   New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
@@ -39,3 +42,14 @@ tsens0: thermal-sensor@c263000 {
 		#qcom,sensors = <13>;
 		#thermal-sensor-cells = <1>;
 	};
+
+Example 3 (for any platform containing v1 of the TSENS IP):
+tsens: thermal-sensor@4a9000 {
+		compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+		reg = <0x004a9000 0x1000>, /* TM */
+		      <0x004a8000 0x1000>; /* SROT */
+		nvmem-cells = <&tsens_caldata>;
+		nvmem-cell-names = "calib";
+		#qcom,sensors = <10>;
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.17.1

