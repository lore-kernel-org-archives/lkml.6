Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 16C15C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E19208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nem0ZHA7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aVGLN0IC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E19208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754897AbeFNHj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:39:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeFNHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:39:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D85C606DB; Thu, 14 Jun 2018 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528961962;
        bh=uQ08No0lca6oq9fk5/Cuz44bX7rpuwp8VoIqDybX+To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nem0ZHA7dat0QUPSWUwFze3xymYkQYiQCAwZbiWp+0GNt9KyNaEK3F2gcwo0l5gyd
         occPRRus+A/nptJiw5viPGyye0ifQKIAXXaTGlKYeafpgC0IxhVf1WiZeW2RVVcMeA
         lbmB+X0a0R54DuwYvrJIW9Hpw59Rt7NNcaCnZ2R4=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C01C60116;
        Thu, 14 Jun 2018 07:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528961961;
        bh=uQ08No0lca6oq9fk5/Cuz44bX7rpuwp8VoIqDybX+To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVGLN0ICIxDPKd4uXhfwN+Xf7Fg6zhcJqbadJtvZGLaFGM77emhoB+WYIZKG3pCiR
         g/6Pg6R2mNufBw0ejhIf37/xPxuozuUe6ZMF1/e99Ia605RztGJ33S2A5k/6zGe+RB
         dpUjYrhC3arAxEMgYlGw6a/3lkZs3e8xXPaB2DEQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C01C60116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rohit Kumar <rohitkr@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Thu, 14 Jun 2018 13:09:02 +0530
Message-Id: <1528961943-12506-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528961943-12506-1-git-send-email-tdas@codeaurora.org>
References: <1528961943-12506-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Low Power Audio subsystem clock controller for
Qualcomm Technology Inc's SDM845 SoCs.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,lpasscc.txt     | 46 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,lpass-sdm845.h      | 18 +++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
new file mode 100644
index 0000000..16cabc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
@@ -0,0 +1,46 @@
+Qualcomm LPASS Clock Controller Binding
+-----------------------------------------------
+
+Required properties :
+- compatible	: shall contain "qcom,sdm845-lpasscc"
+- #clock-cells	: from common clock binding, shall contain 1.
+
+Note that #address-cells, #size-cells, and ranges shall be present to ensure
+the lpasscc can address the various lpass cc registers.
+
+Child Node Properties :
+The Low Pass Audio clock controller would need to define the following child
+nodes with the properties.
+- compatible	: shall contain all of the below for clocks in each LPASS domain
+			"qcom,sdm845-lpass-gcc",
+			"qcom,sdm845-lpass-cc",
+			"qcom,sdm845-lpass-qdsp6ss"
+- reg		: shall contain base register address and size,
+
+Example:
+
+The below node has to be defined in the cases where the LPASS peripheral loader
+would bring the subsystem out of reset.
+
+	lpasscc: clock-controller {
+		compatible = "qcom,sdm845-lpasscc";
+			#clock-cells = <1>;
+	                #address-cells = <1>;
+		        #size-cells = <1>;
+			ranges;
+
+			lpass_gcc@100000 {
+				compatible = "qcom,sdm845-lpass-gcc";
+				reg = <0x00147000 0x20>;
+			};
+
+			lpass@17014000 {
+				compatible = "qcom,sdm845-lpass-cc";
+				reg = <0x17014000 0x1f004>;
+			};
+
+			lpass_q6@17300020 {
+				compatible = "qcom,sdm845-lpass-qdsp6ss";
+				reg = <0x17300020 0x20>;
+			};
+		 };
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

