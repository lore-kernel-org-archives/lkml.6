Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2076C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6012417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="JO6SipO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6012417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeGEGA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:00:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52556 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbeGEF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:59:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id w16-v6so8886805wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MVFn38qCec6lrkiQKmwFoZWAowYV/VmZ/hr9waL54M=;
        b=JO6SipO1H7sYGAP39wosc1YZvg4znbahCzNDd5yC6Sj4HkAFBx1ZZWNWpnwmo1WeuQ
         OW7XgfL6Ibs1q2nWs4MSIYrLRip3wY3f7+xWz2UDcXyY0YmnIayC1oSC4Cf8V7M5f9E9
         zsfm9NuAWF3KSXMveKMLTkCdNeb2Mrp6kb2X3J5KkOkY3GH7nZk+yaIyE2cSZQr63AI+
         XAUnn2d5d599+Yyd6lhh3RDEq5X0A+n3zYrXZ9AoBKlabG5kcyNYT4ooH18FNUwCXjog
         Eu2WxSElaxD5pOmL1N8m97g/obySfBXUUAgCsU0N2kEYViVCp/ry9vNdcnSNfiFVuIzj
         CB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5MVFn38qCec6lrkiQKmwFoZWAowYV/VmZ/hr9waL54M=;
        b=gqHRhDKQPRYYa8GbpeWjlNyt41Sm4kkf6RMCNx04c+UMQzv9i2HL+CJ/X1FWpeFkqH
         GTAmga63AzBQYPllUy871w7TO5d0fwRnbLsBLaWMRAcbcHuOTHfhHRjkrrNJW0b+FQKZ
         wBtCl+1YzqM+YPVJF80NMZz5IW5EeOkz/XwuM81/OvH3hMKw4lo+PFTx9VJPHzp+1d+L
         hTuM5BhkkqAZH+q5kYM6mVe+XgAsKmyeFlK/UiiVHwfM1JYGQ0AmqM8H96CzkY8Zy9H5
         ExXE0W8N8SIgoTbFVItItgAvWB+n6Hk4v9OV0HFfBjxdzVKKyTh6lKHTsGPBTbvpLAvS
         +53w==
X-Gm-Message-State: APt69E2/V+xQayA/H5ZKp3W9i3IFa+U/hbJJ10Z3Gg0QLKjRoGJm9/xM
        6YEXIn2p1HJRIX2cNBHt45UsABNpvRfoTQ==
X-Google-Smtp-Source: AAOMgpexvPhdOr605/eVjOYZE9QeUizWQiCL0AFtahZ6j84qrr6xaJXpxRVGZ4pF/IUnuUtcxFttRQ==
X-Received: by 2002:a1c:cbc2:: with SMTP id b185-v6mr3272690wmg.117.1530770380126;
        Wed, 04 Jul 2018 22:59:40 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C4E0002E4725E865D6E031.dip0.t-ipconnect.de. [2003:d9:93c4:e000:2e47:25e8:65d6:e031])
        by smtp.googlemail.com with ESMTPSA id h40-v6sm7452689wrf.40.2018.07.04.22.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 22:59:39 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 3/6] ipc/util.c: Use ipc_rcu_putref() for failues in ipc_addid()
Date:   Thu,  5 Jul 2018 07:59:17 +0200
Message-Id: <20180705055920.19611-4-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705055920.19611-1-manfred@colorfullife.com>
References: <20180705055920.19611-1-manfred@colorfullife.com>
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

