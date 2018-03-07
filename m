Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbeCGKLS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:11:18 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46871 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeCGKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:11:15 -0500
X-Google-Smtp-Source: AG47ELsUkhjzAR1JEj/OsSeg8vCdSzmGrGohgUL/2RksI52pGWoJgSHJ8UCWMQi9ShRQ09QyO7OONg==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, sergey.senozhatsky.work@gmail.com,
        sergey.senozhatsky@gmail.com, sfr@canb.auug.org.au,
        peterz@infradead.org, pmladek@suse.com
Subject: [PATCH] nds32: To use the generic dump_stack()
Date: Wed,  7 Mar 2018 18:10:11 +0800
Message-Id: <20180307101011.28689-1-greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic dump_stack() instead of nds32 one because they are doing
the same thing.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/kernel/traps.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 8828b4aeb72b..6e34eb9824a4 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -156,18 +156,6 @@ static void __dump(struct task_struct *tsk, unsigned long *base_reg)
 	pr_emerg("\n");
 }
 
-void dump_stack(void)
-{
-	unsigned long *base_reg;
-	if (!IS_ENABLED(CONFIG_FRAME_POINTER))
-		__asm__ __volatile__("\tori\t%0, $sp, #0\n":"=r"(base_reg));
-	else
-		__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(base_reg));
-	__dump(NULL, base_reg);
-}
-
-EXPORT_SYMBOL(dump_stack);
-
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
 	unsigned long *base_reg;
-- 
2.16.1
