Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325A0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CED2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8qI3fAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CED2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeH1WfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:35:23 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:48019 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeH1WfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:35:22 -0400
Received: by mail-yb0-f202.google.com with SMTP id s27-v6so1213397ybe.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WGp+otou0eK2K6flVd65sfE2AMfT6kBTfP3rn6W8shg=;
        b=Y8qI3fAo6k+5jw+mKstOh6YJe+Z+RxHvo9rLIo1lonjn1LAJy5KxKgzI/rDRXM/fBS
         u6LbBnVgGzXJxH8mMtwccqGt5aHXCmiVbLq96mvOB1p3pVGsrxKtzVOEpCK3kUOZFX5b
         j/Wi7rB2bOxClbRYxs5QBuswM6M3uIhEPyyrztHcIlmBew80WYaeP6YXz/eHoXcJkX1/
         gDNnRaI2t9gvUKlr5cKMNnN+hHpWb1fZxI78agm6XMce8CTlQuDgxzaDm4kMU6i5pWvH
         8o0qV3F5poUUFlQ/2+Euja9OPbDHxaj3HCJIrai1GQ5dFIZcfjbdcVgzWpi/egDw4PjK
         qbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WGp+otou0eK2K6flVd65sfE2AMfT6kBTfP3rn6W8shg=;
        b=kC1KAGw65nOXx/BqwV1AYP4a3Xi3FfhFAIYbu/uOiIcRlFig8F/owJ97MKfRbNFqpH
         qvOPm07cGm2V4hGGaPJNaU/zluvl3s/B07CXuBGMhs90pIBgf/vLhTJRcM8FipSs+qJ4
         ckpFAHDBx6DjeNLTWeTHNCKAxiJU81WLlnOSrsJ23AhP4LTecOa6Rg+4ikADA1BbiJjQ
         ScwUh+dL/2wcbZTqMxp6L59emUmESvzI+19J8Dnqu1qPEPJY3gVlmf1M0EWWrzj02mwA
         oGdJnGkrpaaJ+JMSBTiVSSd/H70Zrb0cL1dcPjsRt/kLZEVAvl2WgbkUPCLno21LDRQW
         hm9g==
X-Gm-Message-State: APzg51CRAJlpqCA5WcnTaD1bfHusaDuwT0OmsD1tiBJr+npXMwsp421C
        iR524JlS4LX7kWnK11ml2maBjPUyDQ==
X-Google-Smtp-Source: ANB0VdbUjoML/x7Zpxok9nCglqhxedpQq0NmwV7kvwtpCDpVozZWFUQ9BOwqld8XgtGDI47E+SfR+YxiqA==
X-Received: by 2002:a81:270d:: with SMTP id n13-v6mr883025ywn.146.1535481746910;
 Tue, 28 Aug 2018 11:42:26 -0700 (PDT)
Date:   Tue, 28 Aug 2018 20:40:33 +0200
Message-Id: <20180828184033.93712-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v2] x86/entry/64: wipe KASAN stack shadow before rewind_stack_do_exit()
From:   Jann Horn <jannh@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, jannh@google.com
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the KASAN shadow state of the task stack before rewinding RSP.
Without this, a kernel oops will leave parts of the stack poisoned, and
code running under do_exit() can trip over such poisoned regions and cause
nonsensical false-positive KASAN reports about stack-out-of-bounds bugs.

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
v2:
 - Rewrite, do it in C from oops_end() instead of in assembly
   (Andrey Ryabinin)


 arch/x86/kernel/dumpstack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 9c8652974f8e..1596e6bfea6f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -17,6 +17,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 #include <linux/sysfs.h>
+#include <linux/kasan.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -346,7 +347,10 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	 * We're not going to return, but we might be on an IST stack or
 	 * have very little stack space left.  Rewind the stack and kill
 	 * the task.
+	 * Before we rewind the stack, we have to tell KASAN that we're going to
+	 * reuse the task stack and that existing poisons are invalid.
 	 */
+	kasan_unpoison_task_stack(current);
 	rewind_stack_do_exit(signr);
 }
 NOKPROBE_SYMBOL(oops_end);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

