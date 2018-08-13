Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49653C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E108A217C5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E108A217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeHMP5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:57:13 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:42074 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeHMP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:57:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 98D7B181A6CA7;
        Mon, 13 Aug 2018 15:14:58 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubifs: Add comment on c->commit_sem
Date:   Mon, 13 Aug 2018 15:14:45 +0200
Message-Id: <20180813131445.5656-1-richard@nod.at>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every single time I come across that code, I get confused
because it looks like a possible dead lock.
Help myself by adding a comment.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 95665eba2b70..c913f36d6c21 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -328,6 +328,7 @@ again:
 	down_read(&c->commit_sem);
 	err = reserve_space(c, jhead, len);
 	if (!err)
+		/* c->commit_sem will get released via finish_reservation(). */
 		return 0;
 	up_read(&c->commit_sem);
 
-- 
2.18.0

