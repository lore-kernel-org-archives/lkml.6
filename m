Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1ABC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83B427D43
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="YByhWzUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83B427D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936855AbeF2T12 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:27:28 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:43600 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935556AbeF2TZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:25:57 -0400
Received: by mail-qt0-f178.google.com with SMTP id c8-v6so8819879qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a9+UtxgxIpUvzBRIeHZNXw5T1d8Q+T1w06fzA+96JXU=;
        b=YByhWzUS/G/Pd+OHvCtpRAVvHSL8isU7m4OSLb3tVNHduGJ1X2+qi2SJxjPlzupZOP
         Qc2dFZ06T//Od7c8ryuONQMyMsPfIBcZvqRis4jA+xtjJzHHNRXqWZwR9vcMvfrQ2Iuo
         3RESsE57pKyhjdtvxp8f/CR30BksBuRAW0qjfAAm/pC5cEs3LOklsJowjO7gppfPA8Ow
         2K8rfH40F0Q4e7jr8tcZs+m0W66+ymEq9+QpRK2837ioYGaxOl6gNA6D5pXZsEoHhKWD
         pBYpaiz1p6fs4aL+cVFAu9tqx0OKqZwlGnvujN95Dik5RrDgWa/vK90n4rKpIIS2Yo6C
         r8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a9+UtxgxIpUvzBRIeHZNXw5T1d8Q+T1w06fzA+96JXU=;
        b=a8oR41LcS1BSg5uzyivmFlOtOZYUm5jTr2lhTn2olaeJUlrtHfj8s2opKifXBgj9qS
         FlhObod8i2Tde+co9zo6VATwvbmTlnRDuDUy3nR9Azw4ht/rcneVRsOJZOz6Y4cHyDpX
         NjZCKSZk6F+eix8nXSDMfoAEHup2MLsU8YrQfXhtmh58DLw0C9iPtnS+pgUA5qt2OLeF
         qkdrQFEwtoWWPBgDNmZqEgD3M06Q+1l+aV9+to4PFywrjQDGPyK1diH4Rel6SbnstGlZ
         5lUDqaPLQS3O4W84TyY5fTbx+yAIGJP3Ds1bPRLproVJLavoZQFhWI+BfaP3pHl5XZ81
         Avaw==
X-Gm-Message-State: APt69E3e9C5j9Nf1v6DyASpAzPzdHCS9ysMe8lwcTEK0lA2oEBIAACVx
        38dKmXKngsXYXOT/uXYXlbRufw==
X-Google-Smtp-Source: AAOMgpcCvHmajw7ET2xpbgW/pRaSNu3OtPIAwte0Fe/DRnQM7W57T9TgcYEAaF+dvDidc0Whl1tDag==
X-Received: by 2002:ac8:1196:: with SMTP id d22-v6mr14371185qtj.325.1530300356360;
        Fri, 29 Jun 2018 12:25:56 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s9-v6sm8626182qkl.65.2018.06.29.12.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:25:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 08/14] blk-stat: export helpers for modifying blk_rq_stat
Date:   Fri, 29 Jun 2018 15:25:36 -0400
Message-Id: <20180629192542.26649-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180629192542.26649-1-josef@toxicpanda.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

We need to use blk_rq_stat in the blkcg qos stuff, so export some of
these helpers so they can be used by other things.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-stat.c | 16 ++++++++--------
 block/blk-stat.h |  4 ++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 175c143ac5b9..7587b1c3caaf 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -17,7 +17,7 @@ struct blk_queue_stats {
 	bool enable_accounting;
 };
 
-static void blk_stat_init(struct blk_rq_stat *stat)
+void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
 	stat->max = stat->nr_samples = stat->mean = 0;
@@ -25,7 +25,7 @@ static void blk_stat_init(struct blk_rq_stat *stat)
 }
 
 /* src is a per-cpu stat, mean isn't initialized */
-static void blk_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
+void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
 	if (!src->nr_samples)
 		return;
@@ -39,7 +39,7 @@ static void blk_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->nr_samples += src->nr_samples;
 }
 
-static void __blk_stat_add(struct blk_rq_stat *stat, u64 value)
+void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
 {
 	stat->min = min(stat->min, value);
 	stat->max = max(stat->max, value);
@@ -69,7 +69,7 @@ void blk_stat_add(struct request *rq, u64 now)
 			continue;
 
 		stat = &get_cpu_ptr(cb->cpu_stat)[bucket];
-		__blk_stat_add(stat, value);
+		blk_rq_stat_add(stat, value);
 		put_cpu_ptr(cb->cpu_stat);
 	}
 	rcu_read_unlock();
@@ -82,15 +82,15 @@ static void blk_stat_timer_fn(struct timer_list *t)
 	int cpu;
 
 	for (bucket = 0; bucket < cb->buckets; bucket++)
-		blk_stat_init(&cb->stat[bucket]);
+		blk_rq_stat_init(&cb->stat[bucket]);
 
 	for_each_online_cpu(cpu) {
 		struct blk_rq_stat *cpu_stat;
 
 		cpu_stat = per_cpu_ptr(cb->cpu_stat, cpu);
 		for (bucket = 0; bucket < cb->buckets; bucket++) {
-			blk_stat_sum(&cb->stat[bucket], &cpu_stat[bucket]);
-			blk_stat_init(&cpu_stat[bucket]);
+			blk_rq_stat_sum(&cb->stat[bucket], &cpu_stat[bucket]);
+			blk_rq_stat_init(&cpu_stat[bucket]);
 		}
 	}
 
@@ -143,7 +143,7 @@ void blk_stat_add_callback(struct request_queue *q,
 
 		cpu_stat = per_cpu_ptr(cb->cpu_stat, cpu);
 		for (bucket = 0; bucket < cb->buckets; bucket++)
-			blk_stat_init(&cpu_stat[bucket]);
+			blk_rq_stat_init(&cpu_stat[bucket]);
 	}
 
 	spin_lock(&q->stats->lock);
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 78399cdde9c9..f4a1568e81a4 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -159,4 +159,8 @@ static inline void blk_stat_activate_msecs(struct blk_stat_callback *cb,
 	mod_timer(&cb->timer, jiffies + msecs_to_jiffies(msecs));
 }
 
+void blk_rq_stat_add(struct blk_rq_stat *, u64);
+void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
+void blk_rq_stat_init(struct blk_rq_stat *);
+
 #endif
-- 
2.14.3

