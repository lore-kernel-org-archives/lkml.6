Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D7CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1A020827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfAHPID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:08:03 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:36145 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbfAHPID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:08:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43YwcH5H4pz9v15q;
        Tue,  8 Jan 2019 16:07:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wM7Vhfiv3EJu; Tue,  8 Jan 2019 16:07:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43YwcH4p4yz9v15p;
        Tue,  8 Jan 2019 16:07:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1CF238B844;
        Tue,  8 Jan 2019 16:08:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5VqcRETIkO1j; Tue,  8 Jan 2019 16:08:01 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E76448B7DF;
        Tue,  8 Jan 2019 16:08:00 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B6481717F2; Tue,  8 Jan 2019 15:08:00 +0000 (UTC)
Message-Id: <fc763a05d2b9dbe2cb6124d97ab9a0fe9e3e5350.1546960038.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/ipic: drop unused functions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  8 Jan 2019 15:08:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipic_set_highest_priority(), ipic_enable_mcp() and ipic_disable_mcp()
are unused. This patch drops them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ipic.h |  3 ---
 arch/powerpc/sysdev/ipic.c      | 35 -----------------------------------
 2 files changed, 38 deletions(-)

diff --git a/arch/powerpc/include/asm/ipic.h b/arch/powerpc/include/asm/ipic.h
index 3dbd47f2bffe..abad50a745db 100644
--- a/arch/powerpc/include/asm/ipic.h
+++ b/arch/powerpc/include/asm/ipic.h
@@ -69,10 +69,7 @@ enum ipic_mcp_irq {
 	IPIC_MCP_MU   = 7,
 };
 
-extern void ipic_set_highest_priority(unsigned int irq);
 extern void ipic_set_default_priority(void);
-extern void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq);
-extern void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq);
 extern u32 ipic_get_mcp_status(void);
 extern void ipic_clear_mcp_status(u32 mask);
 
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 8030a0f55e96..fd129c8ecceb 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -771,21 +771,6 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	return ipic;
 }
 
-void ipic_set_highest_priority(unsigned int virq)
-{
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp;
-
-	temp = ipic_read(ipic->regs, IPIC_SICFR);
-
-	/* clear and set HPI */
-	temp &= 0x7f000000;
-	temp |= (src & 0x7f) << 24;
-
-	ipic_write(ipic->regs, IPIC_SICFR, temp);
-}
-
 void ipic_set_default_priority(void)
 {
 	ipic_write(primary_ipic->regs, IPIC_SIPRR_A, IPIC_PRIORITY_DEFAULT);
@@ -796,26 +781,6 @@ void ipic_set_default_priority(void)
 	ipic_write(primary_ipic->regs, IPIC_SMPRR_B, IPIC_PRIORITY_DEFAULT);
 }
 
-void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq)
-{
-	struct ipic *ipic = primary_ipic;
-	u32 temp;
-
-	temp = ipic_read(ipic->regs, IPIC_SERMR);
-	temp |= (1 << (31 - mcp_irq));
-	ipic_write(ipic->regs, IPIC_SERMR, temp);
-}
-
-void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq)
-{
-	struct ipic *ipic = primary_ipic;
-	u32 temp;
-
-	temp = ipic_read(ipic->regs, IPIC_SERMR);
-	temp &= (1 << (31 - mcp_irq));
-	ipic_write(ipic->regs, IPIC_SERMR, temp);
-}
-
 u32 ipic_get_mcp_status(void)
 {
 	return primary_ipic ? ipic_read(primary_ipic->regs, IPIC_SERSR) : 0;
-- 
2.13.3

