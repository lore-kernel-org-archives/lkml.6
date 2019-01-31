Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D03C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CFC218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eTr6q8Pc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BNkrB1pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387824AbfAaOXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:23:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53122 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfAaOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:23:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF87160F33; Thu, 31 Jan 2019 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548944591;
        bh=OA4MrEV0+ei5UxKdxkdM0G4vw6uuEn4hTQKKAzujyG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTr6q8PccnechRUZFOF6qVJFZtoCrs9urwUS2ncuiNMzX9WsMNl4h+ZUf+O3BVN3d
         oZz1i5+NQOU6QbKDy4vjiSxx3p2VSmUHTy2NDPqYWMxR2sqHFmcQvRxeG2qbFmv3L7
         XPc7aHzSVEVnsQuxyU1GjPf8I8SycoABoyp/z7iE=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F51860EE8;
        Thu, 31 Jan 2019 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548944577;
        bh=OA4MrEV0+ei5UxKdxkdM0G4vw6uuEn4hTQKKAzujyG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNkrB1pdnbPoV/1L5ebtS7lSZX+YaNZXmzMwqQDLsRmM/0UaN209wRq4rcvfyM9+n
         VAYDcs1Y10rHBsdYqmR7ZfJ09YFWBi+zH6eadrsAIST3sXKDCHl5JhaJN48ogqNQfS
         YFhpcn1iW7KSVO31gGrL65xLbLgmIdjlW3jNcj/M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F51860EE8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv6 2/6] arm64: dts: qcom: msm8998: Add Coresight support
Date:   Thu, 31 Jan 2019 19:52:20 +0530
Message-Id: <bcff6cd655c565568caa2d5a9b20d95e619afb1e.1548943727.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable coresight support by adding device nodes for the
available source, sinks and channel blocks on MSM8998.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---
For testing, all dependent patches are in below tree:
 * https://github.com/saiprakash-ranjan/linux/tree/coresight-next

This depends on MSM8998 rpm clocks and rpmcc node by Jeffrey Hugo
and Marc Gonzalez [1][2][3].

[1] https://lore.kernel.org/lkml/1545099336-5615-1-git-send-email-jhugo@codeaurora.org/
[2] https://lore.kernel.org/lkml/1548866144-30265-1-git-send-email-jhugo@codeaurora.org/
[3] https://lore.kernel.org/lkml/6da00186-e7c9-c93d-a80a-65eda2516451@free.fr/
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 435 ++++++++++++++++++++++++++
 1 file changed, 435 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index eb691be6e171..3020a76ed201 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -566,6 +566,441 @@
 			#interrupt-cells = <0x2>;
 		};
 
+		stm@6002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0x06002000 0x1000>,
+			      <0x16280000 0x180000>;
+			reg-names = "stm-base", "stm-data-base";
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint = <&funnel0_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@6041000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x06041000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					funnel0_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in0>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@7 {
+					reg = <7>;
+					funnel0_in7: endpoint {
+						remote-endpoint = <&stm_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6042000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x06042000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					funnel1_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in1>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@6 {
+					reg = <6>;
+					funnel1_in6: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6045000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x06045000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&etf_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&funnel0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					merge_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&funnel1_out>;
+					};
+				};
+			};
+		};
+
+		replicator@6046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x06046000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					replicator_out: endpoint {
+						remote-endpoint = <&etr_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint = <&etf_out>;
+					};
+				};
+			};
+		};
+
+		etf@6047000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x06047000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint =
+						  <&replicator_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					etf_in: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_out>;
+					};
+				};
+			};
+		};
+
+		etr@6048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x06048000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out>;
+					};
+				};
+			};
+		};
+
+		etm@7840000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x07840000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU0>;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		etm@7940000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x07940000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU1>;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		etm@7a40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x07a40000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU2>;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		etm@7b40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x07b40000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU3>;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		funnel@7b60000 { /* APSS Funnel */
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x07b60000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					apss_funnel_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					apss_funnel_in2: endpoint {
+						remote-endpoint =
+						  <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					apss_funnel_in3: endpoint {
+						remote-endpoint =
+						  <&etm3_out>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+					apss_funnel_in4: endpoint {
+						remote-endpoint =
+						  <&etm4_out>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					apss_funnel_in5: endpoint {
+						remote-endpoint =
+						  <&etm5_out>;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					apss_funnel_in6: endpoint {
+						remote-endpoint =
+						  <&etm6_out>;
+					};
+				};
+
+				port@7 {
+					reg = <7>;
+					apss_funnel_in7: endpoint {
+						remote-endpoint =
+						  <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		funnel@7b70000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x07b70000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					apss_merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&funnel1_in6>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					apss_merge_funnel_in: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_out>;
+					};
+				};
+			};
+		};
+
+		etm@7c40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x07c40000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU4>;
+
+			port{
+				etm4_out: endpoint {
+					remote-endpoint = <&apss_funnel_in4>;
+				};
+			};
+		};
+
+		etm@7d40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x07d40000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU5>;
+
+			port{
+				etm5_out: endpoint {
+					remote-endpoint = <&apss_funnel_in5>;
+				};
+			};
+		};
+
+		etm@7e40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x07e40000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU6>;
+
+			port{
+				etm6_out: endpoint {
+					remote-endpoint = <&apss_funnel_in6>;
+				};
+			};
+		};
+
+		etm@7f40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x07f40000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU7>;
+
+			port{
+				etm7_out: endpoint {
+					remote-endpoint = <&apss_funnel_in7>;
+				};
+			};
+		};
+
 		spmi_bus: spmi@800f000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg =	<0x800f000 0x1000>,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

