Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E0EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8AC206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abgRxB+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeLOIVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:21:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45757 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbeLOIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:21:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so3747755pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 00:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZzR+ol4XWcYfVPJjID8gzHQ6ufC5oRR3J4SR2o4vcBU=;
        b=abgRxB+76o92pLItAKB4ZbaU7Us7bgZbtdCM6X9plJwogyiJn5sIubsc1Dz9ZjKUsr
         +UkztzQUB+nrMc7dlYoX/7gFk/qZat6G498Ggc7UmvVisrh0K7vFn5/FVr9C7+eWF20m
         7gVjdt8doJ00+CIV9u1Dn1iJmGUi/hZjzMMbscLVvKPtX43zPtWBNjn5xtkKNEyZzoGT
         escYIAvU+RgBs/zT4ZHvcfWH83/XGgSeLU+70YqbXTlXJuACsMDqMo89Xz/4UT2q3T5S
         gMeUPpnXK7+TGI8/Ng2dWLIJU9Yfp0FRtxr+6CkLup9M6uto0jd/ufuuG0Vv+USrNyb1
         2gAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZzR+ol4XWcYfVPJjID8gzHQ6ufC5oRR3J4SR2o4vcBU=;
        b=bcYWKJwpXlv7i0f9vqq8bxoq146yis96BjgkHwefFJVu06L0nYY1TkqA+dU6D0DSrr
         DblqUuN2YUl5wHj2gDpaTXU5saT1TC4IwdlH/IKO/xjyvTUyGbgKozLZJ+HHioHaB4hl
         n8ysM8IzT9YaaduSespIlWh2dk+xAOmBaYuVEK/bwahIDUBQLiOAWwvpyJXXs3zOFcet
         Dy2cpG6TbDm4QcUidGli0Zv6VqIaxYMbijGTpHDddP6bXhMfVy8TYztgXFnzgIK/xH0f
         B3zQjA3cK4q2ae/hPcpyuM8q+jAzB9ssiKQ8G2PGzZnudfbWbnm8rG2LrsaKjnXdMc8G
         d5pw==
X-Gm-Message-State: AA+aEWZkNjY7fRPOSdXVu9QdWghLrwQktS0mfwyfbNXNaNXfEdR3mqOi
        XYDTKY0E1vMmG8fyel8Rwms=
X-Google-Smtp-Source: AFSGD/WQyudEeabzBnwt1PfVQvzQzjBlTD+MQomqk/et2Fk9CBV/1RTr6ZZ+IlLhwq7L5K8ALNYWTg==
X-Received: by 2002:a63:c141:: with SMTP id p1mr5401045pgi.424.1544862110753;
        Sat, 15 Dec 2018 00:21:50 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v12sm8560627pgg.41.2018.12.15.00.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 00:21:50 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] regulator: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 03:21:48 -0500
Message-Id: <20181215082148.26511-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/regulator/core.c         | 37 +++++---------------------------
 drivers/regulator/dbx500-prcmu.c | 35 ++++--------------------------
 2 files changed, 9 insertions(+), 63 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b528aede..efcfc5e2ff85 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4621,23 +4621,8 @@ static int supply_map_show(struct seq_file *sf, void *data)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(supply_map);
 
-static int supply_map_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, supply_map_show, inode->i_private);
-}
-#endif
-
-static const struct file_operations supply_map_fops = {
-#ifdef CONFIG_DEBUG_FS
-	.open = supply_map_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-#endif
-};
-
-#ifdef CONFIG_DEBUG_FS
 struct summary_data {
 	struct seq_file *s;
 	struct regulator_dev *parent;
@@ -4755,21 +4740,8 @@ static int regulator_summary_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int regulator_summary_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, regulator_summary_show, inode->i_private);
-}
-#endif
-
-static const struct file_operations regulator_summary_fops = {
-#ifdef CONFIG_DEBUG_FS
-	.open		= regulator_summary_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-#endif
-};
+DEFINE_SHOW_ATTRIBUTE(regulator_summary);
+#endif /* CONFIG_DEBUG_FS */
 
 static int __init regulator_init(void)
 {
@@ -4781,12 +4753,13 @@ static int __init regulator_init(void)
 	if (!debugfs_root)
 		pr_warn("regulator: Failed to create debugfs directory\n");
 
+#ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("supply_map", 0444, debugfs_root, NULL,
 			    &supply_map_fops);
 
 	debugfs_create_file("regulator_summary", 0444, debugfs_root,
 			    NULL, &regulator_summary_fops);
-
+#endif
 	regulator_dummy_init();
 
 	return ret;
diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index 8976141c1438..308e3ff0a1bd 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -75,7 +75,7 @@ static struct ux500_regulator_debug {
 	u8 *state_after_suspend;
 } rdebug;
 
-static int ux500_regulator_power_state_cnt_print(struct seq_file *s, void *p)
+static int ux500_regulator_power_state_cnt_show(struct seq_file *s, void *p)
 {
 	/* print power state count */
 	seq_printf(s, "ux500-regulator power state count: %i\n",
@@ -83,23 +83,9 @@ static int ux500_regulator_power_state_cnt_print(struct seq_file *s, void *p)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(ux500_regulator_power_state_cnt);
 
-static int ux500_regulator_power_state_cnt_open(struct inode *inode,
-	struct file *file)
-{
-	return single_open(file, ux500_regulator_power_state_cnt_print,
-		inode->i_private);
-}
-
-static const struct file_operations ux500_regulator_power_state_cnt_fops = {
-	.open = ux500_regulator_power_state_cnt_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int ux500_regulator_status_print(struct seq_file *s, void *p)
+static int ux500_regulator_status_show(struct seq_file *s, void *p)
 {
 	int i;
 
@@ -122,20 +108,7 @@ static int ux500_regulator_status_print(struct seq_file *s, void *p)
 
 	return 0;
 }
-
-static int ux500_regulator_status_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ux500_regulator_status_print,
-		inode->i_private);
-}
-
-static const struct file_operations ux500_regulator_status_fops = {
-	.open = ux500_regulator_status_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(ux500_regulator_status);
 
 int __attribute__((weak)) dbx500_regulator_testcase(
 	struct dbx500_regulator_info *regulator_info,
-- 
2.17.0

