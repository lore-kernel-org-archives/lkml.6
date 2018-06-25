Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333EFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB6826208
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apVdS+Tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB6826208
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934091AbeFYWlZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:41:25 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:37533 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933969AbeFYWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:22 -0400
Received: by mail-qt0-f201.google.com with SMTP id i7-v6so14524534qtp.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Od59Jof06fmqB0qjXSfZQ2gfWVDeH43xyKGMWu1WNYU=;
        b=apVdS+TpQhthLWohXGWtBJUB/pXqAbBGgIcvpYxNvWsMHVcKNamdLM/bgDJe5iAmUX
         rFxTmo4V94gVhp19uz9oEY38kvj4EBTlFbTgx09T+GE5tgIsNInITqcHLPH4b9eyO7I+
         awLAIpSorrpv/gnLuQsc+i+tGyGdVuP0UbSp5uVdUth4WhRI8wJRGaRzsssfUjuKYrJG
         fg/GPDprIorpEIGVuXTU78VvOMtFHmI56CrOzNpm/2cHTfH0apL6mBVT/+Jnj+bySD7n
         QOfOW/1hKYfr+I8zruWNGU9KXJwuzCyK6NXY7wP0B+vD7uGwN9qNnR/eVxBZcW24Pd9z
         z2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Od59Jof06fmqB0qjXSfZQ2gfWVDeH43xyKGMWu1WNYU=;
        b=gGbRdkkaq3U+2j2QXhVzefevdz1FZZBPgg8ATPzWCgD5sTLVBNGvCKXIQSYf1sjw6/
         SQW/gBAAl8NXnw+dR8fHoWvIgRfmPAEO40Z2EN06LoxsP4nxFbKWUUvWg7nu6HElFwAS
         yqE8I/K9Dqg/4kBQeO0NberD1LMSMdKk+1v7crlOqtK75RifVi3FQobSn7yq3TyM/Th5
         wZH9nrdh+W1sJEhwcvfnxcno0pnsEqsxhWqH36HrU2PVcBEJzrXlde+caGlOpn/MKHPq
         mNCiyGs/gNz9Bm0XYLrzX2xceGA1BtZ0YWm4Yb8tGOszwnQLQQKc5sEizJq/Ofmqcmzt
         /ARw==
X-Gm-Message-State: APt69E1+4z5uacYM0CtKuoe1FGv5Lkt35jqCi2Ds/d7Sr4n5BrQVJ8R/
        eT5+rPc34bm4v3M2QE3ORPtOWhsNUZVfUw==
X-Google-Smtp-Source: AAOMgpeYyRD2F9A0DRsyFrlWDgyaWcWUwtuLfPa++rF733Vrv1j2uPswuhfqk0sIn3BqjGCREUp8mKsvm2yVOA==
MIME-Version: 1.0
X-Received: by 2002:a0c:fa04:: with SMTP id q4-v6mr7893824qvn.7.1529966482027;
 Mon, 25 Jun 2018 15:41:22 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:57 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-10-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 09/27] x86/acpi: Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/acpi/wakeup_64.S | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 50b8ed0317a3..472659c0f811 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -14,7 +14,7 @@
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
 ENTRY(wakeup_long64)
-	movq	saved_magic, %rax
+	movq	saved_magic(%rip), %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
 	jne	bogus_64_magic
@@ -25,14 +25,14 @@ ENTRY(wakeup_long64)
 	movw	%ax, %es
 	movw	%ax, %fs
 	movw	%ax, %gs
-	movq	saved_rsp, %rsp
+	movq	saved_rsp(%rip), %rsp
 
-	movq	saved_rbx, %rbx
-	movq	saved_rdi, %rdi
-	movq	saved_rsi, %rsi
-	movq	saved_rbp, %rbp
+	movq	saved_rbx(%rip), %rbx
+	movq	saved_rdi(%rip), %rdi
+	movq	saved_rsi(%rip), %rsi
+	movq	saved_rbp(%rip), %rbp
 
-	movq	saved_rip, %rax
+	movq	saved_rip(%rip), %rax
 	jmp	*%rax
 ENDPROC(wakeup_long64)
 
@@ -45,7 +45,7 @@ ENTRY(do_suspend_lowlevel)
 	xorl	%eax, %eax
 	call	save_processor_state
 
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -64,13 +64,14 @@ ENTRY(do_suspend_lowlevel)
 	pushfq
 	popq	pt_regs_flags(%rax)
 
-	movq	$.Lresume_point, saved_rip(%rip)
+	leaq	.Lresume_point(%rip), %rax
+	movq	%rax, saved_rip(%rip)
 
-	movq	%rsp, saved_rsp
-	movq	%rbp, saved_rbp
-	movq	%rbx, saved_rbx
-	movq	%rdi, saved_rdi
-	movq	%rsi, saved_rsi
+	movq	%rsp, saved_rsp(%rip)
+	movq	%rbp, saved_rbp(%rip)
+	movq	%rbx, saved_rbx(%rip)
+	movq	%rdi, saved_rdi(%rip)
+	movq	%rsi, saved_rsi(%rip)
 
 	addq	$8, %rsp
 	movl	$3, %edi
@@ -82,7 +83,7 @@ ENTRY(do_suspend_lowlevel)
 	.align 4
 .Lresume_point:
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	saved_context_cr4(%rax), %rbx
 	movq	%rbx, %cr4
 	movq	saved_context_cr3(%rax), %rbx
-- 
2.18.0.rc2.346.g013aa6912e-goog

