Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BECC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7892146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2KWS+30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7892146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeLBCEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:04:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33106 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:04:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so4264209plo.0;
        Sat, 01 Dec 2018 06:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vdVsgR5q6/GPyYPgTW/tGfqqgukMmf2xjkb63WLQPaw=;
        b=C2KWS+30OM8y+FN/JlwtQ3f4qhGhdcb7+o8h3mKjMFaw5cClJiN+ewBazGtgXRIIs3
         PTj/ZF5Y1BVODvEkkldMHA3p6MdeWzfHuSnPNumbcGXxDZYGzZWbyQ4tLl2ehKa7RXvb
         UqcPYwFWhLuSaNVDJpyxsfvIsfd39xgfAPiTFENaBD4RnljjVCw2kWJDn8exit7vP7A5
         N6BWCi5IHvIwKKsR8IYLH0t68ArgFTHtNog5wawLxMGHMdh8g/jgxG1VYQTa+W7NVFhy
         aY7xxYI8bu1FGwpRqtFhj9yT/EjpAQpLKZIIVTVAyFtnRK0QRTvhcDvEMFBQTE2krJEX
         iMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vdVsgR5q6/GPyYPgTW/tGfqqgukMmf2xjkb63WLQPaw=;
        b=hBCcbt+6lKM46kqi8r76kQkilUY9cYCCnHjShUusAlQgjPxs4/WKBy2OQFt+C3QMeI
         /XqHS5j8wY4f5FnTL6n90kxvCMxZp5ANswt4IsN9fWPYu67OroZ4za28zlE1lR/VVagY
         cRUf8SKUGQvGqn45xlesACvEvBCmPCnhhd2FxZlPNvzQZyENlwxGyZYjBilT7RIsc7Fm
         O6qiKoJ7msplKXZgYS87WyUu6rxn44+CQwEu+2IhOM9RP4bXC9seWA/HwYIVX2H4VpLP
         LziHVt3C2qw2AoWdbrLZgjhtaEaG5i7fkJmVRpaTf/FIPjVg7RcOhimmpxBe/araW7Gy
         vvpg==
X-Gm-Message-State: AA+aEWZfh6+mjclhdxN5rNoJctiGuJi5rr1YlojuOn39FzA9qxtAyMpY
        YT/XlnFiiASdoDj19QtQ7JA=
X-Google-Smtp-Source: AFSGD/UcPpb7lqZnBFegNdLjW2gt3m94MltbTCTwlmjTA/if9fjfRc3ooqYVOWhdwx7l60EdXAv8+w==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6mr9532039plo.67.1543675919268;
        Sat, 01 Dec 2018 06:51:59 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h8sm8889069pgv.27.2018.12.01.06.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 06:51:58 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 09:51:40 -0500
Message-Id: <20181201145140.8088-3-tiny.windzz@gmail.com>
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
 drivers/watchdog/ie6xx_wdt.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 78c2541f5d52..8de9fb1ed371 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -193,7 +193,7 @@ static struct watchdog_device ie6xx_wdt_dev = {
 
 #ifdef CONFIG_DEBUG_FS
 
-static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
+static int ie6xx_wdt_show(struct seq_file *s, void *unused)
 {
 	seq_printf(s, "PV1   = 0x%08x\n",
 		inl(ie6xx_wdt_data.sch_wdtba + PV1));
@@ -212,23 +212,13 @@ static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int ie6xx_wdt_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ie6xx_wdt_dbg_show, NULL);
-}
-
-static const struct file_operations ie6xx_wdt_dbg_operations = {
-	.open		= ie6xx_wdt_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ie6xx_wdt);
 
 static void ie6xx_wdt_debugfs_init(void)
 {
 	/* /sys/kernel/debug/ie6xx_wdt */
 	ie6xx_wdt_data.debugfs = debugfs_create_file("ie6xx_wdt",
-		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_dbg_operations);
+		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_fops);
 }
 
 static void ie6xx_wdt_debugfs_exit(void)
-- 
2.17.0

