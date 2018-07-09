Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFECFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F652086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="xMGFBJW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F652086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeGIPLO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:11:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33885 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933364AbeGIPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so11334156wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cAEsNTg6BM2ybzt24PDxK6ReK/rv945Kqmv4YHUU3so=;
        b=xMGFBJW36M/7V4P+8tBbP0eFj9eerGOrKaS1nes+CXUMePVxEuyclPb5oqWHY6uzQ5
         uY8lB1UdpZhXtG/FhUow/rVukN/Mu6uxL9gOq6CkYOVnTFmolVayzSu8qs50Jr8kjj1n
         7aoLlOI3wmamg8d+aimSDYGlr1bWgoGasbpjaFPdrL2ytfaWWh6JNajKXLPycCe6w2R9
         MmFtEGZEotb4NZYG3XTQ5ejXIZEjiPSQ4sVU01K57P0YGwm0HBQSSP9CreCwhrvx1rau
         GYamuldFTgtiTIejntq/ASrRH5G/L9qKzB/iaUgMPMcYOl6lT+DSxmrUgqE6Atv68Ys0
         WTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cAEsNTg6BM2ybzt24PDxK6ReK/rv945Kqmv4YHUU3so=;
        b=mOeq2wLp80GWPJseD1JIomQfbs7m4BDdbCUVc4Ogo6hBLnc4RGdZ5JUef7sMilFbRS
         aOsw69GmG3VA16QT+MKLi968gx0QosczkPcHTxHZuG4wuqGMELvrvWCZrLpdvn/GmX0k
         DoFZhxNworN3b3DTdP+6JI4+zFvcDn0UXlRmSE9uSq+j41EY6t+pX2ESEv1L39qzNfYV
         qEfMB30yoxcO4u+mcDgropNa4nNOcmNSIJVLsCcSDu8V1HaEwsBPEM8+0S8cmn2wYHQh
         7x3xtN7g4YtxYBl3rHCRT/kbGmIPZdYsrp3P9ek1P6HlGDy8/LY8n1PdRhHqCiPXkerN
         6kIw==
X-Gm-Message-State: APt69E21UoyOj2DF1yG2Qwzeu9QAhStEcGB0Lfo8AnWwd5d7OK2YhKVT
        Q1lVSowfwLWFXUWHTq36mLTxJQ==
X-Google-Smtp-Source: AAOMgpc5i+FRvxlgs1shwEZI7YRAZ4H5HbNtPMLjn1IFX1luP5Etkug45x93UgmxUznCXjjQTeuxNA==
X-Received: by 2002:adf:a634:: with SMTP id k49-v6mr15816916wrc.181.1531149041925;
        Mon, 09 Jul 2018 08:10:41 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:41 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 11/12] ipc: simplify ipc initialization
Date:   Mon,  9 Jul 2018 17:10:18 +0200
Message-Id: <20180709151019.1336-12-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
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
index ba85d8849e8d..346230712259 100644
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
index 9742e9a1c0c2..f3de2f5e7b9b 100644
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
index cd8655c7bb77..1db4cf91f676 100644
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
index ae485b41ea0b..d474f2b3b299 100644
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
index 25d8ee052ac9..9a8a40de3682 100644
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

