Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4D0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8F6218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5aiYxBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfAXVPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:15:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39095 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfAXVPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:15:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so3636976pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yle1TlNGJaGEEnORF+DKn94y7Tdky3DBMIMdCA8cBkQ=;
        b=G5aiYxByVc6VsErIA8+F4qk2siELUvTdPPrbChQIOsAm83h4aweDW1EtGssVAsYcqr
         d0Hbfi1U48XHWNKKSg6xfBhvQrj7g8/hZUrKv+aKhCRjAxjIsEjMdq9EtxxcRfVJu90f
         BX6molsDxFs4E2ZxSEKUqzNfPjR4gcB67U8DPKVZujIWJXG+/xQti5Q/HhQ39OkRPKta
         4qHw9QqImaawmIin18WKnJassSVIia4mg97ND/pwSl+bQs6LEJIkMU8ykdXNaM3OntUy
         4wCAEHFwa73hdoSX8Xisl4JJso5mKIZzv+rz5PzXQafcVRCiPugAP22E9Ys7jJVMBrL2
         ulKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yle1TlNGJaGEEnORF+DKn94y7Tdky3DBMIMdCA8cBkQ=;
        b=FIru7ycXAW5cQiqNApQ7w8dlsgDuEcbtaXKFRGh85qgq5DcBa8MlILQwKqJlzNX/J6
         JJuSVZv8trYaepRMJW2ZKFVx6ZJ5XVrTKifkpHVej3RY4y6hfIfDTvmvHIHhE4eJhHDK
         VBDnxF1HMy1qK4C5VjQa9M+3/TB6yZbOFH7JDvd6pQ+JUthgzL2NCJjT3tnxtwBnNshJ
         ijJoFHgYu3e3uG0kObbB6gQ/xbYI0uZ9SxLZRkbBKlO6oOl3Bqs4zr8EFnNVRt+XpG4X
         bigrIoRbb0ylsZis8JUDUY0ajJ64elGCtkzcgR4j5T7VnBMiMogPIjO+CN8cR6KN07Xz
         /B0A==
X-Gm-Message-State: AJcUuke4TO6T8QQz9tpZW1PQsboD3zypk1WT5FDJa3CZgu800oGCAzN7
        y/nbc9pTMonXfamg89P5SS4JlQ==
X-Google-Smtp-Source: ALg8bN7c9mCecQ7dN9e6nW340zvc5kgy4jrTniqrJWOGIuXa6rjmzTyuutcXsHTaWk10Kf/c9uFy0w==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr7480273pgk.147.1548364548221;
        Thu, 24 Jan 2019 13:15:48 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id j197sm29626418pgc.76.2019.01.24.13.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:15:47 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 3/5] psi: introduce state_mask to represent stalled psi states
Date:   Thu, 24 Jan 2019 13:15:16 -0800
Message-Id: <20190124211518.244221-4-surenb@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190124211518.244221-1-surenb@google.com>
References: <20190124211518.244221-1-surenb@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The psi monitoring patches will need to determine the same states as
record_times(). To avoid calculating them twice, maintain a state mask
that can be consulted cheaply. Do this in a separate patch to keep the
churn in the main feature patch at a minimum.
This adds 4-byte state_mask member into psi_group_cpu struct which
results in its first cacheline-aligned part to become 52 bytes long.
Add explicit values to enumeration element counters that affect
psi_group_cpu struct size.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/psi_types.h |  9 ++++++---
 kernel/sched/psi.c        | 29 +++++++++++++++++++----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 2cf422db5d18..762c6bb16f3c 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -11,7 +11,7 @@ enum psi_task_count {
 	NR_IOWAIT,
 	NR_MEMSTALL,
 	NR_RUNNING,
-	NR_PSI_TASK_COUNTS,
+	NR_PSI_TASK_COUNTS = 3,
 };
 
 /* Task state bitmasks */
@@ -24,7 +24,7 @@ enum psi_res {
 	PSI_IO,
 	PSI_MEM,
 	PSI_CPU,
-	NR_PSI_RESOURCES,
+	NR_PSI_RESOURCES = 3,
 };
 
 /*
@@ -41,7 +41,7 @@ enum psi_states {
 	PSI_CPU_SOME,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES,
+	NR_PSI_STATES = 6,
 };
 
 struct psi_group_cpu {
@@ -53,6 +53,9 @@ struct psi_group_cpu {
 	/* States of the tasks belonging to this group */
 	unsigned int tasks[NR_PSI_TASK_COUNTS];
 
+	/* Aggregate pressure state derived from the tasks */
+	u32 state_mask;
+
 	/* Period time sampling buckets for each state of interest (ns) */
 	u32 times[NR_PSI_STATES];
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index fe24de3fbc93..2262d920295f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -212,17 +212,17 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 static void get_recent_times(struct psi_group *group, int cpu, u32 *times)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
-	unsigned int tasks[NR_PSI_TASK_COUNTS];
 	u64 now, state_start;
+	enum psi_states s;
 	unsigned int seq;
-	int s;
+	u32 state_mask;
 
 	/* Snapshot a coherent view of the CPU state */
 	do {
 		seq = read_seqcount_begin(&groupc->seq);
 		now = cpu_clock(cpu);
 		memcpy(times, groupc->times, sizeof(groupc->times));
-		memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
+		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
 	} while (read_seqcount_retry(&groupc->seq, seq));
 
@@ -238,7 +238,7 @@ static void get_recent_times(struct psi_group *group, int cpu, u32 *times)
 		 * (u32) and our reported pressure close to what's
 		 * actually happening.
 		 */
-		if (test_state(tasks, s))
+		if (state_mask & (1 << s))
 			times[s] += now - state_start;
 
 		delta = times[s] - groupc->times_prev[s];
@@ -406,15 +406,15 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 	delta = now - groupc->state_start;
 	groupc->state_start = now;
 
-	if (test_state(groupc->tasks, PSI_IO_SOME)) {
+	if (groupc->state_mask & (1 << PSI_IO_SOME)) {
 		groupc->times[PSI_IO_SOME] += delta;
-		if (test_state(groupc->tasks, PSI_IO_FULL))
+		if (groupc->state_mask & (1 << PSI_IO_FULL))
 			groupc->times[PSI_IO_FULL] += delta;
 	}
 
-	if (test_state(groupc->tasks, PSI_MEM_SOME)) {
+	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
 		groupc->times[PSI_MEM_SOME] += delta;
-		if (test_state(groupc->tasks, PSI_MEM_FULL))
+		if (groupc->state_mask & (1 << PSI_MEM_FULL))
 			groupc->times[PSI_MEM_FULL] += delta;
 		else if (memstall_tick) {
 			u32 sample;
@@ -435,10 +435,10 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		}
 	}
 
-	if (test_state(groupc->tasks, PSI_CPU_SOME))
+	if (groupc->state_mask & (1 << PSI_CPU_SOME))
 		groupc->times[PSI_CPU_SOME] += delta;
 
-	if (test_state(groupc->tasks, PSI_NONIDLE))
+	if (groupc->state_mask & (1 << PSI_NONIDLE))
 		groupc->times[PSI_NONIDLE] += delta;
 }
 
@@ -447,6 +447,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
+	enum psi_states s;
+	u32 state_mask = 0;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
@@ -479,6 +481,13 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (set & (1 << t))
 			groupc->tasks[t]++;
 
+	/* Calculate state mask representing active states */
+	for (s = 0; s < NR_PSI_STATES; s++) {
+		if (test_state(groupc->tasks, s))
+			state_mask |= (1 << s);
+	}
+	groupc->state_mask = state_mask;
+
 	write_seqcount_end(&groupc->seq);
 
 	if (!delayed_work_pending(&group->clock_work))
-- 
2.20.1.321.g9e740568ce-goog

