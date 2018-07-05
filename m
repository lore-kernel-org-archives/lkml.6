Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AE8C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C522417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="SLSRgb8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C522417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeGEF7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:59:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53973 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeGEF7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:59:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so8938623wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sUnORpt3ZOyKxYjrsj9AWis0lMUyoBtf3F58mqgMlnI=;
        b=SLSRgb8hQkCuGjcpu4bX1HjjBmEYEiHr5CCE9btUABTGJBPiUe9to3Q81NEEz6xAor
         uJSxk9E1EJM4xyXOIkQw8dRJEjnW9ai2NC8VkqTCO4xqDiTg2H5OPNbM3l7zzqbm5a4Y
         623lD87WoasIbXk4j8nj8FSXC+St+LWLvr2xyXT3WZ3AhFU3bnmDHfUmGqZ7ODO5K+sk
         b1xa9NyiZq0X2U+9CvwN1hy9rDhJKwHInh1I2kHZ8/C72HtIK3t8Ef5tw+v4QZMr5V8L
         KPlEdyZyy8fIOEqMhcG9ScBsz+iTfbG/3BI3DVcnDfppCE/IMjiRyYXsuC1PCy5vEeIR
         15lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sUnORpt3ZOyKxYjrsj9AWis0lMUyoBtf3F58mqgMlnI=;
        b=nvQQLYiMhRWKpe8F2AHhcvn4+5C0jOdR4fcEgHDuLO4wsL8Y6mFf7z1VBo93m5p+c1
         4wXePNLquZEnGaTZppFXshXlZXbYzbhL5CaHZWGtN0hcTzBKWIUzbher25pOpwH9Yg02
         h3kOAECiccRom5oyhbYIl2pERPY+wwr114/oybtjz32aH2T4aMs3ad60EiphFPL1hyRd
         rYTI4hCLWnM/vsCqUMTrlRFyT8+Q5AoELADjgUS8g65estxylRldMxm1KZqUVOjDPhts
         qHAz2Bvdc0Jh05wSWPK3uPa33Q1BergpKD34Q4XBGRqjhE+nrJXQ3EwMWXfjzTpoDGJi
         aiJw==
X-Gm-Message-State: APt69E0Hqtyq67flmpMDsieI7Y2NFdjxGN3Bm0t+s+b7GwNoAQ6sYMwL
        zQJ4lrdLZz641vMNCQ5FXoGvz5m32iMBwA==
X-Google-Smtp-Source: AAOMgpcmGQd7JHbNw3X19zNu82mLe//6eV0xN33Qc4mW27HqcAk2NpJj2nwuIYC6bQhTEDvtEy03Cg==
X-Received: by 2002:a1c:6b51:: with SMTP id g78-v6mr3331350wmc.149.1530770370833;
        Wed, 04 Jul 2018 22:59:30 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C4E0002E4725E865D6E031.dip0.t-ipconnect.de. [2003:d9:93c4:e000:2e47:25e8:65d6:e031])
        by smtp.googlemail.com with ESMTPSA id h40-v6sm7452689wrf.40.2018.07.04.22.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 22:59:30 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 1/6] ipc: reorganize initialization of kern_ipc_perm.id
Date:   Thu,  5 Jul 2018 07:59:15 +0200
Message-Id: <20180705055920.19611-2-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705055920.19611-1-manfred@colorfullife.com>
References: <20180705055920.19611-1-manfred@colorfullife.com>
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
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
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

