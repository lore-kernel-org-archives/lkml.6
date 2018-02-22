Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-427748-1519314225-2-3145041410262331301
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519314224; b=Hre8vt+qw/+m0c9xvr6zaPsB9z2IlE0bfegwAaZNRFIn0ya
    W4sFPHpZ4YOrEH2rOlGLFNPq6HGdZq1684gblhpaGkilREdIBN/QfxYSZsNr+B36
    gtw8ik+vfwOXq3moOeWxNNe2zHoZv6MzLxrrLv8br5G6re+PLLGAzzLErpE1LaxL
    UFBPb2CGkK1OVOoagaBEyZoRKM1MfkIU9D1DeRysenCWgzb+gbH44HNKJ5gbOvuT
    OS/dPdPkcYUJNuAfiFjDibRRGV4SE5PkAKIcTbE9rU8QdavlBlsuWD7M91TXuarX
    Dmy1YoeSnvzBxFcxrrw1kPLa3AAUJLkDE4bJVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519314224; bh=4kjL+r+j8pD2WeauUs4sFSwHYh9AqgJoDJQJsTEd9DE=; b=g
    gLxKYdGYa3SangU+rbVmoLtDFQH2GrGlWWKGCLJ0Da/dGdvF06V6aUgH8yiair9p
    PVfCP2PeAoxpeH3iDdiTcS76zk05KH9P/+W2wRpZRwN7pHj48zsW1fHjg6xrRF9p
    oha6EJQTqrQqob8e+ob2F7A7NNwqqV8+8EtXVl2vAxzhglsAhG7V/VgBu0YAjLGu
    N4zF7J4hx8c1WZtaeoAak+Op1iaHkF++9fk8gEvH7RneSe62CnHDvRQHrTE0AlAr
    0/EpmGIQ129xKVUIneLDCZrueBpvSkWkMiYzEXAZziB+AwB4o/lQM+nMsBZOKndh
    AMYmkVRRug2k/yp3EQi2A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=U0VGp4fK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XMokU3Tn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=U0VGp4fK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XMokU3Tn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933064AbeBVPn2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 10:43:28 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51296 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932919AbeBVPnZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 10:43:25 -0500
X-Google-Smtp-Source: AH8x227gT6MLcpNt3AgcyPfICScbKqeaazG87lN3eU/BjqfRA2k+kembTANxMZPgO0/3S5doHAaDsg==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: x86@kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: x86: use native MSR ops for SPEC_CTRL
Date: Thu, 22 Feb 2018 16:43:17 +0100
Message-Id: <20180222154318.20361-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222154318.20361-1-pbonzini@redhat.com>
References: <20180222154318.20361-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Having a paravirt indirect call in the IBRS restore path is not a
good idea, since we are trying to protect from speculative execution
of bogus indirect branch targets.  It is also slower, so use
native_wrmsrl on the vmentry path too.

Fixes: d28b387fb74da95d69d2615732f50cceb38e9a4d
Cc: x86@kernel.org
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Jim Mattson <jmattson@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm.c | 7 ++++---
 arch/x86/kvm/vmx.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b3e488a74828..1598beeda11c 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -49,6 +49,7 @@
 #include <asm/debugreg.h>
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include <asm/virtext.h>
@@ -5355,7 +5356,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * being speculatively taken.
 	 */
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -5465,10 +5466,10 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * save it.
 	 */
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 67b028d8e726..5caeb8dc5bda 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -51,6 +51,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/mmu_context.h>
+#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include "trace.h"
@@ -9453,7 +9454,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * being speculatively taken.
 	 */
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -9589,10 +9590,10 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * save it.
 	 */
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
-- 
1.8.3.1
