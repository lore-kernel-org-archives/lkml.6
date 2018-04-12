Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx48jTNPQlSBwnrJfoztud4Jy5BLK8gR44PWegLDhUccWWCNtBChzjpdXwWbSJIwVrJfaR45E
ARC-Seal: i=1; a=rsa-sha256; t=1523517431; cv=none;
        d=google.com; s=arc-20160816;
        b=RF+C7Cprz1nruokOQ3MBynWi3wjZJGlNdkMfYvsCd0TwJkaY6RLfpW1MswMAPWrY5Z
         DMM2quOx3E8Dy9RfUEeuJ6ZFYiszADeyAAIgbkPYnPcM+AnGUtFmOPHCUTNQ4VeVjtiO
         KXV0dYXVgfkxQGaPa2kP7d7tbcrheahoKv1XQSg9vf4RPXDo2EZE/1zAeJlJ/b+IwpGg
         Xl7P/Kbwc4IjxJpcLutcYfhd0wbSmrKoMoxRSmJIxfZcG09yzDM/IJKHV0QNi8KfVrFu
         R7cdNEu35HMQ+7YNIvc488hgswi1AIwqKxy0u8wQ72D9At29AFsDbfAoWqJwJ2Tk55oC
         tLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=MqzO/LKBwJAvXLgn1p+H6mkHATXQoDX5aKHLwDgmSmg=;
        b=VOA5utfb8YWqfo+5bgfBZ3CoQnC0IbHTSbrLlRd0qi2Y94LmfRobV+k01Ic6EF9WDG
         Jyb0ezCVW50BvT4GbNoTj7m0/Y25F4miFWCSrol12jRBUxQcRINjmpq0/xK3YbkyCEMr
         grfV2Zg6a5fTsuWKJaKU+zXEZKozsTh7bsXFnWSMCuzFdYHjLALBCEW6nBbGD7Rm3351
         S9nCVR7InZiL0se/5F8niOvuVGUl4h/pj56SjR9YqBlkSsRCd1RcALTWFOrgIip4cLm3
         PW+KbUS0AdKmAqE8+2GY42m61JkVBXNp6ddUxyCvfm/XKksB5aAMuMnCUSpsuXFPUxZO
         GzVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Thu, 12 Apr 2018 00:15:59 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-0f561fce4d6979a50415616896512f87a6d1d5c8@git.kernel.org>
Cc: aarcange@redhat.com, luto@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, jgross@suse.com, arjan@linux.intel.com,
        hpa@zytor.com, hughd@google.com, namit@vmware.com, mingo@kernel.org,
        gregkh@linuxfoundation.org, keescook@google.com,
        dan.j.williams@intel.com, jpoimboe@redhat.com, tglx@linutronix.de,
        dwmw2@infradead.org, peterz@infradead.org
Reply-To: dave.hansen@linux.intel.com, jgross@suse.com, arjan@linux.intel.com,
        luto@kernel.org, aarcange@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, hughd@google.com,
        mingo@kernel.org, namit@vmware.com, gregkh@linuxfoundation.org,
        hpa@zytor.com, tglx@linutronix.de, keescook@google.com,
        dan.j.williams@intel.com, jpoimboe@redhat.com, dwmw2@infradead.org,
        peterz@infradead.org
In-Reply-To: <20180406205515.2977EE7D@viggo.jf.intel.com>
References: <20180406205515.2977EE7D@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Enable global pages for shared areas
Git-Commit-ID: 0f561fce4d6979a50415616896512f87a6d1d5c8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289781405752273?=
X-GMAIL-MSGID: =?utf-8?q?1597523814260941847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  0f561fce4d6979a50415616896512f87a6d1d5c8
Gitweb:     https://git.kernel.org/tip/0f561fce4d6979a50415616896512f87a6d1d5c8
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:15 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 12 Apr 2018 09:05:59 +0200

x86/pti: Enable global pages for shared areas

The entry/exit text and cpu_entry_area are mapped into userspace and
the kernel.  But, they are not _PAGE_GLOBAL.  This creates unnecessary
TLB misses.

Add the _PAGE_GLOBAL flag for these areas.

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
Link: http://lkml.kernel.org/r/20180406205515.2977EE7D@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/cpu_entry_area.c | 14 +++++++++++++-
 arch/x86/mm/pti.c            | 23 ++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 476d810639a8..b45f5aaefd74 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -27,8 +27,20 @@ EXPORT_SYMBOL(get_cpu_entry_area);
 void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 {
 	unsigned long va = (unsigned long) cea_vaddr;
+	pte_t pte = pfn_pte(pa >> PAGE_SHIFT, flags);
 
-	set_pte_vaddr(va, pfn_pte(pa >> PAGE_SHIFT, flags));
+	/*
+	 * The cpu_entry_area is shared between the user and kernel
+	 * page tables.  All of its ptes can safely be global.
+	 * _PAGE_GLOBAL gets reused to help indicate PROT_NONE for
+	 * non-present PTEs, so be careful not to set it in that
+	 * case to avoid confusion.
+	 */
+	if (boot_cpu_has(X86_FEATURE_PGE) &&
+	    (pgprot_val(flags) & _PAGE_PRESENT))
+		pte = pte_set_flags(pte, _PAGE_GLOBAL);
+
+	set_pte_vaddr(va, pte);
 }
 
 static void __init
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 631507f0c198..8082f8b0c10e 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -299,6 +299,27 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 		if (WARN_ON(!target_pmd))
 			return;
 
+		/*
+		 * Only clone present PMDs.  This ensures only setting
+		 * _PAGE_GLOBAL on present PMDs.  This should only be
+		 * called on well-known addresses anyway, so a non-
+		 * present PMD would be a surprise.
+		 */
+		if (WARN_ON(!(pmd_flags(*pmd) & _PAGE_PRESENT)))
+			return;
+
+		/*
+		 * Setting 'target_pmd' below creates a mapping in both
+		 * the user and kernel page tables.  It is effectively
+		 * global, so set it as global in both copies.  Note:
+		 * the X86_FEATURE_PGE check is not _required_ because
+		 * the CPU ignores _PAGE_GLOBAL when PGE is not
+		 * supported.  The check keeps consistentency with
+		 * code that only set this bit when supported.
+		 */
+		if (boot_cpu_has(X86_FEATURE_PGE))
+			*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);
+
 		/*
 		 * Copy the PMD.  That is, the kernelmode and usermode
 		 * tables will share the last-level page tables of this
@@ -348,7 +369,7 @@ static void __init pti_clone_entry_text(void)
 {
 	pti_clone_pmds((unsigned long) __entry_text_start,
 			(unsigned long) __irqentry_text_end,
-		       _PAGE_RW | _PAGE_GLOBAL);
+		       _PAGE_RW);
 }
 
 /*
