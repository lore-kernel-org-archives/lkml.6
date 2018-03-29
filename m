Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbeC2Lcs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:32:48 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:50651 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752975AbeC2Lcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:32:46 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::,RULES_HIT:41:355:379:541:800:960:965:966:968:973:988:989:1260:1345:1359:1437:1534:1538:1567:1711:1714:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3871:3874:3876:4321:4385:4390:4395:5007:6261:9592:10004:10848:11026:11473:11658:11914:12438:12555:12895:12986:13069:13311:13357:14181:14384:14394:14721:21080:21627:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: wave76_17fffa7eee00a
X-Filterd-Recvd-Size: 1382
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>
Subject: [PATCH v5 02/16] riscv: Free initrds with generic free_initrd_mem.
Date: Thu, 29 Mar 2018 07:31:53 -0400
Message-Id: <20180329113207.30674-2-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329113207.30674-1-shea@shealevy.com>
References: <20180328203659.18692-1-shea@shealevy.com>
 <20180329113207.30674-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is a generic implementation, riscv's noop stub can be
removed.

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/riscv/mm/init.c | 6 ------
 1 file changed, 6 deletions(-)

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
