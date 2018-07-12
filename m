Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5697AEC2D1C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2352147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="dPrLUx0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2352147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeGLTEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33405 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeGLTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so13812267wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gV3jQmsRRcrUCvAwgZJ4TkMy7nJAbisx4DsyQvY5HRE=;
        b=dPrLUx0blvYXMVcaVNol/OkUuuSgRPxxxzQHRdF7NrCDlDpTR7BtS3tU9V0ve5Krbt
         VcWByjQRoFDwlqkviCfWkArEEwXyNd+KiQkE4RmRWszCEZxjWo61YGwNejTzQ11tM9e3
         eYq5sgCkpuINc7XRF/vjqluG3lE7H6tP2x0hOrO1L8KdZ9mJGsU8Pl+bbBoc9ahDhyHs
         vIJiGjPhuPjW2zg0uaAorgTf9cLQDWslsu6F+Z0oOwSoD9EmLU4HXQfaTxlNPxKzrY8D
         gDV9VXZdj5qCGhOR/AhPnPfLeAHD14O3J8b7TWMGkMI7CjQi60wOnZbeD4R2GPBHtFyD
         UmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gV3jQmsRRcrUCvAwgZJ4TkMy7nJAbisx4DsyQvY5HRE=;
        b=fastj1LJ8OAseIzSPFLiYhNM6MH1PtneatVReS4VXrXnHZgLI2n0JXg+uY+me5NP17
         4TK9Oeulr8OONHaZbzumUBR8g3NoGhxpp/w6UWyQJdWTLnGjeKaIGL8Ce0ebrDAfz1ew
         +J8feI4TYO49YDJJ5wIE4V6d9V8DMbjISYNfYKZo9wQxK6Dgqc0U7L5uASWbL1K8QNsf
         OIcsTwdD8Nk6HfjvTGRWYd+brvqkn7H6rTUaOtT6rJ/iAWI/oNdHXur/CmgBYX9ulTUz
         d4lMi9OdSdcRlgoUA2cmQ80m4B0BfQYm1Bz5V5WhmYW6BIyxod5ddJ5j+z1v84MX0XYI
         K8iw==
X-Gm-Message-State: AOUpUlEdxJDOSmMQp2XtZr5/nM34Jsdfk43CucV9FsidOggdGSB1iQia
        dDFn09fY2d/rU1ugV+WGebp7vn74IQc=
X-Google-Smtp-Source: AAOMgpdmabMeTVJVlL9vSUypYWnadVOVoPGzcrKQL3ViwogoE25KxUaqBk4n2qlD92qjrtEzYv21kw==
X-Received: by 2002:adf:8895:: with SMTP id f21-v6mr2649672wrf.250.1531421595561;
        Thu, 12 Jul 2018 11:53:15 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:15 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 10/12] ipc: simplify ipc initialization
Date:   Thu, 12 Jul 2018 20:52:39 +0200
Message-Id: <20180712185241.4017-11-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Now that we know that rhashtable_init() will not fail, we
can get rid of a lot of the unnecessary cleanup paths when
the call errored out.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

(variable name added to util.h to resolve checkpatch warning)
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/msg.c       |  9 ++++-----
 ipc/namespace.c | 20 ++++----------------
 ipc/sem.c       | 10 ++++------
 ipc/shm.c       |  9 ++++-----
 ipc/util.c      | 18 +++++-------------
 ipc/util.h      | 18 +++++++++---------
 6 files changed, 30 insertions(+), 54 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 4aca0ce363b5..130e12e6a8c6 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -1237,7 +1237,7 @@ COMPAT_SYSCALL_DEFINE5(msgrcv, int, msqid, compat_uptr_t, msgp,
 }
 #endif
 
-int msg_init_ns(struct ipc_namespace *ns)
+void msg_init_ns(struct ipc_namespace *ns)
 {
 	ns->msg_ctlmax = MSGMAX;
 	ns->msg_ctlmnb = MSGMNB;
@@ -1245,7 +1245,7 @@ int msg_init_ns(struct ipc_namespace *ns)
 
 	atomic_set(&ns->msg_bytes, 0);
 	atomic_set(&ns->msg_hdrs, 0);
-	return ipc_init_ids(&ns->ids[IPC_MSG_IDS]);
+	ipc_init_ids(&ns->ids[IPC_MSG_IDS]);
 }
 
 #ifdef CONFIG_IPC_NS
@@ -1286,12 +1286,11 @@ static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
 }
 #endif
 
-int __init msg_init(void)
+void __init msg_init(void)
 {
-	const int err = msg_init_ns(&init_ipc_ns);
+	msg_init_ns(&init_ipc_ns);
 
 	ipc_init_proc_interface("sysvipc/msg",
 				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
 				IPC_MSG_IDS, sysvipc_msg_proc_show);
-	return err;
 }
diff --git a/ipc/namespace.c b/ipc/namespace.c
index f59a89966f92..21607791d62c 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -55,28 +55,16 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 
-	err = sem_init_ns(ns);
+	err = mq_init_ns(ns);
 	if (err)
 		goto fail_put;
-	err = msg_init_ns(ns);
-	if (err)
-		goto fail_destroy_sem;
-	err = shm_init_ns(ns);
-	if (err)
-		goto fail_destroy_msg;
 
-	err = mq_init_ns(ns);
-	if (err)
-		goto fail_destroy_shm;
+	sem_init_ns(ns);
+	msg_init_ns(ns);
+	shm_init_ns(ns);
 
 	return ns;
 
-fail_destroy_shm:
-	shm_exit_ns(ns);
-fail_destroy_msg:
-	msg_exit_ns(ns);
-fail_destroy_sem:
-	sem_exit_ns(ns);
 fail_put:
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
diff --git a/ipc/sem.c b/ipc/sem.c
index da1626984083..671d8703b130 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -220,14 +220,14 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
 #define sc_semopm	sem_ctls[2]
 #define sc_semmni	sem_ctls[3]
 
-int sem_init_ns(struct ipc_namespace *ns)
+void sem_init_ns(struct ipc_namespace *ns)
 {
 	ns->sc_semmsl = SEMMSL;
 	ns->sc_semmns = SEMMNS;
 	ns->sc_semopm = SEMOPM;
 	ns->sc_semmni = SEMMNI;
 	ns->used_sems = 0;
-	return ipc_init_ids(&ns->ids[IPC_SEM_IDS]);
+	ipc_init_ids(&ns->ids[IPC_SEM_IDS]);
 }
 
 #ifdef CONFIG_IPC_NS
@@ -239,14 +239,12 @@ void sem_exit_ns(struct ipc_namespace *ns)
 }
 #endif
 
-int __init sem_init(void)
+void __init sem_init(void)
 {
-	const int err = sem_init_ns(&init_ipc_ns);
-
+	sem_init_ns(&init_ipc_ns);
 	ipc_init_proc_interface("sysvipc/sem",
 				"       key      semid perms      nsems   uid   gid  cuid  cgid      otime      ctime\n",
 				IPC_SEM_IDS, sysvipc_sem_proc_show);
-	return err;
 }
 
 /**
diff --git a/ipc/shm.c b/ipc/shm.c
index 22afb98363ff..d388d6e744c0 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -95,14 +95,14 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp);
 static int sysvipc_shm_proc_show(struct seq_file *s, void *it);
 #endif
 
-int shm_init_ns(struct ipc_namespace *ns)
+void shm_init_ns(struct ipc_namespace *ns)
 {
 	ns->shm_ctlmax = SHMMAX;
 	ns->shm_ctlall = SHMALL;
 	ns->shm_ctlmni = SHMMNI;
 	ns->shm_rmid_forced = 0;
 	ns->shm_tot = 0;
-	return ipc_init_ids(&shm_ids(ns));
+	ipc_init_ids(&shm_ids(ns));
 }
 
 /*
@@ -135,9 +135,8 @@ void shm_exit_ns(struct ipc_namespace *ns)
 
 static int __init ipc_ns_init(void)
 {
-	const int err = shm_init_ns(&init_ipc_ns);
-	WARN(err, "ipc: sysv shm_init_ns failed: %d\n", err);
-	return err;
+	shm_init_ns(&init_ipc_ns);
+	return 0;
 }
 
 pure_initcall(ipc_ns_init);
diff --git a/ipc/util.c b/ipc/util.c
index f620778b11d2..35621be0d945 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -87,16 +87,12 @@ struct ipc_proc_iface {
  */
 static int __init ipc_init(void)
 {
-	int err_sem, err_msg;
-
 	proc_mkdir("sysvipc", NULL);
-	err_sem = sem_init();
-	WARN(err_sem, "ipc: sysv sem_init failed: %d\n", err_sem);
-	err_msg = msg_init();
-	WARN(err_msg, "ipc: sysv msg_init failed: %d\n", err_msg);
+	sem_init();
+	msg_init();
 	shm_init();
 
-	return err_msg ? err_msg : err_sem;
+	return 0;
 }
 device_initcall(ipc_init);
 
@@ -115,21 +111,17 @@ static const struct rhashtable_params ipc_kht_params = {
  * Set up the sequence range to use for the ipc identifier range (limited
  * below IPCMNI) then initialise the keys hashtable and ids idr.
  */
-int ipc_init_ids(struct ipc_ids *ids)
+void ipc_init_ids(struct ipc_ids *ids)
 {
-	int err;
 	ids->in_use = 0;
 	ids->seq = 0;
 	init_rwsem(&ids->rwsem);
-	err = rhashtable_init(&ids->key_ht, &ipc_kht_params);
-	if (err)
-		return err;
+	rhashtable_init(&ids->key_ht, &ipc_kht_params);
 	idr_init(&ids->ipcs_idr);
 	ids->max_id = -1;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	ids->next_id = -1;
 #endif
-	return 0;
 }
 
 #ifdef CONFIG_PROC_FS
diff --git a/ipc/util.h b/ipc/util.h
index e3c47b21db93..6c5c77c61f85 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -18,8 +18,8 @@
 #define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
 #define SEQ_MULTIPLIER	(IPCMNI)
 
-int sem_init(void);
-int msg_init(void);
+void sem_init(void);
+void msg_init(void);
 void shm_init(void);
 
 struct ipc_namespace;
@@ -34,17 +34,17 @@ static inline void mq_put_mnt(struct ipc_namespace *ns) { }
 #endif
 
 #ifdef CONFIG_SYSVIPC
-int sem_init_ns(struct ipc_namespace *ns);
-int msg_init_ns(struct ipc_namespace *ns);
-int shm_init_ns(struct ipc_namespace *ns);
+void sem_init_ns(struct ipc_namespace *ns);
+void msg_init_ns(struct ipc_namespace *ns);
+void shm_init_ns(struct ipc_namespace *ns);
 
 void sem_exit_ns(struct ipc_namespace *ns);
 void msg_exit_ns(struct ipc_namespace *ns);
 void shm_exit_ns(struct ipc_namespace *ns);
 #else
-static inline int sem_init_ns(struct ipc_namespace *ns) { return 0; }
-static inline int msg_init_ns(struct ipc_namespace *ns) { return 0; }
-static inline int shm_init_ns(struct ipc_namespace *ns) { return 0; }
+static inline void sem_init_ns(struct ipc_namespace *ns) { }
+static inline void msg_init_ns(struct ipc_namespace *ns) { }
+static inline void shm_init_ns(struct ipc_namespace *ns) { }
 
 static inline void sem_exit_ns(struct ipc_namespace *ns) { }
 static inline void msg_exit_ns(struct ipc_namespace *ns) { }
@@ -83,7 +83,7 @@ struct ipc_ops {
 struct seq_file;
 struct ipc_ids;
 
-int ipc_init_ids(struct ipc_ids *);
+void ipc_init_ids(struct ipc_ids *ids);
 #ifdef CONFIG_PROC_FS
 void __init ipc_init_proc_interface(const char *path, const char *header,
 		int ids, int (*show)(struct seq_file *, void *));
-- 
2.17.1

