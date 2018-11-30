Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CDBC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B29A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y5MT5MfH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L5YL1IDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B29A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeLAFb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:31:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:31:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DAA9760C4C; Fri, 30 Nov 2018 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543602107;
        bh=JrC73T0VKGO/XZyRCrNZWS0P8IGgDI3khuD6VaFo1cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5MT5MfHsqHBrPZ3fPdve+GQf9ZuKIgrlmWfd6E/6JH+1zjhVqMXVLz5iIZ8wFlYP
         vpRBEUysLJsfOqQOG27LM6QmOPOL0vwAFyP1kJX24/lF61V84iZu7Oeb0fDoQv2xqU
         vLsk6gwqxVjRY0e2U46KmKukvfWotSOPQxZTNY4A=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 703546079C;
        Fri, 30 Nov 2018 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543602106;
        bh=JrC73T0VKGO/XZyRCrNZWS0P8IGgDI3khuD6VaFo1cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5YL1IDYTFOHEklrlL/o5ppWZvP7GTrUIdnXd4lwLrTFzAOK46SVDiafmHWl17DpE
         xj+TLkrh6yMmodWqt86qsLfaD9EE3DH7ekXUetFGB1RfuuzGItQDbXf2xXC2dbEczW
         5b245i6+MDUMbYRRTubh0maMq0uZEve/gTWYE/po=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 703546079C
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
Subject: [PATCH v11 1/3] dt-bindings: clock: Update GCC bindings for protected-clocks
Date:   Fri, 30 Nov 2018 23:51:27 +0530
Message-Id: <1543602089-21086-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543602089-21086-1-git-send-email-tdas@codeaurora.org>
References: <1543602089-21086-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add protected-clocks list which could used to specify the clocks to be
bypassed on certain devices.

Reviewed-by: Rob Herring <robh@kernel.org>
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

