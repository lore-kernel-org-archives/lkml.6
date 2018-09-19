Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1F8ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CDF214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9KTvBvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CDF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeISGUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:20:23 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33134 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeISGUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:20:22 -0400
Received: by mail-yw1-f73.google.com with SMTP id y137-v6so1793321ywy.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 17:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dPLvabeEu2R5NLjbgna2in9ApyNxHhQTFLi6gYIcZD0=;
        b=D9KTvBvrrAn23w6+nsWFdBhh5C7g8llWsnMC/BzXW0nGAXspOy4e9BubHJLItqLxt5
         nbZlHvMY08B0mvPSdc/43Vf21U8YDgbIBpJBLb+PA7eg03ur18PwVxfnbekEvNqXyK6m
         zKYVbVPRC4QTO3I+KOQ2NESTqBDI5VgcuP+/ocHFqQzGJfiR2Jfr/n4iXqS1xacLOskx
         BXLhnwKFNv5XEYvMkiU+FgdtXU2sg8RkXl9XNKHdl+DnQFvnfRhSlZRxAzLerEvninOv
         sdO2jN0nCRQJeKEGCDI6500p8Ca3xckLP6psNtZBY0Ag9FR1m0VYeviPkbi+MxKiNwDS
         eDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dPLvabeEu2R5NLjbgna2in9ApyNxHhQTFLi6gYIcZD0=;
        b=U5PhDXiDVS7mbxyecpoQJ6w1B4RmUYTE1fvBytxYgUNCIqjWle2m9vmTcxSvftomrn
         +ipr/N00Os0Lu6lmrx1myxCibPwelpXYiUO1qAjEfMjGx//lS8498DZMZ2pYvm/5+xNm
         207cocrjqataIUMVu3EhLx/aJufU2xLHWBds6LTBnVmIpSDbPJalA7irtrl7XGvSvBBY
         gnNZazGXhj/AfTEPpvW04FdMuL4YjcYB/4qWfGLBXQyYCy2UgK3RVq7SYyz5njb8PhjS
         KKhEYR7xbdqNvvlJIPYHT1syu9/g633Gf78l64aZI2VAs9aQNjF/yh/k2KZDwjmo7kRJ
         D8iA==
X-Gm-Message-State: APzg51DCv29WO/0j4uOTpQw8b/lQotVT/Ppx2MWAHArWx2BxnScdjYIs
        pM2rxMVAxlZQfb4mo7mIGsLHKzCaiUTVlQ==
X-Google-Smtp-Source: ANB0VdYR0M8iYbdDE6eEQVtSk0vNIl4Lqjjd4AmEHMfpP7qupf0EQT4vugvnaWs2cWFbVQqC8eqUnFc6rnqbng==
X-Received: by 2002:a81:180b:: with SMTP id 11-v6mr3712124ywy.19.1537317911673;
 Tue, 18 Sep 2018 17:45:11 -0700 (PDT)
Date:   Tue, 18 Sep 2018 17:45:01 -0700
Message-Id: <20180919004501.178023-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH] memcg: remove memcg_kmem_skip_account
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag memcg_kmem_skip_account was added during the era of opt-out
kmem accounting. There is no need for such flag in the opt-in world as
there aren't any __GFP_ACCOUNT allocations within
memcg_create_cache_enqueue().

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/sched.h |  3 ---
 mm/memcontrol.c       | 24 +-----------------------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..c30e3cd4b81c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -723,9 +723,6 @@ struct task_struct {
 #endif
 #ifdef CONFIG_MEMCG
 	unsigned			in_user_fault:1;
-#ifdef CONFIG_MEMCG_KMEM
-	unsigned			memcg_kmem_skip_account:1;
-#endif
 #endif
 #ifdef CONFIG_COMPAT_BRK
 	unsigned			brk_randomized:1;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e79cb59552d9..bde698a0bb99 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2460,7 +2460,7 @@ static void memcg_kmem_cache_create_func(struct work_struct *w)
 /*
  * Enqueue the creation of a per-memcg kmem_cache.
  */
-static void __memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
+static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 					       struct kmem_cache *cachep)
 {
 	struct memcg_kmem_cache_create_work *cw;
@@ -2478,25 +2478,6 @@ static void __memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 	queue_work(memcg_kmem_cache_wq, &cw->work);
 }
 
-static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
-					     struct kmem_cache *cachep)
-{
-	/*
-	 * We need to stop accounting when we kmalloc, because if the
-	 * corresponding kmalloc cache is not yet created, the first allocation
-	 * in __memcg_schedule_kmem_cache_create will recurse.
-	 *
-	 * However, it is better to enclose the whole function. Depending on
-	 * the debugging options enabled, INIT_WORK(), for instance, can
-	 * trigger an allocation. This too, will make us recurse. Because at
-	 * this point we can't allow ourselves back into memcg_kmem_get_cache,
-	 * the safest choice is to do it like this, wrapping the whole function.
-	 */
-	current->memcg_kmem_skip_account = 1;
-	__memcg_schedule_kmem_cache_create(memcg, cachep);
-	current->memcg_kmem_skip_account = 0;
-}
-
 static inline bool memcg_kmem_bypass(void)
 {
 	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
@@ -2531,9 +2512,6 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
 	if (memcg_kmem_bypass())
 		return cachep;
 
-	if (current->memcg_kmem_skip_account)
-		return cachep;
-
 	memcg = get_mem_cgroup_from_current();
 	kmemcg_id = READ_ONCE(memcg->kmemcg_id);
 	if (kmemcg_id < 0)
-- 
2.19.0.397.gdd90340f6a-goog

