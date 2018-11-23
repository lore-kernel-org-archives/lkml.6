Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0BBC04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2591820664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFRwRuCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2591820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504746AbeKXBuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:50:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43542 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbeKXBue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:50:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so10766973plb.10;
        Fri, 23 Nov 2018 07:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o93J3BNmQ1ja0KQUj6SiJX6FygDGjFCA6M1dZJot1uE=;
        b=mFRwRuCPqjoymA4JuaqepvwJHuV1PDSoKmqcgFOKuswVOTcfSBWBaKCSUCnEt5YBtX
         fwEMM/EVakz5gk4LrX2s8c1ysRJa8qF2cjK4LDRGYHLYPwzuVGZDJ5Y4wEi+kiTiz4EA
         q3Lz0uMYioJCVy0phEuJvICLf3r3Q4c8R1fVICYcNbH/0XU3xAVk8owuuef608PDr82m
         mMxDRLbMc5nP5yv6jNw5UX/jGdfDDu6EuCyvdqNSwxGikV4XfPSOT3dfNyIwXl7GiTzm
         oAX4ZXyU5cGJSVa87Nb6YT8TXxNocp29ySApVipt59dZSAK7oLfSmJ7as5ri6tRLr68X
         Vlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o93J3BNmQ1ja0KQUj6SiJX6FygDGjFCA6M1dZJot1uE=;
        b=dzCd4u0P2qI64vAZCWwA1CNXtsKo1AAVSzVSnVJcn5CT6iPmmZglyZOJ/NYr3afO9j
         FEZU4Uj614tPnFvIq9pEWqiYa0ujAASuE1vQZ6Q7Ip7KKWLesT8YhKgStAMy0nOtRQJZ
         QCbjTubauNj359AM+66pEhoW+YfA4yiqBJ0IJkbuxHM7GCiR3jD5wu8c4RfEUSNqtIJj
         R/18dTJdKj1e2A/lCAAcRYHxa6aWLGOO/q98V7iT43TlY4cdM4SZ48PL1V9njfkTg0VX
         qackLIk/AY2aXIr5DadK17YqUgKOJcYiln7ZCBFX6Q69jsjjI8v/vb+lg7DGwTRzFGXy
         L/NA==
X-Gm-Message-State: AA+aEWYME7s6KwopuRlQ92AKoD7LGqNB2EiTbVTl9Cd2MAeQ+LvMS+VF
        Z/oZXkvSYgy190x1HJ8Z8/E=
X-Google-Smtp-Source: AFSGD/UTuZcoUTgvcKZD8g8ZJhdVgVKkGwCPqTfRkk2QrIYj6gUJ0dlZymb2tUE69mD85Dnk1vdRsw==
X-Received: by 2002:a17:902:12b:: with SMTP id 40mr1893146plb.72.1542985563210;
        Fri, 23 Nov 2018 07:06:03 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id u127-v6sm62690898pfb.47.2018.11.23.07.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 07:06:02 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linus.walleij@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: nomadik: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 23 Nov 2018 10:06:00 -0500
Message-Id: <20181123150600.27445-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/clk-nomadik.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index 84a24875c629..e331634d34df 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -479,17 +479,7 @@ static int nomadik_src_clk_show(struct seq_file *s, void *what)
 	return 0;
 }
 
-static int nomadik_src_clk_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nomadik_src_clk_show, NULL);
-}
-
-static const struct file_operations nomadik_src_clk_debugfs_ops = {
-	.open           = nomadik_src_clk_open,
-	.read           = seq_read,
-        .llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nomadik_src_clk_debugfs);
 
 static int __init nomadik_src_clk_init_debugfs(void)
 {
@@ -499,7 +489,7 @@ static int __init nomadik_src_clk_init_debugfs(void)
 	src_pcksr0_boot = readl(src_base + SRC_PCKSR0);
 	src_pcksr1_boot = readl(src_base + SRC_PCKSR1);
 	debugfs_create_file("nomadik-src-clk", S_IFREG | S_IRUGO,
-			    NULL, NULL, &nomadik_src_clk_debugfs_ops);
+			    NULL, NULL, &nomadik_src_clk_debugfs_fops);
 	return 0;
 }
 device_initcall(nomadik_src_clk_init_debugfs);
-- 
2.17.0

