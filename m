Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB4EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FAB20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfAWIvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:51:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfAWIvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:51:01 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2844441B27885080B972;
        Wed, 23 Jan 2019 16:50:58 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 16:50:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <j-keerthy@ti.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] gpio: davinci: drop pointless static qualifier
Date:   Wed, 23 Jan 2019 16:49:12 +0800
Message-ID: <20190123084912.13376-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the 'gpio_unbanked' variable static since
new value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpio/gpio-davinci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index bdb29e5..f250454 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -465,7 +465,7 @@ static const struct irq_domain_ops davinci_gpio_irq_ops = {
 
 static struct irq_chip *davinci_gpio_get_irq_chip(unsigned int irq)
 {
-	static struct irq_chip_type gpio_unbanked;
+	struct irq_chip_type gpio_unbanked;
 
 	gpio_unbanked = *irq_data_get_chip_type(irq_get_irq_data(irq));
 
@@ -474,7 +474,7 @@ static struct irq_chip *davinci_gpio_get_irq_chip(unsigned int irq)
 
 static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
 {
-	static struct irq_chip gpio_unbanked;
+	struct irq_chip gpio_unbanked;
 
 	gpio_unbanked = *irq_get_chip(irq);
 	return &gpio_unbanked;
-- 
2.7.0


