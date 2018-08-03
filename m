Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B356C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3FB21759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RtN5iJFt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OHYS7FWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3FB21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeHCORj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:17:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48128 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeHCORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:17:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C3BA60117; Fri,  3 Aug 2018 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298892;
        bh=45/o71f281ucZi+mFTcCrbV8RrC/HPVGKC1ecz1P5+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtN5iJFtqlXViE0efEPvUarN39/3GTZNSgJbS1TnWTxme+PYmeoy3y7VgGvI2kQ8R
         OEFfOOFEMfrlJsIaydzlPYLzEWIo0c5MqBGVw7IzNFLZQbRSywK50OPeRwiQwv9rp+
         7ZckE91UAbXlEbFRsVGRDw1/acHGg+Crzk5s6Djk=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A05D6071C;
        Fri,  3 Aug 2018 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298891;
        bh=45/o71f281ucZi+mFTcCrbV8RrC/HPVGKC1ecz1P5+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHYS7FWEVOO7Ih2tKVpM2Qo1rrw9H4asRNrJeZcMCTA07hcevsMDU7NM4xxpfBIRb
         zHTgdyQB4HDRSzknADcJx2WCNlTVSr/EjRmFCGnMc9qlbptJ0/fgsCUozFF1SpnGXN
         w5UNYZjIN9LuzuQKvKXq/xbj1J01uhgyrfFYyDC4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A05D6071C
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
        robh@kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v3 1/2] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Fri,  3 Aug 2018 17:51:13 +0530
Message-Id: <1533298874-22863-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533298874-22863-1-git-send-email-tdas@codeaurora.org>
References: <1533298874-22863-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Low Power Audio subsystem clock controller for
Qualcomm Technology Inc's SDM845 SoCs.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,gcc.txt         |  2 ++
 .../devicetree/bindings/clock/qcom,lpasscc.txt     | 33 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |  2 ++
 include/dt-bindings/clock/qcom,lpass-sdm845.h      | 16 +++++++++++
 4 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
index 664ea1f..e452abc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
@@ -32,6 +32,8 @@ be part of GCC and hence the TSENS properties can also be
 part of the GCC/clock-controller node.
 For more details on the TSENS properties please refer
 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+- qcom,lpass-protected : Indicate GCC to be able to access the
+			lpass gcc clock branches.

 Example:
 	clock-controller@900000 {
diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
new file mode 100644
index 0000000..062e413
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
@@ -0,0 +1,33 @@
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
+- qcom,lpass-protected	: Boolean property to indicate to GCC clock controller
+			 for the lpass GCC clocks.
+
+Optional properties :
+- reg-names	: register names of LPASS domain
+		 "lpass_cc", "lpass_qdsp6ss".
+
+Example:
+
+The below node has to be defined in the cases where the LPASS peripheral loader
+would bring the subsystem out of reset.
+
+	lpasscc: clock-controller {
+		compatible = "qcom,sdm845-lpasscc";
+		reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
+		reg-names = "lpass_cc", "lpass_qdsp6ss";
+		#clock-cells = <1>;
+	};
+
+	gcc: clock-controller@100000 {
+		compatible = "qcom,gcc-sdm845";
+		qcom,lpass-protected;
+	};
diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
index f96fc2d..66c4267 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
@@ -194,6 +194,8 @@
 #define GPLL4							184
 #define GCC_CPUSS_DVM_BUS_CLK					185
 #define GCC_CPUSS_GNOC_CLK					186
+#define GCC_LPASS_Q6_AXI_CLK					187
+#define GCC_LPASS_SWAY_CLK					188

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

