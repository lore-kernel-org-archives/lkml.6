Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D390C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BCB2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF9MVea4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeLOI4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:56:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36223 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeLOI4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:56:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so3983233pfc.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KQpN2oTnZlLoB4egBeZPvEFrtLna5LyJLzSDHWpm/gQ=;
        b=DF9MVea4utLpF5hHBcsytaWiQ0KANl2wTevapGot8PVgR5Ech9rwux1G+WQ07UVy3v
         wPBfSG2b7RKFEOwKeJvZcpqKr0nF9KOnS+cuCLfpuGNdjMZJ0VWcNrd+L6rKvrlnTjzX
         oOtI6Xi1PkCRpnKyhLKW2wZbQgrWirr95qda29U2pMQdPZ+cF/tPojKuJ6i2bj/a6aXf
         y3uNyQeYhS46koacBXyh4Fo6A/EmO0nSWAfHLSUAubNZCwYhK9rMJrLRQJT8jSeAPgde
         ioe07PKyRZTUsKxRIORElR7zvyqUaqMGJf6h1zKtZkLgqgSsdn1AE7bepxf03Ir1LmkN
         ATcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KQpN2oTnZlLoB4egBeZPvEFrtLna5LyJLzSDHWpm/gQ=;
        b=iXDWCnSt2sJ/qI2Lbh9ETTSoJZG2PV5kqrK/x/DjcYYI2RqYMMKy9sjjspndhEB5b3
         7b+flRBzDr6MoxBOxr3AxZBxFo2do/jz+QUEwISuN1mN3cMl5yPLfruCde0Jg9uPrH+y
         aaIm/rYTqKl86EvSPd0wC9RW59VbKW5OZMBrZEgI2Ji+eTMBFROqzOOqyyE/Iyw5KWRg
         sWlmESLSZbdoY7hb8xlbfbfgPJ7IKDV4zinNvFZ5apaOAQ5R/gNgjZLaZ+UIiVkJ8JLV
         w7e4XLRdvzJVTUTk5qZ0lKwAStSL2y7Kmgu3UYylaKTPCq3lIKIfFYMXFhoF5h+QEGYb
         7oAg==
X-Gm-Message-State: AA+aEWYs70U1y0TPka3Eq1gN2a1fvPZaQ6pXfKHX8J9LZzrXx/9Z+zcn
        TgS2dmynzukXczKMaD6w7jGYbJAJrcE=
X-Google-Smtp-Source: AFSGD/W2yrKIeTrFy4Oibzyk9yW9fH5q9vLQjDqOXKbDwrEaAEIV46xn6rsez0I4YJrIsuEXMTFp4A==
X-Received: by 2002:a63:e101:: with SMTP id z1mr5478863pgh.310.1544864197830;
        Sat, 15 Dec 2018 00:56:37 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o7sm9363226pfb.34.2018.12.15.00.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 00:56:36 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, natechancellor@gmail.com,
        kernelpatch@126.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] staging: rtlwifi: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 03:56:35 -0500
Message-Id: <20181215085635.27602-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/rtlwifi/debug.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtlwifi/debug.c b/drivers/staging/rtlwifi/debug.c
index 8999feda29b4..543889923864 100644
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
+				    &fopname ##fops);		   	   \
 	} while (0)
 
 #define RTL_DEBUGFS_ADD(name)						   \
-- 
2.17.0

