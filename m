Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E0C65BB3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E5B2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bd0l//6g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QKWBJPYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E5B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLDFVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:21:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLDFVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:21:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 33A7E60A33; Tue,  4 Dec 2018 05:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543900910;
        bh=RaH0QQIKVHYMA7aOVLEDyALnr7ccsWYCH0chY1yqiVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bd0l//6gY1jvLhd+J4Mv3ch+v8lae3sCHlLYtB/C8mdG+BSgYGmnf8G83gOutaXUl
         uzFPLlHPTVNj14YOa9LAd9I1lRPd2NMzJw8MLDDAz1f4SqYaFDzayT+zK9eNsc5Bxh
         WlNuxS26VSDn+i5PZ1yQdRpBV73mGMsi2T+WCzVU=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0036660C4C;
        Tue,  4 Dec 2018 05:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543900908;
        bh=RaH0QQIKVHYMA7aOVLEDyALnr7ccsWYCH0chY1yqiVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKWBJPYDE21cGdnuYG4DmwvYpQrrXOFHr5zfvBiJSavLN8JFaxnScieVGFvseRwi4
         HUkTIqd7lpowGa2yz2loEe6oD5NC1yDentwVHDU9ivEme431Um3DmG2MfI7pvBugYF
         6mGiDT889FE0doVm5EFiiYTRlkdojaNaukhURbsk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0036660C4C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     robh@kernel.org, viresh.kumar@linaro.org, sboyd@kernel.org,
        andy.gross@linaro.org, ulf.hansson@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 5/8] arm64: dts: msm8996: Add rpmpd device node
Date:   Tue,  4 Dec 2018 10:51:16 +0530
Message-Id: <20181204052119.806-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204052119.806-1-rnayak@codeaurora.org>
References: <20181204052119.806-1-rnayak@codeaurora.org>
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
index b29fe80d7288..ed35f0ced699 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -306,6 +306,40 @@
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

