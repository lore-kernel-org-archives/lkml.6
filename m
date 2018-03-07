Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeCGSGN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:06:13 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35690 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933491AbeCGSGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:06:12 -0500
X-Google-Smtp-Source: AG47ELu2LtfrFQ4tIdV5BJ/tN+9zSskISnEpxACscRIKZFYinRnbJKIIApdAP3lLVNWnZeDBXys2uQ==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: linus.walleij@linaro.org
Cc: lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] mfd: ab8500-debugfs: Use kasprintf
Date: Wed,  7 Mar 2018 23:36:01 +0530
Message-Id: <1520445961-12160-1-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kasprintf instead of combination of kmalloc and sprintf.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/mfd/ab8500-debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 8ba4107..831a1ce 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2519,11 +2519,10 @@ static ssize_t ab8500_subscribe_write(struct file *file,
 	if (!dev_attr[irq_index])
 		return -ENOMEM;
 
-	event_name[irq_index] = kmalloc(count, GFP_KERNEL);
+	event_name[irq_index] = kasprintf(GFP_KERNEL, "%lu", user_val);
 	if (!event_name[irq_index])
 		return -ENOMEM;
 
-	sprintf(event_name[irq_index], "%lu", user_val);
 	dev_attr[irq_index]->show = show_irq;
 	dev_attr[irq_index]->store = NULL;
 	dev_attr[irq_index]->attr.name = event_name[irq_index];
-- 
2.7.4
