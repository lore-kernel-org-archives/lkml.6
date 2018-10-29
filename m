Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE0C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611BF20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1x9QymbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611BF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeJ3B2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:28:05 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50973 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeJ3B1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:21 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so10319118ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CCxQ1w7oEfeYNp97sRQwoZGVpyu0hoStQAxbQ0x4cMs=;
        b=1x9QymbKSfQAQsEaeunWt42kHkrjMbrs37kzbMSUPQ6kQQVhCOLo4tC9Q72IzkoGen
         /y4yFpjcwH3Kvhkcu1BrpwfjByT85VqZX3zMwQ+fcxS2SI/d4XcOOmwdLVCtH8DEWvro
         Y8BygKmSvW4drwMIfl9l7x/tIDz+fXl1nx0WaNXZH5B/pYlwvoix1PAQGftREplo4TLe
         6uGNwji5R2mRnR7Dt9jkEv9i9DEtPuhAHGeeTEaL5VfAouZF3i01okwpF9lU8VI5+z6T
         Vvto4i83rswwrASfhDL3trpevQ4lkcC8OUX9i59RmY6wvrwb0j+Hs4ZEus4phy++AiAk
         ycvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCxQ1w7oEfeYNp97sRQwoZGVpyu0hoStQAxbQ0x4cMs=;
        b=hetqEhvaoG1j+2LQafi0aaOYbKEUKtAfgl19h682F5bZ5sHhkE7S9/bgMd8y3DEqZP
         kE8pJwKurizTTaZ/GncynsZcRpIYQBNwb9cdxjAP92ELQFerya3Z+AGTkkjMH0Oajk4i
         d+eayGDkByAIJDa33ANHq2Nc1jiXJPmdDMu664J8IKXrOSJmk/+PVYHqKyIbJX+b7eck
         +1rnmVdgHORpCQfyBryFhcBKa4YGyGH+VqqZNUAoRW2pr/RfHc1n/2vPlcn8f51iWtBp
         HJo1F6TMxAIBNRIit3/8HtYFR81Q9QeuTc4CD3oDxFgQcfByM8qNowXQFeYI14k+nlaP
         TfDQ==
X-Gm-Message-State: AGRZ1gKJZzN1dG8cW/LPb0usMg0vm1PokKH0yPL2y0iFKtvWmFcAL9vE
        1PaUeJ96Vcs0N6jmyoTSZP7brg==
X-Google-Smtp-Source: AJdET5fmxR4SW5z/LgB6ktrnLBgw6BrY449jiuxnWGCX46++qkiTSZHw10Ttf2eU3HjE+B9sXt3d8w==
X-Received: by 2002:a24:1a56:: with SMTP id 83-v6mr6138029iti.135.1540831079149;
        Mon, 29 Oct 2018 09:37:59 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:37:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/14] blk-mq: separate number of hardware queues from nr_cpu_ids
Date:   Mon, 29 Oct 2018 10:37:32 -0600
Message-Id: <20181029163738.10172-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With multiple maps, nr_cpu_ids is no longer the maximum number of
hardware queues we support on a given devices. The initializer of
the tag_set can have set ->nr_hw_queues larger than the available
number of CPUs, since we can exceed that with multiple queue maps.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0fab36372ace..60a951c4934c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2663,6 +2663,19 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	mutex_unlock(&q->sysfs_lock);
 }
 
+/*
+ * Maximum number of queues we support. For single sets, we'll never have
+ * more than the CPUs (software queues). For multiple sets, the tag_set
+ * user may have set ->nr_hw_queues larger.
+ */
+static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
+{
+	if (set->nr_maps == 1)
+		return nr_cpu_ids;
+
+	return max(set->nr_hw_queues, nr_cpu_ids);
+}
+
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
@@ -2682,7 +2695,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
 
-	q->queue_hw_ctx = kcalloc_node(nr_cpu_ids, sizeof(*(q->queue_hw_ctx)),
+	q->nr_queues = nr_hw_queues(set);
+	q->queue_hw_ctx = kcalloc_node(q->nr_queues, sizeof(*(q->queue_hw_ctx)),
 						GFP_KERNEL, set->numa_node);
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
@@ -2694,7 +2708,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
-	q->nr_queues = nr_cpu_ids;
 	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
@@ -2884,12 +2897,13 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		set->queue_depth = min(64U, set->queue_depth);
 	}
 	/*
-	 * There is no use for more h/w queues than cpus.
+	 * There is no use for more h/w queues than cpus if we just have
+	 * a single map
 	 */
-	if (set->nr_hw_queues > nr_cpu_ids)
+	if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
 		set->nr_hw_queues = nr_cpu_ids;
 
-	set->tags = kcalloc_node(nr_cpu_ids, sizeof(struct blk_mq_tags *),
+	set->tags = kcalloc_node(nr_hw_queues(set), sizeof(struct blk_mq_tags *),
 				 GFP_KERNEL, set->numa_node);
 	if (!set->tags)
 		return -ENOMEM;
@@ -2932,7 +2946,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i, j;
 
-	for (i = 0; i < nr_cpu_ids; i++)
+	for (i = 0; i < nr_hw_queues(set); i++)
 		blk_mq_free_map_and_requests(set, i);
 
 	for (j = 0; j < set->nr_maps; j++) {
@@ -3064,7 +3078,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	lockdep_assert_held(&set->tag_list_lock);
 
-	if (nr_hw_queues > nr_cpu_ids)
+	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
 	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
 		return;
-- 
2.17.1

