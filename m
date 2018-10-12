Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B1DC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D1420868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CixZwotb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D1420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeJME7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:59:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44440 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeJME7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:59:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id p25-v6so6472793pli.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=LF/YoHEd6r00UlYo875GaIQxjYz0VZX1XmCm0FXDGnY=;
        b=CixZwotbFH8KgYAAQfsjqqPc8VX4nNMA3w3JlMX9LFnULIo2RvcC5Xa0rVBeVHRS7M
         THTu8xr5tkBslxN+iZkx/zAVU2oGvto3o4nw9bDs4jYrosdllNKh2yRNeIx2gR9SsGT6
         DqEJtkPXG6FhZGx1WwlhqrLposZKAqyW3Cqu7CGcOufea11aJpb2bJ4tajgLYwZbFfhi
         fpz797F46bZshzvh8nTRYtlwTiZXdSNeR5YClakfoCwc1wbaDVrg8Fcjt4gbUuCxEIw1
         JsdCHluRL6h1I9+i2KeTsfCkjth5tIl5tI85Ttgcos6r6hRrlx/Y4i06ub6uWPeUGOTz
         IUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=LF/YoHEd6r00UlYo875GaIQxjYz0VZX1XmCm0FXDGnY=;
        b=GMwC1k5OPYAiHVb6njSpgZOTu3BjjLbmD8VZAgFAjNpB97VwQ+EEOx4KSjvCDOflYN
         Z/M3OHzdiTpGT/jT/YcdaOSiiv6jfUtuKvI4LLlvP84JNKVw8ygveiidBbcRAl0oR/uf
         5zo/9e8oVUUjDY8E5Hirp5A/hubm38UyMzcN+6jzXx/xW+etliNAj8lmEozf75asKvTJ
         u/sZYa87k5W4MSgELyAUL8IrAwVjN0F92dbZqVJ4m5shBjPnNXgBcqIuRlywtyiQz6Pw
         eJTSDMJweOgiVPJfsfMplPPqRllRnQf6BgK/feG+AkU48OwQ4dcHHE6j7R13bh+0UBGO
         v9EA==
X-Gm-Message-State: ABuFfohbtNyuLYef3O/Q2rC1UYhYkc6vA3yUwxaMBunn9fvCHg+XGQW/
        dYX/pxwJLkezxNkyBsTtG4BUog==
X-Google-Smtp-Source: ACcGV61ZNx1mUBELOUYEHjUrEGA4ZFvKoEeT5JrrP495aULPzFHQxGuPrff/j0QsJYYmMhZEhqkruQ==
X-Received: by 2002:a17:902:74c2:: with SMTP id f2-v6mr7269417plt.45.1539379499023;
        Fri, 12 Oct 2018 14:24:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g3-v6sm2981344pgn.37.2018.10.12.14.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 14:24:58 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:24:57 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [patch] mm, slab: avoid high-order slab pages when it does not reduce
 waste
Message-ID: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The slab allocator has a heuristic that checks whether the internal
fragmentation is satisfactory and, if not, increases cachep->gfporder to
try to improve this.

If the amount of waste is the same at higher cachep->gfporder values,
there is no significant benefit to allocating higher order memory.  There
will be fewer calls to the page allocator, but each call will require
zone->lock and finding the page of best fit from the per-zone free areas.

Instead, it is better to allocate order-0 memory if possible so that pages
can be returned from the per-cpu pagesets (pcp).

There are two reasons to prefer this over allocating high order memory:

 - allocating from the pcp lists does not require a per-zone lock, and

 - this reduces stranding of MIGRATE_UNMOVABLE pageblocks on pcp lists
   that increases slab fragmentation across a zone.

We are particularly interested in the second point to eliminate cases
where all other pages on a pageblock are movable (or free) and fallback to
pageblocks of other migratetypes from the per-zone free areas causes
high-order slab memory to be allocated from them rather than from free
MIGRATE_UNMOVABLE pages on the pcp.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/slab.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1748,6 +1748,7 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
 	for (gfporder = 0; gfporder <= KMALLOC_MAX_ORDER; gfporder++) {
 		unsigned int num;
 		size_t remainder;
+		int order;
 
 		num = cache_estimate(gfporder, size, flags, &remainder);
 		if (!num)
@@ -1803,6 +1804,20 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
 		 */
 		if (left_over * 8 <= (PAGE_SIZE << gfporder))
 			break;
+
+		/*
+		 * If a higher gfporder would not reduce internal fragmentation,
+		 * no need to continue.  The preference is to keep gfporder as
+		 * small as possible so slab allocations can be served from
+		 * MIGRATE_UNMOVABLE pcp lists to avoid stranding.
+		 */
+		for (order = gfporder + 1; order <= slab_max_order; order++) {
+			cache_estimate(order, size, flags, &remainder);
+			if (remainder < left_over)
+				break;
+		}
+		if (order > slab_max_order)
+			break;
 	}
 	return left_over;
 }
