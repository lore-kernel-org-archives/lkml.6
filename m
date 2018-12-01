Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E525C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C2B2082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrschUni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C2B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeLAVdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:33:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38518 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLAVdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:33:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so4055054plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 02:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6htsjCqfn+Bj+9blogcuoOuuyLrmNr54XRYy3mStUno=;
        b=SrschUniyZCkAYQE/4sJH4Y6Zmazan+W/HvPbRgO16eObXYJwawe+a7MajdXlFhhY+
         zulffpWzaXJoAm4R0r77Ae3j+teQCBSAVnXw2HQtmlbZPaM6XTl/HS+StuJN1vWX0Qjw
         flaPzPLJN4LqMT1XGHdW9OUaWJ1suK2g5IIhC172p02/XJx1kUuyIp58JkGIhSS8Dpzk
         Z59SmKa4y/CzoxGy+mN8aE1lL30LUrcuiJghLaDkWIOO4ukjpQceibgtnyzEadXVcqKq
         zG3+7z+g1Db3S0pojiw6YFTEeOkQ7++N9EP7kplzutrZLiAAJ2P1NDU0nw0r6BrJBb8T
         a0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6htsjCqfn+Bj+9blogcuoOuuyLrmNr54XRYy3mStUno=;
        b=p6rWkQLY5Eiu0Usi+x8X/h6W8tYTGulVrhwPU5EppnHlrIQ2tRlragCn369UnsiHlf
         sMWINunAf4dM/QFYItgoZgxT9I8r8YrdK7ZXW+ihlhwUtxzwD6V7S9RGkM+g+7oDeXSN
         CE0o7pi9bbT3m3MYJA+B9PadOm10Y5cl8JkgDANRaLorCbt5yieaH/3Ef/JRVwlIdbJ0
         w6CcObpJ46Pe38+qnlfiihSSXAbcBxqhYG1wu/3JOlXEnHr1jYSOSjTiLV/ExJ02uT57
         LSqsvbdCUurhIEsR+pJ0295MF0tFW4rhfhL05z9Wi0rvt5VMTU3/5hVT2Vqn4d2Tk1DG
         gNkA==
X-Gm-Message-State: AA+aEWZDRlEzRLVTPPSfGin6yMkPiWpEGxslJ70iajB+fJEvCcvt6W/j
        bq1Iz1XiFE9aP08qDNI58Wc=
X-Google-Smtp-Source: AFSGD/XIDd7HlWCp69hmCZaBPvUIzVDfg7K1OMMluhMZMvS796D9mX/HIhBmlqLb4FptHdYAH0bcFA==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr8890635plb.150.1543659666648;
        Sat, 01 Dec 2018 02:21:06 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z191sm8848004pgd.74.2018.12.01.02.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 02:21:05 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     david.kershner@unisys.com
Cc:     sparmaintainer@unisys.com, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] drivers: visorbus: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 05:21:04 -0500
Message-Id: <20181201102104.6561-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/visorbus/visorbus_main.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/visorbus/visorbus_main.c b/drivers/visorbus/visorbus_main.c
index 0b2434cc4ecd..8f742dc9e62c 100644
--- a/drivers/visorbus/visorbus_main.c
+++ b/drivers/visorbus/visorbus_main.c
@@ -436,7 +436,7 @@ static void vbuschannel_print_devinfo(struct visor_vbus_deviceinfo *devinfo,
 		   devinfo->infostrs);
 }
 
-static int bus_info_debugfs_show(struct seq_file *seq, void *v)
+static int bus_info_show(struct seq_file *seq, void *v)
 {
 	int i = 0;
 	unsigned long off;
@@ -471,18 +471,7 @@ static int bus_info_debugfs_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int bus_info_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, bus_info_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations bus_info_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.open = bus_info_debugfs_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(bus_info);
 
 static void dev_periodic_work(struct timer_list *t)
 {
@@ -1022,7 +1011,7 @@ int visorbus_create_instance(struct visor_device *dev)
 					      visorbus_debugfs_dir);
 	dev->debugfs_bus_info = debugfs_create_file("client_bus_info", 0440,
 						    dev->debugfs_dir, dev,
-						    &bus_info_debugfs_fops);
+						    &bus_info_fops);
 	dev_set_drvdata(&dev->device, dev);
 	err = get_vbus_header_info(dev->visorchannel, &dev->device, hdr_info);
 	if (err < 0)
-- 
2.17.0

