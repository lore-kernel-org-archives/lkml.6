Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9678ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F1220881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZrXzxzza";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GmJrY0NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F1220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbeGWM1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:27:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55102 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbeGWM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:27:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 37F9D60481; Mon, 23 Jul 2018 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532345212;
        bh=uo4Ljf/BVHXVCf0ItcFEUWNkQ7XjxOo5gLjIBueQIYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrXzxzza2C2pzu2QAguDVgAPL7ew19Zob2QDp8op4XdwlIxcIaslj7eQcK/ZSi2St
         XNGzxQLo6u9dMhQ1FefGgxhheoKDwc95OwgsGXXHyDSO2QqX17XdvvaoZOxmc6guoS
         qbr20PYU6Y7tvzlyiVITWwEbZezBqO/xGjPvtatk=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A74D560B12;
        Mon, 23 Jul 2018 11:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532345211;
        bh=uo4Ljf/BVHXVCf0ItcFEUWNkQ7XjxOo5gLjIBueQIYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmJrY0NJTdFQjUHJNkaJHgWgLVy5e+tHl2KWPdgzRRORcN7b4oxeYe0PIyy7rgQ/B
         /VUSOuhzIjUgp6aH89FqISV9sKg2hF1K7wAn1NPPdbr3HGFKQ836vpyEGFSQdTvYrN
         yZQH7Mfl0wz0299eVqNiha7ySK6vrWnolOU5spuk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A74D560B12
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: clock: Introduce QCOM Camera clock bindings
Date:   Mon, 23 Jul 2018 16:56:32 +0530
Message-Id: <1532345193-18108-2-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532345193-18108-1-git-send-email-anischal@codeaurora.org>
References: <1532345193-18108-1-git-send-email-anischal@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for camera clock controller for
Qualcomm Technology Inc's SDM845 SoCs.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,camcc.txt       |  18 ++++
 include/dt-bindings/clock/qcom,camcc-sdm845.h      | 116 +++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc.txt
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sdm845.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,camcc.txt b/Documentation/devicetree/bindings/clock/qcom,camcc.txt
new file mode 100644
index 0000000..c5eb669
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,camcc.txt
@@ -0,0 +1,18 @@
+Qualcomm Camera Clock & Reset Controller Binding
+------------------------------------------------
+
+Required properties :
+- compatible : shall contain "qcom,sdm845-camcc".
+- reg : shall contain base register location and length.
+- #clock-cells : from common clock binding, shall contain 1.
+- #reset-cells : from common reset binding, shall contain 1.
+- #power-domain-cells : from generic power domain binding, shall contain 1.
+
+Example:
+	camcc: clock-controller@ad00000 {
+		compatible = "qcom,sdm845-camcc";
+		reg = <0xad00000 0x10000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		#power-domain-cells = <1>;
+	};
diff --git a/include/dt-bindings/clock/qcom,camcc-sdm845.h b/include/dt-bindings/clock/qcom,camcc-sdm845.h
new file mode 100644
index 0000000..4f7a2d2
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,camcc-sdm845.h
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_CAM_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_CAM_CC_SDM845_H
+
+/* CAM_CC clock registers */
+#define CAM_CC_BPS_AHB_CLK				0
+#define CAM_CC_BPS_AREG_CLK				1
+#define CAM_CC_BPS_AXI_CLK				2
+#define CAM_CC_BPS_CLK					3
+#define CAM_CC_BPS_CLK_SRC				4
+#define CAM_CC_CAMNOC_ATB_CLK				5
+#define CAM_CC_CAMNOC_AXI_CLK				6
+#define CAM_CC_CCI_CLK					7
+#define CAM_CC_CCI_CLK_SRC				8
+#define CAM_CC_CPAS_AHB_CLK				9
+#define CAM_CC_CPHY_RX_CLK_SRC				10
+#define CAM_CC_CSI0PHYTIMER_CLK				11
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC			12
+#define CAM_CC_CSI1PHYTIMER_CLK				13
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC			14
+#define CAM_CC_CSI2PHYTIMER_CLK				15
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC			16
+#define CAM_CC_CSI3PHYTIMER_CLK				17
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC			18
+#define CAM_CC_CSIPHY0_CLK				19
+#define CAM_CC_CSIPHY1_CLK				20
+#define CAM_CC_CSIPHY2_CLK				21
+#define CAM_CC_CSIPHY3_CLK				22
+#define CAM_CC_FAST_AHB_CLK_SRC				23
+#define CAM_CC_FD_CORE_CLK				24
+#define CAM_CC_FD_CORE_CLK_SRC				25
+#define CAM_CC_FD_CORE_UAR_CLK				26
+#define CAM_CC_ICP_APB_CLK				27
+#define CAM_CC_ICP_ATB_CLK				28
+#define CAM_CC_ICP_CLK					29
+#define CAM_CC_ICP_CLK_SRC				30
+#define CAM_CC_ICP_CTI_CLK				31
+#define CAM_CC_ICP_TS_CLK				32
+#define CAM_CC_IFE_0_AXI_CLK				33
+#define CAM_CC_IFE_0_CLK				34
+#define CAM_CC_IFE_0_CLK_SRC				35
+#define CAM_CC_IFE_0_CPHY_RX_CLK			36
+#define CAM_CC_IFE_0_CSID_CLK				37
+#define CAM_CC_IFE_0_CSID_CLK_SRC			38
+#define CAM_CC_IFE_0_DSP_CLK				39
+#define CAM_CC_IFE_1_AXI_CLK				40
+#define CAM_CC_IFE_1_CLK				41
+#define CAM_CC_IFE_1_CLK_SRC				42
+#define CAM_CC_IFE_1_CPHY_RX_CLK			43
+#define CAM_CC_IFE_1_CSID_CLK				44
+#define CAM_CC_IFE_1_CSID_CLK_SRC			45
+#define CAM_CC_IFE_1_DSP_CLK				46
+#define CAM_CC_IFE_LITE_CLK				47
+#define CAM_CC_IFE_LITE_CLK_SRC				48
+#define CAM_CC_IFE_LITE_CPHY_RX_CLK			49
+#define CAM_CC_IFE_LITE_CSID_CLK			50
+#define CAM_CC_IFE_LITE_CSID_CLK_SRC			51
+#define CAM_CC_IPE_0_AHB_CLK				52
+#define CAM_CC_IPE_0_AREG_CLK				53
+#define CAM_CC_IPE_0_AXI_CLK				54
+#define CAM_CC_IPE_0_CLK				55
+#define CAM_CC_IPE_0_CLK_SRC				56
+#define CAM_CC_IPE_1_AHB_CLK				57
+#define CAM_CC_IPE_1_AREG_CLK				58
+#define CAM_CC_IPE_1_AXI_CLK				59
+#define CAM_CC_IPE_1_CLK				60
+#define CAM_CC_IPE_1_CLK_SRC				61
+#define CAM_CC_JPEG_CLK					62
+#define CAM_CC_JPEG_CLK_SRC				63
+#define CAM_CC_LRME_CLK					64
+#define CAM_CC_LRME_CLK_SRC				65
+#define CAM_CC_MCLK0_CLK				66
+#define CAM_CC_MCLK0_CLK_SRC				67
+#define CAM_CC_MCLK1_CLK				68
+#define CAM_CC_MCLK1_CLK_SRC				69
+#define CAM_CC_MCLK2_CLK				70
+#define CAM_CC_MCLK2_CLK_SRC				71
+#define CAM_CC_MCLK3_CLK				72
+#define CAM_CC_MCLK3_CLK_SRC				73
+#define CAM_CC_PLL0					74
+#define CAM_CC_PLL0_OUT_EVEN				75
+#define CAM_CC_PLL1					76
+#define CAM_CC_PLL1_OUT_EVEN				77
+#define CAM_CC_PLL2					78
+#define CAM_CC_PLL2_OUT_EVEN				79
+#define CAM_CC_PLL3					80
+#define CAM_CC_PLL3_OUT_EVEN				81
+#define CAM_CC_SLOW_AHB_CLK_SRC				82
+#define CAM_CC_SOC_AHB_CLK				83
+#define CAM_CC_SYS_TMR_CLK				84
+
+/* CAM_CC Resets */
+#define TITAN_CAM_CC_CCI_BCR				0
+#define TITAN_CAM_CC_CPAS_BCR				1
+#define TITAN_CAM_CC_CSI0PHY_BCR			2
+#define TITAN_CAM_CC_CSI1PHY_BCR			3
+#define TITAN_CAM_CC_CSI2PHY_BCR			4
+#define TITAN_CAM_CC_MCLK0_BCR				5
+#define TITAN_CAM_CC_MCLK1_BCR				6
+#define TITAN_CAM_CC_MCLK2_BCR				7
+#define TITAN_CAM_CC_MCLK3_BCR				8
+#define TITAN_CAM_CC_TITAN_TOP_BCR			9
+
+/* CAM_CC GDSCRs */
+#define BPS_GDSC					0
+#define IPE_0_GDSC					1
+#define IPE_1_GDSC					2
+#define IFE_0_GDSC					3
+#define IFE_1_GDSC					4
+#define TITAN_TOP_GDSC					5
+
+#endif
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

