Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeCPEJp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:09:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49224 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeCPEI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:08:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE7C560452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 5/7] arm64: dts: msm8996: Add rpmpd device node
Date: Fri, 16 Mar 2018 09:38:22 +0530
Message-Id: <20180316040824.21472-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180316040824.21472-1-rnayak@codeaurora.org>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rpmpd device node and its OPP table

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0a6f7952bbb1..43757a078146 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -297,6 +297,52 @@
 				#clock-cells = <1>;
 			};
 
+			rpmpd: qcom,rpmpd {
+				compatible = "qcom,rpmpd-msm8996";
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
+				compatible = "operating-points-v2", "operating-points-v2-qcom";
+
+				rpmpd_opp1: opp@1 {
+					opp-hz = /bits/ 64 <1>;
+					qcom,level = <1>;
+				};
+
+				rpmpd_opp2: opp@2 {
+					opp-hz = /bits/ 64 <2>;
+					qcom,level = <2>;
+				};
+
+				rpmpd_opp3: opp@3 {
+					opp-hz = /bits/ 64 <3>;
+					qcom,level = <3>;
+				};
+
+				rpmpd_opp4: opp@4 {
+					opp-hz = /bits/ 64 <4>;
+					qcom,level = <4>;
+				};
+
+				rpmpd_opp5: opp@5 {
+					opp-hz = /bits/ 64 <5>;
+					qcom,level = <5>;
+				};
+
+				rpmpd_opp6: opp@6 {
+					opp-hz = /bits/ 64 <6>;
+					qcom,level = <6>;
+				};
+			};
+
 			pm8994-regulators {
 				compatible = "qcom,rpm-pm8994-regulators";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
