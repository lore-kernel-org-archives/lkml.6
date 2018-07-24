Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA25C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C5620856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C5620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbeGXNPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:15:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388236AbeGXNPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:15:30 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BF9272F6B8999;
        Tue, 24 Jul 2018 20:09:14 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Tue, 24 Jul 2018 20:09:11 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <albeu@free.fr>, <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next] gpio: fix meaningless return expression
Date:   Tue, 24 Jul 2018 19:57:43 +0800
Message-ID: <1532433463-42508-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse error:

drivers/gpio/gpio-ath79.c:54:16: error: return expression in void function

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpio/gpio-ath79.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index 684e9d6..0a553d6 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -51,7 +51,7 @@ static u32 ath79_gpio_read(struct ath79_gpio_ctrl *ctrl, unsigned reg)
 static void ath79_gpio_write(struct ath79_gpio_ctrl *ctrl,
 			unsigned reg, u32 val)
 {
-	return writel(val, ctrl->base + reg);
+	writel(val, ctrl->base + reg);
 }
 
 static bool ath79_gpio_update_bits(
-- 
1.7.12.4

