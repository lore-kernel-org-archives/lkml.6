Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeCXDAE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 23:00:04 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41995 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751531AbeCXDAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 23:00:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T--KI2d_1521860387;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com
Subject: [PATCH 1/3] module: Do not access sig_enforce directly
Date: Sat, 24 Mar 2018 10:59:47 +0800
Message-Id: <1521860389-19262-2-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
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
