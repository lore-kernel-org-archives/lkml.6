Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D07C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D552171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="AEv8hJdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfA1LLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:11:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:11740 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfA1LLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:11:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43p6Pk6Tqvz9v1q8;
        Mon, 28 Jan 2019 12:11:06 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AEv8hJdA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id J9_mTbBt8dF8; Mon, 28 Jan 2019 12:11:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43p6Pk5Qlxz9v1q3;
        Mon, 28 Jan 2019 12:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548673866; bh=V6wxBPbg9CEGEYFnmEtmNP2CFKywDtpe70JqDg1O7+I=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=AEv8hJdA7hHCA6ODUr/4gUQoRwbHOuMBE9wNYxW67rl3NcjzMd2Hr4TORX/2F9JHp
         3i/ePfn6FFgdVunGQYy3bGSZBEsoF2vYelfmWZZT13hMuGpDcrahqTJuvXDezFEWIs
         s0H+myaZ5eAOXloBtmMjyERrFu1nl8gfZU/aVc2U=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 39F9F8B79D;
        Mon, 28 Jan 2019 12:11:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Fen8MARGJJom; Mon, 28 Jan 2019 12:11:13 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE4E98B796;
        Mon, 28 Jan 2019 12:11:12 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EE47A72DE6; Mon, 28 Jan 2019 11:11:12 +0000 (UTC)
Message-Id: <d216978ebe0dbcc47d26997085248b267f55e825.1548673552.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 01/11] powerpc/32: Rename THREAD_INFO to TASK_STACK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 28 Jan 2019 11:11:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames THREAD_INFO to TASK_STACK, because it is in fact
the offset of the pointer to the stack in task_struct so this pointer
will not be impacted by the move of THREAD_INFO.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/asm-offsets.c    | 2 +-
 arch/powerpc/kernel/entry_32.S       | 2 +-
 arch/powerpc/kernel/head_32.S        | 2 +-
 arch/powerpc/kernel/head_40x.S       | 4 ++--
 arch/powerpc/kernel/head_8xx.S       | 2 +-
 arch/powerpc/kernel/head_booke.h     | 4 ++--
 arch/powerpc/kernel/head_fsl_booke.S | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ffc72ded73a..23456ba3410a 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -90,7 +90,7 @@ int main(void)
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
 #else
-	OFFSET(THREAD_INFO, task_struct, stack);
+	OFFSET(TASK_STACK, task_struct, stack);
 	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0768dfd8a64e..3f83e71ae43f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1166,7 +1166,7 @@ ret_from_debug_exc:
 	mfspr	r9,SPRN_SPRG_THREAD
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
-	lwz	r9,THREAD_INFO-THREAD(r9)
+	lwz	r9,TASK_STACK-THREAD(r9)
 	CURRENT_THREAD_INFO(r10, r1)
 	lwz	r10,TI_PREEMPT(r10)
 	stw	r10,TI_PREEMPT(r9)
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 05b08db3901d..9268e5e87949 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -261,7 +261,7 @@ __secondary_hold_acknowledge:
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
 	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,THREAD_INFO-THREAD(r11);	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
 1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index b19d78410511..3088c9f29f5e 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -115,7 +115,7 @@ _ENTRY(saved_ksp_limit)
 	andi.	r11,r11,MSR_PR;						     \
 	beq	1f;							     \
 	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
+	lwz	r1,TASK_STACK-THREAD(r1); /* this thread's kernel stack   */\
 	addi	r1,r1,THREAD_SIZE;					     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	tophys(r11,r1);							     \
@@ -158,7 +158,7 @@ _ENTRY(saved_ksp_limit)
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
 1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc an excpt frm  */\
 	tophys(r11,r11);						     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 20cc816b3508..ca9207013579 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -142,7 +142,7 @@ instruction_counter:
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
 	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,THREAD_INFO-THREAD(r11);	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
 1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 306e26c073a0..69e80e6d0d16 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -55,7 +55,7 @@ END_BTB_FLUSH_SECTION
 	beq	1f;							     \
 	BOOKE_CLEAR_BTB(r11)						\
 	/* if from user, start at top of this thread's kernel stack */       \
-	lwz	r11, THREAD_INFO-THREAD(r10);				     \
+	lwz	r11, TASK_STACK - THREAD(r10);				     \
 	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
 1 :	subi	r11, r11, INT_FRAME_SIZE; /* Allocate exception frame */     \
 	stw	r13, _CCR(r11);		/* save various registers */	     \
@@ -142,7 +142,7 @@ END_BTB_FLUSH_SECTION
 	BOOKE_CLEAR_BTB(r10)						\
 	andi.	r11,r11,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	lwz	r11, TASK_STACK - THREAD(r11); /* this thread's kernel stack */\
 	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 2386ce2a9c6e..acf9a58c3c00 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -717,7 +717,7 @@ finish_tlb_load:
 
 	/* Get the next_tlbcam_idx percpu var */
 #ifdef CONFIG_SMP
-	lwz	r12, THREAD_INFO-THREAD(r12)
+	lwz	r12, TASK_STACK-THREAD(r12)
 	lwz	r15, TI_CPU(r12)
 	lis     r14, __per_cpu_offset@h
 	ori     r14, r14, __per_cpu_offset@l
-- 
2.13.3

