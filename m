Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77660C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0E120881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KO0sBPue";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="chyUKywZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfA1TOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:14:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1TOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:14:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6D6760C6A; Mon, 28 Jan 2019 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548702888;
        bh=YThYa1uOYIKkIZl5iOAiMyFX8vKW+bRD/ekOXtERxsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KO0sBPue9kCqmqhKMhX7AJ+F+gjgnOHRdEVWlrA9NueVPjBHDXAthbRcJ4AbV/o+N
         M2WL4VLq8fXipfwR55GhR0ftamlKbhEtwPtTLoBdUYGYmQAqrMIgcT3VkglOrmf6U9
         O4dwihBLtIOOee8+Bo6uElGSH0fjVXAqlxeTov58=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C2F360C60;
        Mon, 28 Jan 2019 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548702882;
        bh=YThYa1uOYIKkIZl5iOAiMyFX8vKW+bRD/ekOXtERxsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chyUKywZabecuv6ENsoDJ7jtfQwyDAdw1K5fc/secMywDmsCvR/NXkFTf+vQshtVd
         ot8b87FiNN6roPUxHexuOs2CxoI7Kh+0pfdR5IqjqbZ0rBqcMR318z7QX3ARkPlPlg
         O3VBObkLtX7xcL6ad6hO3bN1b3Wjz9aNilP9w6+s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C2F360C60
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
Subject: [PATCHv5 1/7] arm64: dts: qcom: sdm845: Add Coresight support
Date:   Tue, 29 Jan 2019 00:43:58 +0530
Message-Id: <60ebf1617f0285c89e921bf3839cba6906d493c9.1548419933.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coresight components found on Qualcomm SDM845 SoC.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---
Depends on AOSS QMP side channel patches and AMBA bus pclk change
by Bjorn Andersson [1][2].
Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
and size cells for soc") [3].

[1] https://lore.kernel.org/lkml/20190106080915.4493-1-bjorn.andersson@linaro.org/
[2] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
[3] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 434 +++++++++++++++++++++++++++
 1 file changed, 434 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..e49f71d00854 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1348,6 +1348,440 @@
 			};
 		};
 
+		stm@6002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0 0x06002000 0 0x1000>,
+			      <0 0x16280000 0 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint =
+						  <&funnel0_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@6041000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x06041000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
+		funnel@6043000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x06043000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					funnel2_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in2>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@5 {
+					reg = <5>;
+					funnel2_in5: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6045000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x06045000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint = <&etf_in>;
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
+				port@2 {
+					reg = <2>;
+					merge_funnel_in2: endpoint {
+						remote-endpoint =
+						  <&funnel2_out>;
+					};
+				};
+			};
+		};
+
+		replicator@6046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0 0x06046000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
+			reg = <0 0x06047000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
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
+			reg = <0 0x06048000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
+		etm@7040000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07040000 0 0x1000>;
+
+			cpu = <&CPU0>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
+		etm@7140000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07140000 0 0x1000>;
+
+			cpu = <&CPU1>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
+		etm@7240000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07240000 0 0x1000>;
+
+			cpu = <&CPU2>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
+		etm@7340000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07340000 0 0x1000>;
+
+			cpu = <&CPU3>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
+		etm@7440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07440000 0 0x1000>;
+
+			cpu = <&CPU4>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in4>;
+					};
+				};
+			};
+		};
+
+		etm@7540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07540000 0 0x1000>;
+
+			cpu = <&CPU5>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in5>;
+					};
+				};
+			};
+		};
+
+		etm@7640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07640000 0 0x1000>;
+
+			cpu = <&CPU6>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in6>;
+					};
+				};
+			};
+		};
+
+		etm@7740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07740000 0 0x1000>;
+
+			cpu = <&CPU7>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@7800000 { /* APSS Funnel */
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x07800000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
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
+		funnel@7810000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x07810000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					apss_merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&funnel2_in5>;
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
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
 			reg = <0x88e2000 0x400>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

