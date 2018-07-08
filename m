Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C18C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B72208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B72208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeGHVY4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:24:56 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:44426 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933255AbeGHVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:24:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 5DFC518186369;
        Sun,  8 Jul 2018 23:24:53 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubifs: gc: Fix typo
Date:   Sun,  8 Jul 2018 23:24:46 +0200
Message-Id: <20180708212446.23996-1-richard@nod.at>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBIFS operates on LEBs, not PEBs.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 11c09ce3c795..a57be0b698b5 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -483,7 +483,7 @@ int ubifs_garbage_collect_leb(struct ubifs_info *c, struct ubifs_lprops *lp)
 			/*
 			 * Write buffers must be sync'd before unmapping
 			 * freeable LEBs, because one of them may contain data
-			 * which obsoletes something in 'lp->pnum'.
+			 * which obsoletes something in 'lp->lnum'.
 			 */
 			err = gc_sync_wbufs(c);
 			if (err)
-- 
2.18.0

