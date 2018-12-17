Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E1EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB124206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLxEF/1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbeLQCiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:38:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40534 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeLQCiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 21:38:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so5581252pfo.7;
        Sun, 16 Dec 2018 18:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uh13cxGWyYRWSd8I8AhmRl0d9aoQVY0CLYoHi6ibCuA=;
        b=lLxEF/1ZWHt60WLYZEj7iYVE8nQm3ndOlZgvWs8cw6mOfX0VyFkR9C+c/AUuquT1YK
         q9+BqYpa4A973cXyEgG5RZQ/ZFahgEtmQryUNcJvkgcj/6j/RYgK1pXjHE1ZIRf7Wwc3
         Mcb6AnePRvmlmFWdwnkazeVGcjgOTatO/f20DCQVEljOr7bois9/Zjz+ZwdZ0sdlOcg4
         bHY1j2q14i+KNVFzzhV8y/69SqCF5HNHiomUEXMz4dauH+USI2oq/1Sjp5lfgWqxKZso
         y905ACDBDtnWZq9Zo4DW+8hM+//31SStcujnJhcEEqG+qeVtYGpBVqJlv6Rp3pa8GxdH
         875g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uh13cxGWyYRWSd8I8AhmRl0d9aoQVY0CLYoHi6ibCuA=;
        b=jE3bl4honHkWmeSsEML7Pgmnu3BfCxgN4cgFpE288TkullKO3kFb2OF290ETy1Q4pR
         mmKYQ1yBupPA8Y2lvsRPgMqkN6vZDGBpPR1N5BM2oyaTuKG2nnCQH+K+IB/kYjsF2p8n
         xQ1KMUgYDJbJJcLP4g0V+9JfEl6RHNIeFoJXSadF1onEBPDahFMpl87QQYrD4KchWxLt
         YZWQWnbPJz0OLTev+aNVBYOxf7Bl7VX26JGkPbMNvNoqrYSF+Jp03ZA138D5SXl3Q3ig
         NO4kExXAVg8C5sX8XlAvOUWCt1Hqwt26G1b96wxRMjezgNkMXIKOx7AK10nY55FE3aNP
         WhDQ==
X-Gm-Message-State: AA+aEWZniVvpbpeJuFCZO7PikbNRl5wA3yMQF0SMUzExtAxg+6/472c/
        24RdPwqvDZTdIizHTj7y+iXX5MG3
X-Google-Smtp-Source: AFSGD/XcYZThUMNTHFsjwKzrYVvs3C0SKWXk2ywacA2HuNZ5k55bTVVJK5Yuz7FcfXfI5wEA7q6izg==
X-Received: by 2002:a63:1204:: with SMTP id h4mr10644151pgl.51.1545014333216;
        Sun, 16 Dec 2018 18:38:53 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id b26sm23129781pfe.91.2018.12.16.18.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 18:38:52 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/3] dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
Date:   Sun, 16 Dec 2018 18:38:26 -0800
Message-Id: <20181217023827.7947-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217023827.7947-1-andrew.smirnov@gmail.com>
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
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
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
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
2.19.1

