Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF999C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656CC250B5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="f0i75apv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656CC250B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935052AbeFYPP7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:15:59 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:43630 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934829AbeFYPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:12:58 -0400
Received: by mail-qt0-f169.google.com with SMTP id y89-v6so12221006qtd.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a9+UtxgxIpUvzBRIeHZNXw5T1d8Q+T1w06fzA+96JXU=;
        b=f0i75apv5CcC6A4NtbZFOuDX8mNvy+JkhnvR8z2395GXbvdsJBA/eE+pPzKibDgmIP
         nwttLkF0cV1m81a5GPoQRXehdRW06JUXNfPkIDbrQQ/K06/3q2r2XnN+Z5ZKSRlDEc04
         Oy4MnqCREBmQOlZ+UrSswGJRwpsKUyaCaa8p9BrFXLcM2n/X8RLASNgiVHyGnaW1yTZG
         soar7GtkJClJnitoCtpECLTTGBURRn6B66sIss9+M64b+WJLwsQn81ptNJZxisn7fzoQ
         KqPIEffYhjkeK4L2aqFhnsrY8UaW94ms2b57y6vOTSU1HycdjEomMjaZyDb7WXSTMhZo
         cDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a9+UtxgxIpUvzBRIeHZNXw5T1d8Q+T1w06fzA+96JXU=;
        b=gRm5agnR7orUnDLCx5b27+BUtXo9HF++SfbgIAKtJoiyroX00AhmlGUx+j91AUOm0m
         1m65RjH9/BH0pRQVs1k/ljHUlEIWjfgYhfWxGRN8DO6Wjs5Tdv9giyYGOOW2xOkUYAm+
         gFWR/bt3+gtQPzFDbNXhvk5axGqh8NFfwIHMiCNVlgO5G6hmm1/TnbFr91KvAtyvtLVm
         siYT7dlwkW6G9ibVhoFmiAjGQpiGjAX7XB+04Fe/zrGRbTqmpquNzZ9NLCFfjLEPk5Xp
         NSfIxfs9B2w+1DitWRA7GRyz3uaai7xCPNavY3zf0AoL8yrC0riDYfZ59tfGufwoX1aO
         kxcg==
X-Gm-Message-State: APt69E1SkInIJKwklt6BFpHoj1CszKfcA9+dXBzw+BpJo2M59JZmdO/g
        xGx8OdGRhyLyenqPdGIVNuYAJA==
X-Google-Smtp-Source: AAOMgpfzXqpUWGsTDPAsx0krur9jd6t4Fa2FOWGOo/O4o6SXREfOhcDTZa11cn77jtTiCThzFV4MQQ==
X-Received: by 2002:ac8:329c:: with SMTP id z28-v6mr5126618qta.330.1529939577655;
        Mon, 25 Jun 2018 08:12:57 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 20-v6sm4214320qts.28.2018.06.25.08.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:12:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 08/15] blk-stat: export helpers for modifying blk_rq_stat
Date:   Mon, 25 Jun 2018 11:12:36 -0400
Message-Id: <20180625151243.2132-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
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

