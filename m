Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D33CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3500217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAc/0Ms/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfBRMgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:36:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36652 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbfBRMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:36:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so18200039wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+/T2odwPAOajJVYEt3tg08DjIdaFRNW4UrgXx0uPhI8=;
        b=RAc/0Ms/+c5eP5RO7qYQxqcnP39mIQjxr5SLRipCO3f4VWJAZPTlPbO3UK+K36CxSv
         zxxUBzeZ+n22AFSS85fl/6/6nag8TyOB0OzKqV05yKSXMKdS0rl48/n5AIIAiTztw6Zs
         Zq1+MDzrpymubQW5T79ZuHFdHh1uopRKKhGVIPrMWlBaCXy9wS2qZyZeb07YR5z9wif6
         w3gaynTrSMk/RCNLIiYymcs0yG2lFtg8ol7PXhKnCWAX89YMcLvyWShahij23Mh1+aem
         c+rig2Mo9VjVcsrgeKsBkiGFsihpUugJG9aQMJ7DS9Ptt5ASODvbs4XU9+ZQUEPLatc1
         wQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+/T2odwPAOajJVYEt3tg08DjIdaFRNW4UrgXx0uPhI8=;
        b=HaeIn6+PVfftXhxI89SDL05+r2Low+kWVKb4N0TN2rxI9HeQqTm6OMQm4gJbVUzK+x
         3becd+MfEek6oUEnZXPPT6H8aLO26EE7RcYerqVzfstreBH0IMXWsEVEoYKR98s+KFgH
         aM/Ad4PMoJtZY8hPp7OdqROzySCq4D/RihAEzqwz5eVdwr9QdPjGqJdf+2pa1UZXGXhV
         ps+kWFYUq8anU4lsiLWKZgJqLk/ZbUzHGO2fkAiwbO25dVjdIIavSkqb6n5m2H6NAmIt
         r6FZgNnr3BoUQMNJtHRMw6A3Oz1LULC8x0h22Q7zGWG3ay969Y+Vj1MItqU99DaaQXAj
         gDeQ==
X-Gm-Message-State: AHQUAub4d2nL1D4t/qfL5NlRWuyibQoQs46ZHzqvODuYhbKXLF0hleXF
        gR+qjv1WGgPGwjEVuoFd/JXkxam8Rd8=
X-Google-Smtp-Source: AHgI3Ib1j+YJunxYuv/OzmigBmQ5SmrWPUPioQiW5FzdM67qK8i6N+66FlaqHM8ZU7Yn3cE2RcP54g==
X-Received: by 2002:adf:9e47:: with SMTP id v7mr17251721wre.190.1550493402609;
        Mon, 18 Feb 2019 04:36:42 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id o2sm18598266wmo.33.2019.02.18.04.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:36:42 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 11/12] arm64: dts: msm8916: thermal: Make trip names consistent
Date:   Mon, 18 Feb 2019 18:05:25 +0530
Message-Id: <cdeed815f3bbb161e51befc5e3af92ee113f31b6.1550493113.git.amit.kucheria@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9e4a82e5e0b4..2002f5f91a83 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -180,19 +180,19 @@
 	};
 
 	thermal-zones {
-		cpu-thermal0 {
+		cpu0_1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 5>;
 
 			trips {
-				cpu_alert0: trip0 {
+				cpu0_1_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu_crit0: trip1 {
+				cpu0_1_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -201,7 +201,7 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert0>;
+					trip = <&cpu0_1_alert0>;
 					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -210,19 +210,19 @@
 			};
 		};
 
-		cpu-thermal1 {
+		cpu2_3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 4>;
 
 			trips {
-				cpu_alert1: trip0 {
+				cpu2_3_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu_crit1: trip1 {
+				cpu2_3_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -231,7 +231,7 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert1>;
+					trip = <&cpu2_3_alert0>;
 					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -247,12 +247,12 @@
 			thermal-sensors = <&tsens 2>;
 
 			trips {
-				gpu_alert: trip0 {
+				gpu_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				gpu_crit: trip1 {
+				gpu_crit: gpu_crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -267,12 +267,12 @@
 			thermal-sensors = <&tsens 1>;
 
 			trips {
-				cam_alert: trip0 {
+				cam_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cam_crit: trip1 {
+				cam_crit: cam_crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
-- 
2.17.1

