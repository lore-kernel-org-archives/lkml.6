Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E531C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280BC21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfAWImM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:42:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfAWImM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:42:12 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B64BDF3C0309280BEED3;
        Wed, 23 Jan 2019 16:42:09 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 16:42:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <baohua@kernel.org>,
        <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] pinctrl: sirf: drop pointless static qualifier in sirfsoc_gpio_probe
Date:   Wed, 23 Jan 2019 16:41:40 +0800
Message-ID: <20190123084140.16524-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the 'sgpio' variable static since new
value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 2e42d73..2b3bd1a 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -782,7 +782,7 @@ static void sirfsoc_gpio_set_pulldown(struct sirfsoc_gpio_chip *sgpio,
 static int sirfsoc_gpio_probe(struct device_node *np)
 {
 	int i, err = 0;
-	static struct sirfsoc_gpio_chip *sgpio;
+	struct sirfsoc_gpio_chip *sgpio;
 	struct sirfsoc_gpio_bank *bank;
 	void __iomem *regs;
 	struct platform_device *pdev;
-- 
2.7.0


