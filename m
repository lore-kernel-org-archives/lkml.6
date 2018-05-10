Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966501AbeEJPt4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:49:56 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:52413 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966138AbeEJPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:15 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:968:973:982:988:989:1260:1345:1359:1437:1534:1539:1568:1711:1714:1730:1747:1777:1792:2194:2199:2393:2559:2562:3138:3139:3140:3141:3142:3865:3866:3874:4321:5007:6119:6261:10004:10848:11026:11658:11914:12043:12296:12438:12555:12895:13069:13161:13229:13311:13357:14181:14384:14394:14721:21080:21451:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: wind22_193e350465400
X-Filterd-Recvd-Size: 1425
From: Joe Perches <joe@perches.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] printk: Convert pr_fmt from blank define to KBUILD_MODNAME
Date: Thu, 10 May 2018 08:45:29 -0700
Message-Id: <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 1000 uses of #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
Make that the default define so these uses can be removed later via script.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/printk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6d7e800affd8..172dce24e1b6 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -285,7 +285,7 @@ static inline void printk_safe_flush_on_panic(void)
 extern int kptr_restrict;
 
 #ifndef pr_fmt
-#define pr_fmt(fmt) fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #endif
 
 /*
-- 
2.15.0
