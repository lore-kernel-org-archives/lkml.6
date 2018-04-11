Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeDKDxi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 23:53:38 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47078 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752140AbeDKDxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 23:53:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T.-8WcN_1523418812;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com
Subject: [PATCH 1/2] module: Do not access sig_enforce directly
Date: Wed, 11 Apr 2018 11:53:33 +0800
Message-Id: <1523418814-6857-1-git-send-email-zhang.jia@linux.alibaba.com>
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
index a6e43a5..f695474 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2785,7 +2785,7 @@ static int module_sig_check(struct load_info *info, int flags)
 	}
 
 	/* Not having a signature is only an error if we're strict. */
-	if (err == -ENOKEY && !sig_enforce)
+	if (err == -ENOKEY && !is_module_sig_enforced())
 		err = 0;
 
 	return err;
-- 
1.8.3.1
