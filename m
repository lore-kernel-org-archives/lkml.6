Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44076C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E32620685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="r5r9RgfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E32620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeKDICu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:02:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38776 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeKDICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:02:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so8974172qkg.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9WTEEyu2PskGPSxUGKrtAjHaKSrp/L3vMKzLiu3cbGg=;
        b=r5r9RgfVxE21mp07NnNDnSYmc6exBER3fT82vmtGer3obqxsAA1Pm94nglHJIq1MTw
         D46w5ApH2CDU3qCxWI59fOQlx6o3zCD1dGNYYABvJAkmd6jqhcDKg6HV7zYL79FtRjku
         Z8hYvcgpBi8k5pgOc4rr+ypvrLXmcvLCPnvX5BhaJbgpMeZurei5OxmY/oiur6wU9GhO
         cOPcsM32d+/lbcFWlVV0137YVxI6RbHnFOIHrCyPnT637BI1mI6nkAJidTCQzy19elCa
         M2TWwPksokgvHpDirk8UylaOmkGVXIqa5IaPaGqLoiuRDQ2rbWnMyfdwCBoRVKKLvLHC
         +mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9WTEEyu2PskGPSxUGKrtAjHaKSrp/L3vMKzLiu3cbGg=;
        b=Ti865JeTM1hU2H4ou5Ag7GnnE1N5sEVGoInoHCBAnrMIJ2/YLG5EGjmZ+zlZkpN7Ff
         U5yNLEcoQAJ93K13Maj+fKaCBRNadZij5RIgaWBpsl7yE+A7IK1B4ve4hkf3fLAO0yRn
         BP5gRf6EQjl3w5pgWtoy6/xBpxATMsgiE5YUqCMJbVVekGSMeWNjL8iQuGTpIQncOWsE
         tiUROLqcddPFgX/geNzYkIhcLXUOSnBOq/y07/ML5063XyOqwgyNaRh4jEE6zbJrRwef
         AINjd2FhzVBW1/KUXBQzaPsfqSfdbac4qFFrkHWjhYU8ZnYs6XHhQQ3VG7cez3fWEu93
         +lFw==
X-Gm-Message-State: AGRZ1gKg6vSbX6L+qPV3qAwiAzkI1iWc2qRmoFAnqzl3oBwNmprjO4zO
        xHC8ur8fDoi65qtICjQeHu7PBw==
X-Google-Smtp-Source: AJdET5clEuKXvSPDzKcVrQLCl7ErwcEaA6KpYThvCN+Im97tnxYe3mwSgdb9nxWFJV5HjQGo0Mmwkw==
X-Received: by 2002:a37:a3c6:: with SMTP id m189mr15557224qke.173.1541285408393;
        Sat, 03 Nov 2018 15:50:08 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id 35-v6sm27550924qtu.69.2018.11.03.15.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 15:50:07 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 1/6] staging:iio:ad2s90: Make read_raw return spi_read's error code
Date:   Sat,  3 Nov 2018 19:49:43 -0300
Message-Id: <20181103224948.31014-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181103224948.31014-1-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, when spi_read returned an error code inside ad2s90_read_raw,
the code was ignored and IIO_VAL_INT was returned. This patch makes the
function return the error code returned by spi_read when it fails.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 59586947a936..ba55de29ef36 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -36,11 +36,12 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&st->lock);
 	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret)
-		goto error_ret;
+	if (ret < 0) {
+		mutex_unlock(&st->lock);
+		return ret;
+	}
 	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
 
-error_ret:
 	mutex_unlock(&st->lock);
 
 	return IIO_VAL_INT;
-- 
2.18.0

