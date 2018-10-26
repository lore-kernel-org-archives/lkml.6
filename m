Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432A9ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CCB20856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ARIBD8Ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CCB20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeJZJU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:20:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39547 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeJZJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:20:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id e4so6929620qkh.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z2LHH9F5OJ0rvYdq5SDRuLDudXHduK0q/J3//KKhqZw=;
        b=ARIBD8TyH/vpvD17XO4fYyhxRcRMRUvKgZ4q1+hMMFlBmr61E4PU6cFWl4PtpMc6q8
         9EU9JxHvK8ih9rwuQehPzA6ybyj7s+qp8MuwLs5Up4CokYEYmTEjPoSuUGh/4/cnwRdH
         YFkR0t+gLuemnErWZYo88pG604blVLtCZazqjmo+6So8ScvAhi29csFxtoCSsO7n+7XM
         nvtj4HEK3OZ8uYR7xAvznNXolK/6KAUvRZNrl/IYoj8dN5bns1170bVdBZb2pjcRmelp
         LyChpy8ajnNf8tBK77ITL+14kL5435LaRizJsbQ4K7OZysRWzmAexJcj1tnSd49VQCsT
         IlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z2LHH9F5OJ0rvYdq5SDRuLDudXHduK0q/J3//KKhqZw=;
        b=H5XPOvaEoXUYJcUMLsCfgeKVxB+taSBJi5y8m2zgkUYCZqtik/DKyjHysiUQtxS5bo
         pjw8OSo/oN7CZ+Dgxv5GWlR3QN2t8/CsE4dOx5Y6P8izycjkpbRkAy1kTX0V4TfWVOSl
         u+CjLgeinc8pCOnldHVxF2jRZASwCQ92RWS0kAL1MK289kRB+WrJZqIzoV3WXSxktC4h
         lHC28MYwBjSgfrlbyWi0R9DUzk7Vf/i20Uc8CL976O7s7VaqXmisnFw2lwY7IBMn9m4q
         INNL2oyo9Wd/vC/m5HzAsXJozVPGDL0aSrG1Tpk/kY/IW8F35/O+xiecg9BAHFaibj1v
         6vDg==
X-Gm-Message-State: AGRZ1gJkdAeka0GPLfJnSjN58LKNYRUHV/g0K5aHGqJV8HRFueQ1mmoi
        ypCyPMNcURzk2wZ8PHqMOxiIMA==
X-Google-Smtp-Source: AJdET5cyOAOdtWKoBifkV5+tKIEVZG0aqfjFItFDEFk4bPtY2o/Muy9NaJuascOIMXxZNHldf1jHlQ==
X-Received: by 2002:a37:8d06:: with SMTP id p6-v6mr1273181qkd.4.1540514735667;
        Thu, 25 Oct 2018 17:45:35 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id y3-v6sm2371735qti.27.2018.10.25.17.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:45:35 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 4/6] staging:iio:ad2s90: Move device registration to the end of probe
Date:   Thu, 25 Oct 2018 21:45:10 -0300
Message-Id: <20181026004512.31012-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
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

