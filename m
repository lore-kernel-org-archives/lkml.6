Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29255ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF70E20856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="NJHxq1VD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF70E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJZJUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:20:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34467 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeJZJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:20:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id a132so1965746qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OkoLtsw0vdIrwS1FAqUPeM6GE5wcSzJ0J1yLPn9Rh1s=;
        b=NJHxq1VDcv6kW1pv7J+KC0jD41NfsfLO1FeLeG6sO8W1AgjQmjWxM5M/x6hwEPXoLV
         x2teyKt/sYevIS3tfXD3lDpLW6hsBUL6bxcHuMU8A5N+Nd9Z1oVUlgJSGmlimUT1SThA
         57UnaMIzmqWcXLrz5pMIArzU9XNGIOuRmFfd8KXvXX6p7bdbe9g/46YL///PWE8E9bhf
         tPKd8u25G+tiFFcwXYECzjj3Knfci6CL35WP89XIsOHDd9esiGqZi6nHtZvI+0GinCkU
         K52XwjvGuFwR5xFmOsH8uoHcrup3UKQQexiLb+xxDNLCDNc8d5Ch1iF+6LnIvunyHJPo
         2QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OkoLtsw0vdIrwS1FAqUPeM6GE5wcSzJ0J1yLPn9Rh1s=;
        b=qkPkSleDWCnvV1vX6cF+wcyJp7+er4Jrb5RdQtxeFF3ZLM/Rk0nNcj7jNiB0bLdKMc
         RLipnnN7yhcaIbuJTdktF7zx0PGM1OwlIf3Ikobj+xTiuv/Htuyk4rrpcO38/YNBChk6
         s3ugrqHoEI0J7nW1gpEJplQ0QaP5FfYSSKg0fMG+AISWigoopAvVA9vJ2FUldO+9gPf/
         cyXY+ljcuNouE6yRqwZBoXNOjQlKqv/aW8fBFWkViBQpCsPHKFKZ6ciyAQX5+9MPh3aq
         /kUsFsdM43ZYW/ziiLc0etWptHxYfC6+veXCrFYXuR3wxyWXCH0RNJx8RGPaZHd9su6V
         QIuQ==
X-Gm-Message-State: AGRZ1gL5J426YjZzPeJ2WHiydDsGlNYSJ5qwDd5NGlws9oPfURCKmu32
        Zm4vnutGcvVEFhq+qPIcmSS3Iw==
X-Google-Smtp-Source: AJdET5cTgvZ+VSjXdxwvfJtN9KrDi/k0S0yyYC2abKckwD9h4K2UIZVzUX9Gby1Nt1fnYtBIWWSKLA==
X-Received: by 2002:a37:1909:: with SMTP id k9mr1287173qkh.61.1540514738709;
        Thu, 25 Oct 2018 17:45:38 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id y3-v6sm2371735qti.27.2018.10.25.17.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:45:38 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>
Subject: [PATCH 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and read_raw
Date:   Thu, 25 Oct 2018 21:45:11 -0300
Message-Id: <20181026004512.31012-6-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Colombo <victorcolombo@gmail.com>

This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
implements the relative read behavior at ad2s90_read_raw.

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s90.c | 32 ++++++++++++++++++---------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index b4a6a89c11b0..52b656875ed1 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -34,19 +34,31 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct ad2s90_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		/* 2 * Pi / (2^12 - 1) ~= 0.001534355 */
+		*val = 0;
+		*val2 = 1534355;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+
+		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
 
-	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret < 0) {
 		mutex_unlock(&st->lock);
-		return ret;
-	}
 
-	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-
-	mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
 
-	return IIO_VAL_INT;
+	return -EINVAL;
 }
 
 static const struct iio_info ad2s90_info = {
@@ -57,7 +69,7 @@ static const struct iio_chan_spec ad2s90_chan = {
 	.type = IIO_ANGL,
 	.indexed = 1,
 	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 };
 
 static int ad2s90_probe(struct spi_device *spi)
-- 
2.18.0

