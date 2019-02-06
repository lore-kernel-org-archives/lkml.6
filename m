Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0DFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37519206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+Hrm2hB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfBFKfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:35:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40732 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfBFKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:35:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so2063019wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=D4/h+ZpRKdC0e8ceFt9XzuipB7bpPFwOc9YPL32HTMc=;
        b=q+Hrm2hBkduyw70dZYXtt1YagWpCVM5JQdrFSb2UWTR0sHuv4Y7Rqc67KumPJON1E8
         7HR5xVXir25EBedI3CG9BotrUFLswTmM2ktwWCjgZR6luUGzCeamR+vNQISiZyLHjlnk
         uPG0RKMaIAh/7ml1laAdSwh5FekcTUhLzHmRTW9S52oMvFRsQVA7BKIiXB1Rxxu33Ytf
         LihfFekfJIa7vf7/RX9dnZ62eh0bo2aSOH9DzuihZJeET0TNDEo7WV0B12MdGTXMkAH0
         LR+3MMV8vbwFnCxI++tt3IuPQ4aNpkhd94a5HP5/yRyHn6hMuxg/P1y5eqF5sfMTJFxu
         NemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=D4/h+ZpRKdC0e8ceFt9XzuipB7bpPFwOc9YPL32HTMc=;
        b=q0bHkCOLU7ydBAZZgnR5ZICjhmmwZhzh1S6/Tmq8YKm3RHlxQATijPqeTlepFqLKTr
         vxgKF6pIWeIwPLy38TFHMHna1EAruz1t6/aiBNS8d3rGoPT56xTjdzZw3S9tDutkbm/V
         V7yVnedribatLKTy0D6tLsleApR/+MqcKvr8WdR6Ud9Bm1n4mAQ23znpaEO8vVpl2d32
         EpKhrXaGTzSFKCQomIPwE2jzm+WcfKqAZt3/XzCxMbd4Q12CFUKoxbCb0icEj8r8CzgV
         Dsk9ewqtWZhaxq4IZYj8gVQ4FNjeXDeIGxaiQULBfa99htnx1vOjs9UtrmiIyfaAtVeT
         TQPQ==
X-Gm-Message-State: AHQUAubitavlEUsopkSfsAMbTTixa5350UdEeqNzlnFYw2XZE1T6Mhpu
        qdVQGSNbjWPUR0UOw5jptFhLad9/UCg=
X-Google-Smtp-Source: AHgI3IYPYDD4g3yIaw5HySN11OJ4t0SQyJ3M1Jk8SlJmHKaHSgdTr6dXk8BnqQ/WGJNehzNeg/O3rw==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr2653945wmh.51.1549449335565;
        Wed, 06 Feb 2019 02:35:35 -0800 (PST)
Received: from localhost ([49.248.48.35])
        by smtp.gmail.com with ESMTPSA id o64sm18539813wmo.47.2019.02.06.02.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 02:35:34 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org,
        swboyd@chromium.org, dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/1] arm64: dts: sdm845: wireup the thermal trip points to cpufreq
Date:   Wed,  6 Feb 2019 16:04:49 +0530
Message-Id: <edfe493e2f2034d531702c333c5acb4fabfbbb97.1549448839.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549448839.git.amit.kucheria@linaro.org>
References: <cover.1549448839.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549448839.git.amit.kucheria@linaro.org>
References: <cover.1549448839.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all cpus in the big and little clusters, respectively, are in the
same frequency domain, use all of them for mitigation in the
cooling-map. We end up with two cooling devices - one each for the big
and little clusters.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 241 ++++++++++++++++++++++++---
 1 file changed, 217 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..8ce5bf55a345 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -99,6 +100,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -114,6 +116,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -126,6 +129,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -138,6 +142,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -150,6 +155,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -162,6 +168,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -174,6 +181,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -186,6 +194,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
 			L2_700: l2-cache {
 				compatible = "cache";
@@ -1691,18 +1700,41 @@
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
-				cpu_alert0: trip0 {
-					temperature = <75000>;
+				cpu0_alert0: trip-point@0 {
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit0: trip1 {
+				cpu0_alert1: trip-point@1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu0_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu1-thermal {
@@ -1712,18 +1744,41 @@
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
-				cpu_alert1: trip0 {
-					temperature = <75000>;
+				cpu1_alert0: trip-point@0 {
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit1: trip1 {
+				cpu1_alert1: trip-point@1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu1_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu1_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu2-thermal {
@@ -1733,18 +1788,41 @@
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
-				cpu_alert2: trip0 {
-					temperature = <75000>;
+				cpu2_alert0: trip-point@0 {
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit2: trip1 {
+				cpu2_alert1: trip-point@1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu2_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu2_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu3-thermal {
@@ -1754,18 +1832,41 @@
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
-				cpu_alert3: trip0 {
-					temperature = <75000>;
+				cpu3_alert0: trip-point@0 {
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit3: trip1 {
+				cpu3_alert1: trip-point@1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu3_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu3_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu4-thermal {
@@ -1775,18 +1876,41 @@
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
-				cpu_alert4: trip0 {
-					temperature = <75000>;
+				cpu4_alert0: trip-point@0 {
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit4: trip1 {
+				cpu4_alert1: trip-point@1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu4_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu5-thermal {
@@ -1796,18 +1920,41 @@
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
-				cpu_alert5: trip0 {
-					temperature = <75000>;
+				cpu5_alert0: trip-point@0 {
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit5: trip1 {
+				cpu5_alert1: trip-point@1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu5_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu5_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu6-thermal {
@@ -1817,18 +1964,41 @@
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
-				cpu_alert6: trip0 {
-					temperature = <75000>;
+				cpu6_alert0: trip-point@0 {
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit6: trip1 {
+				cpu6_alert1: trip-point@1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu6_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu6_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu7-thermal {
@@ -1838,18 +2008,41 @@
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
-				cpu_alert7: trip0 {
-					temperature = <75000>;
+				cpu7_alert0: trip-point@0 {
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit7: trip1 {
+				cpu7_alert1: trip-point@1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu7_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu7_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 };
-- 
2.17.1

