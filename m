Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0D8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5969B219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5969B219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeHFE5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:57:45 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:45866 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeHFE5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:57:45 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 592B9C1FB846F6E53185;
        Mon,  6 Aug 2018 10:50:48 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w762oZGB066303;
        Mon, 6 Aug 2018 10:50:35 +0800 (GMT-8)
        (envelope-from liu.song11@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018080610503711-3252291 ;
          Mon, 6 Aug 2018 10:50:37 +0800 
From:   Liu Song <liu.song11@zte.com.cn>
To:     richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        liu.song11@zte.com.cn, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH] Simplify redundant code
Date:   Mon, 6 Aug 2018 10:49:06 +0800
Message-Id: <1533523746-13197-1-git-send-email-liu.song11@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-06 10:50:37,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-06 10:50:36,
        Serialize complete at 2018-08-06 10:50:36
X-MAIL: mse01.zte.com.cn w762oZGB066303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cbuf's size can be simply assigned.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 fs/ubifs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index c5466c7..1a8e2032 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1245,8 +1245,7 @@ static int mount_ubifs(struct ubifs_info *c)
 	if (err)
 		goto out_free;
 
-	sz = ALIGN(c->max_idx_node_sz, c->min_io_size);
-	sz = ALIGN(sz + c->max_idx_node_sz, c->min_io_size);
+	sz = ALIGN(c->max_idx_node_sz, c->min_io_size) * 2;
 	c->cbuf = kmalloc(sz, GFP_NOFS);
 	if (!c->cbuf) {
 		err = -ENOMEM;
-- 
2.1.0.GIT

