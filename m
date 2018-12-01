Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7C3C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F088020834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7tm5Dos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F088020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeLBDLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:11:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36756 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLBDLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:11:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so4310686plo.3;
        Sat, 01 Dec 2018 07:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6Nlkx8dqzw9t0rvZXiELgUJGbtAVvFRbbQ2v5ajcc78=;
        b=X7tm5DosNXhQu/yEC2gwRz1Lv+XUZCNZYRGMv8/Q/xG2/aSDfh95mNhoo7LYU4PANp
         fLTORTmfXhpJLkgO+B+mfihePdnt4B8Jfehebeio/ttlTm6+0crtCcnfd7S0t9d3jJOw
         fQnH8173Cd0GTVFBkbET+RcAIfVXC+hCGdk1KKLZeqYwdiUtOM53Mij7KN7d+nOHtblQ
         My2/AOgOSW/uW+zAlLBWtuBwEVRUWVOKeZpgBzKy6PLonAgenkiqTIveJBJARmeLgGpC
         17O6HA4Z8VzqfBcgKdVXC72RG+qZaje/d0Gd20uV3XlAMKpSGa8KS6ZA1olH7a7u9fLZ
         8VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Nlkx8dqzw9t0rvZXiELgUJGbtAVvFRbbQ2v5ajcc78=;
        b=nI8BPlj00wKyIZUYiOCesclGQHEsuM8/2gVlPOdd0NDl5OOx7qZwliYHP6cS+FNIzQ
         fg4qbQjrIVeeLN8TeqK4lFMT0gUgTn4R723m+2IIfXzMwFiVcpna3r/2Um8cgQ0Nwn0A
         Ls6tLrx+XKQaxvXoW05xqdneqxrpbMn/WAY2Vp/j4fcp30PBuOCbz9k6g64n+My/LcOM
         u5urhr6UMpYagN2YnGWPZ1lcrbAemIUVWyATinO2sZXD6jI7hWblN28HdCvXN7UL8/6p
         ftloOe2YRh+cpLdLaZaVPutgW6zW/q2bYiAuFmc//nI/QfIGhF5pzx4T2i0Usua03WT2
         Kcag==
X-Gm-Message-State: AA+aEWYvrts2pJSrk4IzNGA19SaZDQ6T+9uQToOh/3S3dkswlosSbDWI
        DYIdio4UPwNeIIY/yH/xEaE=
X-Google-Smtp-Source: AFSGD/Uhxex80TRguECaTbW/cu27VqKD1+5rdP0AOz8MHiSAO1pbXhE/YGbAAJdHzWubIzvEq8Eqqg==
X-Received: by 2002:a17:902:7c82:: with SMTP id y2mr9568283pll.33.1543679921293;
        Sat, 01 Dec 2018 07:58:41 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x19sm14504083pfk.14.2018.12.01.07.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:58:40 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] remoteproc: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 10:58:38 -0500
Message-Id: <20181201155838.8619-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/remoteproc/remoteproc_debugfs.c | 28 ++++---------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index e90135c64af0..f936c2e485ac 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -240,17 +240,7 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
 	return 0;
 }
 
-static int rproc_rsc_table_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rproc_rsc_table_show, inode->i_private);
-}
-
-static const struct file_operations rproc_rsc_table_ops = {
-	.open		= rproc_rsc_table_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rproc_rsc_table);
 
 /* Expose carveout content via debugfs */
 static int rproc_carveouts_show(struct seq_file *seq, void *p)
@@ -270,17 +260,7 @@ static int rproc_carveouts_show(struct seq_file *seq, void *p)
 	return 0;
 }
 
-static int rproc_carveouts_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rproc_carveouts_show, inode->i_private);
-}
-
-static const struct file_operations rproc_carveouts_ops = {
-	.open		= rproc_carveouts_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rproc_carveouts);
 
 void rproc_remove_trace_file(struct dentry *tfile)
 {
@@ -326,9 +306,9 @@ void rproc_create_debug_dir(struct rproc *rproc)
 	debugfs_create_file("recovery", 0400, rproc->dbg_dir,
 			    rproc, &rproc_recovery_ops);
 	debugfs_create_file("resource_table", 0400, rproc->dbg_dir,
-			    rproc, &rproc_rsc_table_ops);
+			    rproc, &rproc_rsc_table_fops);
 	debugfs_create_file("carveout_memories", 0400, rproc->dbg_dir,
-			    rproc, &rproc_carveouts_ops);
+			    rproc, &rproc_carveouts_fops);
 }
 
 void __init rproc_init_debugfs(void)
-- 
2.17.0

