Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60002C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC1E2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMYGk9lZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC1E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436744AbeKVX2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:28:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42422 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436645AbeKVX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:28:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so1911987pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 04:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pbT7cvBR8SJ68SpnxSZaalCbxAC+rUz74D+MN8UMqMA=;
        b=XMYGk9lZTEPIVgUaW6Z0d3dBcsq8hNJAloTXxKlkXxMBVUBWspYVHKkWfHdJ/1RH7u
         g2nZcC+Ja9Ek8ByJtOXUTUwdP4CQjSEhjb6t7A/xX6hV2sPocVFsL6Lv16c9vv9GLgTY
         0oxxsyt7SJsGTyAe5KJwovQoh9Bz8Q8W8DWmJwqqiD8YRT8Kxd+tQ7Z3PaMOHfMFAcuz
         gJZuh/qdnYAMMI9SLrsz7dYIaGjdy61lEGrS3y42MfncPmq1z8yc/M++RsAN4400C7Ja
         6m+S3by3Mr4tuDBleRX5k8YS5Mai21E7guulg9rPHxt4czuQFlFOTMh7QXz7czWVo6js
         B+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pbT7cvBR8SJ68SpnxSZaalCbxAC+rUz74D+MN8UMqMA=;
        b=mYAc97ZOT4vGHJ2LGvdmhNualr4VFztcq7SwvdRU4p0mGaNzMekX2kpF8+U0jj6zq4
         QcWmXzd3gB7wMxks5/lWXb9AYbfk/ajhbwMJTle3hUdP2nDgjn/HtCMOTzdrjoJFTxPm
         4cSken6CFEMHUKMcT6l+bO2ThlIWBrDqPkGHp+4FOW+xwcex1e4dl31yBVylxLc1sYdM
         ajMJlXIQXodJ+MvdJY/D0t6OChvYhG06grXbWVuYUkKG81PGDjcz9KOv3IeD6Ia5Ntnk
         QDkblPYR98Xt7kflRH0ncTCTd+ATXYA/8HtPsCPZxJtK+cFe58P+fmilhAo7yHtbS1aM
         sL3A==
X-Gm-Message-State: AGRZ1gKPrqLbRqQ98vds9BP2gWlsC0vMUBD0ZzCL0aK99kAKO7gmixt4
        FXYUj6ARCpU6fp+0xhM2sig=
X-Google-Smtp-Source: AJdET5ftjKAdPlS/MeYhnLTAKTv6NdyLZZj7De9BBKmsKOdH3RE624+0qabhSKRDXs+71Diu22HEmw==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr11310546pfl.106.1542890939126;
        Thu, 22 Nov 2018 04:48:59 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id s62-v6sm62456526pfb.73.2018.11.22.04.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 04:48:58 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] soc: ti: QMSS: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Thu, 22 Nov 2018 07:48:54 -0500
Message-Id: <20181122124854.24528-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 8b418379272d..67f7c003417b 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -483,17 +483,7 @@ static int knav_queue_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int knav_queue_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, knav_queue_debug_show, NULL);
-}
-
-static const struct file_operations knav_queue_debug_ops = {
-	.open		= knav_queue_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(knav_queue_debug);
 
 static inline int knav_queue_pdsp_wait(u32 * __iomem addr, unsigned timeout,
 					u32 flags)
@@ -1883,7 +1873,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 	}
 
 	debugfs_create_file("qmss", S_IFREG | S_IRUGO, NULL, NULL,
-			    &knav_queue_debug_ops);
+			    &knav_queue_debug_fops);
 	device_ready = true;
 	return 0;
 
-- 
2.17.0

