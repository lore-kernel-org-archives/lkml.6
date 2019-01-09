Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691EDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C792146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfAIC43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:56:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbfAIC42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:56:28 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 51E308BAB234272D1035;
        Wed,  9 Jan 2019 10:56:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 9 Jan 2019 10:56:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mm, compaction: remove set but not used variables 'a, b, c'
Date:   Wed, 9 Jan 2019 03:02:47 +0000
Message-ID: <1547002967-6127-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

mm/compaction.c: In function 'compact_zone':
mm/compaction.c:2063:22: warning:
 variable 'c' set but not used [-Wunused-but-set-variable]
mm/compaction.c:2063:19: warning:
 variable 'b' set but not used [-Wunused-but-set-variable]
mm/compaction.c:2063:16: warning:
 variable 'a' set but not used [-Wunused-but-set-variable]

This never used since 94d5992baaa5 ("mm, compaction: finish pageblock
scanning on contention")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/compaction.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index f73fe07..529f19a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2060,7 +2060,6 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
-	unsigned long a, b, c;
 
 	cc->migratetype = gfpflags_to_migratetype(cc->gfp_mask);
 	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
@@ -2106,10 +2105,6 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 			cc->whole_zone = true;
 	}
 
-	a = cc->migrate_pfn;
-	b = cc->free_pfn;
-	c = (cc->free_pfn - cc->migrate_pfn) / pageblock_nr_pages;
-
 	last_migrated_pfn = 0;
 
 	/*



