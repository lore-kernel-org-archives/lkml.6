Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B249EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7900A20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="g0U7GZcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7900A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeKXLJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:09:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44084 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeKXLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:09:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so12045250qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tOOlqhy2AphJebMrYDfu86cZkqn1w0YS2gGgHkzViLk=;
        b=g0U7GZclXUOqW7mvYgsZHsMNYEIQ1ZafkH0Q+ARZK73WrklH1ISHr88GzSrhtATQMC
         Rf0/utEqi9bvTokxwWe7l4OJMk2iCzNHjmzrqMfIVeaWyrKpdvJgHLPJFiFcsaUwCLsW
         4m1eVcPtQGRfNvhxen3UpI9QjaQN2ucmIhd4plC9L/fBq5B6kjz9zmMpF3rapf+ClnsI
         aX+ywFxtaSfqPUb6f2Q9lyofP1QIG9TpE1DZhnlOHWMfvVa1VqSUUsDF606q3mrJ+aCP
         zcezmL0a/kCkIrH8PiXNFfH5sBT8EYgCj07P/198z6VKySH1RwdbTHx1W13D9f/ysQeK
         wu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tOOlqhy2AphJebMrYDfu86cZkqn1w0YS2gGgHkzViLk=;
        b=p9I+xsT7PdtVLViCujySIkB++OldAmYFaTrusXM3HBbn+yAsvDrmi0mdwMacFgblPZ
         MDMOtdjrTr0Rtz+Pf0jtnj4Gr0oO1TEI0rlF0DRREphGPzhJtWSLF/vRwp2y0LoALLVj
         K3TLlXy6jePFG95EfMP/DT2OAObDZcEdCNV2uYHiNOSMVEBFGb8+OUi5cUBPd8lyh+fi
         sM/EDf3e40XSuertTEJrEUxGcqBARtSy7GNSjXulLN1ak9s8uK1VbfaCwrB7cQFACF1W
         287rQ8/q3jJNEThciadVB0/nfU8QNJhj4EZBFbI5IBQIiWq1W8B2d/TcO+uWns6ZgmuE
         IyOQ==
X-Gm-Message-State: AGRZ1gLlSBFnH8Blzp4dRgwl95TGcCkqKcmtKhuP+Zg8Fo4d5ToLPVs1
        ORdPHWrb7zYP6hVQSAwX0OPNMw==
X-Google-Smtp-Source: AJdET5cNOEZaS6/L6rKjr4v4S3gvm4Ryak5tj2FrLj0sDjIf3jgOTm/VIrfXNbhPJXu1WmI87eQVog==
X-Received: by 2002:aed:314b:: with SMTP id 69mr17063702qtg.247.1543019014627;
        Fri, 23 Nov 2018 16:23:34 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id o34sm26707515qte.4.2018.11.23.16.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 16:23:34 -0800 (PST)
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
Subject: [PATCH v3 2/7] staging:iio:ad2s90: Remove spi setup that should be done via dt
Date:   Fri, 23 Nov 2018 22:23:07 -0200
Message-Id: <20181124002312.6923-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
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
Changes in v3:
 - none

Changes in v2:
 - Rewritten patch message to better explain why the code snippet in
 question should be removed.

 drivers/staging/iio/resolver/ad2s90.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index fdae067ed866..abb9b9147ee6 100644
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

