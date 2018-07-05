Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39379C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEE02417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="waoopo+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEE02417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeGEF7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:59:46 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55518 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753355AbeGEF7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:59:43 -0400
Received: by mail-wm0-f45.google.com with SMTP id v16-v6so8926022wmv.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QWcs2HU/3EysfNyXbu6xsy9xOxqamUhhKxKWA9iJJxw=;
        b=waoopo+8AaM/Qp3f5NCgT2WelWK1n0xv+kRu4Sk0SMcfIWDmBs9CyOK7aMRUiSHmi2
         UIMnfNkwEZiVvzkIqIysR6vM0w2cAdow+S1e4gcBNfjXEsKa3QC5fkxbnw9BmynO4o4q
         znnJzFwhkRI5mnh2izC9wHb3hzzPLVNIX2vB+CjLsWmHTRPODJcLCcew4+fbZhDTL2IU
         nAoGNGhUfK2Xj3y5a9feKSTkHDeHZs3LByyOhxhYn1xiqmh1zTYfo2ByZNAiJzEVS9nF
         JA8LRyd5e4mzHwvqCZO1jIWCl2RyNwJp0qMkOWHQy5HIXQX6d4yIUs8xZTnlFqS/rdBn
         G7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QWcs2HU/3EysfNyXbu6xsy9xOxqamUhhKxKWA9iJJxw=;
        b=Ux9CKviYULybxyx+AC2rcPI4DQV55+4z9WHCy0HjLNwyEvYek5hn+RVWOsFC0Kqpjb
         /mull+/PT71rSLtGnk412I3svBRso67FUY+DCsEezGR7C9dXj2D4YbdK/T/KcDJZKpxV
         k6cxX9AELvBB0SUnOtThBmBYEazjOKgsIKq5dYYAwSazJG9IDU+uJXnLTtrepJurcgL5
         aWZY0niD4GzQhJs/Je6+DEaBd8mqU+1flViYzrt9GKAWshoe1oDk+3WdtIuAhWqeJgtA
         6IGbWhJaj4cG2huDFXoFNIgC0Bp/hnkwcT88cfALUU5Z4D274h96v46L8XJD9FTFQuQO
         cwPw==
X-Gm-Message-State: APt69E3yf9wIvdWU/yv0aXhe2IMVcluPv1wOAUqhE4+vBk5kJBV5cem6
        /Efof/fwTEl6hFMy8WGiZ+gjLkOqSC2BdQ==
X-Google-Smtp-Source: AAOMgpe/hozezK2w3JWr4Ssflgy26yv6rRUZ8hI0lqohSoA94mOpCFpIF/8pLDAj1PaOH19VAE7Oww==
X-Received: by 2002:adf:bbd4:: with SMTP id z20-v6mr3526400wrg.183.1530770381946;
        Wed, 04 Jul 2018 22:59:41 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C4E0002E4725E865D6E031.dip0.t-ipconnect.de. [2003:d9:93c4:e000:2e47:25e8:65d6:e031])
        by smtp.googlemail.com with ESMTPSA id h40-v6sm7452689wrf.40.2018.07.04.22.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 22:59:41 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 4/6] ipc: Rename ipcctl_pre_down_nolock().
Date:   Thu,  5 Jul 2018 07:59:18 +0200
Message-Id: <20180705055920.19611-5-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705055920.19611-1-manfred@colorfullife.com>
References: <20180705055920.19611-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the comment and the name of ipcctl_pre_down_nolock()
are misleading: The function must be called while holdling
the rw semaphore.
Therefore the patch renames the function to ipcctl_obtain_check():
This name matches the other names used in util.c:
- "obtain" function look up a pointer in the idr, without
  acquiring the object lock.
- The caller is responsible for locking.
- _check means that some checks are made.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/msg.c  | 2 +-
 ipc/sem.c  | 2 +-
 ipc/shm.c  | 2 +-
 ipc/util.c | 6 +++---
 ipc/util.h | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 5bf5cb8017ea..ba85d8849e8d 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -385,7 +385,7 @@ static int msgctl_down(struct ipc_namespace *ns, int msqid, int cmd,
 	down_write(&msg_ids(ns).rwsem);
 	rcu_read_lock();
 
-	ipcp = ipcctl_pre_down_nolock(ns, &msg_ids(ns), msqid, cmd,
+	ipcp = ipcctl_obtain_check(ns, &msg_ids(ns), msqid, cmd,
 				      &msqid64->msg_perm, msqid64->msg_qbytes);
 	if (IS_ERR(ipcp)) {
 		err = PTR_ERR(ipcp);
diff --git a/ipc/sem.c b/ipc/sem.c
index 9d49efeac2e5..9742e9a1c0c2 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1595,7 +1595,7 @@ static int semctl_down(struct ipc_namespace *ns, int semid,
 	down_write(&sem_ids(ns).rwsem);
 	rcu_read_lock();
 
-	ipcp = ipcctl_pre_down_nolock(ns, &sem_ids(ns), semid, cmd,
+	ipcp = ipcctl_obtain_check(ns, &sem_ids(ns), semid, cmd,
 				      &semid64->sem_perm, 0);
 	if (IS_ERR(ipcp)) {
 		err = PTR_ERR(ipcp);
diff --git a/ipc/shm.c b/ipc/shm.c
index 06b7bf11a011..426ba1039a7b 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -868,7 +868,7 @@ static int shmctl_down(struct ipc_namespace *ns, int shmid, int cmd,
 	down_write(&shm_ids(ns).rwsem);
 	rcu_read_lock();
 
-	ipcp = ipcctl_pre_down_nolock(ns, &shm_ids(ns), shmid, cmd,
+	ipcp = ipcctl_obtain_check(ns, &shm_ids(ns), shmid, cmd,
 				      &shmid64->shm_perm, 0);
 	if (IS_ERR(ipcp)) {
 		err = PTR_ERR(ipcp);
diff --git a/ipc/util.c b/ipc/util.c
index 8b09496ed720..751d39baaf38 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -703,7 +703,7 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
 }
 
 /**
- * ipcctl_pre_down_nolock - retrieve an ipc and check permissions for some IPC_XXX cmd
+ * ipcctl_obtain_check - retrieve an ipc and check permissions for some IPC_XXX cmd
  * @ns:  ipc namespace
  * @ids:  the table of ids where to look for the ipc
  * @id:   the id of the ipc to retrieve
@@ -713,7 +713,7 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
  *
  * This function does some common audit and permissions check for some IPC_XXX
  * cmd and is called from semctl_down, shmctl_down and msgctl_down.
- * It must be called without any lock held and:
+ * It:
  *
  *   - retrieves the ipc with the given id in the given table.
  *   - performs some audit and permission check, depending on the given cmd
@@ -722,7 +722,7 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
  *
  * Call holding the both the rwsem and the rcu read lock.
  */
-struct kern_ipc_perm *ipcctl_pre_down_nolock(struct ipc_namespace *ns,
+struct kern_ipc_perm *ipcctl_obtain_check(struct ipc_namespace *ns,
 					struct ipc_ids *ids, int id, int cmd,
 					struct ipc64_perm *perm, int extra_perm)
 {
diff --git a/ipc/util.h b/ipc/util.h
index 0aba3230d007..fcf81425ae98 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -148,7 +148,7 @@ struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id);
 void kernel_to_ipc64_perm(struct kern_ipc_perm *in, struct ipc64_perm *out);
 void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out);
 int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out);
-struct kern_ipc_perm *ipcctl_pre_down_nolock(struct ipc_namespace *ns,
+struct kern_ipc_perm *ipcctl_obtain_check(struct ipc_namespace *ns,
 					     struct ipc_ids *ids, int id, int cmd,
 					     struct ipc64_perm *perm, int extra_perm);
 
-- 
2.17.1

