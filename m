Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826107-2-6991368323645766375
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826106; b=Ujj7sBbR/8LuGqiGbtK4RH9ujjEuP1BjRrADCpQqhISgWoh
    7MPClrDmufITRdz2yxj3tTtQHdrOK+DYzObOtKU8OLa+TiXL7SUZsOyq5S/pXAEj
    u5m1ZaxC1M219/Lr2SqTdK8BPDdU6TNmGtXIGCvMYKebY8Okfq/WTdhxkofBmjGh
    oJl18zdanEHARVCIuIaCgiEap0Qmnsmd1t4izP1/RLVAPpN6aWx0gqrPbb54RuX7
    XISXL41M+WJecPVnVfxCSx1r0EFFwYgwTrQbjaaIWd3nsSYvl2kBGIj4jeu5KzCh
    6UwmyrxlM6fvW+NQoDNVDpH/b6dHCKWTUmJASwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826106; bh=PVUN4HRMJm6jzoaHSwS
    t1et5v7ni2nYjMHhQNhGB8fU=; b=kwe+R6nMrL8LnGFgIucx4v/W1u716Zmf7Rq
    2BrbpAxMnMr9cIAfmvXw7Yx5eDrTg3ZYLaxdNqPWxEcKzhgJ1oP1Zx2G94iaA2XQ
    +XaRzuh6vk7xnQ1eql3w4rPshW6uGsMq8qwLskbOG3+6lYVJZu24c8AIMExjMdzz
    LXKnZMeIReJfNbF46/+Hw22FlZISfi4Gz81OWLGHNzvIbzHHWOsrPE2TsV/9LOLz
    R4KhjMAysJXpyWRFgM6U9540C1qOvaaRTpVJOYUNgVglGzPUYvzYLcU7aTJjs2dB
    FoCxrzoQwpCBTJyip1sNfBT4XRNRZe+ybjqqiZ90eh7YSU8FsxQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932784AbeCLD2G (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:28:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41198 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932673AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Marcelo Tosatti" <mtosatti@redhat.com>,
        "Avi Kivity" <avi@redhat.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.731739621@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 031/104] KVM: SVM: Make use of asm.h
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Avi Kivity <avi@redhat.com>

commit 7454766f7bead388251aedee35a478356a7f4e72 upstream.

Use macros for bitness-insensitive register names, instead of
rolling our own.

Signed-off-by: Avi Kivity <avi@redhat.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/svm.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3679,12 +3679,6 @@ static void svm_cancel_injection(struct
 	svm_complete_interrupts(svm);
 }
 
-#ifdef CONFIG_X86_64
-#define R "r"
-#else
-#define R "e"
-#endif
-
 static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -3711,13 +3705,13 @@ static void svm_vcpu_run(struct kvm_vcpu
 	local_irq_enable();
 
 	asm volatile (
-		"push %%"R"bp; \n\t"
-		"mov %c[rbx](%[svm]), %%"R"bx \n\t"
-		"mov %c[rcx](%[svm]), %%"R"cx \n\t"
-		"mov %c[rdx](%[svm]), %%"R"dx \n\t"
-		"mov %c[rsi](%[svm]), %%"R"si \n\t"
-		"mov %c[rdi](%[svm]), %%"R"di \n\t"
-		"mov %c[rbp](%[svm]), %%"R"bp \n\t"
+		"push %%" _ASM_BP "; \n\t"
+		"mov %c[rbx](%[svm]), %%" _ASM_BX " \n\t"
+		"mov %c[rcx](%[svm]), %%" _ASM_CX " \n\t"
+		"mov %c[rdx](%[svm]), %%" _ASM_DX " \n\t"
+		"mov %c[rsi](%[svm]), %%" _ASM_SI " \n\t"
+		"mov %c[rdi](%[svm]), %%" _ASM_DI " \n\t"
+		"mov %c[rbp](%[svm]), %%" _ASM_BP " \n\t"
 #ifdef CONFIG_X86_64
 		"mov %c[r8](%[svm]),  %%r8  \n\t"
 		"mov %c[r9](%[svm]),  %%r9  \n\t"
@@ -3730,20 +3724,20 @@ static void svm_vcpu_run(struct kvm_vcpu
 #endif
 
 		/* Enter guest mode */
-		"push %%"R"ax \n\t"
-		"mov %c[vmcb](%[svm]), %%"R"ax \n\t"
+		"push %%" _ASM_AX " \n\t"
+		"mov %c[vmcb](%[svm]), %%" _ASM_AX " \n\t"
 		__ex(SVM_VMLOAD) "\n\t"
 		__ex(SVM_VMRUN) "\n\t"
 		__ex(SVM_VMSAVE) "\n\t"
-		"pop %%"R"ax \n\t"
+		"pop %%" _ASM_AX " \n\t"
 
 		/* Save guest registers, load host registers */
-		"mov %%"R"bx, %c[rbx](%[svm]) \n\t"
-		"mov %%"R"cx, %c[rcx](%[svm]) \n\t"
-		"mov %%"R"dx, %c[rdx](%[svm]) \n\t"
-		"mov %%"R"si, %c[rsi](%[svm]) \n\t"
-		"mov %%"R"di, %c[rdi](%[svm]) \n\t"
-		"mov %%"R"bp, %c[rbp](%[svm]) \n\t"
+		"mov %%" _ASM_BX ", %c[rbx](%[svm]) \n\t"
+		"mov %%" _ASM_CX ", %c[rcx](%[svm]) \n\t"
+		"mov %%" _ASM_DX ", %c[rdx](%[svm]) \n\t"
+		"mov %%" _ASM_SI ", %c[rsi](%[svm]) \n\t"
+		"mov %%" _ASM_DI ", %c[rdi](%[svm]) \n\t"
+		"mov %%" _ASM_BP ", %c[rbp](%[svm]) \n\t"
 #ifdef CONFIG_X86_64
 		"mov %%r8,  %c[r8](%[svm]) \n\t"
 		"mov %%r9,  %c[r9](%[svm]) \n\t"
@@ -3754,7 +3748,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 		"mov %%r14, %c[r14](%[svm]) \n\t"
 		"mov %%r15, %c[r15](%[svm]) \n\t"
 #endif
-		"pop %%"R"bp"
+		"pop %%" _ASM_BP
 		:
 		: [svm]"a"(svm),
 		  [vmcb]"i"(offsetof(struct vcpu_svm, vmcb_pa)),
@@ -3775,9 +3769,11 @@ static void svm_vcpu_run(struct kvm_vcpu
 		  [r15]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R15]))
 #endif
 		: "cc", "memory"
-		, R"bx", R"cx", R"dx", R"si", R"di"
 #ifdef CONFIG_X86_64
+		, "rbx", "rcx", "rdx", "rsi", "rdi"
 		, "r8", "r9", "r10", "r11" , "r12", "r13", "r14", "r15"
+#else
+		, "ebx", "ecx", "edx", "esi", "edi"
 #endif
 		);
 
@@ -3837,8 +3833,6 @@ static void svm_vcpu_run(struct kvm_vcpu
 	mark_all_clean(svm->vmcb);
 }
 
-#undef R
-
 static void svm_set_cr3(struct kvm_vcpu *vcpu, unsigned long root)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
