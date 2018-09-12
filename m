Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4792C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486612146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv57VbzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486612146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeIMEer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:34:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36507 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeIMEer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:34:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so1815058pgo.3;
        Wed, 12 Sep 2018 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vs4YyhejtDKH9r2Qa3CKRSMDHO1yV5loU/P6gGYpzSo=;
        b=lv57VbzSVKZFygcTmKXv51UHq8t92WUQq1mfOBlUnU9Gb72U1zz0jikIsoWmaBk5FV
         HUgU1yJtdWWucf+ezD5WeYKUjxhF5+DtC/Nih4WTVNsYVK3kG/ANaNZlRszleJ0kuhGV
         bGozcSNkq+GXqQ/+1hLvw/rwQwYBEPmYvTTb7BSPGIVvqJgAdLEGkp5xpL+uk3jLDqWy
         TodCKAoqJJNyU1WwkGoat8bgyJw/nbzv6fQ0XlUra9cZiA0SQQn9vvGuGW2iulQr4Ta6
         anG/Rv3Mk6qiLQNdhxyp3EIC/vYfFAwKYVvwk5zW5T7IqlB3zE00t9tnEXL0f8vxrcNx
         2vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vs4YyhejtDKH9r2Qa3CKRSMDHO1yV5loU/P6gGYpzSo=;
        b=npiHYGjLvSMZtDVvXP3w8qR0nGXyRk3XGXEOsUwACmUD7VuBib2j7oLd4Fv9noaf0n
         s9WEkIxluD6bhh2VJRbBd5pvYNbUTIZf9YL5QEwaH+9rsDLFYdE8YN5n5h439HMdGYyi
         77ZhWB93wC5z5Olw/zgvFQEt3NBlZKEHVozZJFuBas8vNmvvQqzLcNp1YzYDAkehApQr
         TUpu05Y4yPBszGUWnULPQKrASSJhfcJpeGoFyTs0zbbM/YNnbeQ33ZstUK7b0drBtUeF
         InvFZ+HPit3qAsmYGpR7K+obti8BpygPqVWJu4wOZneElM8MX3kA48K229Fj9F2EDwuw
         IIEQ==
X-Gm-Message-State: APzg51AIps5g5r2GaYcuxJ56UsY/fB1MN+eIylT2/Yhsu2UpuNoeASeT
        1cxrAq4xX9APQsf076hpB0rbg6zT
X-Google-Smtp-Source: ANB0VdZk/4x2cd1VWhNZo7EUUcM2+31H8AsQGlfpKgWTLTLm6QGnYHmU1teOnjLfwP5xcA2ywX5DAA==
X-Received: by 2002:a62:8913:: with SMTP id v19-v6mr4674738pfd.127.1536794880812;
        Wed, 12 Sep 2018 16:28:00 -0700 (PDT)
Received: from tw-172-25-29-37.office.twttr.net ([8.25.197.25])
        by smtp.gmail.com with ESMTPSA id e26-v6sm2858123pfi.70.2018.09.12.16.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 16:28:00 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] ucma: fix a use-after-free in ucma_resolve_ip()
Date:   Wed, 12 Sep 2018 16:27:44 -0700
Message-Id: <20180912232744.12693-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition between ucma_close() and ucma_resolve_ip():

CPU0				CPU1
ucma_resolve_ip():		ucma_close():

ctx = ucma_get_ctx(file, cmd.id);

        list_for_each_entry_safe(ctx, tmp, &file->ctx_list, list) {
                mutex_lock(&mut);
                idr_remove(&ctx_idr, ctx->id);
                mutex_unlock(&mut);
		...
                mutex_lock(&mut);
                if (!ctx->closing) {
                        mutex_unlock(&mut);
                        rdma_destroy_id(ctx->cm_id);
		...
                ucma_free_ctx(ctx);

ret = rdma_resolve_addr();
ucma_put_ctx(ctx);

Before idr_remove(), ucma_get_ctx() could still find the ctx
and after rdma_destroy_id(), rdma_resolve_addr() may still
access id_priv pointer. Also, ucma_put_ctx() may use ctx after
ucma_free_ctx() too.

ucma_close() should call ucma_put_ctx() too which tests the
refcnt and waits for the last one releasing it. The similar
pattern is already used by ucma_destroy_id().

Reported-and-tested-by: syzbot+da2591e115d57a9cbb8b@syzkaller.appspotmail.com
Reported-by: syzbot+cfe3c1e8ef634ba8964b@syzkaller.appspotmail.com
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/infiniband/core/ucma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 5f437d1570fb..21863ddde63e 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1759,6 +1759,8 @@ static int ucma_close(struct inode *inode, struct file *filp)
 		mutex_lock(&mut);
 		if (!ctx->closing) {
 			mutex_unlock(&mut);
+			ucma_put_ctx(ctx);
+			wait_for_completion(&ctx->comp);
 			/* rdma_destroy_id ensures that no event handlers are
 			 * inflight for that id before releasing it.
 			 */
-- 
2.14.4

