Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2921C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4EC20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4EC20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeGZAtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:49:50 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:40768 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731370AbeGZAtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:49:50 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 692E0F515ED87F742BD2;
        Thu, 26 Jul 2018 07:35:48 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6PNZiaC088258;
        Thu, 26 Jul 2018 07:35:44 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072607354961-1838980 ;
          Thu, 26 Jul 2018 07:35:49 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        hillf.zj@alibaba-inc.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH] mm/vmscan: fix page_freeze_refs in comment.
Date:   Thu, 26 Jul 2018 07:34:17 +0800
Message-Id: <1532561657-98783-1-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-26 07:35:49,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-26 07:35:32,
        Serialize complete at 2018-07-26 07:35:32
X-MAIL: mse01.zte.com.cn w6PNZiaC088258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_freeze_refs has already been relplaced by page_ref_freeze, but
it is not modified in the comment.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f8..d29e207 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -744,7 +744,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		refcount = 2;
 	if (!page_ref_freeze(page, refcount))
 		goto cannot_free;
-	/* note: atomic_cmpxchg in page_freeze_refs provides the smp_rmb */
+	/* note: atomic_cmpxchg in page_refs_freeze provides the smp_rmb */
 	if (unlikely(PageDirty(page))) {
 		page_ref_unfreeze(page, refcount);
 		goto cannot_free;
-- 
2.7.4

