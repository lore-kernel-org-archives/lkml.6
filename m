Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0783CECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B047E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ied9QGRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B047E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeGQQqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:46:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43081 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbeGQQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:46:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id m12-v6so1251432lfc.10;
        Tue, 17 Jul 2018 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KnG5C/UX75bKySjpKhm1+nD3w7q4ygAjbkqdm8WfYzA=;
        b=Ied9QGRi9AB/X8s644eDDawMtdkYXZd+y657fpq4OH3LVTV13ANJ+Lzdn3j25Bd/hV
         vJ8EEIjSZqLRcgoMjy5v8CT5pWFoTPGRLfAjDDCEBsqLmwmVNcMsL6zETm+ix5urlwpd
         uMY6mPvVsoplfnx4+CwLPUOxwIpVvhZeffsKWPHYZnxUTB0gZ7gmmBp80Nr5AvET8LQG
         Sbkbfqwb04iAhW3nHufdP+dNL+MWLEJNBRDbB2mGthMRMvx8TEWrAy+1CetJp7nEL/yB
         XWMpSwH1USfWf1JqQHLPmdgQ4+77UH/AaTs0P/7sMWT60XFrRPBOzZ7cYOB604s+quwW
         EUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KnG5C/UX75bKySjpKhm1+nD3w7q4ygAjbkqdm8WfYzA=;
        b=OHQMjDpPXdwEkLRcZnPAKolDU5r6YTW2S+ZtTngbrgNk/bexVU6iKB2lC4zInxX/Hv
         62bBt+HecBT5cS2Yxnp9lrXQHBxgeexJB26k0Xnijpy4FcIpEacA55of7kqaZwBaOtVz
         C3NRLQBQdek8hhMom+OZ8XiQJNeu5TqpJ5ji1uGV535hxnPOLcj9b8Uoa0VhXlSHU3F1
         WYIIquqrS+lUnoQ2TXoNtFQV/1ctU6mm2C1jCuealTH9JgBXp/P+wIT/nQOvgVk9u+Tn
         zBvBnXuWNnT5z3xauS3DMkgHx4jZsfPt6PEqXXkzOynFXJYAScuzujfbZfIyVlBZr2MA
         pEDg==
X-Gm-Message-State: AOUpUlGnbZW9XHqhzJP7qKxIfPJj8xan2LW8l/X3fcPKQrM1TWK9OHW6
        Nuw2M/7Bm4W+o6AM3kQySns=
X-Google-Smtp-Source: AAOMgpd6IM4qfb7EVASdOMkE8PonE8L+0CYUq3Tn8yUqOfPR8tg+vYkbZOrI0E+j3qL5KnGtULJOew==
X-Received: by 2002:a19:6902:: with SMTP id e2-v6mr1627426lfc.70.1531843958593;
        Tue, 17 Jul 2018 09:12:38 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-91.nat.spd-mgts.ru. [109.252.91.91])
        by smtp.gmail.com with ESMTPSA id t2-v6sm226202ljj.46.2018.07.17.09.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 09:12:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: tegra: Fix tegra_gpio_irq_set_type()
Date:   Tue, 17 Jul 2018 19:10:38 +0300
Message-Id: <20180717161038.21500-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
broke tegra_gpio_irq_set_type() because requesting of GPIO direction must
be done after enabling GPIO function for a pin.

This patch fixes drivers probe failure like this:

 gpio gpiochip0: (tegra-gpio): gpiochip_lock_as_irq: cannot get GPIO direction
 tegra-gpio 6000d000.gpio: unable to lock Tegra GPIO 144 as IRQ

Fixes: 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpio/gpio-tegra.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 94396caaca75..22e7c99ed69e 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -323,13 +323,6 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	ret = gpiochip_lock_as_irq(&tgi->gc, gpio);
-	if (ret) {
-		dev_err(tgi->dev,
-			"unable to lock Tegra GPIO %u as IRQ\n", gpio);
-		return ret;
-	}
-
 	spin_lock_irqsave(&bank->lvl_lock[port], flags);
 
 	val = tegra_gpio_readl(tgi, GPIO_INT_LVL(tgi, gpio));
@@ -342,6 +335,14 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, gpio), gpio, 0);
 	tegra_gpio_enable(tgi, gpio);
 
+	ret = gpiochip_lock_as_irq(&tgi->gc, gpio);
+	if (ret) {
+		dev_err(tgi->dev,
+			"unable to lock Tegra GPIO %u as IRQ\n", gpio);
+		tegra_gpio_disable(tgi, gpio);
+		return ret;
+	}
+
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		irq_set_handler_locked(d, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
-- 
2.18.0

