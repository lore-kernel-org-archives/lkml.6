Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1280AC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD31420673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XMs7JY08";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AX65YC8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD31420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLAFcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:32:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40920 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:32:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45B7361306; Fri, 30 Nov 2018 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543602113;
        bh=9DPiOLOPQ5i7vTN2Fv6wT89QVQQRg/2U97xW76903Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMs7JY080BQCamVB8vFDD+gKals421Oj+5SMdQuGddRnzitG87wRX+V7fBtNBWsV+
         W1YniPhh8fHQ3cRSqR1ZyzZTRGOnw/IShQKqnoPHbpHa92+Ko8GSb+f7MFDWWE7JFE
         A4ggVypPYpzPijC/S3TJalDnCJQ9uxp1gfsvclBs=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8C6160C61;
        Fri, 30 Nov 2018 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543602112;
        bh=9DPiOLOPQ5i7vTN2Fv6wT89QVQQRg/2U97xW76903Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AX65YC8+ffUWhWb2K8UEJZp5LMmMxoAUsRRs9nUxRjGJ2Tey4L6IWXL9g/EOtRcYd
         zDo1lcFL5EJOEEGd2ylza1aZ5BTy35dblTqv0L1XqaTJjcOfdvnDI4AfyuwoDlO9B+
         LYT4x2TzJizC/iVYubdSS+rx6UR5NdFesDEKU/9M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8C6160C61
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
Subject: [PATCH v11 2/3] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Fri, 30 Nov 2018 23:51:28 +0530
Message-Id: <1543602089-21086-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543602089-21086-1-git-send-email-tdas@codeaurora.org>
References: <1543602089-21086-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Low Power Audio subsystem clock controller for
Qualcomm Technology Inc's SDM845 SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,gcc.txt         |  4 +++-
 .../devicetree/bindings/clock/qcom,lpasscc.txt     | 26 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |  2 ++
 include/dt-bindings/clock/qcom,lpass-sdm845.h      | 15 +++++++++++++
 4 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
index 5e37de9..8661c3c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
@@ -67,5 +67,7 @@ Example of GCC with protected-clocks properties:
 		#power-domain-cells = <1>;
 		protected-clocks = <GCC_QSPI_CORE_CLK>,
 				   <GCC_QSPI_CORE_CLK_SRC>,
-				   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
+				   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+				   <GCC_LPASS_Q6_AXI_CLK>,
+				   <GCC_LPASS_SWAY_CLK>;
 	};
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
index 0000000..6590508
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,lpass-sdm845.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+
+#define LPASS_Q6SS_AHBM_AON_CLK				0
+#define LPASS_Q6SS_AHBS_AON_CLK				1
+#define LPASS_QDSP6SS_XO_CLK				2
+#define LPASS_QDSP6SS_SLEEP_CLK				3
+#define LPASS_QDSP6SS_CORE_CLK				4
+
+#endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

