Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753797AbeDAPAy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 11:00:54 -0400
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:53728 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753736AbeDAPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 11:00:39 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::,RULES_HIT:41:355:379:541:800:960:965:966:968:973:988:989:1260:1345:1359:1437:1534:1540:1711:1714:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3351:3865:3867:3868:3870:3871:4321:4385:4390:4395:5007:6261:9592:10004:10848:11026:11473:11658:11914:12296:12438:12555:12895:12986:13069:13161:13229:13311:13357:14096:14181:14384:14394:14721:21080:21627:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: light22_79eacbeee253d
X-Filterd-Recvd-Size: 1747
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: [PATCH v6 16/16] um: Switch to generic free_initrd_mem.
Date: Sun,  1 Apr 2018 10:59:30 -0400
Message-Id: <20180401145931.7932-16-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180401145931.7932-1-shea@shealevy.com>
References: <20180329113207.30674-1-shea@shealevy.com>
 <20180401145931.7932-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch in this series added a weakly-defined generic
implementation, which is functionally identical to the
architecture-specific one removed here.

Series boot-tested on RISC-V (which now uses the generic
implementation) and x86_64 (which doesn't).

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/um/kernel/mem.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 3c0e470ea646..2d26eec92126 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -170,13 +170,6 @@ void free_initmem(void)
 {
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 /* Allocate and free page tables. */
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
-- 
2.16.2
