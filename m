Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6F3EC2D07
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EFE208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="cwS61NXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EFE208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbeGLTEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42788 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbeGLTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so3163680wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MLrWlCMkGsbat2WF/lcVmlbrqZPBNzqxzkpNlaqZ0R8=;
        b=cwS61NXtXXsCtxIzfWDjmY7Nyi1FqeRMet1cdMxxihEz/r+IIYy968cCzjkDC8Tmwq
         vPDMsV2sQ9FPG/Pl4UOeMA6mOQgvdy9tQ2b/396erIr5oNZNVoOmOWe8+DblgnE4n5H+
         UUP3IHZB9jlGSdN5JsoJLDlO8CUgExILN9xyhZZ5o2+6m4lco5bNEKkFPoSwphhYMTV8
         Ge6N+V5jNSQI1TuGIp4OXPC152+ROFa52e0YU4uR7o4UivEJGGs8bFk1+UkQZhhydLJT
         /hViNRWRoIkGjHnJwsiqgspcacFLEmJq65qmZcipKw5Gl/E6HMBcFnEj/Kyb3XFHqpbR
         GTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MLrWlCMkGsbat2WF/lcVmlbrqZPBNzqxzkpNlaqZ0R8=;
        b=sJX7ztwTaJ8JK0K8CW3VpF+XlFcjtjSEVijl+ZpnI657EVDEArQKDndPfkAu4lC6dt
         ybWhc25b8VkqMfFfMm8MQD7cn5CZ/c0p8eMNKxNXM1EJb9aA3W2OBTqrMyyyXyECPz4B
         9bTZaCC+mK7VOwg+TEwKEm6B71Ut8Hs869WdQNh5et+MHIUImPwc0JKTfYvMdy5m3tMa
         +EmdZ38/QGK+5By3rdZX284FaZ483eAbESqHSsQbDoVfSOq6jbOglSiCnQ8Qk8XaFvYG
         2l4qqp+aLv08rwwu3qX2sDUx4WsY4+A+M3pliZr4BRQBj6kNf9rZqxg3ZI0PjKkcxH5l
         8yQA==
X-Gm-Message-State: AOUpUlE2qpkOv+hVSFqsH800TZvvxIP6BFMkHcGBVPG0rM2Pm/lg6vn4
        5kgG5P9VmF+ANzzQYxZ0y9F7bg==
X-Google-Smtp-Source: AAOMgpc84DFNPD+lznkRfJ4zivaypYrHUOgpTr4ffjP/6fOyowM3Xs0B4+J1h9M+CxVGtFKMmUoIsA==
X-Received: by 2002:a5d:6250:: with SMTP id m16-v6mr2764602wrv.179.1531421594713;
        Thu, 12 Jul 2018 11:53:14 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:14 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 09/12] ipc: get rid of ids->tables_initialized hack
Date:   Thu, 12 Jul 2018 20:52:38 +0200
Message-Id: <20180712185241.4017-10-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

In sysvipc we have an ids->tables_initialized regarding the
rhashtable, introduced in:

commit 0cfb6aee70bd ("ipc: optimize semget/shmget/msgget for lots of keys")

It's there, specifically, to prevent nil pointer dereferences,
from using an uninitialized api. Considering how rhashtable_init()
can fail (probably due to ENOMEM, if anything), this made the
overall ipc initialization capable of failure as well. That alone
is ugly, but fine, however I've spotted a few issues regarding the
semantics of tables_initialized (however unlikely they may be):

- There is inconsistency in what we return to userspace: ipc_addid()
returns ENOSPC which is certainly _wrong_, while ipc_obtain_object_idr()
returns EINVAL.

- After we started using rhashtables, ipc_findkey() can return nil upon
!tables_initialized, but the caller expects nil for when the ipc structure
isn't found, and can therefore call into ipcget() callbacks.

Now that rhashtable initialization cannot fail, we can properly
get rid of the hack altogether.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

(commit id extended to 12 digits)
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 include/linux/ipc_namespace.h |  1 -
 ipc/util.c                    | 23 ++++++++---------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index b5630c8eb2f3..37f3a4b7c637 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -16,7 +16,6 @@ struct user_namespace;
 struct ipc_ids {
 	int in_use;
 	unsigned short seq;
-	bool tables_initialized;
 	struct rw_semaphore rwsem;
 	struct idr ipcs_idr;
 	int max_id;
diff --git a/ipc/util.c b/ipc/util.c
index 234f6d781df3..f620778b11d2 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -125,7 +125,6 @@ int ipc_init_ids(struct ipc_ids *ids)
 	if (err)
 		return err;
 	idr_init(&ids->ipcs_idr);
-	ids->tables_initialized = true;
 	ids->max_id = -1;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	ids->next_id = -1;
@@ -178,19 +177,16 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
  */
 static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 {
-	struct kern_ipc_perm *ipcp = NULL;
+	struct kern_ipc_perm *ipcp;
 
-	if (likely(ids->tables_initialized))
-		ipcp = rhashtable_lookup_fast(&ids->key_ht, &key,
+	ipcp = rhashtable_lookup_fast(&ids->key_ht, &key,
 					      ipc_kht_params);
+	if (!ipcp)
+		return NULL;
 
-	if (ipcp) {
-		rcu_read_lock();
-		ipc_lock_object(ipcp);
-		return ipcp;
-	}
-
-	return NULL;
+	rcu_read_lock();
+	ipc_lock_object(ipcp);
+	return ipcp;
 }
 
 /*
@@ -268,7 +264,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (limit > IPCMNI)
 		limit = IPCMNI;
 
-	if (!ids->tables_initialized || ids->in_use >= limit)
+	if (ids->in_use >= limit)
 		return -ENOSPC;
 
 	idr_preload(GFP_KERNEL);
@@ -577,9 +573,6 @@ struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
 	struct kern_ipc_perm *out;
 	int lid = ipcid_to_idx(id);
 
-	if (unlikely(!ids->tables_initialized))
-		return ERR_PTR(-EINVAL);
-
 	out = idr_find(&ids->ipcs_idr, lid);
 	if (!out)
 		return ERR_PTR(-EINVAL);
-- 
2.17.1

