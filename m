Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F1AC18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC00720672
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qvTWc1lR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC00720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeKUAJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:09:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35280 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeKUAJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:09:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so2283187wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nmnEbWBrxg7vL8jw6YxuuzUlYQ5AMTGgBKEryzY0enE=;
        b=qvTWc1lRZBfF6jKDFeXEVUHjKglpShD3SOlVQx0TEPCYMdGBK+O3Wi0BIvpSiZtSCT
         jBt8J4WFMK4zkjsXTb61cGyteX/aY1WPloYgtNKpyu8EUSq2cYEVEmN3I1jGvwfDJudB
         Wz3fJXxAGOq05q9lbkVwuzV/Z9QfBY+aVIPZ1UujqOYsQNLGgcvHXwaklXRvF6psArL+
         kVALJj6Ft0eHd7cdRrxZC3sZAKP60dccxAQMt0cEI3UkoEaZHqeT+7A4xvJf0LSotvlu
         TagZ1EXjWhMdXSJUzvwB6ofK8FKFCTkE/emM3SiFdWJFf1ngiYpMrqz9jlq9UF76TjE6
         uHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nmnEbWBrxg7vL8jw6YxuuzUlYQ5AMTGgBKEryzY0enE=;
        b=IrlON6acYO/3eI2kT+gQ+Xm9LUYpZWZV2+NDqu0wdJGB8qzuqU6QfXG7gv73FPTApX
         osaLtm3hbYH9QRDRIwqL1K5OXv154M+3Ts2htNOi1EwFYXTy6axqpGaN5AJG0SSze/n0
         jzXEfGhUCRjG0aNgiArJc3dZebi+oWEY/bBKwLnzhtA0Cx9rfX5iWG5zI/eELlZQJrZU
         jrASCBurD9trjgIDWM6i49IDzabBb1oraYaKbfmWyVA1LnwTK7Jj1gr4KALB/21IWloE
         aeMdqVMvjLXFDu8SSOz6fm0fkwEMfnm0o/E8FuEhSbc0ib7XtOQjAhX7p1M7BOPb03xf
         wifQ==
X-Gm-Message-State: AGRZ1gLNLGBTQsCcjPKKnJxbNX+lv0FGTno5oZXftrslbf/KYVoxs6rQ
        eIiqVTUqlsnLAAcF5RVjaG+DbQ==
X-Google-Smtp-Source: AFSGD/WPPSbwlhUZHarQ6057OZYheWiUKvei0lG/L7uBh4GXdda2VLuL09I2CY+A66m8aIseGuwUYA==
X-Received: by 2002:a1c:38c5:: with SMTP id f188-v6mr2197204wma.19.1542721241912;
        Tue, 20 Nov 2018 05:40:41 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id j129-v6sm36962901wmb.47.2018.11.20.05.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:40:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] gpio: mockup: use irq_sim_fire_edge()
Date:   Tue, 20 Nov 2018 14:40:32 +0100
Message-Id: <20181120134032.31645-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120134032.31645-1-brgl@bgdev.pl>
References: <20181120134032.31645-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a specialized variant of irq_sim_fire() - use it in
gpio-mockup so that we only generate events of types that were
requested with the LINEEVENT ioctl().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index a4c054cf9c5f..18563d2c7876 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -199,7 +199,7 @@ static ssize_t gpio_mockup_event_write(struct file *file,
 	struct gpio_mockup_chip *chip;
 	struct seq_file *sfile;
 	struct gpio_desc *desc;
-	int rv, val;
+	int rv, val, edge;
 
 	rv = kstrtoint_from_user(usr_buf, size, 0, &val);
 	if (rv)
@@ -213,7 +213,8 @@ static ssize_t gpio_mockup_event_write(struct file *file,
 	chip = priv->chip;
 
 	gpiod_set_value_cansleep(desc, val);
-	irq_sim_fire(&chip->irqsim, priv->offset);
+	edge = val == 0 ? IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
+	irq_sim_fire_edge(&chip->irqsim, priv->offset, edge);
 
 	return size;
 }
-- 
2.19.1

