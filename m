Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A8C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58F920878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IGPYiFJj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AdOb6Xl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58F920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392747AbeKVScV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:32:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48866 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeKVScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:32:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7940B60246; Thu, 22 Nov 2018 07:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542873244;
        bh=vIcHLOODA1NSO582Xi24INnmECri/bxsxQU3R0ul7jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGPYiFJjimqMo6gAGT3/kmnw3FlfZSqZH08JQQZ2Xu0YswpYPlQe4JnEvVY1w9kYH
         DYPweoZar/CXgwyh1oyVl/ro0mtRvJiDfWwhnVc0J2l+AFTtyDmpTx/KhI+rpOL+bo
         tlao+IAAqtV2Hax2hygltJ5Oz+8XbxkOGQRWKDd0=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EB2F604BE;
        Thu, 22 Nov 2018 07:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542873243;
        bh=vIcHLOODA1NSO582Xi24INnmECri/bxsxQU3R0ul7jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdOb6Xl59c6qAW7/BL4oA6Ohnf1CpGzLOhR0qCdMnd9h9Es5eO95OMwtYzZfjgByU
         aP+sGwl2JI62F7job0YgaPZ9jNnU82L/wUD4e5Jx1oNwMBsv0PqqqX1Nz6lbWU1xEj
         bZ7o5uzhpD9I2Llni3A0N2X8RNSxjFwF1+W4RHLY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EB2F604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v10 1/3] dt-bindings: clock: Update GCC bindings for protected-clocks
Date:   Thu, 22 Nov 2018 13:23:39 +0530
Message-Id: <1542873221-13693-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
References: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add protected-clocks list which could used to specify the clocks to be
bypassed on certain devices.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 Documentation/devicetree/bindings/clock/qcom,gcc.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
index 52d9345..5e37de9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
@@ -35,6 +35,8 @@ be part of GCC and hence the TSENS properties can also be
 part of the GCC/clock-controller node.
 For more details on the TSENS properties please refer
 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+- protected-clocks : Protected clock specifier list as per common clock
+ binding.

 Example:
 	clock-controller@900000 {
@@ -55,3 +57,15 @@ Example of GCC with TSENS properties:
 		#reset-cells = <1>;
 		#thermal-sensor-cells = <1>;
 	};
+
+Example of GCC with protected-clocks properties:
+	clock-controller@100000 {
+		compatible = "qcom,gcc-sdm845";
+		reg = <0x100000 0x1f0000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		#power-domain-cells = <1>;
+		protected-clocks = <GCC_QSPI_CORE_CLK>,
+				   <GCC_QSPI_CORE_CLK_SRC>,
+				   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
+	};
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

