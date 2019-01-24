Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0508C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0243218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8DyLoRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfAXVP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:15:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42119 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfAXVPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:15:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so3462128plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaB5hpMUbkzrw9imUPc3mrdBFq091uUG7T5XaC1Sbdc=;
        b=d8DyLoRK+ddHRiwPLKr4NnRhwUxe9KcJbasDwaBbAy08lwXJ2Dh3UpBvKD5gJhr1XD
         ygCYLowX1NgycoSyCV0KpdJc45ecKTSXqJfcWE5/daHnt2JEDTJYd3P71a2APZJi6gsE
         wCkCCxyQKfSz4OON3OoRJfMRnDMMH3ELo7NTxAL46p+Z/hNOIK73oT/U83YroGojCS0c
         bb4NcpNde6m5cW2n1LDqgbnUoUADyEbmlsEduYccLSa/Df/QPALxgXtvWSA/7TF8ATG7
         W6E0CrAv2zgQJ8S/utkFZ05JP/1BU0q/KVg7q0ekkSeXacE+QZeD/J9YFPgUCjAE+G05
         sUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaB5hpMUbkzrw9imUPc3mrdBFq091uUG7T5XaC1Sbdc=;
        b=QtVtj88kzrEj3G/Wfk9bLbHjc0gvgPPGyaVRPLES8GDS5dfvZllimgwh9TcTuc4t7n
         NTrJxog3xKTLM2ihebZCko5SFWQjIgPYzQ6XQOt0lMIEo3qfyMWNCLAdHb27tIMxZIah
         IgZe8wtGpNy9yB5hnDT3V0fTdQtxgKfRWxX4Ky/gvga6ljKOSaRl/6iEd7Tg3iBXeZBA
         LQYeifSUB/iT5ie5GMTofjyaUP4Lk8Mrj6wbkvups8W1zz53ScNclPeBfJWpYjfgJ1fd
         zlL3y6k3dyEbHT9hkvIPJqqZ+ehJSF12iB7pSJS5uXhZ1D7z22kqRtPu6MZbDoN9tisO
         lpng==
X-Gm-Message-State: AJcUukdnLrCdXNrjqV2RO09L1izQHnXV/T0R559mzixAHRtdhU0uPyVI
        6OcxAtl83PeSC0QiNhSiWQ74Sg==
X-Google-Smtp-Source: ALg8bN5ubkNevpGRpp/f5Y4ShhZRlBmfee1EWHPVxx4kMKUcbRjoIt6YzEkuktkm1W/PHnkThYik+g==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr7770481plq.278.1548364550496;
        Thu, 24 Jan 2019 13:15:50 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id j197sm29626418pgc.76.2019.01.24.13.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:15:49 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 4/5] psi: rename psi fields in preparation for psi trigger addition
Date:   Thu, 24 Jan 2019 13:15:17 -0800
Message-Id: <20190124211518.244221-5-surenb@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190124211518.244221-1-surenb@google.com>
References: <20190124211518.244221-1-surenb@google.com>
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
index 762c6bb16f3c..47757668bdcb 100644
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
index 2262d920295f..c366503ba135 100644
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
@@ -277,7 +277,7 @@ static bool update_stats(struct psi_group *group)
 	int cpu;
 	int s;
 
-	mutex_lock(&group->stat_lock);
+	mutex_lock(&group->update_lock);
 
 	/*
 	 * Collect the per-cpu time buckets and average them into a
@@ -318,7 +318,7 @@ static bool update_stats(struct psi_group *group)
 
 	/* avgX= */
 	now = sched_clock();
-	expires = group->next_update;
+	expires = group->avg_next_update;
 	if (now < expires)
 		goto out;
 	if (now - expires > psi_period)
@@ -331,14 +331,14 @@ static bool update_stats(struct psi_group *group)
 	 * But the deltas we sample out of the per-cpu buckets above
 	 * are based on the actual time elapsing between clock ticks.
 	 */
-	group->next_update = expires + ((1 + missed_periods) * psi_period);
-	period = now - (group->last_update + (missed_periods * psi_period));
-	group->last_update = now;
+	group->avg_next_update = expires + ((1 + missed_periods) * psi_period);
+	period = now - (group->avg_last_update + (missed_periods * psi_period));
+	group->avg_last_update = now;
 
 	for (s = 0; s < NR_PSI_STATES - 1; s++) {
 		u32 sample;
 
-		sample = group->total[s] - group->total_prev[s];
+		sample = group->total[s] - group->avg_total[s];
 		/*
 		 * Due to the lockless sampling of the time buckets,
 		 * recorded time deltas can slip into the next period,
@@ -358,11 +358,11 @@ static bool update_stats(struct psi_group *group)
 		 */
 		if (sample > period)
 			sample = period;
-		group->total_prev[s] += sample;
+		group->avg_total[s] += sample;
 		calc_avgs(group->avg[s], missed_periods, sample, period);
 	}
 out:
-	mutex_unlock(&group->stat_lock);
+	mutex_unlock(&group->update_lock);
 	return nonidle_total;
 }
 
@@ -390,8 +390,10 @@ static void psi_update_work(struct work_struct *work)
 		u64 now;
 
 		now = sched_clock();
-		if (group->next_update > now)
-			delay = nsecs_to_jiffies(group->next_update - now) + 1;
+		if (group->avg_next_update > now) {
+			delay = nsecs_to_jiffies(
+				group->avg_next_update - now) + 1;
+		}
 		schedule_delayed_work(dwork, delay);
 	}
 }
-- 
2.20.1.321.g9e740568ce-goog

