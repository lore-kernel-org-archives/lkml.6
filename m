Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0C8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E7D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipmAwLoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfA1Ei3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 23:38:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42473 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1Ei0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 23:38:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so6676347pga.9;
        Sun, 27 Jan 2019 20:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MPWcbUstqFpEgnc03CLZkCZAC6mq4Ybn4S/kPuTy/ws=;
        b=ipmAwLoaBWv/TLMsJ+mKTH0KkW7FWNG8eSKYb7qA5z2LlEVwfB4yVSn/XrSXKxQUzR
         o9+snaZrcfmurDcs8Btfokt241OjbL7xkCWZZ+IzcDe385DoMJkrrIs78A02IPe7ohkX
         JF6rKOUzLU4j9s8UxmUyUYsCHfoGuT4keWV6QOabdpj0L+DLyhEpKZoCc6qbDpZH/DfJ
         8dSGqN8IwbwLbaWW2yMMdAXu4XCSzlMxiERFLi9B07aJRfOr8c8Ve0XuqU2fLt/oNQLj
         CNgP62MnsvxmwdN+Hz+YrWz5SqSGudKm3uQjsG2ngG3BXB/e9CED2/AMWFNGxlRdROUV
         dDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MPWcbUstqFpEgnc03CLZkCZAC6mq4Ybn4S/kPuTy/ws=;
        b=Ib7VfIJpgaM2EDaSQzd/uFIuDv4CMcwhA9aIoGlxGbWPoT2INf47hiBHaZrJf4Ziql
         UpO7+wrvZRJNMS84iOeolm8ZPL1d6MKMsSZ8bBUAo2VZy6KUyI9qXwJsXLJH7BcB2AjR
         7dZuJ15zNHZTYpEUIaYCGu3oAXqdxlw9zxxUbA/3RD4q8DAuCU1ddW2nMWLnguwDzZfK
         TJO/GPLIk3qwE3qbWx98rGctE88pQODSV1XTX2EHnT1U68j60rX8UwMb1xsqxdIyPhdD
         IhZAs8SEX2HNPklt7R3A5FAvB+glkKCQZM/x1sxrRyuCFtn6Zk1O69laXltLg9IDyktK
         Wtgw==
X-Gm-Message-State: AJcUukf4O9bq2NrHpcIvndiqHi7LCeNcQq0vySspLLmfSmzHtKwM84M/
        SWsciohFVDNsoueOT/Bwv+k=
X-Google-Smtp-Source: ALg8bN63rkxPr+vk0J+mKW4sKPvFrAuJIKfPega12ehccwCulb3qJZhYjU4d+h1z6r6nqIC2sTFh1Q==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr18610562pgb.101.1548650304741;
        Sun, 27 Jan 2019 20:38:24 -0800 (PST)
Received: from chikyu.mistral.in ([202.83.16.90])
        by smtp.gmail.com with ESMTPSA id c23sm37045358pfi.83.2019.01.27.20.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Jan 2019 20:38:24 -0800 (PST)
From:   Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
To:     sfr@canb.auug.org.au, linux-next@vger.kernel.org
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Subject: [PATCH] extcon: Fix build issues in ptn5150
Date:   Mon, 28 Jan 2019 10:08:12 +0530
Message-Id: <1548650292-15762-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <88f71303-575e-6680-a207-da102bda8ef2@infradead.org>
References: <88f71303-575e-6680-a207-da102bda8ef2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- extcon-ptn5150 driver uses gpio libraries
- Add GPIOLIB in depends section of Kconfig

Error:
-----
>   CC      drivers/extcon/extcon-ptn5150.o
> ../drivers/extcon/extcon-ptn5150.c: In function ‘ptn5150_irq_work’:
> ../drivers/extcon/extcon-ptn5150.c:130:5: error: implicit declaration of function ‘gpiod_set_value’ [-Werror=implicit-function-declaration]
>      gpiod_set_value(info->vbus_gpiod, 0);
>      ^
> ../drivers/extcon/extcon-ptn5150.c: In function ‘ptn5150_i2c_probe’:
> ../drivers/extcon/extcon-ptn5150.c:242:2: error: implicit declaration of function ‘devm_gpiod_get’ [-Werror=implicit-function-declaration]
>   info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
>   ^
> ../drivers/extcon/extcon-ptn5150.c:242:53: error: ‘GPIOD_IN’ undeclared (first use in this function)
>   info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
>                                                      ^
> ../drivers/extcon/extcon-ptn5150.c:242:53: note: each undeclared identifier is reported only once for each function it appears in
> ../drivers/extcon/extcon-ptn5150.c:252:2: error: implicit declaration of function ‘gpiod_direction_output’ [-Werror=implicit-function-declaration]
>   ret = gpiod_direction_output(info->vbus_gpiod, 0);
>   ^
> ../drivers/extcon/extcon-ptn5150.c:271:3: error: implicit declaration of function ‘gpiod_to_irq’ [-Werror=implicit-function-declaration]
>    info->irq = gpiod_to_irq(info->int_gpiod);
-----

Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
---
 drivers/extcon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index b9cc027..330dd8b 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -116,7 +116,7 @@ config EXTCON_PALMAS
 
 config EXTCON_PTN5150
 	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	select REGMAP_I2C
 	help
 	  Say Y here to enable support for USB peripheral and USB host
-- 
2.7.4

