Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB72C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E120827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu++ttjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6E120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbeKHBow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:44:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39595 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeKHBow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:44:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so8066165pla.6;
        Wed, 07 Nov 2018 08:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lox9KQgZnOoEyjfEFNSeuDDi1nxxX0S1XCxKVJQw29s=;
        b=mu++ttjRXA4YWXwtlwfHfB0LX7lkVZUY39HZvN3ojHtMm2mBh+YwvDdJVgvAqJDbut
         yH/z68Qa7uNGgn8doQegnsdetIbb2PXWo/9yBT46pmsSKE4FQGHUORp5RuEnTT+h80B2
         zENtYfJGbPjedXCl50Hfc7imchMGM4wHfbai6fva+yDL+RFkoFLoXs0z813A/8gDhToP
         Ga5a0claT0l7PXHL6OnzZii+BzcbpM9aoMrMiLVUF87Ym+HB2Ia917vNqkmlMkF29zB1
         Ysc3+OrjjtLoRi46blWhjg2UjXiQY+ioyK1lbgFyrCOTlXyh3e7dlJJ/SveM+Q80QINH
         TDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lox9KQgZnOoEyjfEFNSeuDDi1nxxX0S1XCxKVJQw29s=;
        b=WPSrZEOEV9Dkaa7GdHR5u/iblpbEjYACM7I5pdKaQ3EqYeJSD0VHLU/w2e6J1mX22Q
         tNkfDuLosaPZIHpWib6RTox9LQKjrRsPWOGUXvAJ0LZyV73kNJKM6PE1dn+kfvOpY9YB
         h55WbKfCaGSd3NlUuekRX7zw5STJuuNwDVV40KifAXzB0zK8kFLhkAbiJIUiP3DGE8Wv
         Nu9tO2Rm1VNV1kcDyqAWPK4Z8eI91EesQgPMdftfqkxNt7eVBIAPPqYKkLJc1CFmiBxk
         oVTCi1Bp59jeh+3L+HgZ3HvYrxwWtrmz9g2iK3QKZeYzD6K0vOPa3eXjbpQj5gbT9HN2
         BYYA==
X-Gm-Message-State: AGRZ1gKhrJPYwR41SS6KqqJx0ha/XHUJSvTWSKA+8A1+yDzBvZOBV5Vi
        D6hKM0iIOVmbc2cBVX3sXvc=
X-Google-Smtp-Source: AJdET5fQeIIx6qmrT+1NijLeNbfF37kw85pnsdvVJKISOZTqy6aui6JsTKs503q5sTDQXL2VDfd9iA==
X-Received: by 2002:a17:902:8210:: with SMTP id x16-v6mr835162pln.129.1541607231093;
        Wed, 07 Nov 2018 08:13:51 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id w10-v6sm1199407pfg.1.2018.11.07.08.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 08:13:50 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: s3c24xx: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Wed,  7 Nov 2018 11:13:46 -0500
Message-Id: <20181107161346.9887-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c | 46 +++--------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
index 4d976e8dbb2f..0df87b6480fe 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
@@ -63,18 +63,7 @@ static int board_show(struct seq_file *seq, void *p)
 	return 0;
 }
 
-static int fops_board_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, board_show, NULL);
-}
-
-static const struct file_operations fops_board = {
-	.open		= fops_board_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(board);
 
 static int info_show(struct seq_file *seq, void *p)
 {
@@ -105,18 +94,7 @@ static int info_show(struct seq_file *seq, void *p)
 	return 0;
 }
 
-static int fops_info_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, info_show, NULL);
-}
-
-static const struct file_operations fops_info = {
-	.open		= fops_info_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(info);
 
 static int io_show(struct seq_file *seq, void *p)
 {
@@ -162,19 +140,7 @@ static int io_show(struct seq_file *seq, void *p)
 	return 0;
 }
 
-static int fops_io_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, io_show, NULL);
-}
-
-static const struct file_operations fops_io = {
-	.open		= fops_io_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
-
+DEFINE_SHOW_ATTRIBUTE(io);
 
 static int __init s3c_freq_debugfs_init(void)
 {
@@ -185,13 +151,13 @@ static int __init s3c_freq_debugfs_init(void)
 	}
 
 	dbgfs_file_io = debugfs_create_file("io-timing", S_IRUGO, dbgfs_root,
-					    NULL, &fops_io);
+					    NULL, &io_fops);
 
 	dbgfs_file_info = debugfs_create_file("info", S_IRUGO, dbgfs_root,
-					      NULL, &fops_info);
+					      NULL, &info_fops);
 
 	dbgfs_file_board = debugfs_create_file("board", S_IRUGO, dbgfs_root,
-					       NULL, &fops_board);
+					       NULL, &board_fops);
 
 	return 0;
 }
-- 
2.17.0

