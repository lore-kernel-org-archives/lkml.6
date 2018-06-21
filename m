Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF373C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D23020874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TghLfkHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D23020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbeFUDHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:07:44 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40150 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbeFUDHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:07:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id w8-v6so715734pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 20:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BlI6sZ67WAPyiOAfEubsTr6KMfHjrMipPMRsWQXJc3k=;
        b=TghLfkHhWYW4CwOlqK7TFn4cWjaZf1kOZwQW5vaM03ST7LRYT5M9lgDkMNLQtrxZF+
         prppjXovV8tpYVB9sfrdmx03N3HQ6s9yblgQ6TD+AmY0MURicwMZc0O0RTx7v8fd+WNp
         13w+CPTeE/0Evx4//Ii/xLvVOjrx3yvXGPe2NzTtZSFk/8OyaKNxmJV7pisn6p6TS1BW
         AMMm9nt6iiMIeWoSl/oI6MxdXzEChIA2ZRw9M501QZgn/pT/ic43XsC5QtNaSNtvbMgv
         v1YU6YtmrPwv1h1uQ0DKgVJv7SVfgs6rJWn35zw3YetUl5dgI17n6sSvMCRh97TawdqH
         0PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BlI6sZ67WAPyiOAfEubsTr6KMfHjrMipPMRsWQXJc3k=;
        b=Yw/TQ8lkp3ah6LirdWsfGvxK70+wmup2lSyvuUY7GgqcMdyelZYLVIVJhNBPt5nEab
         N0PbqGB00wR0WTB4UkB86EEUDhAjsFfByKllFuYrAoz9YO543d+XblMM+DN46xZqlmk/
         +yajo0wJeYQFt10SpSz9qgDvNiERGaW5V1ifUNjgjC+SRbwyeWdA7SYsC+MZyB41P1Nq
         uApXxuV7niX3VS96NV/w7ElOrc+6CKinTD4A0svEqY8Q03tOz3y4sisqPh+D0npQqEYs
         qftxZYV96ALS607HF1QmkuCgvdj/NMUcIUYz0on5x/Z+3ixAGqRgfFLUd3QoLoelEXSt
         EjaA==
X-Gm-Message-State: APt69E02hp8J/PodLkod9qsasMu/i01fuWoPdD+6ZjGg6F1ILOtOB/9U
        xCbtJquklCftNoZTSnjsloc=
X-Google-Smtp-Source: ADUXVKJPZQIh9pHA0WOSsqwXcZva5fB9jX5MSOEPgz8ZGdaInDSZ5k4rvTiJVYTgtGS12kRJIIyneg==
X-Received: by 2002:a62:4a0c:: with SMTP id x12-v6mr25567975pfa.142.1529550462769;
        Wed, 20 Jun 2018 20:07:42 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:1:4413:35c0:9e91:c7fc:672])
        by smtp.gmail.com with ESMTPSA id o66-v6sm6296117pfi.157.2018.06.20.20.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 20:07:42 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com,
        gregkh@linuxfoundation.org, jthumshirn@suse.de,
        pombredanne@nexb.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] mm: mempool: Fix a possible sleep-in-atomic-context bug in mempool_resize()
Date:   Thu, 21 Jun 2018 11:07:14 +0800
Message-Id: <20180621030714.10368-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep with holding a spinlock.
The function call path (from bottom to top) in Linux-4.16.7 is:

[FUNC] remove_element(GFP_KERNEL)
mm/mempool.c, 250: remove_element in mempool_resize
mm/mempool.c, 247: _raw_spin_lock_irqsave in mempool_resize

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool (DSAC-2) and checked by
my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 mm/mempool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 5c9dce34719b..d33bd5d622e7 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -247,7 +247,7 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 	spin_lock_irqsave(&pool->lock, flags);
 	if (new_min_nr <= pool->min_nr) {
 		while (new_min_nr < pool->curr_nr) {
-			element = remove_element(pool, GFP_KERNEL);
+			element = remove_element(pool, GFP_ATOMIC);
 			spin_unlock_irqrestore(&pool->lock, flags);
 			pool->free(element, pool->pool_data);
 			spin_lock_irqsave(&pool->lock, flags);
-- 
2.17.0

