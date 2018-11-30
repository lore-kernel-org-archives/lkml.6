Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D60C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB3620834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dseK9gLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB3620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeLAK66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:58:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43422 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:58:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so3540189pfk.10;
        Fri, 30 Nov 2018 15:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CXMv0Vhrfz8OgUyxnyaG6yJ3Btg8UiW/JMvPPUaP47g=;
        b=dseK9gLvRqCEjaUIDiNh6BoR08VIiCwfwpEK03qKOwbxyAli+YNA2zUJtTHp9iEigk
         EYiUaZB7ndO0EGLz2AluZJ7nuhL1ToenJAjeBzv3+tUvKtzyXXKyPug3I9mfkOu0DSw3
         Y1Imx/m2fBjNarZhVgS3nCJF0xWIZCoRGEHJNV6tV+yAJ+x/jnaXAVOlrWcs67jQ8hj8
         /Nn8GP7XYvd1T/yo6rE+s/JeGSZ7Ih9GD2aujpMhQfsF4Z0gw85nqUTi1r8zdBwD1tqh
         Xbyju0l6ecOodnkLmwF8JhHd5eiXJoX+APsytY7Lg7PAcVVxExeERkSbX7nOQNacQgu9
         h5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CXMv0Vhrfz8OgUyxnyaG6yJ3Btg8UiW/JMvPPUaP47g=;
        b=YeT4PZsGEJ1MfZ9LL5MyWWhW7z/ganTTCAbAOoPzv9hb4CBUM2fw6a8ylzdkB5MIbv
         SN1VIiI/OaJ6DtoS9e/esAkIb3+FBu6yMvOZnE0ZfJwl7rAWmNSWrD15XBvUuhCtuzrD
         hBGZPhog4X6hkt7vgZTPoEcY46x9yD/XfsiPjl+kOb/i4c9lyP7i3ZIKk23qI4Z+tQ7t
         n/3GYieyvS7MoxgQ6ujQiM5na42Tl2J7a2mNeBQmti4QXpADrLnYzMOmI0oeHHdWO9Re
         teaT8BE/GPoy280HwUHrf6H+YMPPtXrlVP+7X+HkNFSthw7GN81QVUznq3fPZZcadtTy
         pt3A==
X-Gm-Message-State: AA+aEWYKUYt076g4esfojtzBOec9PcsM6lyLREPEwBnOIhZZRviIJRa+
        l8SaWTzYJEZOVppZPn8yT+g=
X-Google-Smtp-Source: AFSGD/XIFKZpt/pdi0/VHyBxLuV4A5INsLjVIPU8NkzjtwnsGBQcF80ppOXyJE/bUROvW64/w5MUVg==
X-Received: by 2002:a65:6684:: with SMTP id b4mr6442262pgw.55.1543621675464;
        Fri, 30 Nov 2018 15:47:55 -0800 (PST)
Received: from castle.tfbnw.net ([2620:10d:c090:180::1:2b61])
        by smtp.gmail.com with ESMTPSA id e188sm9556742pfg.130.2018.11.30.15.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:47:54 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 2/7] cgroup: implement __cgroup_task_count() helper
Date:   Fri, 30 Nov 2018 15:47:40 -0800
Message-Id: <20181130234745.6756-3-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130234745.6756-1-guro@fb.com>
References: <20181130234745.6756-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper is identical to the existing cgroup_task_count()
except it doesn't take the css_set_lock by itself, assuming
that the caller does.

Also, move cgroup_task_count() implementation into
kernel/cgroup/cgroup.c, as there is nothing specific to cgroup v1.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 kernel/cgroup/cgroup-internal.h |  1 +
 kernel/cgroup/cgroup-v1.c       | 16 ----------------
 kernel/cgroup/cgroup.c          | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c950864016e2..a195328431ce 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -226,6 +226,7 @@ int cgroup_rmdir(struct kernfs_node *kn);
 int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 		     struct kernfs_root *kf_root);
 
+int __cgroup_task_count(const struct cgroup *cgrp);
 int cgroup_task_count(const struct cgroup *cgrp);
 
 /*
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 51063e7a93c2..6134fef07d57 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -336,22 +336,6 @@ static struct cgroup_pidlist *cgroup_pidlist_find_create(struct cgroup *cgrp,
 	return l;
 }
 
-/**
- * cgroup_task_count - count the number of tasks in a cgroup.
- * @cgrp: the cgroup in question
- */
-int cgroup_task_count(const struct cgroup *cgrp)
-{
-	int count = 0;
-	struct cgrp_cset_link *link;
-
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(link, &cgrp->cset_links, cset_link)
-		count += link->cset->nr_tasks;
-	spin_unlock_irq(&css_set_lock);
-	return count;
-}
-
 /*
  * Load a cgroup's pidarray with either procs' tgids or tasks' pids
  */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e06994fd4e34..7519a4307021 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -563,6 +563,39 @@ static void cgroup_get_live(struct cgroup *cgrp)
 	css_get(&cgrp->self);
 }
 
+/**
+ * __cgroup_task_count - count the number of tasks in a cgroup. The caller
+ * is responsible for taking the css_set_lock.
+ * @cgrp: the cgroup in question
+ */
+int __cgroup_task_count(const struct cgroup *cgrp)
+{
+	int count = 0;
+	struct cgrp_cset_link *link;
+
+	lockdep_assert_held(&css_set_lock);
+
+	list_for_each_entry(link, &cgrp->cset_links, cset_link)
+		count += link->cset->nr_tasks;
+
+	return count;
+}
+
+/**
+ * cgroup_task_count - count the number of tasks in a cgroup.
+ * @cgrp: the cgroup in question
+ */
+int cgroup_task_count(const struct cgroup *cgrp)
+{
+	int count;
+
+	spin_lock_irq(&css_set_lock);
+	count = __cgroup_task_count(cgrp);
+	spin_unlock_irq(&css_set_lock);
+
+	return count;
+}
+
 struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 {
 	struct cgroup *cgrp = of->kn->parent->priv;
-- 
2.17.2

