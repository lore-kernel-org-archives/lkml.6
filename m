Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3ABC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775D120A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwlffhqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775D120A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeHYAAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:00:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41504 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHYAAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:00:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26-v6so7597508lfc.8;
        Fri, 24 Aug 2018 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gm4AKXlXejShiX4OWr9kProTLon2wkD2VMzd9AqoeC0=;
        b=XwlffhqdQrVQG1L7npIlMXY+Zk6HNX6IRx9es8nY2ZC8ka+RJpGXiGu5tTk/Ysbb9t
         /6I3204CpCw9egV4gTuUY9S5s/4n5ad7wLtin5kHrFoeLbLRfjl4exTX1Bd0hr8teEq1
         zx0WXuPU3d7NR2pnZY5ohfFY3yIoDQRZOlzzj2YkGJ+4z90y5DWsQ5BDh+g9zkNaOW3/
         YA8CQknJr3WHOmIouo3gTO8VQ8telpJQvPOyGSO5NGvTdC3mY36qLEyavVEKv9GBCg4+
         U3KFuHI1UGbb2f+u+Nt6OYffelKHHA9LHVp85Awa4TKjiIfaSLhvoTPpSyx69UWfRBj3
         QPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gm4AKXlXejShiX4OWr9kProTLon2wkD2VMzd9AqoeC0=;
        b=jVIufu1ucMepE/h13vwdf4dLsYHxozgB5xTqia9rX3V1DIk62a7PgEFdcFBqQCj/dQ
         9TgNU4J+HRD5GEiu9+Vpjs4JM/6VdQdqWid3T7TgKfCAVHwpMrVNF7jShgQI8i7Vmizf
         hEUe4WZo6KkvMwsKQsDcdCd3OKGEFHAqlAoYZSHjtr0R799FBOUgYP61pUopXOgQMD01
         6H6tJ3sZC41ZpM3QorWMzi6MFgsbRQc9Xpjx40Vu0nHclvU8A8BYJ7jHd1kgm08AjDU5
         daVGJ8vJbdoqAA0nfPpbEm0eOMIr02zUsBhEmMrS/uOZBV1agnBGHjKts0KlQBKSR2q8
         2dHw==
X-Gm-Message-State: APzg51ArR61XIZA0Vzago/4DzfU+6KUHyNkml1SfUg3JAUvmKarN1iFM
        /1BedhgQ/4idJyWOy6vU13y9UgpO
X-Google-Smtp-Source: ANB0Vdbr9Us8Cr20hXRLMS1OtUQ/VxxBX6AutyyADEFRAToqfMaWoybDFMhjxQTVx2Juk4bT/pghFg==
X-Received: by 2002:a19:5e12:: with SMTP id s18-v6mr2180994lfb.5.1535142271238;
        Fri, 24 Aug 2018 13:24:31 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id b76-v6sm1506392lff.53.2018.08.24.13.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:24:29 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] iio: dac: ti-dac5571: make vref regulator optional
Date:   Fri, 24 Aug 2018 22:24:47 +0200
Message-Id: <20180824202447.21804-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `vref` regulator is declared as optional in the device-tree binding,
but the driver does require it.

Go for the device-tree binding and make the `vref` regulator optional.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/ti-dac5571.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index f6dcd8bce2b0..bf21cc312096 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -251,6 +251,9 @@ static int dac5571_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
+		if (!data->vref)
+			return -EOPNOTSUPP;
+
 		ret = regulator_get_voltage(data->vref);
 		if (ret < 0)
 			return ret;
@@ -335,13 +338,21 @@ static int dac5571_probe(struct i2c_client *client,
 	indio_dev->num_channels = spec->num_channels;
 	data->spec = spec;
 
-	data->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(data->vref))
-		return PTR_ERR(data->vref);
+	data->vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(data->vref)) {
+		if (PTR_ERR(data->vref) == -ENODEV) {
+			data->vref = NULL;
+		} else {
+			dev_err(dev, "failed to get regulator (%ld)\n",
+					PTR_ERR(data->vref));
+			return PTR_ERR(data->vref);
+		}
 
-	ret = regulator_enable(data->vref);
-	if (ret < 0)
-		return ret;
+	} else {
+		ret = regulator_enable(data->vref);
+		if (ret)
+			return ret;
+	}
 
 	mutex_init(&data->lock);
 
@@ -373,7 +384,9 @@ static int dac5571_probe(struct i2c_client *client,
 	return 0;
 
  err:
-	regulator_disable(data->vref);
+	if (data->vref)
+		regulator_disable(data->vref);
+
 	return ret;
 }
 
@@ -383,7 +396,8 @@ static int dac5571_remove(struct i2c_client *i2c)
 	struct dac5571_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	regulator_disable(data->vref);
+	if (data->vref)
+		regulator_disable(data->vref);
 
 	return 0;
 }
-- 
2.18.0

