Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAD2C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5417208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="UphIVq9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5417208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933501AbeGIPLg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:11:36 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:40459 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933353AbeGIPKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:36 -0400
Received: by mail-wm0-f51.google.com with SMTP id z13-v6so21137827wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xqGzimrhKbo3SEusIn4GZ/7tqQT4c0HQ+iumxAILxfM=;
        b=UphIVq9++4fmpu7RG8GtZ6HVz8IGj59mw4+UlLXpfJTjnC5Y2To2PYVKEWKzACq4Ti
         ZcZu8N8rRdSKdrl9+xkH/XEI3RGlh8c0di8UYdGkdKFMycxfoVUEqZLsPkGwoFSOq8S1
         8wv1DEQw3qLf88zyPPWEv1ZQZ0waVf7r1Igr1+hA2FTY2EXvkm6qWCUKPABqSwYDE3nZ
         ho6HSb2s+AU/QlK2sLZRbrtIxDiP4i4ZrWzdZWzqai0OSXwn3o5u/8WzcEPDBPXkjChr
         gMdI766BqWhfofmZF8iPzAjuqmJ5kOG6JDjME1jD8eskTUOnFFsvXktygvvvg/+0QDEO
         r+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xqGzimrhKbo3SEusIn4GZ/7tqQT4c0HQ+iumxAILxfM=;
        b=XDX3U6MdyGL26PBp79l3785Qcvv6UXexGEjXpkqGUU2HTet7t67pM/vb7cCjfYc+R2
         aELhgTA6gPsvkdwMAKtClkQyE6eLcUdSZCFQ+oAPNvtSbtrJv70FQ74rBIIfhsd0Dj1Z
         YK/gNAVLeA0U868aAzbi6p/FAeCW8Jahea/811eID1jHVqoleeMnBWpgy2roCR4xwfdk
         198an7ko7iI0dPosvm1jgDwNmqlF3W9MuO0yXxF18pamoP/j3rAwifTq5Q7Zd+ydovrs
         sM2KEH/ryDSMsoIi0dh9gjeA5KQZGOsrcqguXGIeZ6qJHmDBM2dlqXcEOb9YIH+AtLVu
         jZSw==
X-Gm-Message-State: APt69E26C880qhxo8/H7JzMAiHBzubKo3yt3EuSpvcu6dxzH9Sf3L+bs
        /eKI9RY5zrIbZ3zKQoabdrKeDQ==
X-Google-Smtp-Source: AAOMgpeMAhv0AxF2t2Gh3Zgk4ChrIGZMaZg54KZpbENsq7c+PlfOsn4VOKeoIjB8aezY7QS+aejoyQ==
X-Received: by 2002:a1c:c44f:: with SMTP id u76-v6mr12157196wmf.43.1531149035045;
        Mon, 09 Jul 2018 08:10:35 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:34 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 04/12] ipc: Rename ipcctl_pre_down_nolock().
Date:   Mon,  9 Jul 2018 17:10:11 +0200
Message-Id: <20180709151019.1336-5-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
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
- _check means that the sequence number is checked.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/msg.c  | 2 +-
 ipc/sem.c  | 2 +-
 ipc/shm.c  | 2 +-
 ipc/util.c | 8 ++++----
 ipc/util.h | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

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
index 8b09496ed720..bbb1ce212a0d 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -703,7 +703,7 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
 }
 
 /**
- * ipcctl_pre_down_nolock - retrieve an ipc and check permissions for some IPC_XXX cmd
+ * ipcctl_obtain_check - retrieve an ipc object and check permissions
  * @ns:  ipc namespace
  * @ids:  the table of ids where to look for the ipc
  * @id:   the id of the ipc to retrieve
@@ -713,16 +713,16 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
  *
  * This function does some common audit and permissions check for some IPC_XXX
  * cmd and is called from semctl_down, shmctl_down and msgctl_down.
- * It must be called without any lock held and:
  *
- *   - retrieves the ipc with the given id in the given table.
+ * It:
+ *   - retrieves the ipc object with the given id in the given table.
  *   - performs some audit and permission check, depending on the given cmd
  *   - returns a pointer to the ipc object or otherwise, the corresponding
  *     error.
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

