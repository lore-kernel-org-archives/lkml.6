Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183AFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53E02098A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQYh/Sbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53E02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeHPVwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:52:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45562 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeHPVwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:52:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id w16-v6so4458629ljh.12;
        Thu, 16 Aug 2018 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=clYKojRQUsud5/ZvoYLWTCNK/A+DZ2sQsL+x7p9aJj8=;
        b=KQYh/SbtXmNnU+XspWqhx/JIOH8EE6eNoFjBWcwPeCX59TgCKnV8cvzeee+87w8Xw/
         Td1DY8usc4+2cGBsuzsdDwhrtB2eAL6rsSIVV1EDOOVJkMyLJ9gWeBNZHKNIm4jBADoI
         RLmcchGbCSXwulEbWjGVrE88ZxXgnOVHxwGrmGlej5A5QHc2OQzu2IttFA29ChUf1lG7
         uMr9rFghAIbDBbfKpEBLJmz3Q1XNwRd9wGX7pidIUEPcRhPCrRBG6ghb9I8ztulYwF6i
         nMRAkClIORSFjpWz47vmq+XTEsHWI3Eud+Kb7b+ecYfjU4p+/CD3VPUA6mERtovyijGn
         1Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=clYKojRQUsud5/ZvoYLWTCNK/A+DZ2sQsL+x7p9aJj8=;
        b=IM9aHZfd6QeYfSXrXLqRrYDSo92JD1Jk6iiNPEwvvtC1lin1hCelcnRArzkNOfqzXQ
         g4hEIzJ2+QQ/MxbY9JhXlyZovFy5+Ca2L+GcXU3WHOWOLS75nLxnKiyscmew4KNsvlsf
         98FXePrm+Zahmy2ZrZ1AewlkNhVK5tVZ5x/W2MTVH7xm4LGDXu+KEC+DQl8/MCKQcf+W
         p4lsTm7uPFGLumCxcpc5pwn/DEuyo5fWrFh6wcFxjF7Pda/JkFonvvcdzTyRVT8B+HGa
         zUXCGjvKImNOeZeXS4FbobYrh/wSfmsuRwfQU05KCzQul7SYcUEs+fZGqzYBa/LIb2Ku
         khxQ==
X-Gm-Message-State: AOUpUlEsojC18M+8vV2hgwleSGb4aClZR81JG99U3aZZtDBiU5+Z/XL3
        Gc0wmJRNgPjXMFnNzoHA59oZ3UZE
X-Google-Smtp-Source: AA+uWPw0cpr2gs8GGLKO+mYmQQfnh+tOWNqFFLJp2rJlK2xTONDADVwy12wkl5UyYrhfoT70J1dr2Q==
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr5165172ljh.6.1534445511268;
        Thu, 16 Aug 2018 11:51:51 -0700 (PDT)
Received: from localhost (89-70-31-6.dynamic.chello.pl. [89.70.31.6])
        by smtp.gmail.com with ESMTPSA id r73-v6sm14748lfi.34.2018.08.16.11.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 11:51:50 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org
Subject: [PATCH] iio: pressure: ms5611: remove deprecated compatible strings
Date:   Thu, 16 Aug 2018 20:49:15 +0200
Message-Id: <20180816184915.32138-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatible strings tend to follow manufacturer,model format.
In case one wants to do a matching with manufacturer stripped
off he can still do so since SPI/I2C core will try id_table
based matching anyway.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/ms5611_i2c.c | 2 --
 drivers/iio/pressure/ms5611_spi.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 55fb5fc0b6ea..0469c8ae1134 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -117,9 +117,7 @@ static int ms5611_i2c_remove(struct i2c_client *client)
 #if defined(CONFIG_OF)
 static const struct of_device_id ms5611_i2c_matches[] = {
 	{ .compatible = "meas,ms5611" },
-	{ .compatible = "ms5611" },
 	{ .compatible = "meas,ms5607" },
-	{ .compatible = "ms5607" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ms5611_i2c_matches);
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index 932e05001e1a..cd11d022208e 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -119,9 +119,7 @@ static int ms5611_spi_remove(struct spi_device *spi)
 #if defined(CONFIG_OF)
 static const struct of_device_id ms5611_spi_matches[] = {
 	{ .compatible = "meas,ms5611" },
-	{ .compatible = "ms5611" },
 	{ .compatible = "meas,ms5607" },
-	{ .compatible = "ms5607" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ms5611_spi_matches);
-- 
2.18.0

