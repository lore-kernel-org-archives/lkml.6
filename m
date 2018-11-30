Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F942145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/EyT+5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F942145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeLADqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:46:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33606 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeLADqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:46:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so3073645plo.0;
        Fri, 30 Nov 2018 08:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m5lpqb58unwhhYr1UH2S+9bDI2XUBanLKdG1j+tGvWE=;
        b=O/EyT+5iIDsaomnA8oemDV236TpOElVOYZrfbM8KB/kA736QlHwSDnfyrHXIjRAh4C
         JwM2sPU5McF9Cy/Yb+o0xfO+Bku9oj4S/FzmB1NudFWHVAMsRNa7sgfpoon41/wN8gzB
         qvk+PIJxPxgOeEOZGaWLv4AZhALtW49kwjhqgw6diMtRz0cKUjh7hE9ZHkAHJoHsu5Yt
         T27sBkhG4YunJ6831AAfYg2TYqMPCkQq6TFSjXPzZtum6vTSpCR3Cl+vvYGC3nUNwnJy
         OLPbW4+JIjayqBmc+B59n//T0+/+KB7mXDkmoz74uozhx0J1ILvlSDpI5D5PerijNNJv
         IneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m5lpqb58unwhhYr1UH2S+9bDI2XUBanLKdG1j+tGvWE=;
        b=QFCAy2XgL/lkxGjOek+8y9QS9cbf1E72C+K+++MvJuW6al87mDkK9L8umDvcOF9/hJ
         rvRKEto+WyMUfc6Q123QjT2bQWbpjxWfx/+D7+uy72KCKa2O0n1AIgytemc5e12lzLPU
         Iie7SML2hwpY1/wtirTADpXqMwKJLfU9FxmFmqJ/vsGyhJ6+g4sEfHcCcbOH9RXrgxiR
         a+tSkGpHMy+xQtvhGv/Cv7dnVZ5m+TtelwbE3zrmgApNx3rtkl3G8+ukbtQsdowrRWGg
         NIAI4tgn5F9m3mEqO2YnpZSwQfA0pxdYuhzxi6rfFmYAYwr/menDRJlU4sKsVkC6QP8r
         w9yg==
X-Gm-Message-State: AA+aEWai3H5d14bSIpZ+7Dim6ZovXqeDeXztG8JHHeKZ9nJStzt1m7Xu
        dLZug+bdEN34T1JPwc3ZaQsB2XKMxPg=
X-Google-Smtp-Source: AFSGD/WyogUTwTLDhcFFqYsWAAu7+34kg5iQDkTe34xVTx941xXLQoaCakEM/zs/oDzN7xqkUPUGiA==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr6517733pll.54.1543595781155;
        Fri, 30 Nov 2018 08:36:21 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z13sm14902826pgf.84.2018.11.30.08.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 08:36:20 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] pinctrl: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 11:36:17 -0500
Message-Id: <20181130163617.3778-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/pinctrl/pinconf.c | 29 ++++-------------------------
 drivers/pinctrl/pinmux.c  | 29 ++++-------------------------
 2 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index d3fe14394b73..2c7229380f08 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -366,29 +366,8 @@ static int pinconf_groups_show(struct seq_file *s, void *what)
 	return 0;
 }
 
-static int pinconf_pins_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pinconf_pins_show, inode->i_private);
-}
-
-static int pinconf_groups_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pinconf_groups_show, inode->i_private);
-}
-
-static const struct file_operations pinconf_pins_ops = {
-	.open		= pinconf_pins_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations pinconf_groups_ops = {
-	.open		= pinconf_groups_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pinconf_pins);
+DEFINE_SHOW_ATTRIBUTE(pinconf_groups);
 
 #define MAX_NAME_LEN 15
 
@@ -613,9 +592,9 @@ void pinconf_init_device_debugfs(struct dentry *devroot,
 			 struct pinctrl_dev *pctldev)
 {
 	debugfs_create_file("pinconf-pins", S_IFREG | S_IRUGO,
-			    devroot, pctldev, &pinconf_pins_ops);
+			    devroot, pctldev, &pinconf_pins_fops);
 	debugfs_create_file("pinconf-groups", S_IFREG | S_IRUGO,
-			    devroot, pctldev, &pinconf_groups_ops);
+			    devroot, pctldev, &pinconf_groups_fops);
 	debugfs_create_file("pinconf-config",  (S_IRUGO | S_IWUSR | S_IWGRP),
 			    devroot, pctldev, &pinconf_dbg_pinconfig_fops);
 }
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 5780442c068b..4d0cc1889dd9 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -644,37 +644,16 @@ void pinmux_show_setting(struct seq_file *s,
 		   setting->data.mux.func);
 }
 
-static int pinmux_functions_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pinmux_functions_show, inode->i_private);
-}
-
-static int pinmux_pins_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pinmux_pins_show, inode->i_private);
-}
-
-static const struct file_operations pinmux_functions_ops = {
-	.open		= pinmux_functions_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations pinmux_pins_ops = {
-	.open		= pinmux_pins_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pinmux_functions);
+DEFINE_SHOW_ATTRIBUTE(pinmux_pins);
 
 void pinmux_init_device_debugfs(struct dentry *devroot,
 			 struct pinctrl_dev *pctldev)
 {
 	debugfs_create_file("pinmux-functions", S_IFREG | S_IRUGO,
-			    devroot, pctldev, &pinmux_functions_ops);
+			    devroot, pctldev, &pinmux_functions_fops);
 	debugfs_create_file("pinmux-pins", S_IFREG | S_IRUGO,
-			    devroot, pctldev, &pinmux_pins_ops);
+			    devroot, pctldev, &pinmux_pins_fops);
 }
 
 #endif /* CONFIG_DEBUG_FS */
-- 
2.17.0

