Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2698890-1527628763-2-915651549349000319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527628763; b=C8sayn7oTikOtc6MjDJgRVf3cNc9F97Rt1VQOdp/zKZ/c1BaAB
    UougcR8XlQYp23rVjPx0jb8J1LVAoymOBCvTfpr2qVIfeIIHVYcSZfvC+gG0iREi
    o/mumX6/WOtI+jPSGiAVq3pU6HW1s5T8j0CbCQNO6r5v1+2OTnsEfaXr6Zyigiy0
    PBKiQpupH6wP9SQCyFVcgJ0xjvdQKfHm1+VKa0nf0MUNAHnLJ4xJXtDg2lST4q64
    pwJpuRQ02B5Yb6e8tde9PHKKDQf32XCBhtFvqUFPqJ9ED/WGdL8b1eWwrhD6KlyQ
    LjkT+SxXlaUK/Ifhdw/nNhG8q6Rba6e6Z+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527628763; bh=
    EjicLf9K/6JSWhW15jDjpVP8/botVJtyocgCDzgGgxk=; b=NKlG5ZkrslbGlFNk
    cHhSHr7av26jvKcsxoO4juaRaKoIIAiGaaZPiqJLf1Vy81hJmXAH3OV3gioIErBz
    Q8wGYHlBs8gqzPzxQaWFyzhx3GRekS1m08We4h5KuEv8Cbj0JKx/A8vRrGJNltx5
    BJvnLPT/3+Esx4kjjRnryEw6TITt6iT5zJZVv1tl4XB1BjbonaSO8iIuFpifhuIr
    EIDW/UwjcYe3P+TJzY5+CS397aBBeIqEmNlqQ++0cTe18PIP6lRgoMxp35vBo5WS
    AW1yhx0VvNoR6IiHAzWLU3k6TcF/Opmwd8/s4QyyLw2UJd3tP36OMrrC5ev3NlVy
    8yN80g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=toxicpanda-com.20150623.gappssmtp.com
    header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=bN8pg7b9
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=tVLDRodi;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=toxicpanda.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=toxicpanda-com.20150623.gappssmtp.com
      header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=bN8pg7b9
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=tVLDRodi;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=toxicpanda.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP/pIdcR5PMnDDNPdFnXb/aKBOYaoDYXHC2W0Z3JTip+qelwEeagRi3eKEC6rCzSvCaz76Uj+5qUmeEva8mW2OrpOH4W8uA7HQiDM3lPU8i0/BbnN97e
    5yf2BcPXssvKEVuVE16g1ZNGjVMMDIAAj5TQvZN6+hgo0zNSKijDpYwk4/LuNVUZhDCY9ag7QzNsD3zTw3RYhXSsVsiX336v43a6ag1mLGahNaNS2ND9DPPx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=FOH2dFAWAAAA:8 a=8tnvWpKZlbSbACY4nYoA:9 a=8r7ZC3K_H8EC-_bP:21
    a=19VeXkd9hL6oXRy5:21 a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967574AbeE2VTK (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 17:19:10 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:39820 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967283AbeE2VRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 17:17:40 -0400
X-Google-Smtp-Source: ADUXVKITArJXRT3Qo92f7LJYsUrATqDc1orwCDTVfRZYk7bv/XNnvkR6PAHSZKbbTfNrKx+nEX1SEA==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 08/13] blk-stat: export helpers for modifying blk_rq_stat
Date: Tue, 29 May 2018 17:17:19 -0400
Message-Id: <20180529211724.4531-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529211724.4531-1-josef@toxicpanda.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We need to use blk_rq_stat in the blkcg qos stuff, so export some of
these helpers so they can be used by other things.

Signed-off-by: Josef Bacik <jbacik@fb.com>
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
