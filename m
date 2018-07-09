Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD90C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CFD2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="HUo97ZPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CFD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933454AbeGIPMH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:12:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933432AbeGIPKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id u7-v6so11372882wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNkJqYQ7TordGVZZGWvihcnhLeI3EnGx5cTrOe6u7s4=;
        b=HUo97ZPtZPKFsoV3KdwJR44wHBegx0UzyAMgxSNVcEZZKRaynSIp4ZZAp0DIiozhTn
         RCPTzm4qvk/AZEVVpUa7sJ/Hzb/2Dn41Ee6pKciGzWgHE08qxyi8vYj+uXgAaZkaYONM
         HciCFdIQiIIrkkvOkcvgncH1pNpwEZjMEyVNBpXsBRrSjJBIGahIIP9byoKu7xJKtjpR
         caW70MJWdovLJGfo/yH12fnx6MBWkC0Np5x3YJLyydiGAlja1NcMc3sfIQN5M/G5otF9
         9MvCm2QM8XeFVq1mjcYN4tXC6hfChz2bf5rxZOKp5yP5ksSYWr6rkT/xU0szdC8u0DT4
         MJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VNkJqYQ7TordGVZZGWvihcnhLeI3EnGx5cTrOe6u7s4=;
        b=O1zMCP5HbOM1rdkme0EwtknpLhARZUGPkdx2X2r84l4aZnLtt0txRNeAEfKxeSKQ0j
         JCRwafDZwzX62OrgdW9h+nhmsgj9NE6R/PZ71Bm5Nyf7Z9tdxA6uWb1/fIawcDphCA8V
         sr/enOo1TJqFxsXBviHgCJgj3T7P/vlMCMIuLxtQNiKn9hhjMEF11DTnL4LBM0QjjWiP
         tF6d3stnjPxmdjir7bsIshZ3LlEAVWWPHh5PqW8ehKz5R0vmNqvgZ47ygVNOKZFo+eNY
         /i5g078ukqAXJSoIT+IlcdzBBlPj1OPCR6tI+PD/KZKUWPwkAIWANZQvK+hzbxJmIiLZ
         aA0w==
X-Gm-Message-State: APt69E2Tiz/nd3TeuHb3mFYiaq8+imigq2HJQwadVwhHzFUFLthQoRDt
        gRGluXkmklimzsVp1Gc52L4Q7w==
X-Google-Smtp-Source: AAOMgpeOnpovriHLOL8Gk0an80yQUluR1pQswuGar1STwEaO1CivbHd4F0loSQE1UQIKVesBS7xcxg==
X-Received: by 2002:adf:f783:: with SMTP id q3-v6mr14449713wrp.108.1531149040891;
        Mon, 09 Jul 2018 08:10:40 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:40 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 10/12] ipc: get rid of ids->tables_initialized hack
Date:   Mon,  9 Jul 2018 17:10:17 +0200
Message-Id: <20180709151019.1336-11-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
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
index a41b8a69de13..ae485b41ea0b 100644
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
@@ -246,7 +242,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (limit > IPCMNI)
 		limit = IPCMNI;
 
-	if (!ids->tables_initialized || ids->in_use >= limit)
+	if (ids->in_use >= limit)
 		return -ENOSPC;
 
 	idr_preload(GFP_KERNEL);
@@ -568,9 +564,6 @@ struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
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

