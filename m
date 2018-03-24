Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeCXRqS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:46:18 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:49145 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752643AbeCXRqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:46:15 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:2194:2196:2198:2199:2200:2201:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3868:3870:3871:3872:4250:4321:4385:5007:6261:6737:8603:9592:10004:10848:11026:11473:11658:11914:12048:12114:12296:12438:12533:12555:12895:12986:13069:13311:13357:14096:14181:14384:14394:14721:21080:21627:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wax19_537482f00ee14
X-Filterd-Recvd-Size: 2198
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH 15/16] sh: Use INITRAMFS_GENERIC_UNLOAD
Date: Sat, 24 Mar 2018 13:44:57 -0400
Message-Id: <20180324174458.26423-16-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/sh/Kconfig   | 1 +
 arch/sh/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 97fe29316476..b6f80dad2152 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -50,6 +50,7 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select INITRAMFS_GENERIC_UNLOAD
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index ce0bbaa7e404..7451459d0725 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -477,13 +477,6 @@ void free_initmem(void)
 	free_initmem_default(-1);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		bool want_memblock)
-- 
2.16.2
