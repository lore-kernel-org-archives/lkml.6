Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E45ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA70420875
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA70420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeGMOWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:22:19 -0400
Received: from mleia.com ([178.79.152.223]:37808 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbeGMOWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:22:19 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id A638A4065E7;
        Fri, 13 Jul 2018 15:07:30 +0100 (BST)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] block: remove blkdev_entry_to_request() macro
Date:   Fri, 13 Jul 2018 17:07:26 +0300
Message-Id: <20180713140726.20897-1-vz@mleia.com>
X-Mailer: git-send-email 2.10.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180713_150730_700546_5EE96995 
X-CRM114-Status: UNSURE (   6.84  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove blkdev_entry_to_request() macro, which remained unused through
the observable history, also note that it repeats list_entry_rq() macro
verbatim.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 include/linux/blkdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 79226ca..eb101fd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1437,8 +1437,6 @@ enum blk_default_limits {
 	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
 };
 
-#define blkdev_entry_to_request(entry) list_entry((entry), struct request, queuelist)
-
 static inline unsigned long queue_segment_boundary(struct request_queue *q)
 {
 	return q->limits.seg_boundary_mask;
-- 
2.10.2

