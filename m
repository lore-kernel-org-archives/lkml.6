Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AFEC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAC3208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="Am27Ccff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAC3208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbeGIPM1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:12:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51302 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933412AbeGIPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so21575082wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+vBLahhfd5+9YQ7Z0ZgVCrIcJVCAuZwQo7uCf3w6NkE=;
        b=Am27CcffrL25heBC58U3MogrbOhZg7u08lRupjdX10fy/0mCpZWSI5sWr0XUJDnYgz
         oxOs3QimkC2AG4SVjGITRxxxeRcbDn5bxzt5hi/uD2y028VvSIyw6CtZoeMm6DqZk01V
         mgjZebC38by4sM1oMgcmwDxX7xC/FgNHKyj/aPMMNiJtvKpSaU7zBeSZyELtA9orfhqn
         nGApcUpiiQaZskKN8B2qKVW6NWpngqnjWCsplIDSnhg+9R5z4ThMkv5gl48qGFrElk76
         0ebUuQEf37Q70TeTlvaqxlNJmMjO60yb5n+9GtIc30NwuXLf9Cmlj7ud0UX5VEZTfPkA
         7INw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+vBLahhfd5+9YQ7Z0ZgVCrIcJVCAuZwQo7uCf3w6NkE=;
        b=Myj1hdiwTpeK15i2FjsA7FfoTkRYnShz3x2stOYd7NxxPQVVQq+553OjHjjClGqh28
         F/PpbNHY7x8gIQZLcmcQMiUuDffVqTW3k+9jPWUfQ0v1cV+/ENltGQ3f5JDge916xjJD
         OBwh396giFxM2dxU7uE2mjFXeSxBTMvssGKBFJho6bgml7bUaKOCY36los4Nts4aemV/
         cQRSAV3fhPmzH/XO3YcC/S5d/4ZkAvsgEWwr20nPBM3//tFhtmCVcJ+hFAtz5fzF+Bcq
         zwslCqvf78fk1vRRLvwJsreJ2Ayet12+q7AgNslLbjxwi/6KOvBDPoO4xRnvpFwQulPN
         Fz/g==
X-Gm-Message-State: APt69E34BVYx0cVwPjaudONcF2vK0XzZUebMeYQpdpKPGSjRg7xkE9jE
        /3ULrFrdxd1JmuEwXPtGdLWYzQ==
X-Google-Smtp-Source: AAOMgpfWOOJqEiq/3nExnAGvO/1LWsQ/vNudYXKT2GEALfthsj53YYAFLhYx7FvL3ypr2VqDdKh85Q==
X-Received: by 2002:a1c:5b09:: with SMTP id p9-v6mr9873205wmb.0.1531149036844;
        Mon, 09 Jul 2018 08:10:36 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:36 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 06/12] ipc: rename ipc_lock() to ipc_lock_idr()
Date:   Mon,  9 Jul 2018 17:10:13 +0200
Message-Id: <20180709151019.1336-7-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipc/util.c contains multiple functions to get the ipc object
pointer given an id number.

There are two sets of function: One set verifies the sequence
counter part of the id number, other functions do not check
the sequence counter.

The standard for function names in ipc/util.c is
- ..._check() functions verify the sequence counter
- ..._idr() functions do not verify the sequence counter

ipc_lock() is an exception: It does not verify the sequence
counter value, but this is not obvious from the function name.

Therefore: Rename the function to ipc_lock_idr(), to make it
obvious that it does not check the sequence counter.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/shm.c  |  4 ++--
 ipc/util.c | 10 ++++++----
 ipc/util.h |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 426ba1039a7b..cd8655c7bb77 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -179,11 +179,11 @@ static inline struct shmid_kernel *shm_obtain_object_check(struct ipc_namespace
  */
 static inline struct shmid_kernel *shm_lock(struct ipc_namespace *ns, int id)
 {
-	struct kern_ipc_perm *ipcp = ipc_lock(&shm_ids(ns), id);
+	struct kern_ipc_perm *ipcp = ipc_lock_idr(&shm_ids(ns), id);
 
 	/*
 	 * Callers of shm_lock() must validate the status of the returned ipc
-	 * object pointer (as returned by ipc_lock()), and error out as
+	 * object pointer (as returned by ipc_lock_idr()), and error out as
 	 * appropriate.
 	 */
 	if (IS_ERR(ipcp))
diff --git a/ipc/util.c b/ipc/util.c
index 8133f10832a9..8bc166bb4981 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -604,15 +604,17 @@ struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
 }
 
 /**
- * ipc_lock - lock an ipc structure without rwsem held
+ * ipc_lock_idr - lock an ipc structure without rwsem held
  * @ids: ipc identifier set
  * @id: ipc id to look for
  *
  * Look for an id in the ipc ids idr and lock the associated ipc object.
+ * The function does not check if the sequence counter matches the
+ * found ipc object.
  *
  * The ipc object is locked on successful exit.
  */
-struct kern_ipc_perm *ipc_lock(struct ipc_ids *ids, int id)
+struct kern_ipc_perm *ipc_lock_idr(struct ipc_ids *ids, int id)
 {
 	struct kern_ipc_perm *out;
 
@@ -624,8 +626,8 @@ struct kern_ipc_perm *ipc_lock(struct ipc_ids *ids, int id)
 	spin_lock(&out->lock);
 
 	/*
-	 * ipc_rmid() may have already freed the ID while ipc_lock()
-	 * was spinning: here verify that the structure is still valid.
+	 * ipc_rmid() may have already freed the ID while waiting for
+	 * the lock. Here verify that the structure is still valid.
 	 * Upon races with RMID, return -EIDRM, thus indicating that
 	 * the ID points to a removed identifier.
 	 */
diff --git a/ipc/util.h b/ipc/util.h
index fcf81425ae98..25d8ee052ac9 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -142,7 +142,7 @@ int ipc_rcu_getref(struct kern_ipc_perm *ptr);
 void ipc_rcu_putref(struct kern_ipc_perm *ptr,
 			void (*func)(struct rcu_head *head));
 
-struct kern_ipc_perm *ipc_lock(struct ipc_ids *, int);
+struct kern_ipc_perm *ipc_lock_idr(struct ipc_ids *ids, int id);
 struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id);
 
 void kernel_to_ipc64_perm(struct kern_ipc_perm *in, struct ipc64_perm *out);
-- 
2.17.1

