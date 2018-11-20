Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E69D2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbV91fBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E69D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbeKTQdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 11:33:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36954 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKTQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 11:33:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so422754pge.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 22:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aGiaCMTlIf1ChSKXNPut5X3cyUNnLU37C2uDQXkCI/E=;
        b=FbV91fBWHIobGIuGl3rKvP1IenOWUrUpXMw6xhdKaNBncJ46KFMMld3hM97DvcIFsu
         r7/KaFl9fUmTFfx2ltSw0fTUOEtJJETQfiC7TMJTCVg9wFXaoLllV1460lgjbdgj1Srf
         59Pi4wMsqptesRELdEjhjeUAKbn2ZUgwkyPPkvgRCUEbuDK/Ti8AKLt16rsye6CGp6ML
         7cjPJeIjoODlRpHzxYtgizYSDWcA6n6jEqiN+VuFIAXRmL8iJ6jm2/8xTdWPl3M6xIjL
         NVwxBsQFEmo1WSRAXXQbRHen7EB16u/SYkL1gKiU7lxfv/CYbd0AE3Mee1ceobabXXp7
         FygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aGiaCMTlIf1ChSKXNPut5X3cyUNnLU37C2uDQXkCI/E=;
        b=lqCUQrevpJ5xInmHh9dvCOoPFJBOaZoScc22cGMLHnK4A6WrsYoiuAHG7WjiGI7sgj
         nb5IgTvzn0nDHuBZbmdTvfIGPiceG7fPhP2kB2+I/RFBCv6wjN7Y3uHA7rWKgJWWaqf2
         h12Y5sullI4gdB3zXbffVlCByiliTR+SPiAA5B0NUAKZXk09AuDr1thKDrWROrWCjY+z
         tyRrGKX6jIanK00cXXiy+71IMUy7RJf/P+Kv+r1etR2ZpGsFplpMtKv9lRr8FDIBCGiB
         Dw2PeYhvD/pcsQ7CVvKQtLcFhgdEOga/hc4vRFpjqndR4xlqCjivmaH8iDZTxLeoFV5s
         9rvQ==
X-Gm-Message-State: AA+aEWa7y43Dxb64nswi3sO7ykiZ1vCXHTlOyZdHcNFGDT1KO1KVsBcb
        c8+5eNE8Jl7xfpJ/T/umwdQ=
X-Google-Smtp-Source: AFSGD/UtIfn+8OzzXo+/yN0NgG82s/NT31De6rqJ/6Hf7rGcT8tfa5HEH7oxkDiJ/JCOSfzMIK/K5w==
X-Received: by 2002:a63:d157:: with SMTP id c23mr749804pgj.170.1542693982267;
        Mon, 19 Nov 2018 22:06:22 -0800 (PST)
Received: from localhost.localdomain (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id u186sm16141245pgd.62.2018.11.19.22.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 22:06:21 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ptrace: take into account saved_sigmask in PTRACE_{GET,SET}SIGMASK
Date:   Mon, 19 Nov 2018 22:06:16 -0800
Message-Id: <20181120060616.6043-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few system calls (pselect, ppoll, etc) which replace a task
sigmask while they are running in a kernel-space

When a task calls one of these syscalls, the kernel saves a current
sigmask in task->saved_sigmask and sets a syscall sigmask.

On syscall-exit-stop, ptrace traps a task before restoring the
saved_sigmask, so PTRACE_GETSIGMASK returns the syscall sigmask and
PTRACE_SETSIGMASK does nothing, because its sigmask is replaced by
saved_sigmask, when the task returns to user-space.

This patch fixes this problem. PTRACE_GET_SIGMASK returns saved_sigmask
is it's set. PTRACE_SETSIGMASK drops the TIF_RESTORE_SIGMASK flag.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 29000caecbe8 ("ptrace: add ability to get/set signal-blocked mask")
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 include/linux/sched/signal.h | 18 ++++++++++++++++++
 kernel/ptrace.c              | 15 +++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1be35729c2c5..660d78c9af6c 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -417,10 +417,20 @@ static inline void set_restore_sigmask(void)
 	set_thread_flag(TIF_RESTORE_SIGMASK);
 	WARN_ON(!test_thread_flag(TIF_SIGPENDING));
 }
+
+static inline void clear_tsk_restore_sigmask(struct task_struct *tsk)
+{
+	clear_tsk_thread_flag(tsk, TIF_RESTORE_SIGMASK);
+}
+
 static inline void clear_restore_sigmask(void)
 {
 	clear_thread_flag(TIF_RESTORE_SIGMASK);
 }
+static inline bool test_tsk_restore_sigmask(struct task_struct *tsk)
+{
+	return test_tsk_thread_flag(tsk, TIF_RESTORE_SIGMASK);
+}
 static inline bool test_restore_sigmask(void)
 {
 	return test_thread_flag(TIF_RESTORE_SIGMASK);
@@ -438,6 +448,10 @@ static inline void set_restore_sigmask(void)
 	current->restore_sigmask = true;
 	WARN_ON(!test_thread_flag(TIF_SIGPENDING));
 }
+static inline void clear_tsk_restore_sigmask(struct task_struct *tsk)
+{
+	tsk->restore_sigmask = false;
+}
 static inline void clear_restore_sigmask(void)
 {
 	current->restore_sigmask = false;
@@ -446,6 +460,10 @@ static inline bool test_restore_sigmask(void)
 {
 	return current->restore_sigmask;
 }
+static inline bool test_tsk_restore_sigmask(struct task_struct *tsk)
+{
+	return tsk->restore_sigmask;
+}
 static inline bool test_and_clear_restore_sigmask(void)
 {
 	if (!current->restore_sigmask)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73d45d4..fc0d667f5792 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -29,6 +29,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/cn_proc.h>
 #include <linux/compat.h>
+#include <linux/sched/signal.h>
 
 /*
  * Access another process' address space via ptrace.
@@ -925,18 +926,26 @@ int ptrace_request(struct task_struct *child, long request,
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
 
-	case PTRACE_GETSIGMASK:
+	case PTRACE_GETSIGMASK: {
+		sigset_t *mask;
+
 		if (addr != sizeof(sigset_t)) {
 			ret = -EINVAL;
 			break;
 		}
 
-		if (copy_to_user(datavp, &child->blocked, sizeof(sigset_t)))
+		if (test_tsk_restore_sigmask(child))
+			mask = &child->saved_sigmask;
+		else
+			mask = &child->blocked;
+
+		if (copy_to_user(datavp, mask, sizeof(sigset_t)))
 			ret = -EFAULT;
 		else
 			ret = 0;
 
 		break;
+	}
 
 	case PTRACE_SETSIGMASK: {
 		sigset_t new_set;
@@ -962,6 +971,8 @@ int ptrace_request(struct task_struct *child, long request,
 		child->blocked = new_set;
 		spin_unlock_irq(&child->sighand->siglock);
 
+		clear_tsk_restore_sigmask(child);
+
 		ret = 0;
 		break;
 	}
-- 
2.17.2

