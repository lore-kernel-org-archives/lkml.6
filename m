Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1741794-1526958802-2-15021616455496910522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526958801; b=X3/QBqS51Fprc3XO+YQEoDt3RNWDqCmDSJusQEfUPgU6Y7qFlV
    WRD8ty66UOmo0Ct7oQqSLXI17lX5m/f5YR+fqXi9eJX/7qakOc+ysre5LjZWTPw5
    nYZvAM/K9VZNgO3BqrNiaCkaf7VYLPZmH/tlg/yCMaGeyBIzO6wLRDWOC2x1o7bl
    Cw8bT6CUnvPUJKWGTD6V4CB18Tc/jXVDwqI29n5jWklPkIxBpWVnKh65+m1YJ0Nf
    /Ir1GRrHSbzQMe+dd+2Scstb1r/qvOKG6hJq0f14/x+LLYW8zcAERJ865XIyGitd
    1Eq9aGGDwsTffuaBF6WeiiQPS0lSr9/RuQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526958801; bh=
    njURIa7PDOVn173k1Ir9mzyw4Whu+QSNVyFtfhEn8u8=; b=fxvw3reOxFz8A1WY
    MarIk3tWD4xUDWWg7aoorkUmYmsFVoVxGVRLWt8qxdUudx87Nuz1m996Cpue8oi/
    L0G+NuKVem3TUAb8GPjQV4vsxGOLI8y+yUV/dC3OPmRCd79Dz8DhkTd3ShNLHgX6
    crAifrFQzP2RFPMEK07MX8+MGTfnysO9+Lv/IDRYphtasDqJjm1p07SghpthfGSP
    YOTlrOkQmpdkecF2KGUTi3n3Z4DoyMjO3NOs5M+enxzsZHYqBCB86/zJaxpiZLN6
    fbxzf9UF+IeyUvwao7BYMUfTUtfSSLdwJtDvZnFJuxOhTa1hY0JXTnf3vKQviS5W
    r7qXQA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE9DPpqDJF7CUogdvp4OU6l0PTjL7a4JY4v51esWX+E98aDMjo+Jfi4sdVbkS5cZyBYB55dUvZSl73PbQEILUaAnxoqipF6mnvXqCS4vF1iFJpNtIMU4
    uTw9QARQGZtQzqnMH42XcJiBX/7wqjvQ6LSxPMkqbvmAfNzZK7PkoVOT0xPj90OeojyWFPj/ubsfI3xlhd3sJuZ6KEGp9OKw5UckEx0lCgeuDQQkPOdll8vD
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8
    a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8 a=CxaZg77CAAAA:8 a=pGLkceISAAAA:8
    a=lGoDwvWgg58GksNul8QA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=HxQw6O0h_v37Y3_G5fB_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeEVDNT (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 23:13:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:55066 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbeEVDNQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 May 2018 23:13:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="41795482"
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH V3 2/3] efi: Introduce efi_queue_work() to queue any efi_runtime_service() on efi_rts_wq
Date: Mon, 21 May 2018 20:13:03 -0700
Message-Id: <1526958784-14688-3-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526958784-14688-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1526958784-14688-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

When a process requests the kernel to execute any efi_runtime_service(),
the requested efi_runtime_service (represented as an identifier) and its
arguments are packed into a struct named efi_runtime_work and queued
onto work queue named efi_rts_wq. The caller then waits until the work
is completed.

Introduce efi_queue_work() that 1. Populates efi_runtime_work 2. Queues
work onto efi_rts_wq and 3. Waits until worker thread returns.

The caller thread has to wait until the worker thread returns, because
it depends on the return status of efi_runtime_service() and, in
specific cases, the arguments populated by efi_runtime_service(). Some
efi_runtime_services() takes a pointer to buffer as an argument and
fills up the buffer with requested data. For instance,
efi_get_variable() and efi_get_next_variable(). Hence, caller process
cannot just post the work and get going.

Some facts about efi_runtime_services():
1. A quick look at all the efi_runtime_services() shows that any
efi_runtime_service() has five or less arguments.
2. An argument of efi_runtime_service() can be a value (of any type) or
a pointer (of any type).
Hence, efi_runtime_work has five void pointers to store these arguments.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Naresh Bhat <naresh.bhat@linaro.org>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 drivers/firmware/efi/runtime-wrappers.c | 80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index ae54870b2788..a9866045ed52 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -1,6 +1,14 @@
 /*
  * runtime-wrappers.c - Runtime Services function call wrappers
  *
+ * Implementation summary:
+ * -----------------------
+ * 1. When user/kernel thread requests to execute efi_runtime_service(),
+ * enqueue work to efi_rts_wq.
+ * 2. Caller thread waits until the work is finished because it's
+ * dependent on the return status and execution of efi_runtime_service().
+ * For instance, get_variable() and get_next_variable().
+ *
  * Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
  *
  * Split off from arch/x86/platform/efi/efi.c
@@ -22,6 +30,8 @@
 #include <linux/mutex.h>
 #include <linux/semaphore.h>
 #include <linux/stringify.h>
+#include <linux/workqueue.h>
+
 #include <asm/efi.h>
 
 /*
@@ -33,6 +43,76 @@
 #define __efi_call_virt(f, args...) \
 	__efi_call_virt_pointer(efi.systab->runtime, f, args)
 
+/* efi_runtime_service() function identifiers */
+enum efi_rts_ids {
+	GET_TIME,
+	SET_TIME,
+	GET_WAKEUP_TIME,
+	SET_WAKEUP_TIME,
+	GET_VARIABLE,
+	GET_NEXT_VARIABLE,
+	SET_VARIABLE,
+	SET_VARIABLE_NONBLOCKING,
+	QUERY_VARIABLE_INFO,
+	QUERY_VARIABLE_INFO_NONBLOCKING,
+	GET_NEXT_HIGH_MONO_COUNT,
+	RESET_SYSTEM,
+	UPDATE_CAPSULE,
+	QUERY_CAPSULE_CAPS,
+};
+
+/*
+ * efi_runtime_work:	Details of EFI Runtime Service work
+ * @func:		EFI Runtime Service function identifier
+ * @arg<1-5>:		EFI Runtime Service function arguments
+ * @status:		Status of executing EFI Runtime Service
+ */
+struct efi_runtime_work {
+	void *arg1;
+	void *arg2;
+	void *arg3;
+	void *arg4;
+	void *arg5;
+	efi_status_t status;
+	struct work_struct work;
+	enum efi_rts_ids efi_rts_id;
+};
+
+/*
+ * efi_queue_work:	Queue efi_runtime_service() and wait until it's done
+ * @rts:		efi_runtime_service() function identifier
+ * @rts_arg<1-5>:	efi_runtime_service() function arguments
+ *
+ * Accesses to efi_runtime_services() are serialized by a binary
+ * semaphore (efi_runtime_lock) and caller waits until the work is
+ * finished, hence _only_ one work is queued at a time and the queued
+ * work gets flushed.
+ */
+#define efi_queue_work(_rts, _arg1, _arg2, _arg3, _arg4, _arg5)	\
+({									\
+	struct efi_runtime_work efi_rts_work;				\
+	efi_rts_work.status = EFI_ABORTED;				\
+									\
+	INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);		\
+	efi_rts_work.arg1 = _arg1;					\
+	efi_rts_work.arg2 = _arg2;					\
+	efi_rts_work.arg3 = _arg3;					\
+	efi_rts_work.arg4 = _arg4;					\
+	efi_rts_work.arg5 = _arg5;					\
+	efi_rts_work.efi_rts_id = _rts;					\
+									\
+	/*								\
+	 * queue_work() returns 0 if work was already on queue,         \
+	 * _ideally_ this should never happen.                          \
+	 */								\
+	if (queue_work(efi_rts_wq, &efi_rts_work.work))			\
+		flush_work(&efi_rts_work.work);				\
+	else								\
+		pr_err("Failed to queue work to efi_rts_wq.\n");	\
+									\
+	efi_rts_work.status;						\
+})
+
 void efi_call_virt_check_flags(unsigned long flags, const char *call)
 {
 	unsigned long cur_flags, mismatch;
-- 
2.7.4

