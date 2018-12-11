Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748ACC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390CB2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DqPz1H1a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OxF4abvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390CB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeLKJuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:50:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:50:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4B21E60C1C; Tue, 11 Dec 2018 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544521810;
        bh=Bmrm2uELhX1mfUyCb/miFKGE2BZx9ncBYxVPXqqq9+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqPz1H1aBd1vWxJaC+A3NnzdkS1tNKOzeSYFx42GtgMzMd1eD5N6AZrZ5SOMJuhws
         Z0cquu5Le35RQtdS4JaYl/Ogn7vBPmuyA1o26Bskb2DpD5iMzHvGqWI1+szmbr4aD/
         UeXwehZxYh+9OF6PBh65lr7FzYswBPLM5SGft+FM=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B67E60B13;
        Tue, 11 Dec 2018 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544521808;
        bh=Bmrm2uELhX1mfUyCb/miFKGE2BZx9ncBYxVPXqqq9+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxF4abvse2LEfHDhWg3+M3MpOYAvS21MLmVm3PYqSqqyAjOVIlYAIxwBAEtg0Y9sf
         6iLoFmSdDYpV2nUSZHhTp2RTcVpDTwcX3sRDQETGW6UWD5V21DSQ5uYBrsglZY3lY3
         7XTTg/7MuRcP2xrhwid6VMpMsX3FE/mSxdRGafS8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B67E60B13
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 05/10] arm64: dts: msm8996: Add rpmpd device node
Date:   Tue, 11 Dec 2018 15:19:33 +0530
Message-Id: <20181211094938.25086-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181211094938.25086-1-rnayak@codeaurora.org>
References: <20181211094938.25086-1-rnayak@codeaurora.org>
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
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b29fe80d7288..e4a84d11ace3 100644
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

