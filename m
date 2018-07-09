Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F395D2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="hM/nA7Mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F395D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933375AbeGIPN4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:13:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37350 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933045AbeGIPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so11374807wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1NcR47cE2cq77xmlWW4Nt/NyZVL5mkzoPX4nYJ6BRvo=;
        b=hM/nA7MzYXdu8spht3ICwQkRDmOW/U30rSuh9uEzB8FkHokwU+f0fjRnr8duaHCpYu
         uNgN40C+nHHtRUUmDp8ll7OPn+vpAD/CrjKdaS3WNlbXGLFMQGv8byWod93AfVsqT/GD
         px6x4rJ4yPVae06TOWUY+w4k1SFPvZ3I43DHeiM1hH/HToCS2CwbfarYPgC6IDpbSTop
         5C1y7cH6tuii8u+A7IB/hrIXiRoso1S7yyYv46ThxH4pYrP+hcrbCffP7Z6C8PUcWMdU
         fevPnNcrrmF4XnB+h8OPyrVKG/1Z/w5WaTxxB+i5n2xaTxYZh5LPJ6mlI17ccC0t/7mk
         5kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1NcR47cE2cq77xmlWW4Nt/NyZVL5mkzoPX4nYJ6BRvo=;
        b=XGuolvI3hc7TP09JncPucvWk510Zfq4H4EvslgsYurzpYUU0BanaQQleGLqh8wdeOn
         lukHJMWEyVNTWgIOZ33edygjMK+9kQpGXte6fASZX93Cd16+IpfOoLbeMshUciQRnTsP
         LcN3JLoI5tnpQJuU3jRWz7c/Bsynvm6Y8itYOa2vn1AUEd6+2pZd7PqwiUxZInbcGJhM
         hQu1TNoF3w9MkCb0XzZw/REnd8gIw/luO+49W+rvO2WTeAF9mxSKbVgua1UAnChFoZLC
         oxSdFRGMGHY0WmORagA4UIRupGu4WmqVRKWMTZMLr0yq/UTr3hn5EGkOl30yOiXXc8cF
         jO2w==
X-Gm-Message-State: APt69E346uQekx2q0QbjK2W5sIDn0AQVz7/ttOwHCgiP9uTOBgRbIdpr
        +iShF2JNtgXc8wqFz6EzboF5rA==
X-Google-Smtp-Source: AAOMgpdX3nFOGCDcIDKuHbqNxZ9V/MF6UyJsLgYooHQEatrXyWYRwOQPAQpxSOiAj8Vxo4GxqDc1nA==
X-Received: by 2002:a5d:6841:: with SMTP id o1-v6mr14729301wrw.159.1531149032111;
        Mon, 09 Jul 2018 08:10:32 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:31 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 01/12] ipc: reorganize initialization of kern_ipc_perm.id
Date:   Mon,  9 Jul 2018 17:10:08 +0200
Message-Id: <20180709151019.1336-2-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipc_addid() initializes kern_ipc_perm.id after having called
ipc_idr_alloc().

Thus a parallel semop() or msgrcv() that uses ipc_obtain_object_idr()
may see an uninitialized value.

The patch moves all accesses to kern_ipc_perm.id under the spin_lock().

The issues is related to the finding of
syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com:
syzbot found an issue with kern_ipc_perm.seq

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/msg.c | 19 ++++++++++++++-----
 ipc/sem.c | 18 +++++++++++++-----
 ipc/shm.c | 19 ++++++++++++++-----
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 3b6545302598..829c2062ded4 100644
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
+		 * Return the full id, including the sequence counter
+		 */
+		err = msq->q_perm.id;
+	}
 
+	ipc_unlock_object(&msq->q_perm);
 out_unlock:
 	rcu_read_unlock();
 	return err;
diff --git a/ipc/sem.c b/ipc/sem.c
index 5af1943ad782..e8971fa1d847 100644
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
-- 
2.17.1

