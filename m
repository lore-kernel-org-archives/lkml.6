Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DDCC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D05020989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El6zPKl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D05020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeK3FME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:12:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36339 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeK3FME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:12:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so1280761pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l8uQa9znZatAaJ+dsg4573uJh0e3i7tztDIZSeDNr2E=;
        b=El6zPKl2qxEP4MqA6R0aZwNCeTgEFy1FgcOCCdabMJgpY8PrJLP51g3LqXFwrGD0of
         7aEi5opoRE+mjm5qge229YQtA7ILdFJQohY+KvKrGqsan4+cM9JPXqmR222/Nz4SztWu
         xaNz8zf8gMK5yf2+0LCzdhAg5Qjwm1yFlrpsNQyBGOtqwHHrFJjIh49KgeSLga8CXLCV
         6Xduc6vk2CsBf2zEtxDASS8c8jbQMlRYpE9w5eBrdpMULfSJElVKaPty/LGDujjwUZKg
         7BZAVAcPuSWIdsbslenEcZ7bB0bos1zkJ3tORra/mB0FrkOXYHBOo8qB4YFt8V4i36IM
         QGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l8uQa9znZatAaJ+dsg4573uJh0e3i7tztDIZSeDNr2E=;
        b=cne+18cj+DSK4GOJ9Y6N+KS+ZYVKBU8Oqq/aR00/97Ml/z4KpR/Dsucumwb7GrP5Mg
         PqeObyZpzC8XdyLVp1rd+LkYXsLwU9FIr47RY8cZ9vDP+EP8ytPZf97cihQYDnzfNquL
         ZbNVQTFyRNGtm56GCaxih30dgBlp8LE2J0bcwC5PiUqR7H4KY5LTF4mbW5mCTemzu6O0
         f1uDh3nAGjQPYizOn5QnmEl4ywQ8y9tkc8jimbmDucPxG66ES0r6jpAm/hW1m2ZkOk0Q
         h6BPSm2bRVyZwMcSi+1Y86cHu4Vo95KSQlwYx4zLm6FtqCAA+muc4YsXhzeUBnjBtPKb
         OTDQ==
X-Gm-Message-State: AA+aEWawOU9l4tqZJ8mqhBVfE2XNEzhRtvh135sE4Rz+wZe+OvS8CCMj
        LZ2XeBDOH0WTKwq6WMJV46g=
X-Google-Smtp-Source: AFSGD/VV0svDIkJvqDbauQlr7WWzdWIg1lPiPMl0LAAhaK54Bl0ojaLrFwbdYsa8aibDLGjLS9mE2g==
X-Received: by 2002:a63:d949:: with SMTP id e9mr2103443pgj.24.1543514750609;
        Thu, 29 Nov 2018 10:05:50 -0800 (PST)
Received: from localhost.localdomain ([2620:0:1008:fd00:78b4:3a07:980a:287b])
        by smtp.gmail.com with ESMTPSA id m20sm3144867pgb.56.2018.11.29.10.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 10:05:49 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH] include: replace tsk to task in linux/sched/signal.h
Date:   Thu, 29 Nov 2018 10:05:47 -0800
Message-Id: <20181129180547.15976-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181121181650.8d2d6abcf83b9defb7195cd3@linux-foundation.org>
References: <20181121181650.8d2d6abcf83b9defb7195cd3@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file uses "task" 85 times and "tsk" 25 times. It should be better to
choose one of these variants.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 include/linux/sched/signal.h | 51 ++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 76b8399b17f6..0c3e396dca04 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -270,17 +270,18 @@ static inline int signal_group_exit(const struct signal_struct *sig)
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
-extern int dequeue_signal(struct task_struct *tsk, sigset_t *mask, kernel_siginfo_t *info);
+extern int dequeue_signal(struct task_struct *task,
+			  sigset_t *mask, kernel_siginfo_t *info);
 
 static inline int kernel_dequeue_signal(void)
 {
-	struct task_struct *tsk = current;
+	struct task_struct *task = current;
 	kernel_siginfo_t __info;
 	int ret;
 
-	spin_lock_irq(&tsk->sighand->siglock);
-	ret = dequeue_signal(tsk, &tsk->blocked, &__info);
-	spin_unlock_irq(&tsk->sighand->siglock);
+	spin_lock_irq(&task->sighand->siglock);
+	ret = dequeue_signal(task, &task->blocked, &__info);
+	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
 }
@@ -418,18 +419,18 @@ static inline void set_restore_sigmask(void)
 	WARN_ON(!test_thread_flag(TIF_SIGPENDING));
 }
 
-static inline void clear_tsk_restore_sigmask(struct task_struct *tsk)
+static inline void clear_tsk_restore_sigmask(struct task_struct *task)
 {
-	clear_tsk_thread_flag(tsk, TIF_RESTORE_SIGMASK);
+	clear_tsk_thread_flag(task, TIF_RESTORE_SIGMASK);
 }
 
 static inline void clear_restore_sigmask(void)
 {
 	clear_thread_flag(TIF_RESTORE_SIGMASK);
 }
-static inline bool test_tsk_restore_sigmask(struct task_struct *tsk)
+static inline bool test_tsk_restore_sigmask(struct task_struct *task)
 {
-	return test_tsk_thread_flag(tsk, TIF_RESTORE_SIGMASK);
+	return test_tsk_thread_flag(task, TIF_RESTORE_SIGMASK);
 }
 static inline bool test_restore_sigmask(void)
 {
@@ -448,9 +449,9 @@ static inline void set_restore_sigmask(void)
 	current->restore_sigmask = true;
 	WARN_ON(!test_thread_flag(TIF_SIGPENDING));
 }
-static inline void clear_tsk_restore_sigmask(struct task_struct *tsk)
+static inline void clear_tsk_restore_sigmask(struct task_struct *task)
 {
-	tsk->restore_sigmask = false;
+	task->restore_sigmask = false;
 }
 static inline void clear_restore_sigmask(void)
 {
@@ -460,9 +461,9 @@ static inline bool test_restore_sigmask(void)
 {
 	return current->restore_sigmask;
 }
-static inline bool test_tsk_restore_sigmask(struct task_struct *tsk)
+static inline bool test_tsk_restore_sigmask(struct task_struct *task)
 {
-	return tsk->restore_sigmask;
+	return task->restore_sigmask;
 }
 static inline bool test_and_clear_restore_sigmask(void)
 {
@@ -616,9 +617,9 @@ static inline struct pid *task_session(struct task_struct *task)
 	return task->signal->pids[PIDTYPE_SID];
 }
 
-static inline int get_nr_threads(struct task_struct *tsk)
+static inline int get_nr_threads(struct task_struct *task)
 {
-	return tsk->signal->nr_threads;
+	return task->signal->nr_threads;
 }
 
 static inline bool thread_group_leader(struct task_struct *p)
@@ -657,35 +658,35 @@ static inline int thread_group_empty(struct task_struct *p)
 #define delay_group_leader(p) \
 		(thread_group_leader(p) && !thread_group_empty(p))
 
-extern struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
+extern struct sighand_struct *__lock_task_sighand(struct task_struct *task,
 							unsigned long *flags);
 
-static inline struct sighand_struct *lock_task_sighand(struct task_struct *tsk,
+static inline struct sighand_struct *lock_task_sighand(struct task_struct *task,
 						       unsigned long *flags)
 {
 	struct sighand_struct *ret;
 
-	ret = __lock_task_sighand(tsk, flags);
-	(void)__cond_lock(&tsk->sighand->siglock, ret);
+	ret = __lock_task_sighand(task, flags);
+	(void)__cond_lock(&task->sighand->siglock, ret);
 	return ret;
 }
 
-static inline void unlock_task_sighand(struct task_struct *tsk,
+static inline void unlock_task_sighand(struct task_struct *task,
 						unsigned long *flags)
 {
-	spin_unlock_irqrestore(&tsk->sighand->siglock, *flags);
+	spin_unlock_irqrestore(&task->sighand->siglock, *flags);
 }
 
-static inline unsigned long task_rlimit(const struct task_struct *tsk,
+static inline unsigned long task_rlimit(const struct task_struct *task,
 		unsigned int limit)
 {
-	return READ_ONCE(tsk->signal->rlim[limit].rlim_cur);
+	return READ_ONCE(task->signal->rlim[limit].rlim_cur);
 }
 
-static inline unsigned long task_rlimit_max(const struct task_struct *tsk,
+static inline unsigned long task_rlimit_max(const struct task_struct *task,
 		unsigned int limit)
 {
-	return READ_ONCE(tsk->signal->rlim[limit].rlim_max);
+	return READ_ONCE(task->signal->rlim[limit].rlim_max);
 }
 
 static inline unsigned long rlimit(unsigned int limit)
-- 
2.17.2

