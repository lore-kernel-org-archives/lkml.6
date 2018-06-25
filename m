Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D5EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE02E2623A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFiGmUWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE02E2623A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934901AbeFYWpw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:45:52 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:56033 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934154AbeFYWl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:29 -0400
Received: by mail-it0-f74.google.com with SMTP id 7-v6so7318516itv.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=DWmGvA0lR6w7y5ULZBpH8CF04xCV2RqblUumbO+kjTU=;
        b=bFiGmUWPHjGBuOHdMmFSusIQ4RcqGqhbbC+KO7++F6XJa+rf+G/3sdSMCGx49hQWap
         H7c2uu35f4WsOO6xSPy/vZ0iJ6bbZcpqkrEkBUpfuUtlPADE8NNGlM8twAK8lfavlb8J
         8ID9qhlzz4joD/ksZjgFL2hQfRPt/mQZkgBVF6c1hOtF9e4a1eixZl6FBdSB6AeHDGsz
         oCAwSIreuCI8DA1JmKJcgsEob73EknV752zZQ4+aszUshK0UJ6JNe0PzZxjB2zV+srSj
         /D0qDEL/nmED3KCzRWDM2SzpEBdqpoahCIuO5EAP7HctBdMCXR5iljEevMEFplg0lhrp
         VZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=DWmGvA0lR6w7y5ULZBpH8CF04xCV2RqblUumbO+kjTU=;
        b=Jnvq9wmNa33v8RjIt4iaBbFmoG6Ue3ZGPZi7tdMcClhEG2IOcOY6WY3L/HS2dXcpkp
         pmDa9NoKs/KD/etWbsJf2qMXXcO+CQdFVU2SQNRNEGE9mXe1xcjB+iJ6XTbbDR1r5uJC
         Hzn/qwFIvslVr8Q6BASHXmazUSWkfRINUtvJWIPlHJrky71CJU4VZEHibfHlBTIzJKzo
         jjQ8s0YJ5B+/UnzT/RhA88mQtXYDYMjxghYqjqNlNv764qStrIFaqZ63LbLgz9GzpjsG
         GOSkSorecFifo50bZziIr7vKa4pXwJTxzoQC/0IRXNfSFaUm6kBg2YUBIHY1lL5MKdog
         erXA==
X-Gm-Message-State: APt69E10J3zAIQcSkEqLBFj5y36thQhZgArPAwmCMCf5CZgnVMuevrT7
        8cgVXMIp3Utw5YjaRZ63ZVemgBoYusWnCw==
X-Google-Smtp-Source: AAOMgpcMfOgsNjQ3gS57e24UnR3P+4f45NGqjZpwIO8a6CATrwhRFOqvNBr8LlS8GSAmtKv643o/RgJRATOtow==
MIME-Version: 1.0
X-Received: by 2002:a24:6b15:: with SMTP id v21-v6mr1197132itc.1.1529966488785;
 Mon, 25 Jun 2018 15:41:28 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:59 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-12-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 11/27] x86/power/64: Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
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
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index ce8da3a0412c..6fdd7bbc3c33 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -24,7 +24,7 @@
 #include <asm/frame.h>
 
 ENTRY(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -115,7 +115,7 @@ ENTRY(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
-- 
2.18.0.rc2.346.g013aa6912e-goog

