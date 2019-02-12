Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18017C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC50C2190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPVYKujq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfBLSsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:48:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36668 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbfBLSsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:48:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so1719774pfa.3;
        Tue, 12 Feb 2019 10:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJ4P00vx6U5PVt2qTIPEjoDmQITn36JjYHqlVjlSqjo=;
        b=NPVYKujqbqkCnJ+/k5n2gFEhWdhGRypv1ZhfXWfzoePrOJ5Q4AEU7orqnq8EMiCmT/
         n2WsYiINElRTz6A5ID10ujUwmD7CMmmgcynpcjQoDX3uq0qv3iFnApmBJNt4imZkE95k
         b7zoUIs7TDZqL11a2iag/dts0feSX9VGhtGnpzFeQ34hbPBHw3gpP0hXKDjruxYqpdzq
         3sBtkfbkib4kRxqzcVqjf9q+7/NHIr39oUFxAdRrlO75cjcwuJicrCBeJFQC0nE0Ui4S
         47OEglFF1tpLxdvuwmxQNJH5Mg5bo8My9/m9tddl8FhrSUDiJ84G3GHKeCdD5aQcirG+
         HrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJ4P00vx6U5PVt2qTIPEjoDmQITn36JjYHqlVjlSqjo=;
        b=t+cHBDy3Xao0o9gIWHZG7AuvDPtBbHWaITCEF0mA0p/hFXO6UMYpoC8+F++/6ip7ha
         BMxJvzIC93I2IuHJbbf0vsBLRiuVcuJS+BZmrKxjo2IGG7smv13lRTszl5+xe8bbemvp
         nMLmMHaiR4PmhvAMh4vwitAq1gnapKZnZhVPlKIN0kSOHsyeVFZHEuZycDFdoSD9K9Js
         TrZWfPSma4d0DgXxoPxOwRai1UDdr+R93dDVFdckYCBiB/l+SVcXSM2xvRvtIqjLir4h
         8MNqv4JVDjHhQ3bB2kmUcUbHtJBwZIiaKU9GQmAFwHFa3J+5DEAK9cyiGgLy0ApwO5/F
         tjHQ==
X-Gm-Message-State: AHQUAuZ5X3w9DN3hj7qYrk4mHGbtfp1NOiehsQF4ZqKvHurZm5lXi/+E
        B+cLktVb7k77gOA0MNswz/0=
X-Google-Smtp-Source: AHgI3IauRCHpYKCgJBOLf1fzwrVfkFxyoTIg6adrnSX6YE0jPWpsp73OKxiaWgEMVJ5Szynk4Nnw4Q==
X-Received: by 2002:a63:4913:: with SMTP id w19mr4845104pga.394.1549997298727;
        Tue, 12 Feb 2019 10:48:18 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:4d62])
        by smtp.gmail.com with ESMTPSA id f67sm25480102pfc.141.2019.02.12.10.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:48:17 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v7 2/7] cgroup: implement __cgroup_task_count() helper
Date:   Tue, 12 Feb 2019 10:48:02 -0800
Message-Id: <20190212184807.20304-3-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212184807.20304-1-guro@fb.com>
References: <20190212184807.20304-1-guro@fb.com>
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

