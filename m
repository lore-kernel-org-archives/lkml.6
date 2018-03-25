Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeCYWTk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:19:40 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:34435 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752259AbeCYWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:19:21 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::::::::::,RULES_HIT:41:69:355:379:541:800:960:966:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:4250:4321:4385:5007:6119:6261:6737:9592:10004:10848:11026:11473:11658:11914:12043:12048:12114:12296:12438:12533:12555:12683:12895:12986:13069:13311:13357:14096:14181:14384:14394:14721:21080:21627:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:0,LUA_SUMMARY:none
X-HE-Tag: wall94_345fc324aa145
X-Filterd-Recvd-Size: 2216
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH v2 06/16] frv: Use INITRAMFS_GENERIC_UNLOAD
Date: Sun, 25 Mar 2018 18:18:43 -0400
Message-Id: <20180325221853.10839-7-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/frv/Kconfig   |  1 +
 arch/frv/mm/init.c | 11 -----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index af369b05fed5..5c104b800cb1 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -17,6 +17,7 @@ config FRV
 	select OLD_SIGACTION
 	select HAVE_DEBUG_STACKOVERFLOW
 	select ARCH_NO_COHERENT_DMA_MMAP
+	select INITRAMFS_GENERIC_UNLOAD
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/frv/mm/init.c b/arch/frv/mm/init.c
index cf464100e838..345edc4dc462 100644
--- a/arch/frv/mm/init.c
+++ b/arch/frv/mm/init.c
@@ -131,14 +131,3 @@ void free_initmem(void)
 	free_initmem_default(-1);
 #endif
 } /* end free_initmem() */
-
-/*****************************************************************************/
-/*
- * free the initial ramdisk memory
- */
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-} /* end free_initrd_mem() */
-#endif
-- 
2.16.2
