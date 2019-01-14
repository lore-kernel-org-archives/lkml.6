Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE91C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC2B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VAT/qx4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfANKWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:22:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39868 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfANKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:22:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so22148051wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=b84VzS+zt/SYuz8SCYw22/mwhzuXk7yy3r3UAQeofo8=;
        b=VAT/qx4pWCvf/A4ZUSpHjwVNrketlaH1WIrcCH5h5qxAKVbvo5+z4tCQyRz6+QBNV1
         62BquKMDZl+E59cAjzMnECp6/1JWsRyGMyKniWzNpmw4BHRlbPbdP+oFwv7a9gmJlxOZ
         t0tbaLwdjFhkp5ZLfp6qzIIvvJnch/6QKQ97I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=b84VzS+zt/SYuz8SCYw22/mwhzuXk7yy3r3UAQeofo8=;
        b=kEeXd1otz7B8H/+eedcHHKmXp/k9Fa1kp4DP6YR/htmS1m+xBU8h5//XjWPPv8Jj2+
         itgytcEARplfhmm+Plm94kKzuuPtvp4gMWqhZh90TzOHH+dCjETL8JqQPY2EsKaOUScS
         rGoxEt0OA8vrNgwuxo9CVDaQ+5ttsKpA5AWUNO6oQmjJTJSG6XjzTf4zcS7/od8f2sHZ
         9l5aTX+bLVdirvaGQ4TjNqK6mUTAKjZKYftt5WU/VCTGk4YK8kT4HAiWRq+T2x/X1dnW
         4Xqs7GF7D1npZ9znN6rfUpBETHUuQRg6VbMBrnyL9/p+V343uUe1HBpOJTHyIJDfzxjC
         vHhw==
X-Gm-Message-State: AJcUukeNZsIJ8bICLao40Nk5UigQSyZ6qkaynjRoQsbVfZJ0S/6K5k+X
        hL6+TH7XkPUZzbhZ+qO+w5oZ83Rg7G8=
X-Google-Smtp-Source: ALg8bN6KiDUdohCO+frq/jg2Eo5qIj35wrJDFw9p+lzdW7jsRHanVirm4M7D6QJqcQMPwnPPSj1Etw==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr22941742wrq.69.1547461326543;
        Mon, 14 Jan 2019 02:22:06 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id h62sm22421356wmf.11.2019.01.14.02.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:22:05 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 8/9] arm64: dts: sdm845: wireup the thermal trip points to cpufreq
Date:   Mon, 14 Jan 2019 15:51:10 +0530
Message-Id: <7f94696460848a6bcfe5aee5ffda7fe556240736.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all cpus in the big and little clusters, respectively, are in the
same frequency domain, use all of them for mitigation in the
cooling-map. We end up with two cooling devices - one each for the big
and little clusters.

At the lower trip points we restrict ourselves to throttling only a few
OPPs. At higher trip temperatures, allow ourselves to be throttled to
any extent.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 177 ++++++++++++++++++++++++---
 1 file changed, 161 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fb7da678b116..7973e88bdf94 100644
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
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
@@ -116,6 +118,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
@@ -130,6 +133,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
@@ -144,6 +148,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
@@ -158,6 +163,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
@@ -172,6 +178,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
@@ -186,6 +193,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
@@ -200,6 +208,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
@@ -1719,18 +1728,35 @@
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
-				cpu_alert0: trip0 {
+				cpu0_alert0: trip-point@0 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit0: trip1 {
+				cpu0_crit: cpu_crit@0 {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
+							 <&CPU1 THERMAL_NO_LIMIT 4>,
+							 <&CPU2 THERMAL_NO_LIMIT 4>,
+							 <&CPU3 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu0_crit>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu1-thermal {
@@ -1740,18 +1766,35 @@
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
-				cpu_alert1: trip0 {
+				cpu1_alert0: trip-point@0 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit1: trip1 {
+				cpu1_crit: cpu_crit@0 {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu1_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
+							 <&CPU1 THERMAL_NO_LIMIT 4>,
+							 <&CPU2 THERMAL_NO_LIMIT 4>,
+							 <&CPU3 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu1_crit>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu2-thermal {
@@ -1761,18 +1804,35 @@
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
-				cpu_alert2: trip0 {
+				cpu2_alert0: trip-point@0 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit2: trip1 {
+				cpu2_crit: cpu_crit@0 {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu2_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
+							 <&CPU1 THERMAL_NO_LIMIT 4>,
+							 <&CPU2 THERMAL_NO_LIMIT 4>,
+							 <&CPU3 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu2_crit>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu3-thermal {
@@ -1782,18 +1842,35 @@
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
-				cpu_alert3: trip0 {
+				cpu3_alert0: trip-point@0 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit3: trip1 {
+				cpu3_crit: cpu_crit@0 {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu3_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
+							 <&CPU1 THERMAL_NO_LIMIT 4>,
+							 <&CPU2 THERMAL_NO_LIMIT 4>,
+							 <&CPU3 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu3_crit>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu4-thermal {
@@ -1803,18 +1880,35 @@
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
-				cpu_alert4: trip0 {
+				cpu4_alert0: trip-point@0 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit4: trip1 {
+				cpu4_crit: cpu_crit@0 {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT 4>,
+							 <&CPU5 THERMAL_NO_LIMIT 4>,
+							 <&CPU6 THERMAL_NO_LIMIT 4>,
+							 <&CPU7 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu4_crit>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu5-thermal {
@@ -1824,18 +1918,35 @@
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
-				cpu_alert5: trip0 {
+				cpu5_alert0: trip-point@0 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit5: trip1 {
+				cpu5_crit: cpu_crit@0 {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu5_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT 4>,
+							 <&CPU5 THERMAL_NO_LIMIT 4>,
+							 <&CPU6 THERMAL_NO_LIMIT 4>,
+							 <&CPU7 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu5_crit>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu6-thermal {
@@ -1845,18 +1956,35 @@
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
-				cpu_alert6: trip0 {
+				cpu6_alert0: trip-point@0 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit6: trip1 {
+				cpu6_crit: cpu_crit@0 {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu6_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT 4>,
+							 <&CPU5 THERMAL_NO_LIMIT 4>,
+							 <&CPU6 THERMAL_NO_LIMIT 4>,
+							 <&CPU7 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu6_crit>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu7-thermal {
@@ -1866,18 +1994,35 @@
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
-				cpu_alert7: trip0 {
+				cpu7_alert0: trip-point@0 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit7: trip1 {
+				cpu7_crit: cpu_crit@0 {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu7_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT 4>,
+							 <&CPU5 THERMAL_NO_LIMIT 4>,
+							 <&CPU6 THERMAL_NO_LIMIT 4>,
+							 <&CPU7 THERMAL_NO_LIMIT 4>;
+				};
+				map1 {
+					trip = <&cpu7_crit>;
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

