Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx4+D0PExlbdos9S2q+/sGpign5OiHQb6Mh88H02tX+kh0Dui+YG2tjvzgxJ+gYN/hGHXZUaa
ARC-Seal: i=1; a=rsa-sha256; t=1523294012; cv=none;
        d=google.com; s=arc-20160816;
        b=w4aGbTy+FkdQcPEvf+g+ox8HlMIhBvJu1o+UkLVaCDBrVzWRjDdsIGHEOzZejAdUKE
         aDj4oXkEehnfHfg5HApyiuIXOy0uJZIB3jb2o9dkL1hREQZ2LapUz6Z1/iMpbGEwWiIG
         FSY+g4EixjuZdSd26Em/uvIu04W8kGX6GDHLPcre9RVvhyY5tWcyo/X1wX4NetFHNt0G
         jwBjTbt/AAaimZWVJKiGZnysQPw7ks4pVfwH1fvpej0IqYE7Kd0tPM2JaIItjjiOrPkB
         FT1m+PnyObXQygrJzkiCycRc7zzK7bt17lUnaVff7q4muleYPhs+f8skvWAJHtt0n4Is
         EjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=Gdj6S57QSrhigA90ZP4HK3pcBz7lSl425tkvXPKG8c4=;
        b=daEYKlUk2sWZaZg1cAyGlHl0kgfzRZdkZ3zYSUu3AKLxqnfWkKTwtH8cxElvMr+3ua
         g70rPDhrLv6ripkabkcepfc7rQhl6aQf6q7N9Xv57AxswPeQtQzqdk7NXpccJXh6xVrM
         ZurGvaPXXoO8buOekP4XjRfrFiVxr/jhsB6PQ+dCnI6jLQIqpDVwPn0tZCDmdVpl85uB
         qqwWpJGm17jTSdccGPdLwnENr1NvoJU2uv9a3nZvofsBMYamXdQ9iZmUtO3/lauuDY6M
         fWlCCuDbKcVixUP/dfwUVKFk7sPyShdqgpTg5jFm0/Wd8AEuj6mGHCLBEEWdcIUQkF90
         F3ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:12:49 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-8a57f4849f4fa22ed18a941164a214083fc020a2@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dan.j.williams@intel.com, luto@kernel.org,
        jgross@suse.com, peterz@infradead.org, hughd@google.com,
        tglx@linutronix.de, keescook@google.com, namit@vmware.com,
        dave.hansen@linux.intel.com, mingo@kernel.org, aarcange@redhat.com,
        bp@alien8.de, torvalds@linux-foundation.org, arjan@linux.intel.com,
        jpoimboe@redhat.com, hpa@zytor.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Reply-To: arjan@linux.intel.com, torvalds@linux-foundation.org, bp@alien8.de,
        gregkh@linuxfoundation.org, jpoimboe@redhat.com, dwmw2@infradead.org,
        hpa@zytor.com, peterz@infradead.org, jgross@suse.com, luto@kernel.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, mingo@kernel.org, dave.hansen@linux.intel.com,
        namit@vmware.com, keescook@google.com, tglx@linutronix.de,
        hughd@google.com
In-Reply-To: <20180406205506.030DB6B6@viggo.jf.intel.com>
References: <20180406205506.030DB6B6@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Introduce "default" kernel PTE mask
Git-Commit-ID: 8a57f4849f4fa22ed18a941164a214083fc020a2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289542852350752?=
X-GMAIL-MSGID: =?utf-8?q?1597289542852350752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  8a57f4849f4fa22ed18a941164a214083fc020a2
Gitweb:     https://git.kernel.org/tip/8a57f4849f4fa22ed18a941164a214083fc020a2
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:06 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:32 +0200

x86/mm: Introduce "default" kernel PTE mask

The __PAGE_KERNEL_* page permissions are "raw".  They contain bits
that may or may not be supported on the current processor.  They need
to be filtered by a mask (currently __supported_pte_mask) to turn them
into a value that we can actually set in a PTE.

These __PAGE_KERNEL_* values all contain _PAGE_GLOBAL.  But, with PTI,
we want to be able to support _PAGE_GLOBAL (have the bit set in
__supported_pte_mask) but not have it appear in any of these masks by
default.

This patch creates a new mask, __default_kernel_pte_mask, and applies
it when creating all of the PAGE_KERNEL_* masks.  This makes
PAGE_KERNEL_* safe to use anywhere (they only contain supported bits).
It also ensures that PAGE_KERNEL_* contains _PAGE_GLOBAL on PTI=n
kernels but clears _PAGE_GLOBAL when PTI=y.

We also make __default_kernel_pte_mask a non-GPL exported symbol
because there are plenty of driver-available interfaces that take
PAGE_KERNEL_* permissions.

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
Link: http://lkml.kernel.org/r/20180406205506.030DB6B6@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable_types.h | 29 ++++++++++++++++-------------
 arch/x86/mm/init.c                   |  6 ++++++
 arch/x86/mm/init_32.c                |  8 +++++++-
 arch/x86/mm/init_64.c                |  5 +++++
 4 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index acfe755562a6..1e5a40673953 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -196,19 +196,21 @@ enum page_cache_mode {
 #define __PAGE_KERNEL_NOENC	(__PAGE_KERNEL)
 #define __PAGE_KERNEL_NOENC_WP	(__PAGE_KERNEL_WP)
 
-#define PAGE_KERNEL		__pgprot(__PAGE_KERNEL | _PAGE_ENC)
-#define PAGE_KERNEL_NOENC	__pgprot(__PAGE_KERNEL)
-#define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO | _PAGE_ENC)
-#define PAGE_KERNEL_EXEC	__pgprot(__PAGE_KERNEL_EXEC | _PAGE_ENC)
-#define PAGE_KERNEL_EXEC_NOENC	__pgprot(__PAGE_KERNEL_EXEC)
-#define PAGE_KERNEL_RX		__pgprot(__PAGE_KERNEL_RX | _PAGE_ENC)
-#define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE | _PAGE_ENC)
-#define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE | _PAGE_ENC)
-#define PAGE_KERNEL_LARGE_EXEC	__pgprot(__PAGE_KERNEL_LARGE_EXEC | _PAGE_ENC)
-#define PAGE_KERNEL_VVAR	__pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
-
-#define PAGE_KERNEL_IO		__pgprot(__PAGE_KERNEL_IO)
-#define PAGE_KERNEL_IO_NOCACHE	__pgprot(__PAGE_KERNEL_IO_NOCACHE)
+#define default_pgprot(x)	__pgprot((x) & __default_kernel_pte_mask)
+
+#define PAGE_KERNEL		default_pgprot(__PAGE_KERNEL | _PAGE_ENC)
+#define PAGE_KERNEL_NOENC	default_pgprot(__PAGE_KERNEL)
+#define PAGE_KERNEL_RO		default_pgprot(__PAGE_KERNEL_RO | _PAGE_ENC)
+#define PAGE_KERNEL_EXEC	default_pgprot(__PAGE_KERNEL_EXEC | _PAGE_ENC)
+#define PAGE_KERNEL_EXEC_NOENC	default_pgprot(__PAGE_KERNEL_EXEC)
+#define PAGE_KERNEL_RX		default_pgprot(__PAGE_KERNEL_RX | _PAGE_ENC)
+#define PAGE_KERNEL_NOCACHE	default_pgprot(__PAGE_KERNEL_NOCACHE | _PAGE_ENC)
+#define PAGE_KERNEL_LARGE	default_pgprot(__PAGE_KERNEL_LARGE | _PAGE_ENC)
+#define PAGE_KERNEL_LARGE_EXEC	default_pgprot(__PAGE_KERNEL_LARGE_EXEC | _PAGE_ENC)
+#define PAGE_KERNEL_VVAR	default_pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
+
+#define PAGE_KERNEL_IO		default_pgprot(__PAGE_KERNEL_IO)
+#define PAGE_KERNEL_IO_NOCACHE	default_pgprot(__PAGE_KERNEL_IO_NOCACHE)
 
 #endif	/* __ASSEMBLY__ */
 
@@ -483,6 +485,7 @@ static inline pgprot_t pgprot_large_2_4k(pgprot_t pgprot)
 typedef struct page *pgtable_t;
 
 extern pteval_t __supported_pte_mask;
+extern pteval_t __default_kernel_pte_mask;
 extern void set_nx(void);
 extern int nx_enabled;
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 82f5252c723a..583a88c8a6ee 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -190,6 +190,12 @@ static void __init probe_page_size_mask(void)
 		enable_global_pages();
 	}
 
+	/* By the default is everything supported: */
+	__default_kernel_pte_mask = __supported_pte_mask;
+	/* Except when with PTI where the kernel is mostly non-Global: */
+	if (cpu_feature_enabled(X86_FEATURE_PTI))
+		__default_kernel_pte_mask &= ~_PAGE_GLOBAL;
+
 	/* Enable 1 GB linear kernel mappings if available: */
 	if (direct_gbpages && boot_cpu_has(X86_FEATURE_GBPAGES)) {
 		printk(KERN_INFO "Using GB pages for direct mapping\n");
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 396e1f0151ac..07cdc2ed4965 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -558,8 +558,14 @@ static void __init pagetable_init(void)
 	permanent_kmaps_init(pgd_base);
 }
 
-pteval_t __supported_pte_mask __read_mostly = ~(_PAGE_NX | _PAGE_GLOBAL);
+#define DEFAULT_PTE_MASK ~(_PAGE_NX | _PAGE_GLOBAL)
+/* Bits supported by the hardware: */
+pteval_t __supported_pte_mask __read_mostly = DEFAULT_PTE_MASK;
+/* Bits allowed in normal kernel mappings: */
+pteval_t __default_kernel_pte_mask __read_mostly = DEFAULT_PTE_MASK;
 EXPORT_SYMBOL_GPL(__supported_pte_mask);
+/* Used in PAGE_KERNEL_* macros which are reasonably used out-of-tree: */
+EXPORT_SYMBOL(__default_kernel_pte_mask);
 
 /* user-defined highmem size */
 static unsigned int highmem_pages = -1;
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 45241de66785..e6c52dbbf649 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -65,8 +65,13 @@
  * around without checking the pgd every time.
  */
 
+/* Bits supported by the hardware: */
 pteval_t __supported_pte_mask __read_mostly = ~0;
+/* Bits allowed in normal kernel mappings: */
+pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 EXPORT_SYMBOL_GPL(__supported_pte_mask);
+/* Used in PAGE_KERNEL_* macros which are reasonably used out-of-tree: */
+EXPORT_SYMBOL(__default_kernel_pte_mask);
 
 int force_personality32;
 
