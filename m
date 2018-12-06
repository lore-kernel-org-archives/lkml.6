Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B1EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B419420838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1rf2n/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B419420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeLFMZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:25:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46414 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbeLFMZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so244913wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKeBMeDd/hvI2FA7NoeqR+ehI2COJOXIft3otGKQ0o8=;
        b=f1rf2n/scEn9iSpaT9i5tOsqH/hxKSAj6AnhXUunXk4GSnehLOZkxC8cS0pFgw4bCr
         42W27ioXpFlJswetDzyyU0v692af90Dwqs2quECtDhWBNax5gIvsKM9hLqrPPRE7j0Ll
         lmKjB6prDWZDTCgiFHkvtWUXldCGgNI4PTdYxfbNiIsm2fa8ndTPa1e2B+IMHiZLgluF
         UvIdIRqvosMF9vBLQPQf3Fu54KS26Ppo8EJfjWJw1gIDuHptmHhmoyMxHbTYk0g63dy+
         hltg6bPlJ/Z27FVdlMne0eMdsDAKMqpXWJn7svGa5OscnMUePNv3cTmSevfnP+UDZuxC
         SKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKeBMeDd/hvI2FA7NoeqR+ehI2COJOXIft3otGKQ0o8=;
        b=dG7C2ChMBuxb1dxcLD+l/3GI7+r1DsolgwIC6bkiH7JnTi4E/ZRtGjjw8d5qWvcQ2R
         rRzWVU3dww/PylTkJ+gQPd2odojvn2srOxRlaSjMpfAFxiW59C7YhFef4S+GUG1Xyrmd
         G+aNkTBp4as33+Kch9rVr7MWHIzZa/ae9QJZPhpOo7yznmBhcgwo9wCVSsHH/JE+ASPS
         BySbvJbuloh+dJHKMPUkdCCHdl/jzBmEes0ngOhSPqBvIr9M9ckUL9YBQjxi1bMuzd9W
         NiIt/h2TaqdVzntBqi6MJBjVFxk/KT/OxhBzC2kcpWv/KDOm7YZN1OE4U86yChRyhX97
         LcFg==
X-Gm-Message-State: AA+aEWa8x95C+bpdVliQGlMmyXfCiftDpNiuvxAfJ4e8YbhzBTiNL7B7
        GjLoF+9UbmN+Z2/dalxzKJWszQ==
X-Google-Smtp-Source: AFSGD/Xy9XUT3vO1le8FTX7MP1mbCfMSAzWTSUArSSG7mR6VEHKyozrE6h4RIddLRyoXver8Ony3nw==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr24022433wrv.308.1544099109600;
        Thu, 06 Dec 2018 04:25:09 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:25:08 -0800 (PST)
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
Subject: [PATCH v13 13/25] kasan, arm64: fix up fault handling logic
Date:   Thu,  6 Dec 2018 13:24:31 +0100
Message-Id: <3f349b0e9e48b5df3298a6b4ae0634332274494a.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
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
index 7d9571f4ae3d..c1d98f0a3086 100644
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
+	/* entry assembly clears tags for TTBR0 addrs */
+	return addr < TASK_SIZE;
+}
+
+static inline bool is_ttbr1_addr(unsigned long addr)
+{
+	/* TTBR1 addresses may have a tag if KASAN_SW_TAGS is in use */
+	return arch_kasan_reset_tag(addr) >= VA_START;
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
2.20.0.rc1.387.gf8505762e3-goog

