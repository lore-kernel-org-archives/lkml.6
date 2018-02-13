Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513134-2-3376574311179591114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.65', Host='mail-pg0-f65.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513133; b=YcVmFep6K5oj+hjibyk10CHaRXnqZQRfVioP/anPUTtJaxg
    haP1mYvnSi6ttHZoBfwB0n8BI0KWAR3GiLX5jG4XJoggyTp+ICC9GkjUQZVT1XV3
    Idpv4lydxY69EpZGm6E8RUO/mmYnPRBLZlGSaraYtiIHmnmUsjNKRHvX6lwPTgXF
    ODCxE/f2O/UcZqD7aT1okHedijmJ7MjJfby9+ZGzkcyZZ17+/0zm58Xbp8o4LORj
    0vMq4SQ867C+PeX/VM6C1ImoY5JIsyP5LBK7+AAKCMqdRrgrTZeQGdFVcxWGVyjD
    5RwNjjVi6ANaUABz/KC2SJJroJEQ3gUDieQ0u0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513133; bh=lJoFSg86LBdA+bt7PThksaLj2HbzLjZUL0sh4xiCq/o=; b=T
    FdbUv5thHlrdz6HGwIWXyysXvAdKg0sKkhoIbWc/Feh20ReRS8i7xSupfx9CaOIN
    vJlACdSsMWAD4m3WW2jtarcRnVbfXArpI4DR/fqiz/8wZVNVwRJT8T+QIYuHeDiL
    rJvZbtDuWbO9ITAECg29uWsE1pzc5GaTCEFy2DG6AGDewdDD2ioGtOQ1XeMWGYQ4
    Cwko9m1/4Xd+4kQiDNIa2ItbmrqkNIL6a7OZZ/ybm3UbvoMdJ0kLtbsqth1k2jpX
    z+85q8Z+YixVGFrAVN9YBARvuR5ayuNCXDagW/5K4XwMnLcEyVAKV1Qu9UgdcWu4
    9rNAeDpoyPf6D4SI5qEOg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hhICW3Cu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t2zrAbJY;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hhICW3Cu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t2zrAbJY;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225ivm9NW0maA0mbih4eCdONvtQErrixePdXLaU+2m4Ze4mp6QBq579pRAl9Yorr68tN5Xy3Dg==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: green.hu@gmail.com,
	Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v7 19/37] nds32: System calls handling
Date: Tue, 13 Feb 2018 17:09:23 +0800
Message-Id: <d13bf63bd4238f3a87cff66feb75d773e024dc9b.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support for system calls.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/syscall.h     | 188 +++++++++++++++++++++++++++++++++++
 arch/nds32/include/asm/syscalls.h    |  13 +++
 arch/nds32/include/asm/unistd.h      |   6 ++
 arch/nds32/include/uapi/asm/unistd.h |  11 ++
 arch/nds32/kernel/ex-scall.S         |  98 ++++++++++++++++++
 arch/nds32/kernel/sys_nds32.c        |  50 ++++++++++
 arch/nds32/kernel/syscall_table.c    |  17 ++++
 7 files changed, 383 insertions(+)
 create mode 100644 arch/nds32/include/asm/syscall.h
 create mode 100644 arch/nds32/include/asm/syscalls.h
 create mode 100644 arch/nds32/include/asm/unistd.h
 create mode 100644 arch/nds32/include/uapi/asm/unistd.h
 create mode 100644 arch/nds32/kernel/ex-scall.S
 create mode 100644 arch/nds32/kernel/sys_nds32.c
 create mode 100644 arch/nds32/kernel/syscall_table.c

diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
new file mode 100644
index 000000000000..f7e5e86765fe
--- /dev/null
+++ b/arch/nds32/include/asm/syscall.h
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef _ASM_NDS32_SYSCALL_H
+#define _ASM_NDS32_SYSCALL_H	1
+
+#include <linux/err.h>
+struct task_struct;
+struct pt_regs;
+
+/**
+ * syscall_get_nr - find what system call a task is executing
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ *
+ * If @task is executing a system call or is at system call
+ * tracing about to attempt one, returns the system call number.
+ * If @task is not executing a system call, i.e. it's blocked
+ * inside the kernel for a fault or signal, returns -1.
+ *
+ * Note this returns int even on 64-bit machines.  Only 32 bits of
+ * system call number can be meaningful.  If the actual arch value
+ * is 64 bits, this truncates to 32 bits so 0xffffffff means -1.
+ *
+ * It's only valid to call this when @task is known to be blocked.
+ */
+int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->syscallno;
+}
+
+/**
+ * syscall_rollback - roll back registers after an aborted system call
+ * @task:	task of interest, must be in system call exit tracing
+ * @regs:	task_pt_regs() of @task
+ *
+ * It's only valid to call this when @task is stopped for system
+ * call exit tracing (due to TIF_SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
+ * after tracehook_report_syscall_entry() returned nonzero to prevent
+ * the system call from taking place.
+ *
+ * This rolls back the register state in @regs so it's as if the
+ * system call instruction was a no-op.  The registers containing
+ * the system call number and arguments are as they were before the
+ * system call instruction.  This may not be the same as what the
+ * register state looked like at system call entry tracing.
+ */
+void syscall_rollback(struct task_struct *task, struct pt_regs *regs)
+{
+	regs->uregs[0] = regs->orig_r0;
+}
+
+/**
+ * syscall_get_error - check result of traced system call
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ *
+ * Returns 0 if the system call succeeded, or -ERRORCODE if it failed.
+ *
+ * It's only valid to call this when @task is stopped for tracing on exit
+ * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ */
+long syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+{
+	unsigned long error = regs->uregs[0];
+	return IS_ERR_VALUE(error) ? error : 0;
+}
+
+/**
+ * syscall_get_return_value - get the return value of a traced system call
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ *
+ * Returns the return value of the successful system call.
+ * This value is meaningless if syscall_get_error() returned nonzero.
+ *
+ * It's only valid to call this when @task is stopped for tracing on exit
+ * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ */
+long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->uregs[0];
+}
+
+/**
+ * syscall_set_return_value - change the return value of a traced system call
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ * @error:	negative error code, or zero to indicate success
+ * @val:	user return value if @error is zero
+ *
+ * This changes the results of the system call that user mode will see.
+ * If @error is zero, the user sees a successful system call with a
+ * return value of @val.  If @error is nonzero, it's a negated errno
+ * code; the user sees a failed system call with this errno code.
+ *
+ * It's only valid to call this when @task is stopped for tracing on exit
+ * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ */
+void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
+			      int error, long val)
+{
+	regs->uregs[0] = (long)error ? error : val;
+}
+
+/**
+ * syscall_get_arguments - extract system call parameter values
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ * @i:		argument index [0,5]
+ * @n:		number of arguments; n+i must be [1,6].
+ * @args:	array filled with argument values
+ *
+ * Fetches @n arguments to the system call starting with the @i'th argument
+ * (from 0 through 5).  Argument @i is stored in @args[0], and so on.
+ * An arch inline version is probably optimal when @i and @n are constants.
+ *
+ * It's only valid to call this when @task is stopped for tracing on
+ * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * It's invalid to call this with @i + @n > 6; we only support system calls
+ * taking up to 6 arguments.
+ */
+#define SYSCALL_MAX_ARGS 6
+void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+			   unsigned int i, unsigned int n, unsigned long *args)
+{
+	if (n == 0)
+		return;
+	if (i + n > SYSCALL_MAX_ARGS) {
+		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
+		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
+		pr_warning("%s called with max args %d, handling only %d\n",
+			   __func__, i + n, SYSCALL_MAX_ARGS);
+		memset(args_bad, 0, n_bad * sizeof(args[0]));
+		memset(args_bad, 0, n_bad * sizeof(args[0]));
+	}
+
+	if (i == 0) {
+		args[0] = regs->orig_r0;
+		args++;
+		i++;
+		n--;
+	}
+
+	memcpy(args, &regs->uregs[0] + i, n * sizeof(args[0]));
+}
+
+/**
+ * syscall_set_arguments - change system call parameter value
+ * @task:	task of interest, must be in system call entry tracing
+ * @regs:	task_pt_regs() of @task
+ * @i:		argument index [0,5]
+ * @n:		number of arguments; n+i must be [1,6].
+ * @args:	array of argument values to store
+ *
+ * Changes @n arguments to the system call starting with the @i'th argument.
+ * Argument @i gets value @args[0], and so on.
+ * An arch inline version is probably optimal when @i and @n are constants.
+ *
+ * It's only valid to call this when @task is stopped for tracing on
+ * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * It's invalid to call this with @i + @n > 6; we only support system calls
+ * taking up to 6 arguments.
+ */
+void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
+			   unsigned int i, unsigned int n,
+			   const unsigned long *args)
+{
+	if (n == 0)
+		return;
+
+	if (i + n > SYSCALL_MAX_ARGS) {
+		pr_warn("%s called with max args %d, handling only %d\n",
+			__func__, i + n, SYSCALL_MAX_ARGS);
+		n = SYSCALL_MAX_ARGS - i;
+	}
+
+	if (i == 0) {
+		regs->orig_r0 = args[0];
+		args++;
+		i++;
+		n--;
+	}
+
+	memcpy(&regs->uregs[0] + i, args, n * sizeof(args[0]));
+}
+#endif /* _ASM_NDS32_SYSCALL_H */
diff --git a/arch/nds32/include/asm/syscalls.h b/arch/nds32/include/asm/syscalls.h
new file mode 100644
index 000000000000..78778ecff60c
--- /dev/null
+++ b/arch/nds32/include/asm/syscalls.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_NDS32_SYSCALLS_H
+#define __ASM_NDS32_SYSCALLS_H
+
+asmlinkage long sys_cacheflush(unsigned long addr, unsigned long len, unsigned int op);
+asmlinkage long sys_fadvise64_64_wrapper(int fd, int advice, loff_t offset, loff_t len);
+asmlinkage long sys_rt_sigreturn_wrapper(void);
+
+#include <asm-generic/syscalls.h>
+
+#endif /* __ASM_NDS32_SYSCALLS_H */
diff --git a/arch/nds32/include/asm/unistd.h b/arch/nds32/include/asm/unistd.h
new file mode 100644
index 000000000000..b586a2862beb
--- /dev/null
+++ b/arch/nds32/include/asm/unistd.h
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#define __ARCH_WANT_SYS_CLONE
+
+#include <uapi/asm/unistd.h>
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..6e95901cabe3
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#define __ARCH_WANT_SYNC_FILE_RANGE2
+
+/* Use the standard ABI for syscalls */
+#include <asm-generic/unistd.h>
+
+/* Additional NDS32 specific syscalls. */
+#define __NR_cacheflush		(__NR_arch_specific_syscall)
+__SYSCALL(__NR_cacheflush, sys_cacheflush)
diff --git a/arch/nds32/kernel/ex-scall.S b/arch/nds32/kernel/ex-scall.S
new file mode 100644
index 000000000000..36aa87ecdabd
--- /dev/null
+++ b/arch/nds32/kernel/ex-scall.S
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+#include <asm/assembler.h>
+#include <asm/nds32.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/current.h>
+
+/*
+ * $r0 = previous task_struct,
+ * $r1 = next task_struct,
+ * previous and next are guaranteed not to be the same.
+ */
+
+ENTRY(__switch_to)
+
+	la	$p0, __entry_task
+	sw	$r1, [$p0]
+	move	$p1, $r0
+	addi	$p1, $p1, #THREAD_CPU_CONTEXT
+	smw.bi 	$r6, [$p1], $r14, #0xb		! push r6~r14, fp, lp, sp
+	move	$r25, $r1
+	addi	$r1, $r1, #THREAD_CPU_CONTEXT
+	lmw.bi 	$r6, [$r1], $r14, #0xb		! pop r6~r14, fp, lp, sp
+	ret
+
+
+#define tbl $r8
+
+/*
+ * $r7 will be writen as syscall nr
+ */
+	.macro	get_scno
+	lwi	$r7, [$sp + R15_OFFSET]
+	swi	$r7, [$sp + SYSCALLNO_OFFSET]
+	.endm
+
+	.macro	updateipc
+	addi	$r17, $r13, #4				! $r13 is $IPC
+	swi	$r17, [$sp + IPC_OFFSET]
+	.endm
+
+ENTRY(eh_syscall)
+	updateipc
+
+	get_scno
+	gie_enable
+
+	lwi	$p0, [tsk+#TSK_TI_FLAGS]		! check for syscall tracing
+
+	andi	$p1, $p0, #_TIF_WORK_SYSCALL_ENTRY	! are we tracing syscalls?
+	bnez	$p1, __sys_trace
+
+	la	$lp, ret_fast_syscall		! return address
+jmp_systbl:
+	addi	$p1, $r7, #-__NR_syscalls	! syscall number of syscall instruction is guarded by addembler
+	bgez	$p1, _SCNO_EXCEED		! call sys_* routine
+	la	tbl, sys_call_table		! load syscall table pointer
+	slli	$p1, $r7, #2
+	add	$p1, tbl, $p1
+	lwi	$p1, [$p1]
+	jr	$p1				! no return
+
+_SCNO_EXCEED:
+	ori	$r0, $r7, #0
+        ori	$r1, $sp, #0
+	b	bad_syscall
+
+/*
+ * This is the really slow path.  We're going to be doing
+ * context switches, and waiting for our parent to respond.
+ */
+__sys_trace:
+	move	$r0, $sp
+	bal	syscall_trace_enter
+	move	$r7, $r0
+	la	$lp, __sys_trace_return		! return address
+
+	addi    $p1, $r7, #1
+	beqz    $p1, ret_slow_syscall		! fatal signal is pending
+
+	addi	$p1, $sp, #R0_OFFSET		! pointer to regs
+	lmw.bi	$r0, [$p1], $r5			! have to reload $r0 - $r5
+	b	jmp_systbl
+
+__sys_trace_return:
+	swi	$r0, [$sp+#R0_OFFSET]		! T: save returned $r0
+	move	$r0, $sp			! set pt_regs for syscall_trace_leave
+	bal	syscall_trace_leave
+	b	ret_slow_syscall
+
+ENTRY(sys_rt_sigreturn_wrapper)
+	addi	$r0, $sp, #0
+	b	sys_rt_sigreturn
+ENDPROC(sys_rt_sigreturn_wrapper)
diff --git a/arch/nds32/kernel/sys_nds32.c b/arch/nds32/kernel/sys_nds32.c
new file mode 100644
index 000000000000..9de93ab4c52b
--- /dev/null
+++ b/arch/nds32/kernel/sys_nds32.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+
+#include <asm/cachectl.h>
+#include <asm/proc-fns.h>
+
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
+	       unsigned long, prot, unsigned long, flags,
+	       unsigned long, fd, unsigned long, pgoff)
+{
+	if (pgoff & (~PAGE_MASK >> 12))
+		return -EINVAL;
+
+	return sys_mmap_pgoff(addr, len, prot, flags, fd,
+			      pgoff >> (PAGE_SHIFT - 12));
+}
+
+SYSCALL_DEFINE4(fadvise64_64_wrapper,int, fd, int, advice, loff_t, offset,
+					 loff_t, len)
+{
+	return sys_fadvise64_64(fd, offset, len, advice);
+}
+
+SYSCALL_DEFINE3(cacheflush, unsigned int, start, unsigned int, end, int, cache)
+{
+	struct vm_area_struct *vma;
+	bool flushi = true, wbd = true;
+
+	vma = find_vma(current->mm, start);
+	if (!vma)
+		return -EFAULT;
+	switch (cache) {
+	case ICACHE:
+		wbd = false;
+		break;
+	case DCACHE:
+		flushi = false;
+		break;
+	case BCACHE:
+		break;
+	default:
+		return -EINVAL;
+	}
+	cpu_cache_wbinval_range_check(vma, start, end, flushi, wbd);
+
+	return 0;
+}
diff --git a/arch/nds32/kernel/syscall_table.c b/arch/nds32/kernel/syscall_table.c
new file mode 100644
index 000000000000..7879c061b87f
--- /dev/null
+++ b/arch/nds32/kernel/syscall_table.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/syscalls.h>
+#include <linux/signal.h>
+#include <linux/unistd.h>
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call) [nr] = (call),
+
+#define sys_rt_sigreturn sys_rt_sigreturn_wrapper
+#define sys_fadvise64_64 sys_fadvise64_64_wrapper
+void *sys_call_table[__NR_syscalls] __aligned(8192) = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
2.16.1
