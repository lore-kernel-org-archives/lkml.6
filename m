Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DEBC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F3D208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="XY00F3Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F3D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbeGCPSV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:18:21 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:44390 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934068AbeGCPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:19 -0400
Received: by mail-qt0-f177.google.com with SMTP id b15-v6so1854333qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a9+UtxgxIpUvzBRIeHZNXw5T1d8Q+T1w06fzA+96JXU=;
        b=XY00F3HzAc+zDZGKcw3zoID7lfUGl9aDOVcUyxe/1/XPdFG4NtGZHMfOe9li+v+sX2
         iU6MyY9/JiQJsUIw0lpTmNh530a7HAyK939faqkbpYGb77VWdQPHPad4Ns+EgFJ+yQLK
         fHNkctKr1jXNCjoJIacVyH9ToJDC6sbxLrwmDIwzg8CYugyQ8ulRvZPCNk/kBgQycmzA
         ipSBaEJ8Z/UpgpeKCmTQ62oH/z0TBNdeX9gus16EZv3cArL/tFhLNOtcoy8ZgchnuyZp
         peeFYNDKSv28d+3wgXFbBuaUfrG6QiB2vW8epQx7QKVPYGWrrS8cthOiigPrcymWBjl5
         K10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a9+UtxgxIpUvzBRIeHZNXw5T1d8Q+T1w06fzA+96JXU=;
        b=ggW7R0PKvZAquqHG1c7qT/7Kra1tVmj6L1yVmBWb+JHuwMjWZ1Vki3FYwOMXKzkl7p
         oNWa05tELes3prgMXVRbD7ARqSFmw3YX8MUZOEBoIcOAjp7H5mdrT8nMqTnUAXZhscqd
         ZBag3XtjqQbxz6WPabiw5wBxjOwgx7SpTLAkTtHgIrR0bu8IDS+S+Rr/+CvXu8eWuqe2
         TAwnpp8201CqUUuZnMpPkvFlmZTrXLJZ8hab8V6g//ZvCB0tniIY8uwdPB5rqBQQPnSx
         d/lD6SeNsY5fG50bShY1d1rAJZovA9r+zUg4gzUTCKopNsmIPxPRirJZXb/u/wQsQwIf
         ru6Q==
X-Gm-Message-State: APt69E0+eynWbGO8UduqnbdOuWpPy09HtQgQYS1XrIjm4qI6jrbjb82+
        EqSXxH2E14tGoVLaJywal+zrqY4ECMY=
X-Google-Smtp-Source: AAOMgpcbYBenmEcQSxrjPtBzxyHgC4zyLPBboQkz2Y3pGp9RpE4TRzYZyzKxwV4LIg5hAeHta3CNOw==
X-Received: by 2002:ac8:7284:: with SMTP id v4-v6mr18280804qto.177.1530630919054;
        Tue, 03 Jul 2018 08:15:19 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f3-v6sm996553qtf.61.2018.07.03.08.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 08/14] blk-stat: export helpers for modifying blk_rq_stat
Date:   Tue,  3 Jul 2018 11:14:57 -0400
Message-Id: <20180703151503.2549-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
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

