Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD165C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F80208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="n8ECNe8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F80208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeKJHnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:43:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46640 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbeKJHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:43:51 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so4345693qkf.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PypJCBItqAHhZtAV1pEt8q1mShtNp5yrZpvXlh8zIpA=;
        b=n8ECNe8XttM1lMFHrmoGegTYTbaS/vHXlJjOm1fEylbHqjTWqs2UwCRP7hLlqVsTGL
         XWvdnmUkTSSk/atBSubz482ZwKky/kKjn3LK75TPs2cnx7OrMd8R5akuNKs7sSxKa2Eg
         I6I6YZz1Eff1YYCq2A6INCqQbMg4siz2lOT1qwwa2w0AbhkoP9BQ3ihF5w/fYucmdw+i
         2SISTRl6myfUHjG/0I9fAt8ip2A+QNPo1UNerhShDrbXuu/icrK+F7y6wM+Zw4afMEa2
         LjLt/7JvvEdjZrmqtQpKk4jdfjTZguwBlPE6vqWu2UcySAyv9uSlyCNWVReLuYKFkhpZ
         vYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PypJCBItqAHhZtAV1pEt8q1mShtNp5yrZpvXlh8zIpA=;
        b=dXW8h8PfN9swfdBPmCNcAhTHe6oEISHgzyD7WK6AbNPMsOqxV8MBiJQO2Hd6jI6KDs
         8JXM9/SB0YlBUT585gwDvFcyzohXY8T8RvqFPqfxzEnNm1gL4Jv/RwbcTIqNbgYHSP1d
         wvQ/pPCEShZpNcofF15Q1OfKjgCefOV8YjZULPvkSBP3nqHcU2jDVMdQH5AQ4H8fXwIr
         7CRGSiUGKfnTWkcFYyN27H85F1jj3/KMW0TbE+Uu6kFPc9nj65KTVz1HjRhgI+PsQ0eG
         pMEuSFnaFBPmrekTWF+jxeJnuxXOzo8A0MozuZxcYwtNSw6Vtdd030TSNOMODUHwO8iu
         zo6Q==
X-Gm-Message-State: AGRZ1gJTpEM5WzFlyW8OJG13UAeKAL1L7xiS8XQpAJVJe33z3Oa6hmB6
        c++RaVbpCuCCKSB5aMZ0UgO5Lg==
X-Google-Smtp-Source: AJdET5eaLOI9WM3k8hO+ymflInkgXSQpXJ9eoBHh9r2G+92J4eCOErwGMcUAzuR/sQASkrWUFjHraQ==
X-Received: by 2002:aed:384a:: with SMTP id j68mr10289681qte.171.1541800880829;
        Fri, 09 Nov 2018 14:01:20 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id k6sm6082723qtk.41.2018.11.09.14.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:01:20 -0800 (PST)
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
Subject: [PATCH 2/6] staging:iio:ad2s90: Remove spi setup that should be done via dt
Date:   Fri,  9 Nov 2018 20:00:40 -0200
Message-Id: <20181109220044.24843-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181109220044.24843-1-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad2s90 driver currently sets some spi settings (max_speed_hz and
mode) at ad2s90_probe. This should, instead, be handled via device tree.
This patch removes these configurations from the probe function.

Note: The way in which the mentioned spi settings need to be specified
on the ad2s90's node of a device tree will be documented in the future
patch "dt-bindings:iio:resolver: Add docs for ad2s90".

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index ff32ca76ca00..95c118c48400 100644
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

