Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED8ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0557F2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ruL+ahgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0557F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJ0KkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 06:40:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34196 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeJ0KkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 06:40:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id z2-v6so3441382qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z2LHH9F5OJ0rvYdq5SDRuLDudXHduK0q/J3//KKhqZw=;
        b=ruL+ahgQTt8IWvavSx0G9329AhPM1OKdSqIdK5LK4YJrghthI+Mxz8SKeL1a2HmvwE
         e+H8ERDXOenJ0kDdhwWl5ZzlyxcyE8fq7yPMzC+2CaOQ5ThT1l07yxH5xV8CocAG5Dd4
         EcxXmBJtqpMEoeGHZ+Ep5upwQZIVMbtf50EV4WOHWVb9yJwm7RSDkJF9SWwCSFtjMtLt
         89zeRKq2r/0N94tkWj5W1U1lj/jdW0jTasEg/z+gfUHkXKiPdIpVa+/QPgM2Y1SNYg/A
         elSCW4CxeYOYH80QZLawAO8LUgKhcH4EdK8mzCy3fZNYK5+QIOxyznh821RxaXKX/CM+
         lIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z2LHH9F5OJ0rvYdq5SDRuLDudXHduK0q/J3//KKhqZw=;
        b=tuolyA7VNTx3yo3cRoc9ieYQLRFx0eOzQCA14up6Zd/8KQGlV+G/sWaaVr57hcNtbN
         R/9nWMpikchhoZ3Eyzn19uYvWFXUH7S53Z32TpdUvtgWWKGhitGBuP7R0Py0pA/TrvX9
         6GgewMsfdJw5FtH851NSckgIXaAzq07G9zuGpmY7vxD8MCa0u9328KwkgnUje1bGBVZ1
         LD88+qpNUsAWBeAx5nd230G+Ue9/Ld5J/bDQWaaf1oRtt2UubMEoFNmSstLWQX+pXMXx
         ndyLZqnFGjhtg/3cFsIHCJorFmeKSrbdOl2BXEZ8MSNGOVfunim1fkH2sVcev9tCBYIE
         s4bg==
X-Gm-Message-State: AGRZ1gJwnhpait+izs4bmJWOL7qjG6gfrI1yAZhO+aBztnmUUJ/YSVE7
        pRMT7Fp5sz3+FethgqyURZrdng==
X-Google-Smtp-Source: AJdET5cu1/HMNJwpQhcKHquey8ibfvg93sjyy2N490xuju8SYMqryd7dFoZAwVoD34W9ac9yYlF6hg==
X-Received: by 2002:ac8:701d:: with SMTP id x29-v6mr5458721qtm.161.1540605647110;
        Fri, 26 Oct 2018 19:00:47 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id h67-v6sm8499777qkf.32.2018.10.26.19.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 19:00:46 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 4/6] staging:iio:ad2s90: Move device registration to the end of probe
Date:   Fri, 26 Oct 2018 23:00:03 -0300
Message-Id: <20181027020005.3140-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
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
index c20d37dc065a..b4a6a89c11b0 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -81,10 +81,6 @@ static int ad2s90_probe(struct spi_device *spi)
 	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
-	if (ret)
-		return ret;
-
 	/* need 600ns between CS and the first falling edge of SCLK */
 	spi->max_speed_hz = 830000;
 	spi->mode = SPI_MODE_3;
@@ -95,7 +91,7 @@ static int ad2s90_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	return 0;
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
 static const struct spi_device_id ad2s90_id[] = {
-- 
2.18.0

