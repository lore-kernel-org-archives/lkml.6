Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCC4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B3226227
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p09IhSCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B3226227
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965117AbeFYWnF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:43:05 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:51891 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933904AbeFYWnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:43:02 -0400
Received: by mail-oi0-f73.google.com with SMTP id j82-v6so9952749oiy.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=TdEqWXbG+AMIwxuNeOZR/U2UoRq1q0BnvUVxcjuzjmg=;
        b=p09IhSCimbgFEAGpj5uRaoOvk6oGtUtTV/njuF4Kn7D46TTktbzdbaxMT8Kovbp/Nw
         092Bj6D+opW5rw73Idw/cvxLrUrZqUlStzCspCbShtAH8MVZ3nZV5SesWqX3x4Sb6ZvL
         fMrmPSDZafrQLhTYdkNafLQrzF+9Vqpw5ZkuQMJwol1kx+IT7VlUxVTJlkU+XSf91TYO
         LUohzUt9d0gAOV6pyCSn/jpaUmJp+tDHqc4G3JPiqzxulbOYNazId8v9SkUprkkSL6u6
         Th6Ai7ZwBAnlOd7KwX2q68EAmOdfrlFXJ9ocE6A2/oJu4w/Skai8dNJATfbBikBA3F/s
         hs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=TdEqWXbG+AMIwxuNeOZR/U2UoRq1q0BnvUVxcjuzjmg=;
        b=qPOcI1vJvLy7k2zRR7PBWUMF22eloevR3ooK/3nU1ksxlA1ElLnwCPgdFsB7L5vRmb
         HLdqnN/auvVVOb7FImZyb27X5Y0ORJZcXQjjlptuEnXin0uw+MLymVOSwd87TX2DphyF
         t4eH8qrhC138vBrJdRF2SgT47kv0KBqrEo1qgvVwBWwRDPW4Q2ZSxGJ0jPP6+nTI0Qbi
         cCgvPrtK4sf/qmqfkxOqsg6hlwtQJoaHJ4m3pJAI5w0G39UE+dukssOr9wosQMxKRDW/
         i+8Fr7cM9C6Z0/bg5wBZQpa9FwJhmZY3PS9q6830+FqTYl3ftVPyrIpAfOWuOWqfogFE
         Fadg==
X-Gm-Message-State: APt69E2j1rAIqhYySjyrAIoL09PEPM7akiZ1OAuF9dyWr/9apSEKz3Rw
        5f3Jh//QO560dHEf/5dNoZZO0jHcTWnqIQ==
X-Google-Smtp-Source: ADUXVKLX4hT8aN1zf6RRMlH6GLrXPhSpt9SR7J4KXb+gvNJdfsfasw6LIPRMaklyfp8UplSwfXHjv9oW5HI7DA==
MIME-Version: 1.0
X-Received: by 2002:aca:4e93:: with SMTP id c141-v6mr1808894oib.1.1529966581391;
 Mon, 25 Jun 2018 15:43:01 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:15 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-28-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 27/27] x86/kaslr: Add option to extend KASLR range from 1GB
 to 3GB
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new CONFIG_RANDOMIZE_BASE_LARGE option to benefit from PIE
support. It increases the KASLR range from 1GB to 3GB. The new range
stars at 0xffffffff00000000 just above the EFI memory region. This
option is off by default.

The boot code is adapted to create the appropriate page table spanning
three PUD pages.

The relocation table uses 64-bit integers generated with the updated
relocation tool with the large-reloc option.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/Kconfig                     | 21 +++++++++++++++++++++
 arch/x86/boot/compressed/Makefile    |  5 +++++
 arch/x86/boot/compressed/misc.c      | 10 +++++++++-
 arch/x86/include/asm/page_64_types.h |  9 +++++++++
 arch/x86/kernel/head64.c             | 15 ++++++++++++---
 arch/x86/kernel/head_64.S            | 11 ++++++++++-
 6 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 42f77aff5df1..f6cb20a66e8a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2236,6 +2236,27 @@ config X86_PIE
 	select DYNAMIC_MODULE_BASE
 	select MODULE_REL_CRCS if MODVERSIONS
 
+config RANDOMIZE_BASE_LARGE
+	bool "Increase the randomization range of the kernel image"
+	depends on X86_64 && RANDOMIZE_BASE
+	select X86_PIE
+	select X86_MODULE_PLTS if MODULES
+	default n
+	---help---
+	  Build the kernel as a Position Independent Executable (PIE) and
+	  increase the available randomization range from 1GB to 3GB.
+
+	  This option impacts performance on kernel CPU intensive workloads up
+	  to 10% due to PIE generated code. Impact on user-mode processes and
+	  typical usage would be significantly less (0.50% when you build the
+	  kernel).
+
+	  The kernel and modules will generate slightly more assembly (1 to 2%
+	  increase on the .text sections). The vmlinux binary will be
+	  significantly smaller due to less relocations.
+
+	  If unsure say N
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fa42f895fdde..8497ebd5e078 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -116,7 +116,12 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 
 targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
 
+# Large randomization require bigger relocation table
+ifeq ($(CONFIG_RANDOMIZE_BASE_LARGE),y)
+CMD_RELOCS = arch/x86/tools/relocs --large-reloc
+else
 CMD_RELOCS = arch/x86/tools/relocs
+endif
 quiet_cmd_relocs = RELOCS  $@
       cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
 $(obj)/vmlinux.relocs: vmlinux FORCE
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 8dd1d5ccae58..28d17bd5bad8 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -171,10 +171,18 @@ void __puthex(unsigned long value)
 }
 
 #if CONFIG_X86_NEED_RELOCS
+
+/* Large randomization go lower than -2G and use large relocation table */
+#ifdef CONFIG_RANDOMIZE_BASE_LARGE
+typedef long rel_t;
+#else
+typedef int rel_t;
+#endif
+
 static void handle_relocations(void *output, unsigned long output_len,
 			       unsigned long virt_addr)
 {
-	int *reloc;
+	rel_t *reloc;
 	unsigned long delta, map, ptr;
 	unsigned long min_addr = (unsigned long)output;
 	unsigned long max_addr = min_addr + (VO___bss_start - VO__text);
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 6afac386a434..4a9f5ad945b4 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -46,7 +46,11 @@
 #define __PAGE_OFFSET           __PAGE_OFFSET_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
+#ifdef CONFIG_RANDOMIZE_BASE_LARGE
+#define __START_KERNEL_map	_AC(0xffffffff00000000, UL)
+#else
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
+#endif /* CONFIG_RANDOMIZE_BASE_LARGE */
 
 /* See Documentation/x86/x86_64/mm.txt for a description of the memory map. */
 
@@ -64,9 +68,14 @@
  * 512MiB by default, leaving 1.5GiB for modules once the page tables
  * are fully set up. If kernel ASLR is configured, it can extend the
  * kernel page table mapping, reducing the size of the modules area.
+ * On PIE, we relocate the binary 2G lower so add this extra space.
  */
 #if defined(CONFIG_RANDOMIZE_BASE)
+#ifdef CONFIG_RANDOMIZE_BASE_LARGE
+#define KERNEL_IMAGE_SIZE	(_AC(3, UL) * 1024 * 1024 * 1024)
+#else
 #define KERNEL_IMAGE_SIZE	(1024 * 1024 * 1024)
+#endif
 #else
 #define KERNEL_IMAGE_SIZE	(512 * 1024 * 1024)
 #endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 14bbbe592772..2276198dd2bd 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -61,6 +61,7 @@ EXPORT_SYMBOL(vmemmap_base);
 #endif
 
 #define __head	__section(.head.text)
+#define pud_count(x)   (((x + (PUD_SIZE - 1)) & ~(PUD_SIZE - 1)) >> PUD_SHIFT)
 
 /* Required for read_cr3 when building as PIE */
 unsigned long __force_order;
@@ -117,6 +118,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 {
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
+	unsigned long level3_kernel_start, level3_kernel_count;
+	unsigned long level3_fixmap_start;
 	pgdval_t *pgd;
 	p4dval_t *p4d;
 	pudval_t *pud;
@@ -148,6 +151,11 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
+	/* Look at the randomization spread to adapt page table used */
+	level3_kernel_start = pud_index(__START_KERNEL_map);
+	level3_kernel_count = pud_count(KERNEL_IMAGE_SIZE);
+	level3_fixmap_start = level3_kernel_start + level3_kernel_count;
+
 	/* Fixup the physical addresses in the page table */
 
 	pgd = fixup_pointer(&early_top_pgt, physaddr);
@@ -164,8 +172,9 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	}
 
 	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
-	pud[510] += load_delta;
-	pud[511] += load_delta;
+	for (i = 0; i < level3_kernel_count; i++)
+		pud[level3_kernel_start + i] += load_delta;
+	pud[level3_fixmap_start] += load_delta;
 
 	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
 	pmd[506] += load_delta;
@@ -223,7 +232,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 */
 
 	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
-	for (i = 0; i < PTRS_PER_PMD; i++) {
+	for (i = 0; i < PTRS_PER_PMD * level3_kernel_count; i++) {
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 	}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index fddeb3d81aa6..487227d297e8 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -41,12 +41,16 @@
 
 #define l4_index(x)	(((x) >> 39) & 511)
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#define pud_count(x)   (((x + (PUD_SIZE - 1)) & ~(PUD_SIZE - 1)) >> PUD_SHIFT)
 
 L4_PAGE_OFFSET = l4_index(__PAGE_OFFSET_BASE_L4)
 L4_START_KERNEL = l4_index(__START_KERNEL_map)
 
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
+/* Adapt page table L3 space based on range of randomization */
+L3_KERNEL_ENTRY_COUNT = pud_count(KERNEL_IMAGE_SIZE)
+
 	.text
 	__HEAD
 	.code64
@@ -431,7 +435,12 @@ NEXT_PAGE(level4_kernel_pgt)
 NEXT_PAGE(level3_kernel_pgt)
 	.fill	L3_START_KERNEL,8,0
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
-	.quad	level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
+	i = 0
+	.rept	L3_KERNEL_ENTRY_COUNT
+	.quad	level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC \
+		+ PAGE_SIZE*i
+	i = i + 1
+	.endr
 	.quad	level2_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 
 NEXT_PAGE(level2_kernel_pgt)
-- 
2.18.0.rc2.346.g013aa6912e-goog

