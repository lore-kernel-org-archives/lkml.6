Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F287C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0256322BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttrt2y8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0256322BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934448AbeGFUsM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:48:12 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:41032 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933833AbeGFUsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:48:10 -0400
Received: by mail-yb0-f201.google.com with SMTP id s46-v6so11228743ybe.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=UdIVhqKshfapI0b3L3MMkWLnlZm4PWM7dqfeHLlrp7Q=;
        b=ttrt2y8CfvzN5D2C1R3DxZv7gGFEfrVnWx9Om/2KT/xhsRMcaJ5Zp90HAWchOBA2jT
         3jPv+OcLywx6ydHPDKKpxrbAT+nNMkabizddGcOIk0mgqoW7CGi6uY5e8hyjnBkZtCAi
         V14JdP/4jPKLqvZmBpOxCzR5ADs9EIwJ8CynPGoVMkySLX1eMF4HKMEem2QwUWhWvJUt
         8qOtDC76OoyB9FbKji3ARnx/RgAX0KxxyaqzTQR1VNB+lXeqnb+GcCsJGyprOfocnnAg
         LLzHcgS0ucdKi9uN8stisiktb5IRwOLRL0fBt5tDr9fc80PhXvEOjNMakW4HF1oAFLhh
         Hj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=UdIVhqKshfapI0b3L3MMkWLnlZm4PWM7dqfeHLlrp7Q=;
        b=hcVJnpiTsdcgBhAAKKUo0m/3778BC7IJK0oY7UD36Z4D9mxv1RJuPH90PHt8bXtUBq
         s48OCOaWm2rw4eXIhjiemMy6jEmyGBMCqKJ6qDE/D4HETGIL5p5cW/BCSlhidy2eSDr1
         L8AbDAwfZXUf8X9BNWKhzENTMtOKmXXXa90Kh/tbWQgAVXreunLz2xEbo2X4F8Rg/FWU
         sXp83mxJ/mwKA3NCAq/s5Z2bF4b/WcTYlzeVRbY9LS3qdS0ZfwemXQMWrkfL61CIi5Na
         QQ1LMKjQFIEMgaXRYEzqExT5n6CI5gORYkNsLiTa3SrBgYySFk7lQvxWQQ3vLJILZcww
         Yyvw==
X-Gm-Message-State: APt69E1DtZkTSKDLlqkWmWYN2asUgw5rgZ2jlw3CDJhT50cdgSActXVh
        kYNy4C0KPfONZpMakzUE0QTzgkm0oA==
X-Google-Smtp-Source: AAOMgpeKhrQV6gqo9QZPAHfsWUuh4Jiz7h5VHtjy9/VIh9CJSEej+1pCVcCfW9MjQifLHCqoAbODVJSAWw==
MIME-Version: 1.0
X-Received: by 2002:a0d:c901:: with SMTP id l1-v6mr3738708ywd.35.1530910090085;
 Fri, 06 Jul 2018 13:48:10 -0700 (PDT)
Date:   Fri,  6 Jul 2018 22:48:03 +0200
Message-Id: <20180706204803.131152-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2] IB/mlx5: fix uaccess beyond "count" in debugfs read/write handlers
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
be accessible to root), and the read handlers check that *pos is zero
(meaning that at least sys_splice() can't trigger kernel memory
corruption). Because of the root requirement, this is not a security fix,
but rather a cleanup.

For the read handlers, fix it by using simple_read_from_buffer() instead of
custom logic. Add min() calls to the write handlers.

changed in v2:
 - also fix write handlers

Fixes: 4a2da0b8c078 ("IB/mlx5: Add debug control parameters for congestion control")
Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/infiniband/hw/mlx5/cong.c |  9 +--------
 drivers/infiniband/hw/mlx5/mr.c   | 32 ++++++++-----------------------
 2 files changed, 9 insertions(+), 32 deletions(-)

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
index 90a9c461cedc..308456d28afb 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -271,16 +271,16 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
 {
 	struct mlx5_cache_ent *ent = filp->private_data;
 	struct mlx5_ib_dev *dev = ent->dev;
-	char lbuf[20];
+	char lbuf[20] = {0};
 	u32 var;
 	int err;
 	int c;
 
-	if (copy_from_user(lbuf, buf, sizeof(lbuf)))
+	count = min(count, sizeof(lbuf) - 1);
+	if (copy_from_user(lbuf, buf, count))
 		return -EFAULT;
 
 	c = order2idx(dev, ent->order);
-	lbuf[sizeof(lbuf) - 1] = 0;
 
 	if (sscanf(lbuf, "%u", &var) != 1)
 		return -EINVAL;
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
@@ -337,16 +329,16 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
 {
 	struct mlx5_cache_ent *ent = filp->private_data;
 	struct mlx5_ib_dev *dev = ent->dev;
-	char lbuf[20];
+	char lbuf[20] = {0};
 	u32 var;
 	int err;
 	int c;
 
-	if (copy_from_user(lbuf, buf, sizeof(lbuf)))
+	count = min(count, sizeof(lbuf) - 1);
+	if (copy_from_user(lbuf, buf, count))
 		return -EFAULT;
 
 	c = order2idx(dev, ent->order);
-	lbuf[sizeof(lbuf) - 1] = 0;
 
 	if (sscanf(lbuf, "%u", &var) != 1)
 		return -EINVAL;
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
2.18.0.203.gfac676dfb9-goog

