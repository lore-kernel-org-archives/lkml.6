Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsBN5nsGohbp48e15ddtGii6DY4KW6B6IK0hKt30u3ctpPx6DUAGyjQIorazRxYaqP76t8r
ARC-Seal: i=1; a=rsa-sha256; t=1520824084; cv=none;
        d=google.com; s=arc-20160816;
        b=MvGWVjycisKmuJFLrB0nEz/EgtpSgRAgO1dL3qOK7mDdTkoEEU4jkfbVBv4jbZuxmc
         7VZLoTcm1XDsX+b1vDv5GUkBGqG6IFiuzhtan61zrkraRd+P00t6/GGBl1KutWjMQ3cM
         Z1bobMSWPJERolUS9Q5Qfy9eKYrXeGeSzbaUDZ72zxV0EaivfsxDJV6J79y7FE+jiech
         z42UMSc704jr0LxJskeGGmaViy2HtinbL3WYtJwlD+f03jQKQoUlclRsntynJAbmXDCQ
         ZjQ7obYC7WuDAntlm7ZTmz+aZ1k1UqXZXX2oH+4BntYuHMzJ8Nw6S2whYKObfuV8fjvd
         jzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=+98pV2/mAPb8EAbUyY5BkQEZtGU9WN9ts9B8t8daxQc=;
        b=xOznI6TqibkOJXaZUzS6IcMndaWtdv6ZIefxWbqxXHASPJnow4C1A7bnMvr/c4n0nD
         WzMZ26+YbfPL1C/nQ7XwUC7Ze5QksLCI1/ENw/hwbhZqjrcXDmCxoPayKFDUv9nUWkdH
         luwrmigIzVcxR/nbEjs3vyTeCAJUnw6lAiawNjAlc0b00ibzaEoF5c7gNLdtTU0x9J95
         XAGsnvzre9kvthmC6t3r5+9e+paN6hBXhsRaBLk3h+EvcR8mlagsP89QKystahqHao+9
         wt4CMyKfFr/Uy08YJgyKKP5h94i/DZIoTRAzzTasCMPB+JiHel1byf7gcGCTZeb50nlC
         gNqw==
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
 "Andi Kleen" <ak@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@kernel.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 thomas.lendacky@amd.com,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.343958071@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 31/76] x86/retpoline/irq32: Convert assembler
 indirect jumps
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699634841948642?=
X-GMAIL-MSGID: =?utf-8?q?1594699634841948642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
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
@@ -61,11 +62,11 @@ DEFINE_PER_CPU(struct irq_stack *, softi
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
 
@@ -102,11 +103,11 @@ execute_on_irq_stack(int overflow, struc
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
