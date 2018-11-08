Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BACECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC21A20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="2CWEW0LS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC21A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeKIC3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:29:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41600 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKIC3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:29:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id v18-v6so2702923wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GwZ4kCn0pUIbC4Baifciq+tWo366hhq+7YU9gxlpjWY=;
        b=2CWEW0LSLbtDykunbHCkuFxjCRA5vxuhJKV8ZS3QfMfy6QPJHzB7zC/5BdlWkEQ3Be
         W6TVaUB/cKyilVRz0vdxNiliTTnP/WxbokNm2pNzyN07VQ7fEspGoPwAulFU92wz2Qkr
         vMwrTuRSEhq9enJsgex8Ffd7qgwDbYxTkmf2GoqSNyJxTPYgtafGeO+JrkA22nf+XI6b
         NzZaxPE2emQNZq93Lh5V78gqk6Q9gZqV8P3BEPaB8DWcPbyxuxvFXkU3mKa+C3vDlUXZ
         hZG3AdDOYv3xbEQVjnKUMd7XtGHFp0Us0dJle15pwK62pMrOlrCDa+9vm3FvTg2ywEtf
         WTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwZ4kCn0pUIbC4Baifciq+tWo366hhq+7YU9gxlpjWY=;
        b=JHyfEHz1SepYn004FrYRtafA5nmZ6eA6AMgL1WWht+ZKCsk5PTnL8+Cb3q+WwhNjdS
         4Je50gC/NaJVsAU3ymHqIsN5B2qQBIIIvxCSTheZJzOvmsdJ2jjEWNPz5+I40DflIsG+
         +i2IezxMs9WWHTjE+am3OAUIObgj5pfH9whSp9wj3wzXBmCgZfDdB7CjgdOBG+oEEg51
         U5CbZd/yhQymQGiDwOvM1W25J6MmNCGx8v5PenhI5HO5t6rPsb0I7vh3sU0FhCGg0Eot
         8IjaT8Hm7OVUCZdWqo5i/n3D9vuuqxn4syYy0O1k/HyMA+oF7ShqtdF95KbmgqwTSylA
         qHyg==
X-Gm-Message-State: AGRZ1gIiHV144ZDi+GWyNc97mdCUaxKYbLC/gSC2BUrVdysIR/d9Vf99
        cVMUr2pdefokZfu+8wcGNdzYBw==
X-Google-Smtp-Source: AJdET5ee5cpAXJcVHKhW/HPr3CcHrfLQt8SErOFqsrV9SVEkZRbZsbCfwxcjG2iMpYjcTovoMP7Aeg==
X-Received: by 2002:adf:f148:: with SMTP id y8-v6mr4989094wro.303.1541695989486;
        Thu, 08 Nov 2018 08:53:09 -0800 (PST)
Received: from debian-brgl.lan ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h5-v6sm7815987wrs.51.2018.11.08.08.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:53:08 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/3] gpio: mockup: fix indicated direction
Date:   Thu,  8 Nov 2018 17:52:53 +0100
Message-Id: <20181108165255.9940-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108165255.9940-1-brgl@bgdev.pl>
References: <20181108165255.9940-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3edfb7bd76bd ("gpiolib: Show correct direction from the
beginning") fixed an existing issue but broke libgpiod tests by
changing the default direction of dummy lines to output.

We don't break user-space so make gpio-mockup behave as before.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-mockup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 8269cffc2967..6a50f9f59c90 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -35,8 +35,8 @@
 #define gpio_mockup_err(...)	pr_err(GPIO_MOCKUP_NAME ": " __VA_ARGS__)
 
 enum {
-	GPIO_MOCKUP_DIR_OUT = 0,
-	GPIO_MOCKUP_DIR_IN = 1,
+	GPIO_MOCKUP_DIR_IN = 0,
+	GPIO_MOCKUP_DIR_OUT = 1,
 };
 
 /*
@@ -131,7 +131,7 @@ static int gpio_mockup_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	return chip->lines[offset].dir;
+	return !chip->lines[offset].dir;
 }
 
 static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
-- 
2.19.1

