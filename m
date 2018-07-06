Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C0CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B16F23DBD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UF5B6eA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B16F23DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeGFPUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:20:36 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:46794 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753977AbeGFPUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:20:33 -0400
Received: by mail-qk0-f202.google.com with SMTP id u19-v6so13776252qkl.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=GsOMmntGzvMQ0imlqQ8OOQNlMQcc0X+uUDdYN1l/Hyg=;
        b=UF5B6eA11m9dtBGlHZxIef60K2+9jKDeviqgdoZ9ijY64jsw9BAsISvo0CviCk8b+P
         UbTwdJTzlAwEe2Eb6gbowubao9IBuXn+TGfPSuhHRtcij7Jsu9Qqv6ojo24SZD5Jucqa
         s72q/uA1NpXknTBIWoWBuBmbzUTw817VEJVKrxZov0DL4YekFPjRnzdvXzrwO8Q4P8do
         4Y3NSIMFFhQZu4m+OQWdGUNA7emWyBaP6wtlyoAgAUxerJxGUFQZ7zx5AZI5ARQLhXjT
         IDflZjfjdB0ooUsP8WGhaTe+WysyC3u4EmCkWYswQQDttn3XBNB8DeZnH/QIZOcny7lJ
         +C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=GsOMmntGzvMQ0imlqQ8OOQNlMQcc0X+uUDdYN1l/Hyg=;
        b=Ft5AKA3VExlZNd7sZkwk4v9SOj2juP1kWGx/9hBEbjNss09qgg6w3EMWqw2aUuJqJ3
         b7Ek6uz/OnkBf9SREApy4z2Z2J/lZKv/8GYdcm+s5wqh7DS+grKI7KFZDIUxh1/VDGa/
         ZUuLtmt3zan52MRurKMdD7JvhL8R2XyzylnqAwgtbjpZiIYuhDRoagjQfFtTwf2J9jAP
         kIrKnq50gTl5bHNAyWyWCA8zpUcX97tNWmUCkmCHNWo4swoteoXxR2vhV1aFHm43fa38
         BS8lMqQrvNf3bmPEi0DdmhwQp2m+JRzI4KLxaQVkt2Fgl4R/cDh/Wf7o65D9oBJnXVJc
         kiUA==
X-Gm-Message-State: APt69E3eXcGHmzbdigeXyINeymUwKjrbIAOKefCsmMhM6BLr3n67LMne
        g4GWbQz+4lm5VQzgEV55APTihk1wzQ==
X-Google-Smtp-Source: AAOMgpcoE2uA2SVxza6gguyKoPVWO03IModdlm/aU9WBB1j9mfhigyzLq5btWcJcg9rd0Gjs8myfw1vMmg==
MIME-Version: 1.0
X-Received: by 2002:ac8:7103:: with SMTP id z3-v6mr6281887qto.50.1530890433129;
 Fri, 06 Jul 2018 08:20:33 -0700 (PDT)
Date:   Fri,  6 Jul 2018 17:20:28 +0200
Message-Id: <20180706152028.31775-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH net] net/mlx5: fix uaccess beyond "count" in debugfs read handlers
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

Fix it by using simple_read_from_buffer() instead of custom logic.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 23 +++----------------
 .../net/ethernet/mellanox/mlx5/core/debugfs.c | 22 ++----------------
 2 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 384c1fa49081..0a79a4540923 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1226,21 +1226,12 @@ static ssize_t data_read(struct file *filp, char __user *buf, size_t count,
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
@@ -1258,19 +1249,11 @@ static ssize_t outlen_read(struct file *filp, char __user *buf, size_t count,
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
2.18.0.399.gad0ab374a1-goog

