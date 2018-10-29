Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFBEC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAFE204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMONfDRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAFE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeJ3CnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:43:06 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:51546 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJ3CnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:43:06 -0400
Received: by mail-qt1-f201.google.com with SMTP id h4-v6so6760044qtc.18
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2A2AdDpJbd2uH09MtJnMiQzbXF9iaCgYTjowV4Fml04=;
        b=eMONfDRjBueGlbdjY0ODA3j12cuutQzOIpj6/6ihAhEa+S3JyeMXEd36t8Yny+qJk4
         DoVlJgsJjGtUfLcbrcmFBmmW+ekUtE6X2o+ZFdc+IgSy4Z7zQ1vfbJtnv4o4zYSiX47g
         AMOdF8QtQyCTKE8FzMZYzVQaYvbEBzbbww3QH/aW6iwnzVi6mcAcrqw1mU4FT40FhCu1
         ftf7a41zXyPphDC/8bbkhbhrqtc6AoM4l0X+wKeKZuonGZY+sC7aY22967FyJofQNIBq
         60XcK7XnylzaTWTQGsVilEewa6yhlO4+qOLjd6niON6VXdsO5uxz92y3WOstx4h1xQys
         7Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2A2AdDpJbd2uH09MtJnMiQzbXF9iaCgYTjowV4Fml04=;
        b=WxkiUD+LSzvf3kWLfd59MouP1Cl8v07TCbqjOxTu2ep9M6Sy8Q9hnczSastmy8jOXB
         8bxpdxsQaTTbnHP3cp8RF6v2JqWXTQDRRaY3ZD/ct9GsOg9T187oeIGmBuKIK0rtMoji
         w/ISmN3EMJhtVvMgtqSCs9w1zENoltHewsxpxpBz1ubIbcvkEijnKRGjl/M8uRgGKe77
         rM2dz/ylXp/HGlFZVxyRNGKBxcIFaicvZyJaaJplko+z5lP94Z9tPCggCHpenBUlwt9R
         lO/nKOsqqumHFADwUmNIcSq3dhB094oKR/ssiylo1R1cDM/vgNfjUilGGasE53JD43jX
         5IWA==
X-Gm-Message-State: AGRZ1gKl1rFvuW1boDtZtG9HjDAf/GyhkrevlGawNWyqz46/nOEYyyd0
        orAxTnz8tdfnuXKLKINZw4vWX63ywnnwepjEdmI6w0G7wOckdWR9xNvQlFoqA3wZUJyI5NwS5H9
        qhGSEgqhKyBMnwZMEtqVSWVxfpyxAEltbuOYNd0KVX22I8l6pnIHCAeiLeSGYV9a3ViwKMg==
X-Google-Smtp-Source: AJdET5eONr/Q53yIfgODn7S5/Uw+FEf560kV6UXhy3XRaOP6e3SKCEJ23AVT/rMYHTAWpPx5+K27Fz+KNP8=
X-Received: by 2002:ac8:3497:: with SMTP id w23mr480873qtb.21.1540835606061;
 Mon, 29 Oct 2018 10:53:26 -0700 (PDT)
Date:   Mon, 29 Oct 2018 17:53:22 +0000
Message-Id: <20181029175322.189042-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC PATCH] Minimal non-child process exit notification support
From:   Daniel Colascione <dancol@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     timmurray@google.com, joelaf@google.com,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new file under /proc/pid, /proc/pid/exithand.
Attempting to read from an exithand file will block until the
corresponding process exits, at which point the read will successfully
complete with EOF.  The file descriptor supports both blocking
operations and poll(2). It's intended to be a minimal interface for
allowing a program to wait for the exit of a process that is not one
of its children.

Why might we want this interface? Android's lmkd kills processes in
order to free memory in response to various memory pressure
signals. It's desirable to wait until a killed process actually exits
before moving on (if needed) to killing the next process. Since the
processes that lmkd kills are not lmkd's children, lmkd currently
lacks a way to wait for a proces to actually die after being sent
SIGKILL; today, lmkd resorts to polling the proc filesystem pid
entry. This interface allow lmkd to give up polling and instead block
and wait for process death.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/proc/Makefile             |   1 +
 fs/proc/base.c               |   1 +
 fs/proc/exithand.c           | 117 +++++++++++++++++++++++++++++++++++
 fs/proc/internal.h           |   4 ++
 include/linux/sched/signal.h |   7 +++
 kernel/exit.c                |   2 +
 kernel/signal.c              |   3 +
 7 files changed, 135 insertions(+)
 create mode 100644 fs/proc/exithand.c

diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index ead487e80510..21322280a2c1 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -27,6 +27,7 @@ proc-y	+= softirqs.o
 proc-y	+= namespaces.o
 proc-y	+= self.o
 proc-y	+= thread_self.o
+proc-y  += exithand.o
 proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
 proc-$(CONFIG_NET)		+= proc_net.o
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7e9f07bf260d..31bc6bbb6dc4 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3006,6 +3006,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_LIVEPATCH
 	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
 #endif
+	REG("exithand", S_IRUGO, proc_tgid_exithand_operations),
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/fs/proc/exithand.c b/fs/proc/exithand.c
new file mode 100644
index 000000000000..358b08da6a08
--- /dev/null
+++ b/fs/proc/exithand.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Synchronous exit notification of non-child processes
+ *
+ * Simple file descriptor /proc/pid/exithand. Read blocks (and poll
+ * reports non-readable) until process either dies or becomes
+ * a zombie.
+ */
+#include <linux/printk.h>
+#include <linux/sched/signal.h>
+#include <linux/poll.h>
+#include "internal.h"
+
+static int proc_tgid_exithand_open(struct inode *inode, struct file *file)
+{
+	struct task_struct* task = get_proc_task(inode);
+	/* If get_proc_task failed, it means the task is dead, which
+	 * is fine, since a subsequent read will return
+	 * immediately.  */
+	if (task && !thread_group_leader(task))
+		return -EINVAL;
+	return 0;
+}
+
+static ssize_t proc_tgid_exithand_read(struct file * file,
+				       char __user * buf,
+				       size_t count, loff_t *ppos)
+{
+	struct task_struct* task = NULL;
+	wait_queue_entry_t wait;
+	ssize_t res = 0;
+	bool locked = false;
+
+	for (;;) {
+		/* Retrieve the task from the struct pid each time
+		 * through the loop in case the exact struct task
+		 * changes underneath us (e.g., if in exec.c, the
+		 * execing process kills the group leader and starts
+		 * using its PID).  The struct signal should be the
+		 * same though even in this case.
+		 */
+		task = get_proc_task(file_inode(file));
+		res = 0;
+		if (!task)
+			goto out;  /* No task?  Must have died.  */
+
+		BUG_ON(!thread_group_leader(task));
+
+		/* Synchronizes with exit.c machinery. */
+		read_lock(&tasklist_lock);
+		locked = true;
+
+		res = 0;
+		if (task->exit_state)
+			goto out;
+
+		res = -EAGAIN;
+		if (file->f_flags & O_NONBLOCK)
+			goto out;
+
+		/* Tell exit.c to go to the trouble of waking our
+		 * runqueue when this process gets around to
+		 * exiting. */
+		task->signal->exithand_is_interested = true;
+
+		/* Even if the task identity changes, task->signal
+		 * should be invariant across the wait, making it safe
+		 * to go remove our wait record from the wait queue
+		 * after we come back from schedule.  */
+
+		init_waitqueue_entry(&wait, current);
+		add_wait_queue(&wait_exithand, &wait);
+
+		read_unlock(&tasklist_lock);
+		locked = false;
+
+		put_task_struct(task);
+		task = NULL;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&wait_exithand, &wait);
+
+		res = -ERESTARTSYS;
+		if (signal_pending(current))
+			goto out;
+	}
+out:
+	if (locked)
+		read_unlock(&tasklist_lock);
+	if (task)
+		put_task_struct(task);
+	return res;
+}
+
+static __poll_t proc_tgid_exithand_poll(struct file *file, poll_table *wait)
+{
+	__poll_t mask = 0;
+	struct task_struct* task = get_proc_task(file_inode(file));
+	if (!task) {
+		mask |= POLLIN;
+	} else if (READ_ONCE(task->exit_state)) {
+		mask |= POLLIN;
+	} else {
+		read_lock(&tasklist_lock);
+		task->signal->exithand_is_interested = true;
+		read_unlock(&tasklist_lock);
+		poll_wait(file,	&wait_exithand,	wait);
+	}
+	return mask;
+}
+
+const struct file_operations proc_tgid_exithand_operations = {
+	.open           = proc_tgid_exithand_open,
+	.read		= proc_tgid_exithand_read,
+	.poll           = proc_tgid_exithand_poll,
+};
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 5185d7f6a51e..1009d20475bc 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -304,3 +304,7 @@ extern unsigned long task_statm(struct mm_struct *,
 				unsigned long *, unsigned long *,
 				unsigned long *, unsigned long *);
 extern void task_mem(struct seq_file *, struct mm_struct *);
+
+/* exithand.c */
+
+extern const struct file_operations proc_tgid_exithand_operations;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 13789d10a50e..44131cb6c7f4 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -74,6 +74,10 @@ struct multiprocess_signals {
 	struct hlist_node node;
 };
 
+/* Need to stick the waitq for exithand outside process structures in
+ * case a process disappears across a poll.  */
+extern wait_queue_head_t wait_exithand;
+
 /*
  * NOTE! "signal_struct" does not have its own
  * locking, because a shared signal_struct always
@@ -87,6 +91,9 @@ struct signal_struct {
 	int			nr_threads;
 	struct list_head	thread_head;
 
+	/* Protected with tasklist_lock.  */
+	bool                    exithand_is_interested;
+
 	wait_queue_head_t	wait_chldexit;	/* for wait4() */
 
 	/* current thread group signal load-balancing target: */
diff --git a/kernel/exit.c b/kernel/exit.c
index 0e21e6d21f35..44a4e3796f8b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1485,6 +1485,8 @@ void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
 {
 	__wake_up_sync_key(&parent->signal->wait_chldexit,
 				TASK_INTERRUPTIBLE, 1, p);
+	if (p->signal->exithand_is_interested)
+		__wake_up_sync(&wait_exithand, TASK_INTERRUPTIBLE, 0);
 }
 
 static long do_wait(struct wait_opts *wo)
diff --git a/kernel/signal.c b/kernel/signal.c
index 17565240b1c6..e156d48da70a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -454,6 +454,9 @@ void flush_sigqueue(struct sigpending *queue)
 	}
 }
 
+wait_queue_head_t wait_exithand =
+	__WAIT_QUEUE_HEAD_INITIALIZER(wait_exithand);
+
 /*
  * Flush all pending signals for this kthread.
  */
-- 
2.19.1.568.g152ad8e336-goog

