Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BA1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C812084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knPpRNPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbeLTBH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:07:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39037 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbeLTBH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:07:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so33811pfc.6;
        Wed, 19 Dec 2018 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eDj9Bbt2oCf40baWi7GsmAunPoJ7bQGVVCa01DH/lM=;
        b=knPpRNPve/QpAk838saOm0fzqBMDJZUpf9ZwdhpSbcqX1+2m6ewzdTVo7P0Pkh5R8s
         prneLkG9ohhukGXVYDYumezv99MF4Jb+dO9aJ0ucF+LpsSesZXYf929WmdGi+AgwVI7G
         wkDZKarPWboOwmQlSgrYKl8fI4gt1BrzybodmiWB5wDEwlPHjopVYu4hepIqz9MvMR5s
         dSyRN8Z9geJuD6v7nB00lmcbTf2C+O6lsJAM5sXjASoVzey/PlQ4xRSywUW/naG+ymKq
         CsnlFmOdqhpgxOuBEY/b3vURJYVidVXI3xPaioHeCzqrKVDsPZDn9YQCoBEBAlWu4cZT
         iuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eDj9Bbt2oCf40baWi7GsmAunPoJ7bQGVVCa01DH/lM=;
        b=s51W0/d/ybOOQmMygovPEquXJlP3YQv0b3VH9FHwaIacfMI0UJNBRV4cxecHz2beBm
         KbkS1L2RnePKKI8I9eHNAN3qzLN7SYujyXcNQ3hrKU1fmseh4BI3TX0YRTzyWg+SeelJ
         Rl34RYG/iyAFS1ZZ5CkCgCdK+4s7iZ2wMrlYqrTjvQfgFOrW7xSNEYl0aQ4n5LDUSXZR
         tHz16sJVr3cyK1BN9nP6fiWU2w5DQx1FQABEeZotwqbVynjjeTZ7gQFntfCjumgN57fH
         uYBqwoiqiyfkBM1B7pgtVYcU0hbbhM3+6MMyAog7L63peLett64UVtO9JMXhjOB1vPxx
         XfWA==
X-Gm-Message-State: AA+aEWbcUoUmaTdHCMkTQvBT5mkIGBvOzY9gx0VRytZJzNLiK3UPp7NF
        esmGGdPpV5RKvSg5arudomI=
X-Google-Smtp-Source: AFSGD/Xk4iEb/3kumYvsWax7BIovJuhImdrqNN/gjgnOhxLr/GDDsrxdgU540Fs4qQL43q0ijfx80A==
X-Received: by 2002:a62:8d4f:: with SMTP id z76mr23262096pfd.2.1545268044860;
        Wed, 19 Dec 2018 17:07:24 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 83sm29008612pgf.57.2018.12.19.17.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 17:07:24 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     p.zabel@pengutronix.de
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] reset: imx7: Add support for i.MX8MQ IP block variant
Date:   Wed, 19 Dec 2018 17:07:00 -0800
Message-Id: <20181220010700.8598-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220010700.8598-1-andrew.smirnov@gmail.com>
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bits and pieces needed to support IP block variant found on
i.MX8MQ SoCs.

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
 drivers/reset/Kconfig      |   4 +-
 drivers/reset/reset-imx7.c | 106 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c21da9fe51ec..add84b523be1 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -48,9 +48,9 @@ config RESET_HSDK
 	  This enables the reset controller driver for HSDK board.
 
 config RESET_IMX7
-	bool "i.MX7 Reset Driver" if COMPILE_TEST
+	bool "i.MX7/8 Reset Driver" if COMPILE_TEST
 	depends on HAS_IOMEM
-	default SOC_IMX7D
+	default SOC_IMX7D || (ARM64 && ARCH_MXC)
 	select MFD_SYSCON
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 3a36d5863891..bb826935db6d 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -22,6 +22,7 @@
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
 #include <dt-bindings/reset/imx7-reset.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 
 struct imx7_src_signal {
 	unsigned int offset, bit;
@@ -113,6 +114,110 @@ static const struct imx7_src_variant variant_imx7 = {
 	.prepare = imx7_src_prepare,
 };
 
+enum imx8mq_src_registers {
+	SRC_A53RCR0		= 0x0004,
+	SRC_HDMI_RCR		= 0x0030,
+	SRC_DISP_RCR		= 0x0034,
+	SRC_GPU_RCR		= 0x0040,
+	SRC_VPU_RCR		= 0x0044,
+	SRC_PCIE2_RCR		= 0x0048,
+	SRC_MIPIPHY1_RCR	= 0x004c,
+	SRC_MIPIPHY2_RCR	= 0x0050,
+	SRC_DDRC2_RCR		= 0x1004,
+};
+
+static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
+	[IMX8MQ_RESET_A53_CORE_POR_RESET0]	= { SRC_A53RCR0, BIT(0) },
+	[IMX8MQ_RESET_A53_CORE_POR_RESET1]	= { SRC_A53RCR0, BIT(1) },
+	[IMX8MQ_RESET_A53_CORE_POR_RESET2]	= { SRC_A53RCR0, BIT(2) },
+	[IMX8MQ_RESET_A53_CORE_POR_RESET3]	= { SRC_A53RCR0, BIT(3) },
+	[IMX8MQ_RESET_A53_CORE_RESET0]		= { SRC_A53RCR0, BIT(4) },
+	[IMX8MQ_RESET_A53_CORE_RESET1]		= { SRC_A53RCR0, BIT(5) },
+	[IMX8MQ_RESET_A53_CORE_RESET2]		= { SRC_A53RCR0, BIT(6) },
+	[IMX8MQ_RESET_A53_CORE_RESET3]		= { SRC_A53RCR0, BIT(7) },
+	[IMX8MQ_RESET_A53_DBG_RESET0]		= { SRC_A53RCR0, BIT(8) },
+	[IMX8MQ_RESET_A53_DBG_RESET1]		= { SRC_A53RCR0, BIT(9) },
+	[IMX8MQ_RESET_A53_DBG_RESET2]		= { SRC_A53RCR0, BIT(10) },
+	[IMX8MQ_RESET_A53_DBG_RESET3]		= { SRC_A53RCR0, BIT(11) },
+	[IMX8MQ_RESET_A53_ETM_RESET0]		= { SRC_A53RCR0, BIT(12) },
+	[IMX8MQ_RESET_A53_ETM_RESET1]		= { SRC_A53RCR0, BIT(13) },
+	[IMX8MQ_RESET_A53_ETM_RESET2]		= { SRC_A53RCR0, BIT(14) },
+	[IMX8MQ_RESET_A53_ETM_RESET3]		= { SRC_A53RCR0, BIT(15) },
+	[IMX8MQ_RESET_A53_SOC_DBG_RESET]	= { SRC_A53RCR0, BIT(20) },
+	[IMX8MQ_RESET_A53_L2RESET]		= { SRC_A53RCR0, BIT(21) },
+	[IMX8MQ_RESET_SW_NON_SCLR_M4C_RST]	= { SRC_M4RCR, BIT(0) },
+	[IMX8MQ_RESET_OTG1_PHY_RESET]		= { SRC_USBOPHY1_RCR, BIT(0) },
+	[IMX8MQ_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
+	[IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N]	= { SRC_MIPIPHY_RCR, BIT(1) },
+	[IMX8MQ_RESET_MIPI_DSI_RESET_N]		= { SRC_MIPIPHY_RCR, BIT(2) },
+	[IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
+	[IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
+	[IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
+	[IMX8MQ_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR,
+						    BIT(2) | BIT(1) },
+	[IMX8MQ_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
+	[IMX8MQ_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF]	= { SRC_PCIEPHY_RCR, BIT(11) },
+	[IMX8MQ_RESET_HDMI_PHY_APB_RESET]	= { SRC_HDMI_RCR, BIT(0) },
+	[IMX8MQ_RESET_DISP_RESET]		= { SRC_DISP_RCR, BIT(0) },
+	[IMX8MQ_RESET_GPU_RESET]		= { SRC_GPU_RCR, BIT(0) },
+	[IMX8MQ_RESET_VPU_RESET]		= { SRC_VPU_RCR, BIT(0) },
+	[IMX8MQ_RESET_PCIEPHY2]			= { SRC_PCIE2_RCR,
+						    BIT(2) | BIT(1) },
+	[IMX8MQ_RESET_PCIEPHY2_PERST]		= { SRC_PCIE2_RCR, BIT(3) },
+	[IMX8MQ_RESET_PCIE2_CTRL_APPS_EN]	= { SRC_PCIE2_RCR, BIT(6) },
+	[IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF]	= { SRC_PCIE2_RCR, BIT(11) },
+	[IMX8MQ_RESET_MIPI_CSI1_CORE_RESET]	= { SRC_MIPIPHY1_RCR, BIT(0) },
+	[IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET]	= { SRC_MIPIPHY1_RCR, BIT(1) },
+	[IMX8MQ_RESET_MIPI_CSI1_ESC_RESET]	= { SRC_MIPIPHY1_RCR, BIT(2) },
+	[IMX8MQ_RESET_MIPI_CSI2_CORE_RESET]	= { SRC_MIPIPHY2_RCR, BIT(0) },
+	[IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET]	= { SRC_MIPIPHY2_RCR, BIT(1) },
+	[IMX8MQ_RESET_MIPI_CSI2_ESC_RESET]	= { SRC_MIPIPHY2_RCR, BIT(2) },
+	[IMX8MQ_RESET_DDRC1_PRST]		= { SRC_DDRC_RCR, BIT(0) },
+	[IMX8MQ_RESET_DDRC1_CORE_RESET]		= { SRC_DDRC_RCR, BIT(1) },
+	[IMX8MQ_RESET_DDRC1_PHY_RESET]		= { SRC_DDRC_RCR, BIT(2) },
+	[IMX8MQ_RESET_DDRC2_PHY_RESET]		= { SRC_DDRC2_RCR, BIT(0) },
+	[IMX8MQ_RESET_DDRC2_CORE_RESET]		= { SRC_DDRC2_RCR, BIT(1) },
+	[IMX8MQ_RESET_DDRC2_PRST]		= { SRC_DDRC2_RCR, BIT(2) },
+};
+
+static unsigned int
+imx8mq_src_prepare(struct imx7_src *imx7src, unsigned long id, bool assert)
+{
+	const unsigned int bit = imx7src->variant->signals[id].bit;
+	unsigned int value = assert ? bit : 0;
+
+	switch (id) {
+	case IMX8MQ_RESET_PCIEPHY:
+	case IMX8MQ_RESET_PCIEPHY2: /* fallthrough */
+		/*
+		 * wait for more than 10us to release phy g_rst and
+		 * btnrst
+		 */
+		if (!assert)
+			udelay(10);
+		break;
+
+	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
+	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
+	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
+		value = assert ? 0 : bit;
+		break;
+	}
+
+	return value;
+}
+
+static const struct imx7_src_variant variant_imx8mq = {
+	.signals = imx8mq_src_signals,
+	.signals_num = ARRAY_SIZE(imx8mq_src_signals),
+	.prepare = imx8mq_src_prepare,
+};
+
 static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
 {
 	return container_of(rcdev, struct imx7_src, rcdev);
@@ -175,6 +280,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 
 static const struct of_device_id imx7_reset_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-src", .data = &variant_imx7 },
+	{ .compatible = "fsl,imx8mq-src", .data = &variant_imx8mq },
 	{ /* sentinel */ },
 };
 
-- 
2.19.1

