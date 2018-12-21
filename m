Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C861EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E3D21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtFfue5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbeLUPpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:45:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39649 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbeLUPo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:44:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so2771551pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yNBZJFY9upl767cMfPmevGbz0aYXvBwrVaB+Ff3yMHU=;
        b=ZtFfue5akEI24ASrO2Yvj5EzJCb09T3i08pnLqHFsZZNw1RCkgSZXpqCFrRYKQo5/k
         E24pCUppx+EsZRXMJWG1zV7Q6GzUJQB/78VEUSNnRtAsKjq8G6IOuRBRF2b7wZgEBlp8
         DjyoM6g4Zt4Nrb9Gwmth2QJSL/LGrXi/fLRa1JpFkFDczEyHk2dJ4bXTm+mwWRCtzK9J
         vJGNqxthdC2b+QecqMm+zVU3MZBEQhuoCv+3pqlMc1g9fEWrq1kholOIQLEBgO5SJlY5
         j4Pf3izupt0mAeekdlwRpEPHqWMCEKgEj4JIJLnPsmvYfpZvH9Vac7HtHEsCzF+0PrWa
         RoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yNBZJFY9upl767cMfPmevGbz0aYXvBwrVaB+Ff3yMHU=;
        b=ftPNunADT+I6uj7igE+TOcop/32OWvls6vTlpdJa4ChYqo0dKuPCsxl4rTSHYYNzeH
         0hiDLmOfPefOVwgSekzuiPWLcj2rDaQlMW6uh7Lj2IxItUwXfusT6e6tY+yFZqG3e8IH
         GWllhUF2JlVV9lixthi0/fxtAZ08okZWQzNlIKuILkeYc6nTmfH/DX7koMq6d65wKC4/
         GWL+dfgya0jw3sRBvFToZc1X+R1YQMW+5dyWF+mpAq0JGxeCgkX6h5sWzJmRdex82WcD
         6WBqo1IncdQ/UoAgbJSSbi7Nw88q767r9HD2gPUUJW3EQE/fMYW/DpPhuKmiPoMC7RD7
         ec6g==
X-Gm-Message-State: AJcUukcpzP0ndcG6blgO3j2cgmip76ckqZqQbxfOIq1CrqASmaYrbMuQ
        JBnaMWlOOtGVvElDFWiltyc=
X-Google-Smtp-Source: ALg8bN608bcQv56p5sx39h3Nkt/klSGE6NfBLWg7wu77ISbbMoe+LWwrUjPNZXM/40E1rPfIg1idnw==
X-Received: by 2002:a63:3d49:: with SMTP id k70mr2873378pga.191.1545407098643;
        Fri, 21 Dec 2018 07:44:58 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h128sm37850999pgc.15.2018.12.21.07.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 07:44:57 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, natechancellor@gmail.com,
        kernelpatch@126.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] staging: rtlwifi: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Fri, 21 Dec 2018 10:44:55 -0500
Message-Id: <20181221154455.32430-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
v2:
-modify RTL_DEBUGFS_ADD_CORE macro
---
 drivers/staging/rtlwifi/debug.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtlwifi/debug.c b/drivers/staging/rtlwifi/debug.c
index 8999feda29b4..dd1cc27e9544 100644
--- a/drivers/staging/rtlwifi/debug.c
+++ b/drivers/staging/rtlwifi/debug.c
@@ -79,24 +79,13 @@ struct rtl_debugfs_priv {
 
 static struct dentry *debugfs_topdir;
 
-static int rtl_debug_get_common(struct seq_file *m, void *v)
+static int common_show(struct seq_file *m, void *v)
 {
 	struct rtl_debugfs_priv *debugfs_priv = m->private;
 
 	return debugfs_priv->cb_read(m, v);
 }
-
-static int dl_debug_open_common(struct inode *inode, struct file *file)
-{
-	return single_open(file, rtl_debug_get_common, inode->i_private);
-}
-
-static const struct file_operations file_ops_common = {
-	.open = dl_debug_open_common,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(common);
 
 static int rtl_debug_get_mac_page(struct seq_file *m, void *v)
 {
@@ -439,7 +428,7 @@ static ssize_t rtl_debugfs_common_write(struct file *filp,
 	return debugfs_priv->cb_write(filp, buffer, count, loff);
 }
 
-static const struct file_operations file_ops_common_write = {
+static const struct file_operations common_write_fops = {
 	.owner = THIS_MODULE,
 	.write = rtl_debugfs_common_write,
 	.open = simple_open,
@@ -488,7 +477,7 @@ static int rtl_debugfs_open_rw(struct inode *inode, struct file *filp)
 	int ret = 0;
 
 	if (filp->f_mode & FMODE_READ)
-		ret = single_open(filp, rtl_debug_get_common, inode->i_private);
+		ret = single_open(filp, common_show, inode->i_private);
 	else
 		filp->private_data = inode->i_private;
 
@@ -509,7 +498,7 @@ static struct rtl_debugfs_priv rtl_debug_priv_phydm_cmd = {
 	.cb_data = 0,
 };
 
-static const struct file_operations file_ops_common_rw = {
+static const struct file_operations common_rw_fops = {
 	.owner = THIS_MODULE,
 	.open = rtl_debugfs_open_rw,
 	.release = rtl_debugfs_close_rw,
@@ -523,7 +512,7 @@ static const struct file_operations file_ops_common_rw = {
 		rtl_debug_priv_ ##name.rtlpriv = rtlpriv;		   \
 		debugfs_create_file(#name, mode, parent,		   \
 				    &rtl_debug_priv_ ##name,		   \
-				    &file_ops_ ##fopname);		   \
+				    &fopname_ ##fops);		   	   \
 	} while (0)
 
 #define RTL_DEBUGFS_ADD(name)						   \
-- 
2.17.0

