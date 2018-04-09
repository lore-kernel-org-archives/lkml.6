Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx48suWIX+OmX0aWEVzVfS7UGtXye5MxNSSV1vBXrbMif9Npbkd7dYFUJdYje9tz/hhL4KGb5
ARC-Seal: i=1; a=rsa-sha256; t=1523294152; cv=none;
        d=google.com; s=arc-20160816;
        b=uitdMOWXhetdosNEhWOi0QvsVgMjB+MjkLlpkiRidhvViCx6c2iKqLzsz0O9p4vX+N
         8RFx6IPYDAq9bMzyiCvyQoQ0OTZ7VetMqgFP11QPa7AG+VqhsZSIbPQ1FyhTgbfy2ZHL
         sC+xri5VrUFGxi6V9jfFD9AmB/v7rBgguD6VvIdgWZx4VE+cW1CAdmA+YJhMRI9LIfFm
         t1Fi/6zh2G6+rNeAdExZ9YJhbrij/Pj/bEvghL5CSM4n826s1zyOn0V3BPKGecLEHQYg
         4+r38x4A5EdHEJRahRC7AKiOoAsZng5vR+AH5h4ws4VOrwKHmqZZIBbB5CCGq2pbiZIS
         uBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=CvOmTyl8qrsAnT8JmlZ4Nah0JpzSWigr7FY+qOP1+xI=;
        b=tIJFzQbsUof0C3sDAj7apuAsThuXAlC0T8gYAYJIi3Wv+6184mDeE+EqEuditLUYkv
         AikIIOyfXZZhBGO/+0cIMeQ9jpTutdZjnPN/R3+7YdXi7qjfIPgA2OIaxr53Wk9szLLN
         CoA3zakFtNKxOrxoJ1U3z792w7fpL9GiPOb05IuxLhi3xNU+6NctIc1eSHye/5yC5glY
         intMJM6AjmoiDLxXIz6+FOZharHpN3t6lQrn7EalVGni7nojB+zIYZpCB3Ypphk7u1/C
         0Sl72Qlqi+CHH6/YTok8L6FPeke2MPbTWpOXDWW+AnH1OiLksAAvce5Oo3ozWLd4530G
         KtIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:15:09 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-efad2b4151521c944e405272035a673c74125c65@git.kernel.org>
Cc: luto@kernel.org, gregkh@linuxfoundation.org, namit@vmware.com,
        hpa@zytor.com, dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        tglx@linutronix.de, dwmw2@infradead.org, torvalds@linux-foundation.org,
        hughd@google.com, arjan@linux.intel.com, keescook@chromium.org,
        aarcange@redhat.com, mingo@kernel.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        peterz@infradead.org
Reply-To: dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        torvalds@linux-foundation.org, dwmw2@infradead.org, tglx@linutronix.de,
        luto@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        namit@vmware.com, aarcange@redhat.com, keescook@chromium.org,
        mingo@kernel.org, hughd@google.com, arjan@linux.intel.com,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        jgross@suse.com, peterz@infradead.org
In-Reply-To: <20180406205514.8D898241@viggo.jf.intel.com>
References: <20180406205514.8D898241@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Do not forbid _PAGE_RW before init for
 __ro_after_init
Git-Commit-ID: efad2b4151521c944e405272035a673c74125c65
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
X-GMAIL-MSGID: =?utf-8?q?1597289689293448520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  efad2b4151521c944e405272035a673c74125c65
Gitweb:     https://git.kernel.org/tip/efad2b4151521c944e405272035a673c74125c65
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:14 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:34 +0200

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
 
