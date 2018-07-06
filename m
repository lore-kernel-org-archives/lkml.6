Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C7FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E15F2241F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4Mi1Doi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E15F2241F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeGFPY4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:24:56 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:55998 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932590AbeGFPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:24:54 -0400
Received: by mail-ua0-f201.google.com with SMTP id r19-v6so3516200ual.22
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=KUWHNZHeagj/CL6Y8XcnSsfnsgIezm6BP2wsPXYz0LA=;
        b=d4Mi1DoiI0wnRn2TLfG6L7Z1iaC+ATIk2yqlS9uj6xIGYX3KoMKY4Fx1iwssnE8qUF
         L3K/AHYDihvy6B5U3dcfwi9s/swgeqRyuPIbBBeC6L86FC6SYaYys2EGc+3ykqCG5EDw
         v4Abn1w4nEYvmlOGv2wdaeejQSAa6+o+sVu7aAypkVqOvtkk4Z1Nt2yYtWDAtZUHgLPV
         KWet3YTsDAw5YqhCyGsoMCiIm45uUWEET1lWRbDhAx+XCMpXG99aUQwa25d+T0ddmB7j
         6Z9z8l4uwnnAYoJ8/P/VyhwD/UcxPxH/blJMixZFDaPEqNOZbqc8tPwUyPLM9cqY8DXM
         do5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=KUWHNZHeagj/CL6Y8XcnSsfnsgIezm6BP2wsPXYz0LA=;
        b=sgwBAN3KmRDqJL11IpgvA9o9Tnks2IqRLVJd2qMXWqUCcOa8+z/EgkTcqFXLcoSuRS
         8ZY0kTLzgEm7+03J/qhAUEtOjsDW/vRNfu8LHXPNVyuX4BaxpHN0wnv65zsOq1ireJyM
         +690XkPOFJegi5+3bJGcCSoo+wg8+4bklUnzh1TTsQcMTtY+1+QIp32FKFn1qTdlba+M
         RI9hcsoQSGMYVtBoTcIi82NbyZLTr3SP/9tYDHKX1M4pMRuw/LoE9erDJI2EdUK0pLY4
         mHDpoXoYt9+xRTbUK3ETQt6pe1RvMmlXuE/AkNEEcM+JCa8Rhgpxhm/tJTWzaz54XByB
         kQqg==
X-Gm-Message-State: APt69E25//9lYN7YjydOjSldp4/lmrfbLJc61t4s7yE6V1Nu0L1aOc5K
        kbeO9z2RCE0bkzuqQKG+9v1Sbl8FFw==
X-Google-Smtp-Source: AAOMgpeR/zSK+wlZSUl/nVjG+EKjlTTLSCWKDhKGdtJedqB6nBMG7goIqdii74RlQg+FsevsiwKCX35CJg==
MIME-Version: 1.0
X-Received: by 2002:a1f:3897:: with SMTP id f145-v6mr4618995vka.125.1530890694132;
 Fri, 06 Jul 2018 08:24:54 -0700 (PDT)
Date:   Fri,  6 Jul 2018 17:24:49 +0200
Message-Id: <20180706152449.33415-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH] IB/mlx5: fix uaccess beyond "count" in debugfs read handlers
From:   Jann Horn <jannh@google.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, jannh@google.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, accessing userspace memory beyond the length of the supplied
buffer in VFS read/write handlers can lead to both kernel memory corruption
(via kernel_read()/kernel_write(), which can e.g. be triggered via
sys_splice()) and privilege escalation inside userspace.

In this case, the affected files are in debugfs (and should therefore only
be accessible to root) and check that *pos is zero (which prevents the
sys_splice() trick). Therefore, this is not a security fix, but rather a
small cleanup.

Fix it by using simple_read_from_buffer() instead of custom logic.

Fixes: 4a2da0b8c078 ("IB/mlx5: Add debug control parameters for congestion control")
Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/infiniband/hw/mlx5/cong.c |  9 +--------
 drivers/infiniband/hw/mlx5/mr.c   | 20 ++------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cong.c b/drivers/infiniband/hw/mlx5/cong.c
index 985fa2637390..7e4e358a4fd8 100644
--- a/drivers/infiniband/hw/mlx5/cong.c
+++ b/drivers/infiniband/hw/mlx5/cong.c
@@ -359,9 +359,6 @@ static ssize_t get_param(struct file *filp, char __user *buf, size_t count,
 	int ret;
 	char lbuf[11];
 
-	if (*pos)
-		return 0;
-
 	ret = mlx5_ib_get_cc_params(param->dev, param->port_num, offset, &var);
 	if (ret)
 		return ret;
@@ -370,11 +367,7 @@ static ssize_t get_param(struct file *filp, char __user *buf, size_t count,
 	if (ret < 0)
 		return ret;
 
-	if (copy_to_user(buf, lbuf, ret))
-		return -EFAULT;
-
-	*pos += ret;
-	return ret;
+	return simple_read_from_buffer(buf, count, pos, lbuf, ret);
 }
 
 static const struct file_operations dbg_cc_fops = {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 90a9c461cedc..37847add6f74 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -310,19 +310,11 @@ static ssize_t size_read(struct file *filp, char __user *buf, size_t count,
 	char lbuf[20];
 	int err;
 
-	if (*pos)
-		return 0;
-
 	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->size);
 	if (err < 0)
 		return err;
 
-	if (copy_to_user(buf, lbuf, err))
-		return -EFAULT;
-
-	*pos += err;
-
-	return err;
+	return simple_read_from_buffer(buf, count, pos, lbuf, err);
 }
 
 static const struct file_operations size_fops = {
@@ -372,19 +364,11 @@ static ssize_t limit_read(struct file *filp, char __user *buf, size_t count,
 	char lbuf[20];
 	int err;
 
-	if (*pos)
-		return 0;
-
 	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->limit);
 	if (err < 0)
 		return err;
 
-	if (copy_to_user(buf, lbuf, err))
-		return -EFAULT;
-
-	*pos += err;
-
-	return err;
+	return simple_read_from_buffer(buf, count, pos, lbuf, err);
 }
 
 static const struct file_operations limit_fops = {
-- 
2.18.0.399.gad0ab374a1-goog

