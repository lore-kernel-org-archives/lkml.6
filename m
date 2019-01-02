Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F8BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705AE218FC
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JI62b/4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfABQJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:09:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39437 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfABQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:09:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so29306853qtj.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 08:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EGjYGPLV79cTTAx88qQx8JrYVlIA/Dm5mTiflkZ49i0=;
        b=JI62b/4t57zikLrILsFrQDuVhi7swP/jBfBQNzeEM+jsFup2AJngLTQJbpu+053IJI
         BkRonK1QmetROv0XGT7cAZkOBxnZq0zR80JhQQi3XYivW1N5dSNm0jxOmfq61XU5rHIU
         f+OxvdRksQhlMUZrZF6NXC95mWy8qXLxJR5Fq8+3b5p1Cyw5mTZcyfhhYTg+zRJn3QW4
         zymxS6ZCcZp7NHoxCfD7n1hc4yiTc2qMfMyM6BFq9vgJbMjrcbeuXv8A7qzbZQqYiIzz
         MRJ/4NkrGzN+fJoC+AgKPrS7IPM6kVRRo76sZwuqsPl0xCRTuqD9eNehN4hH9vnwPzpJ
         3tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EGjYGPLV79cTTAx88qQx8JrYVlIA/Dm5mTiflkZ49i0=;
        b=AJ7SiKTXqRj0nK0N7t1R6jhE+/a7XqOTwa4IS1Yc+cGyT99/bKR9EoiJRPMeCBxw7n
         +jBgJU+VEHWmXJEuTyFuCJaZvZnbd222QbnBM8QfRnXz/jcVicihTZ2AV4pAsPSQuttW
         WDcw+zcjoJzelhPq+6SL5y0DybN3T9uIhREy+0Gh+iSS8PYpb9P82SI5EVh0tNFgsdo7
         0EoqbYwe8eUJvqdgyxwBPZyhMxSnDD7g6rbm5dCDLJEXfMHEWs7tH5kpMG8LO0fezAgJ
         9Kvpb1mc4x/yFkLcGlEX2voh6paREug1nzSP1upp0I5BVI6UMPGVXK2gKh87fbqAig3G
         aOjQ==
X-Gm-Message-State: AJcUukftxZRwjQHAiIjbzaWwy0gwON+vrAI5ckYYZAI1wwRyjjFK2CvT
        0XGX4X18NGuYXJsJ1ZkQ7vtWtw==
X-Google-Smtp-Source: ALg8bN4CozgshsojEr9SRo9gEV0nvl6+w91J2qQJG0JU0C+qEghXkGDfijqpZFshk2Tam4IPvQYJFw==
X-Received: by 2002:a0c:d6c2:: with SMTP id l2mr42305547qvi.97.1546445349896;
        Wed, 02 Jan 2019 08:09:09 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y12sm30994640qta.13.2019.01.02.08.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 08:09:09 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] kmemleak: survive in a low-memory situation
Date:   Wed,  2 Jan 2019 11:08:49 -0500
Message-Id: <20190102160849.11480-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <0b2ecfe8-b98b-755c-5b5d-00a09a0d9e57@lca.pw>
References: <0b2ecfe8-b98b-755c-5b5d-00a09a0d9e57@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak could quickly fail to allocate an object structure and then
disable itself in a low-memory situation. For example, running a mmap()
workload triggering swapping and OOM [1].

First, it unnecessarily attempt to allocate even though the tracking
object is NULL in kmem_cache_alloc(). For example,

alloc_io
  bio_alloc_bioset
    mempool_alloc
      mempool_alloc_slab
        kmem_cache_alloc
          slab_alloc_node
            __slab_alloc <-- could return NULL
            slab_post_alloc_hook
              kmemleak_alloc_recursive

Second, kmemleak allocation could fail even though the trackig object is
succeeded. Hence, it could still try to start a direct reclaim if it is
not executed in an atomic context (spinlock, irq-handler etc), or a
high-priority allocation in an atomic context as a last-ditch effort.

[1]
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/kmemleak.c | 10 ++++++++++
 mm/slab.h     | 17 +++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index f9d9dc250428..9e1aa3b7df75 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -576,6 +576,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	struct rb_node **link, *rb_parent;
 
 	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
+#ifdef CONFIG_PREEMPT_COUNT
+	if (!object) {
+		/* last-ditch effort in a low-memory situation */
+		if (irqs_disabled() || is_idle_task(current) || in_atomic())
+			gfp = GFP_ATOMIC;
+		else
+			gfp = gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
+		object = kmem_cache_alloc(object_cache, gfp);
+	}
+#endif
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
diff --git a/mm/slab.h b/mm/slab.h
index 4190c24ef0e9..51a9a942cc56 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -435,15 +435,16 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 {
 	size_t i;
 
-	flags &= gfp_allowed_mask;
-	for (i = 0; i < size; i++) {
-		void *object = p[i];
-
-		kmemleak_alloc_recursive(object, s->object_size, 1,
-					 s->flags, flags);
-		p[i] = kasan_slab_alloc(s, object, flags);
+	if (*p) {
+		flags &= gfp_allowed_mask;
+		for (i = 0; i < size; i++) {
+			void *object = p[i];
+
+			kmemleak_alloc_recursive(object, s->object_size, 1,
+						 s->flags, flags);
+			p[i] = kasan_slab_alloc(s, object, flags);
+		}
 	}
-
 	if (memcg_kmem_enabled())
 		memcg_kmem_put_cache(s);
 }
-- 
2.17.2 (Apple Git-113)

