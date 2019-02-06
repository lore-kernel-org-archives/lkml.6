Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57562C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1817220821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UA97yBlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfBFQOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:14:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53200 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbfBFQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:14:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so3078598wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OoOAAHwh4rgzNRFqB1rNv+feFdv+xbxO5pzW9hXMxGY=;
        b=UA97yBlhEMO6p0CFDPJbGtTUF9DPES/4crLzXlVCfUiK4I033eSHkf9uU8bUWg/uKr
         ccOgS6z9cMXnYDVLYuhnn8n4sgLaKtJQW0FVv07IMev3iJY2ELBlt3f1NLR1zYh0NMIH
         DPjUJ/HBbVu+APkiLLvtF43MVpkrinpzFYDhfZAwRTNkydCAjwb4nI8y7T9CVh1dKASm
         tnyZuAtNszD37zgG3vaMyzWBfk5TYVoLVOOr7xrGLmqMEr+iLz39gbUyzxWzChjaDeC/
         2/gs1ndRfGCj2snA5LT3CXbABLf77uMkxD1VvQMVUsC5vxasKMpbk7MIW0QXq0ewbXCc
         ajHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OoOAAHwh4rgzNRFqB1rNv+feFdv+xbxO5pzW9hXMxGY=;
        b=uPYrsvppdEp/QKpCl+RMJgfKo2TNsxL15I90tPaZsYF+w3EkSjPkURv5wvZjLOBeoi
         qJptOzas551Gx97MR+USxXBabG54NlMCE8lCIRJQOY5JxbJHKIGnU7bCcMg1r+HhEA1e
         W56oNIT9y6KXzBII/Nix/Hlws5cKB42Sf2ySiPYMz15jLUN9ABEHs0wz8FjTh95uuQNb
         sXAjQdyctuKBn6ZX++/pS/Kd+LJFgRUAfMWgsc9vr6iqf0Vbo1y4ujwNVF/uCs8P5xi3
         OxoKlYLJtOFuaFr6Rm6AiwunFB8NKB1MR1lqMTijapaC9yxcxkkm0IxvvmsEkhmqEad7
         QYfg==
X-Gm-Message-State: AHQUAuaD+afYe9L8DhOmu9mFQpuzCRcoBsq1U12gZr7/rU6tG0heShE0
        h1Sd444Tb543KyzAVciDgWK2AwD5p8k=
X-Google-Smtp-Source: AHgI3IY4MHznUNBn+npjpm+I8SYTmBtfklwXq+mj/b01reVkox0RIJ0EVvYuX+tgAndqSbq1p/a82Q==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr2073856wmj.10.1549469671295;
        Wed, 06 Feb 2019 08:14:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e4a1:3fb3:af18:c98a])
        by smtp.gmail.com with ESMTPSA id y20sm27492328wra.51.2019.02.06.08.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 08:14:30 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     tj@kernel.org, sargun@sargun.me, xiexiuqi@huawei.com,
        xiezhipeng1@huawei.com, torvalds@linux-foundation.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] sched/fair: Fix O(nr_cgroups) in load balance path
Date:   Wed,  6 Feb 2019 17:14:22 +0100
Message-Id: <1549469662-13614-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts:
  commit c40f7d74c741 ("sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")

Now that cfs_rq can be safely removed/added in the list, we can re-apply
 commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index badf8173..c6167bb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -368,9 +368,10 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
 }
 
-/* Iterate through all cfs_rq's on a runqueue in bottom-up order */
-#define for_each_leaf_cfs_rq(rq, cfs_rq) \
-	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
+/* Iterate thr' all leaf cfs_rq's on a runqueue */
+#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
+	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
+				 leaf_cfs_rq_list)
 
 /* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
@@ -461,8 +462,8 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 {
 }
 
-#define for_each_leaf_cfs_rq(rq, cfs_rq)	\
-		for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
+#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
+		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
 
 static inline struct sched_entity *parent_entity(struct sched_entity *se)
 {
@@ -7699,10 +7700,27 @@ static inline bool others_have_blocked(struct rq *rq)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
+static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+{
+	if (cfs_rq->load.weight)
+		return false;
+
+	if (cfs_rq->avg.load_sum)
+		return false;
+
+	if (cfs_rq->avg.util_sum)
+		return false;
+
+	if (cfs_rq->avg.runnable_load_sum)
+		return false;
+
+	return true;
+}
+
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq, *pos;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
@@ -7714,7 +7732,7 @@ static void update_blocked_averages(int cpu)
 	 * Iterates the task_group tree in a bottom up fashion, see
 	 * list_add_leaf_cfs_rq() for details.
 	 */
-	for_each_leaf_cfs_rq(rq, cfs_rq) {
+	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
 		struct sched_entity *se;
 
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
@@ -7725,6 +7743,13 @@ static void update_blocked_averages(int cpu)
 		if (se && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, 0);
 
+		/*
+		 * There can be a lot of idle CPU cgroups.  Don't let fully
+		 * decayed cfs_rqs linger on the list.
+		 */
+		if (cfs_rq_is_decayed(cfs_rq))
+			list_del_leaf_cfs_rq(cfs_rq);
+
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
@@ -10606,10 +10631,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_SCHED_DEBUG
 void print_cfs_stats(struct seq_file *m, int cpu)
 {
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq, *pos;
 
 	rcu_read_lock();
-	for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
+	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
 		print_cfs_rq(m, cpu, cfs_rq);
 	rcu_read_unlock();
 }
-- 
2.7.4

