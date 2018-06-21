Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2D5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB79F208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMDpKF8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB79F208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFUHDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:03:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39930 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbeFUHDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:03:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id r11-v6so1049615pfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=szKF+gnXyFXIku5VW3IbELUbDP8o2QPq0Oibn8D+kV0=;
        b=OMDpKF8FnmTzindIV3XU62gZHNXA6nApVy4lSfU/29dt5YV2YZV0SojHimfTeVnT/O
         ncyT1neuWXzqB4UX8qY9q9g11EpwMFCmsWSZHJ2MR8uec8Iy4Clv02S9fm/jTv5G2fb4
         lNs5OXM7Xu45cOqkhTaZXsTyp+oTt5W6IaXri0lhKxKQP+phfc3hUJcTSH3LegGJzWaH
         0KIQsUbzYLwJ64YyU8szK5MKx1jbypkTk4vjFx3/ljf3L/EZIEMgwy4dRuSjENh10Ojf
         AGskvifSuzDa2YBsncesI+6CzG1iEFVODmjXi6QZ+erXWOLYmn+AVX2PEuV87MKGXkrR
         a5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=szKF+gnXyFXIku5VW3IbELUbDP8o2QPq0Oibn8D+kV0=;
        b=L72XjfuIoQutOosuvcjr+CsYl8lOPiwVZe7NbF19W2wbqipRhwt+9QtRB+WfymTd4n
         5py09/cUW+z7gUbu7oh9iWJZwTLWUkay5eJTQKAm/wi3p1wjxsCMbFUtuOPTZ5xMhscp
         ACWIlbb5CplKtrqA/5BHnIL2sMpehLMGKpe6OD8hupq/nk78cYvgkr2nLwBZRZj8ZQdu
         u0gvqBmIS9DOvSPyELo0LGUtazO/I8GfuBVDjT0RvB2rdHnavU3O4M34boG5LGkvDqne
         S7eDKRKg86h0Aaiu2BXRv1UvCmrcV37S0yQ1Ls21Qbt3xw0gvhupwcomzFUGjWCrWdbU
         86Uw==
X-Gm-Message-State: APt69E2s9xjqZyDwC1o/mfl9zKyHyIGHJUE1J2tYf5XorQ7pm5x+4lid
        ieFYrlFKpgaumaLqBCWN1b4=
X-Google-Smtp-Source: ADUXVKKR5dsyFYEF0nX5/+tHzGdweS+hh1nnWXwkG4R+OfdEVhlASh+SI4n95WDFkGxLwSlYucM6Yw==
X-Received: by 2002:a62:67c5:: with SMTP id t66-v6mr26293032pfj.20.1529564619802;
        Thu, 21 Jun 2018 00:03:39 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:1:4413:35c0:9e91:c7fc:672])
        by smtp.gmail.com with ESMTPSA id u1-v6sm6053427pfn.59.2018.06.21.00.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 00:03:39 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     akpm@linux-foundation.org, jthumshirn@suse.de, cl@linux.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, dvyukov@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] mm: mempool: Remove unused argument in kasan_unpoison_element() and remove_element()
Date:   Thu, 21 Jun 2018 15:03:32 +0800
Message-Id: <20180621070332.16633-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The argument "gfp_t flags" is not used in kasan_unpoison_element() 
and remove_element(), so remove it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 mm/mempool.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 5c9dce34719b..3076ab3f7bc4 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -111,7 +111,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 		kasan_free_pages(element, (unsigned long)pool->pool_data);
 }
 
-static void kasan_unpoison_element(mempool_t *pool, void *element, gfp_t flags)
+static void kasan_unpoison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
 		kasan_unpoison_slab(element);
@@ -127,12 +127,12 @@ static __always_inline void add_element(mempool_t *pool, void *element)
 	pool->elements[pool->curr_nr++] = element;
 }
 
-static void *remove_element(mempool_t *pool, gfp_t flags)
+static void *remove_element(mempool_t *pool)
 {
 	void *element = pool->elements[--pool->curr_nr];
 
 	BUG_ON(pool->curr_nr < 0);
-	kasan_unpoison_element(pool, element, flags);
+	kasan_unpoison_element(pool, element);
 	check_element(pool, element);
 	return element;
 }
@@ -151,7 +151,7 @@ void mempool_destroy(mempool_t *pool)
 		return;
 
 	while (pool->curr_nr) {
-		void *element = remove_element(pool, GFP_KERNEL);
+		void *element = remove_element(pool);
 		pool->free(element, pool->pool_data);
 	}
 	kfree(pool->elements);
@@ -247,7 +247,7 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 	spin_lock_irqsave(&pool->lock, flags);
 	if (new_min_nr <= pool->min_nr) {
 		while (new_min_nr < pool->curr_nr) {
-			element = remove_element(pool, GFP_KERNEL);
+			element = remove_element(pool);
 			spin_unlock_irqrestore(&pool->lock, flags);
 			pool->free(element, pool->pool_data);
 			spin_lock_irqsave(&pool->lock, flags);
@@ -333,7 +333,7 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 
 	spin_lock_irqsave(&pool->lock, flags);
 	if (likely(pool->curr_nr)) {
-		element = remove_element(pool, gfp_temp);
+		element = remove_element(pool);
 		spin_unlock_irqrestore(&pool->lock, flags);
 		/* paired with rmb in mempool_free(), read comment there */
 		smp_wmb();
-- 
2.17.0

