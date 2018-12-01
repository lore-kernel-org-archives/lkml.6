Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4550C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871EB2146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk5kVgBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871EB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeLBCEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:04:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45450 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:04:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so3763446pgc.12;
        Sat, 01 Dec 2018 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/7kGPK6CxVyiJ8APXCBWIxIiTtZ/gxon6zemIqEwfi8=;
        b=Tk5kVgBxtNJFl9KCB1KPkCf4judvEDObqlFyaEsNqsFsboHN03bHigZSEAm7GhXlsM
         p5m4FRg9vllePMYzM2V5qx+RajknrIortPVE2Xal9E2B4L4CiZOFDSrC0BEUgDj1gDCU
         I6JutO0yO7SHlt7Hoas49dTsxJWBGekRQEz4lmscpA61dG+DrUEYROVfUm9OgFdwJqfw
         0ElEWgNwNMM+Dq9ZTBKnZlTuNIjmhMM6XO0ZKGdu2RU3iBCGRJwqhfdnAbMTFzF82FAf
         gg8+m9qVScfwfUqQGb7bzuu2wO6RVR21KD81EN1nQMNgBL//JnWntP4g0JuUScmMdvit
         PmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/7kGPK6CxVyiJ8APXCBWIxIiTtZ/gxon6zemIqEwfi8=;
        b=DcMYH1iEM7G21vWGMktgnZQ3EXnn6/yRcD6J/W8CQc6hdQGApvBmb3cuwbc2G86PbA
         qkzA/KfjhX+Q90nbgECcwUWH3x5PtcJLIlt+6Ygwszl/1Lp823pffiGBDNYy74EdiTcO
         MmUk9IxfChW/7jF+4hhwV+8cnNOKtqc331/jR5gy6CmLTApPulOutn2KdE6zjAy7akrT
         +5Mmd+OmV7/Jppmo8GqEkRkc7n3R0YSGZeC6CjILE/hntV0Kkq8UbeY1OZC8BozfOD4W
         hkdGG4Mtu7LvLtnBjrpuoGPQPaBHlrIe+WJeWrwwq55xEA3nyj2IyuFg2vqsSND1Tgea
         G2bw==
X-Gm-Message-State: AA+aEWbNRtdq34EVpdRgteAQx5VkNiVbjPaRpkrgq3XFO4VtMki/xYTf
        POoBdx5S2XUK2LeN1ULao7c=
X-Google-Smtp-Source: AFSGD/UIyF5zGgX6FnDg2rl6Q464Ov3yRcB+9oBjUmX7W9o82i2t2p2sLvt1/EEE+hnTbKR/BdHyhg==
X-Received: by 2002:a62:8145:: with SMTP id t66mr9570213pfd.55.1543675916297;
        Sat, 01 Dec 2018 06:51:56 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l5sm8374491pgp.82.2018.12.01.06.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 06:51:55 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] watchdog: bcm281xx: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 09:51:39 -0500
Message-Id: <20181201145140.8088-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181201145140.8088-1-tiny.windzz@gmail.com>
References: <20181201145140.8088-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 1462be9e6fc5..4249b47902bd 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -90,7 +90,7 @@ static int secure_register_read(struct bcm_kona_wdt *wdt, uint32_t offset)
 
 #ifdef CONFIG_BCM_KONA_WDT_DEBUG
 
-static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
+static int bcm_kona_show(struct seq_file *s, void *data)
 {
 	int ctl_val, cur_val;
 	unsigned long flags;
@@ -130,17 +130,7 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int bcm_kona_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, bcm_kona_wdt_dbg_show, inode->i_private);
-}
-
-static const struct file_operations bcm_kona_dbg_operations = {
-	.open		= bcm_kona_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(bcm_kona);
 
 static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
 {
@@ -157,7 +147,7 @@ static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
 		return;
 
 	if (debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdt,
-				&bcm_kona_dbg_operations))
+				&bcm_kona_fops))
 		wdt->debugfs = dir;
 	else
 		debugfs_remove_recursive(dir);
-- 
2.17.0

