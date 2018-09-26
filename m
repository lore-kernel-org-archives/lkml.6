Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312FCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2A72086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBQHKtki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2A72086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeIZVa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:30:57 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:38971 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIZVa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:30:56 -0400
Received: by mail-qt1-f201.google.com with SMTP id f19-v6so10848722qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7tQVtrlmt+ZcRTy6M4J+EZAvS1Jrxpm9qeuU6XPxs0s=;
        b=pBQHKtkiBTdlbON3S+mvhCOgpzrgIVcCnxMPJ6z2WsXdcUSW44DsL1Vt/ouObc8jJi
         3ENPKi/zhMCcXVBuas8XBB1zjz3+6gfLuZwJotnxzPJWVjGFuuckZhfFI6+HSCNAe283
         cJU9yM/2HGf6muyHxiIlTR0iLIhHbDVAVaTOaNElWr8Iy8rzY90gUXGDF30iqblg3wGD
         M3b7jAZjF/4QUt3KjFUumcI+T8mYlG7o7cmaOR19DTHhIyF5esuyYdo4Yulw4icpAkTd
         NkFIreacD5iGX42Be4DZVaLldjLxRO8e+fv5HfchpAj2j4YL/hqpzKJMLigo6T32jhaB
         8vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7tQVtrlmt+ZcRTy6M4J+EZAvS1Jrxpm9qeuU6XPxs0s=;
        b=M/404Lgp5dFBW2dA0yJ7NJ50HNzEOkGKCJErBlLoj9lR0v9f1B58yGpRUc3GO4Gw4J
         hmYBvZYKt2Z3OuXfay41FkRRF86s4wfw+cPxiOjtymmjVcxaWNyVLTiTFjYIAJGT0ske
         +JiLAfxpGxFFMThmC7BdCWe8xr/GMfaVBhmIMjA11/zddoshYKdF2UcYOQhsErbPuRGw
         JR+oY41nwBv/FIqAmxBF4R/Ha9pYXdbR2rZclOkkKqGBG6hDvFeUfSfGCwnfOkTaH4a5
         W1CQQbhSHFu/j7uBFwZOy5litXjXH4kDNzpov9VM95yAEvPqwUzGaRSoOf30HYeOtVdS
         SaPw==
X-Gm-Message-State: ABuFfohlGdoohyanDDKPDyoI/UlFZjv8TN6ji1thNfLj66nDoix3CyFP
        zJX4DIe8iCob5fiUQ9wAlbSoLhtUrFI=
X-Google-Smtp-Source: ACcGV62V6GzYJV06TE7COtdf9GvW1mXEnhVmYpMShsiwkuShnITEvZwRNMlr4mGGTEI1P2vI1Pdk4ZnYOUA=
X-Received: by 2002:ac8:4748:: with SMTP id k8-v6mr2096365qtp.58.1537975050623;
 Wed, 26 Sep 2018 08:17:30 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:17:25 +0200
Message-Id: <20180926151725.63120-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] ptrace: zero out siginfo_t in ptrace_peek_siginfo()
From:   Alexander Potapenko <glider@google.com>
To:     oleg@redhat.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        andreyknvl@google.com, w@1wt.eu, avagin@openvz.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reported the following infoleak:

==================================================================
BUG: KMSAN: kernel-infoleak in _copy_to_user+0x15d/0x1f0
...
Call Trace:
 __dump_stack lib/dump_stack.c:77
 dump_stack+0x2f5/0x430 lib/dump_stack.c:113
 kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:917
 kmsan_internal_check_memory+0x17e/0x1f0 mm/kmsan/kmsan.c:981
 kmsan_copy_to_user+0x79/0xc0 mm/kmsan/kmsan_hooks.c:482
 _copy_to_user+0x15d/0x1f0 lib/usercopy.c:31
 copy_to_user ./include/linux/uaccess.h:183
 copy_siginfo_to_user+0x81/0x130 kernel/signal.c:2897
 ptrace_peek_siginfo kernel/ptrace.c:741
 ptrace_request+0x2278/0x2680 kernel/ptrace.c:912
 arch_ptrace+0xbdd/0x11a0 arch/x86/kernel/ptrace.c:877
 __do_sys_ptrace kernel/ptrace.c:1145
 __se_sys_ptrace+0x422/0x920 kernel/ptrace.c:1110
 __x64_sys_ptrace+0x56/0x70 kernel/ptrace.c:1110
 do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7 arch/x86/entry/entry_64.S:240
...
Local variable description: ----info.i@ptrace_request
Variable was created at:
 ptrace_peek_siginfo kernel/ptrace.c:712
 ptrace_request+0xdf/0x2680 kernel/ptrace.c:912
 arch_ptrace+0xbdd/0x11a0 arch/x86/kernel/ptrace.c:877

Bytes 16-127 of 128 are uninitialized
Memory access starts at ffff88007af6fc90
==================================================================

when calling ptrace(PTRACE_PEEKSIGINFO) for a traceable child process
with args = {-1, 0, 1}.

Initialize the |info| structure to avoid leaking stack data.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reported-by: syzbot+69c3bd9869b32e394c48@syzkaller.appspotmail.com
Fixes: 84c751bd4aebb ("ptrace: add ability to retrieve signals without
removing from a queue (v4)")
Cc: Andrey Vagin <avagin@openvz.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>
---
 kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73d45d4..92c3855c2b9c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -712,6 +712,7 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 		siginfo_t info;
 		s32 off = arg.off + i;
 
+		memset(&info, 0, sizeof(info));
 		spin_lock_irq(&child->sighand->siglock);
 		list_for_each_entry(q, &pending->list, list) {
 			if (!off--) {
-- 
2.19.0.605.g01d371f741-goog

