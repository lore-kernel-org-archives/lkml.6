Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636EBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1736B26213
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFEwAkvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1736B26213
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934620AbeFYWmN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:42:13 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:55457 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934572AbeFYWmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:42:09 -0400
Received: by mail-yb0-f201.google.com with SMTP id y16-v6so2009482ybk.22
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=di1a+2IpeHvGipVB0LNFKlY88ZP9mtPFk4hb1bdjJ3g=;
        b=XFEwAkvdcDd+pTY2WvROAMghiTBxG57BlW5nss82QtKbp7E1LAtNGYODcOl55snyQW
         USJ95jbU45snVmet677M/BF8OWFmBCHxLwcmBEGrwKvTBp8U+ycdIMwgrZbPjyb5iRnp
         xDG3SP7aH1umnwtjmFgNCV0mM1AzR4OF5KjEiaBo1qGqlg8K1aA9rjLiAFaa8uguRKN8
         QTmiHnV47JU4HRwxc3hjdmWX930eJNIcVge2bRA4KYbHnlEjrZ5HSFxra9eaDyBnaird
         /mpsKbrF6vJbNAej7N8YV7tTAF2eiLLCoIcmyOlRYSy5Sb4OfqpfGetjqEjOnS8ppV/s
         g0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=di1a+2IpeHvGipVB0LNFKlY88ZP9mtPFk4hb1bdjJ3g=;
        b=JguCdVr95Nk+1e2oI1y5if/mE0MJ973xrxe6Y9Hk+jXL9vwJ/SBZqnzSeipl+sArUj
         ZcPLJEQbiXDEXIn7QbGX8BjRbfLTUSSN65TKA1OccJ3BSVD4DgpoJpgFP/jPFwwNeITH
         CwR9t41TT3RDYWtljlon44o0q9DyNDp438gINqkuLT5KcZ41YvzAZiTfmWPemuYawYMI
         mbESYkNvWKQj/wm6B3mldq9KOtbuvqCXkNyn9LjIxJJ+IjcS2Hz/+pqBRY4MXb+6865U
         Yh6amv+V9F0TWntE15SA9A64x5ApEmQXwcjzpWANmrS4016y088RWNQ48ELRYEUntKvh
         5uWw==
X-Gm-Message-State: APt69E0sln2SnGK4WpztDJ19l4RDUYI2v7UxR7XyyhLRC3saxNd3r2nE
        HCd0xmL+KQD3Qf/MS5kdGuxVurLYJX1Eiw==
X-Google-Smtp-Source: ADUXVKLzN1s8fYsNlgRqA0tF1PXlXiR8WocAmAa0gGKaY9LtWGM0+c679ifb6R2DwM8udHVkhXSRbscJM97x7A==
MIME-Version: 1.0
X-Received: by 2002:a25:2e0c:: with SMTP id u12-v6mr3925175ybu.27.1529966528225;
 Mon, 25 Jun 2018 15:42:08 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:07 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-20-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 19/27] kvm: Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible. The new __ASM_MOVABS macro is used to
get the address of a symbol on both 32 and 64-bit with PIE support.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/kvm_host.h | 8 ++++++--
 arch/x86/kernel/kvm.c           | 6 ++++--
 arch/x86/kvm/svm.c              | 4 ++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c13cd28d9d1b..27370f4917a4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1390,9 +1390,13 @@ asmlinkage void kvm_spurious_fault(void);
 	".pushsection .fixup, \"ax\" \n" \
 	"667: \n\t" \
 	cleanup_insn "\n\t"		      \
-	"cmpb $0, kvm_rebooting \n\t"	      \
+	"cmpb $0, kvm_rebooting" __ASM_SEL(,(%%rip)) " \n\t" \
 	"jne 668b \n\t"      		      \
-	__ASM_SIZE(push) " $666b \n\t"	      \
+	__ASM_SIZE(push) "$0 \n\t"		\
+	__ASM_SIZE(push) "%%" _ASM_AX " \n\t"		\
+	_ASM_MOVABS " $666b, %%" _ASM_AX "\n\t"	\
+	_ASM_MOV " %%" _ASM_AX ", " __ASM_SEL(4,8) "(%%" _ASM_SP ") \n\t" \
+	__ASM_SIZE(pop) "%%" _ASM_AX " \n\t"		\
 	"call kvm_spurious_fault \n\t"	      \
 	".popsection \n\t" \
 	_ASM_EXTABLE(666b, 667b)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a37bda38d205..761157c138c9 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -726,8 +726,10 @@ asm(
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
 "__raw_callee_save___kvm_vcpu_is_preempted:"
-"movq	__per_cpu_offset(,%rdi,8), %rax;"
-"cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
+"leaq	__per_cpu_offset(%rip), %rax;"
+"movq	(%rax,%rdi,8), %rax;"
+"addq	" __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rip), %rax;"
+"cmpb	$0, (%rax);"
 "setne	%al;"
 "ret;"
 ".popsection");
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f059a73f0fd0..cb78647d6383 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -707,12 +707,12 @@ static u32 svm_msrpm_offset(u32 msr)
 
 static inline void clgi(void)
 {
-	asm volatile (__ex(SVM_CLGI));
+	asm volatile (__ex(SVM_CLGI) : :);
 }
 
 static inline void stgi(void)
 {
-	asm volatile (__ex(SVM_STGI));
+	asm volatile (__ex(SVM_STGI) : :);
 }
 
 static inline void invlpga(unsigned long addr, u32 asid)
-- 
2.18.0.rc2.346.g013aa6912e-goog

