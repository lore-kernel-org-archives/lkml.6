Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965867AbeEYKBx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:01:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965712AbeEYKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:01:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDC2460C65
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, collinsd@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 4/6] arm64: dts: msm8996: Add rpmpd device node
Date: Fri, 25 May 2018 15:31:19 +0530
Message-Id: <20180525100121.28214-5-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525100121.28214-1-rnayak@codeaurora.org>
References: <20180525100121.28214-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rpmpd device node and its OPP table

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 37b7152cb064..e1bc86b2a230 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -308,6 +308,46 @@
 				#clock-cells = <1>;
 			};
 
+			rpmpd: power-controller {
+				compatible = "qcom,msm8996-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>, /* cx */
+						      <&rpmpd_opp_table>, /* cx_ao */
+						      <&rpmpd_opp_table>, /* cx_vfc */
+						      <&rpmpd_opp_table>, /* mx */
+						      <&rpmpd_opp_table>, /* mx_ao */
+						      <&rpmpd_opp_table>, /* sscx */
+						      <&rpmpd_opp_table>; /* sscx_vfc */
+			};
+
+			rpmpd_opp_table: opp-table {
+				compatible = "operating-points-v2-qcom-level", "operating-points-v2";
+
+				rpmpd_opp1: opp@1 {
+					qcom,level = <1>;
+				};
+
+				rpmpd_opp2: opp@2 {
+					qcom,level = <2>;
+				};
+
+				rpmpd_opp3: opp@3 {
+					qcom,level = <3>;
+				};
+
+				rpmpd_opp4: opp@4 {
+					qcom,level = <4>;
+				};
+
+				rpmpd_opp5: opp@5 {
+					qcom,level = <5>;
+				};
+
+				rpmpd_opp6: opp@6 {
+					qcom,level = <6>;
+				};
+			};
+
 			pm8994-regulators {
 				compatible = "qcom,rpm-pm8994-regulators";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
