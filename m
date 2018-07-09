Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD3CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8362086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="hSFQqOpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8362086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933437AbeGIPKo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:10:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40169 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeGIPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so21137777wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MVFn38qCec6lrkiQKmwFoZWAowYV/VmZ/hr9waL54M=;
        b=hSFQqOpIpiVZZUKn/mGK4AdHYsSqBp8SQwaXcA9OGUos8gjNtywdl3wI6Co9yT9Imr
         QjB4T1Do51GO4HFskCNerrdROYVPhjkwWdexzzQJ+bwC1l0pn0rqERI9AwWKqqLpKlfp
         ptH7T8/2sbjOMtZ+QBCVsQgS/HLGmSTWNwIpM1+XyahtHXedHgoXoBxVoBbzf7JERas8
         AJFXQSk8X/RqPnchFxQ9Y0VteNZ/cR+Cj7dexK1/86RwIXexY6zjRUT9hIA6tLs6LDWt
         g/vJGGqsRgxznLWeKbKgkpiRQORJzHzFZKQadnr4mRQhYMn3Ea+VQs3cmWOndFPAIEZN
         bmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5MVFn38qCec6lrkiQKmwFoZWAowYV/VmZ/hr9waL54M=;
        b=rqyRkH4puhae6nCXnxpZ8m3mfKiZesIawIxdJktp5wKHBl2jBG19QjraQ/UE3sf4Qa
         zFl4GmOTx08OkJm9fDT4mRiv1Ktu2QYjAfU7/FNoimQwha+jo6Y+lMkp3QZHOSOc6aOT
         jScgzb6pIT+zaOwhBDLp7uIgRr4RWs6Qx9d5JmCzB9HxxT7qLI2yfT1Nr1o4qhxrqv1m
         sOlp/VHkwH9LEKAKwNSS7t12Y1ftsXDOodnnegdTwaAU6W5ctN1dV7KXHhWYKFvgXkTK
         oCjoyO9mXxxpsCAP2KqiI5pcGIFWuH3JufMG09x3P5fKOsIeV/L/PQyYIi5izH3XtAf9
         M46A==
X-Gm-Message-State: APt69E30DSEesWYcsOYWXIm8b9aTD8JHhRG/7NExQiRdLarAMqQzsRm9
        OPIkqvc2ZKCQEJTEl6ICeUv5Pg==
X-Google-Smtp-Source: AAOMgpfyMgk+Err9RDnrrUjdaUeZjLGTU0emoLCuoRkJ4hSe+xaygYo0LLHccRvtdQZ8MppG+FLFIg==
X-Received: by 2002:a1c:c60a:: with SMTP id w10-v6mr2183878wmf.26.1531149034143;
        Mon, 09 Jul 2018 08:10:34 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:33 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 03/12] ipc/util.c: Use ipc_rcu_putref() for failues in ipc_addid()
Date:   Mon,  9 Jul 2018 17:10:10 +0200
Message-Id: <20180709151019.1336-4-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipc_addid() is impossible to use:
- for certain failures, the caller must not use ipc_rcu_putref(),
  because the reference counter is not yet initialized.
- for other failures, the caller must use ipc_rcu_putref(),
  because parallel operations could be ongoing already.

The patch cleans that up, by initializing the refcount early,
and by modifying all callers.

The issues is related to the finding of
syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com:
syzbot found an issue with reading kern_ipc_perm.seq,
here both read and write to already released memory could happen.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/msg.c  |  2 +-
 ipc/sem.c  |  2 +-
 ipc/shm.c  |  2 ++
 ipc/util.c | 12 ++++++++++--
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 829c2062ded4..5bf5cb8017ea 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -162,7 +162,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	/* ipc_addid() locks msq upon success. */
 	retval = ipc_addid(&msg_ids(ns), &msq->q_perm, ns->msg_ctlmni);
 	if (retval < 0) {
-		call_rcu(&msq->q_perm.rcu, msg_rcu_free);
+		ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
 		return retval;
 	}
 
diff --git a/ipc/sem.c b/ipc/sem.c
index e8971fa1d847..9d49efeac2e5 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -556,7 +556,7 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 	/* ipc_addid() locks sma upon success. */
 	retval = ipc_addid(&sem_ids(ns), &sma->sem_perm, ns->sc_semmni);
 	if (retval < 0) {
-		call_rcu(&sma->sem_perm.rcu, sem_rcu_free);
+		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
 		return retval;
 	}
 	ns->used_sems += nsems;
diff --git a/ipc/shm.c b/ipc/shm.c
index 59fe8b3b3794..06b7bf11a011 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -671,6 +671,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	if (is_file_hugepages(file) && shp->mlock_user)
 		user_shm_unlock(size, shp->mlock_user);
 	fput(file);
+	ipc_rcu_putref(&shp->shm_perm, shm_rcu_free);
+	return error;
 no_file:
 	call_rcu(&shp->shm_perm.rcu, shm_rcu_free);
 	return error;
diff --git a/ipc/util.c b/ipc/util.c
index 662c28c6c9fa..8b09496ed720 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -248,7 +248,9 @@ static inline void ipc_set_seq(struct ipc_ids *ids,
  * Add an entry 'new' to the ipc ids idr. The permissions object is
  * initialised and the first free entry is set up and the id assigned
  * is returned. The 'new' entry is returned in a locked state on success.
+ *
  * On failure the entry is not locked and a negative err-code is returned.
+ * The caller must use ipc_rcu_putref() to free the identifier.
  *
  * Called with writer ipc_ids.rwsem held.
  */
@@ -258,6 +260,9 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	kgid_t egid;
 	int id, err;
 
+	/* 1) Initialize the refcount so that ipc_rcu_putref works */
+	refcount_set(&new->refcount, 1);
+
 	if (limit > IPCMNI)
 		limit = IPCMNI;
 
@@ -266,9 +271,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 
 	idr_preload(GFP_KERNEL);
 
-	refcount_set(&new->refcount, 1);
 	spin_lock_init(&new->lock);
-	new->deleted = false;
 	rcu_read_lock();
 	spin_lock(&new->lock);
 
@@ -277,6 +280,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	new->gid = new->cgid = egid;
 
 	ipc_set_seq(ids, new);
+	new->deleted = false;
 
 	/*
 	 * As soon as a new object is inserted into the idr,
@@ -288,6 +292,9 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	 * Thus the object must be fully initialized, and if something fails,
 	 * then the full tear-down sequence must be followed.
 	 * (i.e.: set new->deleted, reduce refcount, call_rcu())
+	 *
+	 * This function sets new->deleted, the caller must use ipc_rcu_putef()
+	 * for the remaining steps.
 	 */
 	id = ipc_idr_alloc(ids, new);
 	idr_preload_end();
@@ -301,6 +308,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 		}
 	}
 	if (id < 0) {
+		new->deleted = true;
 		spin_unlock(&new->lock);
 		rcu_read_unlock();
 		return id;
-- 
2.17.1

