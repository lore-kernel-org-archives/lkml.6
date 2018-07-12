Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A100EC310A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36042124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="u5o2Y3Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36042124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbeGLTED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41461 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeGLTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so16194317wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YTg++A2XyD4RJX13zCaicBxSq5ZoZNMYFu4OGjlcCeI=;
        b=u5o2Y3Ye+1sjBjn+7/Dr7u++ZMT8RKh9dscIfYKiyhkfHnLUSK1AspXZKHbw8i4Zql
         izdJbgE4MViVhXT8qmGEMjkNH4TZroAv0ALJgdDXtPsVOSgzcxzzBgpAPmtzeOwbIZN3
         fw81N/rXtQVDLpp0NkDlzHsAA4BXIoLIgMmRRs81AQdQEU54VdACp6h2+DoJr4eWBTbd
         OA1WObDQwgSZtwc40BuWegvonVY9+N3rxiKshl/BP16SuZTvTMcb5xUSHE8CjBnauRnd
         morBg4quqvVtgTREY4rpSVje0Flt7iYuEpSSMLG/ES9Gbut6R6e5sqNRo1alOCOgxVEH
         RiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YTg++A2XyD4RJX13zCaicBxSq5ZoZNMYFu4OGjlcCeI=;
        b=CDMZEaV0Zq+YiZFpYsrWNEg1bKnIvzsLhQWkNdKsVHeZO/acy7PTzw0WD2N/CEGJxZ
         vIL2HZni2e7Ym2k19Xz4H4Pb89vMPNuOQIkrsGpleWBYslkllJRXVnFWRHePrNBjyNPi
         DZYX3t7cllSuD4gAG5aoaKkBTN+QeYEkL2FlOAHweRPBCqSN+YFHZgAAIP9h1Mm/6kVn
         9d+wjG06Iiek6UjEpOw0lbyd0lxeySO6kSK1Ddi9bewEcdTu5QyputgbiL2mPyMbzzq9
         PC02o0O5YSdN07qFavbUdulJ0dfSvVu5/h8klBKWN2DMDhKbJIQdUC5EtEY5RQVDMIe6
         BvIg==
X-Gm-Message-State: AOUpUlGu3MLHQ+1ScuBwHkua25wNMY54nRyfsguRxT4JjDJgf2jrtrYt
        vPNZK1Isd4jGnKo+LN++2u26uQ==
X-Google-Smtp-Source: AAOMgpcPDeELB9ZACvglLu9qGHmlR1pHO26Pu2SzBj5PF87fPKJGqg8c76u+c+tZl6SZcwAFMbvRmA==
X-Received: by 2002:a5d:514d:: with SMTP id u13-v6mr2609051wrt.162.1531421592151;
        Thu, 12 Jul 2018 11:53:12 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:11 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 06/12] ipc: drop ipc_lock()
Date:   Thu, 12 Jul 2018 20:52:35 +0200
Message-Id: <20180712185241.4017-7-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

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

Furthermore, shm.c is the only user of this helper. Thus, we
can simply move the logic into shm_lock() and get rid of the
function altogether.

[changelog mostly by manfred]
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/shm.c  | 29 +++++++++++++++++++++++------
 ipc/util.c | 36 ------------------------------------
 ipc/util.h |  1 -
 3 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 0a509befb558..22afb98363ff 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -179,16 +179,33 @@ static inline struct shmid_kernel *shm_obtain_object_check(struct ipc_namespace
  */
 static inline struct shmid_kernel *shm_lock(struct ipc_namespace *ns, int id)
 {
-	struct kern_ipc_perm *ipcp = ipc_lock(&shm_ids(ns), id);
+	struct kern_ipc_perm *ipcp;
+
+	rcu_read_lock();
+	ipcp = ipc_obtain_object_idr(&shm_ids(ns), id);
+	if (IS_ERR(ipcp))
+		goto err;
 
+	ipc_lock_object(ipcp);
+	/*
+	 * ipc_rmid() may have already freed the ID while ipc_lock_object()
+	 * was spinning: here verify that the structure is still valid.
+	 * Upon races with RMID, return -EIDRM, thus indicating that
+	 * the ID points to a removed identifier.
+	 */
+	if (ipc_valid_object(ipcp)) {
+		/* return a locked ipc object upon success */
+		return container_of(ipcp, struct shmid_kernel, shm_perm);
+	}
+
+	ipc_unlock_object(ipcp);
+err:
+	rcu_read_unlock();
 	/*
 	 * Callers of shm_lock() must validate the status of the returned ipc
-	 * object pointer (as returned by ipc_lock()), and error out as
-	 * appropriate.
+	 * object pointer and error out as appropriate.
 	 */
-	if (IS_ERR(ipcp))
-		return (void *)ipcp;
-	return container_of(ipcp, struct shmid_kernel, shm_perm);
+	return (void *)ipcp;
 }
 
 static inline void shm_lock_by_ptr(struct shmid_kernel *ipcp)
diff --git a/ipc/util.c b/ipc/util.c
index 5cc37066e659..234f6d781df3 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -587,42 +587,6 @@ struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
 	return out;
 }
 
-/**
- * ipc_lock - lock an ipc structure without rwsem held
- * @ids: ipc identifier set
- * @id: ipc id to look for
- *
- * Look for an id in the ipc ids idr and lock the associated ipc object.
- *
- * The ipc object is locked on successful exit.
- */
-struct kern_ipc_perm *ipc_lock(struct ipc_ids *ids, int id)
-{
-	struct kern_ipc_perm *out;
-
-	rcu_read_lock();
-	out = ipc_obtain_object_idr(ids, id);
-	if (IS_ERR(out))
-		goto err;
-
-	spin_lock(&out->lock);
-
-	/*
-	 * ipc_rmid() may have already freed the ID while ipc_lock()
-	 * was spinning: here verify that the structure is still valid.
-	 * Upon races with RMID, return -EIDRM, thus indicating that
-	 * the ID points to a removed identifier.
-	 */
-	if (ipc_valid_object(out))
-		return out;
-
-	spin_unlock(&out->lock);
-	out = ERR_PTR(-EIDRM);
-err:
-	rcu_read_unlock();
-	return out;
-}
-
 /**
  * ipc_obtain_object_check
  * @ids: ipc identifier set
diff --git a/ipc/util.h b/ipc/util.h
index fcf81425ae98..e3c47b21db93 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -142,7 +142,6 @@ int ipc_rcu_getref(struct kern_ipc_perm *ptr);
 void ipc_rcu_putref(struct kern_ipc_perm *ptr,
 			void (*func)(struct rcu_head *head));
 
-struct kern_ipc_perm *ipc_lock(struct ipc_ids *, int);
 struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id);
 
 void kernel_to_ipc64_perm(struct kern_ipc_perm *in, struct ipc64_perm *out);
-- 
2.17.1

