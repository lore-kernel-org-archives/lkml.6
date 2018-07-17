Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5261FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172E520C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172E520C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbeGQK2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43183 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729700AbeGQK2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:45 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6H9s4XL006655;
        Tue, 17 Jul 2018 11:56:34 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k87ueg3j1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 17 Jul 2018 11:56:34 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4C17331;
        Tue, 17 Jul 2018 09:56:34 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2DA5D4E03;
        Tue, 17 Jul 2018 09:56:34 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 17 Jul
 2018 11:56:33 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 17 Jul
 2018 11:56:33 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 2/2] pinctrl: stm32: add syscfg mask parameter
Date:   Tue, 17 Jul 2018 11:56:27 +0200
Message-ID: <1531821387-29845-3-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
References: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds mask parameter to define IRQ mux field.
This field could vary depend of IRQ mux selection register.
To avoid backward compatibility, the drivers set
the legacy value by default.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index dfed609..f756232 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -46,6 +46,8 @@
 #define STM32_GPIO_PINS_PER_BANK 16
 #define STM32_GPIO_IRQ_LINE	 16
 
+#define SYSCFG_IRQMUX_MASK GENMASK(3, 0)
+
 #define gpio_range_to_bank(chip) \
 		container_of(chip, struct stm32_gpio_bank, range)
 
@@ -1033,6 +1035,7 @@ static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct regmap *rm;
 	int offset, ret, i;
+	int mask, mask_width;
 
 	parent = of_irq_find_parent(np);
 	if (!parent)
@@ -1052,12 +1055,21 @@ static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	ret = of_property_read_u32_index(np, "st,syscfg", 2, &mask);
+	if (ret)
+		mask = SYSCFG_IRQMUX_MASK;
+
+	mask_width = fls(mask);
+
 	for (i = 0; i < STM32_GPIO_PINS_PER_BANK; i++) {
 		struct reg_field mux;
 
 		mux.reg = offset + (i / 4) * 4;
-		mux.lsb = (i % 4) * 4;
-		mux.msb = mux.lsb + 3;
+		mux.lsb = (i % 4) * mask_width;
+		mux.msb = mux.lsb + mask_width - 1;
+
+		dev_dbg(dev, "irqmux%d: reg:%#x, lsb:%d, msb:%d\n",
+			i, mux.reg, mux.lsb, mux.msb);
 
 		pctl->irqmux[i] = devm_regmap_field_alloc(dev, rm, mux);
 		if (IS_ERR(pctl->irqmux[i]))
-- 
2.7.4

