Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934880AbeCHE16 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:27:58 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48606 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753901AbeCHE1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:27:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Sz3wC4Q_1520483226;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com
Subject: [PATCH 1/4] module: Do not access sig_enforce directly
Date: Thu,  8 Mar 2018 12:27:00 +0800
Message-Id: <1520483223-6596-2-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520483223-6596-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1520483223-6596-1-git-send-email-zhang.jia@linux.alibaba.com>
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
