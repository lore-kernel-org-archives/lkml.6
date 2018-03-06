Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELtwJJ4V+QorHonRjVHspEuaTarAM/7wtdpNQNdJvgiFd1q1xRBJYUWTSa7hb4yrLYKCATZh
ARC-Seal: i=1; a=rsa-sha256; t=1520295982; cv=none;
        d=google.com; s=arc-20160816;
        b=Uha3WwuAXHdcxIpxFlJMnyezRxfWljgzeF0jXSua98T3I/bIrU4pmBTBmdwjqQg5UA
         Ub/qhOnu3gE8iwPSefD95zQNox0OD5CeKZzcCFlARwIqnrA0mlJHjrt1QqwGycvfHtgM
         4g9hf3mKDz0Q8XGA8Tldk4WL5awPo9mIEcgkhhLFregilsnVt3PxONnvt2Xyj0kUOAQC
         fHWgfCmOoVcpyT8h1r5cAjFDFibo9gPmgeeBEyH1D86dA+Vl+ZHyI+cEppC02mXP/Js3
         vyfLfRYaZleEGtFKgEPN6Wjtq822o8uBIOqZ8I2dMJzRB8jGbeOIHjyvwcODCTjXAUBb
         +SHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=tdpc+7Jw/Ly+c4riK6XReTTY0hZGVnX8jKWoqZX+t60=;
        b=w/o+Mel04Rg1gTZjXw9gkmUIHD+I+kf9Pv3KfeTndF0WRDKgiOkmoAOWTSPfJUat4t
         AtbG7aqbiIj60w2rBT7bZdc92ORM6ljWJp/J6MhazB3WzRF+eAYp3j9c8ZFhNuBY47Oe
         ZZ683U5oqs3Q8Wv2LPC70/EwNyPS6ULRCv3gLhSS3+PcvspknfDVDM6H4QKPBRqRCD1y
         mG/h+LjpDHb2a1/5Rgz0Xs0Ry0PhAXXO/zApYbb3G8R99tzJtCPdFFtjirVXqP6yCtDk
         1JWM0jXAOSMORoCGU3T0qNnVj1vPKd+ZFnAByC26nt1Q9BMJaYx3Jge6FnDsINQr4PH2
         YMQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Sw7D8SOx;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Sw7D8SOx;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 24/65] x86/entry: Remove unused 'kernel_stack' per-cpu variable
Date: Mon,  5 Mar 2018 19:24:57 -0500
Message-Id: <20180306002538.1761-25-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145879808485192?=
X-GMAIL-MSGID: =?utf-8?q?1594145879808485192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Denys Vlasenko <dvlasenk@redhat.com>

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Drewry <wad@chromium.org>
Link: http://lkml.kernel.org/r/1429889495-27850-2-git-send-email-dvlasenk@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
(cherry picked from commit fed7c3f0f750f225317828d691e9eb76eec887b3)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/thread_info.h | 2 --
 arch/x86/kernel/cpu/common.c       | 4 ----
 arch/x86/kernel/process_32.c       | 5 +----
 arch/x86/kernel/process_64.c       | 3 ---
 arch/x86/kernel/smpboot.c          | 2 --
 5 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d656a363e1eb..472288962c99 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -177,8 +177,6 @@ struct thread_info {
  */
 #ifndef __ASSEMBLY__
 
-DECLARE_PER_CPU(unsigned long, kernel_stack);
-
 static inline struct thread_info *current_thread_info(void)
 {
 	return (struct thread_info *)(current_top_of_stack() - THREAD_SIZE);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f5647d238337..4f1db34113e2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1210,10 +1210,6 @@ static __init int setup_disablecpuid(char *arg)
 }
 __setup("clearcpuid=", setup_disablecpuid);
 
-DEFINE_PER_CPU(unsigned long, kernel_stack) =
-	(unsigned long)&init_thread_union + THREAD_SIZE;
-EXPORT_PER_CPU_SYMBOL(kernel_stack);
-
 #ifdef CONFIG_X86_64
 struct desc_ptr idt_descr = { NR_VECTORS * 16 - 1, (unsigned long) idt_table };
 struct desc_ptr debug_idt_descr = { NR_VECTORS * 16 - 1,
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 8ed2106b06da..a99900cedc22 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -302,13 +302,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	arch_end_context_switch(next_p);
 
 	/*
-	 * Reload esp0, kernel_stack, and current_top_of_stack.  This changes
+	 * Reload esp0 and cpu_current_top_of_stack.  This changes
 	 * current_thread_info().
 	 */
 	load_sp0(tss, next);
-	this_cpu_write(kernel_stack,
-		       (unsigned long)task_stack_page(next_p) +
-		       THREAD_SIZE);
 	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index f7724a1d7de1..b6533ef508c9 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -410,9 +410,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Reload esp0 and ss1.  This changes current_thread_info(). */
 	load_sp0(tss, next);
 
-	this_cpu_write(kernel_stack,
-		(unsigned long)task_stack_page(next_p) + THREAD_SIZE);
-
 	/*
 	 * Now maybe reload the debug registers and handle I/O bitmaps
 	 */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 50e547eac8cd..023cccf5a4ae 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -792,8 +792,6 @@ void common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	clear_tsk_thread_flag(idle, TIF_FORK);
 	initial_gs = per_cpu_offset(cpu);
 #endif
-	per_cpu(kernel_stack, cpu) =
-		(unsigned long)task_stack_page(idle) + THREAD_SIZE;
 }
 
 /*
-- 
2.16.2
