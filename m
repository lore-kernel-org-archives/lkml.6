Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABD5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249A42667F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="evOhmuTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249A42667F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965205AbeFZNAb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:00:31 -0400
Received: from m50-138.163.com ([123.125.50.138]:48354 "EHLO m50-138.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964940AbeFZNAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=CSrVdAsoWRS9WDnWpp
        4YvwqD5yWqFKwe2S5B8SRpWwU=; b=evOhmuTNI/XcVP6KYwQ9g3BDp1fIOjTkCn
        DbRXE7mXC0DZ3nNWU7q/R0uCzGBA9GIPg3Ga+vBBYiXjy9OzQ2wZNNnvuDKXlxLf
        8fRJHsyUPQ74/hBiQ/gj21MzKrtlnR10sayvPh8Z6u4NzTUbHowN5IuABPq04a45
        ypcnmUcHI=
Received: from localhost.localdomain (unknown [61.167.60.250])
        by smtp1 (Coremail) with SMTP id C9GowAB3v4_VODJbZyY8BQ--.479S2;
        Tue, 26 Jun 2018 21:00:05 +0800 (CST)
From:   LiuYang <yiqiaoxihui@163.com>
To:     avi@redhat.com
Cc:     mtosatti@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, LiuYang <yiqiaoxihui@163.com>
Subject: [PATCH] KVM: VMX: modify macro definition 'R' to 'R ' because of gcc-5+
Date:   Tue, 26 Jun 2018 20:59:48 +0800
Message-Id: <1530017988-8026-1-git-send-email-yiqiaoxihui@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C9GowAB3v4_VODJbZyY8BQ--.479S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyUtrW3JFy3ury3KF15urg_yoWrWr1fpr
        WfCF42kw4rtF15J3W7Xr13KFZrX3WfCr13Xr9IkF45Gr98Gr1xGr10kFnYk345XFW8Z3Z3
        AF15ZFyq9r45Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvApOUUUUU=
X-Originating-IP: [61.167.60.250]
X-CM-SenderInfo: 51ltxtxr0lx3rl6rljoofrz/1tbiTBVxSlSIZ5AhRAAAss
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 5.4.0 enables raw strings by default and they have higher priority
than macros, thus R is interpreted incorrectly.
Fix it by putting a space between macro R and a string literal.

Signed-off-by: LiuYang <yiqiaoxihui@163.com>
---
 arch/x86/kvm/vmx.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d48ec60..3e4ffaa 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4169,30 +4169,30 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)

	asm(
		/* Store host registers */
-		"push %%"R"dx; push %%"R"bp;"
-		"push %%"R"cx \n\t" /* placeholder for guest rcx */
-		"push %%"R"cx \n\t"
-		"cmp %%"R"sp, %c[host_rsp](%0) \n\t"
+		"push %%"R "dx; push %%"R "bp;"
+		"push %%"R "cx \n\t" /* placeholder for guest rcx */
+		"push %%"R "cx \n\t"
+		"cmp %%"R "sp, %c[host_rsp](%0) \n\t"
		"je 1f \n\t"
-		"mov %%"R"sp, %c[host_rsp](%0) \n\t"
+		"mov %%"R "sp, %c[host_rsp](%0) \n\t"
		__ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"
		"1: \n\t"
		/* Reload cr2 if changed */
-		"mov %c[cr2](%0), %%"R"ax \n\t"
-		"mov %%cr2, %%"R"dx \n\t"
-		"cmp %%"R"ax, %%"R"dx \n\t"
+		"mov %c[cr2](%0), %%"R "ax \n\t"
+		"mov %%cr2, %%"R "dx \n\t"
+		"cmp %%"R "ax, %%"R "dx \n\t"
		"je 2f \n\t"
-		"mov %%"R"ax, %%cr2 \n\t"
+		"mov %%"R "ax, %%cr2 \n\t"
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
+		"mov %c[rax](%0), %%"R "ax \n\t"
+		"mov %c[rbx](%0), %%"R "bx \n\t"
+		"mov %c[rdx](%0), %%"R "dx \n\t"
+		"mov %c[rsi](%0), %%"R "si \n\t"
+		"mov %c[rdi](%0), %%"R "di \n\t"
+		"mov %c[rbp](%0), %%"R "bp \n\t"
 #ifdef CONFIG_X86_64
		"mov %c[r8](%0),  %%r8  \n\t"
		"mov %c[r9](%0),  %%r9  \n\t"
@@ -4203,7 +4203,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
		"mov %c[r14](%0), %%r14 \n\t"
		"mov %c[r15](%0), %%r15 \n\t"
 #endif
-		"mov %c[rcx](%0), %%"R"cx \n\t" /* kills %0 (ecx) */
+		"mov %c[rcx](%0), %%"R "cx \n\t" /* kills %0 (ecx) */

		/* Enter guest mode */
		"jne .Llaunched \n\t"
@@ -4212,15 +4212,15 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
		".Llaunched: " __ex(ASM_VMX_VMRESUME) "\n\t"
		".Lkvm_vmx_return: "
		/* Save guest registers, load host registers, keep flags */
-		"mov %0, %c[wordsize](%%"R"sp) \n\t"
+		"mov %0, %c[wordsize](%%"R "sp) \n\t"
		"pop %0 \n\t"
-		"mov %%"R"ax, %c[rax](%0) \n\t"
-		"mov %%"R"bx, %c[rbx](%0) \n\t"
+		"mov %%"R "ax, %c[rax](%0) \n\t"
+		"mov %%"R "bx, %c[rbx](%0) \n\t"
		"pop"Q" %c[rcx](%0) \n\t"
-		"mov %%"R"dx, %c[rdx](%0) \n\t"
-		"mov %%"R"si, %c[rsi](%0) \n\t"
-		"mov %%"R"di, %c[rdi](%0) \n\t"
-		"mov %%"R"bp, %c[rbp](%0) \n\t"
+		"mov %%"R "dx, %c[rdx](%0) \n\t"
+		"mov %%"R "si, %c[rsi](%0) \n\t"
+		"mov %%"R "di, %c[rdi](%0) \n\t"
+		"mov %%"R "bp, %c[rbp](%0) \n\t"
 #ifdef CONFIG_X86_64
		"mov %%r8,  %c[r8](%0) \n\t"
		"mov %%r9,  %c[r9](%0) \n\t"
@@ -4231,10 +4231,10 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
		"mov %%r14, %c[r14](%0) \n\t"
		"mov %%r15, %c[r15](%0) \n\t"
 #endif
-		"mov %%cr2, %%"R"ax   \n\t"
-		"mov %%"R"ax, %c[cr2](%0) \n\t"
+		"mov %%cr2, %%"R "ax   \n\t"
+		"mov %%"R "ax, %c[cr2](%0) \n\t"

-		"pop  %%"R"bp; pop  %%"R"dx \n\t"
+		"pop  %%"R "bp; pop  %%"R "dx \n\t"
		"setbe %c[fail](%0) \n\t"
	      : : "c"(vmx), "d"((unsigned long)HOST_RSP),
		[launched]"i"(offsetof(struct vcpu_vmx, launched)),
@@ -4260,7 +4260,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
		[cr2]"i"(offsetof(struct vcpu_vmx, vcpu.arch.cr2)),
		[wordsize]"i"(sizeof(ulong))
	      : "cc", "memory"
-		, R"ax", R"bx", R"di", R"si"
+		, R "ax", R "bx", R "di", R "si"
 #ifdef CONFIG_X86_64
		, "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
 #endif
--
2.7.4

