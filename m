Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC307C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9A220854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ECMsBx1F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gDXZqk8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfAGKKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:10:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56518 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfAGKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:10:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B75760A7E; Mon,  7 Jan 2019 10:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855835;
        bh=VGknM7IwOWjGYLrUbb042qXvuJQSppWSIxoAkiKBUI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECMsBx1F9nPSg3GMfOTPPZuayb8CvVaeOdXueVl1l4tcnCv79gAFjdWSHA3adpVNA
         vgJYs5ovsR/OvkAy55r9RR2WqUPyRAHDUudXUt8mevhaExHkpw7NQx4inEdDz/Az2M
         pNP+Di5i7Gyql6Hjj3+iwrKhH2IoOHJlHx+3sid4=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B79760A41;
        Mon,  7 Jan 2019 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855832;
        bh=VGknM7IwOWjGYLrUbb042qXvuJQSppWSIxoAkiKBUI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDXZqk8pq6hIT/eQWpbhnXRsa0YQMezmNEWt+L6tf502aBz7K6sy/BWDfYCZf5qiU
         MF144+joy/ez3yh2mF8QCfBif16ENmn1tkBOPVrclIPu5/45c0MSNuLVBcnqQSP7Os
         zxQzT5blgndX1E9WzcEJRJ6q7bcez927xkXXadSo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B79760A41
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v9 05/10] arm64: dts: msm8996: Add rpmpd device node
Date:   Mon,  7 Jan 2019 15:39:54 +0530
Message-Id: <20190107100959.14528-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107100959.14528-1-rnayak@codeaurora.org>
References: <20190107100959.14528-1-rnayak@codeaurora.org>
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
index 99b7495455a6..692bb9934e92 100644
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
+					compatible = "operating-points-v2-level";
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

