Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8E4C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDBF20685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="GUubobDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDBF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeKDIDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:03:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41411 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeKDIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:02:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so8946076qkj.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GD4vVE0HPom8l9DS59ZCy1DA4DKNmflT3aSJsaYUcgA=;
        b=GUubobDbcf/zDkYhIxxdggdX5hJks+0xN50pfmTtNVPHJ/FsxiA37fzyP7ZUQFQXKZ
         XzKqgVBBVFS6abh6HRkRZYMjN7nr+U6nWU7NcwP/lkaojZlhWmiQ4P33MfOqGCjMVTZA
         70ZnLGQg90J7uWn5E9GM4/A7KLkwxnnrDTvKOXckH3UqGO3uQKdw4Q6U/tHi1Y7efaTh
         jr78V2ovjPRAN4ecvL1Vfs0UwZZHkZuM7m1OwxPiXu1k9VdT07nIWAImtGDVUvVI1n9G
         BeAyPXxh+gzhcFDkiyj6lpI29neTAcVbx+aeKVWA8IPl+ugesdmkbUPHjJ7FmtH4VAcf
         +wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GD4vVE0HPom8l9DS59ZCy1DA4DKNmflT3aSJsaYUcgA=;
        b=hzeX+7pg9gk89P0CB/1XovYUPAtlvpE2DOZJjRAlOHbjC1xfJ8ARicHocU3R1m8xHA
         5lAV7dAyTuMRRj1cI9pnQAvIQkHPmJilvphcEy4we4k86E0bHqvijhCjS9ZD1Jc7nkqT
         E81RYBcNM6GcgG6xylyogQ4xjZhZSmc8i8od84sMhNoR4OQ+8Ru73R4fYPdkHapDTk8B
         aqz8yz1bFx5/Hk4qEjMTPMeOqbtWTlEMi5XFXYnpoSYeo/c8MU6PCb8Zc2B1fEUHRk+h
         z36c63OuSqIUoY510mjMEUrbrd83D2tPFDRBTz7P8Mdr7iY/1p5rvkkAFldL0kYo0xHQ
         4hNA==
X-Gm-Message-State: AGRZ1gJcmn4tmqBlgmyhGCQkTibOK7hk7pPDNvgTUA2jTMo9oN3rfShu
        0acvBZay+3MO0GI3vn0AH0tgcA==
X-Google-Smtp-Source: AJdET5emOQoEEYsu17VDqPH9pxzz2d8As5AujJn8zwW1Qxm3/MB7tl+pB1q14J/EA6PzkIgkSqhjkw==
X-Received: by 2002:ac8:6104:: with SMTP id a4-v6mr10478328qtm.350.1541285418902;
        Sat, 03 Nov 2018 15:50:18 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id 35-v6sm27550924qtu.69.2018.11.03.15.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 15:50:18 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 4/6] staging:iio:ad2s90: Move device registration to the end of probe
Date:   Sat,  3 Nov 2018 19:49:46 -0300
Message-Id: <20181103224948.31014-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181103224948.31014-1-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, devm_iio_device_register was being called before the
spi_setup call and the spi_device's max_speed_hz and mode assignments.
This could lead to a race condition since the driver was still being
set up after it was already made ready to use. To fix it, this patch
moves the device registration to the end of ad2s90_probe.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 54ad85bd9dc6..8f79cccf4814 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -79,10 +79,6 @@ static int ad2s90_probe(struct spi_device *spi)
 	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
-	if (ret)
-		return ret;
-
 	/* need 600ns between CS and the first falling edge of SCLK */
 	spi->max_speed_hz = 830000;
 	spi->mode = SPI_MODE_3;
@@ -93,7 +89,7 @@ static int ad2s90_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	return 0;
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
 static const struct spi_device_id ad2s90_id[] = {
-- 
2.18.0

