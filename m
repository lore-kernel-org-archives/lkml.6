Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D215C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3582086B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Agze0mcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3582086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeICVPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:15:19 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:40491 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeICVPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:15:19 -0400
Received: by mail-yw1-f73.google.com with SMTP id t10-v6so733963ywc.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rKnFvMPLRLhE5B5/9VShTn+eOMor9sot1Cueho2TCcU=;
        b=Agze0mcJPbqpM6gmxBFC0mqR9GOrsH8ZXgjX4HVsJrqhQ8f4I4CB4wyye8/Q4654+8
         eDkUQ2dAwr2agGQfJgaXvz4Lyg4km0uqf3yyXEwv4YlTnlGbbMGCq/6KqxiiV1uhbprl
         cJeGdZuEhw+9Ji+hltt32duCbvxVqdZeYOC+MK9x6d2RNiKeOKzjaUGFkGFWo1dDflYA
         TwaK16xwaYoUbaFtldbHylg4GyFryIg+BDg/2xhK1CRujgSGKy05GZ4YpYEMKPleQ7yX
         jvUuy9D1WFVYW84p689J8ZG9W6fBVSM5dsFhmAIWEVSDbHlqNQX8mDO19/vuhM+ALsvY
         GfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rKnFvMPLRLhE5B5/9VShTn+eOMor9sot1Cueho2TCcU=;
        b=UPVu2ZtPpFx0DHUqEQmFjKrrq0ku53PNF8m9l3YJv04Clj080xt88/27s4doyIuHDk
         OD5FlpjUahRelhz2R6rqNZ/tsiO+nQhbRuLV9V+/vrNRMSnKyoA6Q4FY/2Woz17fUWvP
         k1JwPMVT+rOezb4AzlMBHkWhLSPcKjN0IRZD/ELAvYIjIuCo2n/R7zWYmRRoGlFNV6gj
         z+CVMXCiNoxAf5vnOZdG6RfXujZzPpwGQ5I/myY8nu/CcPYoLCC+VkZiAbGHtx4ZgNc7
         j8BmhsONdJc3wPGR6U1HiIqhaxOmgUZhUyNuL255dgU76AfIQWrUThg1HhY9Etx0x4kv
         IxOQ==
X-Gm-Message-State: APzg51A/u8RNp6vFbNS96WtHI40sncvSkjgY5Lq9I1o8Iqkcq2c/dpBT
        BNjthra/EdU6Ljp0LglsBWUQ8uRHVw==
X-Google-Smtp-Source: ANB0Vdb61QBXMDQJyTa7VqNltrJGT6eC7zhAOJCZqM+Br80Z2ApCVAvUTp/KQQdpyMQpc1BEKq6Qvjv/Lw==
X-Received: by 2002:a81:5713:: with SMTP id l19-v6mr8279136ywb.26.1535993661631;
 Mon, 03 Sep 2018 09:54:21 -0700 (PDT)
Date:   Mon,  3 Sep 2018 18:54:14 +0200
Message-Id: <20180903165414.248309-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH] RDMA/ucma: check fd type in ucma_migrate_id()
From:   Jann Horn <jannh@google.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, jannh@google.com
Cc:     linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code grabs the private_data of whatever file descriptor
userspace has supplied and implicitly casts it to a `struct ucma_file *`,
potentially causing a type confusion.

This is probably fine in practice because the pointer is only used for
comparisons, it is never actually dereferenced; and even in the
comparisons, it is unlikely that a file from another filesystem would have
a ->private_data pointer that happens to also be valid in this context.
But ->private_data is not always guaranteed to be a valid pointer to an
object owned by the file's filesystem; for example, some filesystems just
cram numbers in there.

Check the type of the supplied file descriptor to be safe, analogous to how
other places in the kernel do it.

Fixes: 88314e4dda1e ("RDMA/cma: add support for rdma_migrate_id()")
Signed-off-by: Jann Horn <jannh@google.com>
---
Only compile-tested, because I don't have an environment in which I
could test this.

 drivers/infiniband/core/ucma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index ec8fb289621f..5f437d1570fb 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -124,6 +124,8 @@ static DEFINE_MUTEX(mut);
 static DEFINE_IDR(ctx_idr);
 static DEFINE_IDR(multicast_idr);
 
+static const struct file_operations ucma_fops;
+
 static inline struct ucma_context *_ucma_find_context(int id,
 						      struct ucma_file *file)
 {
@@ -1581,6 +1583,10 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 	f = fdget(cmd.fd);
 	if (!f.file)
 		return -ENOENT;
+	if (f.file->f_op != &ucma_fops) {
+		ret = -EINVAL;
+		goto file_put;
+	}
 
 	/* Validate current fd and prevent destruction of id. */
 	ctx = ucma_get_ctx(f.file->private_data, cmd.id);
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

