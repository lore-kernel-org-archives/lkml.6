Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B43C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A85224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYj4+QLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A85224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbeKMI7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:59:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42871 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbeKMI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:59:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so1281552pga.9;
        Mon, 12 Nov 2018 15:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FP20pGgu3D25STEzu2nQYXaFb5vqYhGB0+bCEyu/01c=;
        b=gYj4+QLLPEksUSiryQwvQyfZONhBhGfmUh6aioSQOgcZxDkws2ECAoGpjf/mp/Nbxr
         KPARXI8utFVk1kJaUtwb3VxjhHO4OJzsCDBhLN0sdIIJ1AQ49ulu+9Qw7yDo5R2Wj2Ph
         nNrZ24JgzwwK0O8lrvif9dZ4PVotn32doQl23DdWJ29gLWXeujl2ol6Y1lMQW+JnqKWk
         AopiBCgKrtdHzGGHEIugqmwW0f/+uVRM7lJzJ4KCyOX4xW/Rv+J3+y8HihBX/lh+Kdt/
         YcZ4ow5oHeZqFGJZV5FBmy4apL0w4PTmLhrQ7UfnAyfyGQWFSzJJkWF/9rr6RTw0dwFE
         09tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FP20pGgu3D25STEzu2nQYXaFb5vqYhGB0+bCEyu/01c=;
        b=nrIVGF+z0wDquaF406/pubjqeFZFZNZzRXQWPTphQPgUWmWhkGlqsHWb+YUq7OueFR
         z+M2gEqyTxV/Uc8Y7G+AGsd2OD/1tc6bzd+ih5o69IyQcnu5CO4B04YrYlnaEbKnlr5l
         pssOwXPEvDE8itVgKx7BIDyPI+1r9SBxItVUGdZQYS+uYljsvzStPq9I9AVTqwsWhmNN
         2nWLsJutLcydweLNv89lrmTp581wbb4ZIehlOk+yWL1DySvjjSAeLGw6h1svVXlYkSSk
         gY7fiOI6fbgMDlp8nJgYIuV2yLjOWyVueHVVyx6hi14M6NXWQH9/6tgfJXLbyvy9PDL1
         gqow==
X-Gm-Message-State: AGRZ1gLqCBuoN9dFp/M+3tEOUQDuBl0z+Hu2HYm6jSzUW1EoktWL6YDd
        YB7lAsAC9Tg+TVo4HcW6h6mJpHtRkKM=
X-Google-Smtp-Source: AJdET5cJI1OzvitXV07TBofoYcOdy8oEZlm9duqvqukYnnqjZ+3OFvzP3+WEkQ49SEBmpdjLbNf+CA==
X-Received: by 2002:a62:8012:: with SMTP id j18-v6mr2695769pfd.202.1542063867757;
        Mon, 12 Nov 2018 15:04:27 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:c2f7])
        by smtp.gmail.com with ESMTPSA id f64sm7192327pfh.0.2018.11.12.15.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 15:04:27 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 2/6] cgroup: implement __cgroup_task_count() helper
Date:   Mon, 12 Nov 2018 15:04:18 -0800
Message-Id: <20181112230422.5911-4-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181112230422.5911-1-guro@fb.com>
References: <20181112230422.5911-1-guro@fb.com>
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
index 75568fcf2180..fe01a9fa4a8d 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -224,6 +224,7 @@ int cgroup_rmdir(struct kernfs_node *kn);
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
index 4a3dae2a8283..ef3442555b32 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -561,6 +561,39 @@ static void cgroup_get_live(struct cgroup *cgrp)
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

