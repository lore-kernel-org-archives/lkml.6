Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68A8C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F71120834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8YhznWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F71120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeLADcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:32:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34552 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeLADcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:32:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so3057017pfg.1;
        Fri, 30 Nov 2018 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UXx7K1aD1lH5akuv9QVkU+NEL46CsTmiv8IdZL4IEBY=;
        b=s8YhznWhtYjCyX7QfR6AMwlENj5pew2kWkombLmFKr7Rmfq51kPaPPwsj/1cW3Fs5I
         qumG6R9XPnc/bOmsaUwjlVADlRY1ZuZ4C/j8kxs0WeOmIXtbrrv7h/ybbBnsZ5V379aC
         cFFQzYmKQhB+f8/robh/TF+9pnJueKJcQczudQcEUFUi5xh5j4iyYvZGVO20kIlNGCW+
         k3c9hYYxKeTYWTz7pVrsXtRvA9sgVQo/VDEoFeJ2+L4ymoQtuVdOFiBHAccF/RqTVvSu
         SEvifFzjDHz9SvyF7jybWYmtKPP5GEk+sH95anGntTtDekSgU6ka29mrmt7Ws7/jFyhB
         HH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UXx7K1aD1lH5akuv9QVkU+NEL46CsTmiv8IdZL4IEBY=;
        b=gGaqvznFmZqly+TH6mfpPR21LHiYqUnpwWO8Fy4WqFfIWCvwW3qXkl5pGjnMiEbV+i
         qb43qe+iqJ/pgY1WKRLItt1kYfMnhc/LjaalhUfND6G6thpY/pjjfHR36ZmuBxOnEKpO
         VBG2zS7TdEAW8epgu9iU5ve44EyE1mw7tXF1hg3Sb2NT+jfjYG3gHANqJXPfXyPWS3hU
         WLUNnR3LI37m0AtDoktoiGsGDQ7gpZKZ7TMwmHFoaBvujZKWTjk6C7csz5Gk/fLgyHuw
         tiLC0V1oBwJVmhb4NDaNcT4hWery/KMFwBQReTQSdT1Nv/21wdIOKSN35rtiZ+q4XV0E
         GW1w==
X-Gm-Message-State: AA+aEWYBDQeXfNjbAOvni1ZT4WiqGuAMLI/AR+fQASiBr1RHKWZlbcfS
        lNYL3NNzZXSLzPxFq/35fuM=
X-Google-Smtp-Source: AFSGD/U7jbewC1xW48SahpN20upkuhfUkldoXyWkpyiyX/LaLrMVXje8Ep0H3vQGa/SBsxEHIdHiwQ==
X-Received: by 2002:a63:6645:: with SMTP id a66mr5245444pgc.390.1543594971016;
        Fri, 30 Nov 2018 08:22:51 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n22sm12990198pfh.166.2018.11.30.08.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 08:22:49 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] gpio: ks8695: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 11:22:46 -0500
Message-Id: <20181130162246.3555-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/gpio/gpio-ks8695.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-ks8695.c b/drivers/gpio/gpio-ks8695.c
index 55d562e1278e..d6d6140ffc40 100644
--- a/drivers/gpio/gpio-ks8695.c
+++ b/drivers/gpio/gpio-ks8695.c
@@ -282,22 +282,13 @@ static int ks8695_gpio_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int ks8695_gpio_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ks8695_gpio_show, NULL);
-}
-
-static const struct file_operations ks8695_gpio_operations = {
-	.open		= ks8695_gpio_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ks8695_gpio);
 
 static int __init ks8695_gpio_debugfs_init(void)
 {
 	/* /sys/kernel/debug/ks8695_gpio */
-	(void) debugfs_create_file("ks8695_gpio", S_IFREG | S_IRUGO, NULL, NULL, &ks8695_gpio_operations);
+	debugfs_create_file("ks8695_gpio", S_IFREG | S_IRUGO, NULL, NULL,
+				&ks8695_gpio_fops);
 	return 0;
 }
 postcore_initcall(ks8695_gpio_debugfs_init);
-- 
2.17.0

