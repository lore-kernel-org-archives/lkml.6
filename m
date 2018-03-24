Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752893AbeCXRqZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:46:25 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:52121 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752850AbeCXRqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:46:17 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3352:3868:4250:4321:4385:5007:6119:6261:6737:9592:10004:10848:11026:11473:11658:11914:12048:12114:12296:12438:12533:12555:12895:12986:13069:13311:13357:14096:14181:14384:14394:14721:21080:21451:21627:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: van88_53baae234fa17
X-Filterd-Recvd-Size: 2042
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH 16/16] um: Use INITRAMFS_GENERIC_UNLOAD
Date: Sat, 24 Mar 2018 13:44:58 -0400
Message-Id: <20180324174458.26423-17-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/um/Kconfig.common | 1 +
 arch/um/kernel/mem.c   | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index c68add8df3ae..1cb8a023938b 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -13,6 +13,7 @@ config UML
 	select GENERIC_CLOCKEVENTS
 	select HAVE_GCC_PLUGINS
 	select TTY # Needed for line.c
+	select INITRAMFS_GENERIC_UNLOAD
 
 config MMU
 	bool
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
