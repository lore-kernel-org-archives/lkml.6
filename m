Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E739C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCA4217D1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCA4217D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeHEQNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:13:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbeHEQNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:13:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7DA4CC35ED266;
        Sun,  5 Aug 2018 22:08:58 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Sun, 5 Aug 2018 22:08:49 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <gaoxiang25@huawei.com>,
        <yuchao0@huawei.com>
CC:     <rspringer@google.com>, <jnjoseph@google.com>,
        <benchan@chromium.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/staging: Remove some unneeded semicolon
Date:   Sun, 5 Aug 2018 21:57:09 +0800
Message-ID: <1533477429-17379-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That semicolons are unneeded, JUst remove them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c         | 2 +-
 drivers/staging/gasket/gasket_interrupt.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 1030ca5..e5ceb68 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1016,7 +1016,7 @@ static void z_erofs_vle_unzip_all(struct super_block *sb,
 		owned = READ_ONCE(grp->next);
 
 		z_erofs_vle_unzip(sb, grp, page_pool);
-	};
+	}
 }
 
 static void z_erofs_vle_unzip_wq(struct work_struct *work)
diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 09c3d07..1cfbc12 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -386,7 +386,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev, const char *name,
 			"Cannot handle unsupported interrupt type %d\n",
 			interrupt_data->type);
 		ret = -EINVAL;
-	};
+	}
 
 	if (ret) {
 		/* Failing to setup interrupts will cause the device to report
@@ -445,7 +445,7 @@ int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 			"Cannot handle unsupported interrupt type %d\n",
 			gasket_dev->interrupt_data->type);
 		ret = -EINVAL;
-	};
+	}
 
 	if (ret) {
 		/* Failing to setup MSIx will cause the device
@@ -493,7 +493,7 @@ void gasket_interrupt_cleanup(struct gasket_dev *gasket_dev)
 		dev_dbg(gasket_dev->dev,
 			"Cannot handle unsupported interrupt type %d\n",
 			interrupt_data->type);
-	};
+	}
 
 	kfree(interrupt_data->interrupt_counts);
 	kfree(interrupt_data->eventfd_ctxs);
-- 
1.7.12.4

