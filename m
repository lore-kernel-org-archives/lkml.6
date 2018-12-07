Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13547C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EEF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv1dU8CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EEF2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeLGUQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:16:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39598 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeLGUPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:15:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so2177768pgl.6;
        Fri, 07 Dec 2018 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CXMv0Vhrfz8OgUyxnyaG6yJ3Btg8UiW/JMvPPUaP47g=;
        b=iv1dU8CL7eCxkwjdGBFS0mbtxk6GU8XmzSL0nJFOoIS3VrhbCDGf0tP7iWGdFyLajD
         aplvV93AwOr0eNpnVx2zfFszUcI9KJzC3oAbVs0+ahZvCFNKy+zAlp8pkxa97NR92hMK
         pjgD1Fm33eANuoVbsiu7oh7dI0OarvO/14v6gXDwWqljuOHakvlaZDRSXOua3/s8mujq
         IaDC3x/5XRCDmnhvPaBJZHXh66MAnAM5vF+v0MytJfiEbYunsILafsGbXfnynRIPXzwN
         ysUrfKuhMeXogcAMnw5sPNpw2f175HdVKRuW7TFFgHtHiu2p3QYsNPAaktOHWdQM1i84
         5GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CXMv0Vhrfz8OgUyxnyaG6yJ3Btg8UiW/JMvPPUaP47g=;
        b=btQDsWd1JULN3iU0ESvmHHk6iOnZrTZ8J3thpnMEuPkA+IkDn8dGiBtt11oULNrqF/
         ShBjYBcF2XbX7tcXMRdl4o1Avp1jKr2Aqe4YlUZOnNJAdz5PhM4Ks2ptCcmWRRkFWfvb
         j9Xixqu4cEsSMHXP3NRveHgWMSraLvpzV+dghjG08oSIIAlE6nT9TYiwEMa4daANciRv
         qQZmwKEq7rt1iFZh15ZQjTDkWACRPe07lSWfPaaM4X2awZISID9A9nn67ixEI7sE7yom
         08KugbYhf2yPHK7wxre9yrX7/+wmlX/xZmQeGdVHO3IAzlSimmSdK5GamRYaXTa0rh+J
         1EDQ==
X-Gm-Message-State: AA+aEWZwjJ5hszgatFjOZsvddGYxSjLbxS1VupJ/pQWtBUi2INdVtuGD
        VuYZM/CL7Q0A3A9WjVtOB58=
X-Google-Smtp-Source: AFSGD/Xzu9bkbeks40O2SGCZiYVYF2PqYn8T+cGanFzGlm74lZiHOkKF33gcr0CIj/VOO2BVdD5/xQ==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr3660164pfv.216.1544213736978;
        Fri, 07 Dec 2018 12:15:36 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c090:200::6:d83b])
        by smtp.gmail.com with ESMTPSA id q75sm5870898pfa.38.2018.12.07.12.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 12:15:36 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v5 2/7] cgroup: implement __cgroup_task_count() helper
Date:   Fri,  7 Dec 2018 12:15:26 -0800
Message-Id: <20181207201531.1665-3-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181207201531.1665-1-guro@fb.com>
References: <20181207201531.1665-1-guro@fb.com>
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

