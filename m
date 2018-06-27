Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9626BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4760A2679D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FgeWw2nb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="igLxrqst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4760A2679D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932959AbeF0ExX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 00:53:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932829AbeF0ExT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 00:53:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5DE73608C8; Wed, 27 Jun 2018 04:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530075199;
        bh=fjLrrUiMAJKwEa/s3RKT9toZJzOvEFOUJ9StJB/xuwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgeWw2nbp7u5d/+TYMY5PQ+fE69b9/uVe3WrOd/DLUwEkhD3Cb+WXyU6XXI1KOI4X
         ofRu0Y0P1fUZ6slMaaNvWTwZzy/+Jb1BP7qgYnfy293R7s93yi6diYcC+0CGQVTabT
         Q2RpqXcLSzqF2jTKO9T5yu6ddW5vH2tJroGU86G8=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB93660791;
        Wed, 27 Jun 2018 04:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530075198;
        bh=fjLrrUiMAJKwEa/s3RKT9toZJzOvEFOUJ9StJB/xuwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igLxrqsta2mtTaO0mpjZql/eBLP2TdekWhuQFk/+y67GBVKPF0Sl1siI0IGBkI3Di
         NBDoOfUQqwerYy82RsHiS2xXzAzXnrf84jKNn2Wib+lnAm6bAXWyOsZECb1Gvjwc8y
         ePTMOi+cwe/f8jMaFiCA4BkyobY+5N8q6WWfKGzQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB93660791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 5/6] arm64: dts: msm8996: Add rpmpd device node
Date:   Wed, 27 Jun 2018 10:22:33 +0530
Message-Id: <20180627045234.27403-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180627045234.27403-1-rnayak@codeaurora.org>
References: <20180627045234.27403-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rpmpd device node and its OPP table

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8c7f9ca25b53..404a08630ccd 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -308,6 +308,40 @@
 				#clock-cells = <1>;
 			};
 
+			rpmpd: power-controller {
+				compatible = "qcom,msm8996-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>;
+			};
+
+			rpmpd_opp_table: opp-table {
+				compatible = "operating-points-v2-qcom-level";
+
+				rpmpd_opp1: opp1 {
+					qcom,level = <1>;
+				};
+
+				rpmpd_opp2: opp2 {
+					qcom,level = <2>;
+				};
+
+				rpmpd_opp3: opp3 {
+					qcom,level = <3>;
+				};
+
+				rpmpd_opp4: opp4 {
+					qcom,level = <4>;
+				};
+
+				rpmpd_opp5: opp5 {
+					qcom,level = <5>;
+				};
+
+				rpmpd_opp6: opp6 {
+					qcom,level = <6>;
+				};
+			};
+
 			pm8994-regulators {
 				compatible = "qcom,rpm-pm8994-regulators";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

