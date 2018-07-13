Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B261FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65380208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTyoY5ZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65380208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbeGMXYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:24:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33800 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbeGMXYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:24:19 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so12782905plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 16:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=T2+PUkWlQYmob3d7nbW9BJNgUCy5teUF4SQyur60lBY=;
        b=oTyoY5ZYXGItIy6cx+ht7YTXMM48yYu1RA9qyXh9i2A1gHInBn1iXqpMnYo+mBZXX3
         sT/eCnZJi5AIXufgWSdfgcRlf/y7fhlf5XrRrdWoJdGgD9bbYYweJ9ouppUglMObdRCC
         7Fx5ViiMrcFKYNlPYTXfnq9sigHbwhxN3gtEg/X9uLQ06EWc0qdcLFjbiKn8X8qoFFSS
         9fQBpIfXQEzofLnpWWbmpjCAGGmsnu9Qigd7x5Tj85hWwT2aaGR8AH5w+vUsbwEqHLlq
         4f4KJInaA5/nYyz/Y0nerQU3aJqcYDOj+ivXjKApv83coxIJue4y+kRc1f/BGmxrnG1A
         piaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=T2+PUkWlQYmob3d7nbW9BJNgUCy5teUF4SQyur60lBY=;
        b=CnaoS5SjOBFqNmpMU/B7E+yI1wFsRRJR6iCb6M+Z/ZI1n3R8PfeHNrJi1zSlbECuHx
         GmkoSpZBcdpcwDt4c+RVeTJDuVKPWSxtL7/hwdW6QcDpg7PETjN5K0gMLM8bw3/dlX7i
         kbqrF6aSouLCsL0/IuM/Tz+Z4BmjabkvsKUBPEaLiFgVQyLRoUO9smuytOUdW6GtSWRj
         or5vDEShG24FMbJNjfJ0OSU+sntMzu5m6d/dkXSOABN0qycRWE+nQIaZIKiPTKj/rn30
         1dgO+3O0Gx+CcGqeYb+YvFskGj+DpJ0Oo1YZVDhD8qlDBi5uH+iN49W2kDJZoLXajLoa
         0bbg==
X-Gm-Message-State: AOUpUlHIqiqWLUTyRU+LriTL+faVEi6SREdwf8FbTnvMospN+eYzJ4tr
        sIPoGUHNqGB9VGtGMRGvnSiGqA==
X-Google-Smtp-Source: AAOMgpfjslxBd1HjqfSr3NhWLRij03RspDnRYnp0+IFgOXkoZA2FwFOqQpy1Fbqgbu4aiRTVXQDIlQ==
X-Received: by 2002:a17:902:aa01:: with SMTP id be1-v6mr8138127plb.296.1531523256906;
        Fri, 13 Jul 2018 16:07:36 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e16-v6sm37730415pfn.46.2018.07.13.16.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 16:07:36 -0700 (PDT)
Date:   Fri, 13 Jul 2018 16:07:35 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch v3 -mm 6/6] mm, memcg: disregard mempolicies for cgroup-aware
 oom killer
In-Reply-To: <alpine.DEB.2.21.1807131604560.217600@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807131606590.217600@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com> <alpine.DEB.2.20.1803151351140.55261@chino.kir.corp.google.com> <alpine.DEB.2.20.1803161405410.209509@chino.kir.corp.google.com> <alpine.DEB.2.20.1803221451370.17056@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807131604560.217600@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup-aware oom killer currently considers the set of allowed nodes
for the allocation that triggers the oom killer and discounts usage from
disallowed nodes when comparing cgroups.

If a cgroup has both the cpuset and memory controllers enabled, it may be
possible to restrict allocations to a subset of nodes, for example.  Some
latency sensitive users use cpusets to allocate only local memory, almost
to the point of oom even though there is an abundance of available free
memory on other nodes.

The same is true for processes that mbind(2) their memory to a set of
allowed nodes.

This yields very inconsistent results by considering usage from each mem
cgroup (and perhaps its subtree) for the allocation's set of allowed nodes
for its mempolicy.  Allocating a single page for a vma that is mbind to a
now-oom node can cause a cgroup that is restricted to that node by its
cpuset controller to be oom killed when other cgroups may have much higher
overall usage.

The cgroup-aware oom killer is described as killing the largest memory
consuming cgroup (or subtree) without mentioning the mempolicy of the
allocation.  For now, discount it.  It would be possible to add an
additional oom policy for NUMA awareness if it would be generally useful
later with the extensible interface.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/memcontrol.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2819,19 +2819,15 @@ static inline bool memcg_has_children(struct mem_cgroup *memcg)
 	return ret;
 }
 
-static long memcg_oom_badness(struct mem_cgroup *memcg,
-			      const nodemask_t *nodemask)
+static long memcg_oom_badness(struct mem_cgroup *memcg)
 {
 	const bool is_root_memcg = memcg == root_mem_cgroup;
 	long points = 0;
 	int nid;
-	pg_data_t *pgdat;
 
 	for_each_node_state(nid, N_MEMORY) {
-		if (nodemask && !node_isset(nid, *nodemask))
-			continue;
+		pg_data_t *pgdat = NODE_DATA(nid);
 
-		pgdat = NODE_DATA(nid);
 		if (is_root_memcg) {
 			points += node_page_state(pgdat, NR_ACTIVE_ANON) +
 				  node_page_state(pgdat, NR_INACTIVE_ANON);
@@ -2867,8 +2863,7 @@ static long memcg_oom_badness(struct mem_cgroup *memcg,
  *   >0: memcg is eligible, and the returned value is an estimation
  *       of the memory footprint
  */
-static long oom_evaluate_memcg(struct mem_cgroup *memcg,
-			       const nodemask_t *nodemask)
+static long oom_evaluate_memcg(struct mem_cgroup *memcg)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -2902,7 +2897,7 @@ static long oom_evaluate_memcg(struct mem_cgroup *memcg,
 	if (eligible <= 0)
 		return eligible;
 
-	return memcg_oom_badness(memcg, nodemask);
+	return memcg_oom_badness(memcg);
 }
 
 static void select_victim_memcg(struct mem_cgroup *root, struct oom_control *oc)
@@ -2962,7 +2957,7 @@ static void select_victim_memcg(struct mem_cgroup *root, struct oom_control *oc)
 		if (memcg_has_children(iter))
 			continue;
 
-		score = oom_evaluate_memcg(iter, oc->nodemask);
+		score = oom_evaluate_memcg(iter);
 
 		/*
 		 * Ignore empty and non-eligible memory cgroups.
@@ -2991,8 +2986,7 @@ static void select_victim_memcg(struct mem_cgroup *root, struct oom_control *oc)
 
 	if (oc->chosen_memcg != INFLIGHT_VICTIM) {
 		if (root == root_mem_cgroup) {
-			group_score = oom_evaluate_memcg(root_mem_cgroup,
-							 oc->nodemask);
+			group_score = oom_evaluate_memcg(root_mem_cgroup);
 			if (group_score > leaf_score) {
 				/*
 				 * Discount the sum of all leaf scores to find
