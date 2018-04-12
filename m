Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx4+yvxEzQREeETusZyqgTw78MKv8ygWhcgj+uP5G+H/VJyBkPpStLKpjvMWmdTpZlh3QIPdN
ARC-Seal: i=1; a=rsa-sha256; t=1523517401; cv=none;
        d=google.com; s=arc-20160816;
        b=b6wKzw/NLQRuEgLpkcs4k0sRBDTC7scKHdXKo0/zl6yJmkO/YLUhDa/C3qytqwNylM
         Whhm5DVCPeVdNkhM0OVshoOORSIhdTDZwiJ2w7NM1bumjfNtgPt8UNV8tsF6SzOkarty
         dXGRz5vywu0A2mjPcvXyWUD/4spDz2J+ImqSVqKUZFdBopu2+wOJsIASJx/FZkhkQhCL
         A1Iql8a9e7NpmIcFtttZZ1SR6yDMXnXHwXgxfPFL60ekXZ4J6tJoNIw1Slq3Y0EFhfPy
         s5oEKuRlf8dzCykKmmbVaTuzo5jBgPLxQnLp9Df1Shj/rcBlzXdMkR5+Xf0BkUhr90ce
         sIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=AR6oQaOFZtzU4VAsi+2Uau9tRcWlKFMlKObeEmaEYNo=;
        b=cj00ve38iqh/xuqgBy0vL5iWJbC4IfUeiTKp4DTDPxR2J1xMn0wJhP5v8RGsVtmMl8
         jrjctEqd/EuREs6QCyBDnSIQ8BUmnZ2hJ4ECExuFXCVexvY3/WGCwqvUpuSXJPBSDK9J
         uJ0lTQrJUhz6/b93hvQNbO78gedH1CjnHoZ1bnjq3T3Wf8eHvZxwrbzzkK2UXVQVnpYL
         NGUCkaetJEYWjnrlB5qXybTvRl7wRTEqbbni5BU97+z3F5yRBtS+mxdu4eDVlIDBjo08
         XNdolFvDWkpVq8GynJnUQPdT7zA+J7rTxZ3fK+WITwjXNvNg9jpApoIFTH5ePRoC7ZqJ
         1yRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Thu, 12 Apr 2018 00:14:58 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-430d4005b8b41c19966dd3bfdb33004bdb2de01c@git.kernel.org>
Cc: luto@kernel.org, dave.hansen@linux.intel.com, keescook@google.com,
        dan.j.williams@intel.com, torvalds@linux-foundation.org,
        mingo@kernel.org, jgross@suse.com, dwmw2@infradead.org,
        hughd@google.com, gregkh@linuxfoundation.org, peterz@infradead.org,
        hpa@zytor.com, namit@vmware.com, arjan@linux.intel.com,
        tglx@linutronix.de, jpoimboe@redhat.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de
Reply-To: dwmw2@infradead.org, jgross@suse.com, hughd@google.com,
        gregkh@linuxfoundation.org, peterz@infradead.org, hpa@zytor.com,
        namit@vmware.com, luto@kernel.org, dave.hansen@linux.intel.com,
        keescook@google.com, mingo@kernel.org, torvalds@linux-foundation.org,
        dan.j.williams@intel.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
        arjan@linux.intel.com, jpoimboe@redhat.com
In-Reply-To: <20180406205513.079BB265@viggo.jf.intel.com>
References: <20180406205513.079BB265@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Comment _PAGE_GLOBAL mystery
Git-Commit-ID: 430d4005b8b41c19966dd3bfdb33004bdb2de01c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289661093401125?=
X-GMAIL-MSGID: =?utf-8?q?1597523782441333090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  430d4005b8b41c19966dd3bfdb33004bdb2de01c
Gitweb:     https://git.kernel.org/tip/430d4005b8b41c19966dd3bfdb33004bdb2de01c
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:13 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 12 Apr 2018 09:05:58 +0200

x86/mm: Comment _PAGE_GLOBAL mystery

I was mystified as to where the _PAGE_GLOBAL in the kernel page tables
for kernel text came from.  I audited all the places I could find, but
I missed one: head_64.S.

The page tables that we create in here live for a long time, and they
also have _PAGE_GLOBAL set, despite whether the processor supports it
or not.  It's harmless, and we got *lucky* that the pageattr code
accidentally clears it when we wipe it out of __supported_pte_mask and
then later try to mark kernel text read-only.

Comment some of these properties to make it easier to find and
understand in the future.

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
Link: http://lkml.kernel.org/r/20180406205513.079BB265@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/head_64.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 48385c1074a5..8344dd2f310a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -399,8 +399,13 @@ NEXT_PAGE(level3_ident_pgt)
 	.quad	level2_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.fill	511, 8, 0
 NEXT_PAGE(level2_ident_pgt)
-	/* Since I easily can, map the first 1G.
+	/*
+	 * Since I easily can, map the first 1G.
 	 * Don't set NX because code runs from these pages.
+	 *
+	 * Note: This sets _PAGE_GLOBAL despite whether
+	 * the CPU supports it or it is enabled.  But,
+	 * the CPU should ignore the bit.
 	 */
 	PMDS(0, __PAGE_KERNEL_IDENT_LARGE_EXEC, PTRS_PER_PMD)
 #else
@@ -431,6 +436,10 @@ NEXT_PAGE(level2_kernel_pgt)
 	 * (NOTE: at +512MB starts the module area, see MODULES_VADDR.
 	 *  If you want to increase this then increase MODULES_VADDR
 	 *  too.)
+	 *
+	 *  This table is eventually used by the kernel during normal
+	 *  runtime.  Care must be taken to clear out undesired bits
+	 *  later, like _PAGE_RW or _PAGE_GLOBAL in some cases.
 	 */
 	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
