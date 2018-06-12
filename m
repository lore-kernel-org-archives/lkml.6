Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7BD0AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324E42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Se7L2WQE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Se7L2WQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324E42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbeFLElZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:41:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932592AbeFLElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:41:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 92FF1606DB; Tue, 12 Jun 2018 04:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778482;
        bh=oltgX3MV2Km3blGMQjBAhFbOERkJWYDc0oNmCOPMe8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Se7L2WQEaqFYVJXD/kPCkj8uTXiODtlNGCLOLu/N/DyyH2BY7VXzzb7UbbF1s8G2G
         Y7SFZcyfGaVUmAGx9AICHg6PN1KngCArigUeeg6MNt9F5XgFAAr1yTTqib09BtUNgq
         rQSh8L2QWvhl0pCxszptt5BVQn6xNSnCdx5Nr7VI=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2769E602BD;
        Tue, 12 Jun 2018 04:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778482;
        bh=oltgX3MV2Km3blGMQjBAhFbOERkJWYDc0oNmCOPMe8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Se7L2WQEaqFYVJXD/kPCkj8uTXiODtlNGCLOLu/N/DyyH2BY7VXzzb7UbbF1s8G2G
         Y7SFZcyfGaVUmAGx9AICHg6PN1KngCArigUeeg6MNt9F5XgFAAr1yTTqib09BtUNgq
         rQSh8L2QWvhl0pCxszptt5BVQn6xNSnCdx5Nr7VI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2769E602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 5/7] dt-bindings: power: Add qcom rpmh power domain driver bindings
Date:   Tue, 12 Jun 2018 10:10:50 +0530
Message-Id: <20180612044052.4402-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612044052.4402-1-rnayak@codeaurora.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings to describe the rpmh powerdomains found on Qualcomm
Technologies, Inc. SoCs. These power domains communicate a performance
state to RPMh, which then translates it into corresponding voltage on
a PMIC rail.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 .../devicetree/bindings/power/qcom,rpmhpd.txt | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
new file mode 100644
index 000000000000..41ef7afa6b24
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
@@ -0,0 +1,65 @@
+Qualcomm RPMh Power domains
+
+For RPMh Power domains, we communicate a performance state to RPMh
+which then translates it into a corresponding voltage on a rail
+
+Required Properties:
+ - compatible: Should be one of the following
+	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
+ - power-domain-cells: number of cells in power domain specifier
+	must be 1
+ - operating-points-v2: Phandle to the OPP table for the power-domain.
+	Refer to Documentation/devicetree/bindings/power/power_domain.txt
+	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
+
+Example:
+
+	rpmhpd: power-controller {
+		compatible = "qcom,sdm845-rpmhpd";
+		#power-domain-cells = <1>;
+		operating-points-v2 = <&rpmhpd_opp_table>;
+	};
+
+	rpmhpd_opp_table: opp-table {
+		compatible = "operating-points-v2-qcom-level";
+
+		rpmhpd_opp_ret: opp1 {
+			qcom-level = <16>;
+		};
+
+		rpmhpd_opp_min_svs: opp2 {
+			qcom-level = <48>;
+		};
+
+		rpmhpd_opp_low_svs: opp3 {
+			qcom-level = <64>;
+		};
+
+		rpmhpd_opp_svs: opp4 {
+			qcom-level = <128>;
+		};
+
+		rpmhpd_opp_svs_l1: opp5 {
+			qcom-level = <192>;
+		};
+
+		rpmhpd_opp_nom: opp6 {
+			qcom-level = <256>;
+		};
+
+		rpmhpd_opp_nom_l1: opp7 {
+			qcom-level = <320>;
+		};
+
+		rpmhpd_opp_nom_l2: opp8 {
+			qcom-level = <336>;
+		};
+
+		rpmhpd_opp_turbo: opp9 {
+			qcom-level = <384>;
+		};
+
+		rpmhpd_opp_turbo_l1: opp10 {
+			qcom-level = <416>;
+		};
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

