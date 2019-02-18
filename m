Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CE521773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ral1zlD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfBRMgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:36:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38264 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbfBRMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:36:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so16937862wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IpwvUsCE/RAgILwZtM1QTDRD/UhcFwjv0M37jWKuSgs=;
        b=Ral1zlD9Ja6qvxYD7EDuuGfYe0oYdXn4rrX+YF27Pjenh0T2CZZUUJTQt3q8KaOlj6
         jqWvxJtRwYY/5q2l2ZSMF/wtj/VXCjeswMLwDWgw8PKpGrmfQvwsy6YtU8JsntDsjBeL
         to2eRMAMi0CSUjnRg5ZwchnAUpFC/ERZiWttWEKYcWjnpHpYds798jIOQk/p0lTveqUb
         811pJIF13oABrY2sG9W5n7xjTUWGUyQu4KAz+/n1fB4+YtFhaddnrKZxZmwUltFQZvga
         uZS0H8z5McSgx2TWx/kJ2a7kN+cQsO24F72wZ10kP3jrf70su+rRYucOcoRoRajlQnLS
         m8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IpwvUsCE/RAgILwZtM1QTDRD/UhcFwjv0M37jWKuSgs=;
        b=Ro8BTseadKQtxrP4Ex9sHXvAFQ4DL9gD/M/g38ldq0VveNE2znzJ4hxeUVeva2Xzlb
         UsrfJTw0YGd6pPWlg2YpO+pH9BwiuG+LajMyXe8wEpxzfBtObRAf9Mv7S0iEyfj2V4J4
         7pQpBsudRvEoqQZ6U59g6MQ7/3kGD8vOWpi7XaBhUXnzfPuphTVcvW1sZ4SZFqAd0rWp
         CzOyHgqqZPbigM30lDl/6Ipq7/cPbrruBhhbLql1tpy8F+o/l+lxNDNQpl6CxkM7E2Ud
         lPGqAb8ziHnifj30mPB0QLy2CnWrN2PVYSUwAh/0k2iajIqbuJ66Js1/vAW/ZHRa/W5w
         7XUQ==
X-Gm-Message-State: AHQUAubFp4w2ASfW/a1t6eHayqlpEhI7vkddYClGM26+rFX2CpETtYJt
        cvDqHJOBf0UjutbQPyU1CyBk+lNEsZM=
X-Google-Smtp-Source: AHgI3IZFBBI4p1Cl0gUu3wk9jLmZgqcZrsrWtthO2ODqMNZiKaUfV4IRDzoqjJElF6sW0bEYBS1LYw==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr15774104wme.135.1550493396645;
        Mon, 18 Feb 2019 04:36:36 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id j1sm4877756wme.4.2019.02.18.04.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:36:36 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 10/12] arm64: dts: msm8998: thermal: Make trip names consistent
Date:   Mon, 18 Feb 2019 18:05:24 +0530
Message-Id: <e3101826eedc867ee64f7cc73d9d35acda630822.1550493113.git.amit.kucheria@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 26a493af0866..f05ce858c423 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -332,20 +332,20 @@
 	};
 
 	thermal-zones {
-		cpu-thermal0 {
+		cpu0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 1>;
 
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
@@ -353,20 +353,20 @@
 			};
 		};
 
-		cpu-thermal1 {
+		cpu1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 2>;
 
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
@@ -374,20 +374,20 @@
 			};
 		};
 
-		cpu-thermal2 {
+		cpu2-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
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
@@ -395,20 +395,20 @@
 			};
 		};
 
-		cpu-thermal3 {
+		cpu3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 4>;
 
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
@@ -416,20 +416,20 @@
 			};
 		};
 
-		cpu-thermal4 {
+		cpu4-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
-				cpu_alert4: trip0 {
+				cpu4_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit4: trip1 {
+				cpu4_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -437,20 +437,20 @@
 			};
 		};
 
-		cpu-thermal5 {
+		cpu5-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
-				cpu_alert5: trip0 {
+				cpu5_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit5: trip1 {
+				cpu5_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -458,20 +458,20 @@
 			};
 		};
 
-		cpu-thermal6 {
+		cpu6-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
-				cpu_alert6: trip0 {
+				cpu6_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit6: trip1 {
+				cpu6_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -479,20 +479,20 @@
 			};
 		};
 
-		cpu-thermal7 {
+		cpu7-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
-				cpu_alert7: trip0 {
+				cpu7_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit7: trip1 {
+				cpu7_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
-- 
2.17.1

