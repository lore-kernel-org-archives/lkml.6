Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A997C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B9621019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Eub6ULmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfAVOtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:49:22 -0500
Received: from m12-13.163.com ([220.181.12.13]:48090 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbfAVOtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:49:21 -0500
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 09:49:20 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=SJCdauQe6QoeEHk3E6
        CfEhMg/t1Nqq1uepFVEj/67nk=; b=Eub6ULmR2g9q9toVZw1RrsVkBhZnp7FI27
        4MzKWruWfBgFsbvYNUIuuUBLmEupyvWhJxSwbomAAVzS8RUIRrVaMmIQ0EfqpaVz
        861uq6wxcClj8J6RIuU7jglupNdXoI8zreg28F8h8a0zqo1cFUU3F7koz3LVw3bG
        dMSz2+880=
Received: from localhost.localdomain (unknown [182.139.212.77])
        by smtp9 (Coremail) with SMTP id DcCowACnM4PaKUdcc20PCg--.32661S2;
        Tue, 22 Jan 2019 22:34:03 +0800 (CST)
From:   Bo Wang <wdjjwb@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, wang.bo116@zte.com.cn,
        wangbo <wdjjwb@163.com>
Subject: [PATCH v2] uio:remove unneeded variable ret
Date:   Tue, 22 Jan 2019 22:33:57 +0800
Message-Id: <1548167637-2607-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcCowACnM4PaKUdcc20PCg--.32661S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1rtF15trW7Jw1rWr15Arb_yoWkXrXEkr
        Wvq3y0gayDur4ruanI9F4YvFZ0yrWkWw4vqFnFkF93Wa47Grn5Jr4IyF9xXry8XrZ5GrWD
        A3yxtr4UXr1DWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbT5l7UUUUU==
X-Originating-IP: [182.139.212.77]
X-CM-SenderInfo: xzgmy4re6rljoofrz/1tbiOxtEGVXlhoSZXwAAsJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangbo <wdjjwb@163.com>

In uio_dmem_genirq_open the variable ret is unneeded,remove it now.

Signed-off-by: Bo Wang <wang.bo116@zte.com.cn>
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


