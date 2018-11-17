Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE39DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649E320815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSpajO61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649E320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeKRE3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:29:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36907 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKRE3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:29:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so10224979pfm.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+acSq/TkpyYxv16Qw49nXaW0OzDzxcF2f5zPzPa3zU=;
        b=cSpajO61tHQGt5ICXg5YBchmA3WcqZ/acbl/jriTuJF/c6lS6wdx0N+gFfOPL4+Pxb
         HVlj3docF+jtExRI7vpaOvV9rQsJUAGIRAIS3TBeH9UmSUuj2ZWznhp1WPr48OszGs/l
         oSjlbruJcp9YSD+KZmFq5PHb+bMA3UloOM28N3FHfHM7vpm5zAgx2oOf+NVxvAy1F9t0
         ms5N6lIv8mL5afryFaHg5Nw6QhhJoFanCbV0neHMUEJafk2EfmBjDm49PskTqy3EdC1b
         n1AOXCmX+5Ed0fwgrO0QwnjwCd7hCCRW3ssWsgFFm/DV2KxIdStnZI48aSitPa9JDSPH
         EWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+acSq/TkpyYxv16Qw49nXaW0OzDzxcF2f5zPzPa3zU=;
        b=pKuipRV5fymnKCfC+7GbaWDOU3Ev4Lf/a/wJRAweGUnHAUdEB/gl2BKyKuxYlg3tFp
         R12w3jG+gM3+kFujMOmKNjKTbueCdJAmXrUsk5zvSGwQBhqWeUtj2XEWu4ZS4CX3gPTT
         o5Xm9foU1uU+UHq7HoJgIpsmRccXyWRxP2V1xtGErpdZL/+R/uoi+wN6N31utZa8Thut
         KoyEUhmGckjqStXC4NKrr2X0dUxpmPJBvQDBXbe/BbJ+05USQb4yCx/yRaAcZpCYm4TO
         Zk89QT7lZODr+v5iFnbRvL1BdUReczRNh5SFL70/aGymh0Y8q5nSrjv8gksCdnxmyVqK
         icTA==
X-Gm-Message-State: AGRZ1gK+wZB6o4HHQFGd4ic7+MhiWkeg8mnulxIzY3jdRIS0qaXwNF7N
        wNT7u/ccyfGxacvckT1Vsk3E1FVXoiI=
X-Google-Smtp-Source: AJdET5cfzmA3JQW6SQyEHv8PqAG71Je6JZUhzAC8wD0OQuilj/xpxrGGuYkNBhVJhclpqBiL//2NTQ==
X-Received: by 2002:a65:42c2:: with SMTP id l2-v6mr13651015pgp.139.1542478311147;
        Sat, 17 Nov 2018 10:11:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a73sm24816500pfa.7.2018.11.17.10.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 10:11:50 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] reset: imx7: Add support for i.MX8MQ
Date:   Sat, 17 Nov 2018 10:11:31 -0800
Message-Id: <20181117181131.9330-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117181131.9330-1-andrew.smirnov@gmail.com>
References: <20181117181131.9330-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SRC IP block used in i.MX8MQ is a superset of what is found in i.MX7D,
so add all of the definitions necessary to support both.

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
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/reset/Kconfig                   |  2 +-
 drivers/reset/reset-imx7.c              | 66 ++++++++++++++++++++++++-
 include/dt-bindings/reset/imx7-reset.h  | 15 +++++-
 include/dt-bindings/reset/imx8m-reset.h | 47 ++++++++++++++++++
 4 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8m-reset.h

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
index 77911fa8f31d..dffad618f805 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -21,14 +21,16 @@
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
 #include <dt-bindings/reset/imx7-reset.h>
+#include <dt-bindings/reset/imx8m-reset.h>
 
 struct imx7_src {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
 };
 
-enum imx7_src_registers {
+enum imx_src_registers {
 	SRC_A7RCR0		= 0x0004,
+	SRC_A53RCR0		= 0x0004,
 	SRC_M4RCR		= 0x000c,
 	SRC_ERCR		= 0x0014,
 	SRC_HSICPHY_RCR		= 0x001c,
@@ -36,7 +38,9 @@ enum imx7_src_registers {
 	SRC_USBOPHY2_RCR	= 0x0024,
 	SRC_MIPIPHY_RCR		= 0x0028,
 	SRC_PCIEPHY_RCR		= 0x002c,
+	SRC_PCIE2PHY_RCR	= 0x0048,
 	SRC_DDRC_RCR		= 0x1000,
+
 };
 
 struct imx7_src_signal {
@@ -67,11 +71,67 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_PCIEPHY]		= { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
 	[IMX7_RESET_PCIEPHY_PERST]	= { SRC_PCIEPHY_RCR, BIT(3) },
 	[IMX7_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX7_RESET_PCIE_CTRL_APPS_CLK_REQ] = { SRC_PCIEPHY_RCR, BIT(4) },
 	[IMX7_RESET_PCIE_CTRL_APPS_TURNOFF] = { SRC_PCIEPHY_RCR, BIT(11) },
 	[IMX7_RESET_DDRC_PRST]		= { SRC_DDRC_RCR, BIT(0) },
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
+
+	[IMX8M_RESET_A53_CORE_POR_RESET2] = { SRC_A53RCR0, BIT(2) },
+	[IMX8M_RESET_A53_CORE_POR_RESET3] = { SRC_A53RCR0, BIT(3) },
+	[IMX8M_RESET_A53_CORE_RESET2]     = { SRC_A53RCR0, BIT(6) },
+	[IMX8M_RESET_A53_CORE_RESET3]     = { SRC_A53RCR0, BIT(7) },
+	[IMX8M_RESET_A53_ETM_RESET2]      = { SRC_A53RCR0, BIT(14) },
+	[IMX8M_RESET_A53_ETM_RESET3]      = { SRC_A53RCR0, BIT(15) },
+	[IMX8M_RESET_PCIE2PHY]		= { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
+	[IMX8M_RESET_PCIE2PHY_PERST]      = { SRC_PCIE2PHY_RCR, BIT(3) },
+	[IMX8M_RESET_PCIE2_CTRL_APPS_EN]  = { SRC_PCIE2PHY_RCR, BIT(6) },
+	[IMX8M_RESET_PCIE2_CTRL_APPS_CLK_REQ] = { SRC_PCIE2PHY_RCR, BIT(4) },
+	[IMX8M_RESET_PCIE2_CTRL_APPS_TURNOFF] = { SRC_PCIE2PHY_RCR, BIT(11) },
 };
 
+static inline void imx7_src_check_definitions(void)
+{
+	BUILD_BUG_ON(IMX8M_RESET_A53_CORE_POR_RESET0 !=
+		     IMX7_RESET_A7_CORE_POR_RESET0);
+	BUILD_BUG_ON(IMX8M_RESET_A53_CORE_POR_RESET1 !=
+		     IMX7_RESET_A7_CORE_POR_RESET1);
+	BUILD_BUG_ON(IMX8M_RESET_A53_CORE_RESET0 !=
+		     IMX7_RESET_A7_CORE_RESET0);
+	BUILD_BUG_ON(IMX8M_RESET_A53_CORE_RESET1 !=
+		     IMX7_RESET_A7_CORE_RESET1);
+	BUILD_BUG_ON(IMX8M_RESET_A53_DBG_RESET0 !=
+		     IMX7_RESET_A7_DBG_RESET0);
+	BUILD_BUG_ON(IMX8M_RESET_A53_DBG_RESET1 !=
+		     IMX7_RESET_A7_DBG_RESET1);
+	BUILD_BUG_ON(IMX8M_RESET_A53_ETM_RESET0 !=
+		     IMX7_RESET_A7_ETM_RESET0);
+	BUILD_BUG_ON(IMX8M_RESET_A53_ETM_RESET1 !=
+		     IMX7_RESET_A7_ETM_RESET1);
+	BUILD_BUG_ON(IMX8M_RESET_A53_SOC_DBG_RESET !=
+		     IMX7_RESET_A7_SOC_DBG_RESET);
+	BUILD_BUG_ON(IMX8M_RESET_A53_L2RESET != IMX7_RESET_A7_L2RESET);
+	BUILD_BUG_ON(IMX8M_RESET_SW_M4C_RST != IMX7_RESET_SW_M4C_RST);
+	BUILD_BUG_ON(IMX8M_RESET_SW_M4P_RST != IMX7_RESET_SW_M4P_RST);
+	BUILD_BUG_ON(IMX8M_RESET_EIM_RST != IMX7_RESET_EIM_RST);
+	BUILD_BUG_ON(IMX8M_RESET_HSICPHY_PORT_RST !=
+		     IMX7_RESET_HSICPHY_PORT_RST);
+	BUILD_BUG_ON(IMX8M_RESET_USBPHY1_POR != IMX7_RESET_USBPHY1_POR);
+	BUILD_BUG_ON(IMX8M_RESET_USBPHY1_PORT_RST !=
+		     IMX7_RESET_USBPHY1_PORT_RST);
+	BUILD_BUG_ON(IMX8M_RESET_USBPHY2_POR != IMX7_RESET_USBPHY2_POR);
+	BUILD_BUG_ON(IMX8M_RESET_USBPHY2_PORT_RST !=
+		     IMX7_RESET_USBPHY2_PORT_RST);
+	BUILD_BUG_ON(IMX8M_RESET_MIPI_PHY_MRST != IMX7_RESET_MIPI_PHY_MRST);
+	BUILD_BUG_ON(IMX8M_RESET_MIPI_PHY_SRST != IMX7_RESET_MIPI_PHY_SRST);
+	BUILD_BUG_ON(IMX8M_RESET_PCIEPHY != IMX7_RESET_PCIEPHY);
+	BUILD_BUG_ON(IMX8M_RESET_PCIE_CTRL_APPS_EN !=
+		     IMX7_RESET_PCIE_CTRL_APPS_EN);
+	BUILD_BUG_ON(IMX8M_RESET_PCIE_CTRL_APPS_TURNOFF !=
+		     IMX7_RESET_PCIE_CTRL_APPS_TURNOFF);
+	BUILD_BUG_ON(IMX8M_RESET_DDRC_PRST != IMX7_RESET_DDRC_PRST);
+	BUILD_BUG_ON(IMX8M_RESET_DDRC_CORE_RST != IMX7_RESET_DDRC_CORE_RST);
+}
+
 static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
 {
 	return container_of(rcdev, struct imx7_src, rcdev);
@@ -85,6 +145,7 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 	unsigned int value = assert ? signal->bit : 0;
 
 	switch (id) {
+	case IMX8M_RESET_PCIE2PHY: /* FALLTHROUGH */
 	case IMX7_RESET_PCIEPHY:
 		/*
 		 * wait for more than 10us to release phy g_rst and
@@ -94,6 +155,7 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 			udelay(10);
 		break;
 
+	case IMX8M_RESET_PCIE2_CTRL_APPS_EN: /* FALLTHROUGH */
 	case IMX7_RESET_PCIE_CTRL_APPS_EN:
 		value = (assert) ? 0 : signal->bit;
 		break;
@@ -126,6 +188,8 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct regmap_config config = { .name = "src" };
 
+	imx7_src_check_definitions();
+
 	imx7src = devm_kzalloc(dev, sizeof(*imx7src), GFP_KERNEL);
 	if (!imx7src)
 		return -ENOMEM;
diff --git a/include/dt-bindings/reset/imx7-reset.h b/include/dt-bindings/reset/imx7-reset.h
index 31b3f87dde9a..8fefd694d481 100644
--- a/include/dt-bindings/reset/imx7-reset.h
+++ b/include/dt-bindings/reset/imx7-reset.h
@@ -57,8 +57,21 @@
 #define IMX7_RESET_DDRC_CORE_RST	24
 
 #define IMX7_RESET_PCIE_CTRL_APPS_TURNOFF 25
+#define IMX7_RESET_PCIE_CTRL_APPS_CLK_REQ 26
 
-#define IMX7_RESET_NUM			26
+#define	IMX8M_RESET_A53_CORE_POR_RESET2	27
+#define IMX8M_RESET_A53_CORE_POR_RESET3	28
+#define IMX8M_RESET_A53_CORE_RESET2	29
+#define	IMX8M_RESET_A53_CORE_RESET3	30
+#define IMX8M_RESET_A53_ETM_RESET2	31
+#define IMX8M_RESET_A53_ETM_RESET3	32
+#define IMX8M_RESET_PCIE2PHY		33
+#define IMX8M_RESET_PCIE2PHY_PERST	34
+#define IMX8M_RESET_PCIE2_CTRL_APPS_EN	35
+#define IMX8M_RESET_PCIE2_CTRL_APPS_CLK_REQ 36
+#define IMX8M_RESET_PCIE2_CTRL_APPS_TURNOFF 37
+
+#define IMX7_RESET_NUM			38
 
 #endif
 
diff --git a/include/dt-bindings/reset/imx8m-reset.h b/include/dt-bindings/reset/imx8m-reset.h
new file mode 100644
index 000000000000..8fa840354723
--- /dev/null
+++ b/include/dt-bindings/reset/imx8m-reset.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Zodiac Inflight Innovations
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ */
+
+#ifndef DT_BINDING_RESET_IMX8M_H
+#define DT_BINDING_RESET_IMX8M_H
+
+#include "imx7-reset.h"
+
+#define IMX8M_RESET_A53_CORE_POR_RESET0 IMX7_RESET_A7_CORE_POR_RESET0
+#define IMX8M_RESET_A53_CORE_POR_RESET1 IMX7_RESET_A7_CORE_POR_RESET1
+
+#define IMX8M_RESET_A53_CORE_RESET0     IMX7_RESET_A7_CORE_RESET0
+#define IMX8M_RESET_A53_CORE_RESET1     IMX7_RESET_A7_CORE_RESET1
+
+#define IMX8M_RESET_A53_DBG_RESET0	IMX7_RESET_A7_DBG_RESET0
+#define IMX8M_RESET_A53_DBG_RESET1	IMX7_RESET_A7_DBG_RESET1
+
+#define IMX8M_RESET_A53_ETM_RESET0	IMX7_RESET_A7_ETM_RESET0
+#define IMX8M_RESET_A53_ETM_RESET1	IMX7_RESET_A7_ETM_RESET1
+
+#define IMX8M_RESET_A53_SOC_DBG_RESET   IMX7_RESET_A7_SOC_DBG_RESET
+#define IMX8M_RESET_A53_L2RESET         IMX7_RESET_A7_L2RESET
+#define IMX8M_RESET_SW_M4C_RST          IMX7_RESET_SW_M4C_RST
+#define IMX8M_RESET_SW_M4P_RST          IMX7_RESET_SW_M4P_RST
+#define IMX8M_RESET_EIM_RST             IMX7_RESET_EIM_RST
+#define IMX8M_RESET_HSICPHY_PORT_RST    IMX7_RESET_HSICPHY_PORT_RST
+#define IMX8M_RESET_USBPHY1_POR         IMX7_RESET_USBPHY1_POR
+#define IMX8M_RESET_USBPHY1_PORT_RST    IMX7_RESET_USBPHY1_PORT_RST
+#define IMX8M_RESET_USBPHY2_POR         IMX7_RESET_USBPHY2_POR
+#define IMX8M_RESET_USBPHY2_PORT_RST    IMX7_RESET_USBPHY2_PORT_RST
+#define IMX8M_RESET_MIPI_PHY_MRST       IMX7_RESET_MIPI_PHY_MRST
+#define IMX8M_RESET_MIPI_PHY_SRST       IMX7_RESET_MIPI_PHY_SRST
+
+#define IMX8M_RESET_PCIEPHY             IMX7_RESET_PCIEPHY
+#define IMX8M_RESET_PCIEPHY_PERST	IMX7_RESET_PCIEPHY_PERST
+#define IMX8M_RESET_PCIE_CTRL_APPS_EN   IMX7_RESET_PCIE_CTRL_APPS_EN
+#define IMX8M_RESET_DDRC_PRST           IMX7_RESET_DDRC_PRST
+#define IMX8M_RESET_DDRC_CORE_RST       IMX7_RESET_DDRC_CORE_RST
+
+#define IMX8M_RESET_PCIE_CTRL_APPS_TURNOFF IMX7_RESET_PCIE_CTRL_APPS_TURNOFF
+#define IMX8M_RESET_PCIE_CTRL_APPS_CLK_REQ IMX7_RESET_PCIE_CTRL_APPS_CLK_REQ
+
+#endif
-- 
2.19.1

