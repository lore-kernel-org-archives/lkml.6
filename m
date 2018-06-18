Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F82DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D08720862
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjPX4BuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D08720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937030AbeFRXjC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:39:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39137 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935955AbeFRXjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:39:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so18605422wmc.4;
        Mon, 18 Jun 2018 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tSJ0PFRtIPJQzQLdadhSLw5MtRHuUy2M083CJAjO5OA=;
        b=HjPX4BuAwa5AXM47jCJdL2m2/2eo//Cmas39Ezf8A/n768V2wFUbNmn/h4MHQFoHyl
         L8JT0VoAA/vW9/nvX3zi3Xx3jhARwvG5U0N+axqc/jYuceE5xZzm5o3ztTjmAhWsrXY0
         dk7WpPOptCo2su32/qydpaM5JHgU6/Pl5gh9aSk6eNcPECtIN6dwdfGWA/pi3CN0AO+X
         TJ2ypuzF931GR3y99hupIsNwTIbaRWGqgOMvWg2V9bHJXAFbTa+PG9E2K+gtZMrrHxR3
         +EzmRmbPzth6ofNxYJyV7KtUZBIMovjkVf1xuzdJhIlO1LHK64ygBseOOQo3Z4oZNrPL
         c8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tSJ0PFRtIPJQzQLdadhSLw5MtRHuUy2M083CJAjO5OA=;
        b=EWFq2LuskvBWRmI26LeOMzdpj/Ci2E2PxMyoFenKr1b3TzB8wVO/6L5YFu82aOHk1C
         W0u6NHausWUaj6q28DcuEiP4S5fv1//7wI7Qyf8ePpoSrHBs876C4aUPsFAgKhk53zNu
         /MMAJtnJIdBrj2N8fSdM2zQ3UmclI3tOsJJZyrxqo4emAls6QMgonLc+fnrmyaTPc8qm
         3y/rIfo4OjnXVkbW87p1/731KxQsT8jFFdY9Zgn/HUvF8QkK6H7j5LQpvkl/LuMUBK+z
         bQi8qElMlZ951CEEclzW0dW8xjaIJkOHlU+F/8eUwL+cK6OAYMZP5r9Kl5CcVpBmUt3f
         7N2g==
X-Gm-Message-State: APt69E2YyMdXm6duOYO0xjgx1nwo2ZgjQXiSZvDZ9Z415HAy1ceWRB2s
        VavvCX+QnEjivGXz4veLGVs=
X-Google-Smtp-Source: ADUXVKLtvE9fIdnMKEgBYUvVy6h+tiNq79IhZIVi3OH5v0N7bfW+e0ICz97RyVE4OZHehaPVFSeZbQ==
X-Received: by 2002:a1c:7d94:: with SMTP id y142-v6mr10360497wmc.107.1529365138702;
        Mon, 18 Jun 2018 16:38:58 -0700 (PDT)
Received: from localhost.localdomain ([156.219.79.32])
        by smtp.gmail.com with ESMTPSA id m16-v6sm14943704wro.91.2018.06.18.16.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:38:57 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:adc:ad7816: Backward resources cleanups in probe
Date:   Tue, 19 Jun 2018 01:38:51 +0200
Message-Id: <20180618233851.7992-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backward cleanups for all resources allocated in probing
in case of failure at any regestering or allocation step.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index bf76a8620bdb..5ff14c830451 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -373,7 +373,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
 			chip->rdwr_pin);
-		return ret;
+		goto device_free;
 	}
 	gpio_direction_input(chip->rdwr_pin);
 	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
@@ -381,7 +381,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
 			chip->convert_pin);
-		return ret;
+		goto free_rdwr_pin;
 	}
 	gpio_direction_input(chip->convert_pin);
 	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
@@ -389,7 +389,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
 			chip->busy_pin);
-		return ret;
+		goto free_convert_pin;
 	}
 	gpio_direction_input(chip->busy_pin);
 
@@ -407,17 +407,29 @@ static int ad7816_probe(struct spi_device *spi_dev)
 						indio_dev->name,
 						indio_dev);
 		if (ret)
-			return ret;
+			goto free_busy_pin;
 	}
 
 	ret = devm_iio_device_register(&spi_dev->dev, indio_dev);
 	if (ret)
-		return ret;
+		goto free_dev_irq;
 
 	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
 		 indio_dev->name);
 
 	return 0;
+free_dev_irq:
+	devm_free_irq(&spi_dev->dev, spi_dev->irq, indio_dev);
+free_busy_pin:
+	devm_gpio_free(&spi_dev->dev, chip->busy_pin);
+free_convert_pin:
+	devm_gpio_free(&spi_dev->dev, chip->convert_pin);
+free_rdwr_pin:
+	devm_gpio_free(&spi_dev->dev, chip->rdwr_pin);
+device_free:
+	devm_iio_device_free(&spi_dev->dev, indio_dev);
+
+	return ret;
 }
 
 static const struct spi_device_id ad7816_id[] = {
-- 
2.17.1

