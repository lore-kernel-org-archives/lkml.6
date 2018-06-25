Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA170C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845D226210
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ARK9ftcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845D226210
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934189AbeFYWla (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:41:30 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:49719 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933969AbeFYWl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:26 -0400
Received: by mail-io0-f202.google.com with SMTP id x13-v6so12887215iog.16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=XXQ7C/CDeUMNvwwGw/8BYZVCFy2rI+v0Pigd08BAKSc=;
        b=ARK9ftcgOouSqk4fMxtyYsAfDex24/Ayzi/AtIxioDUezvChXudQkPfNOwwr+3ZiRL
         rVCwh5esMjB9OTMkdaqfam+0w2pfO9aYrBUYX40KkiohWcjVjigpRkTishZWQzBBP/uR
         1ql786ng1WWfmkMjPO+FuSQfa1Z8UX34oKUUlsqe4cgFd2+9/+o8WiI19h/3a7pxOjwq
         MV/8m0KQdewBL4Q8AxKONCqHduy0eq5ZMhWTYJCpe6G/2I6BDldafG5NTvKRJKKHG4vX
         WhBbWMi5LPECGI+m2D0C2JNvVV08sSEH0TwU3YdQ8uhlfO7wtw83EhJ8/LD3yQCr9Jp7
         060g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=XXQ7C/CDeUMNvwwGw/8BYZVCFy2rI+v0Pigd08BAKSc=;
        b=j9bW7+hp0r/ranvT5ZNkitWCu9uwwNfwHUg2cvWL0rc3/YTgygcA+qTaLkvwKHF+b8
         TEvBiBgppqtxBZRxRQloG8mC9NOvYz/RHDd2P1icsnE5fkm4oS9+HFbKMFJ5b/h14mpV
         1NsfOM7hufzA1VXZvVoTLeOOuREb1mwb81+zZEwLhlC8j4zQatnx09XzRSmcQ4Ln/TKR
         rdEgEwQe1oPufVvdX2J+ofnBT4IO7y8hRwtrQsw26bdD7YI1Hdc8kbQyHx3+dNK89ERV
         /QX2L2PONWX6lLzVZWuWcBkkHdygT0iHzUvBdwRD+sgRlGetwZE0UzrFB192JWIcqiif
         Hsng==
X-Gm-Message-State: APt69E2TpNSfI5sc7A4FMGgbuAErrc5Rlr+fI8czhS+NlHNYIbF5HmCV
        VrlEJ5kiysrt+9rDwzyO72IH0n/sNe2/Dg==
X-Google-Smtp-Source: ADUXVKInHsu2npYg7XtQ4k9TVhn2iNrTC4MpiIVgLdoBMmCL8Nj9iE/HXeNOjEeLLnh2WsEB9e3brWOFXptFRg==
MIME-Version: 1.0
X-Received: by 2002:a24:14ca:: with SMTP id 193-v6mr1231065itg.13.1529966485494;
 Mon, 25 Jun 2018 15:41:25 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:58 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-11-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 10/27] x86/boot/64: Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Early at boot, the kernel is mapped at a temporary address while preparing
the page table. To know the changes needed for the page table with KASLR,
the boot code calculate the difference between the expected address of the
kernel and the one chosen by KASLR. It does not work with PIE because all
symbols in code are relatives. Instead of getting the future relocated
virtual address, you will get the current temporary mapping.
Instructions were changed to have absolute 64-bit references.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/kernel/head_64.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 8344dd2f310a..7fca19e1f556 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -89,8 +89,10 @@ startup_64:
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	movabs  $(early_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 	jmp 1f
+
 ENTRY(secondary_startup_64)
 	UNWIND_HINT_EMPTY
 	/*
@@ -119,7 +121,8 @@ ENTRY(secondary_startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+	movabs	$(init_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 1:
 
 	/* Enable PAE mode, PGE and LA57 */
@@ -137,7 +140,7 @@ ENTRY(secondary_startup_64)
 	movq	%rax, %cr3
 
 	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
+	movabs  $1f, %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
@@ -234,11 +237,12 @@ ENTRY(secondary_startup_64)
 	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
 	 *		address given in m16:64.
 	 */
-	pushq	$.Lafter_lret	# put return address on stack for unwinder
+	movabs  $.Lafter_lret, %rax
+	pushq	%rax		# put return address on stack for unwinder
 	xorq	%rbp, %rbp	# clear frame pointer
-	movq	initial_code(%rip), %rax
+	leaq	initial_code(%rip), %rax
 	pushq	$__KERNEL_CS	# set correct cs
-	pushq	%rax		# target address in negative space
+	pushq	(%rax)		# target address in negative space
 	lretq
 .Lafter_lret:
 END(secondary_startup_64)
-- 
2.18.0.rc2.346.g013aa6912e-goog

