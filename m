Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14782EC2D01
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86D82147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="QwwYywIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86D82147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeGLTD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:03:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42781 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeGLTD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:03:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so3163426wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DOWFsvkXVBP/PlC9LU3PV5kWiJokDw749IeqxdST4lo=;
        b=QwwYywIV+nqkxVwkZvTwOq9vZdCp4S93coQ9er1YtLrvyMdYJXlHtdjMsPf0sScHWd
         JriM4wWPCROxd08P6w/7/8xO+OiIToNHysQb5e1uqCtSIQvZ2vhzG79aeGo6uikc0pqT
         wq+vH01M/p9WbKDBJnuYyOvZQfLu7ydTaAbjSJ+o380yU5klig+JG3hIN5coavFByT3f
         onVjMc9DMXy3YNTaggIaYZoOdO8oP0aqPQ+IVTqWFz1w9chpnrTnSgCgjtkIWSYwHZIC
         1IJ89fHQ6oGwThKGs/V79SudZO3Uprdc9SEoMOHA32JBSOpIcmrGi3E4Oknzp7zrP1pY
         0gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DOWFsvkXVBP/PlC9LU3PV5kWiJokDw749IeqxdST4lo=;
        b=dc0GormjAF+yTiypuYQUO+1xOY5BkpgqZfg1cAi8n91+73lbxIOzRjX4MYYfYZBnrc
         XbZeufG9jNsIlqjehd3L0VvXsws8DFyiz6e6A7eLfv/H3112zmR7BzekAdGtMvUvFfMf
         nJFpDHlgDSqVKsMvPG6aqKb0pSrKybmRx089GMIQ178eGAuxN+fu/74lZOuS4My2hvgQ
         6/t3Ll1OlKM69juv5DMWkOB2PN3IobvHnYaXYQ5lDd6m5q9qP0dXTKOSHy6cjmctHcZx
         /XDbZcrAvZBLs8x4yfIPunqSlIo93h6ZHYA/DiEM/GlxqTDWPjOaGPBL8r37k3bsgEzG
         eGOg==
X-Gm-Message-State: AOUpUlGxTlhrGWPBroZNFRfS4Ak/VWtQuv1CUewcCkqqKGrEIuEda7yv
        9ukvambYV8OQn07GJSvHupsNhg==
X-Google-Smtp-Source: AAOMgpc9NSX5JiPc2yMovqBzi81bMf+qimnZCfJpbo4fWZNG2lX+3gvYt9mbIFpbFDQma3gTNLtwnA==
X-Received: by 2002:adf:9142:: with SMTP id j60-v6mr2550615wrj.180.1531421588284;
        Thu, 12 Jul 2018 11:53:08 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:07 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH 02/12] ipc: reorganize initialization of kern_ipc_perm.seq
Date:   Thu, 12 Jul 2018 20:52:31 +0200
Message-Id: <20180712185241.4017-3-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipc_addid() initializes kern_ipc_perm.seq after having called
idr_alloc() (within ipc_idr_alloc()).

Thus a parallel semop() or msgrcv() that uses ipc_obtain_object_check()
may see an uninitialized value.

The patch moves the initialization of kern_ipc_perm.seq before the
calls of idr_alloc().

Notes:
1) This patch has a user space visible side effect:
If /proc/sys/kernel/*_next_id is used (i.e.: checkpoint/restore) and
if semget()/msgget()/shmget() fails in the final step of adding the id
to the rhash tree, then .._next_id is cleared. Before the patch, is
remained unmodified.

There is no change of the behavior after a successful ..get() call:
It always clears .._next_id, there is no impact to non checkpoint/restore
code as that code does not use .._next_id.

2) The patch correctly documents that after a call to ipc_idr_alloc(),
the full tear-down sequence must be used. The callers of ipc_addid()
do not fullfill that, i.e. more bugfixes are required.

The patch is a squash of a patch from Dmitry and my own changes.

Reported-by: syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 Documentation/sysctl/kernel.txt |  3 +-
 ipc/util.c                      | 91 +++++++++++++++++----------------
 2 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index eded671d55eb..b2d4a8f8fe97 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -440,7 +440,8 @@ Notes:
 1) kernel doesn't guarantee, that new object will have desired id. So,
 it's up to userspace, how to handle an object with "wrong" id.
 2) Toggle with non-default value will be set back to -1 by kernel after
-successful IPC object allocation.
+successful IPC object allocation. If an IPC object allocation syscall
+fails, it is undefined if the value remains unmodified or is reset to -1.
 
 ==============================================================
 
diff --git a/ipc/util.c b/ipc/util.c
index 4e81182fa0ac..4998f8fa8ce0 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -193,46 +193,54 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 	return NULL;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
 /*
- * Specify desired id for next allocated IPC object.
+ * Insert new IPC object into idr tree, and set sequence number and id
+ * in the correct order.
+ * Especially:
+ * - the sequence number must be set before inserting the object into the idr,
+ *   because the sequence number is accessed without a lock.
+ * - the id can/must be set after inserting the object into the idr.
+ *   All accesses must be done after getting kern_ipc_perm.lock.
+ *
+ * The caller must own kern_ipc_perm.lock.of the new object.
+ * On error, the function returns a (negative) error code.
  */
-#define ipc_idr_alloc(ids, new)						\
-	idr_alloc(&(ids)->ipcs_idr, (new),				\
-		  (ids)->next_id < 0 ? 0 : ipcid_to_idx((ids)->next_id),\
-		  0, GFP_NOWAIT)
-
-static inline int ipc_buildid(int id, struct ipc_ids *ids,
-			      struct kern_ipc_perm *new)
+static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 {
-	if (ids->next_id < 0) { /* default, behave as !CHECKPOINT_RESTORE */
+	int idx, next_id = -1;
+
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	next_id = ids->next_id;
+	ids->next_id = -1;
+#endif
+
+	/*
+	 * As soon as a new object is inserted into the idr,
+	 * ipc_obtain_object_idr() or ipc_obtain_object_check() can find it,
+	 * and the lockless preparations for ipc operations can start.
+	 * This means especially: permission checks, audit calls, allocation
+	 * of undo structures, ...
+	 *
+	 * Thus the object must be fully initialized, and if something fails,
+	 * then the full tear-down sequence must be followed.
+	 * (i.e.: set new->deleted, reduce refcount, call_rcu())
+	 */
+
+	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
 		new->seq = ids->seq++;
 		if (ids->seq > IPCID_SEQ_MAX)
 			ids->seq = 0;
+		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
 	} else {
-		new->seq = ipcid_to_seqx(ids->next_id);
-		ids->next_id = -1;
+		new->seq = ipcid_to_seqx(next_id);
+		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
+				0, GFP_NOWAIT);
 	}
-
-	return SEQ_MULTIPLIER * new->seq + id;
+	if (idx >= 0)
+		new->id = SEQ_MULTIPLIER * new->seq + idx;
+	return idx;
 }
 
-#else
-#define ipc_idr_alloc(ids, new)					\
-	idr_alloc(&(ids)->ipcs_idr, (new), 0, 0, GFP_NOWAIT)
-
-static inline int ipc_buildid(int id, struct ipc_ids *ids,
-			      struct kern_ipc_perm *new)
-{
-	new->seq = ids->seq++;
-	if (ids->seq > IPCID_SEQ_MAX)
-		ids->seq = 0;
-
-	return SEQ_MULTIPLIER * new->seq + id;
-}
-
-#endif /* CONFIG_CHECKPOINT_RESTORE */
-
 /**
  * ipc_addid - add an ipc identifier
  * @ids: ipc identifier set
@@ -250,7 +258,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 {
 	kuid_t euid;
 	kgid_t egid;
-	int id, err;
+	int idx, err;
 
 	if (limit > IPCMNI)
 		limit = IPCMNI;
@@ -270,30 +278,27 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	new->cuid = new->uid = euid;
 	new->gid = new->cgid = egid;
 
-	id = ipc_idr_alloc(ids, new);
+	idx = ipc_idr_alloc(ids, new);
 	idr_preload_end();
 
-	if (id >= 0 && new->key != IPC_PRIVATE) {
+	if (idx >= 0 && new->key != IPC_PRIVATE) {
 		err = rhashtable_insert_fast(&ids->key_ht, &new->khtnode,
 					     ipc_kht_params);
 		if (err < 0) {
-			idr_remove(&ids->ipcs_idr, id);
-			id = err;
+			idr_remove(&ids->ipcs_idr, idx);
+			idx = err;
 		}
 	}
-	if (id < 0) {
+	if (idx < 0) {
 		spin_unlock(&new->lock);
 		rcu_read_unlock();
-		return id;
+		return idx;
 	}
 
 	ids->in_use++;
-	if (id > ids->max_id)
-		ids->max_id = id;
-
-	new->id = ipc_buildid(id, ids, new);
-
-	return id;
+	if (idx > ids->max_id)
+		ids->max_id = idx;
+	return idx;
 }
 
 /**
-- 
2.17.1

