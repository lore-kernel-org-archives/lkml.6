Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F74C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7287F2620F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JTPUZE/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7287F2620F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933627AbeFYWlP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:41:15 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:42839 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbeFYWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:12 -0400
Received: by mail-yw0-f202.google.com with SMTP id c79-v6so6369593ywh.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=O8CLfxcg9OKod1ivZbkoSyCm0ci4+lg3Z3Y3PZu7UvE=;
        b=JTPUZE/GxynGfFI/4iONF3uw/WeFYQQ6M8VlMNpH0ZU14R2j6KAhlDygiRO8VAM6mA
         ZdcZeH12M1U29XH1GW8SRT0wgsbQRIbdMDswzReTGwaA0leh5WI03ZFGy0y7Dl49vAU5
         Sug/SHF5odExmWhLk9f4hadKAg3Tgyk5CprBUgh74KSIeH94nJmc/MD1uB60tFkq+POa
         h1k9A2kw3lVjvWiwSu4MGNl5eJm2gngU04RttYcXYlRJQMv8KMkK3JIQTn6sLq0AlEhe
         91aP9Do3SAyXhpoRrxYL+ajHGHFbE/Ya+FyYKgV5DQClYCY9iiK4KNd0qjCCaCtUx4zd
         jcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=O8CLfxcg9OKod1ivZbkoSyCm0ci4+lg3Z3Y3PZu7UvE=;
        b=m9LwhqRqFQAtAUy2B10QKqExn8PCpU6KSMg7eOr9kqYbdgrjoly/GjrnUD+rKiy1C8
         MkAKXx6GQGjwdUpasyHq73SoDupxblFycRfl1VSMEfUf3RhBXO61w4RNte76bL1pIT1e
         8/kD2aoHcaBpzCJoGG1kSIDVaDSPGy5S0Mnjujxfn2Vxzs/aSjvU7brGUWGVlBjMwZFe
         ddJz5wB+JH7MZPVzaxWYENnCUHjPFv81Ih49UqDda2u5jk7XOMp8e5y7cH8eG+G+gQDg
         WmkCV9fbTsS/2FJ4GEQotqcr0fsU1I3HJAM/4jWeZuDUGpqEFqKmol09RXbEZShKPOsB
         WRew==
X-Gm-Message-State: APt69E3wIloNimPdSyrA0vrrqaah8egjMwXeOOrQY2JGSiZwnKSgwQEm
        V1pATyBnNGUgQBno7x4Wj2SZD1gq82+1Uw==
X-Google-Smtp-Source: ADUXVKIZhgOfpWOU7eftUZZ/WQuPZZDkCs20b0atPoQ+qjy3MlJIB7NY/ZTFjvwbwXinU8dvuEvN7+PTWr1jsQ==
MIME-Version: 1.0
X-Received: by 2002:a25:ba8c:: with SMTP id s12-v6mr4018875ybg.6.1529966472111;
 Mon, 25 Jun 2018 15:41:12 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:54 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-7-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 06/27] x86/entry/64: Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/entry/entry_64.S            | 18 ++++++++++++------
 arch/x86/kernel/relocate_kernel_64.S |  8 +++-----
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c6f3677e6105..e738d8d0e308 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -191,7 +191,7 @@ ENTRY(entry_SYSCALL_64_trampoline)
 	 * spill RDI and restore it in a second-stage trampoline.
 	 */
 	pushq	%rdi
-	movq	$entry_SYSCALL_64_stage2, %rdi
+	movabsq	$entry_SYSCALL_64_stage2, %rdi
 	JMP_NOSPEC %rdi
 END(entry_SYSCALL_64_trampoline)
 
@@ -1277,7 +1277,8 @@ ENTRY(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	leaq	.Lgs_change(%rip), %rcx
+	cmpq	%rcx, RIP+8(%rsp)
 	jne	.Lerror_entry_done
 
 	/*
@@ -1482,10 +1483,10 @@ ENTRY(nmi)
 	 * resume the outer NMI.
 	 */
 
-	movq	$repeat_nmi, %rdx
+	leaq	repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	1f
-	movq	$end_repeat_nmi, %rdx
+	leaq	end_repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	nested_nmi_out
 1:
@@ -1539,7 +1540,8 @@ nested_nmi:
 	pushq	%rdx
 	pushfq
 	pushq	$__KERNEL_CS
-	pushq	$repeat_nmi
+	leaq	repeat_nmi(%rip), %rdx
+	pushq	%rdx
 
 	/* Put stack back */
 	addq	$(6*8), %rsp
@@ -1578,7 +1580,11 @@ first_nmi:
 	addq	$8, (%rsp)	/* Fix up RSP */
 	pushfq			/* RFLAGS */
 	pushq	$__KERNEL_CS	/* CS */
-	pushq	$1f		/* RIP */
+	pushq	$0		/* Futur return address */
+	pushq	%rax		/* Save RAX */
+	leaq	1f(%rip), %rax	/* RIP */
+	movq    %rax, 8(%rsp)   /* Put 1f on return address */
+	popq	%rax		/* Restore RAX */
 	iretq			/* continues at repeat_nmi below */
 	UNWIND_HINT_IRET_REGS
 1:
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index a7227dfe1a2b..0c0fc259a4e2 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -208,11 +208,9 @@ identity_mapped:
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	jmp	*virtual_mapped_addr(%rip)
-
-	/* Absolute value for PIE support */
-virtual_mapped_addr:
-	.quad virtual_mapped
+	movabsq $virtual_mapped, %rax
+	pushq	%rax
+	ret
 
 virtual_mapped:
 	movq	RSP(%r8), %rsp
-- 
2.18.0.rc2.346.g013aa6912e-goog

