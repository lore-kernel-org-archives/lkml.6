Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A94C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89A026217
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apXGASg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89A026217
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965046AbeFYWmq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:42:46 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:41028 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964955AbeFYWmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:42:42 -0400
Received: by mail-ua0-f201.google.com with SMTP id l15-v6so97797uae.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ESq6rfDNik/kXwRZbH6VPHQYFEm3dOylYovQo3are/c=;
        b=apXGASg/GZZ7EKt+TqN7gssCs0OUjKQFdfG//DagNhRFBL1cvg8Nq6xVYuLI/9Djc1
         qGIVO7TCHsEiE+8RrrpuMW3SX+88d1JBFT5I7zufdfRy6M5WtXuzB/jwzlIlWbyfYuon
         +ng8ka561FKuTrIjDxeg56ey2NYLoLEiGMurwTTb7VMLRZBIw2N993zD5AzD+k0yYB5B
         JPkKG7t/wZ65cblDPV0ftVZxabrFo+LJc6Ig/RBdQVSvSQBMJVDLKyPSBS+vs7mgKwxj
         K6w3aRDRj7EKb8c+nZe/XASN2+OX94VTZtRRxFuXCOtFK8v78MZn9pdJGao2iDwo6rG5
         o2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ESq6rfDNik/kXwRZbH6VPHQYFEm3dOylYovQo3are/c=;
        b=Ce7GMbhtgW/qc3ZQ7E9oVyZz9sONvpkOG9Fq49R+2xzVrYSig0plp32vEFQZypZCVQ
         TE1ipPTfZSTDNiWO2hB8hBIlTnhMa6Y4oHWD6x+OEtwSqhs2mjgelRX9o7vtM2F757jE
         Tzh0FdpcAkM2EKNFAuubEgcaXKvywoD4vyyc1/0jOd6Ro9DBacS9W4CACN9HgfGMFCLi
         yByErNbOpf8vLVliZCpFAfEA6djMbdpTHchhXtkY+pJQUtenln1YIU/R4qUBqC1QjxzY
         o+uY7JfwP84YTL5VYYS8TLQEdVlUtcjblFXR1aM6CIwM16cLgnzYEGTz+CboGXhPLM05
         0tbQ==
X-Gm-Message-State: APt69E0ayvVEk15VMG+cZB52Ql3wt25aSBhp5/Osj3crefkdo+m2jJjr
        BQn73TAjCHXA1F7wmnvGn+YNGSvt3k1EDg==
X-Google-Smtp-Source: AAOMgpcxXRNJbW5X93NASiV2u43AinBKGHy3rRyXlnkHjLAkxQY/pD5u5IXw1Yo/4CLW1pkDXob5o/OZNAGmHA==
MIME-Version: 1.0
X-Received: by 2002:a1f:245:: with SMTP id 66-v6mr1609237vkc.35.1529966561458;
 Mon, 25 Jun 2018 15:42:41 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:11 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-24-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 23/27] x86/modules: Adapt module loading for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt module loading to support PIE relocations. Generate dynamic GOT if
a symbol requires it but no entry exists in the kernel GOT.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/Makefile               |   4 +
 arch/x86/include/asm/module.h   |  11 ++
 arch/x86/include/asm/sections.h |   4 +
 arch/x86/kernel/module.c        | 181 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/module.lds      |   3 +
 5 files changed, 198 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/kernel/module.lds

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index c2c221fd20d7..112ccdc99566 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -134,7 +134,11 @@ else
         KBUILD_CFLAGS += $(cflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
+ifdef CONFIG_X86_PIE
+        KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/x86/kernel/module.lds
+else
         KBUILD_CFLAGS += -mcmodel=kernel
+endif
 
         # -funit-at-a-time shrinks the kernel .text considerably
         # unfortunately it makes reading oopses harder.
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index 7948a17febb4..68ff05e14288 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -5,12 +5,23 @@
 #include <asm-generic/module.h>
 #include <asm/orc_types.h>
 
+#ifdef CONFIG_X86_PIE
+struct mod_got_sec {
+	struct elf64_shdr	*got;
+	int			got_num_entries;
+	int			got_max_entries;
+};
+#endif
+
 struct mod_arch_specific {
 #ifdef CONFIG_UNWINDER_ORC
 	unsigned int num_orcs;
 	int *orc_unwind_ip;
 	struct orc_entry *orc_unwind;
 #endif
+#ifdef CONFIG_X86_PIE
+	struct mod_got_sec	core;
+#endif
 };
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 5c019d23d06b..da3d98bb2bcb 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -13,4 +13,8 @@ extern char __end_rodata_hpage_align[];
 extern char __entry_trampoline_start[], __entry_trampoline_end[];
 #endif
 
+#if defined(CONFIG_X86_PIE)
+extern char __start_got[], __end_got[];
+#endif
+
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index f58336af095c..88895f3d474b 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -30,6 +30,7 @@
 #include <linux/gfp.h>
 #include <linux/jump_label.h>
 #include <linux/random.h>
+#include <linux/sort.h>
 
 #include <asm/text-patching.h>
 #include <asm/page.h>
@@ -77,6 +78,173 @@ static unsigned long int get_module_load_offset(void)
 }
 #endif
 
+#ifdef CONFIG_X86_PIE
+static u64 find_got_kernel_entry(Elf64_Sym *sym, const Elf64_Rela *rela)
+{
+	u64 *pos;
+
+	for (pos = (u64*)__start_got; pos < (u64*)__end_got; pos++) {
+		if (*pos == sym->st_value)
+			return (u64)pos + rela->r_addend;
+	}
+
+	return 0;
+}
+
+static u64 module_emit_got_entry(struct module *mod, void *loc,
+				 const Elf64_Rela *rela, Elf64_Sym *sym)
+{
+	struct mod_got_sec *gotsec = &mod->arch.core;
+	u64 *got = (u64*)gotsec->got->sh_addr;
+	int i = gotsec->got_num_entries;
+	u64 ret;
+
+	/* Check if we can use the kernel GOT */
+	ret = find_got_kernel_entry(sym, rela);
+	if (ret)
+		return ret;
+
+	got[i] = sym->st_value;
+
+	/*
+	 * Check if the entry we just created is a duplicate. Given that the
+	 * relocations are sorted, this will be the last entry we allocated.
+	 * (if one exists).
+	 */
+	if (i > 0 && got[i] == got[i - 2]) {
+		ret = (u64)&got[i - 1];
+	} else {
+		gotsec->got_num_entries++;
+		BUG_ON(gotsec->got_num_entries > gotsec->got_max_entries);
+		ret = (u64)&got[i];
+	}
+
+	return ret + rela->r_addend;
+}
+
+#define cmp_3way(a,b)	((a) < (b) ? -1 : (a) > (b))
+
+static int cmp_rela(const void *a, const void *b)
+{
+	const Elf64_Rela *x = a, *y = b;
+	int i;
+
+	/* sort by type, symbol index and addend */
+	i = cmp_3way(ELF64_R_TYPE(x->r_info), ELF64_R_TYPE(y->r_info));
+	if (i == 0)
+		i = cmp_3way(ELF64_R_SYM(x->r_info), ELF64_R_SYM(y->r_info));
+	if (i == 0)
+		i = cmp_3way(x->r_addend, y->r_addend);
+	return i;
+}
+
+static bool duplicate_rel(const Elf64_Rela *rela, int num)
+{
+	/*
+	 * Entries are sorted by type, symbol index and addend. That means
+	 * that, if a duplicate entry exists, it must be in the preceding
+	 * slot.
+	 */
+	return num > 0 && cmp_rela(rela + num, rela + num - 1) == 0;
+}
+
+static unsigned int count_gots(Elf64_Sym *syms, Elf64_Rela *rela, int num)
+{
+	unsigned int ret = 0;
+	Elf64_Sym *s;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		switch (ELF64_R_TYPE(rela[i].r_info)) {
+		case R_X86_64_GOTPCREL:
+			s = syms + ELF64_R_SYM(rela[i].r_info);
+
+			/*
+			 * Use the kernel GOT when possible, else reserve a
+			 * custom one for this module.
+			 */
+			if (!duplicate_rel(rela, i) &&
+			    !find_got_kernel_entry(s, rela + i))
+				ret++;
+			break;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Generate GOT entries for GOTPCREL relocations that do not exists in the
+ * kernel GOT. Based on arm64 module-plts implementation.
+ */
+int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
+			      char *secstrings, struct module *mod)
+{
+	unsigned long gots = 0;
+	Elf_Shdr *symtab = NULL;
+	Elf64_Sym *syms = NULL;
+	char *strings, *name;
+	int i;
+
+	/*
+	 * Find the empty .got section so we can expand it to store the PLT
+	 * entries. Record the symtab address as well.
+	 */
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (!strcmp(secstrings + sechdrs[i].sh_name, ".got")) {
+			mod->arch.core.got = sechdrs + i;
+		} else if (sechdrs[i].sh_type == SHT_SYMTAB) {
+			symtab = sechdrs + i;
+			syms = (Elf64_Sym *)symtab->sh_addr;
+		}
+	}
+
+	if (!mod->arch.core.got) {
+		pr_err("%s: module GOT section missing\n", mod->name);
+		return -ENOEXEC;
+	}
+	if (!syms) {
+		pr_err("%s: module symtab section missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		Elf64_Rela *rels = (void *)ehdr + sechdrs[i].sh_offset;
+		int numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
+
+		if (sechdrs[i].sh_type != SHT_RELA)
+			continue;
+
+		/* sort by type, symbol index and addend */
+		sort(rels, numrels, sizeof(Elf64_Rela), cmp_rela, NULL);
+
+		gots += count_gots(syms, rels, numrels);
+	}
+
+	mod->arch.core.got->sh_type = SHT_NOBITS;
+	mod->arch.core.got->sh_flags = SHF_ALLOC;
+	mod->arch.core.got->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.core.got->sh_size = (gots + 1) * sizeof(u64);
+	mod->arch.core.got_num_entries = 0;
+	mod->arch.core.got_max_entries = gots;
+
+	/*
+	 * If a _GLOBAL_OFFSET_TABLE_ symbol exists, make it absolute for
+	 * modules to correctly reference it. Similar to s390 implementation.
+	 */
+	strings = (void *) ehdr + sechdrs[symtab->sh_link].sh_offset;
+	for (i = 0; i < symtab->sh_size/sizeof(Elf_Sym); i++) {
+		if (syms[i].st_shndx != SHN_UNDEF)
+			continue;
+		name = strings + syms[i].st_name;
+		if (!strcmp(name, "_GLOBAL_OFFSET_TABLE_")) {
+			syms[i].st_shndx = SHN_ABS;
+			break;
+		}
+	}
+	return 0;
+}
+#endif
+
 void *module_alloc(unsigned long size)
 {
 	void *p;
@@ -190,16 +358,20 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			if ((s64)val != *(s32 *)loc)
 				goto overflow;
 			break;
+#ifdef CONFIG_X86_PIE
+		case R_X86_64_GOTPCREL:
+			val = module_emit_got_entry(me, loc, rel + i, sym);
+			/* fallthrough */
+#endif
 		case R_X86_64_PC32:
 		case R_X86_64_PLT32:
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
 			*(u32 *)loc = val;
-#if 0
-			if ((s64)val != *(s32 *)loc)
+			if (IS_ENABLED(CONFIG_X86_PIE) &&
+			    (s64)val != *(s32 *)loc)
 				goto overflow;
-#endif
 			break;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
@@ -217,8 +389,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 overflow:
 	pr_err("overflow in relocation type %d val %Lx\n",
 	       (int)ELF64_R_TYPE(rel[i].r_info), val);
-	pr_err("`%s' likely not compiled with -mcmodel=kernel\n",
-	       me->name);
+	pr_err("`%s' likely too far from the kernel\n", me->name);
 	return -ENOEXEC;
 }
 #endif
diff --git a/arch/x86/kernel/module.lds b/arch/x86/kernel/module.lds
new file mode 100644
index 000000000000..fd6e95a4b454
--- /dev/null
+++ b/arch/x86/kernel/module.lds
@@ -0,0 +1,3 @@
+SECTIONS {
+	.got (NOLOAD) : { BYTE(0) }
+}
-- 
2.18.0.rc2.346.g013aa6912e-goog

