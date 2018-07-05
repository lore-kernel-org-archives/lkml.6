Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620A1C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277A8240C7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277A8240C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754450AbeGEQ02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:26:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4409 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753982AbeGEQZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:25:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41M39W6qnPz9ttmc;
        Thu,  5 Jul 2018 18:25:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zy3HnuvlWcsv; Thu,  5 Jul 2018 18:25:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41M39W6N3Zz9ttm7;
        Thu,  5 Jul 2018 18:25:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B3C7C8B8CF;
        Thu,  5 Jul 2018 18:25:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xroyHCPOAe3P; Thu,  5 Jul 2018 18:25:05 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CC338B8BC;
        Thu,  5 Jul 2018 18:25:05 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 82168711E2; Thu,  5 Jul 2018 16:25:05 +0000 (UTC)
Message-Id: <918a4533548b1f2b5ffc16c05cac1c6b0a808142.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 08/16] powerpc: declare set_breakpoint() static
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 16:25:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_breakpoint() is only used in process.c so make it static

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/debug.h |  1 -
 arch/powerpc/kernel/process.c    | 14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index ce5da214ffe5..7756026b95ca 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -45,7 +45,6 @@ static inline int debugger_break_match(struct pt_regs *regs) { return 0; }
 static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
-void set_breakpoint(struct arch_hw_breakpoint *brk);
 void __set_breakpoint(struct arch_hw_breakpoint *brk);
 bool ppc_breakpoint_available(void);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9ef4aea9fffe..6061efb369e8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -716,6 +716,13 @@ void switch_booke_debug_regs(struct debug_reg *new_debug)
 EXPORT_SYMBOL_GPL(switch_booke_debug_regs);
 #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
+static void set_breakpoint(struct arch_hw_breakpoint *brk)
+{
+	preempt_disable();
+	__set_breakpoint(brk);
+	preempt_enable();
+}
+
 static void set_debug_reg_defaults(struct thread_struct *thread)
 {
 	thread->hw_brk.address = 0;
@@ -828,13 +835,6 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
 		WARN_ON_ONCE(1);
 }
 
-void set_breakpoint(struct arch_hw_breakpoint *brk)
-{
-	preempt_disable();
-	__set_breakpoint(brk);
-	preempt_enable();
-}
-
 /* Check if we have DAWR or DABR hardware */
 bool ppc_breakpoint_available(void)
 {
-- 
2.13.3

