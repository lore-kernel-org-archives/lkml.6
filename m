Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx48Yb7bT4G8p0EkGBEHNvr7onJ/bUonDxvuk1VbsaWunw70IraKNjiJx+d3braxU/A6kd0ww
ARC-Seal: i=1; a=rsa-sha256; t=1523294189; cv=none;
        d=google.com; s=arc-20160816;
        b=FTwqFmcfgQYVJfpmSqT4XECk2ZRlXho3PyzbPX82zy2khzUW8s3kjLy6ycq9vWS6uk
         /R75zrkSLEffKai8yZOmaSy7EAe+MPjIisPt3FhmuEa/ks1Fai52AyG8+MFcLOknTDuG
         I6IUmhpuGX4c47A5vWSllOZaxgr16VjoYY8imLrEAMG/D4LrZ7bwH5vCI6LnRxFMunjU
         UBJ0R7JpAM/2TIj8mrE1lBKt2l2/+cicQAYpsPRcXpWBMI2Bk8+xFrRZ8W+CXgq1/WFK
         mAe3Xh/Pt6v6TnT5O20e43RjJjbIg9pzNDJkvexAnLJdWy8bjQ6S66J4MOg8JDCKSImZ
         SONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=u+HE09jlK9dRcguBV5NcvS8FuA2v2dfzeQXRxjbd1ks=;
        b=W2JFIRxu8Yq+9OdF7BxwIVi55p3sDXWv6SeHJ2FmxTwjV1CvhQQBns56REVfA8lWD1
         Ze8uOtr2VvHW/qqVRdBVeU84DxrG46pNz2MOD3KgNIb3qbcLpzxHtLN1vVcBA5HiMblC
         1cj4+sdWcbjD3XQiDIYS7qPo20tzyp3jMAiX7EKSi9QERxi2VHkbV713ljfuA1jkVsZ0
         1MUpQrpIvPKRY6F1ynozWjHh4XJTLZNxsCT+312MhlD9u/pZXcO+sFUocbMog5Oumndc
         LBQ50fyrtLtu5dzh7cqmvQ2IhHw6pRFLzUkskkmB1gDioamYzdUwBsOylZLLdbzf5sxW
         wyrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:13:45 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-64c80759408f1c47d2414bfa79f80a4573a8d68d@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jpoimboe@redhat.com, peterz@infradead.org,
        arjan@linux.intel.com, dan.j.williams@intel.com, aarcange@redhat.com,
        torvalds@linux-foundation.org, jgross@suse.com, keescook@google.com,
        dave.hansen@linux.intel.com, bp@alien8.de, luto@kernel.org,
        mingo@kernel.org, namit@vmware.com, hughd@google.com,
        gregkh@linuxfoundation.org, dwmw2@infradead.org, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: jgross@suse.com, torvalds@linux-foundation.org,
        dave.hansen@linux.intel.com, bp@alien8.de, luto@kernel.org,
        keescook@google.com, namit@vmware.com, gregkh@linuxfoundation.org,
        hughd@google.com, mingo@kernel.org, hpa@zytor.com, dwmw2@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, arjan@linux.intel.com, dan.j.williams@intel.com,
        aarcange@redhat.com
In-Reply-To: <20180406205509.77E1D7F6@viggo.jf.intel.com>
References: <20180406205509.77E1D7F6@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Do not auto-massage page protections
Git-Commit-ID: 64c80759408f1c47d2414bfa79f80a4573a8d68d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289727143871253?=
X-GMAIL-MSGID: =?utf-8?q?1597289727143871253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  64c80759408f1c47d2414bfa79f80a4573a8d68d
Gitweb:     https://git.kernel.org/tip/64c80759408f1c47d2414bfa79f80a4573a8d68d
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:09 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:33 +0200

x86/mm: Do not auto-massage page protections

A PTE is constructed from a physical address and a pgprotval_t.
__PAGE_KERNEL, for instance, is a pgprot_t and must be converted
into a pgprotval_t before it can be used to create a PTE.  This is
done implicitly within functions like pfn_pte() by massage_pgprot().

However, this makes it very challenging to set bits (and keep them
set) if your bit is being filtered out by massage_pgprot().

This moves the bit filtering out of pfn_pte() and friends.  For
users of PAGE_KERNEL*, filtering will be done automatically inside
those macros but for users of __PAGE_KERNEL*, they need to do their
own filtering now.

Note that we also just move pfn_pte/pmd/pud() over to check_pgprot()
instead of massage_pgprot().  This way, we still *look* for
unsupported bits and properly warn about them if we find them.  This
might happen if an unfiltered __PAGE_KERNEL* value was passed in,
for instance.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180406205509.77E1D7F6@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c |  3 +++
 arch/x86/include/asm/pgtable.h   | 27 ++++++++++++++++++++++-----
 arch/x86/kernel/head64.c         |  2 ++
 arch/x86/kernel/ldt.c            |  6 +++++-
 arch/x86/mm/ident_map.c          |  3 +++
 arch/x86/mm/iomap_32.c           |  6 ++++++
 arch/x86/mm/ioremap.c            |  3 +++
 arch/x86/mm/kasan_init_64.c      | 14 +++++++++++++-
 arch/x86/mm/pgtable.c            |  3 +++
 arch/x86/power/hibernate_64.c    | 20 +++++++++++++++-----
 10 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 66e42a098d70..c5196d2edd52 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -54,6 +54,9 @@ unsigned int ptrs_per_p4d __ro_after_init = 1;
 
 extern unsigned long get_cmd_line_ptr(void);
 
+/* Used by PAGE_KERN* macros: */
+pteval_t __default_kernel_pte_mask __read_mostly;
+
 /* Simplified build-specific string for starting entropy. */
 static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 89d5c8886c85..50b207289ae1 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -526,22 +526,39 @@ static inline pgprotval_t massage_pgprot(pgprot_t pgprot)
 	return protval;
 }
 
+static inline pgprotval_t check_pgprot(pgprot_t pgprot)
+{
+	pgprotval_t massaged_val = massage_pgprot(pgprot);
+
+	/* mmdebug.h can not be included here because of dependencies */
+#ifdef CONFIG_DEBUG_VM
+	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
+		  "attempted to set unsupported pgprot: %016lx "
+		  "bits: %016lx supported: %016lx\n",
+		  pgprot_val(pgprot),
+		  pgprot_val(pgprot) ^ massaged_val,
+		  __supported_pte_mask);
+#endif
+
+	return massaged_val;
+}
+
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
 	return __pte(((phys_addr_t)page_nr << PAGE_SHIFT) |
-		     massage_pgprot(pgprot));
+		     check_pgprot(pgprot));
 }
 
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
 	return __pmd(((phys_addr_t)page_nr << PAGE_SHIFT) |
-		     massage_pgprot(pgprot));
+		     check_pgprot(pgprot));
 }
 
 static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
 {
 	return __pud(((phys_addr_t)page_nr << PAGE_SHIFT) |
-		     massage_pgprot(pgprot));
+		     check_pgprot(pgprot));
 }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
@@ -553,7 +570,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 * the newprot (if present):
 	 */
 	val &= _PAGE_CHG_MASK;
-	val |= massage_pgprot(newprot) & ~_PAGE_CHG_MASK;
+	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
 
 	return __pte(val);
 }
@@ -563,7 +580,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	pmdval_t val = pmd_val(pmd);
 
 	val &= _HPAGE_CHG_MASK;
-	val |= massage_pgprot(newprot) & ~_HPAGE_CHG_MASK;
+	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
 
 	return __pmd(val);
 }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c855deee165..0c408f8c4ed4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -195,6 +195,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pud[i + 1] = (pudval_t)pmd + pgtable_flags;
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
+	/* Filter out unsupported __PAGE_KERNEL_* bits: */
+	pmd_entry &= __supported_pte_mask;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 26d713ecad34..d41d896481b8 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -145,6 +145,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 		unsigned long offset = i << PAGE_SHIFT;
 		const void *src = (char *)ldt->entries + offset;
 		unsigned long pfn;
+		pgprot_t pte_prot;
 		pte_t pte, *ptep;
 
 		va = (unsigned long)ldt_slot_va(slot) + offset;
@@ -163,7 +164,10 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 		 * target via some kernel interface which misses a
 		 * permission check.
 		 */
-		pte = pfn_pte(pfn, __pgprot(__PAGE_KERNEL_RO & ~_PAGE_GLOBAL));
+		pte_prot = __pgprot(__PAGE_KERNEL_RO & ~_PAGE_GLOBAL);
+		/* Filter out unsuppored __PAGE_KERNEL* bits: */
+		pgprot_val(pte_prot) |= __supported_pte_mask;
+		pte = pfn_pte(pfn, pte_prot);
 		set_pte_at(mm, va, ptep, pte);
 		pte_unmap_unlock(ptep, ptl);
 	}
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 9aa22be8331e..a2f0c7e20fb0 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -98,6 +98,9 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 	if (!info->kernpg_flag)
 		info->kernpg_flag = _KERNPG_TABLE;
 
+	/* Filter out unsupported __PAGE_KERNEL_* bits: */
+	info->kernpg_flag &= __default_kernel_pte_mask;
+
 	for (; addr < end; addr = next) {
 		pgd_t *pgd = pgd_page + pgd_index(addr);
 		p4d_t *p4d;
diff --git a/arch/x86/mm/iomap_32.c b/arch/x86/mm/iomap_32.c
index ada98b39b8ad..b3294d36769d 100644
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -44,6 +44,9 @@ int iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot)
 		return ret;
 
 	*prot = __pgprot(__PAGE_KERNEL | cachemode2protval(pcm));
+	/* Filter out unsupported __PAGE_KERNEL* bits: */
+	pgprot_val(*prot) &= __default_kernel_pte_mask;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_create_wc);
@@ -88,6 +91,9 @@ iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
 		prot = __pgprot(__PAGE_KERNEL |
 				cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS));
 
+	/* Filter out unsupported __PAGE_KERNEL* bits: */
+	pgprot_val(prot) &= __default_kernel_pte_mask;
+
 	return (void __force __iomem *) kmap_atomic_prot_pfn(pfn, prot);
 }
 EXPORT_SYMBOL_GPL(iomap_atomic_prot_pfn);
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index e2db83bebc3b..c63a545ec199 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -816,6 +816,9 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
 	}
 	pte = early_ioremap_pte(addr);
 
+	/* Sanitize 'prot' against any unsupported bits: */
+	pgprot_val(flags) &= __default_kernel_pte_mask;
+
 	if (pgprot_val(flags))
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
 	else
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index d8ff013ea9d0..980dbebd0ca7 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -269,6 +269,12 @@ void __init kasan_early_init(void)
 	pudval_t pud_val = __pa_nodebug(kasan_zero_pmd) | _KERNPG_TABLE;
 	p4dval_t p4d_val = __pa_nodebug(kasan_zero_pud) | _KERNPG_TABLE;
 
+	/* Mask out unsupported __PAGE_KERNEL bits: */
+	pte_val &= __default_kernel_pte_mask;
+	pmd_val &= __default_kernel_pte_mask;
+	pud_val &= __default_kernel_pte_mask;
+	p4d_val &= __default_kernel_pte_mask;
+
 	for (i = 0; i < PTRS_PER_PTE; i++)
 		kasan_zero_pte[i] = __pte(pte_val);
 
@@ -371,7 +377,13 @@ void __init kasan_init(void)
 	 */
 	memset(kasan_zero_page, 0, PAGE_SIZE);
 	for (i = 0; i < PTRS_PER_PTE; i++) {
-		pte_t pte = __pte(__pa(kasan_zero_page) | __PAGE_KERNEL_RO | _PAGE_ENC);
+		pte_t pte;
+		pgprot_t prot;
+
+		prot = __pgprot(__PAGE_KERNEL_RO | _PAGE_ENC);
+		pgprot_val(prot) &= __default_kernel_pte_mask;
+
+		pte = __pte(__pa(kasan_zero_page) | pgprot_val(prot));
 		set_pte(&kasan_zero_pte[i], pte);
 	}
 	/* Flush TLBs again to be sure that write protection applied. */
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 34cda7e0551b..d10a40aceeaa 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -583,6 +583,9 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
 void native_set_fixmap(enum fixed_addresses idx, phys_addr_t phys,
 		       pgprot_t flags)
 {
+	/* Sanitize 'prot' against any unsupported bits: */
+	pgprot_val(flags) &= __default_kernel_pte_mask;
+
 	__native_set_fixmap(idx, pfn_pte(phys >> PAGE_SHIFT, flags));
 }
 
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 74a532989308..48b14b534897 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -51,6 +51,12 @@ static int set_up_temporary_text_mapping(pgd_t *pgd)
 	pmd_t *pmd;
 	pud_t *pud;
 	p4d_t *p4d = NULL;
+	pgprot_t pgtable_prot = __pgprot(_KERNPG_TABLE);
+	pgprot_t pmd_text_prot = __pgprot(__PAGE_KERNEL_LARGE_EXEC);
+
+	/* Filter out unsupported __PAGE_KERNEL* bits: */
+	pgprot_val(pmd_text_prot) &= __default_kernel_pte_mask;
+	pgprot_val(pgtable_prot)  &= __default_kernel_pte_mask;
 
 	/*
 	 * The new mapping only has to cover the page containing the image
@@ -81,15 +87,19 @@ static int set_up_temporary_text_mapping(pgd_t *pgd)
 		return -ENOMEM;
 
 	set_pmd(pmd + pmd_index(restore_jump_address),
-		__pmd((jump_address_phys & PMD_MASK) | __PAGE_KERNEL_LARGE_EXEC));
+		__pmd((jump_address_phys & PMD_MASK) | pgprot_val(pmd_text_prot)));
 	set_pud(pud + pud_index(restore_jump_address),
-		__pud(__pa(pmd) | _KERNPG_TABLE));
+		__pud(__pa(pmd) | pgprot_val(pgtable_prot)));
 	if (p4d) {
-		set_p4d(p4d + p4d_index(restore_jump_address), __p4d(__pa(pud) | _KERNPG_TABLE));
-		set_pgd(pgd + pgd_index(restore_jump_address), __pgd(__pa(p4d) | _KERNPG_TABLE));
+		p4d_t new_p4d = __p4d(__pa(pud) | pgprot_val(pgtable_prot));
+		pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
+
+		set_p4d(p4d + p4d_index(restore_jump_address), new_p4d);
+		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
 	} else {
 		/* No p4d for 4-level paging: point the pgd to the pud page table */
-		set_pgd(pgd + pgd_index(restore_jump_address), __pgd(__pa(pud) | _KERNPG_TABLE));
+		pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
+		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
 	}
 
 	return 0;
