Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F95C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8582417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="oG8V9uqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8582417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeGEF7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:59:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42596 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeGEF7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:59:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1-v6so527794wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rgomvK8VaUfDx59yuJwsojUVMJvYmQ4RdeosPImHvMg=;
        b=oG8V9uqTMQYvZLRm+8IOSnUUbAKz4SGbZC3eYR2dTLHjLId80HQ1u/d+fZRjS/hPgC
         EDOoF7zV8aEB/4+aeDd9XXILWC/ivGMgA8qnxLsEZhuWS/w7NCEdEFTOa6Ha6QABvnyP
         oGacSNWwQSb5nXU2gqlbI7fEwRMhSUCNrJFq5nz7jmaqHK4XzC/RXtEHi4nwpl+A8hA0
         AO8x0vaWkpSc6Uhty//Af0/iFHXGxpBVw6iU2BrLaU01jANFusR3lL95PUocx1BCAmg+
         dolUQcCLdEE9z+DUukf0cPXHD74QYbuk5Adr5vYweFZmejHdBe/aYQ+mqqomAu6oMRBP
         +QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rgomvK8VaUfDx59yuJwsojUVMJvYmQ4RdeosPImHvMg=;
        b=tU4PT68dGZIfQmmpp4XlUiO+aat7q0AonA8ZC88nr4ZzSRHYk5qaHeaMIkvuwMqNtM
         6nMfu+8a8kXBk4zOoYkDp8Fq57tQZZODyKgvpcbb7FXI0KuvEd14ljJl3fyH7Vrq1U+f
         bDaASdF0jUzQLhbwVposGEQduiukR9f6ggkp1cqBA69jGdvKoqwaE12Yv//xHQxfVPrs
         n7j7rV3gZPf7i9nAyaZZ0N67WFye/W+sCOQsyYMSTWpDuQzs1C3CXYM/dQ3Rovkuhob0
         y1FzgE9qtGiv55V5llwc/eQukZXHVbllkbhbce4qHR3OtSExwnoOa7UV2luDTMPlcy53
         Nwug==
X-Gm-Message-State: APt69E0LH5U9+jRMbyVNQcZUmW+DCa5gNQ5Dw+Ll8FCFaZJTW2nOqNwP
        bIq4vnxmB+3OV+e+xlALObwRnap+0QJ3Vg==
X-Google-Smtp-Source: AAOMgpciS4QKEWIjEnS9ymT1rx9g8O8yutDmm5oJa6TvifsVFJqPzwRiE1GtZSTODWGvjqhSgHI8EQ==
X-Received: by 2002:a5d:67c6:: with SMTP id n6-v6mr3328520wrw.39.1530770383420;
        Wed, 04 Jul 2018 22:59:43 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C4E0002E4725E865D6E031.dip0.t-ipconnect.de. [2003:d9:93c4:e000:2e47:25e8:65d6:e031])
        by smtp.googlemail.com with ESMTPSA id h40-v6sm7452689wrf.40.2018.07.04.22.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 22:59:43 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 5/6] ipc: rename ipc_lock() to ipc_lock_idr()
Date:   Thu,  5 Jul 2018 07:59:19 +0200
Message-Id: <20180705055920.19611-6-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705055920.19611-1-manfred@colorfullife.com>
References: <20180705055920.19611-1-manfred@colorfullife.com>
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
index 751d39baaf38..4f2db913acf9 100644
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
index fcf81425ae98..ed74b0fc68c9 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -142,7 +142,7 @@ int ipc_rcu_getref(struct kern_ipc_perm *ptr);
 void ipc_rcu_putref(struct kern_ipc_perm *ptr,
 			void (*func)(struct rcu_head *head));
 
-struct kern_ipc_perm *ipc_lock(struct ipc_ids *, int);
+struct kern_ipc_perm *ipc_lock_idr(struct ipc_ids *, int);
 struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id);
 
 void kernel_to_ipc64_perm(struct kern_ipc_perm *in, struct ipc64_perm *out);
-- 
2.17.1

