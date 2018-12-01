Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14739C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E1420834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imdi2CqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E1420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeLAVIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:08:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37730 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeLAVIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:08:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so4039245pfb.4;
        Sat, 01 Dec 2018 01:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f9f23gJ521wQoegjMt6fYorFvvw/tT9NpB8/4OGX5cI=;
        b=Imdi2CqS5D7YZn5HSmO8uTMEC1HSH3chARsmGOdCX8NSsgutXSJ5HtE6WGN5V2p1kH
         RADvwApXlFyjKvWQedhV9Kr6Sj2glr13RUdh2xdg3Fs1XsQUYeD5V85ziBPyfqvZ51Js
         1AXm+EsnnmKAzN8hWrU1MuFWdjCNynK02JDEnNT66LaHLy0O5LqXgIHAevA+U9m7ltCs
         UvcEpnlfzcDzdXOj6nKugzRDtkZ/dDlSQ5eopQAQxUnVAoUN7nqX2+o6csHKQRnzq8Jq
         KtEcAnLz9PJZ2HMxLy10heOCeYzbDTbRdAG+rvDYy9K7nvzqk4X38BugNkZteKTPMw32
         rSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f9f23gJ521wQoegjMt6fYorFvvw/tT9NpB8/4OGX5cI=;
        b=ZSFgJu7I3YMHC8+hjj2wKEg1BS1WkkjgJvKvFsDF8hrkb/0mF3OlWS1Kv4vZQF/JZM
         yNCh7vrDSNWkP+SBY6ezczXXhTSoLApEdDOOajC+KkWEbbAZ6+Jp6C6isDNvNZbLhGrF
         62j2fx0QdwRyzGf8fEZKObx7kHobb/lqvQUs7upY8/BUXXFOpBeSEhPBqfyTr81UnNnv
         zxbvrHycqr6j4nIgVWjlL8MaMGOjlsn+xDv3Ei7rr5cfLFD8sBgeimJsoVwxNrL0krJK
         LIj0XLeCb4mhc5b5pIeFuNronzYYllCyviJtb2JD6mtRTA2FlqLa90KELOf7f1NDX1K/
         PodA==
X-Gm-Message-State: AA+aEWZ0zXFTfDE5IPQeiGfEYSPt7RxDxFqcPdzRd3danNOJpIMYbsnR
        27ajkvtf/GzQvUksg3/GHcc=
X-Google-Smtp-Source: AFSGD/Wh/9l47EMHUDjM/9Nco2ZiISHSFAgxWPbOxPEFZvEvng69GWLnfGnM82k7Kto6Y5BV58T4Xg==
X-Received: by 2002:a63:4342:: with SMTP id q63mr7475625pga.63.1543658193470;
        Sat, 01 Dec 2018 01:56:33 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h19sm9276591pfn.114.2018.12.01.01.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 01:56:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        Jampala.Srikanth@cavium.com, sgadam@cavium.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] crypto: cavium/nitrox convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 04:56:30 -0500
Message-Id: <20181201095630.6232-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_debugfs.c | 48 ++++---------------
 1 file changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
index 5f3cd5fafe04..0196b992280f 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
@@ -13,18 +13,7 @@ static int firmware_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int firmware_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, firmware_show, inode->i_private);
-}
-
-static const struct file_operations firmware_fops = {
-	.owner = THIS_MODULE,
-	.open = firmware_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(firmware);
 
 static int device_show(struct seq_file *s, void *v)
 {
@@ -41,18 +30,7 @@ static int device_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int nitrox_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, device_show, inode->i_private);
-}
-
-static const struct file_operations nitrox_fops = {
-	.owner = THIS_MODULE,
-	.open = nitrox_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(device);
 
 static int stats_show(struct seq_file *s, void *v)
 {
@@ -69,18 +47,7 @@ static int stats_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int nitrox_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, stats_show, inode->i_private);
-}
-
-static const struct file_operations nitrox_stats_fops = {
-	.owner = THIS_MODULE,
-	.open = nitrox_stats_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(stats);
 
 void nitrox_debugfs_exit(struct nitrox_device *ndev)
 {
@@ -97,13 +64,16 @@ int nitrox_debugfs_init(struct nitrox_device *ndev)
 		return -ENOMEM;
 
 	ndev->debugfs_dir = dir;
-	f = debugfs_create_file("firmware", 0400, dir, ndev, &firmware_fops);
+	f = debugfs_create_file("firmware", 0400, dir, ndev,
+				&firmware_fops);
 	if (!f)
 		goto err;
-	f = debugfs_create_file("device", 0400, dir, ndev, &nitrox_fops);
+	f = debugfs_create_file("device", 0400, dir, ndev,
+				&device_fops);
 	if (!f)
 		goto err;
-	f = debugfs_create_file("stats", 0400, dir, ndev, &nitrox_stats_fops);
+	f = debugfs_create_file("stats", 0400, dir, ndev,
+				&stats_fops);
 	if (!f)
 		goto err;
 
-- 
2.17.0

