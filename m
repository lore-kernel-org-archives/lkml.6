Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeCYWT0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:19:26 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:44038 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752159AbeCYWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:19:11 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1345:1359:1534:1540:1711:1714:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3350:3876:3877:4250:4321:4385:5007:6114:6261:6642:6737:9592:10004:10848:11026:11473:11658:11914:12048:12114:12296:12438:12533:12555:12895:12986:13069:13311:13357:14096:14181:14384:14394:14721:14877:21080:21611:21627,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:error,Custom_rules:0:0:0,LFtime:2000,LUA_SUMMARY:none
X-HE-Tag: burst45_325beda20ad46
X-Filterd-Recvd-Size: 1979
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH v2 02/16] riscv: Use INITRAMFS_GENERIC_UNLOAD.
Date: Sun, 25 Mar 2018 18:18:39 -0400
Message-Id: <20180325221853.10839-3-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/riscv/Kconfig   | 1 +
 arch/riscv/mm/init.c | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c22ebe08e902..ab1b4cee84fc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,6 +37,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
+	select INITRAMFS_GENERIC_UNLOAD
 
 config MMU
 	def_bool y
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c77df8142be2..36f83fe8a726 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -62,9 +62,3 @@ void free_initmem(void)
 {
 	free_initmem_default(0);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-}
-#endif /* CONFIG_BLK_DEV_INITRD */
-- 
2.16.2
