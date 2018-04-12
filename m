Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx49MEw7XxbL3Dky8qHfl8z68VIw06dTr3VcxwSLQqy+iOyo+5lJz2S4Kfcnke/sjVPjOx6ik
ARC-Seal: i=1; a=rsa-sha256; t=1523517503; cv=none;
        d=google.com; s=arc-20160816;
        b=iPlUad55lOtOPe9WLqlzbiTsNscKF8Q8FZG93vxOnpNfYl0dPWMx5130KQ1AAi4tcO
         XfGTXWs26kj7CIxO7AZ/oKJfPpgF3vz2T2zURmiQCZKVtBYe//ChMNrxUo/lYaNUwbk6
         O/Xo1S2RgjhaAd36LPR0Q1pDa/dqKqRqWfLOGfXrLa/5eWliy+Ds/3i4yrNqt4z8g9V+
         tAMhPYu/EkRSAnrmKt61Ejf2oJqp253f5J37rgWahfPCssdsm0X8OwfZ3uP8xNhlTkm0
         YCcSzH0Xh9Blmt/Rb1tlcy5IuiLEKQs3Qq1Hyi3dJGgzi+PMrlM93QF1bHORqozTXmUD
         1o+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=7RKXtY1TEHoK6OQREzXKgzM3F54Y4MY0UzN17SrMThg=;
        b=ohUzwi9gi9DveaGH6Agb5RKqt1gaNToJVUDkxmyWL4IEbunG4cwGyjV1aEr3BByFFN
         tDwAYoP/FHzNaSxpCAIDOP/EhxUILU7PSlEhGh97UWGa292aAkLR919tcxWUV2S5Hmnr
         PnSthq+4dgKegtakrud4IreqKNOH2hbMzWNBjp8BM0hUgsPPhxFbxCt81SZNYYl7x4xV
         ur6ghW//BlGMO9bYumuSOAsmwvgiimbmzUJ9QaAAJEN99w5BokMQ0NtF91JFnz3ZWfwn
         zlGk7gh2nu+gYkL6miBqO4WtrRa5JcKQRmorC2ONX3noY64IuChrBh2SzVRPtCZaJOy+
         JcNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Thu, 12 Apr 2018 00:16:30 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-39114b7a743e6759bab4d96b7d9651d44d17e3f9@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
        hughd@google.com, tglx@linutronix.de, keescook@google.com,
        jgross@suse.com, luto@kernel.org, jpoimboe@redhat.com, bp@alien8.de,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, aarcange@redhat.com, arjan@linux.intel.com,
        dave.hansen@linux.intel.com, namit@vmware.com, peterz@infradead.org,
        dwmw2@infradead.org
Reply-To: jpoimboe@redhat.com, luto@kernel.org, jgross@suse.com,
        torvalds@linux-foundation.org, hughd@google.com, hpa@zytor.com,
        mingo@kernel.org, keescook@google.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, dwmw2@infradead.org, peterz@infradead.org,
        namit@vmware.com, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org, bp@alien8.de,
        arjan@linux.intel.com, aarcange@redhat.com
In-Reply-To: <20180406205517.C80FBE05@viggo.jf.intel.com>
References: <20180406205517.C80FBE05@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Never implicitly clear _PAGE_GLOBAL for
 kernel image
Git-Commit-ID: 39114b7a743e6759bab4d96b7d9651d44d17e3f9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289749177813039?=
X-GMAIL-MSGID: =?utf-8?q?1597523889282252737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  39114b7a743e6759bab4d96b7d9651d44d17e3f9
Gitweb:     https://git.kernel.org/tip/39114b7a743e6759bab4d96b7d9651d44d17e3f9
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:17 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 12 Apr 2018 09:06:00 +0200

x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image

Summary:

In current kernels, with PTI enabled, no pages are marked Global. This
potentially increases TLB misses.  But, the mechanism by which the Global
bit is set and cleared is rather haphazard.  This patch makes the process
more explicit.  In the end, it leaves us with Global entries in the page
tables for the areas truly shared by userspace and kernel and increases
TLB hit rates.

The place this patch really shines in on systems without PCIDs.  In this
case, we are using an lseek microbenchmark[1] to see how a reasonably
non-trivial syscall behaves.  Higher is better:

  No Global pages (baseline): 6077741 lseeks/sec
  88 Global Pages (this set): 7528609 lseeks/sec (+23.9%)

On a modern Skylake desktop with PCIDs, the benefits are tangible, but not
huge for a kernel compile (lower is better):

  No Global pages (baseline): 186.951 seconds time elapsed  ( +-  0.35% )
  28 Global pages (this set): 185.756 seconds time elapsed  ( +-  0.09% )
                               -1.195 seconds (-0.64%)

I also re-checked everything using the lseek1 test[1]:

  No Global pages (baseline): 15783951 lseeks/sec
  28 Global pages (this set): 16054688 lseeks/sec
			     +270737 lseeks/sec (+1.71%)

The effect is more visible, but still modest.

Details:

The kernel page tables are inherited from head_64.S which rudely marks
them as _PAGE_GLOBAL.  For PTI, we have been relying on the grace of
$DEITY and some insane behavior in pageattr.c to clear _PAGE_GLOBAL.
This patch tries to do better.

First, stop filtering out "unsupported" bits from being cleared in the
pageattr code.  It's fine to filter out *setting* these bits but it
is insane to keep us from clearing them.

Then, *explicitly* go clear _PAGE_GLOBAL from the kernel identity map.
Do not rely on pageattr to do it magically.

After this patch, we can see that "GLB" shows up in each copy of the
page tables, that we have the same number of global entries in each
and that they are the *same* entries.

  /sys/kernel/debug/page_tables/current_kernel:11
  /sys/kernel/debug/page_tables/current_user:11
  /sys/kernel/debug/page_tables/kernel:11

  9caae8ad6a1fb53aca2407ec037f612d  current_kernel.GLB
  9caae8ad6a1fb53aca2407ec037f612d  current_user.GLB
  9caae8ad6a1fb53aca2407ec037f612d  kernel.GLB

A quick visual audit also shows that all the entries make sense.
0xfffffe0000000000 is the cpu_entry_area and 0xffffffff81c00000
is the entry/exit text:

  0xfffffe0000000000-0xfffffe0000002000           8K     ro                 GLB NX pte
  0xfffffe0000002000-0xfffffe0000003000           4K     RW                 GLB NX pte
  0xfffffe0000003000-0xfffffe0000006000          12K     ro                 GLB NX pte
  0xfffffe0000006000-0xfffffe0000007000           4K     ro                 GLB x  pte
  0xfffffe0000007000-0xfffffe000000d000          24K     RW                 GLB NX pte
  0xfffffe000002d000-0xfffffe000002e000           4K     ro                 GLB NX pte
  0xfffffe000002e000-0xfffffe000002f000           4K     RW                 GLB NX pte
  0xfffffe000002f000-0xfffffe0000032000          12K     ro                 GLB NX pte
  0xfffffe0000032000-0xfffffe0000033000           4K     ro                 GLB x  pte
  0xfffffe0000033000-0xfffffe0000039000          24K     RW                 GLB NX pte
  0xffffffff81c00000-0xffffffff81e00000           2M     ro         PSE     GLB x  pmd

[1.] https://github.com/antonblanchard/will-it-scale/blob/master/tests/lseek1.c

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
Link: http://lkml.kernel.org/r/20180406205517.C80FBE05@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/init.c     |  8 +-------
 arch/x86/mm/pageattr.c | 12 +++++++++---
 arch/x86/mm/pti.c      | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 583a88c8a6ee..fec82b577c18 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -161,12 +161,6 @@ struct map_range {
 
 static int page_size_mask;
 
-static void enable_global_pages(void)
-{
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		__supported_pte_mask |= _PAGE_GLOBAL;
-}
-
 static void __init probe_page_size_mask(void)
 {
 	/*
@@ -187,7 +181,7 @@ static void __init probe_page_size_mask(void)
 	__supported_pte_mask &= ~_PAGE_GLOBAL;
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		cr4_set_bits_and_update_boot(X86_CR4_PGE);
-		enable_global_pages();
+		__supported_pte_mask |= _PAGE_GLOBAL;
 	}
 
 	/* By the default is everything supported: */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index a7324045d87d..0f3d50f4c48c 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1411,11 +1411,11 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	memset(&cpa, 0, sizeof(cpa));
 
 	/*
-	 * Check, if we are requested to change a not supported
-	 * feature:
+	 * Check, if we are requested to set a not supported
+	 * feature.  Clearing non-supported features is OK.
 	 */
 	mask_set = canon_pgprot(mask_set);
-	mask_clr = canon_pgprot(mask_clr);
+
 	if (!pgprot_val(mask_set) && !pgprot_val(mask_clr) && !force_split)
 		return 0;
 
@@ -1758,6 +1758,12 @@ int set_memory_4k(unsigned long addr, int numpages)
 					__pgprot(0), 1, 0, NULL);
 }
 
+int set_memory_nonglobal(unsigned long addr, int numpages)
+{
+	return change_page_attr_clear(&addr, numpages,
+				      __pgprot(_PAGE_GLOBAL), 0);
+}
+
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
 	struct cpa_data cpa;
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 8082f8b0c10e..1470b173963f 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -372,6 +372,27 @@ static void __init pti_clone_entry_text(void)
 		       _PAGE_RW);
 }
 
+/*
+ * This is the only user for it and it is not arch-generic like
+ * the other set_memory.h functions.  Just extern it.
+ */
+extern int set_memory_nonglobal(unsigned long addr, int numpages);
+void pti_set_kernel_image_nonglobal(void)
+{
+	/*
+	 * The identity map is created with PMDs, regardless of the
+	 * actual length of the kernel.  We need to clear
+	 * _PAGE_GLOBAL up to a PMD boundary, not just to the end
+	 * of the image.
+	 */
+	unsigned long start = PFN_ALIGN(_text);
+	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+
+	pr_debug("set kernel image non-global\n");
+
+	set_memory_nonglobal(start, (end - start) >> PAGE_SHIFT);
+}
+
 /*
  * Initialize kernel page table isolation
  */
@@ -383,6 +404,10 @@ void __init pti_init(void)
 	pr_info("enabled\n");
 
 	pti_clone_user_shared();
+
+	/* Undo all global bits from the init pagetables in head_64.S: */
+	pti_set_kernel_image_nonglobal();
+	/* Replace some of the global bits just for shared entry text: */
 	pti_clone_entry_text();
 	pti_setup_espfix64();
 	pti_setup_vsyscall();
