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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D66C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834712075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z55R2GDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfAILzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:55:08 -0500
Received: from m12-14.163.com ([220.181.12.14]:55135 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfAILzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=d+SROot9sbufheNYek
        mS6QLK+5nZnqQWFQpmK2UXJOw=; b=Z55R2GDAynMUg8yGTaUqqAxXEX1WzxbGBn
        FPT3jdaMrhnorngpgsTdUhRhebh03ZAsSQ2e6RC2zMfgrCsVcJf4RDRnm5cJMhcg
        xf8jrVjFHxoJBj4ROrVvKyxSG60AH/kH5BrvyDnywILN+HyppWdouL+7Alk2Mg/P
        YxhKXO13w=
Received: from localhost.localdomain (unknown [110.185.70.223])
        by smtp10 (Coremail) with SMTP id DsCowADH_vTa4DVcgaiNAA--.1400S2;
        Wed, 09 Jan 2019 19:54:03 +0800 (CST)
From:   wangbo <wdjjwb@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, wang.bo116@zte.com.cn
Subject: [PATCH] uio:remove unneeded variable ret
Date:   Wed,  9 Jan 2019 19:53:59 +0800
Message-Id: <1547034839-3493-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowADH_vTa4DVcgaiNAA--.1400S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1UXFWxAF4DGF1kAr13urg_yoWDKFXEkr
        WkK3yjgayDur4rua9I9F4YvFZ0yrWDWw4vqFnFkFyrWa47Grn5Jr4IyF9xXry8XrZ5CrWD
        Z397tr4UXr1DGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8WCJPUUUUU==
X-Originating-IP: [110.185.70.223]
X-CM-SenderInfo: xzgmy4re6rljoofrz/xtbBEhs3GVZX-r6LKAAAsF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In uio_dmem_genirq_open the variable ret is unneededw,remove it now.

Signed-off-by: wangbo <wang.bo116@zte.com.cn>
---
 drivers/uio/uio_dmem_genirq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 003bada..2be7569 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -47,7 +47,6 @@ static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 {
 	struct uio_dmem_genirq_platdata *priv = info->priv;
 	struct uio_mem *uiomem;
-	int ret = 0;
 	int dmem_region = priv->dmem_region_start;
 
 	uiomem = &priv->uioinfo->mem[priv->dmem_region_start];
@@ -71,7 +70,7 @@ static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 	mutex_unlock(&priv->alloc_lock);
 	/* Wait until the Runtime PM code has woken up the device */
 	pm_runtime_get_sync(&priv->pdev->dev);
-	return ret;
+	return 0;
 }
 
 static int uio_dmem_genirq_release(struct uio_info *info, struct inode *inode)
-- 
2.7.4


