Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DAFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A15022B69
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9ym/AdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A15022B69
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeGFUSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:18:21 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:35757 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754058AbeGFUST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:18:19 -0400
Received: by mail-yb0-f201.google.com with SMTP id w3-v6so12019412ybp.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=9lZE8mspbom25+QAi6lF959ttyUUF0aSqxdOEzxHOCs=;
        b=Q9ym/AdBF7KK4jjkprOecQUv4fRUKE3YGL2xjXKzoBofXU8cDgdQNn7vQB34wI2vzP
         jcdSLDkwlSEQiUbwNdyfGMQRf/llpgvqHNTC4vx8roeVuzK1gnlEIolwW7v06HUGof2b
         8aI0Q20jX/M8TY2EDmL1+wBIr5IcDrbsiU9HC8Hb3axa7+lRunhxW0wLpazOTOM8sG51
         vUY5hS4a8AiNrm1rYOWKhk0U7jI+XmhMgdr50XeFjI6Q4Gcsrb4gQ8h5u//UHuxdrxXS
         VbyC3oAtyyUBHNo4kXQCRw6IPGv8mQ/F7RAjug3qOgEWJDteqlPrRJDeBChvwBtGv4QF
         Jzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=9lZE8mspbom25+QAi6lF959ttyUUF0aSqxdOEzxHOCs=;
        b=Uki6tIBn4RNgOw7uOfeZyDy6REjZUE3YgLgskyaFTqCc9AxeCCkCQPKTJkNhk8Rt1l
         dk9zD9upQj0xy+nQc8mXQpsfymz4XZ+dKGfNhjkeAHT/ozRMfsbT40DHxS7hgvtJe/o7
         k15FfLLAQ3rmdE+WlAjs17mB2Pq0XvBw5K1fXS8boiuNdM+JUBcw1Mh9a3MffYGSOHMV
         KmJahgCuPasPSi+g7scm/62JjLrw7SRopuqnfYxto7xz8k4A1KBJuKmLsjWjJP8d0OHK
         +1uZMcuS9MHguppM8mjC5wVtDtQW/dKAkWz9GvvmMieQVA8sVLI4O18c/MbmG1T/vjgF
         pbkQ==
X-Gm-Message-State: APt69E2s1ssJzlKrg+eA4hq5XG9T4NMhOb+k9P9S8avfZ7yN43VLTGl6
        saGjJr6O9nXlolHqilAOsdNs9bRE9w==
X-Google-Smtp-Source: AAOMgpf+5BXvSreX+p9CBD0rzu8RMWCI3TJBlE6kbOXUq1fOAb48oCzOuHatct3HH1dTyT/BVfIseKCkMQ==
MIME-Version: 1.0
X-Received: by 2002:a25:8686:: with SMTP id z6-v6mr3521354ybk.37.1530908298580;
 Fri, 06 Jul 2018 13:18:18 -0700 (PDT)
Date:   Fri,  6 Jul 2018 22:18:09 +0200
Message-Id: <20180706201809.105152-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH net v2] net/mlx5: fix uaccess beyond "count" in debugfs
 read/write handlers
From:   Jann Horn <jannh@google.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, jannh@google.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

For the read handlers, fix it by using simple_read_from_buffer() instead of
custom logic.
For the write handler, add a check.

changed in v2:
 - also fix dbg_write()

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 28 +++++--------------
 .../net/ethernet/mellanox/mlx5/core/debugfs.c | 22 ++-------------
 2 files changed, 9 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 384c1fa49081..92578074145d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1022,7 +1022,10 @@ static ssize_t dbg_write(struct file *filp, const char __user *buf,
 	if (!dbg->in_msg || !dbg->out_msg)
 		return -ENOMEM;
 
-	if (copy_from_user(lbuf, buf, sizeof(lbuf)))
+	if (count < sizeof(lbuf) - 1)
+		return -EINVAL;
+
+	if (copy_from_user(lbuf, buf, sizeof(lbuf) - 1))
 		return -EFAULT;
 
 	lbuf[sizeof(lbuf) - 1] = 0;
@@ -1226,21 +1229,12 @@ static ssize_t data_read(struct file *filp, char __user *buf, size_t count,
 {
 	struct mlx5_core_dev *dev = filp->private_data;
 	struct mlx5_cmd_debug *dbg = &dev->cmd.dbg;
-	int copy;
-
-	if (*pos)
-		return 0;
 
 	if (!dbg->out_msg)
 		return -ENOMEM;
 
-	copy = min_t(int, count, dbg->outlen);
-	if (copy_to_user(buf, dbg->out_msg, copy))
-		return -EFAULT;
-
-	*pos += copy;
-
-	return copy;
+	return simple_read_from_buffer(buf, count, pos, dbg->out_msg,
+				       dbg->outlen);
 }
 
 static const struct file_operations dfops = {
@@ -1258,19 +1252,11 @@ static ssize_t outlen_read(struct file *filp, char __user *buf, size_t count,
 	char outlen[8];
 	int err;
 
-	if (*pos)
-		return 0;
-
 	err = snprintf(outlen, sizeof(outlen), "%d", dbg->outlen);
 	if (err < 0)
 		return err;
 
-	if (copy_to_user(buf, &outlen, err))
-		return -EFAULT;
-
-	*pos += err;
-
-	return err;
+	return simple_read_from_buffer(buf, count, pos, outlen, err);
 }
 
 static ssize_t outlen_write(struct file *filp, const char __user *buf,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 413080a312a7..90fabd612b6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -150,22 +150,13 @@ static ssize_t average_read(struct file *filp, char __user *buf, size_t count,
 	int ret;
 	char tbuf[22];
 
-	if (*pos)
-		return 0;
-
 	stats = filp->private_data;
 	spin_lock_irq(&stats->lock);
 	if (stats->n)
 		field = div64_u64(stats->sum, stats->n);
 	spin_unlock_irq(&stats->lock);
 	ret = snprintf(tbuf, sizeof(tbuf), "%llu\n", field);
-	if (ret > 0) {
-		if (copy_to_user(buf, tbuf, ret))
-			return -EFAULT;
-	}
-
-	*pos += ret;
-	return ret;
+	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
 }
 
 static ssize_t average_write(struct file *filp, const char __user *buf,
@@ -442,9 +433,6 @@ static ssize_t dbg_read(struct file *filp, char __user *buf, size_t count,
 	u64 field;
 	int ret;
 
-	if (*pos)
-		return 0;
-
 	desc = filp->private_data;
 	d = (void *)(desc - desc->i) - sizeof(*d);
 	switch (d->type) {
@@ -470,13 +458,7 @@ static ssize_t dbg_read(struct file *filp, char __user *buf, size_t count,
 	else
 		ret = snprintf(tbuf, sizeof(tbuf), "0x%llx\n", field);
 
-	if (ret > 0) {
-		if (copy_to_user(buf, tbuf, ret))
-			return -EFAULT;
-	}
-
-	*pos += ret;
-	return ret;
+	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
 }
 
 static const struct file_operations fops = {
-- 
2.18.0.203.gfac676dfb9-goog

