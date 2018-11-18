Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A2DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E516420815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="IglfmGaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E516420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeKROpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:45:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39662 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeKROpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:45:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id q70so26335164qkh.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 20:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AQMJAzyixzk0/1WSmVNMs8fwNy6KbazheSZxWxsLE1Q=;
        b=IglfmGaTcc71ngiuUY41D+tnc+EvGiwidh4C3kcgtK1eS2GyctTL3DU2/+MQkTu5Ua
         TrOYIgrs+5PVbmDZg5vPGVBCj03LjTvUD8UElhGtfL/t08tboq7e++X8BAF6ab1SKrLn
         MT6jODnIyXtc4FrJowQX/TBwM0Od/hRTWWB7R0In1/mG+ic64ZFaW1oo/5Ots8Mbky9J
         5wv90c2Y273iM7eWICtQUzKmXY13sT88YKY2pTAIRWnPEczx2Uzk9rzvj6jJzkQWeVZU
         VdKxE5dihCj5DguC8cQHjpzYQTyl+q/0RYhgHM60NQeaYdZIi0VCVBV4NF99YSi98DrZ
         1iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AQMJAzyixzk0/1WSmVNMs8fwNy6KbazheSZxWxsLE1Q=;
        b=q89zOLoHWbOQpflsL7uH00KJhTId2YW0Aas2dA4nq08atNi7GpEzg60NdlP5O0HUpb
         /JuQ9BWBOuYEpCRdCLbSPEYhqBbjjhe5xN6DAyIOHmPvq0xILR2cN+HZ9ypXkSsEl9wj
         0hqf5EHq26oVOpoXp1kZrRn5zgqUzMKf1DKCLGkRMlE9CY+a1k/zNTPosqn6L1eUsFXx
         BF/c+LY+zpHH+SQtejtfpr732W+NE3fjQE+UwBTJsrHzfV/xpWPtVCbq9GcdHXtwJ4eo
         h7x++RB6k56WAMk1SXIQJ1XnddffF7X3ZlZnl0Pt2LVvVpsqjzFkSOQKhFebNp2SNDvJ
         dyhQ==
X-Gm-Message-State: AGRZ1gIGtR3FhRXolkdlBcEWkhE1IjlU8kH4KyNyjvBVL56zaic7QpuE
        ddl752y8edEAUHz5QBq3bNOazA==
X-Google-Smtp-Source: AJdET5cJKIsOMW/SSS/EjI4ctTvTOPvYfU2/3uxDjcl82XPyZ2hZWe0DrD14DJ602UzbMSs3JfqvYA==
X-Received: by 2002:ac8:34cb:: with SMTP id x11mr16053740qtb.115.1542515179321;
        Sat, 17 Nov 2018 20:26:19 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id b6sm16112350qtq.29.2018.11.17.20.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 20:26:18 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v2 2/7] staging:iio:ad2s90: Remove spi setup that should be done via dt
Date:   Sun, 18 Nov 2018 02:25:35 -0200
Message-Id: <20181118042540.12697-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118042540.12697-1-matheus.bernardino@usp.br>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad2s90 driver currently sets some spi settings (max_speed_hz and
mode) at ad2s90_probe. Since the maximum frequency is a required element
in DT binding for spi slave devices and because the spi mode for the
device can be either (0,0) or (1,1), these settings should be handled
via device tree, not in the driver's code. This patch removes them from
the probe function.

Note: The way in which the mentioned spi settings need to be specified
on the ad2s90's node of a device tree will be documented in the future
patch "dt-bindings:iio:resolver: Add docs for ad2s90".

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - Rewritten patch message to better explain why the code snippet in
 question should be removed.

 drivers/staging/iio/resolver/ad2s90.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 6ffbac66b837..913d6fad2d4d 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -77,7 +77,6 @@ static int ad2s90_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad2s90_state *st;
-	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -94,16 +93,6 @@ static int ad2s90_probe(struct spi_device *spi)
 	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	/* need 600ns between CS and the first falling edge of SCLK */
-	spi->max_speed_hz = 830000;
-	spi->mode = SPI_MODE_3;
-	ret = spi_setup(spi);
-
-	if (ret < 0) {
-		dev_err(&spi->dev, "spi_setup failed!\n");
-		return ret;
-	}
-
 	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
-- 
2.18.0

