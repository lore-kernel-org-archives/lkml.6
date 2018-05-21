Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526938177-2-9724406902007753350
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
    1526938176; b=iBrPCt0dIs9yvo7CFN/u3biQeEvtWw2Ye7CQN6n3WH6xaKdSNL
    2wzo3DL2PUjy8Uuglk86UyuIkq/EaFLaHP3SWtOCxLde0iNNJzFZ3zGFkose22D4
    YhfYih7jh7AbvruVm0wLle+N84CYfelA4sq1PIybu8vZbncKgEDPevPRE6cUxGR9
    aNwB53gYYbZVwtUfwrABnoaTfa807m7WrFl2o1XEAJftbkIEsFPaJeW0A4nBnSgL
    guMGUi7tEMenCnG8IKRpPGYtx35OBzHcVy8/r/woVVJirEkQ6gCC5UT3ihYUAZXS
    Fa1q7X2dOxM1Aue9hDH8o+eu1bGGHp5c8EEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938176; bh=uIO+mwcBbyTQGSKFfP3Rof/+CsA5rL
    ypLeAu4T1ueTE=; b=J260IdP4jF3UsF4BFTH7j+jB32VYBMPwflu+NPApQDflmP
    Z3HhGy/3rYxikBpRVSpYiFzGbCD7fRBw9mB0t3VjgPeNOgdVV1i2+hPbiSEw+wCT
    17VioPLpUhTr9wYOkWSpSgRR8qshP1XXoif0rXJh3Y+h07wi1cVK8yg/RgWruCs2
    z3SvZDS9y2neC1ELWvCP86PCFDJQ1zkTyd03SDhkgaSggZ8INGa3bJF4S3dEk4f+
    kGVftv3045hb+QyprGXafRNTiNR2SgEZ0Skl9Fz5Owi850iErTXsLaOzRFOLYNOq
    WtDgeR6XmeavBO9IFK7sulfW+RG/lLSP/AKqpjzQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=yit7IGlp x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=yit7IGlp x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFEurNjJR6iOqNXTHIXZuYqMrm5ZSWkspheI/xITgV40JanYGNf1MQ5682dp6tEtFlLBqN8+wBJSM0D26rgSKHDXg04s8u12IEyD+I7i/ZRg7TYrmYqH
    o7pa0dHAu8aaF3rI5ObRoinihlQgt44zuX3gL92jofrBwzFP1/64wIbDXvVFS4PX5z1iUTTRaTDJ1QIl++kwYKOMQX+q/YPmVUGFK3Ap09psPmgZEyoNbYOJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=Y8gORIMYy1lJ2uihekQA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeEUV1G (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932495AbeEUV1C (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:27:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.16 100/110] x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL
Date: Mon, 21 May 2018 23:12:37 +0200
Message-Id: <20180521210514.544607886@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit ccbcd2674472a978b48c91c1fbfb66c0ff959f24 upstream

AMD is proposing a VIRT_SPEC_CTRL MSR to handle the Speculative Store
Bypass Disable via MSR_AMD64_LS_CFG so that guests do not have to care
about the bit position of the SSBD bit and thus facilitate migration.
Also, the sibling coordination on Family 17H CPUs can only be done on
the host.

Extend x86_spec_ctrl_set_guest() and x86_spec_ctrl_restore_host() with an
extra argument for the VIRT_SPEC_CTRL MSR.

Hand in 0 from VMX and in SVM add a new virt_spec_ctrl member to the CPU
data structure which is going to be used in later patches for the actual
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/spec-ctrl.h |    9 ++++++---
 arch/x86/kernel/cpu/bugs.c       |   20 ++++++++++++++++++--
 arch/x86/kvm/svm.c               |   11 +++++++++--
 arch/x86/kvm/vmx.c               |    5 +++--
 4 files changed, 36 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -10,10 +10,13 @@
  * the guest has, while on VMEXIT we restore the host view. This
  * would be easier if SPEC_CTRL were architecturally maskable or
  * shadowable for guests but this is not (currently) the case.
- * Takes the guest view of SPEC_CTRL MSR as a parameter.
+ * Takes the guest view of SPEC_CTRL MSR as a parameter and also
+ * the guest's version of VIRT_SPEC_CTRL, if emulated.
  */
-extern void x86_spec_ctrl_set_guest(u64);
-extern void x86_spec_ctrl_restore_host(u64);
+extern void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl,
+				    u64 guest_virt_spec_ctrl);
+extern void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl,
+				       u64 guest_virt_spec_ctrl);
 
 /* AMD specific Speculative Store Bypass MSR data */
 extern u64 x86_amd_ls_cfg_base;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -151,7 +151,15 @@ u64 x86_spec_ctrl_get_default(void)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
-void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl)
+/**
+ * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
 {
 	u64 host = x86_spec_ctrl_base;
 
@@ -168,7 +176,15 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
 
-void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl)
+/**
+ * x86_spec_ctrl_restore_host - Restore host speculation control registers
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
 {
 	u64 host = x86_spec_ctrl_base;
 
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -192,6 +192,12 @@ struct vcpu_svm {
 	} host;
 
 	u64 spec_ctrl;
+	/*
+	 * Contains guest-controlled bits of VIRT_SPEC_CTRL, which will be
+	 * translated into the appropriate L2_CFG bits on the host to
+	 * perform speculative control.
+	 */
+	u64 virt_spec_ctrl;
 
 	u32 *msrpm;
 
@@ -1910,6 +1916,7 @@ static void svm_vcpu_reset(struct kvm_vc
 
 	vcpu->arch.microcode_version = 0x01000065;
 	svm->spec_ctrl = 0;
+	svm->virt_spec_ctrl = 0;
 
 	if (!init_event) {
 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
@@ -5401,7 +5408,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	x86_spec_ctrl_set_guest(svm->spec_ctrl);
+	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5525,7 +5532,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	x86_spec_ctrl_restore_host(svm->spec_ctrl);
+	x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	reload_tss(vcpu);
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9465,9 +9465,10 @@ static void __noclone vmx_vcpu_run(struc
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	x86_spec_ctrl_set_guest(vmx->spec_ctrl);
+	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
+
 	asm(
 		/* Store host registers */
 		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
@@ -9603,7 +9604,7 @@ static void __noclone vmx_vcpu_run(struc
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	x86_spec_ctrl_restore_host(vmx->spec_ctrl);
+	x86_spec_ctrl_restore_host(vmx->spec_ctrl, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
