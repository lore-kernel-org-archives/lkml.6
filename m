Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53105C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216CC206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdbSosqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbeLNRQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:16:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35538 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbeLNRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:16:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so3025072plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1K/9jxBUhr3ZKbGV/xGf2bm9+2dhfv3m9ZmKXLf2XLM=;
        b=fdbSosqkmOy+GOJSWJ6aOnhR9OK/6rV7BapjvJttxkHBRPlyq0NYeMod4uZFvdSdmT
         YuqAwToioC5aXk49M7de1ONOHk9gEsqA7b40kGqvGCau9bMzwLC+BfUXeXcvoRoXY/6z
         hgN9QIykNobCdulmez5DFg6uIyyRfq7Fv1vwvgOPGumapbEOiO4sslYg8YcjTvKfeWK+
         Q14G6m3ZKlkUIUwWpyj24NjsPl7ZP6FsYoj8aqWhtBb9nh7IrV5WHsNgYb40G4jcArqC
         8EpvQKL679AjqTo4JLW8cTKtzZMHTArygO9acydjH0zI5ExKr4x7CG85JKpbMTXGdASU
         5w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1K/9jxBUhr3ZKbGV/xGf2bm9+2dhfv3m9ZmKXLf2XLM=;
        b=tjggOgKK/XM8tW7ZHpoejofQdDcXNaAa7xRAbPR9mRUWvZi1t/ryCXY5vNQm6rnGcZ
         D46QG3pNHC5YZ7MEM8MpbJHwJAb/Li0bQ5hyHiV4jE5szuTWnSrwVhzVf4kv6clgkZr1
         6ZfulCcSDl9cSHjHYJnygNrvZ2e+lqk3+0Z6RkTMObW4xj3rthGRK6rS2Ich2PQ/G9Pe
         11JzPFWwzMV0Cq2Olaz+KscVpB6mkrOXGzOeR6aHmmIfWxwPCYiICS9F76iQ2/ENTQ2t
         idTaFKo5D6yHoK4rQZqlGmKSCUeByPA0+PyCePKImYKqK/JR6vriBJp8i4rtNlqsSxeN
         xY/g==
X-Gm-Message-State: AA+aEWZ2Brd0UFKRdFD1X5rdtA+TciJoaDje6zJwtX+smNZFzKxmg7W+
        7RqIzcUXashbHad+wTgfUMSKjA==
X-Google-Smtp-Source: AFSGD/UAxdLH6HoIs+mnW869kAVAqSMJdTBnZfNTiYAZJdKFhswZe4dHVAjkbuZrTEVtGTcbSwoN2Q==
X-Received: by 2002:a17:902:4c85:: with SMTP id b5mr3446926ple.226.1544807787259;
        Fri, 14 Dec 2018 09:16:27 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id g185sm7605761pfc.174.2018.12.14.09.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:16:24 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 5/6] psi: rename psi fields in preparation for psi trigger addition
Date:   Fri, 14 Dec 2018 09:15:07 -0800
Message-Id: <20181214171508.7791-6-surenb@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
In-Reply-To: <20181214171508.7791-1-surenb@google.com>
References: <20181214171508.7791-1-surenb@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming psi_group structure member fields used for calculating psi
totals and averages for clear distinction between them and trigger-related
fields that will be added next.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/psi_types.h | 15 ++++++++-------
 kernel/sched/psi.c        | 26 ++++++++++++++------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 2c6e9b67b7eb..11b32b3395a2 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -69,20 +69,21 @@ struct psi_group_cpu {
 };
 
 struct psi_group {
-	/* Protects data updated during an aggregation */
-	struct mutex stat_lock;
+	/* Protects data used by the aggregator */
+	struct mutex update_lock;
 
 	/* Per-cpu task state & time tracking */
 	struct psi_group_cpu __percpu *pcpu;
 
-	/* Periodic aggregation state */
-	u64 total_prev[NR_PSI_STATES - 1];
-	u64 last_update;
-	u64 next_update;
 	struct delayed_work clock_work;
 
-	/* Total stall times and sampled pressure averages */
+	/* Total stall times observed */
 	u64 total[NR_PSI_STATES - 1];
+
+	/* Running pressure averages */
+	u64 avg_total[NR_PSI_STATES - 1];
+	u64 avg_last_update;
+	u64 avg_next_update;
 	unsigned long avg[NR_PSI_STATES - 1][3];
 };
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 153c0624976b..694edefdd333 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -172,9 +172,9 @@ static void group_init(struct psi_group *group)
 
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
-	group->next_update = sched_clock() + psi_period;
+	group->avg_next_update = sched_clock() + psi_period;
 	INIT_DELAYED_WORK(&group->clock_work, psi_update_work);
-	mutex_init(&group->stat_lock);
+	mutex_init(&group->update_lock);
 }
 
 void __init psi_init(void)
@@ -268,7 +268,7 @@ static void update_stats(struct psi_group *group)
 	int cpu;
 	int s;
 
-	mutex_lock(&group->stat_lock);
+	mutex_lock(&group->update_lock);
 
 	/*
 	 * Collect the per-cpu time buckets and average them into a
@@ -309,7 +309,7 @@ static void update_stats(struct psi_group *group)
 
 	/* avgX= */
 	now = sched_clock();
-	expires = group->next_update;
+	expires = group->avg_next_update;
 	if (now < expires)
 		goto out;
 
@@ -320,14 +320,14 @@ static void update_stats(struct psi_group *group)
 	 * But the deltas we sample out of the per-cpu buckets above
 	 * are based on the actual time elapsing between clock ticks.
 	 */
-	group->next_update = expires + psi_period;
-	period = now - group->last_update;
-	group->last_update = now;
+	group->avg_next_update = expires + psi_period;
+	period = now - group->avg_last_update;
+	group->avg_last_update = now;
 
 	for (s = 0; s < NR_PSI_STATES - 1; s++) {
 		u32 sample;
 
-		sample = group->total[s] - group->total_prev[s];
+		sample = group->total[s] - group->avg_total[s];
 		/*
 		 * Due to the lockless sampling of the time buckets,
 		 * recorded time deltas can slip into the next period,
@@ -347,11 +347,11 @@ static void update_stats(struct psi_group *group)
 		 */
 		if (sample > period)
 			sample = period;
-		group->total_prev[s] += sample;
+		group->avg_total[s] += sample;
 		calc_avgs(group->avg[s], sample, period);
 	}
 out:
-	mutex_unlock(&group->stat_lock);
+	mutex_unlock(&group->update_lock);
 }
 
 static void psi_update_work(struct work_struct *work)
@@ -375,8 +375,10 @@ static void psi_update_work(struct work_struct *work)
 	update_stats(group);
 
 	now = sched_clock();
-	if (group->next_update > now)
-		delay = nsecs_to_jiffies(group->next_update - now) + 1;
+	if (group->avg_next_update > now) {
+		delay = nsecs_to_jiffies(
+				group->avg_next_update - now) + 1;
+	}
 	schedule_delayed_work(dwork, delay);
 }
 
-- 
2.20.0.405.gbc1bbc6f85-goog

