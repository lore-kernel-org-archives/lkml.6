Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A6DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 03:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452C220C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 03:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452C220C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeHTHJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 03:09:59 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:45696 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbeHTHJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 03:09:59 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 5A2D61AAAAEC28B3C5BB;
        Mon, 20 Aug 2018 11:56:00 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7K3tt4c092739;
        Mon, 20 Aug 2018 11:55:55 +0800 (GMT-8)
        (envelope-from liu.song11@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018082011555651-5216529 ;
          Mon, 20 Aug 2018 11:55:56 +0800 
From:   Liu Song <liu.song11@zte.com.cn>
To:     richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        liu.song11@zte.com.cn, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH] UBIFS: Fix typo of output in get_cs_sqnum
Date:   Mon, 20 Aug 2018 11:54:30 +0800
Message-Id: <1534737270-143176-1-git-send-email-liu.song11@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-20 11:55:56,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-20 11:55:55,
        Serialize complete at 2018-08-20 11:55:55
X-MAIL: mse01.zte.com.cn w7K3tt4c092739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Not a CS node" makes more sense than "Node a CS node".

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 fs/ubifs/recovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index 3af4472061cc..400163dc7022 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -829,7 +829,7 @@ static int get_cs_sqnum(struct ubifs_info *c, int lnum, int offs,
 		goto out_err;
 	}
 	if (cs_node->ch.node_type != UBIFS_CS_NODE) {
-		ubifs_err(c, "Node a CS node, type is %d", cs_node->ch.node_type);
+		ubifs_err(c, "Not a CS node, type is %d", cs_node->ch.node_type);
 		goto out_err;
 	}
 	if (le64_to_cpu(cs_node->cmt_no) != c->cmt_no) {
-- 
2.17.1

