Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A5AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7ED206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YOo+I0hl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IExxPJ6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfAIRru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:47:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfAIRrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:47:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6618260A75; Wed,  9 Jan 2019 17:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547056067;
        bh=bfNmy5d3KgIXDAS8tBvCXqhk7FUc4qosVXfwiNYVLGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOo+I0hlFRbWRs4qkO5gZPAWsOxX6EksI+7QMaFJqkVhr9tgqCZc2Cb6eF+Qn9Sl8
         wOoZhmH0l7bAtOtQSfGLKjyoG1md+IY774dekT7o0PhoyoXzxcAJY8GyT6TA/wUkDz
         N+aq2/39kr2tnRjzGtiAc77kUjGws07rmI9euZCE=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E413E608FF;
        Wed,  9 Jan 2019 17:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547056060;
        bh=bfNmy5d3KgIXDAS8tBvCXqhk7FUc4qosVXfwiNYVLGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IExxPJ6soU2re0wWgdB2aACCkkOaIXJLDBAwqIHNpjhpUyHqguZEk/5GdkJqxODM7
         MvVjInpWy0sMe5/oW8mt4O/3VVd+YFC0Yd60RMN6cVK2MSvnlUzinUggmDilqTSCka
         mN1N0vtK058mhPFordJc+7wvZC6RrcCw8CM2jumA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E413E608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
Date:   Wed,  9 Jan 2019 23:16:47 +0530
Message-Id: <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coresight components found on Qualcomm SDM845 SoC.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 .../arm64/boot/dts/qcom/sdm845-coresight.dtsi | 437 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +
 2 files changed, 439 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi b/arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi
new file mode 100644
index 000000000000..b6ef250b9186
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SDM845 Coresight DTS
+ *
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ */
+
+&soc {
+	stm@6002000 {
+		compatible = "arm,coresight-stm", "arm,primecell";
+		reg = <0x06002000 0x1000>,
+		      <0x16280000 0x180000>;
+		reg-names = "stm-base", "stm-stimulus-base";
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				stm_out: endpoint {
+					remote-endpoint = <&funnel0_in7>;
+				};
+			};
+		};
+	};
+
+	funnel@6041000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0x06041000 0x1000>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				funnel0_out: endpoint {
+					remote-endpoint =
+						<&merge_funnel_in0>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@7 {
+				reg = <7>;
+				funnel0_in7: endpoint {
+					remote-endpoint = <&stm_out>;
+				};
+			};
+		};
+	};
+
+	funnel@6043000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0x06043000 0x1000>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				funnel2_out: endpoint {
+					remote-endpoint =
+					  <&merge_funnel_in2>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@5 {
+				reg = <5>;
+				funnel2_in5: endpoint {
+					remote-endpoint =
+					  <&apss_merge_funnel_out>;
+				};
+			};
+		};
+	};
+
+	funnel@6045000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0x06045000 0x1000>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				merge_funnel_out: endpoint {
+					remote-endpoint = <&etf_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				merge_funnel_in0: endpoint {
+					remote-endpoint =
+						<&funnel0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				merge_funnel_in2: endpoint {
+					remote-endpoint =
+						<&funnel2_out>;
+				};
+			};
+		};
+	};
+
+	replicator@6046000 {
+		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+		reg = <0x06046000 0x1000>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				replicator_out: endpoint {
+					remote-endpoint = <&etr_in>;
+				};
+			};
+		};
+
+		in-ports {
+			port {
+				replicator_in: endpoint {
+					remote-endpoint = <&etf_out>;
+				};
+			};
+		};
+	};
+
+	etf@6047000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0x06047000 0x1000>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				etf_out: endpoint {
+					remote-endpoint = <&replicator_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <1>;
+				etf_in: endpoint {
+					remote-endpoint = <&merge_funnel_out>;
+				};
+			};
+		};
+	};
+
+	etr@6048000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0x06048000 0x1000>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		in-ports {
+			port {
+				etr_in: endpoint {
+					remote-endpoint = <&replicator_out>;
+				};
+			};
+		};
+	};
+
+	etm@7040000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		arm,primecell-periphid = <0x000bb95d>;
+		reg = <0x07040000 0x1000>;
+
+		cpu = <&CPU0>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				etm0_out: endpoint {
+					remote-endpoint = <&apss_funnel_in0>;
+				};
+			};
+		};
+	};
+
+	etm@7140000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		arm,primecell-periphid = <0x000bb95d>;
+		reg = <0x07140000 0x1000>;
+
+		cpu = <&CPU1>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				etm1_out: endpoint {
+					remote-endpoint = <&apss_funnel_in1>;
+				};
+			};
+		};
+	};
+
+	etm@7240000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		arm,primecell-periphid = <0x000bb95d>;
+		reg = <0x07240000 0x1000>;
+
+		cpu = <&CPU2>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				etm2_out: endpoint {
+					remote-endpoint = <&apss_funnel_in2>;
+				};
+			};
+		};
+	};
+
+	etm@7340000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		arm,primecell-periphid = <0x000bb95d>;
+		reg = <0x07340000 0x1000>;
+
+		cpu = <&CPU3>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				etm3_out: endpoint {
+					remote-endpoint = <&apss_funnel_in3>;
+				};
+			};
+		};
+	};
+
+	etm@7440000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		arm,primecell-periphid = <0x000bb95d>;
+		reg = <0x07440000 0x1000>;
+
+		cpu = <&CPU4>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				etm4_out: endpoint {
+					remote-endpoint = <&apss_funnel_in4>;
+				};
+			};
+		};
+	};
+
+	etm@7540000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		arm,primecell-periphid = <0x000bb95d>;
+		reg = <0x07540000 0x1000>;
+
+		cpu = <&CPU5>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				etm5_out: endpoint {
+					remote-endpoint = <&apss_funnel_in5>;
+				};
+			};
+		};
+	};
+
+	etm@7640000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		arm,primecell-periphid = <0x000bb95d>;
+		reg = <0x07640000 0x1000>;
+
+		cpu = <&CPU6>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				etm6_out: endpoint {
+					remote-endpoint = <&apss_funnel_in6>;
+				};
+			};
+		};
+	};
+
+	etm@7740000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		arm,primecell-periphid = <0x000bb95d>;
+		reg = <0x07740000 0x1000>;
+
+		cpu = <&CPU7>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				etm7_out: endpoint {
+					remote-endpoint = <&apss_funnel_in7>;
+				};
+			};
+		};
+	};
+
+	funnel@7800000 { /* APSS Funnel */
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0x07800000 0x1000>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				apss_funnel_out: endpoint {
+					remote-endpoint =
+					    <&apss_merge_funnel_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				apss_funnel_in0: endpoint {
+					remote-endpoint =
+						<&etm0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				apss_funnel_in1: endpoint {
+					remote-endpoint =
+						<&etm1_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				apss_funnel_in2: endpoint {
+					remote-endpoint =
+						<&etm2_out>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				apss_funnel_in3: endpoint {
+					remote-endpoint =
+						<&etm3_out>;
+				};
+			};
+
+			port@4 {
+				reg = <4>;
+				apss_funnel_in4: endpoint {
+					remote-endpoint =
+						<&etm4_out>;
+				};
+			};
+
+			port@5 {
+				reg = <5>;
+				apss_funnel_in5: endpoint {
+					remote-endpoint =
+						<&etm5_out>;
+				};
+			};
+
+			port@6 {
+				reg = <6>;
+				apss_funnel_in6: endpoint {
+					remote-endpoint =
+						<&etm6_out>;
+				};
+			};
+
+			port@7 {
+				reg = <7>;
+				apss_funnel_in7: endpoint {
+					remote-endpoint =
+						<&etm7_out>;
+				};
+			};
+		};
+	};
+
+	funnel@7810000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0x07810000 0x1000>;
+
+		power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+		out-ports {
+			port {
+				apss_merge_funnel_out: endpoint {
+					remote-endpoint =
+					    <&funnel2_in5>;
+				};
+			};
+		};
+
+		in-ports {
+			port {
+				apss_merge_funnel_in: endpoint {
+					remote-endpoint =
+					    <&apss_funnel_out>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..03683179b8f7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1853,3 +1853,5 @@
 		};
 	};
 };
+
+#include "sdm845-coresight.dtsi"
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

