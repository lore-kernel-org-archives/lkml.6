Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DA2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8D620869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usrC+MmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8D620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389914AbeKGC5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:57:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54206 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389855AbeKGC53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:57:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id v24-v6so11868049wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qG7GGQswG6z6qbF8z455/sUNiXtUU10lOp1Oj7JJWlA=;
        b=usrC+MmM1aDZFeALAY/qucJYeM4DBspv73RKgp/1or3/pITpA9tPm07GhuzXp4K/qJ
         NnundVooazUik2QJ9SkARp1FgSFa4am9Bx7wzJf5fUmyTdq83QfnHlZIk1Ck2yg1XoRt
         89ehgwWlydiqqniexC0JAVha4GEz1HJ8sVb0k7qPLQWbzm/KfQhzI73ZABvu6g79Rvtb
         JpcFj8ttwmrcGpijLGtYLl4vOUEFHDLJxMAvCsfsXf0p8MM9X8+NDsjYzRmljOBKMbB5
         BE2quiA40/7eoG51sKOUETR5fhtyj66KeEoDmG0+yxrD3y9mvPBBEyBO/dYCigFCFC/D
         v+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qG7GGQswG6z6qbF8z455/sUNiXtUU10lOp1Oj7JJWlA=;
        b=sKE3pF1rrwVkVF4hwehERg7bXmlnDJTc20g5P2jG1IrbQue0Y1CaRkhFNbxxlM7Q8a
         FMACmYLOR1dJGR8CozimOt7Juklzu+BcYlNlt5EB91b6iia91+VgFh8R7zcgoqCUNG5N
         qN4yG9WGZIaoEZE++p1tx0er20rI6EBRwUw+wUgwWZM3+oBf+Q/Ma1+RybnKgCm8GCDF
         OfrxbOq4L21JjP3y3VcRE8+pCm8m40ev7lb0k9ZsAjIwl2AlVAiPUoM45hfblKgcNeFQ
         kxBwrRI+mx4r9Hf949Nf65kicPYN3YCwWPfb479yGfXsnX2FAtSU53SpUvBv5yqVGDCN
         2g6Q==
X-Gm-Message-State: AGRZ1gLoHlrRiu5QM1YTbn2abpZEeU8aXeZg2YS1p62SXT/xh/Yvbr3i
        jg3SN8LvNlf3JFjmYORHc08AkA==
X-Google-Smtp-Source: AJdET5d3fUoOAj9jJzdwBL4RII3aygkS9jrUMcIOVUis2WZl2TDUzOuau/0A2MWlKD+3Rw/caxIKfA==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr2715568wmc.131.1541525471472;
        Tue, 06 Nov 2018 09:31:11 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z17-v6sm16328416wrm.65.2018.11.06.09.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 09:31:10 -0800 (PST)
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
Subject: [PATCH v10 18/22] kasan, arm64: add brk handler for inline instrumentation
Date:   Tue,  6 Nov 2018 18:30:33 +0100
Message-Id: <e5d9fbbf054377c2a46b872be01f9dd4a2155154.1541525354.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag-based KASAN inline instrumentation mode (which embeds checks of shadow
memory into the generated code, instead of inserting a callback) generates
a brk instruction when a tag mismatch is detected.

This commit adds a tag-based KASAN specific brk handler, that decodes the
immediate value passed to the brk instructions (to extract information
about the memory access that triggered the mismatch), reads the register
values (x0 contains the guilty address) and reports the bug.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/brk-imm.h |  2 +
 arch/arm64/kernel/traps.c        | 68 +++++++++++++++++++++++++++++++-
 include/linux/kasan.h            |  3 ++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
index ed693c5bcec0..2945fe6cd863 100644
--- a/arch/arm64/include/asm/brk-imm.h
+++ b/arch/arm64/include/asm/brk-imm.h
@@ -16,10 +16,12 @@
  * 0x400: for dynamic BRK instruction
  * 0x401: for compile time BRK instruction
  * 0x800: kernel-mode BUG() and WARN() traps
+ * 0x9xx: tag-based KASAN trap (allowed values 0x900 - 0x9ff)
  */
 #define FAULT_BRK_IMM			0x100
 #define KGDB_DYN_DBG_BRK_IMM		0x400
 #define KGDB_COMPILED_DBG_BRK_IMM	0x401
 #define BUG_BRK_IMM			0x800
+#define KASAN_BRK_IMM			0x900
 
 #endif
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5f4d9acb32f5..04bdc53716ef 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -35,6 +35,7 @@
 #include <linux/sizes.h>
 #include <linux/syscalls.h>
 #include <linux/mm_types.h>
+#include <linux/kasan.h>
 
 #include <asm/atomic.h>
 #include <asm/bug.h>
@@ -284,10 +285,14 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 	}
 }
 
-void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
+void __arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 {
 	regs->pc += size;
+}
 
+void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
+{
+	__arm64_skip_faulting_instruction(regs, size);
 	/*
 	 * If we were single stepping, we want to get the step exception after
 	 * we return from the trap.
@@ -959,7 +964,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
 	}
 
 	/* If thread survives, skip over the BUG instruction and continue: */
-	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+	__arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 	return DBG_HOOK_HANDLED;
 }
 
@@ -969,6 +974,58 @@ static struct break_hook bug_break_hook = {
 	.fn = bug_handler,
 };
 
+#ifdef CONFIG_KASAN_SW_TAGS
+
+#define KASAN_ESR_RECOVER	0x20
+#define KASAN_ESR_WRITE	0x10
+#define KASAN_ESR_SIZE_MASK	0x0f
+#define KASAN_ESR_SIZE(esr)	(1 << ((esr) & KASAN_ESR_SIZE_MASK))
+
+static int kasan_handler(struct pt_regs *regs, unsigned int esr)
+{
+	bool recover = esr & KASAN_ESR_RECOVER;
+	bool write = esr & KASAN_ESR_WRITE;
+	size_t size = KASAN_ESR_SIZE(esr);
+	u64 addr = regs->regs[0];
+	u64 pc = regs->pc;
+
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
+	kasan_report(addr, size, write, pc);
+
+	/*
+	 * The instrumentation allows to control whether we can proceed after
+	 * a crash was detected. This is done by passing the -recover flag to
+	 * the compiler. Disabling recovery allows to generate more compact
+	 * code.
+	 *
+	 * Unfortunately disabling recovery doesn't work for the kernel right
+	 * now. KASAN reporting is disabled in some contexts (for example when
+	 * the allocator accesses slab object metadata; this is controlled by
+	 * current->kasan_depth). All these accesses are detected by the tool,
+	 * even though the reports for them are not printed.
+	 *
+	 * This is something that might be fixed at some point in the future.
+	 */
+	if (!recover)
+		die("Oops - KASAN", regs, 0);
+
+	/* If thread survives, skip over the brk instruction and continue: */
+	__arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+	return DBG_HOOK_HANDLED;
+}
+
+#define KASAN_ESR_VAL (0xf2000000 | KASAN_BRK_IMM)
+#define KASAN_ESR_MASK 0xffffff00
+
+static struct break_hook kasan_break_hook = {
+	.esr_val = KASAN_ESR_VAL,
+	.esr_mask = KASAN_ESR_MASK,
+	.fn = kasan_handler,
+};
+#endif
+
 /*
  * Initial handler for AArch64 BRK exceptions
  * This handler only used until debug_traps_init().
@@ -976,6 +1033,10 @@ static struct break_hook bug_break_hook = {
 int __init early_brk64(unsigned long addr, unsigned int esr,
 		struct pt_regs *regs)
 {
+#ifdef CONFIG_KASAN_SW_TAGS
+	if ((esr & KASAN_ESR_MASK) == KASAN_ESR_VAL)
+		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
+#endif
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
 }
 
@@ -983,4 +1044,7 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
 void __init trap_init(void)
 {
 	register_break_hook(&bug_break_hook);
+#ifdef CONFIG_KASAN_SW_TAGS
+	register_break_hook(&kasan_break_hook);
+#endif
 }
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 4c9d6f9029f2..d5a2a7f1f72c 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -173,6 +173,9 @@ void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
 
+void kasan_report(unsigned long addr, size_t size,
+		bool is_write, unsigned long ip);
+
 #else /* CONFIG_KASAN_SW_TAGS */
 
 static inline void kasan_init_tags(void) { }
-- 
2.19.1.930.g4563a0d9d0-goog

