Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069BBEC2F10
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDE6208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="sHrNIAZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDE6208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeGLTEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54061 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbeGLTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so6603244wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pDhpHSWHzvRj/A5PKyn3ks9CvSsjZEZOAESpNW7u0Hc=;
        b=sHrNIAZ3mM6Jb+M6TF2D0TJoUpWhNKKu3bZ6ldEAHMq32o6L4uiw2WAhyMi68onkf8
         FpX4hado91MF89GQDbdzKLAPbv1L09B5sc+l8atoMo6Qi1Zpn4qgLmZa//hIBkkWz/83
         lSbC6jo62OGNx5YM/OKZDYil4dK978o7DIYJQ2kWlp1dbOPZZEzBLrRe7MBh9JbgDCWU
         jZcHjQUjTYkVzaSW9E+8pMb52xtsJ8NvMcwKdO64OPCAesg4V4aVvpSSSZ8jWsYZcIms
         nJA7RcCLaXacitNv1P9iW5+dWilOL8ppM9rJkr/lafnyWRdyJ1uG8jAPgn4+V9SnSVjp
         /REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pDhpHSWHzvRj/A5PKyn3ks9CvSsjZEZOAESpNW7u0Hc=;
        b=KnIRORM5isShbp7nGEamuknuSsU/IA65slb0odUv3Ei79wPeQz2Uw3F5oGlGnTx7SU
         qt4dWXP04aRIsSOlTY4kZmA/xPkkx2dDZaDCYC/GCGVwJzg1dEkD9W2oBekZtzEw0HK/
         wYH9Arp/5fF+aiFAmVuJenxTCyRhOzemrgc5HATCzyxtmW6ZcYEJ8ksVYqr8RR9OLhIA
         Wq7ctBdQSuARReb3SFS47R9EHebv89YrZPxveXLi8PqWWvZTFAAap/bg66RFDm4T/1TY
         rc2JQdU3gtG6nM4oPthkgw6yuHwu6vSXiHbL4+LN5dNO0WiF3cDnCVjG622yaK/epFRA
         ljUQ==
X-Gm-Message-State: AOUpUlFTzG4QNa+spQMCz/3pw3MN+jQsGTPVuKfPxDuDOv01q/g6wWSM
        imcHnCDTU03YtdqZyr31YmmWYw==
X-Google-Smtp-Source: AAOMgpdzrWgb6xp963lRi36uXLYAlu6tZNfrIEw+HRRXy1NSBovXLs0kuFONZmjrnE/cg0D/IFYqoQ==
X-Received: by 2002:a1c:cd4:: with SMTP id 203-v6mr29182wmm.95.1531421596467;
        Thu, 12 Jul 2018 11:53:16 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:16 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 11/12] ipc/util.c: Further variable name cleanups
Date:   Thu, 12 Jul 2018 20:52:40 +0200
Message-Id: <20180712185241.4017-12-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The varable names got a mess, thus standardize them again:

id: user space id. Called semid, shmid, msgid if the type is known.
    Most functions use "id" already.
idx: "index" for the idr lookup
    Right now, some functions use lid, ipc_addid() already uses idx as
    the variable name.
seq: sequence number, to avoid quick collisions of the user space id
key: user space key, used for the rhash tree

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/ipc_namespace.h |  2 +-
 ipc/msg.c                     |  6 +++---
 ipc/sem.c                     |  6 +++---
 ipc/shm.c                     |  4 ++--
 ipc/util.c                    | 26 +++++++++++++-------------
 ipc/util.h                    | 10 +++++-----
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 37f3a4b7c637..3098d275a29d 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -18,7 +18,7 @@ struct ipc_ids {
 	unsigned short seq;
 	struct rw_semaphore rwsem;
 	struct idr ipcs_idr;
-	int max_id;
+	int max_idx;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	int next_id;
 #endif
diff --git a/ipc/msg.c b/ipc/msg.c
index 130e12e6a8c6..1892bec0f1c8 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -455,7 +455,7 @@ static int msgctl_info(struct ipc_namespace *ns, int msqid,
 			 int cmd, struct msginfo *msginfo)
 {
 	int err;
-	int max_id;
+	int max_idx;
 
 	/*
 	 * We must not return kernel stack data.
@@ -482,9 +482,9 @@ static int msgctl_info(struct ipc_namespace *ns, int msqid,
 		msginfo->msgpool = MSGPOOL;
 		msginfo->msgtql = MSGTQL;
 	}
-	max_id = ipc_get_maxid(&msg_ids(ns));
+	max_idx = ipc_get_maxidx(&msg_ids(ns));
 	up_read(&msg_ids(ns).rwsem);
-	return (max_id < 0) ? 0 : max_id;
+	return (max_idx < 0) ? 0 : max_idx;
 }
 
 static int msgctl_stat(struct ipc_namespace *ns, int msqid,
diff --git a/ipc/sem.c b/ipc/sem.c
index 671d8703b130..f98962b06024 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1293,7 +1293,7 @@ static int semctl_info(struct ipc_namespace *ns, int semid,
 			 int cmd, void __user *p)
 {
 	struct seminfo seminfo;
-	int max_id;
+	int max_idx;
 	int err;
 
 	err = security_sem_semctl(NULL, cmd);
@@ -1317,11 +1317,11 @@ static int semctl_info(struct ipc_namespace *ns, int semid,
 		seminfo.semusz = SEMUSZ;
 		seminfo.semaem = SEMAEM;
 	}
-	max_id = ipc_get_maxid(&sem_ids(ns));
+	max_idx = ipc_get_maxidx(&sem_ids(ns));
 	up_read(&sem_ids(ns).rwsem);
 	if (copy_to_user(p, &seminfo, sizeof(struct seminfo)))
 		return -EFAULT;
-	return (max_id < 0) ? 0 : max_id;
+	return (max_idx < 0) ? 0 : max_idx;
 }
 
 static int semctl_setval(struct ipc_namespace *ns, int semid, int semnum,
diff --git a/ipc/shm.c b/ipc/shm.c
index d388d6e744c0..a4e9a1b34595 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -935,7 +935,7 @@ static int shmctl_ipc_info(struct ipc_namespace *ns,
 		shminfo->shmall = ns->shm_ctlall;
 		shminfo->shmmin = SHMMIN;
 		down_read(&shm_ids(ns).rwsem);
-		err = ipc_get_maxid(&shm_ids(ns));
+		err = ipc_get_maxidx(&shm_ids(ns));
 		up_read(&shm_ids(ns).rwsem);
 		if (err < 0)
 			err = 0;
@@ -955,7 +955,7 @@ static int shmctl_shm_info(struct ipc_namespace *ns,
 		shm_info->shm_tot = ns->shm_tot;
 		shm_info->swap_attempts = 0;
 		shm_info->swap_successes = 0;
-		err = ipc_get_maxid(&shm_ids(ns));
+		err = ipc_get_maxidx(&shm_ids(ns));
 		up_read(&shm_ids(ns).rwsem);
 		if (err < 0)
 			err = 0;
diff --git a/ipc/util.c b/ipc/util.c
index 35621be0d945..fb69c911655a 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -118,7 +118,7 @@ void ipc_init_ids(struct ipc_ids *ids)
 	init_rwsem(&ids->rwsem);
 	rhashtable_init(&ids->key_ht, &ipc_kht_params);
 	idr_init(&ids->ipcs_idr);
-	ids->max_id = -1;
+	ids->max_idx = -1;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	ids->next_id = -1;
 #endif
@@ -236,7 +236,7 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
  * @limit: limit for the number of used ids
  *
  * Add an entry 'new' to the ipc ids idr. The permissions object is
- * initialised and the first free entry is set up and the id assigned
+ * initialised and the first free entry is set up and the index assigned
  * is returned. The 'new' entry is returned in a locked state on success.
  *
  * On failure the entry is not locked and a negative err-code is returned.
@@ -290,8 +290,8 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	}
 
 	ids->in_use++;
-	if (idx > ids->max_id)
-		ids->max_id = idx;
+	if (idx > ids->max_idx)
+		ids->max_idx = idx;
 	return idx;
 }
 
@@ -430,20 +430,20 @@ static void ipc_kht_remove(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
  */
 void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 {
-	int lid = ipcid_to_idx(ipcp->id);
+	int idx = ipcid_to_idx(ipcp->id);
 
-	idr_remove(&ids->ipcs_idr, lid);
+	idr_remove(&ids->ipcs_idr, idx);
 	ipc_kht_remove(ids, ipcp);
 	ids->in_use--;
 	ipcp->deleted = true;
 
-	if (unlikely(lid == ids->max_id)) {
+	if (unlikely(idx == ids->max_idx)) {
 		do {
-			lid--;
-			if (lid == -1)
+			idx--;
+			if (idx == -1)
 				break;
-		} while (!idr_find(&ids->ipcs_idr, lid));
-		ids->max_id = lid;
+		} while (!idr_find(&ids->ipcs_idr, idx));
+		ids->max_idx = idx;
 	}
 }
 
@@ -563,9 +563,9 @@ void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out)
 struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
 {
 	struct kern_ipc_perm *out;
-	int lid = ipcid_to_idx(id);
+	int idx = ipcid_to_idx(id);
 
-	out = idr_find(&ids->ipcs_idr, lid);
+	out = idr_find(&ids->ipcs_idr, idx);
 	if (!out)
 		return ERR_PTR(-EINVAL);
 
diff --git a/ipc/util.h b/ipc/util.h
index 6c5c77c61f85..e74564fe3375 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -113,12 +113,12 @@ void ipc_set_key_private(struct ipc_ids *, struct kern_ipc_perm *);
 int ipcperms(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp, short flg);
 
 /**
- * ipc_get_maxid - get the last assigned id
+ * ipc_get_maxidx - get the highest assigned index
  * @ids: ipc identifier set
  *
  * Called with ipc_ids.rwsem held for reading.
  */
-static inline int ipc_get_maxid(struct ipc_ids *ids)
+static inline int ipc_get_maxidx(struct ipc_ids *ids)
 {
 	if (ids->in_use == 0)
 		return -1;
@@ -126,7 +126,7 @@ static inline int ipc_get_maxid(struct ipc_ids *ids)
 	if (ids->in_use == IPCMNI)
 		return IPCMNI - 1;
 
-	return ids->max_id;
+	return ids->max_idx;
 }
 
 /*
@@ -172,9 +172,9 @@ extern struct msg_msg *load_msg(const void __user *src, size_t len);
 extern struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst);
 extern int store_msg(void __user *dest, struct msg_msg *msg, size_t len);
 
-static inline int ipc_checkid(struct kern_ipc_perm *ipcp, int uid)
+static inline int ipc_checkid(struct kern_ipc_perm *ipcp, int id)
 {
-	return uid / SEQ_MULTIPLIER != ipcp->seq;
+	return ipcid_to_seqx(id) != ipcp->seq;
 }
 
 static inline void ipc_lock_object(struct kern_ipc_perm *perm)
-- 
2.17.1

