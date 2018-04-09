Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx4+2QoPFZBzlAItbz1AAjPIKam58lgh4Nma11RKdTujaQVOpwv1xOKlEGVw7c6UE1PieJSJh
ARC-Seal: i=1; a=rsa-sha256; t=1523294095; cv=none;
        d=google.com; s=arc-20160816;
        b=mgbTEv4tUQIQXkCQexszUdfzm62S5y7bgd1yjVvdRLOjkUR3NYxVhK1CZ9UDSlPog6
         RpkR6bF/w49XsH0MhTexcN1n6V3mw2WtLNRxgfEaBHcqHOFin8oFauDFs1tkUPAK+9kq
         BWhB7x3zJhqXiy8cOvpDqmLiiThSxXW8njNQXrM0/6JEGqOPZYwXmKfY/hqeaEfvLVgF
         lhI3sQfgU6Sga1izOgEsSQvoXnizf4M/8nSmciTTTPKRHj0gqJTQ1JDA9zn0op421IUP
         9wOmafaJrxEbQPDHgNYoCQwKtlTJho7Siu05rGDAjzi9BAwAHr06zhvWRgZUHziRaKOT
         Pz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=79OdL8ByQVnc8Vqglpd73cx2itHLr9x0E3tQXBZXogI=;
        b=vDzIfTrgnHOL6ssXQQwxu8nT6/aiX+94Dv8m4sQ30fwURV2cZsgJGL8R5U5sBaQ+YN
         FeBrZwaT98q5OsKygWBk1J4Tr87FFgbvJDMUDxifQRKSoxIUj0UaPMpIkwFKuN03953P
         1sre39/QMx2KApwxDxQtz3838d71ZQgVgngk+PQEJbC2azRdgpbbqWSnqEZxiYOSUjcy
         r8cP7wvCbd1CTtP9uNziqpxIodcvs+6pXEU9OaB2ns+a+0JFhYf8v0mbpEiBFUsU1ZRz
         F22wI/mhBxnwLV8kJ0D0XhTu1fj+KiObsBPSc2PMfAqD2mYIe0j30KnJ145NOh+F8QTD
         VUqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:14:13 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-e71e836f463dd2cfb319ce88ae4a6e4f83904e6c@git.kernel.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, keescook@google.com,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        dwmw2@infradead.org, aarcange@redhat.com, namit@vmware.com,
        luto@kernel.org, jgross@suse.com, hughd@google.com, hpa@zytor.com,
        arjan@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Reply-To: jgross@suse.com, aarcange@redhat.com, namit@vmware.com,
        luto@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, hughd@google.com, hpa@zytor.com,
        arjan@linux.intel.com, dave.hansen@linux.intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org, keescook@google.com,
        peterz@infradead.org, dwmw2@infradead.org, dan.j.williams@intel.com,
        tglx@linutronix.de, bp@alien8.de
In-Reply-To: <20180406205511.BC072352@viggo.jf.intel.com>
References: <20180406205511.BC072352@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Remove extra filtering in pageattr code
Git-Commit-ID: e71e836f463dd2cfb319ce88ae4a6e4f83904e6c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289629374494511?=
X-GMAIL-MSGID: =?utf-8?q?1597289629374494511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  e71e836f463dd2cfb319ce88ae4a6e4f83904e6c
Gitweb:     https://git.kernel.org/tip/e71e836f463dd2cfb319ce88ae4a6e4f83904e6c
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:11 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:33 +0200

x86/mm: Remove extra filtering in pageattr code

The pageattr code has a mode where it can set or clear PTE bits in
existing PTEs, so the page protections of the *new* PTEs come from
one of two places:

  1. The set/clear masks: cpa->mask_clr / cpa->mask_set
  2. The existing PTE

We filter ->mask_set/clr for supported PTE bits at entry to
__change_page_attr() so we never need to filter them again.

The only other place permissions can come from is an existing PTE
and those already presumably have good bits.  We do not need to filter
them again.

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
Link: http://lkml.kernel.org/r/20180406205511.BC072352@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index d3442dfdfced..968f51a2e39b 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -598,7 +598,6 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	req_prot = pgprot_clear_protnone_bits(req_prot);
 	if (pgprot_val(req_prot) & _PAGE_PRESENT)
 		pgprot_val(req_prot) |= _PAGE_PSE;
-	req_prot = canon_pgprot(req_prot);
 
 	/*
 	 * old_pfn points to the large page base pfn. So we need
@@ -718,7 +717,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 */
 	pfn = ref_pfn;
 	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc)
-		set_pte(&pbase[i], pfn_pte(pfn, canon_pgprot(ref_prot)));
+		set_pte(&pbase[i], pfn_pte(pfn, ref_prot));
 
 	if (virt_addr_valid(address)) {
 		unsigned long pfn = PFN_DOWN(__pa(address));
@@ -935,7 +934,6 @@ static void populate_pte(struct cpa_data *cpa,
 	pte = pte_offset_kernel(pmd, start);
 
 	pgprot = pgprot_clear_protnone_bits(pgprot);
-	pgprot = canon_pgprot(pgprot);
 
 	while (num_pages-- && start < end) {
 		set_pte(pte, pfn_pte(cpa->pfn, pgprot));
@@ -1234,7 +1232,7 @@ repeat:
 		 * after all we're only going to change it's attributes
 		 * not the memory it points to
 		 */
-		new_pte = pfn_pte(pfn, canon_pgprot(new_prot));
+		new_pte = pfn_pte(pfn, new_prot);
 		cpa->pfn = pfn;
 		/*
 		 * Do we really change anything ?
