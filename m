Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966431AbeEJPrz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:47:55 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:56245 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966094AbeEJPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:33 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1359:1437:1534:1540:1568:1711:1714:1730:1747:1777:1792:2393:2559:2562:2689:3138:3139:3140:3141:3142:3867:3870:4321:4419:5007:6261:10004:10848:11026:11658:11914:12296:12438:12555:12895:12986:13069:13311:13357:13972:14181:14384:14394:14721:21080:21433:21451:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: hope67_1be1bfc8b2e35
X-Filterd-Recvd-Size: 1583
From: Joe Perches <joe@perches.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] printk: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:39 -0700
Message-Id: <fdcd68ac1b1c8d5e51fa04e65862c838767c04c3.1525964385.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..2ee979c30aa0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2673,7 +2673,7 @@ void register_console(struct console *newcon)
 
 	if (newcon->flags & CON_EXTENDED)
 		if (!nr_ext_console_drivers++)
-			pr_info("printk: continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");
+			pr_info("continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");
 
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/*
-- 
2.15.0
