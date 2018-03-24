Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeCXRp7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:45:59 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:45416 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752741AbeCXRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:45:53 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1345:1359:1534:1540:1711:1714:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3351:3876:3877:4250:4321:4385:5007:6114:6261:6642:6737:9592:10004:10848:11026:11473:11658:11914:12048:12114:12296:12438:12533:12555:12895:13069:13311:13357:14096:14181:14384:14394:14721:21080:21627,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: bird27_503c7aca1583d
X-Filterd-Recvd-Size: 2031
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH 05/16] c6x: Use INITRAMFS_GENERIC_UNLOAD
Date: Sat, 24 Mar 2018 13:44:47 -0400
Message-Id: <20180324174458.26423-6-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/c6x/Kconfig   | 1 +
 arch/c6x/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index c6b4dd1418b4..857f95f9a6a4 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -19,6 +19,7 @@ config C6X
 	select GENERIC_CLOCKEVENTS
 	select MODULES_USE_ELF_RELA
 	select ARCH_NO_COHERENT_DMA_MMAP
+	select INITRAMFS_GENERIC_UNLOAD
 
 config MMU
 	def_bool n
diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index 4cc72b0d1c1d..a11cb657182a 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -66,13 +66,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void __init free_initmem(void)
 {
 	free_initmem_default(-1);
-- 
2.16.2
