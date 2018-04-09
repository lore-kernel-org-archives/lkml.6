Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx4+u+jvtkmHcYo/jzRQLo97hpFZwjXUs2tQ5+FePbImOd1A8O3qMDa2pJZW4xmeBKE3IcDeK
ARC-Seal: i=1; a=rsa-sha256; t=1523294039; cv=none;
        d=google.com; s=arc-20160816;
        b=MVrOyE3vF/WNCbp8dK7KGGoOGY093LhLIHlF9mQ7sQwguJwunAqyflcM1dYvG5Vb85
         BzQxYBiAruc2O/t0MsC4yaIlP1kw1EyvRbksoR4KPj6D7QOqNxsRvrrWi6ycxP4mSM2F
         EXHN2SBTMc5tBJOKA3VOt/Fb0BR9HohTVtBgYQPtVKnRvkN7/kMq2PCsLHJIUmBxXdON
         9t1lmRx9Tbn0eFNKvdT8vMD+SGBp71zcX1ahLBcnSQOeFf5vkGjcp6ARctud1ijpn3B3
         pfxmeUdHpSVBNGNWJcGoVr6Wzaridn5Ofd3a0H3zMGIE05fYkU2LZkq6pJdlU/1+OFxJ
         VYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=xL5lc5tbaPWy9c82VEJPW6go5jdwFN791VHTn4KyIW0=;
        b=XrEIxcgCHoqQJdopFTl24vRQA/rmBbrOYaNF8CHsTrWxIcD+3xN7ax2EfmYyIxAAAx
         I4G5KJBBT1DCDxfnnmD1Cmb6HG7+98fcrE8QbQShu6EbVJkz+V99kYBubN/8kBv0H7Ny
         pO2ll2iZcWFdVzZoxriWd6t/eAsPERtc8PkREyr6Ase5GpFa9U2Q+LM/hi2IfceZ4e8A
         3mMews18QpbHt85zxzOB09oB2BFK76wvztoa8eDVSGfwCdWZT9mtfFGcV2ED3NeBsv9m
         i0+7bNDB8tzti7f1HpDhhfenK63aMebl/OvKm1v7LBdlbZXT3rceCx/EdY2vdwel0rqe
         tUEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:13:17 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-6baf4bec02dbc41645c3a5130ee15a8e1d62b80f@git.kernel.org>
Cc: jpoimboe@redhat.com, torvalds@linux-foundation.org,
        dave.hansen@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, namit@vmware.com,
        bp@alien8.de, aarcange@redhat.com, luto@kernel.org, jgross@suse.com,
        keescook@google.com, gregkh@linuxfoundation.org, peterz@infradead.org,
        hpa@zytor.com, dan.j.williams@intel.com, hughd@google.com,
        mingo@kernel.org, dwmw2@infradead.org
Reply-To: jgross@suse.com, keescook@google.com, hpa@zytor.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, dwmw2@infradead.org,
        mingo@kernel.org, hughd@google.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com, luto@kernel.org, namit@vmware.com,
        aarcange@redhat.com, bp@alien8.de, tglx@linutronix.de
In-Reply-To: <20180406205507.BCF4D4F0@viggo.jf.intel.com>
References: <20180406205507.BCF4D4F0@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/espfix: Document use of _PAGE_GLOBAL
Git-Commit-ID: 6baf4bec02dbc41645c3a5130ee15a8e1d62b80f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289571344453428?=
X-GMAIL-MSGID: =?utf-8?q?1597289571344453428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  6baf4bec02dbc41645c3a5130ee15a8e1d62b80f
Gitweb:     https://git.kernel.org/tip/6baf4bec02dbc41645c3a5130ee15a8e1d62b80f
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:07 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:33 +0200

x86/espfix: Document use of _PAGE_GLOBAL

The "normal" kernel page table creation mechanisms using
PAGE_KERNEL_* page protections will never set _PAGE_GLOBAL with PTI.
The few places in the kernel that always want _PAGE_GLOBAL must
avoid using PAGE_KERNEL_*.

Document that we want it here and its use is not accidental.

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
Link: http://lkml.kernel.org/r/20180406205507.BCF4D4F0@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/espfix_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index e5ec3cafa72e..aebd0d5bc086 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -195,6 +195,10 @@ void init_espfix_ap(int cpu)
 
 	pte_p = pte_offset_kernel(&pmd, addr);
 	stack_page = page_address(alloc_pages_node(node, GFP_KERNEL, 0));
+	/*
+	 * __PAGE_KERNEL_* includes _PAGE_GLOBAL, which we want since
+	 * this is mapped to userspace.
+	 */
 	pte = __pte(__pa(stack_page) | ((__PAGE_KERNEL_RO | _PAGE_ENC) & ptemask));
 	for (n = 0; n < ESPFIX_PTE_CLONES; n++)
 		set_pte(&pte_p[n*PTE_STRIDE], pte);
