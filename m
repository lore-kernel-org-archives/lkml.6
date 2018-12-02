Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 04:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD5420834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 04:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuPEPSe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD5420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbeLBEOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:14:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLBEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:14:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so4730029pfc.3;
        Sat, 01 Dec 2018 20:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ItWw9xV0OZ0rLJ2VN73W7xJ7ddl7sTO8Ach+wndptXA=;
        b=PuPEPSe+EoL8YSzOUedlI2qT8PltTleyH8iFa7+K4awDYo690mv31yYustUguNqsBr
         4WdY6JWZhA5XHhISI7BC1TMiZu7bfOiNYT/PQDHeNSjrEBTKcBNCK4TWO++az/m67d3v
         VuYpHKU3PO/v4Vx0VaWUMzoQF6BdxoLyekRUZYCCScbEXcgtUK0pVXvz8uzPGJpPKOxs
         IXkQBdfA3Dy5wJswVd9Oa91/dlCLumY+h1jxluSymq+PHK/flbBPFKxrPe//w2YkaAnW
         r81euVvdfPirMvS6umc9i23zUwbf7180cU/VrIyktbYp7g1EuJUSI4dP5m/a2H2Z7Akw
         dLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ItWw9xV0OZ0rLJ2VN73W7xJ7ddl7sTO8Ach+wndptXA=;
        b=HHVEZCrR7dpZ0pFngI0Jr5fbLnrVwVjbAyEZ61wqrBhoB36pnN1EcGdf2WLp8aWEuz
         +n1ot4HpjudERTTqZqDbbAoGnO6FXKwMhcyD1d8cI6CjZ3CvqfKQjLuqWVsTNaXqchzp
         FeQOGlW49WSwdcqfNzMTT2XVSOIxo5Jihnlp0tfHDsT8LOa43ba6t8UH9q5PEDOL0l02
         pnB0V9pQoPWCryoaCj2qEQtxUmdTHbIKQCFGFsuoDo7vDDkHmTrVL0Ob16hrSvhdr5KR
         rmOtnl3/DZ3Bt6EEbxrHv7bh4BqihyuZkplqGz/GpBiIIzi7ztX9CctVH0wXVRgKjJhR
         xGsQ==
X-Gm-Message-State: AA+aEWaKaZrxETkyq+R9ffflswe4IlHSzEaA8Elt6MsPhvyp/Rl1dh+c
        X9DGIcxvXdo9LAZGzruvxAE=
X-Google-Smtp-Source: AFSGD/VbEpjDDYMmogLC9/EwJuhKnaZilzfKot9IgplrwKz7SVrpC/cPGL1KywOgZypOmz5mf2SEPA==
X-Received: by 2002:a63:8742:: with SMTP id i63mr9344669pge.298.1543724090593;
        Sat, 01 Dec 2018 20:14:50 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id m198sm11087043pga.10.2018.12.01.20.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 20:14:49 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     b.zolnierkie@samsung.com, fengguang.wu@intel.com,
        mchehab+samsung@kernel.org
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] media: omap2: omapfb: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 23:14:48 -0500
Message-Id: <20181202041448.10049-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index a5e58a829ea0..b4bcf3a4a647 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -99,24 +99,14 @@ int dss_set_min_bus_tput(struct device *dev, unsigned long tput)
 }
 
 #if defined(CONFIG_FB_OMAP2_DSS_DEBUGFS)
-static int dss_debug_show(struct seq_file *s, void *unused)
+static int dss_show(struct seq_file *s, void *unused)
 {
 	void (*func)(struct seq_file *) = s->private;
 	func(s);
 	return 0;
 }
 
-static int dss_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dss_debug_show, inode->i_private);
-}
-
-static const struct file_operations dss_debug_fops = {
-	.open           = dss_debug_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dss);
 
 static struct dentry *dss_debugfs_dir;
 
@@ -130,7 +120,7 @@ static int dss_initialize_debugfs(void)
 	}
 
 	debugfs_create_file("clk", S_IRUGO, dss_debugfs_dir,
-			&dss_debug_dump_clocks, &dss_debug_fops);
+			&dss_debug_dump_clocks, &dss_fops);
 
 	return 0;
 }
@@ -145,7 +135,7 @@ int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 	struct dentry *d;
 
 	d = debugfs_create_file(name, S_IRUGO, dss_debugfs_dir,
-			write, &dss_debug_fops);
+			write, &dss_fops);
 
 	return PTR_ERR_OR_ZERO(d);
 }
-- 
2.17.0

