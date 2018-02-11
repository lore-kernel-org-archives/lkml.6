Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x225FI0pqBwqjSte3vEEoI9p5ALf6MfdwalwNQoEyGQwq5Idhrtx3ZMrSAM+UeMj3pFDoB162
ARC-Seal: i=1; a=rsa-sha256; t=1518402352; cv=none;
        d=google.com; s=arc-20160816;
        b=m+i2P9dUBMv7bl+cEaZ5p4cn61NnLWsb9zKjSHS6org/iuAtTiTDVbz/Ia6XSTVK7/
         SGlOMVzf+wzGP2RsxYtJiZ3h8tCDXpxPu3Y/jdG5XS4tAUDCDw5FUsz9KIUzrYWjlu3y
         vE3hMNHCFuBI780Q66i7xVRZkX9wVPsco2U9MUWDZ5DQmY+hKgseLESI5KrZA5TwuyFz
         vgv7egmUxlxfwWDvVhdd9TaNJ8Lpg6bFGlNL9rIm8zTIrt32xBh6rQkAP+KOit5JLvYA
         H8Icc+OMCQw06s7vH6HGvascUF+EK3hr4S4IlELyWmYrNrZDLK3qnuXGPut9TycD1H4K
         y/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=P9jRrz8E+qzd0DgUEotS9+yavLh9c0E9Q2/7mEdvhP4=;
        b=zK5WZKa2piBzq8yRj8qoj5kYjQD6Epe145wFuFo74VBQ+cyGVLYlKJXVjAc+ah6QPI
         y+0gDackoVOlDAkbJiBlsXw++1WsB2ZNrE+8ni2yolJULoVY2eqfvJ7DgV8zvTx+aH+8
         T8pm0ItbkJZPcUrC/a8FkvQFl3a7wTZykzKA5oPsd4DuuWH4ppcprbYjAoWANCcDY6g1
         F4E0RNl9dDHHOpQiWuN1LSvlb5Kd75N6Z5MgBg5IcQkS4pDkqnzb2gVNJPioXnXALuQf
         MSDDsVCsUzW5ed/3B1n3ilTMDg5x4wubKUX/vnCC+TixoDG8VZtS/l0PheV8/6Mil5RN
         7Cuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sun, 11 Feb 2018 04:09:25 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for David Woodhouse <tipbot@zytor.com>
Message-ID: <tip-930ce1a7a55bc0eb8917f453ee22f1b6d67df5cd@git.kernel.org>
Cc: dwmw@amazon.co.uk, arjan@linux.intel.com, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, bp@alien8.de, hpa@zytor.com,
        jpoimboe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com,
        luto@kernel.org, dwmw2@infradead.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org
Reply-To: peterz@infradead.org, jpoimboe@redhat.com, hpa@zytor.com,
        bp@alien8.de, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, arjan@linux.intel.com, dwmw@amazon.co.uk,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dan.j.williams@intel.com, dwmw2@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
In-Reply-To: <1518305967-31356-3-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-3-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] Revert "x86/speculation: Simplify
 indirect_branch_prediction_barrier()"
Git-Commit-ID: 930ce1a7a55bc0eb8917f453ee22f1b6d67df5cd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592160265203742206?=
X-GMAIL-MSGID: =?utf-8?q?1592160265203742206?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  930ce1a7a55bc0eb8917f453ee22f1b6d67df5cd
Gitweb:     https://git.kernel.org/tip/930ce1a7a55bc0eb8917f453ee22f1b6d67df5cd
Author:     David Woodhouse <dwmw@amazon.co.uk>
AuthorDate: Sat, 10 Feb 2018 23:39:23 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 11:24:15 +0100

Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"

This reverts commit 64e16720ea0879f8ab4547e3b9758936d483909b.

We cannot call C functions like that, without marking all the
call-clobbered registers as, well, clobbered. We might have got away
with it for now because the __ibp_barrier() function was *fairly*
unlikely to actually use any other registers. But no. Just no.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Cc: sironi@amazon.de
Link: http://lkml.kernel.org/r/1518305967-31356-3-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/nospec-branch.h | 13 +++++++++----
 arch/x86/include/asm/processor.h     |  3 ---
 arch/x86/kernel/cpu/bugs.c           |  6 ------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4d57894..300cc15 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -164,10 +164,15 @@ static inline void vmexit_fill_RSB(void)
 
 static inline void indirect_branch_prediction_barrier(void)
 {
-	alternative_input("",
-			  "call __ibp_barrier",
-			  X86_FEATURE_USE_IBPB,
-			  ASM_NO_INPUT_CLOBBER("eax", "ecx", "edx", "memory"));
+	asm volatile(ALTERNATIVE("",
+				 "movl %[msr], %%ecx\n\t"
+				 "movl %[val], %%eax\n\t"
+				 "movl $0, %%edx\n\t"
+				 "wrmsr",
+				 X86_FEATURE_USE_IBPB)
+		     : : [msr] "i" (MSR_IA32_PRED_CMD),
+			 [val] "i" (PRED_CMD_IBPB)
+		     : "eax", "ecx", "edx", "memory");
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 513f960..99799fb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -969,7 +969,4 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
-
-void __ibp_barrier(void);
-
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 71949bf..61152aa 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -337,9 +337,3 @@ ssize_t cpu_show_spectre_v2(struct device *dev,
 		       spectre_v2_module_string());
 }
 #endif
-
-void __ibp_barrier(void)
-{
-	__wrmsr(MSR_IA32_PRED_CMD, PRED_CMD_IBPB, 0);
-}
-EXPORT_SYMBOL_GPL(__ibp_barrier);
