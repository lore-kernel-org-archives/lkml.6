Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F5EC3417
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84E72124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="p4XDqZnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84E72124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeGLTD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:03:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39726 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeGLTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:03:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so22711443wre.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5OGrgO27F2NTCuxxW8AjgNNATlch22dFs7igXFPN7x4=;
        b=p4XDqZnnU1kCMR96doWPW09Mu8/QMaYIrkND0tXcAAuR0C2neIRFUHc1I+2NK8uarH
         X8RUNb4v3FOHShY0dONVEvXQJg3eYqmmptSPyno11ymRN2cg1e54G1O3vUvYfFW4xK18
         QD/ZyqgFWsN1GgM5iZalCddmPdWbB2mx35EZym5cew3Pp5jsEPl/jzdSz7B1JgBydOBd
         oGth5oiZ+kPnLMzeY2ipVCxNCgDqmd03G1miOWknR0HrNIFwg1CsiU9THEuYjgyLp1nk
         ESE4b6baTNfqHU3g1RCYjfHBX7p7Y0U5/6YsXGjQ0tF+stg2yRiFumEDVYyWqIcJcFEH
         wWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5OGrgO27F2NTCuxxW8AjgNNATlch22dFs7igXFPN7x4=;
        b=jhNNBSCcQuMiH1iO5lzPPLrMIGTWuPEm9hZArthRkRPxYV5+tq/mf7YOmJqKRHGfpN
         0kAXZcdi7ljsnp6u6masNkkGbGJ/fwm9KAddDoL+GVIO5Cf+kCj9Wuv5z2UCrk9JZkkd
         AidxCyG1BF64BpDJnp2lmNXCQvOPOI43La6VsMFuWmZ+M0/AmTypgRTgR/Z0lWrf1WQc
         yzy183whOGTLpR0dHPzy2Drt29WwBKLiDytqiX+rt4+54GtM5gqTJmagc4xt7/E+g1XC
         PWAlzeCaIzi3J40jp6KpLPreKNkbdZSYt+Pn2N7KkMHqDQ3IeUrYWBZBacW7wMmLlhiT
         JijA==
X-Gm-Message-State: AOUpUlHBeZMeEFsDQDtkq7gDCcDgG05UGtSZh0+hy/xwCGJwfzRd/7Ex
        QPZBmVfB8b2xQPpTkKEL9ID7IA==
X-Google-Smtp-Source: AAOMgpd6JhgnHqSq+9Tycy8WiM/xhrZDcBhYz8q2ast9vLSkwhVUM8tGG55aFlxsnPRbn8+8TaFbZQ==
X-Received: by 2002:adf:9bc9:: with SMTP id e9-v6mr2802301wrc.240.1531421587038;
        Thu, 12 Jul 2018 11:53:07 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:06 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 01/12] ipc: ipc: compute kern_ipc_perm.id under the ipc lock.
Date:   Thu, 12 Jul 2018 20:52:30 +0200
Message-Id: <20180712185241.4017-2-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipc_addid() initializes kern_ipc_perm.id after having called
ipc_idr_alloc().

Thus a parallel semctl() or msgctl() that uses e.g. MSG_STAT may use
this unitialized value as the return code.

The patch moves all accesses to kern_ipc_perm.id under the spin_lock().

The issues is related to the finding of
syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com:
syzbot found an issue with kern_ipc_perm.seq

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/msg.c | 19 ++++++++++++++-----
 ipc/sem.c | 18 +++++++++++++-----
 ipc/shm.c | 19 ++++++++++++++-----
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 3b6545302598..49358f474fc9 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -491,7 +491,6 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 			 int cmd, struct msqid64_ds *p)
 {
 	struct msg_queue *msq;
-	int id = 0;
 	int err;
 
 	memset(p, 0, sizeof(*p));
@@ -503,7 +502,6 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 			err = PTR_ERR(msq);
 			goto out_unlock;
 		}
-		id = msq->q_perm.id;
 	} else { /* IPC_STAT */
 		msq = msq_obtain_object_check(ns, msqid);
 		if (IS_ERR(msq)) {
@@ -548,10 +546,21 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
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
+		 * Return the full id, including the sequence number
+		 */
+		err = msq->q_perm.id;
+	}
 
+	ipc_unlock_object(&msq->q_perm);
 out_unlock:
 	rcu_read_unlock();
 	return err;
diff --git a/ipc/sem.c b/ipc/sem.c
index 5af1943ad782..d89ce69b2613 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1222,7 +1222,6 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 {
 	struct sem_array *sma;
 	time64_t semotime;
-	int id = 0;
 	int err;
 
 	memset(semid64, 0, sizeof(*semid64));
@@ -1234,7 +1233,6 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 			err = PTR_ERR(sma);
 			goto out_unlock;
 		}
-		id = sma->sem_perm.id;
 	} else { /* IPC_STAT */
 		sma = sem_obtain_object_check(ns, semid);
 		if (IS_ERR(sma)) {
@@ -1274,10 +1272,20 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
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
+		 * Return the full id, including the sequence number
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
index 051a3e1fb8df..f3bae59bed08 100644
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
+		 * Return the full id, including the sequence number
+		 */
+		err = shp->shm_perm.id;
+	}
 
+	ipc_unlock_object(&shp->shm_perm);
 out_unlock:
 	rcu_read_unlock();
 	return err;
-- 
2.17.1

