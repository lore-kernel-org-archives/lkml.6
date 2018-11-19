Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D332DC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BA2213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezP0ESTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BA2213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbeKTDxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:53:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40705 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404731AbeKTDvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:51:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so6050914wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UxJd/TD5dhnni0EdJsiBbVNK+EVuSfLspufPfY8Op0=;
        b=ezP0ESTGIDPD6PIZXaeQ1HQvAtE12YKEKXk2IQhb30r0JyeclvTIkALJudtga1L/Q3
         sfSqapZGnhPLM3BAb3PXOYLm/bZTb1MZ54ZRnv6h5/3IlejoIUHx/AaGd5qfhPuKxnpn
         GsnYAXIpMb9ohJGYhY0zD2xvR+T/Aku8msHLcEukSHopb9SGDZXGijaVWkpc9CKGUaiu
         VLTlA6dJNpc7t3wdP5GQdvZ/cbM0ca5EE+ZdL+ZEBNJjVa09dOGeUYw8b0oESjRUAScJ
         k2aoTr6qOxO96slc3aQpZ9kDtYvc9TSHsfhmZQgS17UlDgmj7Ll18teQgR09yy1V1Gpr
         QcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UxJd/TD5dhnni0EdJsiBbVNK+EVuSfLspufPfY8Op0=;
        b=Ci+nFghO4o8HkiO+VSeC2eIVKFJJjuqXt9Td6xTUrcidUU387jdZ90JBYxtJfbE8hO
         gdp11OtRUG/93dSItLsCdLFy4NFbAzOUFSUjONRi9/OjySrSTKh6Qr+F3lmWK+zM5zjK
         TYWUAZbDmTbFoUoJTrhxSjy7h5Jx0AHNDV274oJ7t7qOEJOH5INQgdDLWEPpEWG/1eBy
         2v0IgBipVbasUUPyGYf2LfDYA0tIlbyTumBsjVCMeiMIuRN2r1xdlMftO9l58KEhEq4n
         bVv+GMhTOvi4GoRqgKDfK6WHSVJD/Ai1YboXuUSdO9YCM7517O3UMrC8Kb1ZZB82y+WT
         mOMA==
X-Gm-Message-State: AGRZ1gLiL2Z2Zh/jc6qQHVYHKJ53KLlTCO2YJNebcEyjh7gU3A76CrLD
        AJ4a+vThJ1XeTjAeHuoJbKA+mw==
X-Google-Smtp-Source: AJdET5f/CWAArcyhbvqSSe7+ZirG+qS0xHVggXGTUB5W8Aw5Wyx6utJIbL2GhHlD46DxV8W80eGl3Q==
X-Received: by 2002:a1c:f514:: with SMTP id t20-v6mr7673551wmh.129.1542648436015;
        Mon, 19 Nov 2018 09:27:16 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l143-v6sm23685190wmb.23.2018.11.19.09.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:27:15 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v11 13/24] kasan, arm64: fix up fault handling logic
Date:   Mon, 19 Nov 2018 18:26:29 +0100
Message-Id: <99c747edfba8ea4b93d9c70aac47ea86ef258b86.1542648335.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now arm64 fault handling code removes pointer tags from addresses
covered by TTBR0 in faults taken from both EL0 and EL1, but doesn't do
that for pointers covered by TTBR1.

This patch adds two helper functions is_ttbr0_addr() and is_ttbr1_addr(),
where the latter one accounts for the fact that TTBR1 pointers might be
tagged when tag-based KASAN is in use, and uses these helper functions to
perform pointer checks in arch/arm64/mm/fault.c.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7d9571f4ae3d..6023d4752701 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -40,6 +40,7 @@
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
+#include <asm/kasan.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/pgtable.h>
@@ -132,6 +133,18 @@ static void mem_abort_decode(unsigned int esr)
 		data_abort_decode(esr);
 }
 
+static inline bool is_ttbr0_addr(unsigned long addr)
+{
+        /* entry assembly clears tags for TTBR0 addrs */
+        return addr < TASK_SIZE;
+}
+
+static inline bool is_ttbr1_addr(unsigned long addr)
+{
+        /* TTBR1 addresses may have a tag if KASAN_SW_TAGS is in use */
+        return arch_kasan_reset_tag(addr) >= VA_START;
+}
+
 /*
  * Dump out the page tables associated with 'addr' in the currently active mm.
  */
@@ -141,7 +154,7 @@ void show_pte(unsigned long addr)
 	pgd_t *pgdp;
 	pgd_t pgd;
 
-	if (addr < TASK_SIZE) {
+	if (is_ttbr0_addr(addr)) {
 		/* TTBR0 */
 		mm = current->active_mm;
 		if (mm == &init_mm) {
@@ -149,7 +162,7 @@ void show_pte(unsigned long addr)
 				 addr);
 			return;
 		}
-	} else if (addr >= VA_START) {
+	} else if (is_ttbr1_addr(addr)) {
 		/* TTBR1 */
 		mm = &init_mm;
 	} else {
@@ -254,7 +267,7 @@ static inline bool is_el1_permission_fault(unsigned long addr, unsigned int esr,
 	if (fsc_type == ESR_ELx_FSC_PERM)
 		return true;
 
-	if (addr < TASK_SIZE && system_uses_ttbr0_pan())
+	if (is_ttbr0_addr(addr) && system_uses_ttbr0_pan())
 		return fsc_type == ESR_ELx_FSC_FAULT &&
 			(regs->pstate & PSR_PAN_BIT);
 
@@ -319,7 +332,7 @@ static void set_thread_esr(unsigned long address, unsigned int esr)
 	 * type", so we ignore this wrinkle and just return the translation
 	 * fault.)
 	 */
-	if (current->thread.fault_address >= TASK_SIZE) {
+	if (!is_ttbr0_addr(current->thread.fault_address)) {
 		switch (ESR_ELx_EC(esr)) {
 		case ESR_ELx_EC_DABT_LOW:
 			/*
@@ -455,7 +468,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
 
-	if (addr < TASK_SIZE && is_el1_permission_fault(addr, esr, regs)) {
+	if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, regs)) {
 		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
 		if (regs->orig_addr_limit == KERNEL_DS)
 			die_kernel_fault("access to user memory with fs=KERNEL_DS",
@@ -603,7 +616,7 @@ static int __kprobes do_translation_fault(unsigned long addr,
 					  unsigned int esr,
 					  struct pt_regs *regs)
 {
-	if (addr < TASK_SIZE)
+	if (is_ttbr0_addr(addr))
 		return do_page_fault(addr, esr, regs);
 
 	do_bad_area(addr, esr, regs);
@@ -758,7 +771,7 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	 * re-enabled IRQs. If the address is a kernel address, apply
 	 * BP hardening prior to enabling IRQs and pre-emption.
 	 */
-	if (addr > TASK_SIZE)
+	if (!is_ttbr0_addr(addr))
 		arm64_apply_bp_hardening();
 
 	local_daif_restore(DAIF_PROCCTX);
@@ -771,7 +784,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 					   struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
-		if (instruction_pointer(regs) > TASK_SIZE)
+		if (!is_ttbr0_addr(instruction_pointer(regs)))
 			arm64_apply_bp_hardening();
 		local_daif_restore(DAIF_PROCCTX);
 	}
@@ -825,7 +838,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
-	if (user_mode(regs) && instruction_pointer(regs) > TASK_SIZE)
+	if (user_mode(regs) && !is_ttbr0_addr(instruction_pointer(regs)))
 		arm64_apply_bp_hardening();
 
 	if (!inf->fn(addr, esr, regs)) {
-- 
2.19.1.1215.g8438c0b245-goog

