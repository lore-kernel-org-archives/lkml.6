Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC9AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D76C2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNI8ai7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D76C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeH2AIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:08:15 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:57278 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeH2AIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:08:14 -0400
Received: by mail-yw1-f73.google.com with SMTP id v144-v6so1235514ywa.23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NAETjXJiOQavioRhqbGq6F/PzukzG2gZMWmeXQhMl80=;
        b=WNI8ai7+Ht1I4l5z/whPDwVOiBvsOplA05YMYRIfqVQlJ2+ZVyhdWGLGefcF6nvULz
         nCaQhDzxjzW/1RYfszsLXUkxKF1jLMdyKSVNYMHCNO1VEq6wqwxJa36FNTF2Kmo4EJX2
         Ud3JqfRBAGMW8Bay70gIBHrrLyqvWK/44JaHTEutpKevrlWy0fpXp9DvqElM++dD5CpV
         3yzoj/oEej7eLabBA8u1LCnCFyvB9xhrAVzX518VG/aoPBezsdzu9QGt4klHxXoIFpha
         jEa9oysLx3Z4VC8nLmpUXst4nVucIHg9NEQh55Jw6m547JLudG8BhbAjgHZuj8ogtTtR
         NvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NAETjXJiOQavioRhqbGq6F/PzukzG2gZMWmeXQhMl80=;
        b=ZI549YWG0Ow5JrR/CROF/JJHdgc7Wbbh4wG01eaK1evhZG8L4DW9ZDs1Vg0gexOmOM
         hH/DWGfUkicjLZbEEQ+hOuSw9HSSV04DfEAxN9J0vauxSYnMgiIwm13dJX8a0NB3IBtP
         8QLekmewFc6Spx99KpSiN0y9hVypUQ5nEmT6HeojggATmmkh5DaKpy4hL5M8w4A8EAK5
         1L1MkOtVB0zJvb7ZKU/D9bK+Ik341puirCl8jh9MZltAITsFJUX/x7zitAsfalk8p1Hq
         JMQEB2GXg3eck/DPHsM1RBJtTGMylG/YL62kYQXIDAd1SQVwec+74MLbq51zJg9Pqam8
         3OBg==
X-Gm-Message-State: APzg51BDcSUl1vuHE0BZcj7knXw4XTtLp+tET6wggBZwfJiWLvHlajP2
        KeX6oFunnps7OZbhxX9B6bnZ2j/4Mg==
X-Google-Smtp-Source: ANB0VdaaJ4oPVmKutihv0mhKCgI76AgUwcB5OOoZyVVLf2Qa5AMoOXkJubQMng4m3eTi+DqXw+8y140DIQ==
X-Received: by 2002:a81:2304:: with SMTP id j4-v6mr941579ywj.101.1535487298418;
 Tue, 28 Aug 2018 13:14:58 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:14:20 +0200
In-Reply-To: <20180828201421.157735-1-jannh@google.com>
Message-Id: <20180828201421.157735-7-jannh@google.com>
Mime-Version: 1.0
References: <20180828201421.157735-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v3 6/7] x86: BUG() when uaccess helpers fault on kernel addresses
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been multiple kernel vulnerabilities that permitted userspace to
pass completely unchecked pointers through to userspace accessors:

 - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
   access_ok() checks")
 - the sg/bsg read/write APIs
 - the infiniband read/write APIs

These don't happen all that often, but when they do happen, it is hard to
test for them properly; and it is probably also hard to discover them with
fuzzing. Even when an unmapped kernel address is supplied to such buggy
code, it just returns -EFAULT instead of doing a proper BUG() or at least
WARN().

This patch attempts to make such misbehaving code a bit more visible by
refusing to do a fixup in the pagefault handler code when a userspace
accessor causes #PF on a kernel address and the current context isn't
whitelisted.

Signed-off-by: Jann Horn <jannh@google.com>
---
v3:
 - whitelist exact_copy_from_user(), at least for now - the alternative
   would be a somewhat complicated refactor (Kees Cook)

 arch/x86/mm/extable.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c        |  2 ++
 include/linux/sched.h |  6 +++++
 mm/maccess.c          |  6 +++++
 4 files changed, 72 insertions(+)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 856fa409c536..6521134057e8 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -117,11 +117,67 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
+/* Helper to check whether a uaccess fault indicates a kernel bug. */
+static bool bogus_uaccess(struct pt_regs *regs, int trapnr,
+			  unsigned long fault_addr)
+{
+	/* This is the normal case: #PF with a fault address in userspace. */
+	if (trapnr == X86_TRAP_PF && fault_addr < TASK_SIZE_MAX)
+		return false;
+
+	/*
+	 * This code can be reached for machine checks, but only if the #MC
+	 * handler has already decided that it looks like a candidate for fixup.
+	 * This e.g. happens when attempting to access userspace memory which
+	 * the CPU can't access because of uncorrectable bad memory.
+	 */
+	if (trapnr == X86_TRAP_MC)
+		return false;
+
+	/*
+	 * There are two remaining exception types we might encounter here:
+	 *  - #PF for faulting accesses to kernel addresses
+	 *  - #GP for faulting accesses to noncanonical addresses
+	 * Complain about anything else.
+	 */
+	if (trapnr != X86_TRAP_PF && trapnr != X86_TRAP_GP) {
+		WARN(1, "unexpected trap %d in uaccess\n", trapnr);
+		return false;
+	}
+
+	/*
+	 * This is a faulting memory access in kernel space, on a kernel
+	 * address, in a usercopy function. This can e.g. be caused by improper
+	 * use of helpers like __put_user and by improper attempts to access
+	 * userspace addresses in KERNEL_DS regions.
+	 * The one (semi-)legitimate exception are probe_kernel_{read,write}(),
+	 * which can be invoked from places like kgdb, /dev/mem (for reading)
+	 * and privileged BPF code (for reading).
+	 * The probe_kernel_*() functions set the kernel_uaccess_faults_ok flag
+	 * to tell us that faulting on kernel addresses, and even noncanonical
+	 * addresses, in a userspace accessor does not necessarily imply a
+	 * kernel bug, root might just be doing weird stuff.
+	 */
+	if (current->kernel_uaccess_faults_ok)
+		return false;
+
+	/* This is bad. Refuse the fixup so that we go into die(). */
+	if (trapnr == X86_TRAP_PF) {
+		pr_emerg("BUG: pagefault on kernel address 0x%lx in non-whitelisted uaccess\n",
+			 fault_addr);
+	} else {
+		pr_emerg("BUG: GPF in non-whitelisted uaccess (non-canonical address?)\n");
+	}
+	return true;
+}
+
 __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 				  struct pt_regs *regs, int trapnr,
 				  unsigned long error_code,
 				  unsigned long fault_addr)
 {
+	if (bogus_uaccess(regs, trapnr, fault_addr))
+		return false;
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
 }
@@ -132,6 +188,8 @@ __visible bool ex_handler_ext(const struct exception_table_entry *fixup,
 			      unsigned long error_code,
 			      unsigned long fault_addr)
 {
+	if (bogus_uaccess(regs, trapnr, fault_addr))
+		return false;
 	/* Special hack for uaccess_err */
 	current->thread.uaccess_err = 1;
 	regs->ip = ex_fixup_addr(fixup);
diff --git a/fs/namespace.c b/fs/namespace.c
index 99186556f8d3..d86830c86ce8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2642,6 +2642,7 @@ static long exact_copy_from_user(void *to, const void __user * from,
 	if (!access_ok(VERIFY_READ, from, n))
 		return n;
 
+	current->kernel_uaccess_faults_ok++;
 	while (n) {
 		if (__get_user(c, f)) {
 			memset(t, 0, n);
@@ -2651,6 +2652,7 @@ static long exact_copy_from_user(void *to, const void __user * from,
 		f++;
 		n--;
 	}
+	current->kernel_uaccess_faults_ok--;
 	return n;
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..56dd65f1be4f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -739,6 +739,12 @@ struct task_struct {
 	unsigned			use_memdelay:1;
 #endif
 
+	/*
+	 * May usercopy functions fault on kernel addresses?
+	 * This is not just a single bit because this can potentially nest.
+	 */
+	unsigned int			kernel_uaccess_faults_ok;
+
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
 	struct restart_block		restart_block;
diff --git a/mm/maccess.c b/mm/maccess.c
index ec00be51a24f..f3416632e5a4 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -30,8 +30,10 @@ long __probe_kernel_read(void *dst, const void *src, size_t size)
 
 	set_fs(KERNEL_DS);
 	pagefault_disable();
+	current->kernel_uaccess_faults_ok++;
 	ret = __copy_from_user_inatomic(dst,
 			(__force const void __user *)src, size);
+	current->kernel_uaccess_faults_ok--;
 	pagefault_enable();
 	set_fs(old_fs);
 
@@ -58,7 +60,9 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
 
 	set_fs(KERNEL_DS);
 	pagefault_disable();
+	current->kernel_uaccess_faults_ok++;
 	ret = __copy_to_user_inatomic((__force void __user *)dst, src, size);
+	current->kernel_uaccess_faults_ok--;
 	pagefault_enable();
 	set_fs(old_fs);
 
@@ -94,11 +98,13 @@ long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
 
 	set_fs(KERNEL_DS);
 	pagefault_disable();
+	current->kernel_uaccess_faults_ok++;
 
 	do {
 		ret = __get_user(*dst++, (const char __user __force *)src++);
 	} while (dst[-1] && ret == 0 && src - unsafe_addr < count);
 
+	current->kernel_uaccess_faults_ok--;
 	dst[-1] = '\0';
 	pagefault_enable();
 	set_fs(old_fs);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

