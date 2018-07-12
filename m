Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9E8EC33EE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF8A2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="LzVkOXbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF8A2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeGLTEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34458 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeGLTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so22677070wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4m/VKMM/c4wpd+Gk7GUikKc6ivrRMbzqdnD5fXIh/k4=;
        b=LzVkOXbn3RBGVBmY7BkYPn2J144vV6BfRUBbjx4BvnJ9+fJfDN5oaITxuuNFt3KBNC
         84jjWUF+LzyFgYHoDNopWnGEn1To4wsfDHXlDrkfIJ06/RmpDNTVfuBE8SvN9NNSYSIj
         xjgM1MMGVoViPNvIiGqIbptywowKS5mc2JEsTNuj+1MaHgqyjxsLSO6YKg6WgNR0kMz8
         yR9QCE0WRrWEiB0qncmdvg9XWreDOUAOV+QtZyxkE6Bo8ME9z9YC6Y7lRSo5hDYoQgNM
         BTx/OpTZb3gqMI88yEm7GFCXjh4k48Nd2Df4XVO/0y6oK+gfR5Q+rNgEPYmLv2yOT6J2
         0olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4m/VKMM/c4wpd+Gk7GUikKc6ivrRMbzqdnD5fXIh/k4=;
        b=mKabLWwhUHj9/FYGPVcsgIJNUzz2MxrMNrUDuMCahA5MiuVldjaPUjkDflNl+Im+0y
         svU35QRx2xG0lSpDAAZ9+12zNXDlhqiG8sPxadtjko/q3T6q7j5uHOCCtmlNWYpfDxpA
         ZS6gjTtmQIv1b7035gc44zgZ+VlLlATzYbL9sb+ChrDVVBZ9hC/XvVYLEobJcCFY+Ewq
         4bS538ixJAeSOsuRLjyZ3n//jw3JqcDz8wuXrsueJijTyq8XxPU0cZ5EfVeFczEIepNX
         33XcPYOfT2fOexXnBaaAcQ1fY6AYRrtN60/6vWe8JWPFYwU4taCzzJZQuRmjGDbfsjVQ
         vdEw==
X-Gm-Message-State: AOUpUlEnN4/HWLHEM+7i46ROJxR+X7lsflGuYI1kQGOWIi80e3Ytf27C
        eN6huZBiY7ftD2rW5HBndjkGhQ==
X-Google-Smtp-Source: AAOMgpeUnhwDzIN1OAYu0P+o+7wB88vuAnKNB7RePF0QEetlToth8mXW7EZpOVU89duiFNgocu3tgg==
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr2776388wrc.88.1531421589444;
        Thu, 12 Jul 2018 11:53:09 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:08 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 03/12] ipc/util.c: Use ipc_rcu_putref() for failues in ipc_addid()
Date:   Thu, 12 Jul 2018 20:52:32 +0200
Message-Id: <20180712185241.4017-4-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
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
 ipc/util.c | 10 ++++++++--
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 49358f474fc9..38119c1f0da3 100644
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
index d89ce69b2613..8a0a1eb05765 100644
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
index f3bae59bed08..92d71abe9e8f 100644
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
index 4998f8fa8ce0..f3447911c81e 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -250,7 +250,9 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
  * Add an entry 'new' to the ipc ids idr. The permissions object is
  * initialised and the first free entry is set up and the id assigned
  * is returned. The 'new' entry is returned in a locked state on success.
+ *
  * On failure the entry is not locked and a negative err-code is returned.
+ * The caller must use ipc_rcu_putref() to free the identifier.
  *
  * Called with writer ipc_ids.rwsem held.
  */
@@ -260,6 +262,9 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	kgid_t egid;
 	int idx, err;
 
+	/* 1) Initialize the refcount so that ipc_rcu_putref works */
+	refcount_set(&new->refcount, 1);
+
 	if (limit > IPCMNI)
 		limit = IPCMNI;
 
@@ -268,9 +273,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 
 	idr_preload(GFP_KERNEL);
 
-	refcount_set(&new->refcount, 1);
 	spin_lock_init(&new->lock);
-	new->deleted = false;
 	rcu_read_lock();
 	spin_lock(&new->lock);
 
@@ -278,6 +281,8 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	new->cuid = new->uid = euid;
 	new->gid = new->cgid = egid;
 
+	new->deleted = false;
+
 	idx = ipc_idr_alloc(ids, new);
 	idr_preload_end();
 
@@ -290,6 +295,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 		}
 	}
 	if (idx < 0) {
+		new->deleted = true;
 		spin_unlock(&new->lock);
 		rcu_read_unlock();
 		return idx;
-- 
2.17.1

