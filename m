Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1008C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAA52238E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EC41x2Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAA52238E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeHIVr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:47:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33759 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeHIVrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:47:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so6113968wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twF6sNhTtfvVSGfxuaySSxIXOdHaX4FE6UrAMHW8nGM=;
        b=EC41x2JjiJzik3Wnv94TlySKVymUooeutcZL8WXdifFiDQVmHKUbYlQDL6Ej2ctx6E
         oHRBUG14qjk0cxdUsBg+Ir7AnWicRNPrnDNrGfRfEoIgnuwlB5Yy3G+cDOc8HmETBTBV
         ZcB8Ms4y6tbKEv/RNXoLMJvpHZZmxsFMt8eedataLqmQMLur8uh7rV/6JIAXOs9KH1hM
         5mLbypAprgTDjq5AREvz9zOoNJ1c2sy08Hn5HQE37W6BeWTeFsdfeXLuB57wKly0f1Ms
         HnnCp6n4UA/+5EMcKVUAmPEWCKj04JJ8/a0FTvYGFFoQfXzF9dwQ36ZdGzLUosq0tGg3
         mHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twF6sNhTtfvVSGfxuaySSxIXOdHaX4FE6UrAMHW8nGM=;
        b=KeUq91iNJE0l7RajAy/0x7W2EDq/XTlC9H2r/S2tWyVCg8CwGyjnUxWQJzYipzY3x8
         sSEzwjUJpB9sTxNypoA+7FtEqlb5WqtEVP0uHPKLQInBC/8uoUWysSu9ltE5we4HrHh0
         Aj5lLnhSrnHGCvo2angIoGVXo6MxDX7HcdDl4heMJYDeB1xqEQXJq4yoV18X5/yMjbon
         CzjvqeBCGR1SuK4sTFG6bxG8mupu0aMteDLsKet/K4Z4uU5+jIaexEuc0dZQNsHezBRm
         zj1f10kVXC1suBfQR6BpNUkR1ddyn+ub7LfUKDdOAmd98E0QKhqpT7jZpDOy3wWoOWFo
         Eb6Q==
X-Gm-Message-State: AOUpUlF5QRAi5n53UaiyxIOxrrrAqtzue3Kb9g3jkWQha6GU8dQuP/oe
        fnGrzfZWwVUYgBJjQLGCA1mgxg==
X-Google-Smtp-Source: AA+uWPyRQtYXfr8FUdpGU+RB5iX5B4yuhSfTZOkAZZey5WmW6ezBoCWEkP49Bu5n5WocQNV2IKBARA==
X-Received: by 2002:adf:d207:: with SMTP id g7-v6mr2297275wri.91.1533842499723;
        Thu, 09 Aug 2018 12:21:39 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id o14-v6sm14738797wmd.35.2018.08.09.12.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:21:38 -0700 (PDT)
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
Subject: [PATCH v5 15/18] khwasan, arm64: add brk handler for inline instrumentation
Date:   Thu,  9 Aug 2018 21:21:07 +0200
Message-Id: <8f925694d0c885413d38e4fc79a39726d4281a3d.1533842385.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KHWASAN inline instrumentation mode (which embeds checks of shadow memory
into the generated code, instead of inserting a callback) generates a brk
instruction when a tag mismatch is detected.

This commit add a KHWASAN brk handler, that decodes the immediate value
passed to the brk instructions (to extract information about the memory
access that triggered the mismatch), reads the register values (x0 contains
the guilty address) and reports the bug.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/brk-imm.h |  2 +
 arch/arm64/kernel/traps.c        | 69 +++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
index ed693c5bcec0..e4a7013321dc 100644
--- a/arch/arm64/include/asm/brk-imm.h
+++ b/arch/arm64/include/asm/brk-imm.h
@@ -16,10 +16,12 @@
  * 0x400: for dynamic BRK instruction
  * 0x401: for compile time BRK instruction
  * 0x800: kernel-mode BUG() and WARN() traps
+ * 0x9xx: KHWASAN trap (allowed values 0x900 - 0x9ff)
  */
 #define FAULT_BRK_IMM			0x100
 #define KGDB_DYN_DBG_BRK_IMM		0x400
 #define KGDB_COMPILED_DBG_BRK_IMM	0x401
 #define BUG_BRK_IMM			0x800
+#define KHWASAN_BRK_IMM			0x900
 
 #endif
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d459397b..95152a4fd202 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -35,6 +35,7 @@
 #include <linux/sizes.h>
 #include <linux/syscalls.h>
 #include <linux/mm_types.h>
+#include <linux/kasan.h>
 
 #include <asm/atomic.h>
 #include <asm/bug.h>
@@ -269,10 +270,14 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
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
@@ -791,7 +796,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
 	}
 
 	/* If thread survives, skip over the BUG instruction and continue: */
-	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+	__arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 	return DBG_HOOK_HANDLED;
 }
 
@@ -801,6 +806,59 @@ static struct break_hook bug_break_hook = {
 	.fn = bug_handler,
 };
 
+#ifdef CONFIG_KASAN_HW
+
+#define KHWASAN_ESR_RECOVER	0x20
+#define KHWASAN_ESR_WRITE	0x10
+#define KHWASAN_ESR_SIZE_MASK	0x0f
+#define KHWASAN_ESR_SIZE(esr)	(1 << ((esr) & KHWASAN_ESR_SIZE_MASK))
+
+static int khwasan_handler(struct pt_regs *regs, unsigned int esr)
+{
+	bool recover = esr & KHWASAN_ESR_RECOVER;
+	bool write = esr & KHWASAN_ESR_WRITE;
+	size_t size = KHWASAN_ESR_SIZE(esr);
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
+	 * now. KHWASAN reporting is disabled in some contexts (for example when
+	 * the allocator accesses slab object metadata; same is true for KASAN;
+	 * this is controlled by current->kasan_depth). All these accesses are
+	 * detected by the tool, even though the reports for them are not
+	 * printed.
+	 *
+	 * This is something that might be fixed at some point in the future.
+	 */
+	if (!recover)
+		die("Oops - KHWASAN", regs, 0);
+
+	/* If thread survives, skip over the brk instruction and continue: */
+	__arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+	return DBG_HOOK_HANDLED;
+}
+
+#define KHWASAN_ESR_VAL (0xf2000000 | KHWASAN_BRK_IMM)
+#define KHWASAN_ESR_MASK 0xffffff00
+
+static struct break_hook khwasan_break_hook = {
+	.esr_val = KHWASAN_ESR_VAL,
+	.esr_mask = KHWASAN_ESR_MASK,
+	.fn = khwasan_handler,
+};
+#endif
+
 /*
  * Initial handler for AArch64 BRK exceptions
  * This handler only used until debug_traps_init().
@@ -808,6 +866,10 @@ static struct break_hook bug_break_hook = {
 int __init early_brk64(unsigned long addr, unsigned int esr,
 		struct pt_regs *regs)
 {
+#ifdef CONFIG_KASAN_HW
+	if ((esr & KHWASAN_ESR_MASK) == KHWASAN_ESR_VAL)
+		return khwasan_handler(regs, esr) != DBG_HOOK_HANDLED;
+#endif
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
 }
 
@@ -815,4 +877,7 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
 void __init trap_init(void)
 {
 	register_break_hook(&bug_break_hook);
+#ifdef CONFIG_KASAN_HW
+	register_break_hook(&khwasan_break_hook);
+#endif
 }
-- 
2.18.0.597.ga71716f1ad-goog

