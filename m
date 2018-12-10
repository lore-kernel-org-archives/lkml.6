Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B813C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA020851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKBbxiK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBA020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeLJPxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:53:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40718 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeLJPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:53:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so5149096pgp.7;
        Mon, 10 Dec 2018 07:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pAJElhgXETw5U29C4zhBa1j2EiCL5oVSeF3pklk7yss=;
        b=aKBbxiK4iwETH8nfe4c278vW1FKGmxJJAAHlFbzfbp7OkMxYIoDMOndAa35ozqsouS
         zn6Bekop75MaO1mUFXAfG8pq0lk3eaXpx0EDFAg/DOufxf+mK66jr7lch7hQBGKN/ue9
         dVjgcrf1REAx0rNVEaKMEX33OgKuFdEuqYhelNB3tvaO2X9oD8H3eCULlL2v2Mj2cfpx
         JwRYvQoW0HcJRRbC+7CfT/SZOor5LFDe7yRukLG31UpH8VVbPheNoc6dsIn2jsCf0sMM
         LO/ywhxR4GhOuXOXvXxFCDvn+GDKDkzWdGHCB3bMZ8LUdmMmKKZQ+cPWp2IjfyfIYc67
         DTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pAJElhgXETw5U29C4zhBa1j2EiCL5oVSeF3pklk7yss=;
        b=KSkJDDPk9RFGzcHUq2CvS693qtasuH8C8drGSrz9quFLaxoMMDly0Q0Dj44/5pvWID
         sMBIGtMAw2HvBlghayzG3gVrDZe+J5RpP7R1uqmV5kfutAFICpbpwCMPiDIaMBH6kdcK
         g6cMAFRQ9ZjvHJPislXzn/DC5dWu/4xI9O9ypHBj6Xh+yqOW/bi4fyMqyJ5U73T8B27x
         G/JFHetM3hkmKt0zDy16yzWJk3JebG1OJTVlc9SdI0WJe/Jm5LzGhjrMk8urzuje+17X
         iE1z2u04oef6EJ1cHOguIScClBmNXyB1N2nIQ8pTPmgNbSF7QQTSlHwT4a9cTk8jjn+Q
         CsSQ==
X-Gm-Message-State: AA+aEWb4c2TbRYATZQU9MI8rgCxhmxioD7sLKwxridnndgAROUvGMUp/
        2rLkdD8fTv+maiR1qPydYQ0=
X-Google-Smtp-Source: AFSGD/XwYJ1qBBvG0WGlZ/FugJiDOdLr6Fz+54wbceL3xmpe9c2MLnxne9Jq87Gk5q1YNmhMrfcl6A==
X-Received: by 2002:a62:5716:: with SMTP id l22mr13213717pfb.16.1544457213759;
        Mon, 10 Dec 2018 07:53:33 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 128sm15416170pfu.129.2018.12.10.07.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:53:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     wei.liu2@citrix.com, paul.durrant@citrix.com, davem@davemloft.net
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] net: xenbus: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon, 10 Dec 2018 10:53:29 -0500
Message-Id: <20181210155329.20608-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/xen-netback/xenbus.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index fe1d52247bbe..2625740bdc4a 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -186,7 +186,7 @@ static const struct file_operations xenvif_dbg_io_ring_ops_fops = {
 	.write = xenvif_write_io_ring,
 };
 
-static int xenvif_read_ctrl(struct seq_file *m, void *v)
+static int xenvif_ctrl_show(struct seq_file *m, void *v)
 {
 	struct xenvif *vif = m->private;
 
@@ -194,19 +194,7 @@ static int xenvif_read_ctrl(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int xenvif_ctrl_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, xenvif_read_ctrl, inode->i_private);
-}
-
-static const struct file_operations xenvif_dbg_ctrl_ops_fops = {
-	.owner = THIS_MODULE,
-	.open = xenvif_ctrl_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(xenvif_ctrl);
 
 static void xenvif_debugfs_addif(struct xenvif *vif)
 {
@@ -238,7 +226,7 @@ static void xenvif_debugfs_addif(struct xenvif *vif)
 						    0400,
 						    vif->xenvif_dbg_root,
 						    vif,
-						    &xenvif_dbg_ctrl_ops_fops);
+						    &xenvif_ctrl_fops);
 			if (IS_ERR_OR_NULL(pfile))
 				pr_warn("Creation of ctrl file returned %ld!\n",
 					PTR_ERR(pfile));
-- 
2.17.0

