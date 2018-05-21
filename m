Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937606-2-3593866762582324299
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
    1526937605; b=dezLcGjGEfY9x4n0/Wvi/RHTMtDC+t1xVtkPJxORg5TfEq0AiO
    Gyk56VzpW4zF72rBTRt8S4ArqTxs226Cty24tnSto4DmS8lyCBKMpsh+q0k5pbP0
    TR7muALTarYKoKrJ1K/U+Oj1+P4Gy0iE7zk/zTHxAIhM/RJsvPVI7Cq+6sx6FGDC
    pZSMSRtraeeXrBIOt4GXMlDkAcWurfEAhOkUE23a98k6RTlgFXMrQBhuq7gbqeGj
    5GMPkQokHsSebFLPkLYzZaIURVxiu0doo9gk2YBINxOCo5dlXo/AizwlcrOi/m3v
    7y/tvNnDahLeld4UzSoTF6HypwHkGiHMvarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937605; bh=LC/0DJkcgMa26daBo1AckdXfHFo6Yw
    N+cNVy2i/nNQQ=; b=BibyIuok+N337KRWpi4H22Ymqdej/BKR2v3K+vL0VFgqFT
    DPo5Y9UycptmQm3Ff4RfzcXADrDR2O2GLuJ1H7pPRR7MNeWAhSCp9U/6leT4rDuh
    8N/rqB5gyeS/9ZbxN/xi4VQFueW2YPiMngmoMFpWrOdTY4ZlCdIaJSHCae7krOJh
    r3WFB0VAPRl+eW2OUSIOhD8tlnPGFCWsDSRqzC5N7z3dJoOmhZfFwMNBNpGAmCOZ
    i3wwdrDjbrRkhRuq7UIOL8944+2xOeXJtYtCMFesiGpB2rLhlgTiA0Uhew0q0jB4
    rIwQdTKLkjS3El1vz8KtrbQukLAYncvDLmOfZy7A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jLwpEU2S x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jLwpEU2S x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMuu6OMUAwi2WcZi68/dtK62olRGn6lYP6vTynWvfhsSRyeko2O5RN2FrkvrrYQlAma047Q+OoO8lMZup+cOcSLxLa6TLSQ6wRgXsI577rZCtSWuT035
    YknHOJQ4Gohph6tqeaS7FQ6bbv24czPkxjPDBuGamknW35PMYyQ5+Vs80ywpEO8p/DYLKrTg4QFKXaXESOI1O2/pTiKcf8g+S7L9LKlVq0HLmNkDJriB4vIR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=tS2p1tcMxUG_1mGfonEA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753796AbeEUVUC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752654AbeEUVT6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:19:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 52/95] x86/bugs, KVM: Support the combination of guest and host IBRS
Date: Mon, 21 May 2018 23:11:42 +0200
Message-Id: <20180521210458.038162758@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5015,8 +5015,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+	x86_spec_ctrl_set_guest(svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5128,8 +5127,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(svm->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9452,8 +9452,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+	x86_spec_ctrl_set_guest(vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -9591,8 +9590,7 @@ static void __noclone vmx_vcpu_run(struc
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(vmx->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
