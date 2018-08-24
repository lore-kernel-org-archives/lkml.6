Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB8F21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XglZwoIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB8F21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeHYDf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:35:26 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:36279 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeHYDf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:35:26 -0400
Received: by mail-io0-f202.google.com with SMTP id s5-v6so5506999iop.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nqWOJ2aHqIuIT0It5ils8/UkwLcRqO0J+7CqJC9U1qg=;
        b=XglZwoIkbU9hWQ/lcw4FjHB5kVhilBaLWXoYn9PuswGVl7JUCVUEgGxcve+0EEuFW4
         5pdun/99sNBrgJUSE6wD+XeYuUBWkaafXzkwwDOQnj5a32KyzV8KOs2S5gP0w6YBbB34
         eG6eyS5TY5hca8wbou+lwX6QaQcIvdWzMYv11wFPpM1dn9XYbDexsE4t8SBarmAqm+fZ
         cWKDOXzC2zYzD1iIKO9XbrhhicvMhbNVtPVRaPMcxh72C6durLOJJ2gb6C+2DK4z0sW6
         9GPVJuuX1Teo1XIQc6I7GljjW1yMcqUAXZIF7wOAYLDWup6DYJdCrBkdDyxQN4MD9ZRE
         N33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nqWOJ2aHqIuIT0It5ils8/UkwLcRqO0J+7CqJC9U1qg=;
        b=ZnyeGcnXQvt0puU2jNTyySxFumeqKoQHJNRLmq/9x2DbZULOm308jTD6naFRZPn+8Y
         SWTAUrAlNpZe19BYKGph5Mbsw2EZtpSQSKllUST50p8u5D9tdsCtFxhjkZvFB9Hzlwdv
         n4Vx0s4mF76a9lsA6b1yUtsCZU61AAYV4jfzGUmHuE5FkOEUtL9nfsEPaZ+ri7QLXB5G
         P5d+XX+A8VM7vktcYVQv22BWh3bKC8vXTQUZbWNrzMSOKJ5tSIAvvMZjVDMl0JsmZQ7j
         O6yww49w/N9rz71XHWsQHzymd5DGW35cLG6jE8uyHGs8BosM39uGEpshVmgewh3qy+Zp
         7nFA==
X-Gm-Message-State: APzg51ATS7ir4aJHsVm8UIvIcQTsCICn6qPjIx+x5M8hs19n5evg2XIY
        N3WiAK2qOLX3e0E4IQNGP3GopQ2J8g==
X-Google-Smtp-Source: ANB0VdZtJ1QOaQoYYeJrKr06NMvB5UjQcQolpLfmJlCRVlxpklrVXWqT5NfJr44P2vwTQbMe3V7BclWPiQ==
X-Received: by 2002:a24:5e93:: with SMTP id h141-v6mr1889248itb.19.1535155114571;
 Fri, 24 Aug 2018 16:58:34 -0700 (PDT)
Date:   Sat, 25 Aug 2018 01:58:26 +0200
Message-Id: <20180824235826.62741-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH] x86/entry/64: wipe KASAN stack shadow in rewind_stack_do_exit()
From:   Jann Horn <jannh@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, jannh@google.com
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the KASAN shadow state of the task stack when rewinding RSP.
Without this, a kernel oops will leave parts of the stack poisoned, and
code running under do_exit() can trip over such poisoned regions and cause
nonsensical false-positive KASAN reports about stack-out-of-bounds bugs.

This patch is 64-bit only because KASAN doesn't exist on 32-bit.

This patch does not wipe exception stacks; if you oops on an exception
stack, you might get random KASAN false-positives from other tasks
afterwards. This is probably relatively uninteresting, since if you're
oopsing on an exception stack, you likely have bigger things to worry
about. It'd be more interesting if vmapped stacks and KASAN were
compatible, since then handle_stack_overflow() would oops from exception
stack context.

Fixes: 2deb4be28077 ("x86/dumpstack: When OOPSing, rewind the stack before do_exit()")
Signed-off-by: Jann Horn <jannh@google.com>
---
I have manually tested that an oops that previously triggered this bug
doesn't trigger it anymore.

It would be possible to rewrite this assembly to use fewer instructions
in non-KASAN builds, but I think it's clearer this way.

If anyone thinks that this thing should also be wiping exception stacks:
I did write some (entirely untested) code that should take care of that
(before realizing that it's rather unlikely to occur in practice because
vmapped stacks and KASAN are mutually exclusive), but I'm not sure
whether it's worth complicating this code for that.
In case anyone's curious how that would look:
https://gist.github.com/thejh/c91f9b4e3cc4c58659bb3cd056c4fa40

 arch/x86/entry/entry_64.S | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 957dfb693ecc..92d3ad5bd365 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1673,9 +1673,25 @@ ENTRY(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
+	movq	%rdi, %r14
+
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
-	leaq	-PTREGS_SIZE(%rax), %rsp
+	leaq	-PTREGS_SIZE(%rax), %r15
+
+#ifdef CONFIG_KASAN
+	/*
+	 * Remove stack poisons left behind by our old stack.
+	 * Do this before updating RSP to avoid problems in case we get some
+	 * interrupt that is not handled on an exception stack before we're done
+	 * with the unpoisoning.
+	 */
+	movq	%r15, %rdi
+	call	kasan_unpoison_task_stack_below
+#endif
+
+	movq	%r15, %rsp
 	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
 
+	movq	%r14, %rdi
 	call	do_exit
 END(rewind_stack_do_exit)
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

