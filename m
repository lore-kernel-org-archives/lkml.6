Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518CC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F122192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="d/h0ERZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395231AbfBOPZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:25:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52362 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389223AbfBOPZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:25:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so10343401wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1lfqJzHdcjA20Q30XeL0tcyEj0lgU0X5EuBNLTHV4pc=;
        b=d/h0ERZWKXp4REc8nmbVASzZDJaeMj9gc4lq98tpyMgsmLH3pDj/UIilglcb1PpeHl
         G0L82i2AZZ8X0RfPjT9n5XuPj2yyMaOT4B6YEBdorlXLABI3n3nvS+8r2sA5xQbV8hi5
         xHVz8pakGx1UODt1Ool4e68LRvsihHQewzzeFAI6ASgnIeverIMmzFZFZ79UgenIZraP
         /bbyBmnk3d/tevqwz2dAgA/iorQIYolezE/3ChdFVWDzDmH3EHrKXEhOhsPz0oGeouPr
         sLvRdwo2EhJWHR2HruzrpcGwrZEAgV/2WIwXKJbsRDoWPXWr9IXLtupUWpm5MQsPmqJj
         qJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1lfqJzHdcjA20Q30XeL0tcyEj0lgU0X5EuBNLTHV4pc=;
        b=qzVVa9JOtwdrC6oKYq+YSWdstTWdkRso4jhs/EzURjZStNluSLpLFyy9/SKNyDSA1l
         bTaNTAEJb/BUQs9SvO0tUqNyKunjRbtKlCExgY36drFy52+zRnmrSBrFCsIa/HhDk/4E
         /sBqt+YCfDImH/kQ33ibxq5AITempyYIEqgbue+oi579f306nYoWuekiLyp0oU08h9ly
         4AcYzPGHf5jdp2140pUwWOXmna34XXbs+MsJ68y/mU7Xopjek6xUPKMn2F7yXAbBUENl
         yL2dqa2SUWwg1+OJU6245aJJ0TItfWmTLqhVZb2fuNSzpSkAuwCA5jLvw6a0KyC7z4U5
         ApUg==
X-Gm-Message-State: AHQUAuY+exCeu4fUy8bzGXwOv2jyzLkOTjhAQ3ErYPNJ0VCnj1SZu9N1
        an2/V2uG8w9UIvoJ149rABpjoQ==
X-Google-Smtp-Source: AHgI3IaD6o8KRxqbx1iwGop9lbPLonPTqOcj4j5CrTevs4ua1VvaWaR5wLVBPkv5emX0QnZceUpskA==
X-Received: by 2002:a1c:7903:: with SMTP id l3mr7372371wme.22.1550244319449;
        Fri, 15 Feb 2019 07:25:19 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id y5sm1904337wmg.31.2019.02.15.07.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:25:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] gpio: davinci: use devm_platform_ioremap_resource()
Date:   Fri, 15 Feb 2019 16:25:07 +0100
Message-Id: <20190215152507.31066-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215152507.31066-1-brgl@bgdev.pl>
References: <20190215152507.31066-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new helper that wraps the calls to platform_get_resource() and
devm_ioremap_resource() together.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-davinci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index bdb29e51b417..188b8e5c8e67 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -198,7 +198,6 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 
 	pdata = davinci_gpio_get_pdata(pdev);
 	if (!pdata) {
@@ -236,8 +235,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	if (!chips)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpio_base = devm_ioremap_resource(dev, res);
+	gpio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio_base))
 		return PTR_ERR(gpio_base);
 
-- 
2.20.1

