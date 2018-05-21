Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1306010-1526937333-2-15856071716393161093
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
    1526937332; b=V2ZAzlNuk4/3tYWd06B3XPYesjHDxcjl2AlQ/NnYJA7Q8HkZLd
    2kie3uHJgEvUqNdY0eNW3iuDdcs0GG3NoFOrkGMFcVgkXHYkfxNzcVK0G4xQX07y
    m6nBjKwW9jwbIV/pgBOZeTTM0xhgotIzc8t/eRtFz3+qwJnxhtwT+8MU8Px26oXg
    h30f/HLABuCQps0/PHzgaF03RtRKlK7rqG0Nk6eNyiCW+Q7tICQ/op60LMUGlrvw
    RQ8o0gk0mVB1A5NaLxKj2Nr7KZme27v7223paz0smXn2VIKpcXhzMMz984FP2cIW
    KEnga3hgRnRvPMR7Tu+qZM6rLTBdUAE2u6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937332; bh=zDsMiFX9eAzhUX7JAgV2ShkYS1biHt
    vRaHssp0o1zAw=; b=N6M7piy64DxkokiuntYvMMkhQPO5kCab/H9MQ44dK3eXYa
    rkdQK+r7XZKtTwpWbecjOX6vkbOCE5eX63TAqQA3iltOASg2s/1DTlwikwO9XXsy
    Wd0SjTIGkLuO0b1aXKuVnBdnMziIIffUMNp/DNYpWFDdC2t7RxBRtDsEf7gpfoAa
    ryWvqcNUttUT7ukh4LHPBoAQ4cPaTeoLS20JjITS5A95u/iu9X3LqRAYYR1SxxvU
    MAsgWrKdJYPP1sCRBM4ABGhO/IMobATUxQHC/vg9LNbiwJalISIkVcKAAy22df6z
    HTTVKVZjP6qHG9cOFOBMY5Qatsq+xfY8FZk9vUPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=IeoySHms x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=IeoySHms x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBQ7TP0RSJPx3S5gYkrVKUOvQvbGyEnjYG/TQCmX2mwOqOLUDJ6g+lpxn9GOClTecTfbs4Au1ghEiHXZRvZtzTNI7Zb9hlESqZiXesFXiXPlWKPI/Eic
    5mI2+QrlF6Jk1Qw64Tm+OxwOMjdaAl21xqsqHhfyjoGlJ2iDfxAWz2vj6Pd9IniGGBtU0QQcERJUg9hE326U9Nx9WEcECehcSsBVwh2mIlWPt2GawdEZqGq/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=pBOR-ozoAAAA:8 a=ag1SF4gXAAAA:8
    a=tS2p1tcMxUG_1mGfonEA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeEUVP2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbeEUVPZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:15:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 40/87] x86/bugs, KVM: Support the combination of guest and host IBRS
Date: Mon, 21 May 2018 23:11:16 +0200
Message-Id: <20180521210424.216683415@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
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
@@ -122,6 +122,24 @@ u64 x86_spec_ctrl_get_default(void)
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
@@ -4917,8 +4917,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+	x86_spec_ctrl_set_guest(svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5030,8 +5029,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(svm->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8916,8 +8916,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+	x86_spec_ctrl_set_guest(vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -9055,8 +9054,7 @@ static void __noclone vmx_vcpu_run(struc
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(vmx->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
