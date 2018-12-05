Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F06C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A865820892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZ/O6676"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A865820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeLEQTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:19:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33755 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeLEQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:19:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so10255381pfb.0;
        Wed, 05 Dec 2018 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U5AyLvvPtL5q9Hq4lLjNeXGltOkPp9aVeP+7Rj9S6G4=;
        b=pZ/O66767u/rju7GV0hExJzk4xER5YpDmZBVbLQR1ZPXoBifETBSmkHWjhuxoMk0tt
         6EL2v4x6RYeLQ1k/2gESxWcg4UNPGaZLJhE9IuxaYZf3Li974d3yYYEb6mETlQ+I7PsE
         Vfb4Ro1ynCGwsetRSyuqcEv0ybE7hOjh+DYS0gIBX4sEZuqc+39U4k437HaaBAEKk83m
         Vlrz+A1madK3qDoef9UdDzp0YA0jUjsUurLPIk3g70ALBFr36w22qyFMcaUmZr2nhCSr
         igm5OoCmvzl4vorfgzH3YZZK7G7bkzZqIUGWDbxCoRZefotnEIvsAqs2rTJ5y3oQtaQW
         3gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U5AyLvvPtL5q9Hq4lLjNeXGltOkPp9aVeP+7Rj9S6G4=;
        b=V9GgYXRt9aIY9mVJsQL7mcJXt1tEgVDvy/eJXe8YT7bcg7mpSKsFgNp5tS/ZHe15/V
         LpnSZI/WlR27eDmDdNECVk2qBjyU2Epi5T99VZDaa7ejJhKmWQ/LgryXrJg2x9tlkhKW
         jk1t5C4G8BEmLrT5eXC+OafGI2cyMEu8mZ5Q5crg1bQTS8zA8ONnY8k5CuKuZ07mpmfg
         gV9XM5+2CJ11j/0/ONuzLYUGK8ew5zAtmW/Rz7xLftWRV13u3duexZtX6AveB6s0qJoy
         BS8F6kQtMXKxmiPnzlJeWsuUkQsQv+5Zb++N14nuyRKeMzOAame9cAHp1gqtrCjNdoYt
         gTmA==
X-Gm-Message-State: AA+aEWbIakW2hflboLVTH+FTznMClRSkmcXMUl/ycsHiy3+VElS1oPzu
        uFQS78FqHoc3srlKrlXCVE0=
X-Google-Smtp-Source: AFSGD/XRuMnsK25fid0v5zdBmNLshJ9g2ojqO8x9OsAVhaID02pKR/H65XtOEy1CVvhAsOp3pOucnQ==
X-Received: by 2002:a63:5907:: with SMTP id n7mr20874313pgb.435.1544026759113;
        Wed, 05 Dec 2018 08:19:19 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o7sm26868095pfb.34.2018.12.05.08.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:19:18 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr, okaya@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 4/4] dmaengine: qcom_hidma: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed,  5 Dec 2018 11:19:00 -0500
Message-Id: <20181205161900.16434-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181205161900.16434-1-tiny.windzz@gmail.com>
References: <20181205161900.16434-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/dma/qcom/hidma_dbg.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
index 3bdcb8056a36..9523faf7acdc 100644
--- a/drivers/dma/qcom/hidma_dbg.c
+++ b/drivers/dma/qcom/hidma_dbg.c
@@ -85,11 +85,11 @@ static void hidma_ll_devstats(struct seq_file *s, void *llhndl)
 }
 
 /*
- * hidma_chan_stats: display HIDMA channel statistics
+ * hidma_chan_show: display HIDMA channel statistics
  *
  * Display the statistics for the current HIDMA virtual channel device.
  */
-static int hidma_chan_stats(struct seq_file *s, void *unused)
+static int hidma_chan_show(struct seq_file *s, void *unused)
 {
 	struct hidma_chan *mchan = s->private;
 	struct hidma_desc *mdesc;
@@ -117,11 +117,11 @@ static int hidma_chan_stats(struct seq_file *s, void *unused)
 }
 
 /*
- * hidma_dma_info: display HIDMA device info
+ * hidma_dma_show: display HIDMA device info
  *
  * Display the info for the current HIDMA device.
  */
-static int hidma_dma_info(struct seq_file *s, void *unused)
+static int hidma_dma_show(struct seq_file *s, void *unused)
 {
 	struct hidma_dev *dmadev = s->private;
 	resource_size_t sz;
@@ -138,29 +138,8 @@ static int hidma_dma_info(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int hidma_chan_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hidma_chan_stats, inode->i_private);
-}
-
-static int hidma_dma_info_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hidma_dma_info, inode->i_private);
-}
-
-static const struct file_operations hidma_chan_fops = {
-	.open = hidma_chan_stats_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static const struct file_operations hidma_dma_fops = {
-	.open = hidma_dma_info_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(hidma_chan);
+DEFINE_SHOW_ATTRIBUTE(hidma_dma);
 
 void hidma_debug_uninit(struct hidma_dev *dmadev)
 {
-- 
2.17.0

