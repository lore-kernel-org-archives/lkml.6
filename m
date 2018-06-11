Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E25C4C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F13120869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edcRoNZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F13120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeFKTah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:30:37 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44649 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeFKTaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:30:35 -0400
Received: by mail-pg0-f65.google.com with SMTP id p21-v6so10225022pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g6N5HHKzRAZZPAqLufIufWeopavOpKuw/ghbCJReFhI=;
        b=edcRoNZOGyoZcEb9WnXeGiZYKFksK7D4u+pK8CHrimxhimjZir7VTyEKMjSlxj+pkc
         YQYpY+S6o+1azqtTY4X4tMHDhn6f2pY1iB1nrVvFCEpc0P9BRJ56h0W4W3e+TZezoesr
         6LYphObaOcOtyhi0YoUjzm/GcECzufuApKsDuYN+TXbdOimlbc/uZSSeBjjP4hvm0H8P
         DH3OWVrUp/6kLEmAfGXZpDkIQyAcLKFL2+rTPCCXHBvvMla+muO+MyB6TUaFil0oX49v
         aJLSjQSgSJwWnMFNSZQyuvejvAMy8330khu/XvekDe0D3lhzidcmyGdifphf68qiHjWF
         LQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g6N5HHKzRAZZPAqLufIufWeopavOpKuw/ghbCJReFhI=;
        b=uDocOb//MmuQsrOEDMAb6DSoDmJ4Si5VKTMuVfQIG/ey5N4g6lcehGilWpVg1HJVkS
         sfiuW9VuNyuzgvuH1qfvMpBUqzDORQ92hWMe/80P06FWg+HxT2TQ5zZfZp+FSI+rnXVY
         HjVZQSAP04SwLPgpbb+XQH5TQmfWxxShjm/GEVYz09z3Loc0fJn82dBb/p1andvOBBAt
         dq3Fsv/dJnysfzX+3GhWV71oxO67Bn9VIQBlq/er+t2HTqAzV9vWHWg9ftSwiPIoc3gf
         5iCaCotbeMWDvcAxuHwyP6/qpQMHFczXFBPH+W5SUrcMxO0T64gVZP8qVIrI9ZMBqx4M
         asJw==
X-Gm-Message-State: APt69E0EdmpPMdj0qhLLGW9EoQZ3v90JW8yvf9UeClgU5KLl3ta4PC1T
        T+QNjrUL2xT+MzvNFsKdSky0Mw==
X-Google-Smtp-Source: ADUXVKKjJip/VIilXIWc3jUs/C8jeY7mmDeU7vjgYkA1B7rcFsWjz5SdXPLVCM/jL2foaFPDAK7WEw==
X-Received: by 2002:a62:5991:: with SMTP id k17-v6mr519152pfj.94.1528745433964;
        Mon, 11 Jun 2018 12:30:33 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id b22-v6sm14010493pfi.144.2018.06.11.12.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 12:30:31 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Michal Hocko <mhocko@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v4] mm: fix race between kmem_cache destroy, create and deactivate
Date:   Mon, 11 Jun 2018 12:29:51 -0700
Message-Id: <20180611192951.195727-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg kmem cache creation and deactivation (SLUB only) is
asynchronous. If a root kmem cache is destroyed whose memcg cache is in
the process of creation or deactivation, the kernel may crash.

Example of one such crash:
	general protection fault: 0000 [#1] SMP PTI
	CPU: 1 PID: 1721 Comm: kworker/14:1 Not tainted 4.17.0-smp
	...
	Workqueue: memcg_kmem_cache kmemcg_deactivate_workfn
	RIP: 0010:has_cpu_slab
	...
	Call Trace:
	? on_each_cpu_cond
	__kmem_cache_shrink
	kmemcg_cache_deact_after_rcu
	kmemcg_deactivate_workfn
	process_one_work
	worker_thread
	kthread
	ret_from_fork+0x35/0x40

To fix this race, on root kmem cache destruction, mark the cache as
dying and flush the workqueue used for memcg kmem cache creation and
deactivation. SLUB's memcg kmem cache deactivation also includes RCU
callback and thus make sure all previous registered RCU callbacks
have completed as well.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changelog since v3:
- Handle the RCU callbacks for SLUB deactivation

Changelog since v2:
- Rewrote the patch and used workqueue flushing instead of refcount

Changelog since v1:
- Added more documentation to the code
- Renamed fields to be more readable

---
 include/linux/slab.h |  1 +
 mm/slab_common.c     | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9ebe659bd4a5..71c5467d99c1 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -658,6 +658,7 @@ struct memcg_cache_params {
 			struct memcg_cache_array __rcu *memcg_caches;
 			struct list_head __root_caches_node;
 			struct list_head children;
+			bool dying;
 		};
 		struct {
 			struct mem_cgroup *memcg;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b0dd9db1eb2f..890b1f04a03a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -136,6 +136,7 @@ void slab_init_memcg_params(struct kmem_cache *s)
 	s->memcg_params.root_cache = NULL;
 	RCU_INIT_POINTER(s->memcg_params.memcg_caches, NULL);
 	INIT_LIST_HEAD(&s->memcg_params.children);
+	s->memcg_params.dying = false;
 }
 
 static int init_memcg_params(struct kmem_cache *s,
@@ -608,7 +609,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
 	 * The memory cgroup could have been offlined while the cache
 	 * creation work was pending.
 	 */
-	if (memcg->kmem_state != KMEM_ONLINE)
+	if (memcg->kmem_state != KMEM_ONLINE || root_cache->memcg_params.dying)
 		goto out_unlock;
 
 	idx = memcg_cache_id(memcg);
@@ -712,6 +713,9 @@ void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
 	    WARN_ON_ONCE(s->memcg_params.deact_fn))
 		return;
 
+	if (s->memcg_params.root_cache->memcg_params.dying)
+		return;
+
 	/* pin memcg so that @s doesn't get destroyed in the middle */
 	css_get(&s->memcg_params.memcg->css);
 
@@ -823,11 +827,36 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
 		return -EBUSY;
 	return 0;
 }
+
+static void flush_memcg_workqueue(struct kmem_cache *s)
+{
+	mutex_lock(&slab_mutex);
+	s->memcg_params.dying = true;
+	mutex_unlock(&slab_mutex);
+
+	/*
+	 * SLUB deactivates the kmem_caches through call_rcu_sched. Make
+	 * sure all registered rcu callbacks have been invoked.
+	 */
+	if (IS_ENABLED(CONFIG_SLUB))
+		rcu_barrier_sched();
+
+	/*
+	 * SLAB and SLUB create memcg kmem_caches through workqueue and SLUB
+	 * deactivates the memcg kmem_caches through workqueue. Make sure all
+	 * previous workitems on workqueue are processed.
+	 */
+	flush_workqueue(memcg_kmem_cache_wq);
+}
 #else
 static inline int shutdown_memcg_caches(struct kmem_cache *s)
 {
 	return 0;
 }
+
+static inline void flush_memcg_workqueue(struct kmem_cache *s)
+{
+}
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 void slab_kmem_cache_release(struct kmem_cache *s)
@@ -845,6 +874,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
 
+	flush_memcg_workqueue(s);
+
 	get_online_cpus();
 	get_online_mems();
 
-- 
2.18.0.rc1.242.g61856ae69a-goog

