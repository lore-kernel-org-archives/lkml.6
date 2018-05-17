Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427043-1526531731-2-4988148145688880571
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES ro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526531730; b=MZ4JxB1kdoBKJU6HTx6CehNbgRDId1ePgjC/K1TmYe+ElFDiOm
    vKxaoQOMC3IoVh3W928LJLcV0NTP7sYyQxrlqjkTE6o4pQ4BxpBZem9FY2Fr45ow
    9HZC4dnJXR8FvMzYzP2bLKJpTYFEvxJh+7J/xcBReiKg95HrFgGeIywSb0lEtS3d
    YuMZfGORx1XZ5C8pdR0sGy0J9k44ekyZ0jo4Cai9JoOHTPKof+a4pSDZY1+9TSoo
    OrbNKKi7fr5Lf/6EfS8F2Dx9+JFoNZKeS01cDdmz2FOj5agr/bKV8KhV4I6XdneB
    5bksFtUnSHz+EyyN4nIQWDFKeM5SodcinxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526531730; bh=
    HIzOHPayKyZnYwDzqIqqM3Z417oIjDKSXdf3Tbarx7w=; b=k7DryzTB1kFThegQ
    awfR6qwO9VHbgwkl5TRDB7ncbXkzJN+sgAtuivrHkq5ZhV+4aH3B7P4CEVxpBEM2
    0kI+jUG/E+I8edOwCymlmxzjpIs36di7D2uuhlm0XN0DtY+Z909AHjhNSau8WqwE
    yGW+4/D2r7b1QmkTR6ISjmojpiazbQ+Rnnyw9S4esw/meo4oEI0cILEwnIwZuIC6
    5OmCi0qdemMeQSzwhqhKV2lJICtXcnSJiy96lnqx4BtfkkMxa/Ou2mQ5mJc0GZZc
    F//233WObvBSTJNp8otyAFdAcF6ud9b8/umKxCGvJoaGAZK83B85ZuWTETxeazhr
    zxttog==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=o1PRZVQj x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Emh2A/UL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=o1PRZVQj x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Emh2A/UL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFgkA68GXufImg+51kyMLcqJWGQhjVr2QrcAZrvgYXn5BuTIQV7WgYrHCsEWKvJjq6ox2WonL+QFj7Y//GgvLLWc/mYMucsL4A2m7U/LzB94BlEKdzr3
    OeTed1bCl07eC+gRPn9cgdfYyDXensRchX+/ghXSc1FhzGmNX2HH7RratXPF3vfS49iUoalmtHzVYKEJzfOMGlyuKkM96t+MlZEDMRY6NvRZnH5FJ8zAq3Ct
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=qPtGF5O9dAw_yJMKWYMA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeEQEfN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 00:35:13 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35195 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeEQEfK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 00:35:10 -0400
X-Google-Smtp-Source: AB8JxZqjRFH4u/aN6x2HqJZ/3uZfJNgthwPOJo3uTuKt7dQbCwNpCZxZU6Eedr/qYDIfVSM6fBcTtw==
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, csmall@enc.com.au, Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] proc: Consolidate task->comm formatting into proc_task_name()
Date: Wed, 16 May 2018 21:34:47 -0700
Message-Id: <20180517043448.3152269-6-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180517043448.3152269-1-tj@kernel.org>
References: <20180517043448.3152269-1-tj@kernel.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

proc shows task->comm in three places - comm, stat, status - and each
is fetching and formatting task->comm slighly differently.  This patch
renames task_name() to proc_task_name(), makes it more generic, and
updates all three paths to use it.

This will enable expanding comm reporting for workqueue workers.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/proc/array.c    | 26 +++++++++++++++-----------
 fs/proc/base.c     |  5 ++---
 fs/proc/internal.h |  2 ++
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index ae2c807..f29221e 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -95,7 +95,7 @@
 #include <asm/processor.h>
 #include "internal.h"
 
-static inline void task_name(struct seq_file *m, struct task_struct *p)
+void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 {
 	char *buf;
 	size_t size;
@@ -104,13 +104,17 @@ static inline void task_name(struct seq_file *m, struct task_struct *p)
 
 	get_task_comm(tcomm, p);
 
-	seq_puts(m, "Name:\t");
-
 	size = seq_get_buf(m, &buf);
-	ret = string_escape_str(tcomm, buf, size, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
-	seq_commit(m, ret < size ? ret : -1);
+	if (escape) {
+		ret = string_escape_str(tcomm, buf, size,
+					ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
+		if (ret >= size)
+			ret = -1;
+	} else {
+		ret = strscpy(buf, tcomm, size);
+	}
 
-	seq_putc(m, '\n');
+	seq_commit(m, ret);
 }
 
 /*
@@ -365,7 +369,10 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 {
 	struct mm_struct *mm = get_task_mm(task);
 
-	task_name(m, task);
+	seq_puts(m, "Name:\t");
+	proc_task_name(m, task, true);
+	seq_putc(m, '\n');
+
 	task_state(m, ns, pid, task);
 
 	if (mm) {
@@ -400,7 +407,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	u64 cutime, cstime, utime, stime;
 	u64 cgtime, gtime;
 	unsigned long rsslim = 0;
-	char tcomm[sizeof(task->comm)];
 	unsigned long flags;
 
 	state = *get_task_state(task);
@@ -427,8 +433,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		}
 	}
 
-	get_task_comm(tcomm, task);
-
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
 	cutime = cstime = utime = stime = 0;
@@ -495,7 +499,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
 	seq_puts(m, " (");
-	seq_puts(m, tcomm);
+	proc_task_name(m, task, false);
 	seq_puts(m, ") ");
 	seq_putc(m, state);
 	seq_put_decimal_ll(m, " ", ppid);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 2eee4d7..eb17917ca 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1581,9 +1581,8 @@ static int comm_show(struct seq_file *m, void *v)
 	if (!p)
 		return -ESRCH;
 
-	task_lock(p);
-	seq_printf(m, "%s\n", p->comm);
-	task_unlock(p);
+	proc_task_name(m, p, false);
+	seq_putc(m, '\n');
 
 	put_task_struct(p);
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 0f1692e..b823fac62 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -131,6 +131,8 @@ unsigned name_to_int(const struct qstr *qstr);
  */
 extern const struct file_operations proc_tid_children_operations;
 
+extern void proc_task_name(struct seq_file *m, struct task_struct *p,
+			   bool escape);
 extern int proc_tid_stat(struct seq_file *, struct pid_namespace *,
 			 struct pid *, struct task_struct *);
 extern int proc_tgid_stat(struct seq_file *, struct pid_namespace *,
-- 
2.9.5

