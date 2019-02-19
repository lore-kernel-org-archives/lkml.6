Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C550C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155522147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/5TaA/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfBSWDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:03:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44247 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbfBSWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:03:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id y1so10750942pgk.11;
        Tue, 19 Feb 2019 14:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJ4P00vx6U5PVt2qTIPEjoDmQITn36JjYHqlVjlSqjo=;
        b=d/5TaA/K17ynBMaopcn3ZXeD/EuvctR/PrwWdbrG8MGBCzdztK/qOOdj0yHK/r1M9I
         XCfIgI1JX0fCkAPqI2VBCRGyKPP7QrnzZqBEgNGCwCUjJueBnTkl+DUxYAGgI1qMV02R
         xVNAO2i2REPTrWj7OwcqlZSi1DLRyYlvMn+aSjKlWfSJeL/UQwPWzKorDW9IJ7IiEA2F
         GTTd5BO9K+C9X56WlkJWo01FWmDPwnO2ibe9YGIm6LTVDPFenrR8LcYCVa47UtTusLPI
         APmVN2YkyFqU/PdsZI9mGX2zp/L/VpCRf0F+jT5W0NuM4hx7YH/yXbDfJSMIz/8p4JaR
         MjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJ4P00vx6U5PVt2qTIPEjoDmQITn36JjYHqlVjlSqjo=;
        b=P36OE0Z2MvjclrTIFDeevRsdHp4SIW/5SOIdve1E3ZtysZS5sNVIMtvtZZXXNZv4FR
         0HRx7cCVqunNMsWlHhj1nUCQLQCL3yE8ip4UieJGq7i71Hv7J1umS2w6QTHumh/e9HlX
         9WCwwJ2Q1NpPHSeKzJLGxyeYzAPesqzLu0gqAAXOF1zPOcjFgAXDXGeh+QQokTZ/nEfC
         RHYxIh3pxKtkOVBSYy5930yTFGQYQ2EACsROm0dYW+dfcDmiGCuq3cS4u0VNUzjzr9re
         2qT1PZdiv7rcl1KG4cOzYHV8rM91rhvkdYG7pkU6AWSG8zgZUaQXijo82V6GklfmGyM1
         7f/A==
X-Gm-Message-State: AHQUAuZ059WjSHkV2iie65ALPkxPEQVcTb4CuzaeT/XLQrxEFS1pOxxv
        fQRJ6Y2TwYdY5HAmSQAW0k7hDy7Jh1s=
X-Google-Smtp-Source: AHgI3IbrQpGBZMSJUC+QbMTYwiR0Hu+Lh8QCjEXQfIQEkIZ78Fr3P2lGzgrnA7JEkjQpBL0GCDvyig==
X-Received: by 2002:a62:3a89:: with SMTP id v9mr31467640pfj.26.1550613783653;
        Tue, 19 Feb 2019 14:03:03 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:161b])
        by smtp.gmail.com with ESMTPSA id e6sm33539779pfe.59.2019.02.19.14.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:03:02 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v8 2/7] cgroup: implement __cgroup_task_count() helper
Date:   Tue, 19 Feb 2019 14:02:47 -0800
Message-Id: <20190219220252.4906-3-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219220252.4906-1-guro@fb.com>
References: <20190219220252.4906-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 583b969b0c0e..29c0ca8f76cf 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -339,22 +339,6 @@ static struct cgroup_pidlist *cgroup_pidlist_find_create(struct cgroup *cgrp,
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
index f4418371c83b..b230afccf635 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -592,6 +592,39 @@ static void cgroup_get_live(struct cgroup *cgrp)
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
2.20.1

