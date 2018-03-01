Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966728AbeCAJKX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:10:23 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41947 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966675AbeCAJJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:09:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04421;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Sykfl9P_1519895346;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: zhang.jia@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] module: Do not access sig_enforce directly
Date: Thu,  1 Mar 2018 17:09:03 +0800
Message-Id: <1519895346-7961-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call is_module_sig_enforced() instead.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index ad2d420..003d0ab 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2789,7 +2789,7 @@ static int module_sig_check(struct load_info *info, int flags)
 	}
 
 	/* Not having a signature is only an error if we're strict. */
-	if (err == -ENOKEY && !sig_enforce)
+	if (err == -ENOKEY && !is_module_sig_enforced())
 		err = 0;
 
 	return err;
-- 
1.8.3.1
