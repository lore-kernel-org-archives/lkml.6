Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5153AEC2D07
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C4E208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="sbK5639S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C4E208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeGLTEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeGLTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so22757662wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h/1bIwJFU6W5L1EVOq2WCFhvHnNImSro/mZ3CbR0tRg=;
        b=sbK5639SG6ASR010cueUU3EfPBq5wF9jsWG55nPWa9r6A8ej8DRhOQ4qXIkFg4O5pn
         1W9KjNOCaQOruhlxg9Qyx4Q8FNLTtRziQ67sYV2Z3pxARRDM3QvVta/rpYVSHCKehrZN
         YflsljMl02y2pUWeXyd+bP17cxhrxXMY1IBp5EVI0d3A1BN79APwtZTlLc+o1NCuoZLu
         zEWuzMzxVChD4gag1sYX4YczAixZyUctBSzhQjqfYIX+7+5hh+krE4Ben2jTF72n3GKd
         6Cagw08d1g0lS00W5ypHedL/6PL9Op/5g/UPIJVsjFryJGSVGbchTkQjVFtqXE0T3ZP3
         oJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h/1bIwJFU6W5L1EVOq2WCFhvHnNImSro/mZ3CbR0tRg=;
        b=piGZIChZ3IYT6hAhXTaKYoiRABLj3KoAWTOXfKeQpo+Eu4dogm8Y1VxUpIDsbBa1hj
         A4U1hCASnX0lYVUFLQ6sD7692tWkQmaRdNbEeunqjGo1968fJX2Yv5spbZE1XJAc+Cl7
         GUQEWH6+7AgzYUex4i3DTuIFjPxULcL6uc6g3HcNSM6mqh2FZ67LXar6wKyg0Gi59OlS
         pJ1ZTIyWXxq9913LIhNCB7MVc/+K8Cf2JyXwUzE9f/F6uMjHzeANQwqqVAISS5k4XcLx
         BNF6yeCY9waOmXLfPvfT7wVYpABYlEpJUSaZLSjDUYLBeL/ZYDbUne72UXm5+bVga4HW
         StyQ==
X-Gm-Message-State: AOUpUlGBDRASlxWiazHOvJhIFEjQYBV8BWlp1mu/nGs9PZDDY+bBXlxJ
        tZiNQRgDDYQx1MPNh9wINggbdQ==
X-Google-Smtp-Source: AAOMgpf5jV2CrpGqk9psrWXM+5ivfiCwgF2XhNhs4inpkj9yImFsvMLAYcFbf/VL0/tSZIvo/TG8OA==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr2786034wrq.156.1531421590388;
        Thu, 12 Jul 2018 11:53:10 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:09 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 04/12] ipc: Rename ipcctl_pre_down_nolock().
Date:   Thu, 12 Jul 2018 20:52:33 +0200
Message-Id: <20180712185241.4017-5-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
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
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/msg.c  | 2 +-
 ipc/sem.c  | 2 +-
 ipc/shm.c  | 2 +-
 ipc/util.c | 8 ++++----
 ipc/util.h | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 38119c1f0da3..4aca0ce363b5 100644
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
index 8a0a1eb05765..da1626984083 100644
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
index 92d71abe9e8f..0a509befb558 100644
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
index f3447911c81e..cffd12240f67 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -687,7 +687,7 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
 }
 
 /**
- * ipcctl_pre_down_nolock - retrieve an ipc and check permissions for some IPC_XXX cmd
+ * ipcctl_obtain_check - retrieve an ipc object and check permissions
  * @ns:  ipc namespace
  * @ids:  the table of ids where to look for the ipc
  * @id:   the id of the ipc to retrieve
@@ -697,16 +697,16 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
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

