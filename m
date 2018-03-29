Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeC2LgD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:36:03 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:54028 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752575AbeC2Lcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:32:53 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::,RULES_HIT:41:355:379:541:800:960:965:966:973:988:989:1260:1345:1359:1437:1534:1539:1567:1711:1714:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3865:3871:4321:4385:4390:4395:5007:6261:9592:10004:10848:11026:11473:11658:11914:12438:12555:12895:12986:13069:13161:13229:13311:13357:14181:14384:14394:14721:21080:21627:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: dime15_18ec1435bff05
X-Filterd-Recvd-Size: 1397
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH v5 04/16] arc: Switch to generic free_initrd_mem.
Date: Thu, 29 Mar 2018 07:31:55 -0400
Message-Id: <20180329113207.30674-4-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329113207.30674-1-shea@shealevy.com>
References: <20180328203659.18692-1-shea@shealevy.com>
 <20180329113207.30674-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic implementation is functionally identical.

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/arc/mm/init.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index ba145065c579..7bcf23ab1756 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -229,10 +229,3 @@ void __ref free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2
