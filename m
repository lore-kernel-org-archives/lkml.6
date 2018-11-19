Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F691C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429F32147A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJw352I0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429F32147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391081AbeKTDwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:52:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33189 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404457AbeKTDvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:51:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id 79so3211728wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBF5UF4+9Mv4z7HvvYvHo19YeCHdsuE1+in1R6vNAJ0=;
        b=hJw352I0VKmInsCOkuELsOv+Pahph8JfJ73CQXAZKCXN65JnrmcZlGzURxPmgXvG3g
         QazJpRBIHupHzYPfP7MYb0PuKhph+X1s8OpuF8UpSC4mgWmjWvNRznIWGSNoJFEYfVEu
         99xZ8gRRopTUIz+9Me9DLsMKuJYtjyjZOtrg6wqtXK0h63pL4szujO0UI0L0daJy1NDq
         mVnQVySQ+v+H1rd/xXcoegJ2Gs7uXsMvxU5XAJoxOrFeFq5jDJZUBIl3MB4bV1DisWdE
         3BLNXZajk3syornY+EfBF1om3yJE12IbjYbNel6kelBqvJ7+A5HKRDy/6d8eAm5ykh3K
         zlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBF5UF4+9Mv4z7HvvYvHo19YeCHdsuE1+in1R6vNAJ0=;
        b=KNlQgXUlVqm2qv48Ev4cFHbUx6crbFdbVneURdflr4NAVKsC26wrV3Ai5FoNUgVi7a
         o+JLtLX7IuU7aWLAMBTOTPK2WMj4XRaykymikTKOZVz2oBj/RV+hXr1WusJQw9EmdNag
         WA5OpFounitOfrJm+bpCHZQXaTOLV9cq9Bd75w5Ox7o0eWJCrwO4mH1HNv3Fc0kdPYlt
         MODq073D6rwKULFJKrb3ULLXIoichqdhg2iwmn925492xKsoE+meCJNC4OumN+Dxn4U1
         Cj+Fortb1evfSJvnDeRliLL70spShQADSg6SarbLPHZPfGVe3c15SMw5qD3cguFePYm9
         0Vxg==
X-Gm-Message-State: AGRZ1gJcH5x/p1LuUP6GPUTlOJquucQP48EVbJvNdsKJiBKBz6PTRAka
        7IiycMKTM8jb+PRMseD3/vXJdA==
X-Google-Smtp-Source: AFSGD/UnIiLKI4KNAdCg4BuOwdkMDxbO6AUrlCl42nJ+mPUKPiATHpNbFPe96DXL5euEhW1+kxSToA==
X-Received: by 2002:a1c:8c4d:: with SMTP id o74mr2767337wmd.134.1542648448371;
        Mon, 19 Nov 2018 09:27:28 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l143-v6sm23685190wmb.23.2018.11.19.09.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:27:27 -0800 (PST)
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
Subject: [PATCH v11 20/24] kasan, arm64: add brk handler for inline instrumentation
Date:   Mon, 19 Nov 2018 18:26:36 +0100
Message-Id: <33d91a4f2ea70b7c58cdfbedb8042118b05eca30.1542648335.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
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
index a477ce2abdc9..8da7b7a4397a 100644
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
2.19.1.1215.g8438c0b245-goog

