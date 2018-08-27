Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C781C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D28208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dj+yn1go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D28208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeH0Wp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:45:59 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:36453 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeH0Wp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:45:59 -0400
Received: by mail-qt0-f201.google.com with SMTP id v52-v6so32481qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h/6ixY6QI1yfOfWRaVjlfHVsrSranIFCSVplWqXXOCA=;
        b=dj+yn1go6eAJ6NCYbT0zvyQRjeNndmpEB1PqdwqATXZFeI3ATHAmTrlNYxhad3/nvh
         KKRGN1CrdFRyhK77OgqwC1YR/pvMsHRxLQeJf++WVFMHzp2RAN19P4r0RShWyVgIZ/pX
         m75bFooEs2zmeaqXS2CbyhUZqETK0Q8Fg+StzpizGXbm5bREI5Sqt+Fbnn+/pmtTrNjQ
         wV1kWGhv40DXjkyXblD7p0wbO0YQIkrNbE7Lh9+/prhbsHMDkBToyt+7/ifB/iT7BjSi
         YLjPFlSAx0CxlCWLkU8jgtz/4TuTxwI5L9fEYeyAlBwhe2HTwKV6wHJpnYcZ0MqT7YAH
         PUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h/6ixY6QI1yfOfWRaVjlfHVsrSranIFCSVplWqXXOCA=;
        b=OWGluMQEkHAHduC0DcLItqorRk1arefE6q9Ejrml7wEVNZS1FLdH3K2nhQTsIinSIV
         gWAOt4jZiL2mcpZAUaU28l6xGtP9NqfhcraA1Y8JISFXvDwAHqIhZMlZlU1xfN5TMpxc
         b/TBMKO2jtluDnSD7S8g2gnrY31YyqIShen6swSy02td2Fu4EiG3x+GTrDj6/bsAHCV+
         E/02TYPo/9Qf2NmyV9BB02SiTV3u/0RhsmdUoVAGhUxtNnRYLpZUbNxE43EK/ACauSpZ
         pDPUp+21EfhtL/WW8HRmfFXXvsS1lRTIOlAITiKq95Pk/UPV9kcJJuq8q+lUHD8W0lnn
         VhGA==
X-Gm-Message-State: APzg51BgzZL+HZqU7tIeqw+r0pIU4Jm2D9oC1wNTuX1f/a9ytuW+YXrk
        VO6J4z6phv+MLabVlndVZAJgu3M/Cg==
X-Google-Smtp-Source: ANB0VdYpJdcHW7TpW9fR8qpkQVL+Og5+F11cz5JfU4F2j2tjJIv2638ZajLElm+TdisTmEt72IJf37dpZQ==
X-Received: by 2002:a0c:8863:: with SMTP id 32-v6mr8503517qvm.49.1535396288713;
 Mon, 27 Aug 2018 11:58:08 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:56:30 +0200
In-Reply-To: <20180827185631.163506-1-jannh@google.com>
Message-Id: <20180827185631.163506-7-jannh@google.com>
Mime-Version: 1.0
References: <20180827185631.163506-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v2 6/7] x86: BUG() when uaccess helpers fault on kernel addresses
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        linux-edac@vger.kernel.org
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
 arch/x86/mm/extable.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h |  6 +++++
 mm/maccess.c          |  6 +++++
 3 files changed, 70 insertions(+)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 4110cca93a08..28298b4e5080 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -112,10 +112,66 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
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
 				  unsigned long fault_addr)
 {
+	if (bogus_uaccess(regs, trapnr, fault_addr))
+		return false;
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
 }
@@ -125,6 +181,8 @@ __visible bool ex_handler_ext(const struct exception_table_entry *fixup,
 			      struct pt_regs *regs, int trapnr,
 			      unsigned long fault_addr)
 {
+	if (bogus_uaccess(regs, trapnr, fault_addr))
+		return false;
 	/* Special hack for uaccess_err */
 	current->thread.uaccess_err = 1;
 	regs->ip = ex_fixup_addr(fixup);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 00de3e950dd4..7ea3f4afc0ee 100644
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

