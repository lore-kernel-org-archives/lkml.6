Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697A1ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0FB20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1ge932A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0FB20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeKIFxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:53:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39429 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeKIFxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:53:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id e4so28823211qkh.6;
        Thu, 08 Nov 2018 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FP20pGgu3D25STEzu2nQYXaFb5vqYhGB0+bCEyu/01c=;
        b=J1ge932AU57OX3pVF2qFu6ZAwgjQSy7uYb65qI+r32Ukf8L7ttlHLYcqAJnpijZ8Md
         A621DvjpOoSwflm86J64Xyf4KmKokqpUMZI6W6jdXKr1u+HVGZRFdD/fB7xTErCRt7jK
         A37pG+YZE1BXZAy9eekHnW615s8OooZvX5EDAfRol6aYIIN2bAiWYsihkZsm+z24sIG4
         v0gmF6mI7a9Gbp8jVil7dxPptI3pD3Zq/PA0uxdYoDcTUtUGFREfx1CwqsR1JmU4UHXQ
         U+dF3oh1EwNnTSvQHgzxUcNo6GDApYDfFPSP6slS+eM7i/pm5Ic8N+rx9spUrDk6IgyD
         CwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FP20pGgu3D25STEzu2nQYXaFb5vqYhGB0+bCEyu/01c=;
        b=fM0R1z3Lexd3LrpGH+NwPx4xCXLoM0I9y6GtT7LNdePle96aY22teKl7d6oKFY16t1
         Jc4rb6BLQgMohcLYfygiwcZg4azcoalGgLP4uPpFR7s9kQN2XNfu64BIrTorXNb3p+Su
         WqhEMCo6RPzlXzlWLwk2e0JWmkdTVM0jiRKLNd/5XVOteeY6GIzx/kPPIPrapLM/880n
         93TjSoDZHeAFN9RoHRU0WjapWYLnPa+68+z3rUYK8F5w3yxri65jV5o07RJ8rVFvwaZ4
         u404dlg6cjin59EwCGNr7ZfSpLd81hapRGDFGmK36cADvM2xuloqUQv7i7g9TjBSIAVP
         zj9Q==
X-Gm-Message-State: AGRZ1gI06VQSdAbG2hju6LSIgIUoLSwqmAiiVMkAcVKvcQuIXOtMUrnN
        +rIbs2ps0rkH+zDUTHCxRrZmDy+TGy8=
X-Google-Smtp-Source: AJdET5e5qoQ78c4XRE++wjjCVpwHhn/mPb9lZZ0wuqZyKF+2x6JpXAhJf1maq5opljmN1PeOLEzvZw==
X-Received: by 2002:aed:2407:: with SMTP id r7mr6192162qtc.128.1541708170618;
        Thu, 08 Nov 2018 12:16:10 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c091:200::4:4cb1])
        by smtp.gmail.com with ESMTPSA id k38sm3399381qkh.72.2018.11.08.12.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 12:16:09 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] cgroup: implement __cgroup_task_count() helper
Date:   Thu,  8 Nov 2018 15:15:57 -0500
Message-Id: <20181108201600.9129-3-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181108201600.9129-1-guro@fb.com>
References: <20181108201600.9129-1-guro@fb.com>
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

