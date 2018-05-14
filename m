Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeENNNn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:13:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932357AbeENNNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:13:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 212986055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        rjw@rjwysocki.net, linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: [PATCH v6 14/14] dt: qcom: Add qcom-cpufreq-kryo driver configuration
Date: Mon, 14 May 2018 16:12:00 +0300
Message-Id: <1526303520-5843-15-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi       | 310 +++++++++++++++++++++++++++-
 2 files changed, 309 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 230e9c8..da23bda 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -17,5 +17,5 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. DB820c";
-	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc";
+	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc", "qcom,apq8096";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index d7adef9..fbf92f6 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -174,218 +174,519 @@
 	};
 
 	cluster0_opp: opp_table0 {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
 		opp-shared;
 
 		opp-307200000 {
 			opp-hz = /bits/ 64 <307200000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x77>;
+			clock-latency-ns = <200000>;
+		};
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-422400000 {
 			opp-hz = /bits/ 64 <422400000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-460800000 {
+			opp-hz = /bits/ 64 <460800000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-480000000 {
 			opp-hz = /bits/ 64 <480000000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-537600000 {
+			opp-hz = /bits/ 64 <537600000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-556800000 {
 			opp-hz = /bits/ 64 <556800000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-652800000 {
 			opp-hz = /bits/ 64 <652800000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-729600000 {
 			opp-hz = /bits/ 64 <729600000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-768000000 {
+			opp-hz = /bits/ 64 <768000000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-844800000 {
 			opp-hz = /bits/ 64 <844800000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x77>;
+			clock-latency-ns = <200000>;
+		};
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-960000000 {
 			opp-hz = /bits/ 64 <960000000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1036800000 {
 			opp-hz = /bits/ 64 <1036800000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1190400000 {
 			opp-hz = /bits/ 64 <1190400000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1228800000 {
 			opp-hz = /bits/ 64 <1228800000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x5>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x72>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x5>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1440000000 {
+			opp-hz = /bits/ 64 <1440000000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1478400000 {
 			opp-hz = /bits/ 64 <1478400000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1593600000 {
 			opp-hz = /bits/ 64 <1593600000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x71>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x20>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x10>;
 			clock-latency-ns = <200000>;
 		};
 	};
 
 	cluster1_opp: opp_table1 {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
 		opp-shared;
 
 		opp-307200000 {
 			opp-hz = /bits/ 64 <307200000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x77>;
+			clock-latency-ns = <200000>;
+		};
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-403200000 {
 			opp-hz = /bits/ 64 <403200000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-460800000 {
+			opp-hz = /bits/ 64 <460800000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-480000000 {
 			opp-hz = /bits/ 64 <480000000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-537600000 {
+			opp-hz = /bits/ 64 <537600000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-556800000 {
 			opp-hz = /bits/ 64 <556800000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-652800000 {
 			opp-hz = /bits/ 64 <652800000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-729600000 {
 			opp-hz = /bits/ 64 <729600000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-806400000 {
 			opp-hz = /bits/ 64 <806400000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-883200000 {
 			opp-hz = /bits/ 64 <883200000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-940800000 {
 			opp-hz = /bits/ 64 <940800000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1036800000 {
 			opp-hz = /bits/ 64 <1036800000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1190400000 {
 			opp-hz = /bits/ 64 <1190400000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1248000000 {
 			opp-hz = /bits/ 64 <1248000000>;
 			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			opp-microvolt = <905000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1440000000 {
+			opp-hz = /bits/ 64 <1440000000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1478400000 {
 			opp-hz = /bits/ 64 <1478400000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1555200000 {
 			opp-hz = /bits/ 64 <1555200000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1632000000 {
 			opp-hz = /bits/ 64 <1632000000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1670400000 {
+			opp-hz = /bits/ 64 <1670400000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1708800000 {
 			opp-hz = /bits/ 64 <1708800000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1747200000 {
+			opp-hz = /bits/ 64 <1747200000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1785600000 {
 			opp-hz = /bits/ 64 <1785600000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x6>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1824000000 {
 			opp-hz = /bits/ 64 <1824000000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x71>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x74>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1920000000 {
 			opp-hz = /bits/ 64 <1920000000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1977600000 {
+			opp-hz = /bits/ 64 <1977600000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x30>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1996800000 {
 			opp-hz = /bits/ 64 <1996800000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2054400000 {
+			opp-hz = /bits/ 64 <2054400000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x30>;
 			clock-latency-ns = <200000>;
 		};
 		opp-2073600000 {
 			opp-hz = /bits/ 64 <2073600000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x1>;
 			clock-latency-ns = <200000>;
 		};
 		opp-2150400000 {
 			opp-hz = /bits/ 64 <2150400000>;
 			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x31>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2246400000 {
+			opp-hz = /bits/ 64 <2246400000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x10>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2342400000 {
+			opp-hz = /bits/ 64 <2342400000>;
+			opp-microvolt = <1140000 905000 1140000>;
+			opp-supported-hw = <0x10>;
 			clock-latency-ns = <200000>;
 		};
 	};
@@ -992,6 +1293,11 @@
 				reg = <0x24f 0x1>;
 				bits = <1 4>;
 			};
+
+			speedbin_efuse: speedbin@133 {
+				reg = <0x133 0x1>;
+				bits = <5 3>;
+			};
 		};
 
 		phy@34000 {
-- 
1.9.1
