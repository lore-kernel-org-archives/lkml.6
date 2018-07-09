Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9544C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918602086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="cFE6RJyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918602086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933379AbeGIPKm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:10:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33873 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933145AbeGIPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so11333658wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7EVOqd58kgAua7pE4tNQLfDXb+t/t+oe7kHgLTZJ2Uk=;
        b=cFE6RJyD7LOu47M+ZAaGeYPXX7Buz836ypR0ZYyPmu8+tfakMXzZgN/3D1Vapt/bTe
         Foqjhm0b40LrtxQv6Pqz5VsblgIHzE0qsvwMsfG9sMJ5chU78X0zlghknOUIYg2yeZN+
         1bzHNyJbuijG7BL3q6wNt4NVz4+jqt85hd9w95+YsvOcDHOabjJWoJlBwiq7Yt2SeFVv
         NnjcuX4wuJXRFRpx4tReY2yNspEEBV/p4MI7aC8Tstruaa01+MlX++baVQfWWyWoXG9t
         /16CFhwjvwWj5/N5q252R9bEWn17QIugyEOIuTxmGP3G5yA5h3bJPwdQlwMJtxE2QY7V
         A2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7EVOqd58kgAua7pE4tNQLfDXb+t/t+oe7kHgLTZJ2Uk=;
        b=MkmvwRUB+1M+Ny0gDBzaY3Huqo/xbl+2IUm0Wog+eTzkGJZB2PqvBd+O/g51l11Ego
         RO2i/oJqu+DRWyIiaJBPxLHVligJ0TTNEJ6YwsyIdMone3qxr/oC/k3SjhzWq1IXQisg
         4yoHGRWFZvsFbdmqiT+ecd+RbeNYYioymLYQWZzPI1C6I/RXVYgoAzzsyufDXUGta3XE
         5wNadB13R2MyXY+F9nCdtgp2o13PMo2CLCfTFkCdorJSyAHWGvier2WUZ4CgoqEXAOCC
         wKmCipxrk5MkBK64/RB0UJED5gYPNgChNjozesNqkhUXhsZgBhsJ/Bo7KDvUY86pa0CN
         t0VA==
X-Gm-Message-State: APt69E2EYsjzd6vv+1cSxvT7dQC34Enskir44kZq6aZHYTPSVQPkGhbf
        YCE0x8JkX42tAZy7FNCAvj+0ZA==
X-Google-Smtp-Source: AAOMgpcc0/7QJokpkq+AnKI+Jmq5UWknMFm2g6r083Zhi0meXoytL9on0YMQeTRNs17GHgzqYgUYQQ==
X-Received: by 2002:adf:8405:: with SMTP id 5-v6mr15801003wrf.167.1531149033078;
        Mon, 09 Jul 2018 08:10:33 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:32 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH 02/12] ipc: reorganize initialization of kern_ipc_perm.seq
Date:   Mon,  9 Jul 2018 17:10:09 +0200
Message-Id: <20180709151019.1336-3-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
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

