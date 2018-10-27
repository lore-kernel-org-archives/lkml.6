Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B45BECDE46
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9292086E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="SzL4Zeni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9292086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeJ0KkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 06:40:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46532 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbeJ0KkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 06:40:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id c16-v6so3382088qtj.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 19:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q2vdmtUPmzwFZSI00GQes0NB6ZitLyrsTfc3LNt6rZ8=;
        b=SzL4ZeniqHfcy081DHrPNC+V2oGbX5i773yZH+MmCKUiVrOPTXl+wcXMl1ye6RyWhU
         +O+yAMQUlp+6mK1sp6OVmT9Ef8b/yAnjWmBDbKRLbIeuIfGE/Xd3DoVUttxfSbQWOaRA
         q50xaSGVCz0m2uAOOOpTuDRXVenyktYgSjgEBzCWwsqr1uw0Zu7TqVaSwuKVBWmVYjAi
         q5lcywwbf94NGO6aQeuHLsHkU0FBj+E0Yl90xI1bQ+AJfczUXcxbSh9UUqXmA3M0yF9k
         tTWz1U4+AFWMox2C4qKtruqkU9goxYWrvNDJsyNrDXfQjFmP6PzOofIXNXPS6CjxFEZm
         2h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q2vdmtUPmzwFZSI00GQes0NB6ZitLyrsTfc3LNt6rZ8=;
        b=f5hDjgam5hjrHsTmL2wX46ct4xoY9TXF7jlvEIBk6YPE4GAuYCQPFUp04WH9E2LYcl
         ud+UKGA/mJh0U8mt7DiIYfBucFC9OBj9S3j8fE31dZK5US8WctGzYDMP/DZKKI6aKB7o
         +INYmrm+zDMfLWaqrh9lEY6CiGdDZPKG9l7uS/5MWXtLZtc9VDY/zLQeFT0N4XtgygBT
         lRKHEVUTVzMZlVcSu0QoWNjzmZgDgFnPk4R9v5q/Fmjt4PHI0pTQzX57ZOX2FY4luZps
         ibKKqcXCxQMvOAbK2kEiOZJrhDxCdfltt7uS3FCmD+JQ0qYMI5uWeihOI68/FXKVAz5Z
         BNlw==
X-Gm-Message-State: AGRZ1gKhWJcdOQD4Rrc9Lcc8ccslcaEaj2iE+SiiSPQa8Lxhi0c2uTnd
        lnSpAMekUS1w1xubqlzJNnkMtA==
X-Google-Smtp-Source: AJdET5d/djts5UApLE+6dQVmk45w7/rXb4FHqLDrVbp69bflikCGdDgMAxOfQMUC7z60YCiisfRtbg==
X-Received: by 2002:a0c:ad8f:: with SMTP id w15mr5372488qvc.146.1540605650310;
        Fri, 26 Oct 2018 19:00:50 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id h67-v6sm8499777qkf.32.2018.10.26.19.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 19:00:49 -0700 (PDT)
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
Subject: [PATCH v2 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and read_raw
Date:   Fri, 26 Oct 2018 23:00:04 -0300
Message-Id: <20181027020005.3140-6-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
implements the relative read behavior at ad2s90_read_raw.

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
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

