Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F43020879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kt6Hqzcd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ptzjam2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfAJD7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:59:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfAJD7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:59:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4491E609C3; Thu, 10 Jan 2019 03:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092780;
        bh=NrxqmKgy9sK1yFTElvHRrpBhyobeVUW67RrpwZH/VgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kt6HqzcdvestTWs9+LqNhH7NFX2WsxeP1tHs0zk9fElq3pALsT9XuVHvj9b6t2765
         cQw4X7tYe7YBU4Q+qBuk/DZbArpvC5lURYjcQtUOy2KNH3yN/8xUDaspQmQfWceOT6
         CQ30T0o/+hIMdykbg+HcbgQQ6q0X1euNuldsytYY=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6CB260987;
        Thu, 10 Jan 2019 03:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092777;
        bh=NrxqmKgy9sK1yFTElvHRrpBhyobeVUW67RrpwZH/VgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ptzjam2nnED+tto8T3WilDchn3THTKk8/jZ/6oTG7E8WWrzDKsm278Wo55nBQmPJM
         O+OF+qFCxWZi8ngTaeyU3zqwzf1qfvu2fb1rLLI7qZkzjZrY8+mDwF1wF3wX3EehJu
         b5yKnQatLlhd9RniBtprKuWsE2lJ3SXJftw/x4ic=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6CB260987
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v10 6/9] arm64: dts: msm8996: Add rpmpd device node
Date:   Thu, 10 Jan 2019 09:28:49 +0530
Message-Id: <20190110035852.5666-7-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190110035852.5666-1-rnayak@codeaurora.org>
References: <20190110035852.5666-1-rnayak@codeaurora.org>
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

