Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427043-1526531752-2-2211808809040480464
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526531751; b=PwluVsTU88lms4WHJjYCU3n+Gq+oFYhJz7R+fAjVm2upqFK1FH
    CDo88mcJouq8TZs1XkxUxXdZKce9kwaOry/Tk49s/GaKgaoA6oPq1tbRMQ71uKyg
    lGZFdy6ZeQ1S4iU1zKY7q6VQ20jDhLE/yF+s231ZJGkecMbhX+6JJZM3+g2AtrS3
    mzaA9QhqL604U9G+WLOq0SmcWqCHocCiN4JVk+jJNEmrD2VV00K3YS+FEdSGRVoT
    0+ehTYEHIbuys/TZ0BP8YqSodM8gqHCoccRKlRnBJy9M06tonGY+nrs/EgAyiGRR
    C1kNPJrez2PImp3oQ0y3N3jnx8Iw8oMaILMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526531751; bh=
    iXR9Risbd6LaJ+7glo0h4Jy8XeB7CGCroDcM4zL1unE=; b=SiA1rw4PxeKyKANF
    u8WxuJcGoxQuHcZHuJXzNoaYjQfQa795e/d1DmGYiB085FJ7yJ96uDkcF+1EeHuG
    FWKuAAy9IokZVqN6aXMOMNyAgv9Be+QhA063loHRuUSLFyiOB1oWLu/y2pilauwf
    EzEW8xsH2D8cgRUCrP2w22aPy2ES1bIL22s4ueQC93hqMSkItaW8EcVqYtQVbkSx
    6Fy94jLhBmB5F29Ab7FrGseTEONavlI5FUBOol6VyWoijNHUMmGOp3fUMcA6Yldl
    qWnAUaZ6BAv4VNmTIHH7kQYuvazeYqWcSMsfh5JNslWR0rIyA6r01xBfqR13CwGS
    hvMkJA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=jNLioZPz x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=PZ1BzX9t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=jNLioZPz x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=PZ1BzX9t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPJhUOUmkl4ARaapTmwkzR5Q8506UqxYTZApXGddKey7JtZ6VPJez9hDjfGMEzYMMJfTS3rcDrJ0prEGM1sCT1BbyfbQu284mkR4jWlQt2jLTL94iW29
    1rMDpJfgi7NMmfW6J3TEwk11sIUf47TsOyYuoFDWVvPW/Q8hht4APn3TQNXpuGP8EZAZvvx06y4JMPdSSLMbZKm3EiBXKL9SxuZrOV+/LffRLzf3cpGHeaE1
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=OvHI6wMX6yb8nBPH2uYA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeEQEfJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 00:35:09 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43676 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQEfH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 00:35:07 -0400
X-Google-Smtp-Source: AB8JxZoYYpdmlqyahCe0JPaDD0X9NDQuqLHPwFcTEFR5levvSwxuVhrKui5sXwpioqjRvf2myXYqzg==
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, csmall@enc.com.au, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] workqueue: Set worker->desc to workqueue name by default
Date: Wed, 16 May 2018 21:34:46 -0700
Message-Id: <20180517043448.3152269-5-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180517043448.3152269-1-tj@kernel.org>
References: <20180517043448.3152269-1-tj@kernel.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Work functions can use set_worker_desc() to improve the visibility of
what the worker task is doing.  Currently, the desc field is unset at
the beginning of each execution and there is a separate field to track
the field is set during the current execution.

Instead of leaving empty till desc is set, worker->desc can be used to
remember the last workqueue the worker worked on by default and users
that use set_worker_desc() can override it to something more
informative as necessary.

This simplifies desc handling and helps tracking the last workqueue
that the worker exected on to improve visibility.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c          | 21 ++++++++++-----------
 kernel/workqueue_internal.h |  1 -
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2fde50f..3fbe007 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2088,6 +2088,12 @@ __acquires(&pool->lock)
 	worker->current_pwq = pwq;
 	work_color = get_work_color(work);
 
+	/*
+	 * Record wq name for cmdline and debug reporting, may get
+	 * overridden through set_worker_desc().
+	 */
+	strscpy(worker->desc, pwq->wq->name, WORKER_DESC_LEN);
+
 	list_del_init(&work->entry);
 
 	/*
@@ -2183,7 +2189,6 @@ __acquires(&pool->lock)
 	worker->current_work = NULL;
 	worker->current_func = NULL;
 	worker->current_pwq = NULL;
-	worker->desc_valid = false;
 	pwq_dec_nr_in_flight(pwq, work_color);
 }
 
@@ -4346,7 +4351,6 @@ void set_worker_desc(const char *fmt, ...)
 		va_start(args, fmt);
 		vsnprintf(worker->desc, sizeof(worker->desc), fmt, args);
 		va_end(args);
-		worker->desc_valid = true;
 	}
 }
 
@@ -4370,7 +4374,6 @@ void print_worker_info(const char *log_lvl, struct task_struct *task)
 	char desc[WORKER_DESC_LEN] = { };
 	struct pool_workqueue *pwq = NULL;
 	struct workqueue_struct *wq = NULL;
-	bool desc_valid = false;
 	struct worker *worker;
 
 	if (!(task->flags & PF_WQ_WORKER))
@@ -4383,22 +4386,18 @@ void print_worker_info(const char *log_lvl, struct task_struct *task)
 	worker = kthread_probe_data(task);
 
 	/*
-	 * Carefully copy the associated workqueue's workfn and name.  Keep
-	 * the original last '\0' in case the original contains garbage.
+	 * Carefully copy the associated workqueue's workfn, name and desc.
+	 * Keep the original last '\0' in case the original is garbage.
 	 */
 	probe_kernel_read(&fn, &worker->current_func, sizeof(fn));
 	probe_kernel_read(&pwq, &worker->current_pwq, sizeof(pwq));
 	probe_kernel_read(&wq, &pwq->wq, sizeof(wq));
 	probe_kernel_read(name, wq->name, sizeof(name) - 1);
-
-	/* copy worker description */
-	probe_kernel_read(&desc_valid, &worker->desc_valid, sizeof(desc_valid));
-	if (desc_valid)
-		probe_kernel_read(desc, worker->desc, sizeof(desc) - 1);
+	probe_kernel_read(desc, worker->desc, sizeof(desc) - 1);
 
 	if (fn || name[0] || desc[0]) {
 		printk("%sWorkqueue: %s %pf", log_lvl, name, fn);
-		if (desc[0])
+		if (strcmp(name, desc))
 			pr_cont(" (%s)", desc);
 		pr_cont("\n");
 	}
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index 4a182e0..66fbb5a 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -31,7 +31,6 @@ struct worker {
 	struct work_struct	*current_work;	/* L: work being processed */
 	work_func_t		current_func;	/* L: current_work's fn */
 	struct pool_workqueue	*current_pwq; /* L: current_work's pwq */
-	bool			desc_valid;	/* ->desc is valid */
 	struct list_head	scheduled;	/* L: scheduled works */
 
 	/* 64 bytes boundary on 64bit, 32 on 32bit */
-- 
2.9.5

