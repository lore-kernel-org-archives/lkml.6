Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947160AbeCBSVN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:21:13 -0500
Received: from mout.web.de ([217.72.192.78]:60683 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423207AbeCBSVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:21:11 -0500
From: Mario Leinweber <marioleinweber@web.de>
To: mingo@redhat.com
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
        Mario Leinweber <marioleinweber@web.de>
Subject: [PATCH] kernel/sched/cpudeadline.c: Fixed coding style error and warnings.
Date: Fri,  2 Mar 2018 13:20:07 -0500
Message-Id: <20180302182007.28691-1-marioleinweber@web.de>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:PUawGF3YjR2PKWpbJyFpQKHI0OXwnOe7EKwyZQ4musAxpJpccyN
 68DlWmNIgRB44UOhkvfN/vjbE8jXmQZ2ckzBGXHhACc5li+od0lnk6nfryTJHV92RJnf1Ba
 tT46UIOXXr8HL89Rm48xh9bEZo795eAzxVE8VLXS5QlaGv3YKCiYX4/P2TDy5fOXukf7DMb
 0Xib1oyX4AcXAiPnTdSCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7njO842jy+M=:eh/1MX/qEJnpAWnw6iflsM
 OVHTiql4mmczdMMfXNYuNzx1OA5OMXaqTuMjrVURTUhhP0raH3xcTGVR+yRw+Lw6NoHejbcO8
 exlZlLdZKXHVS1aTiiChUMe+PUOMkEiJabyqLiMyUTMvt6uDsf+nLXzQykPyJG+VmsHVXuDIr
 EQNv+u+gBBpn5rDaVTvE+EQRWp1XX5EGv5uXVLOASSvrUnZvXfUFyGDiVrGkRB8JLSUPKOZRT
 PgNznau7jiyezzJbE7P0xni1eBOj2uqjYd7XL4bTCNYSbxt9O1fi9vE0uoswJi/LNKqeuUXqB
 3k/Bxp0MrAnrkVeEAhpcOk8mnZc2enLRJM14daPd7TPr9/edxmKQd2/sVIZ/msq0Ck5uuo+z0
 4JTdzVqGTtC7hghNlNgtMg9Fcr0H+d7wESYxTfMcvOE18MPQpsHdVcWytysAASyCzbQ6vl/DC
 16vkrD655pkJeDBWPaiocv9IJBvF5TtUJqo/1x/mNVeWHnmCFy60aNu0uMoD7jW+7tVlu9WS6
 ecpjft+XRtyvRBqzYAQqjzgRPvSM+ptVbgZzH6jl3xmJkEfEXBQNhJIu9here48gEWCV1faNV
 S19xJnOH8c8K6ou85WVHG1v6BX1i5KwUhR67QccMl9ZSO2ph9OM+H7qzdxYMUsqNjmIVww7OV
 /6MaEBhNPhpdO3MIVW2OGmKW8ugUv+4yhlB04aY7ApNhwVLmRThW18em5y13b/dt6+G0MxXbH
 5uk/BsSZE0FNtdxy3elCuBgDTj1JWJtHipvdjrCs1qakUVnTwiHbOhnw6qX3HkNC1C6bWQytp
 vZcJeyMRxs1/Lk3WV/GhAVsqWSgFg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fixed style error: Missing space before the open parenthesis
- Fixed style warnings: 2x Missing blank line after declaration

One warning left: else after return
 (I don't feel comfortable fixing that without side effects)

Signed-off-by: Mario Leinweber <marioleinweber@web.de>
---
 kernel/sched/cpudeadline.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
