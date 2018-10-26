Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BDDC46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E94E20854
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="WfCe3OEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E94E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJZJUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:20:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33998 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZJUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:20:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id z2-v6so12233902qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k98qfZFTnS8YJsoHEehtGRqClwouswNGYRpoM+jy0g0=;
        b=WfCe3OEfI5h5TiyKZsUsPEW2ZKcSFLs7dwNQWaIFKq66ADuDggB/mQcSdWhrtg+mUd
         nXLELbHh2LuH2DsgCXMmPv1OfsjauU70IQWSz0OnSTxjisc4ZmosHus0Nvnbt+ktMMUl
         pDzz/9wgNySKhry6SU46DAvPxZQMH7YF+PvOjZIuFDlbavhM79P8chxr9ZMUX5GbnFRq
         4yHKooNi8IqMfMxz1I8mhHt9cYA5zo58fyVfiaSlzJJ4t3/m2BDlTp4EdNWQTw3Bv/Ci
         ABN8Vwi+jOKAdAZo7DqWNd2piS5ntdYePWUWi9mCDYdqThPpPUrn3pujlv67tGTWoEh3
         vd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k98qfZFTnS8YJsoHEehtGRqClwouswNGYRpoM+jy0g0=;
        b=mQqeaBwj+Gvvp8LSfvHoMv32xJSqas1SV8Xk9e9SdMSORUkSpdXGNC80oEbZGveIhj
         NYe95Y1DWmuLfixIOjNFvt2Kuhmdq3qw8JzAv/JH8ts3s8YG4i26eCDaJ/s69QJDIBD5
         mhN0pSTj3fdWP3n/YFGQyFO7bAKNsHauP5MYz6mGBB7LWyFKQGbNDMhvieWOE+lUh55r
         adgFo7pEPY4ipgfAo4Y7m2ZuRKzgMIFSiTmGLldoDBgVGVsOibv0KyHHAr3PdcgQRBbY
         Cs/+h7zrbwzYgYLRiZMsW4wAouHzscEjasThl7XLaotdvfgxq3Po8C2Fi7Y87//x0sOO
         tMIw==
X-Gm-Message-State: AGRZ1gJjfOaFKKD30MXFPm1GAncl32Mrs6VzbeiAY6/2VvKtZh0CqGIo
        7hLSUxRijPtxiHi+wAjNPxNz3w==
X-Google-Smtp-Source: AJdET5dDxewdUwp9hl2WPeGetOqfFX7Y/rpJzmAex0gSFrFxaLYFikbhqjN5vznas7V45/6Zw8tcPQ==
X-Received: by 2002:ac8:1b58:: with SMTP id p24-v6mr1364608qtk.56.1540514727014;
        Thu, 25 Oct 2018 17:45:27 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id y3-v6sm2371735qti.27.2018.10.25.17.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:45:26 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/6] staging:iio:ad2s90: Make read_raw return spi_read's error code
Date:   Thu, 25 Oct 2018 21:45:07 -0300
Message-Id: <20181026004512.31012-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
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

