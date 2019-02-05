Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F33C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E09320818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH1ZW5E4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfBERN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:13:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38586 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBERN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:13:29 -0500
Received: by mail-qt1-f195.google.com with SMTP id 2so4673634qtb.5;
        Tue, 05 Feb 2019 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vFSrBwfGt5LBuMGMNCi1mHrZCrU6Rt7g9XGY2s5Y+K8=;
        b=QH1ZW5E4ujvJyhiMA0rYxAQm6pKydOyS7KQGmMyjR+QTVu0VD1k5vKXvd5xkL3V2EA
         K+7Y1docxLclppcQ1UhxaXzXNuUk7ME04xOOL1PO8VfCTPr+L5o6trl6dnydEn75kcjA
         SLQa0asIFEob/SbhiPUk4TwdOpc/12BneIH6o5sk0Yfht8voBRi4ErEsrqtd5fi+TC7M
         /xjZxQScb8eoLWfZzC1OJx3gJhzq2zSjBW2kEcN9r/wr7ULJ96pWANqhqQwepiRlRF2h
         /WusKxDAgUjldLBikNLr0yPKfl/Oa8hsh1XcRTCQ9tPRIdaDUYcNHdGe+qWl2XshddSV
         ACgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vFSrBwfGt5LBuMGMNCi1mHrZCrU6Rt7g9XGY2s5Y+K8=;
        b=ALNyrcLUo0e3JApjIwThHYLmZ+HRA3C8Oqua61Pvlalz8idPgdZZVfUlE0jKiLidbI
         QAv+NzqEoz79nrmYFUbavyxCdYlAg34MInVXQcst6fiowVvtkKSEMlSVBQ/+mWFVF8Iw
         QZ6PJj/d3V1geLYqh2/udMspHgKnqqwMpYskFFqRgkHFJLAZte7yQoCD3DkuxltQ0Ue3
         eY+Brhk2e75tsrxbIIrlSui+gS//NUCsNXh5+WnwghAA6aAAxuMBgBsbVBP2Cy4DCc+t
         qzWA01kcBRd0v4KVkyP7gyU6GviQ+dWcwMh4880CooLhHE/oJVR+hus3G0euAzTnAlIp
         DAqA==
X-Gm-Message-State: AHQUAua7+8ypSmiDS9GgjK8pfuIgBPaJCHKMaewuYuuZq0/XIw9AVJfO
        aQKdJ8bbCk8f5YzFCqabxcY=
X-Google-Smtp-Source: AHgI3IbmVxgPWbaXEgSo36iKC8O2czQ0EywsVxcv2hivA1z6Hv2GjVA+zXLXGf04fimdQsTrY0EOQQ==
X-Received: by 2002:a0c:eb4b:: with SMTP id c11mr2664184qvq.207.1549386807612;
        Tue, 05 Feb 2019 09:13:27 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o25sm17588252qtj.10.2019.02.05.09.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 09:13:27 -0800 (PST)
Date:   Tue, 5 Feb 2019 15:13:21 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 2/4] staging: iio: ad7780: move regulator to after GPIO
 init
Message-ID: <b2380d77d09abdf63d6f6471ed7743f8bec14a29.1549385784.git.renatogeh@gmail.com>
References: <cover.1549385784.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1549385784.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To maintain consistency between ad7780_probe and ad7780_remove orders,
regulator initialization has been moved to after GPIO initializations.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 6e4357800d31..7804cd2b273e 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -250,16 +250,6 @@ static int ad7780_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
 
-	st->reg = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
-		return ret;
-	}
-
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
@@ -279,7 +269,7 @@ static int ad7780_probe(struct spi_device *spi)
 		ret = PTR_ERR(st->powerdown_gpio);
 		dev_err(&spi->dev, "Failed to request powerdown GPIO: %d\n",
 			ret);
-		goto error_disable_reg;
+		return ret;
 	}
 
 	if (st->chip_info->is_ad778x) {
@@ -290,7 +280,7 @@ static int ad7780_probe(struct spi_device *spi)
 			ret = PTR_ERR(st->gain_gpio);
 			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
 				ret);
-			goto error_disable_reg;
+			return ret;
 		}
 
 		st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
@@ -301,10 +291,20 @@ static int ad7780_probe(struct spi_device *spi)
 			dev_err(&spi->dev,
 				"Failed to request filter GPIO: %d\n",
 				ret);
-			goto error_disable_reg;
+			return ret;
 		}
 	}
 
+	st->reg = devm_regulator_get(&spi->dev, "avdd");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
+		return ret;
+	}
+
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
 	if (ret)
 		goto error_disable_reg;
-- 
2.20.1

