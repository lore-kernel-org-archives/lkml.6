Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E07C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675A720892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9zyVDnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675A720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeLEQTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:19:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41986 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:19:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so9232009pga.9;
        Wed, 05 Dec 2018 08:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UlVfIMfHrGtBTlZv/XK8koRNqWY+54IiT4Z9OFB2kBw=;
        b=p9zyVDnLTDccX6BjnfxuHmufgkGARQAWH6PNjDcQaP0d7RHLNfobAzQenhVX0TLyQJ
         DaPB/5OD5dd4IBHTHRb4J4mkeXn7DdZ/tEIkCP/TL2sUPW5NFoIKd9GMaaJSeIlsF32r
         Vfgh44k3f2+aOQD/A6SsnQQYwRFtvsFQjMkZ32HrGrq1lHXokB7+7mxpAm/YbAYW9Lwu
         YJc/kQJeYb8hZF5b0ikCCmCKy5MK08ecgte1WLilvRY7anHDTgWMY94YR0Zjf62Tsa8g
         4FP5T6QISdsUqOHkEVwFs/GVeCEHg0U4n0zAOoWbfbpUFfd5DApJ8fvNBtCwRb+kVlbH
         BNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UlVfIMfHrGtBTlZv/XK8koRNqWY+54IiT4Z9OFB2kBw=;
        b=VVE9rE1HALY7aCkO48WBkmy2IoxVSS4if1GU3eACvoqVKD0ZN45Mq0YYkbFQQGs970
         FfmXplc/y1KkaCf1SB+l2Eb5XCTF89GX1aYpZ8jmiuBoGTqRxxYN7x4iymF8ce2yoKMz
         A8KyrGZZgx5FyaHM2Bds+eH9XOX+278zcIDv/+rCJqlTRrs0sxzw/R+TL7VeuzD2CRVB
         BBp1jnMJRxvP282lqLTYeB7sKVvS39IwWrbakyKoaf2aVqz0I8Oczl91tDJz9XX6svVk
         gptF2ITGsr+ZamDPcFOGJr1rvWEPYVHQwWdL0FNtF3u3gKnm330JQovPKZFq4jjCSHN9
         43uw==
X-Gm-Message-State: AA+aEWYj/lh6pcSQ7eULIStMux17dy/iyHsReWBBVJ6rgXFwnkae5YB2
        wjiPrQSK13u+LwZZTfVPRnP0lS2auLY=
X-Google-Smtp-Source: AFSGD/WzdxHmUE3nEUbxh/wpldUjRDSE4NVo39PlUajdmLspkBIg9fg85B0OrPZUxw+Y1Xob+V9PCA==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr20775172pgq.67.1544026750169;
        Wed, 05 Dec 2018 08:19:10 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g65sm104654652pfa.63.2018.12.05.08.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:19:09 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr, okaya@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/4] dmaengine: mic_x100_dma: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed,  5 Dec 2018 11:18:58 -0500
Message-Id: <20181205161900.16434-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181205161900.16434-1-tiny.windzz@gmail.com>
References: <20181205161900.16434-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/dma/mic_x100_dma.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/mic_x100_dma.c b/drivers/dma/mic_x100_dma.c
index adfd316db1a8..6a91e28d537d 100644
--- a/drivers/dma/mic_x100_dma.c
+++ b/drivers/dma/mic_x100_dma.c
@@ -676,7 +676,7 @@ static void mic_dma_dev_unreg(struct mic_dma_device *mic_dma_dev)
 }
 
 /* DEBUGFS CODE */
-static int mic_dma_reg_seq_show(struct seq_file *s, void *pos)
+static int mic_dma_reg_show(struct seq_file *s, void *pos)
 {
 	struct mic_dma_device *mic_dma_dev = s->private;
 	int i, chan_num, first_chan = mic_dma_dev->start_ch;
@@ -707,23 +707,7 @@ static int mic_dma_reg_seq_show(struct seq_file *s, void *pos)
 	return 0;
 }
 
-static int mic_dma_reg_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mic_dma_reg_seq_show, inode->i_private);
-}
-
-static int mic_dma_reg_debug_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations mic_dma_reg_ops = {
-	.owner   = THIS_MODULE,
-	.open    = mic_dma_reg_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = mic_dma_reg_debug_release
-};
+DEFINE_SHOW_ATTRIBUTE(mic_dma_reg);
 
 /* Debugfs parent dir */
 static struct dentry *mic_dma_dbg;
@@ -747,7 +731,7 @@ static int mic_dma_driver_probe(struct mbus_device *mbdev)
 		if (mic_dma_dev->dbg_dir)
 			debugfs_create_file("mic_dma_reg", 0444,
 					    mic_dma_dev->dbg_dir, mic_dma_dev,
-					    &mic_dma_reg_ops);
+					    &mic_dma_reg_fops);
 	}
 	return 0;
 }
-- 
2.17.0

