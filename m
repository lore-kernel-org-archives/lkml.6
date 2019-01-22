Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB72C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7192520861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZbdnrdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAVCLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:11:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45181 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfAVCLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:11:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so10270018pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 18:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1XO83hS5mIM+zliejbGlU5+RMOEgguhpigyoHfbkznI=;
        b=vZbdnrddENYDy/zsfrMdd2ZlMRU+a7HWlqn2uv41VxjeM7s0tp45nkIfhIddHDRt75
         WyEmMLXeOHKLpPMqH9JQTVjfhi1JsU4zMYEAmK5uNa35Cm2GUEQiqQ9z9utjzsXSF2Xq
         G/6DT+JvMGMxqXuPl9Y969/DCY2wLyRZkwUQ2VFW3ZSWm5wIec7w5B+FEWQW98oSrr6V
         AntxYjeUqHkfEqy/x2wGVrzWAf8GjzPjHap7tRnd76qz6ifhhkeMrWEdHvLeXruMDYkg
         jFgvZ8VjJN1o1y5Nxtdb/EzyBzcLZist2KFHq1tAUyRlxDVfYtAaK/AZp0I30ve2EiQP
         Q5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XO83hS5mIM+zliejbGlU5+RMOEgguhpigyoHfbkznI=;
        b=Sbsod5iUssq623SNrZ4UC0XphZt3wOrOkHrG5ABd2VckVSExizsTsJMNMdCipa+Q6C
         Kwh1AkUw581iskd2qh1A26IwvRXfpwf8fOKOfQzcdaFFCVkadHc+LiS7v5Lyr94mho45
         7Th2cBB6opKEWWf8YTr7Y4Kz1Tq7SZEIIT1C8fmOSdDyYffbf0wE8kO1r6TKBXQAXzDK
         fGwphvFeqR4ehGXa1++yILwEVzvjC64qCWzGRJqxQvJg/sUVpIHECnud2tAb5Oy+5nx3
         DKqj9u4z8ORrh9mLNbmF6qU1VVRLAtheMjPSdqamxQhLcPnvelWJ343WK3X5myhTZMVT
         Udzg==
X-Gm-Message-State: AJcUukebcWezhVyY97m6h5JqK0h8C822fWZO2ybsHTq+lENhpnRmNgbX
        1FURIzh4Ca9XnJx8IFmLcfM=
X-Google-Smtp-Source: ALg8bN4yP0pWdiYq4MWroLcHIkMUssfxiotSKhkRs8qPtN+WHXdmy9AxV09yFB/mf1/Z2tXS4FEdTg==
X-Received: by 2002:a63:2ac9:: with SMTP id q192mr30264172pgq.58.1548123066709;
        Mon, 21 Jan 2019 18:11:06 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c7sm19907267pfh.18.2019.01.21.18.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 18:11:06 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     p.zabel@pengutronix.de
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
Date:   Mon, 21 Jan 2019 18:10:42 -0800
Message-Id: <20190122021043.25449-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122021043.25449-1-andrew.smirnov@gmail.com>
References: <20190122021043.25449-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver now supports i.MX8MQ, so update bindings accordingly.

Cc: p.zabel@pengutronix.de
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../bindings/reset/fsl,imx7-src.txt           |  7 +-
 include/dt-bindings/reset/imx8mq-reset.h      | 64 +++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index 1ab1d109318e..2ecf33815d18 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -5,7 +5,9 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 Required properties:
-- compatible: Should be "fsl,imx7d-src", "syscon"
+- compatible:
+	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
+	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain SRC interrupt
@@ -44,4 +46,5 @@ Example:
 
 
 For list of all valid reset indicies see
-<dt-bindings/reset/imx7-reset.h>
+<dt-bindings/reset/imx7-reset.h> for i.MX7 and
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
new file mode 100644
index 000000000000..57c592498aa0
--- /dev/null
+++ b/include/dt-bindings/reset/imx8mq-reset.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Zodiac Inflight Innovations
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ */
+
+#ifndef DT_BINDING_RESET_IMX8MQ_H
+#define DT_BINDING_RESET_IMX8MQ_H
+
+#define IMX8MQ_RESET_A53_CORE_POR_RESET0	0
+#define IMX8MQ_RESET_A53_CORE_POR_RESET1	1
+#define IMX8MQ_RESET_A53_CORE_POR_RESET2	2
+#define IMX8MQ_RESET_A53_CORE_POR_RESET3	3
+#define IMX8MQ_RESET_A53_CORE_RESET0		4
+#define IMX8MQ_RESET_A53_CORE_RESET1		5
+#define IMX8MQ_RESET_A53_CORE_RESET2		6
+#define IMX8MQ_RESET_A53_CORE_RESET3		7
+#define IMX8MQ_RESET_A53_DBG_RESET0		8
+#define IMX8MQ_RESET_A53_DBG_RESET1		9
+#define IMX8MQ_RESET_A53_DBG_RESET2		10
+#define IMX8MQ_RESET_A53_DBG_RESET3		11
+#define IMX8MQ_RESET_A53_ETM_RESET0		12
+#define IMX8MQ_RESET_A53_ETM_RESET1		13
+#define IMX8MQ_RESET_A53_ETM_RESET2		14
+#define IMX8MQ_RESET_A53_ETM_RESET3		15
+#define IMX8MQ_RESET_A53_SOC_DBG_RESET		16
+#define IMX8MQ_RESET_A53_L2RESET		17
+#define IMX8MQ_RESET_SW_NON_SCLR_M4C_RST	18
+#define IMX8MQ_RESET_OTG1_PHY_RESET		19
+#define IMX8MQ_RESET_OTG2_PHY_RESET		20
+#define IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N	21
+#define IMX8MQ_RESET_MIPI_DSI_RESET_N		22
+#define IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N	23
+#define IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N	24
+#define IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N	25
+#define IMX8MQ_RESET_PCIEPHY			26
+#define IMX8MQ_RESET_PCIEPHY_PERST		27
+#define IMX8MQ_RESET_PCIE_CTRL_APPS_EN		28
+#define IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF	29
+#define IMX8MQ_RESET_HDMI_PHY_APB_RESET		30
+#define IMX8MQ_RESET_DISP_RESET			31
+#define IMX8MQ_RESET_GPU_RESET			32
+#define IMX8MQ_RESET_VPU_RESET			33
+#define IMX8MQ_RESET_PCIEPHY2			34
+#define IMX8MQ_RESET_PCIEPHY2_PERST		35
+#define IMX8MQ_RESET_PCIE2_CTRL_APPS_EN		36
+#define IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF	37
+#define IMX8MQ_RESET_MIPI_CSI1_CORE_RESET	38
+#define IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET	39
+#define IMX8MQ_RESET_MIPI_CSI1_ESC_RESET	40
+#define IMX8MQ_RESET_MIPI_CSI2_CORE_RESET	41
+#define IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET	42
+#define IMX8MQ_RESET_MIPI_CSI2_ESC_RESET	43
+#define IMX8MQ_RESET_DDRC1_PRST			44
+#define IMX8MQ_RESET_DDRC1_CORE_RESET		45
+#define IMX8MQ_RESET_DDRC1_PHY_RESET		46
+#define IMX8MQ_RESET_DDRC2_PRST			47
+#define IMX8MQ_RESET_DDRC2_CORE_RESET		48
+#define IMX8MQ_RESET_DDRC2_PHY_RESET		49
+
+#define IMX8MQ_RESET_NUM			50
+
+#endif
-- 
2.20.1

