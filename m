Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtdICX7xqbO1vonzf1ZvmUlejOi2O2Vg22GuLDO2HI3YtUrShgBxZcx6sqsIL3xRmO78TPA
ARC-Seal: i=1; a=rsa-sha256; t=1520824087; cv=none;
        d=google.com; s=arc-20160816;
        b=vCpkbGFFzdJErTIDewbfqfFOjlY5SW78SxXjriCNbioVh2cr+NDAL9/M5oysi+RtwV
         U0I7vGJ5ZRsZ/ZBV5FVTAJ1cs7ew7D45aLsTSupLoGDMqv94s0UzQzrL/TyQUmIQSvX4
         Az2Ik6Tg7PR01bECNIBEvs7WiycdBDpaN2aofbY8tG1NoYTnZ5pCArywa/qTI88kVVWJ
         OVXIMgMeU8RA2CuMF+mpCoguGxpmwdpGQ4Kgxf3RgG+cQXRazeYdACc2N2aAzpL5oNAE
         kuVWypdwyfyUW6C5R/opRW0ewlnAvMN2A6ca3Q/6z+N4I3x3IjGKTbEsDdhHDozYHFjd
         LHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=pEFFRGgPc1EKWQctEjJBA2Q+SvRWPKDVyFdxgy+fjaY=;
        b=JwUrN3MkK8Qh/SdjdXWfo7alXIz0RjJ91kTwEH32GNuC3fGAmDHb+wwzliJqkf6eOm
         8Rlwjk1Rxgltb/CVRVLA59DOhORPkSN76mch1ewYdTsLcpy2YK7/rmY5+ucGAadS8Del
         uZuOscLnmYxriVI3ywb2VWHhA8WbQHeD3G19vWMbkp7sqFJSfpy9O9xqh3qPKhB+Fbna
         VhtYK58wMUoLSC6UplymG5KhG7b3DcqES9MYMywb5OVj9DQM48sDWgvbWZkRkjV5jJTh
         FnIbf25bfhL4AGfc0BushAfR48olQSpei5Wm75mPlm+AoWr77zSUzLljVBwo+GXS2I1A
         zeig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Ingo Molnar" <mingo@kernel.org>,
 "Rik van Riel" <riel@redhat.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Kees Cook" <keescook@google.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 thomas.lendacky@amd.com
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.412053836@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 065/104] x86/retpoline/irq32: Convert assembler
 indirect jumps
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699634841948642?=
X-GMAIL-MSGID: =?utf-8?q?1594699638069855956?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 7614e913db1f40fff819b36216484dc3808995d4 upstream.

Convert all indirect jumps in 32bit irq inline asm code to use non
speculative sequences.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515707194-20531-12-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/irq_32.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 
 #include <asm/apic.h>
+#include <asm/nospec-branch.h>
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -64,11 +65,11 @@ static DEFINE_PER_CPU(union irq_ctx *, s
 static void call_on_stack(void *func, void *stack)
 {
 	asm volatile("xchgl	%%ebx,%%esp	\n"
-		     "call	*%%edi		\n"
+		     CALL_NOSPEC
 		     "movl	%%ebx,%%esp	\n"
 		     : "=b" (stack)
 		     : "0" (stack),
-		       "D"(func)
+		       [thunk_target] "D"(func)
 		     : "memory", "cc", "edx", "ecx", "eax");
 }
 
@@ -107,11 +108,11 @@ execute_on_irq_stack(int overflow, struc
 		call_on_stack(print_stack_overflow, isp);
 
 	asm volatile("xchgl	%%ebx,%%esp	\n"
-		     "call	*%%edi		\n"
+		     CALL_NOSPEC
 		     "movl	%%ebx,%%esp	\n"
 		     : "=a" (arg1), "=d" (arg2), "=b" (isp)
 		     :  "0" (irq),   "1" (desc),  "2" (isp),
-			"D" (desc->handle_irq)
+			[thunk_target] "D" (desc->handle_irq)
 		     : "memory", "cc", "ecx");
 	return 1;
 }
