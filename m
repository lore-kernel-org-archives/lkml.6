Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AAAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4806206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="auSw5SVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfAIMLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:11:20 -0500
Received: from m12-16.163.com ([220.181.12.16]:56699 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfAIMLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=TY84r/Ln7WEOJD5tk8
        eOJ7YfnM6dQBHRcMrBTtic7Hw=; b=auSw5SVcf4tYNbuEfrkqgt6O8IhPq4G3Ms
        h9fOMSzhlzAQh4ZGW/Ku77mgmjpGTplCGl99DkdTzG74HdwEyc/Aa3ncxC1kW9kx
        GXRYdQ1SMX2MidyxEuc6Q1pIS4PGbqTUnImSzYGdWNQJwaltUCXBfduWWtIFo9rf
        9+T9104y0=
Received: from localhost.localdomain (unknown [110.185.70.223])
        by smtp12 (Coremail) with SMTP id EMCowABHzPm85DVcQt6HAA--.14475S2;
        Wed, 09 Jan 2019 20:10:37 +0800 (CST)
From:   wangbo <wdjjwb@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        wang.bo116@zte.com.cn
Subject: [PATCH] mmc:sdio: Remove unneeded variable ret
Date:   Wed,  9 Jan 2019 20:10:33 +0800
Message-Id: <1547035833-3924-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowABHzPm85DVcQt6HAA--.14475S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry8Zw1fJr1kXrW3Jry7Wrg_yoWfAwc_Cr
        W5Xrs7Grn5Za1rG3W29F1SvryqgFn7ZrnYgFn5Kay3Jr17J3WkWF4DZFn09ryfury0ka1j
        yr45XryUZF4rCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnag43UUUUU==
X-Originating-IP: [110.185.70.223]
X-CM-SenderInfo: xzgmy4re6rljoofrz/xtbBEhs3GVZX-r6LKAABsE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdio_bus_remove the variable is unneeded,remove it now.

Signed-off-by: wangbo <wang.bo116@zte.com.cn>
---
 drivers/mmc/core/sdio_bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index b6d8203..62b0f5e 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -179,7 +179,6 @@ static int sdio_bus_remove(struct device *dev)
 {
 	struct sdio_driver *drv = to_sdio_driver(dev->driver);
 	struct sdio_func *func = dev_to_sdio_func(dev);
-	int ret = 0;
 
 	/* Make sure card is powered before invoking ->remove() */
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
@@ -205,7 +204,7 @@ static int sdio_bus_remove(struct device *dev)
 
 	dev_pm_domain_detach(dev, false);
 
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops sdio_bus_pm_ops = {
-- 
2.7.4


