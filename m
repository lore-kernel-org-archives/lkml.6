Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx49WU1vgtb/e84l1P+Guk/tQntAV9kvuY7k31v5vbUYe8T4Ims/Jfxu1inGrx74vOFwYQ8SM
ARC-Seal: i=1; a=rsa-sha256; t=1523293983; cv=none;
        d=google.com; s=arc-20160816;
        b=TVQmo5gF2X72hIzGoU8xhIri+dyfCGWt6WeDg2nNxy2wlcmTCDmJU0vDWJUke5mhQB
         KHe5GCdgXZGqsbODWi1XEvmrAupPGflWzjlKIj35lgpSbFXIPIkQcaUjL4UK1EO6MG37
         LATQH3CaQin/wdZ407z1IF14etABEADPjsPfj9agLM9s9kFObn73J5VFW3K9m8H5I/vm
         L8gFxjHuGF4ynRwe1Wq15Yjbg7/GGc0CRi9P7lIBCXLNQgJmWrTDsNMNPDYHVbT0aM1+
         0ed1UjV7J61grlVm8WTEeIRy3RHVL6k/DTLRtHEQFbsVIKx3gtpxsLmWmtagFCCDpnme
         BWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=LYWlzjP8+MoGTwD/gtg1oA9IDM0A57UrFdrLnrdVDsY=;
        b=CkmlIday9zpYIP87MUxkQUXOjKA2mrhvlnT5/YbGipD9zj97w8v2IF2qmh9l6axhqV
         uOZq0pxpgUrWneS1+7kONxTZxxIqj85bTi3WIV85xOF27wGXbuhZ+qMDtf5j/Dz85yQV
         cED8sEK0MwyuarXOSKGIJuPnG8SDYTDEKweoU2ffjpd51F8atENGpbL9upSLy4UETcQl
         kCabqLuYABVhPJ7U679uSQC+4sOeT04SXJtwKn59QCM2GopJl0aUC/aKY2s/eXh56kiN
         82HK87IQbq7mqG8ARD/1T55gzmYi1RQwSGztPFfWC38VdC2D7N6UXcnmTgcyCx/c1bll
         DVJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:12:21 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-606c7193d5fbf8ea3dafc8a9468f719fbf1d7160@git.kernel.org>
Cc: jgross@suse.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        namit@vmware.com, hughd@google.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, keescook@google.com, dan.j.williams@intel.com,
        arjan@linux.intel.com, jpoimboe@redhat.com, bp@alien8.de,
        mingo@kernel.org, aarcange@redhat.com, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org, luto@kernel.org,
        hpa@zytor.com
Reply-To: hughd@google.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, peterz@infradead.org, jgross@suse.com,
        namit@vmware.com, luto@kernel.org, dwmw2@infradead.org, hpa@zytor.com,
        arjan@linux.intel.com, keescook@google.com, dan.j.williams@intel.com,
        jpoimboe@redhat.com, bp@alien8.de, mingo@kernel.org,
        aarcange@redhat.com, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180406205504.9B0F44A9@viggo.jf.intel.com>
References: <20180406205504.9B0F44A9@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Undo double _PAGE_PSE clearing
Git-Commit-ID: 606c7193d5fbf8ea3dafc8a9468f719fbf1d7160
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289512511909608?=
X-GMAIL-MSGID: =?utf-8?q?1597289512511909608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  606c7193d5fbf8ea3dafc8a9468f719fbf1d7160
Gitweb:     https://git.kernel.org/tip/606c7193d5fbf8ea3dafc8a9468f719fbf1d7160
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:04 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:32 +0200

x86/mm: Undo double _PAGE_PSE clearing

When clearing _PAGE_PRESENT on a huge page, we need to be careful
to also clear _PAGE_PSE, otherwise it might still get confused
for a valid large page table entry.

We do that near the spot where we *set* _PAGE_PSE.  That's fine,
but it's unnecessary.  pgprot_large_2_4k() already did it.

BTW, I also noticed that pgprot_large_2_4k() and
pgprot_4k_2_large() are not symmetric.  pgprot_large_2_4k() clears
_PAGE_PSE (because it is aliased to _PAGE_PAT) but
pgprot_4k_2_large() does not put _PAGE_PSE back.  Bummer.

Also, add some comments and change "promote" to "move".  "Promote"
seems an odd word to move when we are logically moving a bit to a
lower bit position.  Also add an extra line return to make it clear
to which line the comment applies.

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
Link: http://lkml.kernel.org/r/20180406205504.9B0F44A9@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 4d369d5c04c5..d3442dfdfced 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -583,6 +583,7 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	 * up accordingly.
 	 */
 	old_pte = *kpte;
+	/* Clear PSE (aka _PAGE_PAT) and move PAT bit to correct position */
 	req_prot = pgprot_large_2_4k(old_prot);
 
 	pgprot_val(req_prot) &= ~pgprot_val(cpa->mask_clr);
@@ -597,8 +598,6 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	req_prot = pgprot_clear_protnone_bits(req_prot);
 	if (pgprot_val(req_prot) & _PAGE_PRESENT)
 		pgprot_val(req_prot) |= _PAGE_PSE;
-	else
-		pgprot_val(req_prot) &= ~_PAGE_PSE;
 	req_prot = canon_pgprot(req_prot);
 
 	/*
@@ -684,8 +683,12 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	switch (level) {
 	case PG_LEVEL_2M:
 		ref_prot = pmd_pgprot(*(pmd_t *)kpte);
-		/* clear PSE and promote PAT bit to correct position */
+		/*
+		 * Clear PSE (aka _PAGE_PAT) and move
+		 * PAT bit to correct position.
+		 */
 		ref_prot = pgprot_large_2_4k(ref_prot);
+
 		ref_pfn = pmd_pfn(*(pmd_t *)kpte);
 		break;
 
