Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FEFC04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641B520851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5dRmdqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641B520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbeLBD2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:28:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46357 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLBD2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:28:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so4672101pfe.13;
        Sat, 01 Dec 2018 19:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CX/lZcLXK5qyttBjtFqyDBlDy24fxkhyXJZSeupOrvc=;
        b=F5dRmdqTcciOzfHieVBSaFdEY6JjvncYMW0qaRtiCQgo11QZMM1toAamTam0Zcxgm8
         UUKXL8PpIDE2yAuaVBKHv844N8NOhIhoRGRyDBSyj+AC/pWkRYu1bParfI5OBJSlHVCh
         n+2UZILyVG2Cn1tF8yBGZNCN9PTewFZqrFL+tNetAiUqFRTvfGOwFxqwkWLRkUMO1N4F
         wOKIa6lmHwOtUfvxCF8ucRdveuRLnpdV05P/1li+dMUW6LuM4UIUXJ8wvavpfZ0UKK7Q
         mAIKt5Ysjy/utRIPzknVMFb4n0AgUFp2PlJC5uq5z1Ei3P6hhXgu2i5wSYvTD95RQig9
         yqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CX/lZcLXK5qyttBjtFqyDBlDy24fxkhyXJZSeupOrvc=;
        b=WcqGkXm8FDEYlcTSLalZvHennf7/hGqlRrtZPgfChJGsk5hgrVMCLPlGGpUu1Rtrpe
         eGenQOh2NDw6K4fhqxvOWaAXWhgsZFLMnYseeHl1rR0qgoHVxTlXMvlFxYvWtWNWKILv
         EoAs99dP+y2SusnmOQ4jylS54jjndZSAWCiSwvhEkFYbOZOilxoZnfKB8uiIWu9N/KEh
         DdC0huYgQyPw99xtNOoKL4YRpFp7cmmculeRNzR3BRCfj2r0z3WW5UM/W2Ib9Kl6kAp0
         OVqARN8BpvV2o/wOWVIuN6ImOL4nIGAQQs7jBT1d8uowYg2FNJqT9NuYZ46voP7qLZgG
         c2Dg==
X-Gm-Message-State: AA+aEWZs7SJW+Lxytf2i8rf5skes+HJS2L9JJ4BJE0K5PNHwbKWeqNzI
        zD2zXJi5B2ZFTQWmLvod9Mk=
X-Google-Smtp-Source: AFSGD/WrIuuzEKzmBIoA4rYuQockn08Rp4nDbb4MTOOaLKkreyMHpFtPgNjk5GLsAHVu0v6+Ep5ioA==
X-Received: by 2002:a63:78cd:: with SMTP id t196mr9458162pgc.62.1543721293888;
        Sat, 01 Dec 2018 19:28:13 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t90sm19875525pfj.23.2018.12.01.19.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 19:28:13 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     sth@linux.ibm.com, hoeppner@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, sebott@linux.ibm.com,
        oberpar@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] s390: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 22:28:11 -0500
Message-Id: <20181202032811.9875-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/s390/block/dasd.c     | 15 +--------------
 drivers/s390/cio/qdio_debug.c | 16 ++--------------
 2 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 5e9ebdb0594c..397af07e4d88 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1192,20 +1192,7 @@ static int dasd_hosts_show(struct seq_file *m, void *v)
 	return rc;
 }
 
-static int dasd_hosts_open(struct inode *inode, struct file *file)
-{
-	struct dasd_device *device = inode->i_private;
-
-	return single_open(file, dasd_hosts_show, device);
-}
-
-static const struct file_operations dasd_hosts_fops = {
-	.owner		= THIS_MODULE,
-	.open		= dasd_hosts_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dasd_hosts);
 
 static void dasd_hosts_exit(struct dasd_device *device)
 {
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index 68a82f3e2e92..040061f2bfff 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -190,19 +190,7 @@ static int qstat_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int qstat_seq_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, qstat_show,
-			   file_inode(filp)->i_private);
-}
-
-static const struct file_operations debugfs_fops = {
-	.owner	 = THIS_MODULE,
-	.open	 = qstat_seq_open,
-	.read	 = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(qstat);
 
 static char *qperf_names[] = {
 	"Assumed adapter interrupts",
@@ -306,7 +294,7 @@ static void setup_debugfs_entry(struct qdio_q *q)
 		 q->is_input_q ? "input" : "output",
 		 q->nr);
 	q->debugfs_q = debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR,
-				q->irq_ptr->debugfs_dev, q, &debugfs_fops);
+				q->irq_ptr->debugfs_dev, q, &qstat_fops);
 	if (IS_ERR(q->debugfs_q))
 		q->debugfs_q = NULL;
 }
-- 
2.17.0

