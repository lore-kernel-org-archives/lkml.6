Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FDAC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A0F218D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lFwo9XP1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FTY1lxRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbfA3Qgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:36:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731496AbfA3Qgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:36:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E212A60907; Wed, 30 Jan 2019 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866194;
        bh=VdNJy7Z7v92HyQi92wnjWkdtmZlPvY9hm1ZNitrJkSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFwo9XP1w4tgoDD81zxc7EYcDt/10EwbJfLCnCfS2BfOAJSa9ctakEJeq6tYRhQT0
         C2ZLlo8wAoDNdGy9zP+ZlgYutGTlCUs1xVwHZDOSQcf0BQhsK3iHYwEJlDLGesuEnn
         FrHuM/mOVyVKswHLaraEA7dYPJIPm4IlE9Ck7tYw=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7221260B7E;
        Wed, 30 Jan 2019 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866192;
        bh=VdNJy7Z7v92HyQi92wnjWkdtmZlPvY9hm1ZNitrJkSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTY1lxRLw8S/+egBIvj3gLV6ZsF98YfGNCSpXPxSYtStN74SBtcuCvEfME3yiSkww
         F9E20gLH9UqWt57ehdNqJJhLcxuoE768vuYkOK45D3Z/WeUvYbITnEYMWaN9hQp+DD
         yGj1OkgtA+14Xq2b0Qy6FA9nHOEKKlqULrxjGQ8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7221260B7E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     marc.w.gonzalez@free.fr, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1 4/4] arm64: dts: qcom: msm8998: Add mmcc node
Date:   Wed, 30 Jan 2019 09:36:24 -0700
Message-Id: <1548866184-30378-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSM8998 Multimedia Clock Controller DT node.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 7136ab1..5673a65 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -814,6 +814,21 @@
 			status = "disabled";
 		};
 
+		mmcc: clock-controller@c8c0000 {
+			compatible = "qcom,mmcc-msm8998";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x0c8c0000 0x40000>;
+
+			clock-names =
+				"xo",
+				"gpll0";
+			clocks =
+				<&rpmcc RPM_SMD_XO_CLK_SRC>,
+				<&gcc GPLL0_OUT_MAIN>;
+		};
+
 		timer@17920000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

