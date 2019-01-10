Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C81C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BAE2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nobfYyrV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lavHRTNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfAJEDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:03:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfAJEDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:03:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3ABFD6089D; Thu, 10 Jan 2019 04:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547093014;
        bh=NrxqmKgy9sK1yFTElvHRrpBhyobeVUW67RrpwZH/VgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nobfYyrV7VAbqosGje0oBsmG9Somh0fe5v3X5Jc2Wv2sJDlXM9rNjO34v6qoznT1G
         wwq+2jPExyW6R2e/TTe8pynDiLz3Oe47jlcdyOQeZua4FJpSeP/tB4UhFqpP25w+pI
         V+7nZ/PktQGvySgV+VpYnjqvYTcqMtIvOmApkf9Q=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C51E6089D;
        Thu, 10 Jan 2019 04:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547093011;
        bh=NrxqmKgy9sK1yFTElvHRrpBhyobeVUW67RrpwZH/VgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lavHRTNB/ogX/MXWaeTC+D37e72X7i3KuI5ZZ7LTvh7txTbyfzBpx8wLFovqgSEu3
         wXy0sEdYGEnUSIgvcFLahIYQpalgZJqDjkbf3A0kF7ZBD7dxPdMWH+hanive8gk6t9
         +DszjE0zGmzIK3+t/lhnDYqHA1Pu185c8KLtZ5ok=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C51E6089D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v11 6/9] arm64: dts: msm8996: Add rpmpd device node
Date:   Thu, 10 Jan 2019 09:32:06 +0530
Message-Id: <20190110040209.6028-7-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190110040209.6028-1-rnayak@codeaurora.org>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rpmpd device node and its OPP table

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 99b7495455a6..6a882d3efe30 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -306,6 +306,40 @@
 				#clock-cells = <1>;
 			};
 
+			rpmpd: power-controller {
+				compatible = "qcom,msm8996-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>;
+
+				rpmpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmpd_opp1: opp1 {
+						opp-level = <1>;
+					};
+
+					rpmpd_opp2: opp2 {
+						opp-level = <2>;
+					};
+
+					rpmpd_opp3: opp3 {
+						opp-level = <3>;
+					};
+
+					rpmpd_opp4: opp4 {
+						opp-level = <4>;
+					};
+
+					rpmpd_opp5: opp5 {
+						opp-level = <5>;
+					};
+
+					rpmpd_opp6: opp6 {
+						opp-level = <6>;
+					};
+				};
+			};
+
 			pm8994-regulators {
 				compatible = "qcom,rpm-pm8994-regulators";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

