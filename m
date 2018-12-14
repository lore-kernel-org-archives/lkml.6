Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BE2C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3395D2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akXIWndi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbeLNRQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:16:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37479 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbeLNRQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:16:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so3021390plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwSYAI43KM10GrnM4hZ3Qtd3y6BkTcR7ZHO9M+skX2s=;
        b=akXIWndiUHaos9TbyNLP3xeaC0ZtOOtr3cSf/ilsoUM7WywehoLoqyXEZzuFIORB9M
         OvxzyeHc32Q4lx447L/4jMQROuD8Tpifnb+eTjanco+ff7o+IwZScCVw5XFu71NXZHQx
         h65SJNlG1uCZ+LcxQFWTzPj27rLKDsz7X5nBwYOPjf33icL9nUeUcN8H4DxeA2dJ2CoJ
         u04GoPkgs3B2NaoDOzsMLnvT61RyHEVW0r29CnBfMfhJUd+xuXxPuur/lVVYkfCIPun7
         /axdZ+sXYAdccL5hZ+AL8HqqFeX7QG3R9jGqHbyBu5W6pW9dZ01ISpGwMqGQkIolMen/
         1COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwSYAI43KM10GrnM4hZ3Qtd3y6BkTcR7ZHO9M+skX2s=;
        b=XCCb6+DKaZG3r4usBIIWBVc88tcpt6hAI1TZ/LpZGKCVy6zoclWuLo/4O4KVDeE61f
         4n36AvHFgfeI4gtWuLebRH8zTTyK2Mao9yXDLv4KdCx/RjN+JJhdQpjfQpEspfosnb7/
         LXg0midSKnI9KGJaoaim3EiiQKGCeQCGfKLEkUZljiS+h2VNqyaoj0yO8Q32bFvs1+Dm
         LKuvYH9mcSi8q97crInyV7UZdTyrag4Tj0QcRYK3Of/Uvc6vYnIZNBHpnE2U19sOh6uP
         rsIg8XtrU8uM5rrp+2bVPcCwJcQDrD6goo5ePawv68pr407LOxl3/uMqgUoeXFYb25n9
         R+bg==
X-Gm-Message-State: AA+aEWZiDS97PCIg138I+RJnU/TiNDbISrG7Se9odIQm1C+ok8/NZHxX
        bETQ7TrvwSDC3rOWyS/LpOMGTg==
X-Google-Smtp-Source: AFSGD/UnqpC986vJpvC7OunDuj94mE83rlw4ebocm39rs/p+lo9QYqHHDyqOGddBMnR+LPZQxbTwJQ==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr3653918plr.128.1544807783288;
        Fri, 14 Dec 2018 09:16:23 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id g185sm7605761pfc.174.2018.12.14.09.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:16:21 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 4/6] psi: introduce state_mask to represent stalled psi states
Date:   Fri, 14 Dec 2018 09:15:06 -0800
Message-Id: <20181214171508.7791-5-surenb@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
In-Reply-To: <20181214171508.7791-1-surenb@google.com>
References: <20181214171508.7791-1-surenb@google.com>
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

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/psi_types.h |  3 +++
 kernel/sched/psi.c        | 29 +++++++++++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 2cf422db5d18..2c6e9b67b7eb 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -53,6 +53,9 @@ struct psi_group_cpu {
 	/* States of the tasks belonging to this group */
 	unsigned int tasks[NR_PSI_TASK_COUNTS];
 
+	/* Aggregate pressure state derived from the tasks */
+	u32 state_mask;
+
 	/* Period time sampling buckets for each state of interest (ns) */
 	u32 times[NR_PSI_STATES];
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index d2b9c9a1a62f..153c0624976b 100644
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
@@ -390,15 +390,15 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
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
@@ -419,10 +419,10 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		}
 	}
 
-	if (test_state(groupc->tasks, PSI_CPU_SOME))
+	if (groupc->state_mask & (1 << PSI_CPU_SOME))
 		groupc->times[PSI_CPU_SOME] += delta;
 
-	if (test_state(groupc->tasks, PSI_NONIDLE))
+	if (groupc->state_mask & (1 << PSI_NONIDLE))
 		groupc->times[PSI_NONIDLE] += delta;
 }
 
@@ -431,6 +431,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
+	enum psi_states s;
+	u32 state_mask = 0;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
@@ -463,6 +465,13 @@ static void psi_group_change(struct psi_group *group, int cpu,
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
 }
 
-- 
2.20.0.405.gbc1bbc6f85-goog

