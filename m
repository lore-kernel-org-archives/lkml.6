Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1866E214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+V6OtRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfBAWaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:30:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35854 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfBAWaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:30:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so8725654wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 14:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NFeMuc3s4W7AQBUBX18/VzOwSVQml6rx4LFfV2PKgRc=;
        b=k+V6OtRXr9SXmW8DOL/6xJRPjmalbfE9/rkX0+dYTp/TLJ4mzWtK4grKULR7u9f0Ws
         PzCS/Oj8Car4RO3t3L0S5Mn3jM7AW7nCByAbJEa4YDKCCenPEe4j+We7asjkvkf/3Imp
         oANPhO4FsT28S3gGkTcEiNRxiAS7n+5wiAvvrKUaojiPkNs5n0tfgcsuDTtO+VeiIUAG
         UdbGgpC2085n3BD7layy53iwy0AdhsnDU+FoDlKVfAY6nYhCwgdZe2yXHlFm2VAlcaCA
         AzR9XcOzzqYqH3Jl5XCzHWhHLEgC3aig03UdoDa+rw6khbN8VonwcrrqI4Y32mX/WtMz
         Eg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NFeMuc3s4W7AQBUBX18/VzOwSVQml6rx4LFfV2PKgRc=;
        b=oshj68y1knsYJbO9qumTBdRucMHuJ3U+37desqaRl2clmEJ1Z97p1nQ/74C35ggc0S
         NeKfO0aDfQ1TqHMJmh9wkDXj7nhylt3iQbwPOD9tGMepXU6+5I59CBVFbgrqUU6deaDo
         9raw418G5LzaAcQXuuLdeeAbTpuYJrMsPNTtZLR3ZsOVOWVmCLUSXwAf8SpDrgKNeDel
         +/38joMeVUGh8MOFoMJNmFVc6BNPcNJNuqHEC3aCgr9llavkQE1ysPhEMJ96Bna52Mvm
         01LAsy981spp7NuGs+TlvoBfDrQHJhWztZD0isS4epR8nT/yLYIyleyxJOAvyWPYYt+0
         Ttog==
X-Gm-Message-State: AJcUukfF8VjEof/OpJYsvaIzlBafxR9XvTSY6L4fHbYyc3DDZC0thXAA
        kIDcE8wSzCVf2wXbkmbvtzGwMbs=
X-Google-Smtp-Source: ALg8bN5XumzInc1UpvL5hKgtGQyaMs/pJPPb4dQ5ceWK34HlDKgTeujtgsLGxLWqyYfIhEsR/yqjFg==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr40674537wrx.85.1549060232402;
        Fri, 01 Feb 2019 14:30:32 -0800 (PST)
Received: from avx2 ([46.53.241.160])
        by smtp.gmail.com with ESMTPSA id g9sm3995456wmg.44.2019.02.01.14.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:30:31 -0800 (PST)
Date:   Sat, 2 Feb 2019 01:30:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] numa: make "nr_node_ids" unsigned int
Message-ID: <20190201223029.GA15820@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Number of NUMA nodes can't be negative.

This saves a few bytes on x86_64:

	add/remove: 0/0 grow/shrink: 4/21 up/down: 27/-265 (-238)
	Function                                     old     new   delta
	hv_synic_alloc.cold                           88     110     +22
	prealloc_shrinker                            260     262      +2
	bootstrap                                    249     251      +2
	sched_init_numa                             1566    1567      +1
	show_slab_objects                            778     777      -1
	s_show                                      1201    1200      -1
	kmem_cache_init                              346     345      -1
	__alloc_workqueue_key                       1146    1145      -1
	mem_cgroup_css_alloc                        1614    1612      -2
	__do_sys_swapon                             4702    4699      -3
	__list_lru_init                              655     651      -4
	nic_probe                                   2379    2374      -5
	store_user_store                             118     111      -7
	red_zone_store                               106      99      -7
	poison_store                                 106      99      -7
	wq_numa_init                                 348     338     -10
	__kmem_cache_empty                            75      65     -10
	task_numa_free                               186     173     -13
	merge_across_nodes_store                     351     336     -15
	irq_create_affinity_masks                   1261    1246     -15
	do_numa_crng_init                            343     321     -22
	task_numa_fault                             4760    4737     -23
	swapfile_init                                179     156     -23
	hv_synic_alloc                               536     492     -44
	apply_wqattrs_prepare                        746     695     -51

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm64/mm/numa.c           |    2 +-
 arch/powerpc/mm/numa.c         |    2 +-
 arch/x86/kernel/setup_percpu.c |    2 +-
 arch/x86/mm/numa.c             |    4 ++--
 include/linux/nodemask.h       |    4 ++--
 mm/list_lru.c                  |    3 +--
 mm/memcontrol.c                |    2 +-
 mm/page_alloc.c                |    2 +-
 mm/slab.c                      |    3 +--
 mm/slub.c                      |    2 +-
 mm/swapfile.c                  |    2 +-
 mm/vmscan.c                    |    2 +-
 12 files changed, 14 insertions(+), 16 deletions(-)

--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -120,7 +120,7 @@ static void __init setup_node_to_cpumask_map(void)
 	}
 
 	/* cpumask_of_node() will now work */
-	pr_debug("Node to cpumask map for %d nodes\n", nr_node_ids);
+	pr_debug("Node to cpumask map for %u nodes\n", nr_node_ids);
 }
 
 /*
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -84,7 +84,7 @@ static void __init setup_node_to_cpumask_map(void)
 		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
 
 	/* cpumask_of_node() will now work */
-	dbg("Node to cpumask map for %d nodes\n", nr_node_ids);
+	dbg("Node to cpumask map for %u nodes\n", nr_node_ids);
 }
 
 static int __init fake_numa_create_new_node(unsigned long end_pfn,
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -171,7 +171,7 @@ void __init setup_per_cpu_areas(void)
 	unsigned long delta;
 	int rc;
 
-	pr_info("NR_CPUS:%d nr_cpumask_bits:%d nr_cpu_ids:%u nr_node_ids:%d\n",
+	pr_info("NR_CPUS:%d nr_cpumask_bits:%d nr_cpu_ids:%u nr_node_ids:%u\n",
 		NR_CPUS, nr_cpumask_bits, nr_cpu_ids, nr_node_ids);
 
 	/*
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -123,7 +123,7 @@ void __init setup_node_to_cpumask_map(void)
 		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
 
 	/* cpumask_of_node() will now work */
-	pr_debug("Node to cpumask map for %d nodes\n", nr_node_ids);
+	pr_debug("Node to cpumask map for %u nodes\n", nr_node_ids);
 }
 
 static int __init numa_add_memblk_to(int nid, u64 start, u64 end,
@@ -866,7 +866,7 @@ const struct cpumask *cpumask_of_node(int node)
 {
 	if (node >= nr_node_ids) {
 		printk(KERN_WARNING
-			"cpumask_of_node(%d): node > nr_node_ids(%d)\n",
+			"cpumask_of_node(%d): node > nr_node_ids(%u)\n",
 			node, nr_node_ids);
 		dump_stack();
 		return cpu_none_mask;
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -444,7 +444,7 @@ static inline int next_memory_node(int nid)
 	return next_node(nid, node_states[N_MEMORY]);
 }
 
-extern int nr_node_ids;
+extern unsigned int nr_node_ids;
 extern int nr_online_nodes;
 
 static inline void node_set_online(int nid)
@@ -485,7 +485,7 @@ static inline int num_node_state(enum node_states state)
 #define first_online_node	0
 #define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
-#define nr_node_ids		1
+#define nr_node_ids		1U
 #define nr_online_nodes		1
 
 #define node_set_online(node)	   node_set_state((node), N_ONLINE)
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -601,7 +601,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key, struct shrinker *shrinker)
 {
 	int i;
-	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -612,7 +611,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 #endif
 	memcg_get_cache_ids();
 
-	lru->node = kzalloc(size, GFP_KERNEL);
+	lru->node = kcalloc(nr_node_ids, sizeof(*lru->node), GFP_KERNEL);
 	if (!lru->node)
 		goto out;
 
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4420,7 +4420,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 static struct mem_cgroup *mem_cgroup_alloc(void)
 {
 	struct mem_cgroup *memcg;
-	size_t size;
+	unsigned int size;
 	int node;
 
 	size = sizeof(struct mem_cgroup);
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -289,7 +289,7 @@ EXPORT_SYMBOL(movable_zone);
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
 #if MAX_NUMNODES > 1
-int nr_node_ids __read_mostly = MAX_NUMNODES;
+unsigned int nr_node_ids __read_mostly = MAX_NUMNODES;
 int nr_online_nodes __read_mostly = 1;
 EXPORT_SYMBOL(nr_node_ids);
 EXPORT_SYMBOL(nr_online_nodes);
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -676,12 +676,11 @@ static struct alien_cache *__alloc_alien_cache(int node, int entries,
 static struct alien_cache **alloc_alien_cache(int node, int limit, gfp_t gfp)
 {
 	struct alien_cache **alc_ptr;
-	size_t memsize = sizeof(void *) * nr_node_ids;
 	int i;
 
 	if (limit > 1)
 		limit = 12;
-	alc_ptr = kzalloc_node(memsize, gfp, node);
+	alc_ptr = kcalloc_node(nr_node_ids, sizeof(void *), gfp, node);
 	if (!alc_ptr)
 		return NULL;
 
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4245,7 +4245,7 @@ void __init kmem_cache_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_SLUB_DEAD, "slub:dead", NULL,
 				  slub_cpu_dead);
 
-	pr_info("SLUB: HWalign=%d, Order=%u-%u, MinObjects=%u, CPUs=%u, Nodes=%d\n",
+	pr_info("SLUB: HWalign=%d, Order=%u-%u, MinObjects=%u, CPUs=%u, Nodes=%u\n",
 		cache_line_size(),
 		slub_min_order, slub_max_order, slub_min_objects,
 		nr_cpu_ids, nr_node_ids);
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2813,7 +2813,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 	struct swap_info_struct *p;
 	unsigned int type;
 	int i;
-	int size = sizeof(*p) + nr_node_ids * sizeof(struct plist_node);
+	unsigned int size = sizeof(*p) + nr_node_ids * sizeof(struct plist_node);
 
 	p = kvzalloc(size, GFP_KERNEL);
 	if (!p)
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -374,7 +374,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	size_t size = sizeof(*shrinker->nr_deferred);
+	unsigned int size = sizeof(*shrinker->nr_deferred);
 
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
