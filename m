Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622E7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34228218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ve8WgYCb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ve8WgYCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbeLUI4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:56:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35866 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeLUI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:56:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BC4CF6099A; Fri, 21 Dec 2018 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382612;
        bh=s0/suJBH2IfhJj7iSyxO9HP2T/XZo8zDDF3NTtoE29c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ve8WgYCbk8mmSmVQ0837s9YXaPFxG974PZijBDSEA8CDtpNZKZMr5VOR1RtyKtt8W
         uRbartXCKQ6Ce9WasnlE4/5bPiwhgmneiuFop/nuqj8QxW54QIvwYIk0L6oFMIE0T6
         FENTqDnyj349988XE0yG1z1DDDlE/S8+/PjnrT50=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4BF760986;
        Fri, 21 Dec 2018 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382612;
        bh=s0/suJBH2IfhJj7iSyxO9HP2T/XZo8zDDF3NTtoE29c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ve8WgYCbk8mmSmVQ0837s9YXaPFxG974PZijBDSEA8CDtpNZKZMr5VOR1RtyKtt8W
         uRbartXCKQ6Ce9WasnlE4/5bPiwhgmneiuFop/nuqj8QxW54QIvwYIk0L6oFMIE0T6
         FENTqDnyj349988XE0yG1z1DDDlE/S8+/PjnrT50=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4BF760986
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 05/10] arm64: dts: msm8996: Add rpmpd device node
Date:   Fri, 21 Dec 2018 14:26:17 +0530
Message-Id: <20181221085622.25573-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221085622.25573-1-rnayak@codeaurora.org>
References: <20181221085622.25573-1-rnayak@codeaurora.org>
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
index 99b7495455a6..cac70623600f 100644
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
+					compatible = "operating-points-v2-qcom-level";
+
+					rpmpd_opp1: opp1 {
+						qcom,level = <1>;
+					};
+
+					rpmpd_opp2: opp2 {
+						qcom,level = <2>;
+					};
+
+					rpmpd_opp3: opp3 {
+						qcom,level = <3>;
+					};
+
+					rpmpd_opp4: opp4 {
+						qcom,level = <4>;
+					};
+
+					rpmpd_opp5: opp5 {
+						qcom,level = <5>;
+					};
+
+					rpmpd_opp6: opp6 {
+						qcom,level = <6>;
+					};
+				};
+			};
+
 			pm8994-regulators {
 				compatible = "qcom,rpm-pm8994-regulators";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

