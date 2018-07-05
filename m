Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C5C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1E32417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="OPB3UbSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1E32417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeGEF7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:59:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36335 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeGEF7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:59:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so8761955wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w+VVsCwywmVbN/eEv3++m+/kToDNiVlSoPWbj3fHxzI=;
        b=OPB3UbSOH/rAhJkTYT8xmL9Wyoh7EUSkZFEQD8V07scrd2v8gZre0ccgS81As1WaYC
         HrZke8B7/O+oTDDXGCF5vZNPXRD5YNZ88YFPql/9m5p8kfIfYHLAX51PF7TykaIhEzjm
         QIjMs4LU2agJuW1pnkdfyh6mqIHt4xtQ6AeXA8ixyIB8pIholtMclUb/2iKy0dIhYb7L
         YFT8wTVGDbhLJuoHke68l5cTxRyeTOLX1BipxLumErxaZF26XgI3U45oi5ky2sxDZZOc
         khHg/IkEYnCpcl51Ot3ZwweOvz/bXeBKlLAaRdKuoe6hJCPl+SptBBk3GeF+9EQnw2Pa
         TJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w+VVsCwywmVbN/eEv3++m+/kToDNiVlSoPWbj3fHxzI=;
        b=rrX34QdELcuBPdeX+hA4DQCais9hBptPpALRApnzAxd13MGBXh8GEqShCcx0VhXvJA
         h4XiiYdWrmrXbdoFrZzQgnMHD3pPcYrfcigL8BhmUO4Igv827ByqkVR25RQSCCgt+ejq
         1lChgB7YpU96VsDsjyx3oiztOHu13GZxloitrWJ3TqENsGRT54t937Vf7ZvqjO41+29V
         PZeYBiH9s7K59PAU181ZzECvrtpUKWaPLVRWPt4RrRltsjMlNJ13GGzDEMQFYl+JzeAS
         qOV6WuoCJJQ8OwTT9qFN7xoCDGBHqmGKopJKMxEq/JPyS0698u89Jk/NUguzB9Zpcfhm
         YCtQ==
X-Gm-Message-State: APt69E2Eu+8oTwJ25ubnN6G+w7hMoJJK61+2HtvgpchLqSLKUwqCRXV3
        0JJRsVpIb5YcD8hCm+ihgmlGPLlpn1XEqw==
X-Google-Smtp-Source: AAOMgpf9Me7x5gmDyRo7/yponX2Pz8kTd1+KrhEdLuQW0xLohaIw1Jv5qXJlhW+y1apFrmTgP+fxQA==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr3412618wmf.8.1530770376647;
        Wed, 04 Jul 2018 22:59:36 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C4E0002E4725E865D6E031.dip0.t-ipconnect.de. [2003:d9:93c4:e000:2e47:25e8:65d6:e031])
        by smtp.googlemail.com with ESMTPSA id h40-v6sm7452689wrf.40.2018.07.04.22.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 22:59:36 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH 2/6] ipc: reorganize initialization of kern_ipc_perm.seq
Date:   Thu,  5 Jul 2018 07:59:16 +0200
Message-Id: <20180705055920.19611-3-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705055920.19611-1-manfred@colorfullife.com>
References: <20180705055920.19611-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipc_addid() initializes kern_ipc_perm.seq after having called
ipc_idr_alloc().

Thus a parallel semop() or msgrcv() that uses ipc_obtain_object_check()
may see an uninitialized value.

The patch moves the initialization of kern_ipc_perm.seq before the
calls of ipc_idr_alloc().

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

Reported-by: syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 Documentation/sysctl/kernel.txt |  3 ++-
 ipc/util.c                      | 45 +++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 14 deletions(-)

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
index 4e81182fa0ac..662c28c6c9fa 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -197,13 +197,24 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 /*
  * Specify desired id for next allocated IPC object.
  */
-#define ipc_idr_alloc(ids, new)						\
-	idr_alloc(&(ids)->ipcs_idr, (new),				\
-		  (ids)->next_id < 0 ? 0 : ipcid_to_idx((ids)->next_id),\
-		  0, GFP_NOWAIT)
+static inline int ipc_idr_alloc(struct ipc_ids *ids,
+				struct kern_ipc_perm *new)
+{
+	int key;
 
-static inline int ipc_buildid(int id, struct ipc_ids *ids,
-			      struct kern_ipc_perm *new)
+	if (ids->next_id < 0) {
+		key = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
+	} else {
+		key = idr_alloc(&ids->ipcs_idr, new,
+				ipcid_to_idx(ids->next_id),
+				0, GFP_NOWAIT);
+		ids->next_id = -1;
+	}
+	return key;
+}
+
+static inline void ipc_set_seq(struct ipc_ids *ids,
+				struct kern_ipc_perm *new)
 {
 	if (ids->next_id < 0) { /* default, behave as !CHECKPOINT_RESTORE */
 		new->seq = ids->seq++;
@@ -211,24 +222,19 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
 			ids->seq = 0;
 	} else {
 		new->seq = ipcid_to_seqx(ids->next_id);
-		ids->next_id = -1;
 	}
-
-	return SEQ_MULTIPLIER * new->seq + id;
 }
 
 #else
 #define ipc_idr_alloc(ids, new)					\
 	idr_alloc(&(ids)->ipcs_idr, (new), 0, 0, GFP_NOWAIT)
 
-static inline int ipc_buildid(int id, struct ipc_ids *ids,
+static inline void ipc_set_seq(struct ipc_ids *ids,
 			      struct kern_ipc_perm *new)
 {
 	new->seq = ids->seq++;
 	if (ids->seq > IPCID_SEQ_MAX)
 		ids->seq = 0;
-
-	return SEQ_MULTIPLIER * new->seq + id;
 }
 
 #endif /* CONFIG_CHECKPOINT_RESTORE */
@@ -270,6 +276,19 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	new->cuid = new->uid = euid;
 	new->gid = new->cgid = egid;
 
+	ipc_set_seq(ids, new);
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
 	id = ipc_idr_alloc(ids, new);
 	idr_preload_end();
 
@@ -291,7 +310,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (id > ids->max_id)
 		ids->max_id = id;
 
-	new->id = ipc_buildid(id, ids, new);
+	new->id = SEQ_MULTIPLIER * new->seq + id;
 
 	return id;
 }
-- 
2.17.1

