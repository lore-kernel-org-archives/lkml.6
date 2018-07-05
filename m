Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA18C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642DB24116
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RWCIOT0V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RWCIOT0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642DB24116
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeGEGzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:55:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44998 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753236AbeGEGzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:55:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D1AE5606AC; Thu,  5 Jul 2018 06:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530773740;
        bh=dI4X9crxTaw0Ng6i5l8DwD8OV4ILq+ZB4N2xjL1kBWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWCIOT0Vqx3Y7eBPNmL1hNBeLka9eUppggNo4/SEcjv2MGhwB/ns7d3UJRfzM/LLz
         qgKBkpPuSbTOhHWc/1ImANfRYKhbjpuuf9zcW3Xket8gHD01msnIbF1qZXb6HXkKmL
         MAKSSCMyxrOJYHPRvwcsZV+8uzYNBZf4SjwzPDVg=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79B42606AC;
        Thu,  5 Jul 2018 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530773740;
        bh=dI4X9crxTaw0Ng6i5l8DwD8OV4ILq+ZB4N2xjL1kBWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWCIOT0Vqx3Y7eBPNmL1hNBeLka9eUppggNo4/SEcjv2MGhwB/ns7d3UJRfzM/LLz
         qgKBkpPuSbTOhHWc/1ImANfRYKhbjpuuf9zcW3Xket8gHD01msnIbF1qZXb6HXkKmL
         MAKSSCMyxrOJYHPRvwcsZV+8uzYNBZf4SjwzPDVg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79B42606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohitkr@codeaurora.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 1/2] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Thu,  5 Jul 2018 12:25:20 +0530
Message-Id: <1530773721-14668-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530773721-14668-1-git-send-email-tdas@codeaurora.org>
References: <1530773721-14668-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Low Power Audio subsystem clock controller for
Qualcomm Technology Inc's SDM845 SoCs.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,lpasscc.txt     | 22 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,lpass-sdm845.h      | 18 ++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
new file mode 100644
index 0000000..fe7378b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
@@ -0,0 +1,22 @@
+Qualcomm LPASS Clock Controller Binding
+-----------------------------------------------
+
+Required properties :
+- compatible	: shall contain "qcom,sdm845-lpasscc"
+- #clock-cells	: from common clock binding, shall contain 1.
+- reg		: shall contain base register address and size.
+- reg-names	: shall contain the register names of LPASS domain
+			"lpass_gcc", "lpass_cc", "lpass_qdsp6ss".
+
+Example:
+
+The below node has to be defined in the cases where the LPASS peripheral loader
+would bring the subsystem out of reset.
+
+	lpasscc: clock-controller {
+		compatible = "qcom,sdm845-lpasscc";
+		reg = <0x00147000 0x20>, <0x17014000 0x1f004>,
+			<0x17300020 0x20>;
+		reg-names = "lpass_gcc", "lpass_cc", "lpass_qdsp6ss";
+		#clock-cells = <1>;
+	};
diff --git a/include/dt-bindings/clock/qcom,lpass-sdm845.h b/include/dt-bindings/clock/qcom,lpass-sdm845.h
new file mode 100644
index 0000000..b9d816e
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,lpass-sdm845.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+
+#define GCC_LPASS_Q6_AXI_CLK				0
+#define GCC_LPASS_SWAY_CLK				1
+#define LPASS_AUDIO_WRAPPER_AON_CLK			2
+#define LPASS_Q6SS_AHBM_AON_CLK				3
+#define LPASS_Q6SS_AHBS_AON_CLK				4
+#define LPASS_QDSP6SS_XO_CLK				5
+#define LPASS_QDSP6SS_SLEEP_CLK				6
+#define LPASS_QDSP6SS_CORE_CLK				7
+
+#endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

