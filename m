Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84996C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526EC21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cdi3n/vV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfBRMgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:36:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52635 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbfBRMgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:36:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so17243583wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZwbKvS0X0Qv77slIXShMzIdWeL2cn1uriKE5mTqa5TE=;
        b=Cdi3n/vV4GCuY8I0lh5d1n2i0aEGuAeW9ZeYDLoH8bBiP8F81OK2hAGG0lVLYH1OYZ
         jvkSMrEIYVeIwxcFYWc27L9vxCxsFwThcd0kf/OlP2Om5HnlFYydpuyZIFGXAyOAN2zD
         DKJXrgBk4A3Z2aa+G2/C8DG86kPgaimReBfDnqq3VVgtZWAzKsWzCo131kszkiplZkNN
         iEoD8zBUhfQfoOYrFmmnLWoN6zoWXK9JAy9s1U8cyMxo9nR2zQzF4fBTa3FS8c7fD0ip
         iXDX+X9jkEUf6Tih7d8N+H99Bj3cxjOFgzPBY+hcepU/ngXrXe2qD3svfSLvpf1cZXcj
         lPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZwbKvS0X0Qv77slIXShMzIdWeL2cn1uriKE5mTqa5TE=;
        b=gvc6INLm5BulTdqChv2rnm/1sQ5xutNe3Bj1nTj9cLaGmO+URGYm1ZdWxA587Rh4aQ
         z5DPY4D28KloboqGebnX0HqLtU76z+vZRENo05YznYxVAXSKV+S/VVZsoavn5WZhB3ma
         vePkkjZg5eYF6hFiO6FgRywjubTatsRnPFPASd39k6Ypkz3NVOX94qGS+EOXsQSte3t7
         Ud5gjL6q/fOMMPGKUIM8Va5RLga/KgfBtbkJXjWD7svN44HBng5cnka/GLtRLOqJJ3Od
         G7Wk05jt3CkeSdxTggBankSgKSRH7WmCHyIbmCYMUgWItJsHi0RBOoPgnRRobRZEykWZ
         lF2Q==
X-Gm-Message-State: AHQUAuZDfQPZm5V55YXSi4jRgPQZbmufyAOmwveaB+cHvfc5Gg7ehzfF
        zRXuCjc71riIrZ+Ptt0lEiek/OYFO30=
X-Google-Smtp-Source: AHgI3IZe4IIxt1NcAkVZJyU/aK2tzGK8f9Aa5ueddHNtLJ3eTEXiHxML43X//92WYR4niDvLMo8yMg==
X-Received: by 2002:a7b:cc93:: with SMTP id p19mr8130233wma.113.1550493408607;
        Mon, 18 Feb 2019 04:36:48 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id q78sm5397508wme.43.2019.02.18.04.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:36:48 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 12/12] arm64: dts: msm8996: thermal: Make trip names consistent
Date:   Mon, 18 Feb 2019 18:05:26 +0530
Message-Id: <099a769da066d4e81a1f6087bf2c3eff41245adc.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain naming consistency with what was landed for sdm845. Simplifies
parsing for test tools.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8e36a39e1386..67ab6e31b0e5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -154,20 +154,20 @@
 	};
 
 	thermal-zones {
-		cpu-thermal0 {
+		cpu0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
-				cpu_alert0: trip0 {
+				cpu0_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit0: trip1 {
+				cpu0_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -175,20 +175,20 @@
 			};
 		};
 
-		cpu-thermal1 {
+		cpu1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
-				cpu_alert1: trip0 {
+				cpu1_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit1: trip1 {
+				cpu1_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -196,20 +196,20 @@
 			};
 		};
 
-		cpu-thermal2 {
+		cpu2-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
-				cpu_alert2: trip0 {
+				cpu2_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit2: trip1 {
+				cpu2_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -217,20 +217,20 @@
 			};
 		};
 
-		cpu-thermal3 {
+		cpu3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
-				cpu_alert3: trip0 {
+				cpu3_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit3: trip1 {
+				cpu3_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
-- 
2.17.1

