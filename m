Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeBEOrP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:47:15 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51638 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbeBEOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:46:58 -0500
X-Google-Smtp-Source: AH8x2264q8LNe6wH+4red9vFOeaBMAt6J9wrO+GZAvfcJpj0fpNN7SXHrdHnh8ZMRAuTsFwtj2JpEQ==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: andy.gross@linaro.org
Cc: bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: msm8916: Add CPU frequency scaling support
Date: Mon,  5 Feb 2018 16:46:51 +0200
Message-Id: <20180205144651.5934-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205144651.5934-1-georgi.djakov@linaro.org>
References: <20180205144651.5934-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a CPU OPP table to allow CPU frequency scaling on msm8916 platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 4539571a36b2..e4682779eec7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -113,6 +113,8 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&apcs 0>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU1: cpu@1 {
@@ -122,6 +124,8 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&apcs 0>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU2: cpu@2 {
@@ -131,6 +135,8 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&apcs 0>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU3: cpu@3 {
@@ -140,6 +146,8 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&apcs 0>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		L2_0: l2-cache {
@@ -212,6 +220,24 @@
 
 	};
 
+	cpu_opp_table: cpu_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+		};
+		opp-998400000 {
+			opp-hz = /bits/ 64 <998400000>;
+		};
+	};
+
 	gpu_opp_table: opp_table {
 		compatible = "operating-points-v2";
 
