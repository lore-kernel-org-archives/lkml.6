Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDKDxh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 23:53:37 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58692 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751876AbeDKDxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 23:53:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T.-L1UH_1523418813;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com
Subject: [PATCH 2/2] module: Allow to always show the status of modsign
Date: Wed, 11 Apr 2018 11:53:34 +0800
Message-Id: <1523418814-6857-2-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523418814-6857-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1523418814-6857-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sig_enforce parameter could be always shown to reflect the
current status of modsign. For the case of CONFIG_MODULE_SIG_FORCE=y,
this modification does nothing harmless.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 kernel/module.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index f695474..1e3337b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -274,9 +274,7 @@ static void module_assert_mutex_or_preempt(void)
 }
 
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
-#ifndef CONFIG_MODULE_SIG_FORCE
 module_param(sig_enforce, bool_enable_only, 0644);
-#endif /* !CONFIG_MODULE_SIG_FORCE */
 
 /*
  * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
-- 
1.8.3.1
