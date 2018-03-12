Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520825206-2-3470985175208353555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES sk.us-asciiro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825205; b=SlYcsAG0OsgAx1mPvog8By8lfgA8GXqWrNeDwgu4iOJhZH0
    cYNnDbjGaM+UHQLaMmclzNMLhBFCWFJC0ZZ9vKi0vhCV7ioX9rLcp2sjCOX5ykMe
    dh+0xps4u3x12N5jVp0BuLr4n3TfyKG9wOlil0PlX8tf9Uu8SFB7s0H4imM8UJEQ
    z1nTWHvuYf9gRCb8aS6sfFu3SrSSSUiSzxHqa+ImDf2iJ7Gd/DRox8oa8WUcwPt5
    V43mSAvKMPe+oHhM2U/ZCmAP/xb7CltGD6Mv7XwyzzQyoIFy4c7gEQzVMzO52qsS
    upY9Yz205VYwo9yKK4Oo+DCQayhoyLUfFjydxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825205; bh=4sEFx3SiZA14+N212f6
    YRD0Z9tdqsleZYsbWf0vJ7fQ=; b=TtyF/vqFqIPPthDSidjO0VRAewzpQtbZMhX
    EGfdsfKovlDm19SgqOW7hBmXaeeTeRjMQQS2FkcwG1i1+Ry8d6vJAqQAP/2LJWTA
    O8pMPN4P8hCuELqp0reXxCI+2NuIs0bQUdQX5Zdxva9sQgRSC7/L9V5/jN8URSii
    k21RECjUZ1NHhksCDTuUbVHS5g7JAOtZWTXp2/yHlsKe8ofycVWkJoqGli+NWN73
    zvDzXl2sXn3359aK0ZlghoG/trxMHWvfr8JjN+8+cMaEfqZJrFQ4/yfSS340xkYC
    LPtfKwghM+5QtXc5Dx0JbyZBT77iYVpRPwULmXA7ONr4DLnSzzw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S932837AbeCLDZ3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:25:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41225 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932680AbeCLDHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Marcelo Tosatti" <mtosatti@redhat.com>,
        "Avi Kivity" <avi@redhat.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.185130457@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 030/104] KVM: VMX: Make use of asm.h
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

commit b188c81f2e1a188ddda6a3d353e5b546c30a9b90 upstream.

Use macros for bitness-insensitive register names, instead of
rolling our own.

Signed-off-by: Avi Kivity <avi@redhat.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/vmx.c | 69 ++++++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6130,14 +6130,6 @@ static void atomic_switch_perf_msrs(stru
 					msrs[i].host);
 }
 
-#ifdef CONFIG_X86_64
-#define R "r"
-#define Q "q"
-#else
-#define R "e"
-#define Q "l"
-#endif
-
 static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -6191,30 +6183,30 @@ static void __noclone vmx_vcpu_run(struc
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
 		/* Store host registers */
-		"push %%"R"dx; push %%"R"bp;"
-		"push %%"R"cx \n\t" /* placeholder for guest rcx */
-		"push %%"R"cx \n\t"
-		"cmp %%"R"sp, %c[host_rsp](%0) \n\t"
+		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
+		"push %%" _ASM_CX " \n\t" /* placeholder for guest rcx */
+		"push %%" _ASM_CX " \n\t"
+		"cmp %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
 		"je 1f \n\t"
-		"mov %%"R"sp, %c[host_rsp](%0) \n\t"
+		"mov %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
 		__ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"
 		"1: \n\t"
 		/* Reload cr2 if changed */
-		"mov %c[cr2](%0), %%"R"ax \n\t"
-		"mov %%cr2, %%"R"dx \n\t"
-		"cmp %%"R"ax, %%"R"dx \n\t"
+		"mov %c[cr2](%0), %%" _ASM_AX " \n\t"
+		"mov %%cr2, %%" _ASM_DX " \n\t"
+		"cmp %%" _ASM_AX ", %%" _ASM_DX " \n\t"
 		"je 2f \n\t"
-		"mov %%"R"ax, %%cr2 \n\t"
+		"mov %%" _ASM_AX", %%cr2 \n\t"
 		"2: \n\t"
 		/* Check if vmlaunch of vmresume is needed */
 		"cmpl $0, %c[launched](%0) \n\t"
 		/* Load guest registers.  Don't clobber flags. */
-		"mov %c[rax](%0), %%"R"ax \n\t"
-		"mov %c[rbx](%0), %%"R"bx \n\t"
-		"mov %c[rdx](%0), %%"R"dx \n\t"
-		"mov %c[rsi](%0), %%"R"si \n\t"
-		"mov %c[rdi](%0), %%"R"di \n\t"
-		"mov %c[rbp](%0), %%"R"bp \n\t"
+		"mov %c[rax](%0), %%" _ASM_AX " \n\t"
+		"mov %c[rbx](%0), %%" _ASM_BX " \n\t"
+		"mov %c[rdx](%0), %%" _ASM_DX " \n\t"
+		"mov %c[rsi](%0), %%" _ASM_SI " \n\t"
+		"mov %c[rdi](%0), %%" _ASM_DI " \n\t"
+		"mov %c[rbp](%0), %%" _ASM_BP " \n\t"
 #ifdef CONFIG_X86_64
 		"mov %c[r8](%0),  %%r8  \n\t"
 		"mov %c[r9](%0),  %%r9  \n\t"
@@ -6225,7 +6217,7 @@ static void __noclone vmx_vcpu_run(struc
 		"mov %c[r14](%0), %%r14 \n\t"
 		"mov %c[r15](%0), %%r15 \n\t"
 #endif
-		"mov %c[rcx](%0), %%"R"cx \n\t" /* kills %0 (ecx) */
+		"mov %c[rcx](%0), %%" _ASM_CX " \n\t" /* kills %0 (ecx) */
 
 		/* Enter guest mode */
 		"jne .Llaunched \n\t"
@@ -6234,15 +6226,15 @@ static void __noclone vmx_vcpu_run(struc
 		".Llaunched: " __ex(ASM_VMX_VMRESUME) "\n\t"
 		".Lkvm_vmx_return: "
 		/* Save guest registers, load host registers, keep flags */
-		"mov %0, %c[wordsize](%%"R"sp) \n\t"
+		"mov %0, %c[wordsize](%%" _ASM_SP ") \n\t"
 		"pop %0 \n\t"
-		"mov %%"R"ax, %c[rax](%0) \n\t"
-		"mov %%"R"bx, %c[rbx](%0) \n\t"
-		"pop"Q" %c[rcx](%0) \n\t"
-		"mov %%"R"dx, %c[rdx](%0) \n\t"
-		"mov %%"R"si, %c[rsi](%0) \n\t"
-		"mov %%"R"di, %c[rdi](%0) \n\t"
-		"mov %%"R"bp, %c[rbp](%0) \n\t"
+		"mov %%" _ASM_AX ", %c[rax](%0) \n\t"
+		"mov %%" _ASM_BX ", %c[rbx](%0) \n\t"
+		__ASM_SIZE(pop) " %c[rcx](%0) \n\t"
+		"mov %%" _ASM_DX ", %c[rdx](%0) \n\t"
+		"mov %%" _ASM_SI ", %c[rsi](%0) \n\t"
+		"mov %%" _ASM_DI ", %c[rdi](%0) \n\t"
+		"mov %%" _ASM_BP ", %c[rbp](%0) \n\t"
 #ifdef CONFIG_X86_64
 		"mov %%r8,  %c[r8](%0) \n\t"
 		"mov %%r9,  %c[r9](%0) \n\t"
@@ -6253,10 +6245,10 @@ static void __noclone vmx_vcpu_run(struc
 		"mov %%r14, %c[r14](%0) \n\t"
 		"mov %%r15, %c[r15](%0) \n\t"
 #endif
-		"mov %%cr2, %%"R"ax   \n\t"
-		"mov %%"R"ax, %c[cr2](%0) \n\t"
+		"mov %%cr2, %%" _ASM_AX "   \n\t"
+		"mov %%" _ASM_AX ", %c[cr2](%0) \n\t"
 
-		"pop  %%"R"bp; pop  %%"R"dx \n\t"
+		"pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
 		"setbe %c[fail](%0) \n\t"
 	      : : "c"(vmx), "d"((unsigned long)HOST_RSP),
 		[launched]"i"(offsetof(struct vcpu_vmx, __launched)),
@@ -6282,9 +6274,11 @@ static void __noclone vmx_vcpu_run(struc
 		[cr2]"i"(offsetof(struct vcpu_vmx, vcpu.arch.cr2)),
 		[wordsize]"i"(sizeof(ulong))
 	      : "cc", "memory"
-		, R"ax", R"bx", R"di", R"si"
 #ifdef CONFIG_X86_64
+		, "rax", "rbx", "rdi", "rsi"
 		, "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
+#else
+		, "eax", "ebx", "edi", "esi"
 #endif
 	      );
 
@@ -6320,9 +6314,6 @@ static void __noclone vmx_vcpu_run(struc
 	vmx_complete_interrupts(vmx);
 }
 
-#undef R
-#undef Q
-
 static void vmx_load_vmcs01(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
