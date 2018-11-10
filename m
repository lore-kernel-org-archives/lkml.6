Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C9C0044C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9BB20825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dttLnHDX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="epnLVVEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9BB20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeKJL15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:27:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35786 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbeKJL15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:27:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3EA660B7A; Sat, 10 Nov 2018 01:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541814282;
        bh=gRcQJX5hNE2aXTIAbK72iHPaH0wPP+Q2aAIzYtOtr8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dttLnHDXnZBadAK9/j8hqtZKu4FzfPZTrCIeNW1ohQ5Xy8FxYWiHFMoUYkn0g6Qh4
         C42Lkn95+B4mReVoAlEavio9y9PMC6BIi8eMkTqOEcL2mlC2L+GD7Ew7rDPC5jaUiz
         2pJTMdsjlGICye8YG/LkDMy0SEiIbaoZx+otnB2g=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 615316032C;
        Sat, 10 Nov 2018 01:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541814281;
        bh=gRcQJX5hNE2aXTIAbK72iHPaH0wPP+Q2aAIzYtOtr8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epnLVVEZ3wJbzdimxHFrI9YxEoC7D0HYIwcnZBxges/YlQ+NCpaKY/8SaJOBkJsj1
         072kh7mt1sdB5G6yPR5WrBWbEO9BEP4f+KxyhMED4AKbSQtkv6tM72vY7ojNyRsgjh
         1BJzaC/yb5cvAaPMAgUFvmRmXaSOwJLOaqsDI6VQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 615316032C
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
Subject: [PATCH v9 1/2] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Sat, 10 Nov 2018 07:14:15 +0530
Message-Id: <1541814256-23254-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541814256-23254-1-git-send-email-tdas@codeaurora.org>
References: <1541814256-23254-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Low Power Audio subsystem clock controller for
Qualcomm Technology Inc's SDM845 SoCs.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,gcc.txt         | 16 +++++++++++++
 .../devicetree/bindings/clock/qcom,lpasscc.txt     | 26 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |  2 ++
 include/dt-bindings/clock/qcom,lpass-sdm845.h      | 16 +++++++++++++
 4 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
index 52d9345..8661c3c 100644
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
@@ -55,3 +57,17 @@ Example of GCC with TSENS properties:
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
+				   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+				   <GCC_LPASS_Q6_AXI_CLK>,
+				   <GCC_LPASS_SWAY_CLK>;
+	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
new file mode 100644
index 0000000..b9e9787
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
@@ -0,0 +1,26 @@
+Qualcomm LPASS Clock Controller Binding
+-----------------------------------------------
+
+Required properties :
+- compatible		: shall contain "qcom,sdm845-lpasscc"
+- #clock-cells		: from common clock binding, shall contain 1.
+- reg			: shall contain base register address and size,
+			  in the order
+			Index-0 maps to LPASS_CC register region
+			Index-1 maps to LPASS_QDSP6SS register region
+
+Optional properties :
+- reg-names	: register names of LPASS domain
+		 "cc", "qdsp6ss".
+
+Example:
+
+The below node has to be defined in the cases where the LPASS peripheral loader
+would bring the subsystem out of reset.
+
+	lpasscc: clock-controller@17014000 {
+		compatible = "qcom,sdm845-lpasscc";
+		reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
+		reg-names = "cc", "qdsp6ss";
+		#clock-cells = <1>;
+	};
diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
index b8eae5a..968fa65 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
@@ -197,6 +197,8 @@
 #define GCC_QSPI_CORE_CLK_SRC					187
 #define GCC_QSPI_CORE_CLK					188
 #define GCC_QSPI_CNOC_PERIPH_AHB_CLK				189
+#define GCC_LPASS_Q6_AXI_CLK					190
+#define GCC_LPASS_SWAY_CLK					191

 /* GCC Resets */
 #define GCC_MMSS_BCR						0
diff --git a/include/dt-bindings/clock/qcom,lpass-sdm845.h b/include/dt-bindings/clock/qcom,lpass-sdm845.h
new file mode 100644
index 0000000..015968e
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,lpass-sdm845.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+
+#define LPASS_AUDIO_WRAPPER_AON_CLK			0
+#define LPASS_Q6SS_AHBM_AON_CLK				1
+#define LPASS_Q6SS_AHBS_AON_CLK				2
+#define LPASS_QDSP6SS_XO_CLK				3
+#define LPASS_QDSP6SS_SLEEP_CLK				4
+#define LPASS_QDSP6SS_CORE_CLK				5
+
+#endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

