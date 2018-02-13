Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513153-2-5810159856569080455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.68', Host='mail-pl0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513152; b=Wuq0uiR55nmCtaKrYLRwUKs6e5f9lqCLgy4/VRNtiSAR2Zf
    9OIED/Ej83iRqbMK4DudLBxRNSKkOafqqtZX/6lZz5ArVvaTb0hTOqQspEvCLKdq
    gKR5qZiWyqALtHLn8CqjEeETZRCFifWoW++zMbQvTy2feiaWqJGEfMcpEAKBnWqh
    fBQVEfaWqIkO3jAS2Y1oqGmZdVuunSKAeulV1u7mmRgjlB3ppX41hjboriraNOqz
    qwVh8TbHujJPjrUlCUZE3vhXcrUYWw3lag8ora0R+XXz4/iG+Qi4ro59BvyjmVcp
    DXkta9QAKxpg0ymjJHnFnY34svqdaUGkfQuP6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513152; bh=R1JPCEFPTLFOI9Ac1hy5O5YTuxPKBfjYF25DOxLzRq8=; b=o
    7lXPa4BgF64Mmp45Xa8GcRsdU6rsws3/HbaHh/IQ9Mk9T+QUPKsIG6ZvI5q+Jm/P
    ro9TnsOtjpcie0XIYiUUkTjjcechnGX2JgXKDwBtNO5m4WqMez8k+2Xc1mek2YMi
    gjlynV3fpQf9ydyFCwzsG12eqlxstG4mnFYTh8VK+INx6KW4g8nTcJ2J+Tl98LcB
    PRaNkkil/m/karel6EINpnPTh5reb5HVfOM2Yvt2O0t0bHtb1/h/wKWAjoMoDnxC
    2FBgHj14zU11wAO4XHwJUmkB6yWDwhI1PCdukyJfJGEl6m4xUJWwqWohA4SSJKsI
    l+NjOpI8WCzSGx+b6peeQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IUhPMG2G x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QNwmPsdS;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IUhPMG2G x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QNwmPsdS;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227Bj9lNOEjvbWglBmOPykprZuzaQUYnwpsXWhJjCCGxrStYyXU7wT7sJNsyT+TRbXq5YEIhMQ==
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
Subject: [PATCH v7 23/37] nds32: Debugging support
Date: Tue, 13 Feb 2018 17:09:27 +0800
Message-Id: <7f9139c13f0f84091245b8f5c70ba5d4308e8b36.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds ptrace support.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/uapi/asm/ptrace.h |  25 ++++++++
 arch/nds32/kernel/ptrace.c           | 119 +++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 arch/nds32/include/uapi/asm/ptrace.h
 create mode 100644 arch/nds32/kernel/ptrace.c

diff --git a/arch/nds32/include/uapi/asm/ptrace.h b/arch/nds32/include/uapi/asm/ptrace.h
new file mode 100644
index 000000000000..358c99e399d0
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/ptrace.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __UAPI_ASM_NDS32_PTRACE_H
+#define __UAPI_ASM_NDS32_PTRACE_H
+
+#ifndef __ASSEMBLY__
+
+/*
+ * User structures for general purpose register.
+ */
+struct user_pt_regs {
+	long uregs[26];
+	long fp;
+	long gp;
+	long lp;
+	long sp;
+	long ipc;
+	long lb;
+	long le;
+	long lc;
+	long syscallno;
+};
+#endif
+#endif
diff --git a/arch/nds32/kernel/ptrace.c b/arch/nds32/kernel/ptrace.c
new file mode 100644
index 000000000000..eaaf7a999b20
--- /dev/null
+++ b/arch/nds32/kernel/ptrace.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/ptrace.h>
+#include <linux/regset.h>
+#include <linux/tracehook.h>
+#include <linux/elf.h>
+#include <linux/sched/task_stack.h>
+
+enum nds32_regset {
+	REGSET_GPR,
+};
+
+static int gpr_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user * ubuf)
+{
+	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0, -1);
+}
+
+static int gpr_set(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user * ubuf)
+{
+	int err;
+	struct user_pt_regs newregs = task_pt_regs(target)->user_regs;
+
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newregs, 0, -1);
+	if (err)
+		return err;
+
+	task_pt_regs(target)->user_regs = newregs;
+	return 0;
+}
+
+static const struct user_regset nds32_regsets[] = {
+	[REGSET_GPR] = {
+			.core_note_type = NT_PRSTATUS,
+			.n = sizeof(struct user_pt_regs) / sizeof(u32),
+			.size = sizeof(elf_greg_t),
+			.align = sizeof(elf_greg_t),
+			.get = gpr_get,
+			.set = gpr_set}
+};
+
+static const struct user_regset_view nds32_user_view = {
+	.name = "nds32",
+	.e_machine = EM_NDS32,
+	.regsets = nds32_regsets,
+	.n = ARRAY_SIZE(nds32_regsets)
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &nds32_user_view;
+}
+
+void ptrace_disable(struct task_struct *child)
+{
+	user_disable_single_step(child);
+}
+
+/* do_ptrace()
+ *
+ * Provide ptrace defined service.
+ */
+long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
+		 unsigned long data)
+{
+	int ret = -EIO;
+
+	switch (request) {
+	default:
+		ret = ptrace_request(child, request, addr, data);
+		break;
+	}
+
+	return ret;
+}
+
+void user_enable_single_step(struct task_struct *child)
+{
+	struct pt_regs *regs;
+	regs = task_pt_regs(child);
+	regs->ipsw |= PSW_mskHSS;
+	set_tsk_thread_flag(child, TIF_SINGLESTEP);
+}
+
+void user_disable_single_step(struct task_struct *child)
+{
+	struct pt_regs *regs;
+	regs = task_pt_regs(child);
+	regs->ipsw &= ~PSW_mskHSS;
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+}
+
+/* sys_trace()
+ *
+ * syscall trace handler.
+ */
+
+asmlinkage int syscall_trace_enter(struct pt_regs *regs)
+{
+	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
+		if (tracehook_report_syscall_entry(regs))
+			forget_syscall(regs);
+	}
+	return regs->syscallno;
+}
+
+asmlinkage void syscall_trace_leave(struct pt_regs *regs)
+{
+	int step = test_thread_flag(TIF_SINGLESTEP);
+	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall_exit(regs, step);
+
+}
-- 
2.16.1
