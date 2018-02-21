Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1568560-1519219107-2-975527354840591935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219106; b=M6x55P5G66vQEPVs9yTPfbqKM63dXQ0BoHXlmQ6uXElAcfH
    EeEHN7iN6sd2xuUJ6eh5/zZpQLGruFMuwiUYVmQfqAkd926XpyJ1zJxuvRspjQhd
    kbPaDwoF6RVuUmuVRPRl43cWsXSpLjkRjZ4s97a9zwmDP7Kvbx3EIkJBNZTbVHr7
    I0jmhnVNb2PeX8GD7KUAImaZT7dHYnyFeUvJr9MBP5jgrQtb7/n9wFHLI6Syi+n2
    zNryZTbFNscxLNqAvRaMHm+eczcicjOWYfFcqAzO2Eug8/qsHW+UZTQwoi2/FGzO
    mPn/K60OHI4XUt2MZ5XQ0gU2lH0qsjHZ6/7kEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219106; bh=OBSNAoHanBdLgadYemKDn8AezQ
    8utluBah9UQnehIgM=; b=eBcmImjAvxuuEBPDlEO5CsVgHBqllJLglIfBMJBmNf
    0ZgyKPPHcALrkIgz//GF9wXFoV4FQabl31t2G55CnS9WXxHiHqZTwUILBhIfDUeG
    DMqJ2znu2w800jeUHbxzRrK+/NuDTHwysoz37uj7zsBqCNB+stoj/ef/PMqG1ZSv
    EzQr6t8XGu5W+m7aGUeHmEx94xzwWua1a3FbvJIs4UOXtTrLSI/wGwEMnTUizdhZ
    fv4wOf3s1aK1EdoTlpeNlvyngkIgn5n/FLyLo+sOMucGKUkXzjRDHNvoPijf7wZN
    iyMERgseHsQTmzqa8FhuzysHrYxfrAyrtDC5l6R+Q2FA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965629AbeBUNMm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:12:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965623AbeBUNMh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>,
        Dave <dave.hansen@intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Robert (Persistent Memory)" <elliott@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 153/163] x86/mm, mm/hwpoison: Dont unconditionally unmap kernel 1:1 pages
Date: Wed, 21 Feb 2018 13:49:42 +0100
Message-Id: <20180221124538.447153011@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit fd0e786d9d09024f67bd71ec094b110237dc3840 upstream.

In the following commit:

  ce0fa3e56ad2 ("x86/mm, mm/hwpoison: Clear PRESENT bit for kernel 1:1 mappings of poison pages")

... we added code to memory_failure() to unmap the page from the
kernel 1:1 virtual address space to avoid speculative access to the
page logging additional errors.

But memory_failure() may not always succeed in taking the page offline,
especially if the page belongs to the kernel.  This can happen if
there are too many corrected errors on a page and either mcelog(8)
or drivers/ras/cec.c asks to take a page offline.

Since we remove the 1:1 mapping early in memory_failure(), we can
end up with the page unmapped, but still in use. On the next access
the kernel crashes :-(

There are also various debug paths that call memory_failure() to simulate
occurrence of an error. Since there is no actual error in memory, we
don't need to map out the page for those cases.

Revert most of the previous attempt and keep the solution local to
arch/x86/kernel/cpu/mcheck/mce.c. Unmap the page only when:

	1) there is a real error
	2) memory_failure() succeeds.

All of this only applies to 64-bit systems. 32-bit kernel doesn't map
all of memory into kernel space. It isn't worth adding the code to unmap
the piece that is mapped because nobody would run a 32-bit kernel on a
machine that has recoverable machine checks.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave <dave.hansen@intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert (Persistent Memory) <elliott@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org #v4.14
Fixes: ce0fa3e56ad2 ("x86/mm, mm/hwpoison: Clear PRESENT bit for kernel 1:1 mappings of poison pages")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/page_64.h            |    4 ----
 arch/x86/kernel/cpu/mcheck/mce-internal.h |   15 +++++++++++++++
 arch/x86/kernel/cpu/mcheck/mce.c          |   17 +++++++++++------
 include/linux/mm_inline.h                 |    6 ------
 mm/memory-failure.c                       |    2 --
 5 files changed, 26 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -52,10 +52,6 @@ static inline void clear_page(void *page
 
 void copy_page(void *to, void *from);
 
-#ifdef CONFIG_X86_MCE
-#define arch_unmap_kpfn arch_unmap_kpfn
-#endif
-
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
--- a/arch/x86/kernel/cpu/mcheck/mce-internal.h
+++ b/arch/x86/kernel/cpu/mcheck/mce-internal.h
@@ -115,4 +115,19 @@ static inline void mce_unregister_inject
 
 extern struct mca_config mca_cfg;
 
+#ifndef CONFIG_X86_64
+/*
+ * On 32-bit systems it would be difficult to safely unmap a poison page
+ * from the kernel 1:1 map because there are no non-canonical addresses that
+ * we can use to refer to the address without risking a speculative access.
+ * However, this isn't much of an issue because:
+ * 1) Few unmappable pages are in the 1:1 map. Most are in HIGHMEM which
+ *    are only mapped into the kernel as needed
+ * 2) Few people would run a 32-bit kernel on a machine that supports
+ *    recoverable errors because they have too much memory to boot 32-bit.
+ */
+static inline void mce_unmap_kpfn(unsigned long pfn) {}
+#define mce_unmap_kpfn mce_unmap_kpfn
+#endif
+
 #endif /* __X86_MCE_INTERNAL_H__ */
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -106,6 +106,10 @@ static struct irq_work mce_irq_work;
 
 static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
 
+#ifndef mce_unmap_kpfn
+static void mce_unmap_kpfn(unsigned long pfn);
+#endif
+
 /*
  * CPU/chipset specific EDAC code can register a notifier call here to print
  * MCE errors in a human-readable form.
@@ -582,7 +586,8 @@ static int srao_decode_notifier(struct n
 
 	if (mce_usable_address(mce) && (mce->severity == MCE_AO_SEVERITY)) {
 		pfn = mce->addr >> PAGE_SHIFT;
-		memory_failure(pfn, MCE_VECTOR, 0);
+		if (memory_failure(pfn, MCE_VECTOR, 0))
+			mce_unmap_kpfn(pfn);
 	}
 
 	return NOTIFY_OK;
@@ -1049,12 +1054,13 @@ static int do_memory_failure(struct mce
 	ret = memory_failure(m->addr >> PAGE_SHIFT, MCE_VECTOR, flags);
 	if (ret)
 		pr_err("Memory error not recovered");
+	else
+		mce_unmap_kpfn(m->addr >> PAGE_SHIFT);
 	return ret;
 }
 
-#if defined(arch_unmap_kpfn) && defined(CONFIG_MEMORY_FAILURE)
-
-void arch_unmap_kpfn(unsigned long pfn)
+#ifndef mce_unmap_kpfn
+static void mce_unmap_kpfn(unsigned long pfn)
 {
 	unsigned long decoy_addr;
 
@@ -1065,7 +1071,7 @@ void arch_unmap_kpfn(unsigned long pfn)
 	 * We would like to just call:
 	 *	set_memory_np((unsigned long)pfn_to_kaddr(pfn), 1);
 	 * but doing that would radically increase the odds of a
-	 * speculative access to the posion page because we'd have
+	 * speculative access to the poison page because we'd have
 	 * the virtual address of the kernel 1:1 mapping sitting
 	 * around in registers.
 	 * Instead we get tricky.  We create a non-canonical address
@@ -1090,7 +1096,6 @@ void arch_unmap_kpfn(unsigned long pfn)
 
 	if (set_memory_np(decoy_addr, 1))
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
-
 }
 #endif
 
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -127,10 +127,4 @@ static __always_inline enum lru_list pag
 
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
 
-#ifdef arch_unmap_kpfn
-extern void arch_unmap_kpfn(unsigned long pfn);
-#else
-static __always_inline void arch_unmap_kpfn(unsigned long pfn) { }
-#endif
-
 #endif
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1146,8 +1146,6 @@ int memory_failure(unsigned long pfn, in
 		return 0;
 	}
 
-	arch_unmap_kpfn(pfn);
-
 	orig_head = hpage = compound_head(p);
 	num_poisoned_pages_inc();
 
