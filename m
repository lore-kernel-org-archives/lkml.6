Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525800101; cv=none;
        d=google.com; s=arc-20160816;
        b=J9wTm0FHtIvqfH5x1cB9RL7IwDuTaeLGD74oJEFUi9z4waCjHjt93x0+yxtzZwthVV
         ZXHTZHE2cF4J9OrOonQB2BjghA4eiH3tR7soCsuGXZSueEtAoznJcjKS21D/N7uMCOWv
         bfe9aASYRX87qP5c8B0XjcDUTvNSdghznkch9XIgNGHgTL7iP4lwZRDV7uXvUjiiM3el
         WworzYdG/9gh7VPWgemmET2nQV7bp86IU6E6LULNjAi7Z4WoMbUTaUVAgX5KvMN82PZ2
         RRg8n9F0SivhkVqDBY+jMM1uQj1P4xP8nXY9g/Zln//8rtHv5BUSK7caJaKmYCYN/Bgx
         fSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=vS/KcpwGXBxG8BJLX2GFFP0lc8l1Zpo/Yq8CpDQW390=;
        b=QYimWUYo+C8Bv6SfLHbDaNdHq39CnWEqWMvvZ2h+RAv9M+3BmTLcDbWaSbkO9oS2rt
         +9nxnr2xmx2av7E1VfTA3J3mDdDj/s+G2wVzf81JskbeNn/5IcecfDpE2TpREPSswxLt
         KM7jmKa71t0PNWyq4Wp2llCTYhroNKwf2gOuwctkAtURoaBg1cPoJiHkn8JemfpRlyQl
         PFLdDZvH7bWxeAW8Tc0tsOgxn531Irni6NvTLvjyUfO7Wtp8stAQnFLz7TowCZ19+cfn
         l2AMD1tFCPAEHFEBr4KDuFMecNVSn3RtisRac4rPGymgu4bUC2LEjO3EYqtsctIk/8yY
         v+MA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ul6S41tq;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ul6S41tq;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZpKN6RBJ8oAtKBSfCe/3cQvTikZbk+KQJzz8zRceOVeNe6OFwmu1XkjceChXUjz9vZWBj1tHQ==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Christopher Li <sparse@chrisli.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>,
	Andrey Konovalov <andreyknvl@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <dave.martin@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	James Morse <james.morse@arm.com>,
	Michael Weiser <michael.weiser@gmx.de>,
	Julien Thierry <julien.thierry@arm.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paul Lawrence <paullawrence@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Souptick Joarder <jrdr.linux@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Laura Abbott <labbott@redhat.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pintu Agarwal <pintu.ping@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Anshuman Khandual <khandual@linux.vnet.ibm.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Kees Cook <keescook@google.com>,
	Jann Horn <jannh@google.com>,
	Mark Brand <markbrand@google.com>,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v1 14/16] khwasan, arm64: add brk handler for inline instrumentation
Date: Tue,  8 May 2018 19:21:00 +0200
Message-Id: <1259ed7ecd6e47925184964db90139bc9ef29426.1525798754.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525798753.git.andreyknvl@google.com>
References: <cover.1525798753.git.andreyknvl@google.com>
In-Reply-To: <cover.1525798753.git.andreyknvl@google.com>
References: <cover.1525798753.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917366659988730?=
X-GMAIL-MSGID: =?utf-8?q?1599917366659988730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
index 8bbdc17e49df..2234e3a4cc35 100644
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
@@ -790,7 +795,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
 	}
 
 	/* If thread survives, skip over the BUG instruction and continue: */
-	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+	__arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 	return DBG_HOOK_HANDLED;
 }
 
@@ -800,6 +805,59 @@ static struct break_hook bug_break_hook = {
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
@@ -807,6 +865,10 @@ static struct break_hook bug_break_hook = {
 int __init early_brk64(unsigned long addr, unsigned int esr,
 		struct pt_regs *regs)
 {
+#ifdef CONFIG_KASAN_HW
+	if ((esr & KHWASAN_ESR_MASK) == KHWASAN_ESR_VAL)
+		return khwasan_handler(regs, esr) != DBG_HOOK_HANDLED;
+#endif
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
 }
 
@@ -814,4 +876,7 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
 void __init trap_init(void)
 {
 	register_break_hook(&bug_break_hook);
+#ifdef CONFIG_KASAN_HW
+	register_break_hook(&khwasan_break_hook);
+#endif
 }
-- 
2.17.0.441.gb46fe60e1d-goog
