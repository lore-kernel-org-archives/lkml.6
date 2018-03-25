Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeCYWZH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:25:07 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:34452 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752360AbeCYWT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:19:29 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::::::::::,RULES_HIT:41:69:355:379:541:800:960:966:973:988:989:1260:1345:1359:1534:1541:1711:1730:1747:1777:1792:2194:2196:2199:2200:2282:2393:2559:2562:3138:3139:3140:3141:3142:3352:3876:3877:4250:4321:4385:5007:6114:6261:6642:6737:9592:10004:10848:11026:11473:11658:11914:12043:12048:12114:12291:12438:12533:12555:12683:12895:12986:13069:13311:13357:14096:14181:14384:14394:14721:21080:21627:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:15,LUA_SUMMARY:none
X-HE-Tag: sea19_3566b70bb264e
X-Filterd-Recvd-Size: 2230
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH v2 08/16] m32r: Use INITRAMFS_GENERIC_UNLOAD
Date: Sun, 25 Mar 2018 18:18:45 -0400
Message-Id: <20180325221853.10839-9-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/m32r/Kconfig   |  1 +
 arch/m32r/mm/init.c | 11 -----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index dd84ee194579..010a2b999181 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -21,6 +21,7 @@ config M32R
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DIRECT_OPS
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
+	select INITRAMFS_GENERIC_UNLOAD
 
 config SBUS
 	bool
diff --git a/arch/m32r/mm/init.c b/arch/m32r/mm/init.c
index 93abc8c3a46e..e2b5f09209ee 100644
--- a/arch/m32r/mm/init.c
+++ b/arch/m32r/mm/init.c
@@ -139,14 +139,3 @@ void free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-/*======================================================================*
- * free_initrd_mem() :
- * orig : arch/sh/mm/init.c
- *======================================================================*/
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2
