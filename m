Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D34C9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8784F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mcrb7dJG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GX8j2PFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8784F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeFLEm3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:42:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932711AbeFLElT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:41:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2D1B6606DB; Tue, 12 Jun 2018 04:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778479;
        bh=q7zi9y0W19hjB9TsL4sEV8qAKA0xd1m7ROX9+9vCSVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcrb7dJGR+B70xIambloob78CNAYbISLMfPgE1rfFegpa27TCJnxPdgUJTQG0WXIj
         C15AH+NI93HwbZZdYtBDQ5sJsLaoNc75WsqFSq6qnHT73pSIq2eTyzmif5yURXSuxA
         Lm41ncpXNLFVXTZOuMtgdti6EJ9AQGT0NgSzYApk=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95334607E4;
        Tue, 12 Jun 2018 04:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778478;
        bh=q7zi9y0W19hjB9TsL4sEV8qAKA0xd1m7ROX9+9vCSVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GX8j2PFTjKK15j7ENMwZcmx4Vbr9+azNTQvFVaCDagBBIiIz1JhMT/grMleFLN1Qk
         On9vMsn1z+7KRYi5rR7O0oOoacSHu2cNUKf+z8XLyteiPB8Ih2tO1KLm6BBxbF6RtJ
         riuBlM2Vqxy3faUcIP+3KlZaSza9dnMoTvAn/5i0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95334607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 4/7] arm64: dts: msm8996: Add rpmpd device node
Date:   Tue, 12 Jun 2018 10:10:49 +0530
Message-Id: <20180612044052.4402-5-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612044052.4402-1-rnayak@codeaurora.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rpmpd device node and its OPP table

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
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

