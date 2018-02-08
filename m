Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753799AbeBKVXJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:23:09 -0500
Received: from mout.web.de ([212.227.15.4]:40587 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753669AbeBKVXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:23:07 -0500
From: Mario Leinweber <marioleinweber@web.de>
To: mingo@redhat.com
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
        Mario Leinweber <marioleinweber@web.de>
Subject: [PATCH] kernel/sched/cpudeadline: Fixed code style errors and warnings
Date: Wed,  7 Feb 2018 21:53:59 -0500
Message-Id: <20180208025359.17695-1-marioleinweber@web.de>
X-Mailer: git-send-email 2.14.3
Signed-off-by: Mario Leinweber <marioleinweber@web.de>
X-Provags-ID: V03:K0:M1cC5GhEth+mLRzdEKxm9D0sXaKLfdNGbT8KRUhYdfIL9J5NNlo
 /vDoXu3qbegIgwfrCwbDngGyUiv1qKttPom0K5vQyCX6u3rBMVIgjb8AHjEbo8MNLyjHVJS
 9riQ+ZFilRYEM2Lt82rrLk3Iy0Mot/pNaaAjLSCQll6kYGzZ6y3QjCTzFnGazwd4dwHi95P
 KG2cbYAphGJk4DVfAFzUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ArP4WUH3bx4=:bNm8+EEFOjytnvlFy9NldN
 ZAXufgLVHn0DOFFghRNGI1uLxKMyweUmPhzR6fLxg3780Cvemie8zC+ydSgOR7T0T7U1VErtg
 aKMqNlUsD+m5Iz4av/wG9XSOFItmFRD3+bHElYxzGDvQk+nUlspLiwTTU1TZzONCM4N953jVP
 teTv8f6hFokF3QDftFhgrj3vb2uWVDJh21DbMy3PE5qUq0U79PvlHzCgAwr3v1xXe7Sa8HyGg
 D3odJUfyNGedT8vKuUJZaSvQun612EYF5i72yKGpYNBM6AzpNRkaHxViBSJLzAsatf5VuTlgp
 VsluC4Q+LT4chUQGxQ7bEqWTkNO27Rakls3Tu9SbHpOkPyXX2fXHkOin4gCDKlWRw5GX+8kGw
 S3h5t3p0Pd+Y6L6bh7lqa61UyJuCzWHClazGz8W/UgSnJCTvs6uPHS6P2MLwlY+8wti3SwscG
 uhSsImM3xHFoBDO3R176REe+gruXQIRy3fDMKFyFDysLzrWdMPyjfSNh5wHppj9nrfYRxe59z
 H/oM9KOYe79bfcPN7HeK7leD1+urVqjySE3mGnzT2MAQR2yXln5AqZxivN7xzF2desGl5rMbw
 XPfvrc1aicSmOkxvLDMxAzW2An3RewD3ge2TdRzXMONHhR8EYtgsT9C/yAJyWyrO22w77xTng
 lsrjznR0F5LeOj6glHijZRt2YBfOXwhYJE+VDm/sCEfc9/uyVG4h5NHjnV9GboWmNEHXpPyqJ
 yh+pu/xM+vDvb2LDyAG8WN09JXHXO+eAiKOH5vFvMrcf1u/va6d43bmQ9dy4bf+mHqurGJJmj
 m+eqhitp9Sk3ML+NQ7FiWdM2lszBg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 8d9562d890d3..6a9defebbb54 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -42,8 +42,9 @@ static void cpudl_heapify_down(struct cpudl *cp, int idx)
 		return;
 
 	/* adapted from lib/prio_heap.c */
-	while(1) {
+	while (1) {
 		u64 largest_dl;
+
 		l = left_child(idx);
 		r = right_child(idx);
 		largest = idx;
@@ -131,6 +132,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 		return 1;
 	} else {
 		int best_cpu = cpudl_maximum(cp);
+
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
 		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
@@ -205,6 +207,7 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
 	old_idx = cp->elements[cpu].idx;
 	if (old_idx == IDX_INVALID) {
 		int new_idx = cp->size++;
+
 		cp->elements[new_idx].dl = dl;
 		cp->elements[new_idx].cpu = cpu;
 		cp->elements[cpu].idx = new_idx;
-- 
2.14.3
