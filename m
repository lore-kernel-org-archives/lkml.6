Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx495+wcXOQ67CsMvQuDDIcL6Gl8N/psiZ19ntB6zO6DMTtnvcw3lXVFBRblVcCFOZjwkZrab
ARC-Seal: i=1; a=rsa-sha256; t=1523517308; cv=none;
        d=google.com; s=arc-20160816;
        b=GjL3yc/gM0fStpcK0DzJEH68qQ4GVyud2/wcqGRhrAiteLigN05y3ycj7q55ukRshj
         H/I3zNDKvQ/XOp+rEIFtKattU/lJ5nNbDHZ3hyEjV5ur4SEeWFmE6HwSwvBH4iEQk8kc
         nxiEXWk1UzMQ8TRFI7zSeyGxa2OXrHOW3kpjr1ck+70EmOibGUfNZ+7+OUmSsJrYZt6X
         KUA1WemB3I3H8DgIJ4VCpomJ4bBPmIIXWDPRZVGid3nfMOchRvcOG6DJRHTY+9TyV+IX
         kvvYSUgqG7O5aHV65yLrDYitfcd29D2Uy0XGYgBNk5DdRqMj1HGbZgL1WjVpK7eRbO1N
         Z+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=rVjUifQl0FFbr6o9TJXyylU54fYojEEmMOjQSZ6s8Dc=;
        b=M1uFKBUiiaqaTgb/Y4J43HV9kTaPRdF8uluEslQrlQqVwLtuLvRBnbo+zEyb383eKJ
         nm6M5qyLX//+aSplgOxCTGjeTu9T+CDyCpY1IqOfQacss4L6KlkWq2bzTbsBiYJIO1Ij
         M7vWk+7hcJbV0wjpdmNXmnj1SlnObjwVrYDtGMwCQdwwzRzBi/fXEzOt6WaK4WXMQE7o
         uBbIcmGwWRoC7RZQEZQBIYG1rSkE7WxZfT22tM6yxTSK32MfgSDeqSydTnvsjdO0Z11z
         hNjLV6WcL8+n+nZ5aAOCLs0Jaffua4kmdcFDUpghUOiSWy+QByz5dQBMyes0K1CQQE4C
         PMdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Thu, 12 Apr 2018 00:14:20 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-1a54420aeb4da1ba5b28283aa5696898220c9a27@git.kernel.org>
Cc: dan.j.williams@intel.com, jpoimboe@redhat.com, tglx@linutronix.de,
        dwmw2@infradead.org, luto@kernel.org, namit@vmware.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        hughd@google.com, keescook@google.com, jgross@suse.com, bp@alien8.de,
        mingo@kernel.org, hpa@zytor.com, arjan@linux.intel.com,
        aarcange@redhat.com, dave.hansen@linux.intel.com
Reply-To: keescook@google.com, hughd@google.com, mingo@kernel.org,
        bp@alien8.de, jgross@suse.com, arjan@linux.intel.com, hpa@zytor.com,
        aarcange@redhat.com, dave.hansen@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com, jpoimboe@redhat.com, luto@kernel.org,
        dwmw2@infradead.org, torvalds@linux-foundation.org, namit@vmware.com,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180406205511.BC072352@viggo.jf.intel.com>
References: <20180406205511.BC072352@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Remove extra filtering in pageattr code
Git-Commit-ID: 1a54420aeb4da1ba5b28283aa5696898220c9a27
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
X-GMAIL-MSGID: =?utf-8?q?1597523685694004764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  1a54420aeb4da1ba5b28283aa5696898220c9a27
Gitweb:     https://git.kernel.org/tip/1a54420aeb4da1ba5b28283aa5696898220c9a27
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:11 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 12 Apr 2018 09:05:58 +0200

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
