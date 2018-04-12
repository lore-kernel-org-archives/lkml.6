Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx4+oyHHxaI/s6DF9O84fgc1NmMxJnENZCZstYAmNVWNrpE0cH0H+TBAiqS4zmmEARP/vmfZC
ARC-Seal: i=1; a=rsa-sha256; t=1523517387; cv=none;
        d=google.com; s=arc-20160816;
        b=E65/I3qn45ZvBoWgVVjdfOrUwBBhz6SdSAOByovmUUbVFkj3zbWGCMic3d2eB+ScXq
         sfj4IEv+k9FLWajdIwTkP7pFCGiz2nY7t4hyfujRpxOYc2jTRct/tAkidqhMG141c9uF
         LFRbA7vssdcriSEhippb3J35EzhBR7TTCstICgY9XOiKMYYxIZd2QCmAw6l8GBaPrMhu
         n96Vhq3E5S2UJNZIp55q2K0hxwVWKWlkLygc3guSVYiABo2Kb5OzRVw5TEkhffNFt5bo
         y0bX8qUAWmTwHtprQcxrsaS7E+9VkPRiFJ4J7Bd23ZwEhVDXBDFbpywdTWXGgco/Tc49
         JlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=TWKnpOgYTh1HgnPbnlS9gN4/w6+oBcYVUe6EO0OLiFM=;
        b=rnyPu0X4+FWuMaEijU6P6jdbq4M0hhN2PCNK4/Y/rbFk8opY+XxMzaToVUmRPKRLlB
         Hyg+a+9UnkfdnK9t3+i6xTYGktILjThxB7GdX7P6U/2t8HyN1C3LmknDrLVIArhkhcEf
         MzzbId/iCLj43EzrdVkzDEjoIFruw7ePjaqWkrF3rpQyEQhFhXrUOOVAKSNdEQo8By0Q
         kgj7R4FJQsCY4m+d2xPioS1aqjafGBGIwC3LliSN0Eqfpx2szQ/w8YU/ATLULDFc4RDI
         ceaROnQpRvF0xZcKXimzfdffqPif4ZS3hx7LchIyOBGuD7pqZA2bovgl8ozQ0hbXzhVW
         K3jA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Thu, 12 Apr 2018 00:15:28 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-639d6aafe437a7464399d2a77d006049053df06f@git.kernel.org>
Cc: jpoimboe@redhat.com, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        jgross@suse.com, hpa@zytor.com, dave.hansen@linux.intel.com,
        keescook@chromium.org, dwmw2@infradead.org,
        torvalds@linux-foundation.org, peterz@infradead.org, namit@vmware.com,
        luto@kernel.org, dan.j.williams@intel.com, hughd@google.com,
        arjan@linux.intel.com, gregkh@linuxfoundation.org, aarcange@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: jpoimboe@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, bp@alien8.de, jgross@suse.com, namit@vmware.com,
        dave.hansen@linux.intel.com, dwmw2@infradead.org,
        keescook@chromium.org, torvalds@linux-foundation.org,
        peterz@infradead.org, hughd@google.com, arjan@linux.intel.com,
        gregkh@linuxfoundation.org, luto@kernel.org, dan.j.williams@intel.com,
        aarcange@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180406205514.8D898241@viggo.jf.intel.com>
References: <20180406205514.8D898241@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Do not forbid _PAGE_RW before init for
 __ro_after_init
Git-Commit-ID: 639d6aafe437a7464399d2a77d006049053df06f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289689293448520?=
X-GMAIL-MSGID: =?utf-8?q?1597523768762578922?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  639d6aafe437a7464399d2a77d006049053df06f
Gitweb:     https://git.kernel.org/tip/639d6aafe437a7464399d2a77d006049053df06f
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:14 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 12 Apr 2018 09:05:59 +0200

x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init

__ro_after_init data gets stuck in the .rodata section.  That's normally
fine because the kernel itself manages the R/W properties.

But, if we run __change_page_attr() on an area which is __ro_after_init,
the .rodata checks will trigger and force the area to be immediately
read-only, even if it is early-ish in boot.  This caused problems when
trying to clear the _PAGE_GLOBAL bit for these area in the PTI code:
it cleared _PAGE_GLOBAL like I asked, but also took it up on itself
to clear _PAGE_RW.  The kernel then oopses the next time it wrote to
a __ro_after_init data structure.

To fix this, add the kernel_set_to_readonly check, just like we have
for kernel text, just a few lines below in this function.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kees Cook <keescook@chromium.org>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180406205514.8D898241@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 968f51a2e39b..a7324045d87d 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -298,9 +298,11 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 
 	/*
 	 * The .rodata section needs to be read-only. Using the pfn
-	 * catches all aliases.
+	 * catches all aliases.  This also includes __ro_after_init,
+	 * so do not enforce until kernel_set_to_readonly is true.
 	 */
-	if (within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
+	if (kernel_set_to_readonly &&
+	    within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
 		   __pa_symbol(__end_rodata) >> PAGE_SHIFT))
 		pgprot_val(forbidden) |= _PAGE_RW;
 
