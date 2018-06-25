Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9856C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C2425489
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VgfDwp4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C2425489
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeFYFhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:37:22 -0400
Received: from m50-138.163.com ([123.125.50.138]:47041 "EHLO m50-138.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeFYFhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:37:21 -0400
X-Greylist: delayed 943 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jun 2018 01:37:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=53DYconqiZzkaKPUw7
        4tebksHRcgL5qM630kT/Eg2HE=; b=VgfDwp4ZjJhVVZV4XJv/LGImA5RGoifXkC
        XJaTKgqjUlgc2fz+kl5mGd8+uTq1mVz2laqeYP2W36O5EF46ChTCp8f2IiVFUvHX
        QU2UOv3020un/IthBpQEw2kxAPYvJABmZDiE9M4gHJO3ay1O50VgABraTPPzjG2Q
        XL5sfCe/Q=
Received: from localhost.localdomain (unknown [61.167.60.250])
        by smtp1 (Coremail) with SMTP id C9GowAAnDo_AezBbQr5tBA--.35S2;
        Mon, 25 Jun 2018 13:21:09 +0800 (CST)
From:   LiuYang <yiqiaoxihui@163.com>
To:     Joerg Roedel <joerg.roedel@amd.com>
Cc:     mtosatti@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yiqiaoxihui <yiqiaoxihui@163.com>
Subject: [PATCH] KVM: SVM: modify macro definition 'R' to 'R ' because of gcc-5+
Date:   Mon, 25 Jun 2018 13:20:57 +0800
Message-Id: <1529904057-112227-1-git-send-email-yiqiaoxihui@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C9GowAAnDo_AezBbQr5tBA--.35S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1DKF4UXF47CFWfXr4DCFg_yoW5WFy8pF
        WrGrsIka15tF13Ja47Jr1jkFWxWF1akrnrJr9IkFWfGF98Cr1xJr4q9rnrWrn8Xry8Z3Z3
        AryYvF12va4jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRGLviUUUUU=
X-Originating-IP: [61.167.60.250]
X-CM-SenderInfo: 51ltxtxr0lx3rl6rljoofrz/1tbiMwVwSlXlrCEqIQAAs6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yiqiaoxihui <yiqiaoxihui@163.com>

GCC 5.4.0 enables raw strings by default and they have higher priority
than macros, thus R is interpreted incorrectly.
Fix it by putting a space between macro R and a string literal.

Signed-off-by: yiqiaoxihui <yiqiaoxihui@163.com>
---
 arch/x86/kvm/svm.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 506e4fe..dc328e1 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3676,13 +3676,13 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
	local_irq_enable();

	asm volatile (
-		"push %%"R"bp; \n\t"
-		"mov %c[rbx](%[svm]), %%"R"bx \n\t"
-		"mov %c[rcx](%[svm]), %%"R"cx \n\t"
-		"mov %c[rdx](%[svm]), %%"R"dx \n\t"
-		"mov %c[rsi](%[svm]), %%"R"si \n\t"
-		"mov %c[rdi](%[svm]), %%"R"di \n\t"
-		"mov %c[rbp](%[svm]), %%"R"bp \n\t"
+		"push %%"R "bp; \n\t"
+		"mov %c[rbx](%[svm]), %%"R "bx \n\t"
+		"mov %c[rcx](%[svm]), %%"R "cx \n\t"
+		"mov %c[rdx](%[svm]), %%"R "dx \n\t"
+		"mov %c[rsi](%[svm]), %%"R "si \n\t"
+		"mov %c[rdi](%[svm]), %%"R "di \n\t"
+		"mov %c[rbp](%[svm]), %%"R "bp \n\t"
 #ifdef CONFIG_X86_64
		"mov %c[r8](%[svm]),  %%r8  \n\t"
		"mov %c[r9](%[svm]),  %%r9  \n\t"
@@ -3695,20 +3695,20 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 #endif

		/* Enter guest mode */
-		"push %%"R"ax \n\t"
-		"mov %c[vmcb](%[svm]), %%"R"ax \n\t"
+		"push %%"R "ax \n\t"
+		"mov %c[vmcb](%[svm]), %%"R "ax \n\t"
		__ex(SVM_VMLOAD) "\n\t"
		__ex(SVM_VMRUN) "\n\t"
		__ex(SVM_VMSAVE) "\n\t"
-		"pop %%"R"ax \n\t"
+		"pop %%"R "ax \n\t"

		/* Save guest registers, load host registers */
-		"mov %%"R"bx, %c[rbx](%[svm]) \n\t"
-		"mov %%"R"cx, %c[rcx](%[svm]) \n\t"
-		"mov %%"R"dx, %c[rdx](%[svm]) \n\t"
-		"mov %%"R"si, %c[rsi](%[svm]) \n\t"
-		"mov %%"R"di, %c[rdi](%[svm]) \n\t"
-		"mov %%"R"bp, %c[rbp](%[svm]) \n\t"
+		"mov %%"R "bx, %c[rbx](%[svm]) \n\t"
+		"mov %%"R "cx, %c[rcx](%[svm]) \n\t"
+		"mov %%"R "dx, %c[rdx](%[svm]) \n\t"
+		"mov %%"R "si, %c[rsi](%[svm]) \n\t"
+		"mov %%"R "di, %c[rdi](%[svm]) \n\t"
+		"mov %%"R "bp, %c[rbp](%[svm]) \n\t"
 #ifdef CONFIG_X86_64
		"mov %%r8,  %c[r8](%[svm]) \n\t"
		"mov %%r9,  %c[r9](%[svm]) \n\t"
@@ -3719,7 +3719,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
		"mov %%r14, %c[r14](%[svm]) \n\t"
		"mov %%r15, %c[r15](%[svm]) \n\t"
 #endif
-		"pop %%"R"bp"
+		"pop %%"R "bp"
		:
		: [svm]"a"(svm),
		  [vmcb]"i"(offsetof(struct vcpu_svm, vmcb_pa)),
@@ -3740,7 +3740,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
		  [r15]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R15]))
 #endif
		: "cc", "memory"
-		, R"bx", R"cx", R"dx", R"si", R"di"
+		, R "bx", R "cx", R "dx", R "si", R "di"
 #ifdef CONFIG_X86_64
		, "r8", "r9", "r10", "r11" , "r12", "r13", "r14", "r15"
 #endif
--
2.7.4

