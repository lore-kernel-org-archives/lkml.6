Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427043-1526531732-2-11608947930169297288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES encaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526531732; b=CN2uXUyMD4CGPWCbuGfZF9SmLWDWHlYXd6BIDhAxX2Q16fBrk/
    rjrkzidtYf29IBeqeZhyb3lvdaD2PziXgpeWVWzX9A7XDnX1+MlHYn+jJ5gECwK6
    ecXfxMIaMprl7BCOK7rVC9cwMkqLXM6gzbU6dL4+GqXtXP0nwszeFqhivBPaauSv
    +zlMTnRBsp0C4IEdC/bzI+AFuFePCByzB6PlDC7TTxG5gBIlJikN7ZVKrLdcNBfK
    KH1wu8v5Il7AJ6yNVpb0NhgA2DFL6iBikuV7cazVeHstiBk6FFGyc13/RWNFpp+M
    X+cBmYRFPOnwTot6BBWz3H51Y/7i80A/ZIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526531732; bh=
    tyy6MaJcebYV8UI4eNaKH+pR/wBogI9CuVl3zImJhNM=; b=da6Dd+8F722tzJkL
    pi4x53KvmU3kesJVkMHlRSVwCtCqv88CGYisuy8ZybmT87PnfgtO/ZIUpodSAnl8
    9ajzxfVQJ51kPMVvD0W40MEp/4V2WshKCcEKjitPHNAzRau8H4PmlYA8PI7I9loZ
    MPUGG1rG9pVadH5sS5OIMrgkArqah+VgYg7U7CZ3eGFos5BIE/LIXALrUFuGxozC
    bCwI2kyGLxIxHjXINx96Hu9c21a0Tlmv3qbTnAQnak4NUg1QxJnsMVJ/5dWXmOY6
    YWlRJqj0wukFzpttj9cnqUgLw4PRu6T+k7CbgRSZtPpniqHmWV8GOlLHuPb/3mhF
    t5ot0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Lap1F5O6 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=uMqhECAj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Lap1F5O6 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=uMqhECAj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO902W6cnNjwZY6b4fhg0pBILc56gTyZbgdXbaWFDSk3WiTA3Slb78bWP3Lt/S6IoOJWF6E1RxPSR1VrAJDW5eoPbyqNdxLPj9OVZrq/U3PIw196gSK6
    Zif1oyjfEqz9XWj61H9hYjdSdPr9cNuSttw0ASWpTCd7IVoLYmurkYJ4sSdvkShZZ3wAnrf7cyqkh+JQsWYc97bvLmUdVorjyxFEOIArnSCJMQecAxA/KwE/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=JkJkeMVtAAAA:8 a=m5uOk16tKKtbGB0r1FUA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Aj2ThV04E2MXvoCGQ7Gm:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750723AbeEQEf2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 00:35:28 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43666 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQEfN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 00:35:13 -0400
X-Google-Smtp-Source: AB8JxZpE/tj2SEJAi5IAzI+tB2sZLnT9RqBVa8Jueqy4mG3oXXxqeVwm8qyp+M7/RndJd6CxefdeRg==
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, csmall@enc.com.au, Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] workqueue: Show the latest workqueue name in /proc/PID/{comm,stat,status}
Date: Wed, 16 May 2018 21:34:48 -0700
Message-Id: <20180517043448.3152269-7-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180517043448.3152269-1-tj@kernel.org>
References: <20180517043448.3152269-1-tj@kernel.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There can be a lot of workqueue workers and they all show up with the
cryptic kworker/* names making it difficult to understand which is
doing what and how they came to be.

  # ps -ef | grep kworker
  root           4       2  0 Feb25 ?        00:00:00 [kworker/0:0H]
  root           6       2  0 Feb25 ?        00:00:00 [kworker/u112:0]
  root          19       2  0 Feb25 ?        00:00:00 [kworker/1:0H]
  root          25       2  0 Feb25 ?        00:00:00 [kworker/2:0H]
  root          31       2  0 Feb25 ?        00:00:00 [kworker/3:0H]
  ...

This patch makes workqueue workers report the latest workqueue it was
executing for through /proc/PID/{comm,stat,status}.  The extra
information is appended to the kthread name with intervening '+' if
currently executing, otherwise '-'.

  # cat /proc/25/comm
  kworker/2:0-events_power_efficient
  # cat /proc/25/stat
  25 (kworker/2:0-events_power_efficient) I 2 0 0 0 -1 69238880 0 0...
  # grep Name /proc/25/status
  Name:   kworker/2:0-events_power_efficient

Unfortunately, ps(1) truncates comm to 15 characters,

  # ps 25
    PID TTY      STAT   TIME COMMAND
     25 ?        I      0:00 [kworker/2:0-eve]

making it a lot less useful; however, this should be an easy fix from
ps(1) side.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Craig Small <csmall@enc.com.au>
---
 fs/proc/array.c           |  7 +++++--
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index f29221e..bb1d361 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -99,10 +99,13 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 {
 	char *buf;
 	size_t size;
-	char tcomm[sizeof(p->comm)];
+	char tcomm[64];
 	int ret;
 
-	get_task_comm(tcomm, p);
+	if (p->flags & PF_WQ_WORKER)
+		wq_worker_comm(tcomm, sizeof(tcomm), p);
+	else
+		__get_task_comm(tcomm, sizeof(tcomm), p);
 
 	size = seq_get_buf(m, &buf);
 	if (escape) {
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 39a0e21..60d673e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -494,6 +494,7 @@ extern unsigned int work_busy(struct work_struct *work);
 extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
 extern void print_worker_info(const char *log_lvl, struct task_struct *task);
 extern void show_workqueue_state(void);
+extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
 
 /**
  * queue_work - queue work on a workqueue
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3fbe007..b4a39a1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4577,6 +4577,45 @@ void show_workqueue_state(void)
 	rcu_read_unlock_sched();
 }
 
+/* used to show worker information through /proc/PID/{comm,stat,status} */
+void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
+{
+	struct worker *worker;
+	struct worker_pool *pool;
+	int off;
+
+	/* always show the actual comm */
+	off = strscpy(buf, task->comm, size);
+	if (off < 0)
+		return;
+
+	/* stabilize worker pool association */
+	mutex_lock(&wq_pool_attach_mutex);
+
+	worker = kthread_data(task);
+	pool = worker->pool;
+
+	if (pool) {
+		spin_lock_irq(&pool->lock);
+		/*
+		 * ->desc tracks information (wq name or set_worker_desc())
+		 * for the latest execution.  If current, prepend '+',
+		 * otherwise '-'.
+		 */
+		if (worker->desc[0] != '\0') {
+			if (worker->current_work)
+				scnprintf(buf + off, size - off, "+%s",
+					  worker->desc);
+			else
+				scnprintf(buf + off, size - off, "-%s",
+					  worker->desc);
+		}
+		spin_unlock_irq(&pool->lock);
+	}
+
+	mutex_unlock(&wq_pool_attach_mutex);
+}
+
 /*
  * CPU hotplug.
  *
-- 
2.9.5

