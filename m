Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526938377-2-577090587960448608
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938376; b=NQYGymyJJbxWb1pnqqTslPx1w+1n10DUcXn1n26YHFEYe/W91W
    aqidOyf5llJ/xbKCQSxtKRIV+ZI4NLFVLOTeeCzK3jeVUFgbkN2aI7Q+NC07Sneh
    5Y78rDDIHxxNY6/Y4ZKl9xRo9bS+gstg7mC3ZxYI4w737IU5zmhwvDpa/dKhoZFQ
    0Z6HxN0td+BB7yuyt7xERdByGnf300mHLhnxt5sZGOhzh3/L0LpXFhmynVXFcRIN
    EEDZtPtzByZHR2Gm0QAnIzHrAGoalydqfU/kmxQWJ/mMz47COz65tPmA+9R9BB9L
    WHJ1oKsDAwqx8kB4ajXQ51wr0n6ke9smRpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938376; bh=yfrU2E67PkXzbgSI4WaSxOxsYVRtp6
    3Z33as4skqHOI=; b=fQeJUCWGx8qlD9gOrL9FPI8Qi/YIoyLQKBKVV46HNIbxpz
    cLkBMn2yuUH0HkenQa+319rGHvOQe2/wAEfsvBsh5OKbRqrSPyGJv04LaIfPkzK7
    RgiplIUFa3Oz6kPx0Qpb4wIvOJEQwlnIGaDIbXbSfYTuV4dpuaIsDPWBAdpQEO3F
    O00PaK90YNJKfidIWist0d917FmK0qS4Q9Nc5xzCbA1suSk3wGmW5PMqqdUzcY9p
    uItUgFJDr2ctYjWNHLola9ntz0iFmoMlzAJz3uPEMIr/pZXQG7nn2nSvblCCgXp9
    /meRnMQUOJR/CKAvHBGmV0FoUd61LpWhQg+EWksg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=sAMQEFFb x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=sAMQEFFb x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJhLM7MGlPIXUiYOV/KHIXExM2g6dN4ucfu9l5iomMI/5imJ0Eyy5IHceRltp37a83Lal2D+X1LfeXXf5mdEhowegiB+hTGhHK/DNVGu50/2Lupk/U1k
    32gpf7H9MWV5cve4l7XXIz0CxZ8xVVR+AqBa/KcqqgpPSmRLjaD7Rfaeh/tm7wXxH9TqK0hHohkZFP38BXO2BE2Iqk0L8UjQpUOQPtV8TB72PIQt70AISVlX
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=tS2p1tcMxUG_1mGfonEA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeEUV0Q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754444AbeEUV0M (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 066/110] x86/bugs, KVM: Support the combination of guest and host IBRS
Date: Mon, 21 May 2018 23:12:03 +0200
Message-Id: <20180521210512.061816675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 5cf687548705412da47c9cec342fd952d71ed3d5 upstream

A guest may modify the SPEC_CTRL MSR from the value used by the
kernel. Since the kernel doesn't use IBRS, this means a value of zero is
what is needed in the host.

But the 336996-Speculative-Execution-Side-Channel-Mitigations.pdf refers to
the other bits as reserved so the kernel should respect the boot time
SPEC_CTRL value and use that.

This allows to deal with future extensions to the SPEC_CTRL interface if
any at all.

Note: This uses wrmsrl() instead of native_wrmsl(). I does not make any
difference as paravirt will over-write the callq *0xfff.. with the wrmsrl
assembler code.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |   10 ++++++++++
 arch/x86/kernel/cpu/bugs.c           |   18 ++++++++++++++++++
 arch/x86/kvm/svm.c                   |    6 ++----
 arch/x86/kvm/vmx.c                   |    6 ++----
 4 files changed, 32 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -228,6 +228,16 @@ enum spectre_v2_mitigation {
 extern void x86_spec_ctrl_set(u64);
 extern u64 x86_spec_ctrl_get_default(void);
 
+/*
+ * On VMENTER we must preserve whatever view of the SPEC_CTRL MSR
+ * the guest has, while on VMEXIT we restore the host view. This
+ * would be easier if SPEC_CTRL were architecturally maskable or
+ * shadowable for guests but this is not (currently) the case.
+ * Takes the guest view of SPEC_CTRL MSR as a parameter.
+ */
+extern void x86_spec_ctrl_set_guest(u64);
+extern void x86_spec_ctrl_restore_host(u64);
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -123,6 +123,24 @@ u64 x86_spec_ctrl_get_default(void)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
+void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl)
+{
+	if (!boot_cpu_has(X86_FEATURE_IBRS))
+		return;
+	if (x86_spec_ctrl_base != guest_spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
+
+void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl)
+{
+	if (!boot_cpu_has(X86_FEATURE_IBRS))
+		return;
+	if (x86_spec_ctrl_base != guest_spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5401,8 +5401,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+	x86_spec_ctrl_set_guest(svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5514,8 +5513,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(svm->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9468,8 +9468,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+	x86_spec_ctrl_set_guest(vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -9607,8 +9606,7 @@ static void __noclone vmx_vcpu_run(struc
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(vmx->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
