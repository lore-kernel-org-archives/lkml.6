Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D133C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634A21A12
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="P6oHQKIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1634A21A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934364AbeGDJS4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:18:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38852 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933831AbeGDJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:18:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id j33-v6so4572503wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=esHqllM1j8206m3T9oOD2EF64ViguVZxA1G0+vULoaI=;
        b=P6oHQKIfskHZOvx0/XKerur5GFrwXZfKEEZj740+ObgBh9R71LQcHg96C4fvyfbCGQ
         gpbYDVKqCHZ7s5e1TCIiuE5dmdYQFVvOu4yhsBfUAzuyvBO9ivSXqkC71Y0HwJYKq3ED
         QaXx10gvedgLZl2+oGXiCKUeTX8sXKVTazhmfGtblv/lbSEINvRRjFOMj1Yxikr4u6Lz
         Z/tN0mxbzJW3h+0qfpc/aZoG2rwUHHH/XhlFvnTrNBCfEbK+52GmR4SII48QGY/lPX5A
         7z4kSuMhRzj9yqXQjj+Bqrf0JZ71S4uTDXu/IdaZhXTkV5ngtemoY5xjMryjRzSunuEY
         F1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=esHqllM1j8206m3T9oOD2EF64ViguVZxA1G0+vULoaI=;
        b=rxMAKs0Db106F3R4lXhbmT7jxN3znYaiVtyEbos5FEF7bk9iRs+KDCKsmTJ/7J/U+T
         hRJVJ3sWtV3StmhhlzozvetYqk48uceRf2OZEMvjpOjNK5ocuvZTBPpVVVl2HYqAwG5Q
         RMLyVXfnyvmf1kxBL/3L/yunTcM9z9Jg5SI1bpD+NgFMvHlI37kTlbE+aCUUM1V6MNnR
         cVX5q+txPwmRppahGUNxwVkvABeDpjEEdwU3sAXLgnJIJG1UvVN74ciLT8cj7ItQ+W3G
         fVz8Pbyd10y6CrNRUoDPqa+wt+hgATAOsAkZ7P46csNuyNdaLdGXsC7wioE/6kPRIO6C
         dRbw==
X-Gm-Message-State: APt69E31hSP0dp0nGv3sj+2+Jw0WHzxzp0L38M9JC7BmycM3kXwKpgpm
        cMxzyL1Z294c9HDEDSAV4KDK3Q==
X-Google-Smtp-Source: AAOMgpdybIgAkgT1th8NsgPftZHtGgQdvTDFYIM5j4TPxwy0srEVm1Il8mpJU14E9AESOQ/UDw9WGQ==
X-Received: by 2002:adf:e311:: with SMTP id b17-v6mr1044737wrj.158.1530695927214;
        Wed, 04 Jul 2018 02:18:47 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C3350004CADE66801158EF.dip0.t-ipconnect.de. [2003:d9:93c3:3500:4ca:de66:8011:58ef])
        by smtp.googlemail.com with ESMTPSA id t53-v6sm1985038wrc.13.2018.07.04.02.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 02:18:45 -0700 (PDT)
Subject: Re: ipc/msg: zalloc struct msg_queue when creating a new msq
To:     Dmitry Vyukov <dvyukov@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     syzbot <syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>
References: <000000000000e403b3056e76c786@google.com>
 <20180624025651.bvjlcfulbmycz5bf@linux-r8p5>
 <CACT4Y+anMTUCaRH5D4QoZR4bLdtH=_wtCxK2dM6isJozbVThDg@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <ff30f992-9c75-f230-c86a-902373f4ecaa@colorfullife.com>
Date:   Wed, 4 Jul 2018 11:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+anMTUCaRH5D4QoZR4bLdtH=_wtCxK2dM6isJozbVThDg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------E94E9557229FCA8A59998C09"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E94E9557229FCA8A59998C09
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello together,

On 06/25/2018 11:21 AM, Dmitry Vyukov wrote:
> On Sun, Jun 24, 2018 at 4:56 AM, Davidlohr Bueso <dave@stgolabs.net> wrote:
>> The following splat was reported around the msg_queue structure
>> which can have uninitialized fields left over after newque().
>> Future syscalls which make use of the msq id (now valid) can thus
>> make KMSAN complain because not all fields are explicitly initialized
>> and we have the padding as well. This is internal to the kernel,
>> hence no bogus leaks.
> Hi Davidlohr,
>
> As far as I understand the root problem is that (1) we publish a
> not-fully initialized objects and (2) finish it's initialization in a
> racy manner when other threads already have access to it. As the
> result other threads can act on a wrong object. I am not sure that
> zeroing the object really solves these problems. It will sure get rid
> of the report at hand (but probably not of KTSAN, data race detector,
> report), other threads still can see wrong 0 id and the id is still
> initialized in racy way. I would expect that a proper fix would be to
> publish a fully initialized object with proper, final id. Am I missing
> something?
There are 2 relevant values: kern_ipc_perm.id and kern_ipc_perm.seq.

For kern_ipc_perm.id, it is possible to move the access to the codepath 
that hold the lock.

For kern_ipc_perm.seq, there are two options:
1) set it before publication.
2) initialize to an invalid value, and correct that at the end.

I'm in favor of option 2, it avoids that we must think about reducing 
the next sequence number or not:

The purpose of the sequence counter is to minimize the risk that e.g. a 
semop() will write into a newly created array.
I intentially write "minimize the risk", as it is by design impossible 
to guarantee that this cannot happen, e.g. if semop() sleeps at the 
instruction before the syscall.

Therefore, we can set seq to ULONG_MAX, then ipc_checkid() will always 
fail and the corruption is avoided.

What do you think?

And, obviously:
Just set seq to 0 is dangerous, as the first allocated sequence number 
is 0, and if that object is destroyed, then the newly created object has 
temporarily sequence number 0 as well.

--
     Manfred

--------------E94E9557229FCA8A59998C09
Content-Type: text/x-patch;
 name="0001-ipc-initialize-kern_ipc_perm.id-earlier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ipc-initialize-kern_ipc_perm.id-earlier.patch"

From 4791e604dcb618ed7ea1f42b2f6ca9cfe3c113c3 Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Wed, 4 Jul 2018 10:04:49 +0200
Subject: [PATCH] ipc: fix races with kern_ipc_perm.id and .seq

ipc_addid() initializes kern_ipc_perm.id and kern_ipc_perm.seq after
having called ipc_idr_alloc().

Thus a parallel semop() or msgrcv() that uses ipc_obtain_object_idr()
may see an uninitialized value.

The simple solution cannot be used, as the correct id is only known
after ipc_idr_alloc().

Therefore:
- Initialize kern_ipc_perm.seq to an invalid value, so that
  ipc_checkid() is guaranteed to fail.
  This fulfills the purpose of the sequence counter: If e.g. semget() and
  semop() run in parallel, then the semop() should not write into the
  newly created array.
- Move the accesses to kern_ipc_perm.id into the code that is protected
  by kern_ipc_perm.lock.

The patch also fixes a use-after free that can be triggered by concurrent
semget() and semctl(IPC_RMID): reading kern_ipc_perm.id must happen
before dropping the locks.

Reported-by: syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/msg.c  | 23 +++++++++++++++++------
 ipc/sem.c  | 23 ++++++++++++++++-------
 ipc/shm.c  | 19 ++++++++++++++-----
 ipc/util.c |  8 +++++++-
 4 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 724000c15296..551c10be8d06 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -166,10 +166,12 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 		return retval;
 	}
 
+	retval = msq->q_perm.id;
+
 	ipc_unlock_object(&msq->q_perm);
 	rcu_read_unlock();
 
-	return msq->q_perm.id;
+	return retval;
 }
 
 static inline bool msg_fits_inqueue(struct msg_queue *msq, size_t msgsz)
@@ -491,7 +493,6 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 			 int cmd, struct msqid64_ds *p)
 {
 	struct msg_queue *msq;
-	int id = 0;
 	int err;
 
 	memset(p, 0, sizeof(*p));
@@ -503,7 +504,6 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 			err = PTR_ERR(msq);
 			goto out_unlock;
 		}
-		id = msq->q_perm.id;
 	} else { /* IPC_STAT */
 		msq = msq_obtain_object_check(ns, msqid);
 		if (IS_ERR(msq)) {
@@ -548,10 +548,21 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	p->msg_lspid  = pid_vnr(msq->q_lspid);
 	p->msg_lrpid  = pid_vnr(msq->q_lrpid);
 
-	ipc_unlock_object(&msq->q_perm);
-	rcu_read_unlock();
-	return id;
+	if (cmd == IPC_STAT) {
+		/*
+		 * As defined in SUS:
+		 * Return 0 on success
+		 */
+		err = 0;
+	} else {
+		/*
+		 * MSG_STAT and MSG_STAT_ANY (both Linux specific)
+		 * Return the full id, including the sequence counter
+		 */
+		err = msq->q_perm.id;
+	}
 
+	ipc_unlock_object(&msq->q_perm);
 out_unlock:
 	rcu_read_unlock();
 	return err;
diff --git a/ipc/sem.c b/ipc/sem.c
index c269fae05b24..42fcd0979a46 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -567,13 +567,14 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 	}
 	ns->used_sems += nsems;
 
+	retval = sma->sem_perm.id;
+
 	sem_unlock(sma, -1);
 	rcu_read_unlock();
 
-	return sma->sem_perm.id;
+	return retval;
 }
 
-
 /*
  * Called with sem_ids.rwsem and ipcp locked.
  */
@@ -1228,7 +1229,6 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 {
 	struct sem_array *sma;
 	time64_t semotime;
-	int id = 0;
 	int err;
 
 	memset(semid64, 0, sizeof(*semid64));
@@ -1240,7 +1240,6 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 			err = PTR_ERR(sma);
 			goto out_unlock;
 		}
-		id = sma->sem_perm.id;
 	} else { /* IPC_STAT */
 		sma = sem_obtain_object_check(ns, semid);
 		if (IS_ERR(sma)) {
@@ -1280,10 +1279,20 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 #endif
 	semid64->sem_nsems = sma->sem_nsems;
 
+	if (cmd == IPC_STAT) {
+		/*
+		 * As defined in SUS:
+		 * Return 0 on success
+		 */
+		err = 0;
+	} else {
+		/*
+		 * SEM_STAT and SEM_STAT_ANY (both Linux specific)
+		 * Return the full id, including the sequence counter
+		 */
+		err = sma->sem_perm.id;
+	}
 	ipc_unlock_object(&sma->sem_perm);
-	rcu_read_unlock();
-	return id;
-
 out_unlock:
 	rcu_read_unlock();
 	return err;
diff --git a/ipc/shm.c b/ipc/shm.c
index 051a3e1fb8df..59fe8b3b3794 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -949,7 +949,6 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 			int cmd, struct shmid64_ds *tbuf)
 {
 	struct shmid_kernel *shp;
-	int id = 0;
 	int err;
 
 	memset(tbuf, 0, sizeof(*tbuf));
@@ -961,7 +960,6 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 			err = PTR_ERR(shp);
 			goto out_unlock;
 		}
-		id = shp->shm_perm.id;
 	} else { /* IPC_STAT */
 		shp = shm_obtain_object_check(ns, shmid);
 		if (IS_ERR(shp)) {
@@ -1011,10 +1009,21 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	tbuf->shm_lpid	= pid_vnr(shp->shm_lprid);
 	tbuf->shm_nattch = shp->shm_nattch;
 
-	ipc_unlock_object(&shp->shm_perm);
-	rcu_read_unlock();
-	return id;
+	if (cmd == IPC_STAT) {
+		/*
+		 * As defined in SUS:
+		 * Return 0 on success
+		 */
+		err = 0;
+	} else {
+		/*
+		 * SHM_STAT and SHM_STAT_ANY (both Linux specific)
+		 * Return the full id, including the sequence counter
+		 */
+		err = shp->shm_perm.id;
+	}
 
+	ipc_unlock_object(&shp->shm_perm);
 out_unlock:
 	rcu_read_unlock();
 	return err;
diff --git a/ipc/util.c b/ipc/util.c
index ba7f96fc8a61..ba696e3e0574 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -22,7 +22,7 @@
  *          obtain the ipc object (kern_ipc_perm) by looking up the id in an idr
  *	    tree.
  *	    - perform initial checks (capabilities, auditing and permission,
- *	      etc).
+ *	      check the sequence counter, etc).
  *	    - perform read-only operations, such as INFO command, that
  *	      do not demand atomicity
  *	      acquire the ipc lock (kern_ipc_perm.lock) through
@@ -270,6 +270,12 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	new->cuid = new->uid = euid;
 	new->gid = new->cgid = egid;
 
+	/*
+	 * Initialize ->seq to ULONG_MAX, so that any early ipc_checkid()
+	 * calls are guarenteed to fail.
+	 */
+	new->seq = ULONG_MAX;
+
 	id = ipc_idr_alloc(ids, new);
 	idr_preload_end();
 
-- 
2.14.4


--------------E94E9557229FCA8A59998C09--
