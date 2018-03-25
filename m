Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeCYWT3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:19:29 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:58620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752175AbeCYWTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:19:13 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3866:3868:3871:4250:4321:4385:5007:6261:6737:7903:9592:10004:10848:11026:11473:11658:11914:12048:12114:12296:12438:12533:12555:12895:12986:13069:13311:13357:14096:14181:14384:14394:14721:21080:21627:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: chair83_333cfe13ad225
X-Filterd-Recvd-Size: 2142
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH v2 03/16] alpha: Use INITRAMFS_GENERIC_UNLOAD
Date: Sun, 25 Mar 2018 18:18:40 -0400
Message-Id: <20180325221853.10839-4-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/alpha/Kconfig   | 1 +
 arch/alpha/mm/init.c | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index e96adcbcab41..238d743ae8f2 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -27,6 +27,7 @@ config ALPHA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
+	select INITRAMFS_GENERIC_UNLOAD
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 9d74520298ab..55f7c8efa962 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -291,11 +291,3 @@ free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void
-free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2
