Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA15C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C2420873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgfTixa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C2420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeK1PiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:38:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32890 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeK1PiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:38:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so8841939pfb.0;
        Tue, 27 Nov 2018 20:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbWsa0jVWktcktrL1lg9/sliCbQ1pku9yoOxqB5aTvg=;
        b=SgfTixa0rypG5eIvpVgjJ4ZYgbrFz+JzROUxiMCoKdrEafFa+OantilcnNega9u21j
         4Z1GbwenlVQRxXouPQ0I+58XfS9UFVvmcivEbKXcENPFcdDHgya6AEAdNxJJvrzRY9Ov
         OeVR4bhHDhqMNEAS4VKcdJZbDybRM+E96qnIKtHYOnLFDc9Fxz7AHO34NcL+ZEK+EH+k
         mvVpWrld8LlpgcaHtj/wArxcQHBOdGt1N+O2WjuKCRVVf+Vxho+odlH05GAbIaWRNHyr
         Tl9u0ANZgYTgvoWeObLDapm8+ociSwwX/bqFnXwMMmLVwu4GiVzWOGmeVEsyu1rSJCEW
         +Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbWsa0jVWktcktrL1lg9/sliCbQ1pku9yoOxqB5aTvg=;
        b=WyMH1KVDw44pJRFKlIEXL/E+OX2dVgHZvhEsNBQZU3yJ90TxWPmO9EYWoEISOyZg5u
         MIk7gYFuEcH4HqWSFah0yUVlWNcjfq0tB/SUPkKUyPDMqbhlnV8gAyrMKJVS25yiFs+L
         ABaVIIs7XTH82NIaoALkjt0YyNnL7giHsmIpLx/Nv+JccI1eLfKN7gXOvl5sKX1Pe/Rv
         SvON6+eZ7dnVZZWWaXwSMdxlkry608JO9KydutWYHquhTKERyxArghSCiD5TdGYJJP2G
         5ZpY/g1uzaTj39XU6VbHGObkCP7OUeBoomGk2q126cyLyb5X5o02e+nuCC/669swBP4Q
         rgSQ==
X-Gm-Message-State: AA+aEWYhO8miWP4qTYLGyKXVJi967MPYT57FMbUiSlfHBPmwJDCgmCnn
        va0Ek2SURrIFzvWmf8+hJuINwM2H7To=
X-Google-Smtp-Source: AFSGD/UtpMSKT7pp1XBz/DJXfzWIqK3B7CynzgTpvMrYPg7bXr40IvcvRPIQfL6+o2S5VCnc0XCvZQ==
X-Received: by 2002:a63:d846:: with SMTP id k6mr32440535pgj.251.1543379875535;
        Tue, 27 Nov 2018 20:37:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v2sm6387369pgs.0.2018.11.27.20.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 20:37:54 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] reset: imx7: Add support for i.MX8MQ IP block variant
Date:   Tue, 27 Nov 2018 20:37:37 -0800
Message-Id: <20181128043738.12714-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128043738.12714-1-andrew.smirnov@gmail.com>
References: <20181128043738.12714-1-andrew.smirnov@gmail.com>
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
 drivers/reset/Kconfig                    |   2 +-
 drivers/reset/reset-imx7.c               | 106 +++++++++++++++++++++++
 include/dt-bindings/reset/imx8mq-reset.h |  64 ++++++++++++++
 3 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c21da9fe51ec..4909aab7401b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -50,7 +50,7 @@ config RESET_HSDK
 config RESET_IMX7
 	bool "i.MX7 Reset Driver" if COMPILE_TEST
 	depends on HAS_IOMEM
-	default SOC_IMX7D
+	default SOC_IMX7D || SOC_IMX8MQ
 	select MFD_SYSCON
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index cfbb6346a72e..34ce7448b299 100644
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

