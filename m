Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C97ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A851D20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="0mvHuAu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A851D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeJ0Kj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 06:39:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39943 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJ0Kj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 06:39:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id f18-v6so1840417qkm.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 19:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k98qfZFTnS8YJsoHEehtGRqClwouswNGYRpoM+jy0g0=;
        b=0mvHuAu73tBFg2S2xrmm13wOe/2ZPE0w3h1ybC4dfMYqIkCJajhFGuOcRZ457PFVVq
         qIoc9L6ErihoxUKmAwQBcw2HBkOH02vz1dDMnSyleijBuYHm3/xNNcLEM60zSoH3ekKR
         /gLgC6Ec/vsMOuYYWmN+8g9TUZYp/+gkkCtVyVXtUWT3tWFfliczUUQ4fEwxt9M/a7wV
         93gHnTH3KJpK6y2q3SasjrkL6ESkvPgA3hLemUZF4ZKXQsX1OEVX+MfM9OgTDPrJKMq+
         D8uFFN4sjoZK1gYb/nP66iSuktTXlopIh+Nq5JOfpayoTjBCyqP3UV9VLEu9UR7SBS0/
         6tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k98qfZFTnS8YJsoHEehtGRqClwouswNGYRpoM+jy0g0=;
        b=MtqSkXszxgL3A0vbmVlZtakdQHoUadM6Z+jPcFIAkiToq+m1yy7yW/Etn7iNmODdYT
         C1MpjQVCJpQ2k2IYXeyumXH0lWRJNu2TUTxOavRkj/DjRW7HnUIHBLB8M0MG29INAyzL
         ralLMhcqxYqYasdFUgG7LbrQI1MQjA/kMo+YBkemrImwhGFjoqBPHTy1PeYmjDATuUO/
         f5FYUMhs7M5JFzTGtcBHhaF8EjzVZLLMB/cDUEMjdqPEltId3lPSsFO+RfB79PwFfzAt
         qc8F3z0VeHal12XXcPIpc2lvR3i/8aoWAblGEVyHHfkzEd4hDA/ke9JiigxqrtNA7+5W
         x2Rg==
X-Gm-Message-State: AGRZ1gIiSlvizNUwfp8WLuN1UFHfjNCwuUbfIg7lRMXHuWVvQ58iWKqp
        /jRXvNDVWcdvLgO63jQ+wR4M5Q==
X-Google-Smtp-Source: AJdET5cdYWQCzzz2kZGr6+Kw9s3+0znmG3RnArlGWcHf3C5FviHbNCXNukzyEjI0z3oc5dD/pkn3Bw==
X-Received: by 2002:a37:aa91:: with SMTP id t139mr5101949qke.139.1540605638037;
        Fri, 26 Oct 2018 19:00:38 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id h67-v6sm8499777qkf.32.2018.10.26.19.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 19:00:37 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 1/6] staging:iio:ad2s90: Make read_raw return spi_read's error code
Date:   Fri, 26 Oct 2018 23:00:00 -0300
Message-Id: <20181027020005.3140-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, when spi_read returned an error code inside ad2s90_read_raw,
the code was ignored and IIO_VAL_INT was returned. This patch makes the
function return the error code returned by spi_read when it fails.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 59586947a936..11fac9f90148 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -35,12 +35,15 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 	struct ad2s90_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
+
 	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret)
-		goto error_ret;
+	if (ret < 0) {
+		mutex_unlock(&st->lock);
+		return ret;
+	}
+
 	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
 
-error_ret:
 	mutex_unlock(&st->lock);
 
 	return IIO_VAL_INT;
-- 
2.18.0

