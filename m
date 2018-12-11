Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E6BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E442082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MVkMQqw0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iIX6PD44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E442082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeLKJuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:50:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:50:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DA1AA601A1; Tue, 11 Dec 2018 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544521801;
        bh=13Qiq0/v54HcrTnD9wIsQxIE46oiUcNKtUHNXSzkmF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVkMQqw0NnFrKLpmF0Oj/c0RpoI3Q87yCnDwXOsIdYiq6bPbG5fSpt3PiXA6wKvhX
         gpzB1cD7F0z2L6gs2Lmy7IolGfr1pduYRElwUlXnDA70kaFi1TmD8xw80yGUBPiPsc
         AfHM0SOb+6sagcY80NqNK/ZpoeypDjYmlvdInS2I=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 526EC607E2;
        Tue, 11 Dec 2018 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544521796;
        bh=13Qiq0/v54HcrTnD9wIsQxIE46oiUcNKtUHNXSzkmF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIX6PD44oCc1GuA0cIb4dUhXSy9mhXLVlqhA37cgpQ50q705LcbkOWnxSvavyrQPH
         Kk/Em4Ciyc3WjRSjHp2Z2w3G5bHUgtMIZgRGXuGfXw5oI33hBEpEg1go43uGvxao00
         ONLElmsmDW9SrLJVbdlqNJRo9J7U8F6SzT9AveJA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 526EC607E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 02/10] dt-bindings: power: Add qcom rpm power domain driver bindings
Date:   Tue, 11 Dec 2018 15:19:30 +0530
Message-Id: <20181211094938.25086-3-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181211094938.25086-1-rnayak@codeaurora.org>
References: <20181211094938.25086-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings to describe the rpm/rpmh power domains found on Qualcomm
Technologies, Inc. SoCs. These power domains communicate a performance
state to RPM/RPMh, which then translates it into corresponding voltage on a
PMIC rail.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.txt  | 146 ++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        |  39 +++++
 2 files changed, 185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 include/dt-bindings/power/qcom-rpmpd.h

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
new file mode 100644
index 000000000000..a776e4407f09
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -0,0 +1,146 @@
+Qualcomm RPM/RPMh Power domains
+
+For RPM/RPMh Power domains, we communicate a performance state to RPM/RPMh
+which then translates it into a corresponding voltage on a rail
+
+Required Properties:
+ - compatible: Should be one of the following
+	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
+	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
+ - power-domain-cells: number of cells in Power domain specifier
+	must be 1.
+ - operating-points-v2: Phandle to the OPP table for the Power domain.
+	Refer to Documentation/devicetree/bindings/power/power_domain.txt
+	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
+
+Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
+various OPPs for different platforms as well as Power domain indexes
+
+Example: rpmh power domain controller and OPP table
+
+#include <dt-bindings/power/qcom-rpmhpd.h>
+
+qcom,level values specified in the OPP tables for RPMh power domains
+should use the RPMH_REGULATOR_LEVEL_* constants from
+<dt-bindings/power/qcom-rpmhpd.h>
+
+	rpmhpd: power-controller {
+		compatible = "qcom,sdm845-rpmhpd";
+		#power-domain-cells = <1>;
+		operating-points-v2 = <&rpmhpd_opp_table>;
+
+		rpmhpd_opp_table: opp-table {
+			compatible = "operating-points-v2-qcom-level";
+
+			rpmhpd_opp_ret: opp1 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+			};
+
+			rpmhpd_opp_min_svs: opp2 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+			};
+
+			rpmhpd_opp_low_svs: opp3 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+			};
+
+			rpmhpd_opp_svs: opp4 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_SVS>;
+			};
+
+			rpmhpd_opp_svs_l1: opp5 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+			};
+
+			rpmhpd_opp_nom: opp6 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_NOM>;
+			};
+
+			rpmhpd_opp_nom_l1: opp7 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+			};
+
+			rpmhpd_opp_nom_l2: opp8 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+			};
+
+			rpmhpd_opp_turbo: opp9 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_TURBO>;
+			};
+
+			rpmhpd_opp_turbo_l1: opp10 {
+				qcom,level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+			};
+		};
+	};
+
+Example: rpm power domain controller and OPP table
+
+	rpmpd: power-controller {
+		compatible = "qcom,msm8996-rpmpd";
+		#power-domain-cells = <1>;
+		operating-points-v2 = <&rpmpd_opp_table>;
+
+		rpmpd_opp_table: opp-table {
+			compatible = "operating-points-v2-qcom-level";
+
+			rpmpd_opp_low: opp1 {
+				qcom,level = <1>;
+			};
+
+			rpmpd_opp_ret: opp2 {
+				qcom,level = <2>;
+			};
+
+			rpmpd_opp_svs: opp3 {
+				qcom,level = <3>;
+			};
+
+			rpmpd_opp_normal: opp4 {
+				qcom,level = <4>;
+			};
+
+			rpmpd_opp_high: opp5 {
+				qcom,level = <5>;
+			};
+
+			rpmpd_opp_turbo: opp6 {
+				qcom,level = <6>;
+			};
+		};
+	};
+
+Example: Client/Consumer device using OPP table
+
+	leaky-device0@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&rpmhpd SDM845_MX>;
+		operating-points-v2 = <&leaky_opp_table>;
+	};
+
+
+	leaky_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp1 {
+			opp-hz = /bits/ 64 <144000>;
+			required-opps = <&rpmhpd_opp_low>;
+		};
+
+		opp2 {
+			opp-hz = /bits/ 64 <400000>;
+			required-opps = <&rpmhpd_opp_ret>;
+		};
+
+		opp3 {
+			opp-hz = /bits/ 64 <20000000>;
+			required-opps = <&rpmpd_opp_svs>;
+		};
+
+		opp4 {
+			opp-hz = /bits/ 64 <25000000>;
+			required-opps = <&rpmpd_opp_normal>;
+		};
+
+	};
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
new file mode 100644
index 000000000000..87d9c6611682
--- /dev/null
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
+#define _DT_BINDINGS_POWER_QCOM_RPMPD_H
+
+/* SDM845 Power Domain Indexes */
+#define SDM845_EBI	0
+#define SDM845_MX	1
+#define SDM845_MX_AO	2
+#define SDM845_CX	3
+#define SDM845_CX_AO	4
+#define SDM845_LMX	5
+#define SDM845_LCX	6
+#define SDM845_GFX	7
+#define SDM845_MSS	8
+
+/* SDM845 Power Domain performance levels */
+#define RPMH_REGULATOR_LEVEL_RETENTION	16
+#define RPMH_REGULATOR_LEVEL_MIN_SVS	48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS	64
+#define RPMH_REGULATOR_LEVEL_SVS	128
+#define RPMH_REGULATOR_LEVEL_SVS_L1	192
+#define RPMH_REGULATOR_LEVEL_NOM	256
+#define RPMH_REGULATOR_LEVEL_NOM_L1	320
+#define RPMH_REGULATOR_LEVEL_NOM_L2	336
+#define RPMH_REGULATOR_LEVEL_TURBO	384
+#define RPMH_REGULATOR_LEVEL_TURBO_L1	416
+
+/* MSM8996 Power Domain Indexes */
+#define MSM8996_VDDCX		0
+#define MSM8996_VDDCX_AO	1
+#define MSM8996_VDDCX_VFC	2
+#define MSM8996_VDDMX		3
+#define MSM8996_VDDMX_AO	4
+#define MSM8996_VDDSSCX		5
+#define MSM8996_VDDSSCX_VFC	6
+
+#endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

