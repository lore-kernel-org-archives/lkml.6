Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F17C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EB2218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avnzGOKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfA2ShP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:37:15 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42190 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfA2ShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:37:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id 68so12106977qke.9;
        Tue, 29 Jan 2019 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8DKRRaYVDWWj7eK5BlqC9nwhgc+tZAka4nGRVNCp+8=;
        b=avnzGOKX2aFJ1RqqA35h94U4Es7ETgWYsVCV2MvSgIThDp7DzfEi6tIjDgm0VWy3+J
         LVDZ6U9gqARUXQIKDn0LdNNVBC55epxPGFxVO/PmzTF74P9eyWJMmmo5GiG3fWlFExmR
         axGmDAlzkn1HZHOGmbjHplYG3oQ76FeASRO1nhffA4r3NFjD21aQNE2o63O71Vj3VIhd
         Og55BklycGPFuz6hfg3t27bkuE8oqOWxDJGAfBKkTrqQDxVooaKP6aAbU9aLkg9F6qWC
         YwH/fxcq5hqDd8LqFKMN0bs9ypH6PwumcSWCAp/dqRMOItkostCdZJ68Gb56Op+OXBaQ
         De5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8DKRRaYVDWWj7eK5BlqC9nwhgc+tZAka4nGRVNCp+8=;
        b=UhewqnHeLeIa55MLhduyxlBLZWFUcvTAHPGos76Z1ItMoPIcVjfmIHBKdlH4QhdFxo
         QekdDo7pdtPO9RjxBuTl+ojSc7OgsV6fxxUhJcu0ZsKygwDWderbEEU0AMbtLda7lJjy
         2HKQNa/8XYbe1KjQgTayzPaZCngTpkLOe7ljCkCSGlfy7LCcDJJgf4OnfcP6gK0GfL+R
         QEm3XVTTVNY9DCjYsY0YhVYexfcGD0cBQNxfgjnb9ySRCQwwcemFYBFDf2Kx2ekhCpSb
         nFbeXdwOLYuwWwTlSbYVuiHZwj9bv4JWAbL2x0HbdzSpcuVBdZe9T4krzfL6vUkOwOkG
         yRqw==
X-Gm-Message-State: AJcUuke/qMOmZDSbeebjFU5NQWKxHpZfpK03TMfQRbf7LjD3n36b2SAf
        eN1ZU7zQtTQbqNZYjXxgZAQ=
X-Google-Smtp-Source: ALg8bN5V4B7jlcesbMQ4WVLPimlIOr/aKdeFnaS3jL2ks6hj2H4OsJ7vofWRGBZb+YZp+nZfvH0vHg==
X-Received: by 2002:a37:8b41:: with SMTP id n62mr24555460qkd.262.1548787034442;
        Tue, 29 Jan 2019 10:37:14 -0800 (PST)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o65sm82888562qkl.11.2019.01.29.10.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:37:13 -0800 (PST)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: [PATCH] iio:potentiostat:lmp91000: solve codestyle WARNINGs and CHECKs
Date:   Tue, 29 Jan 2019 16:36:56 -0200
Message-Id: <20190129183656.15656-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solve most of the checkpatch.pl WARNINGs and CHECKs on lmp9100.c. They
are the following:

lmp91000.c:116: CHECK: Unnecessary parentheses around 'state != channel'
lmp91000.c:116: CHECK: Unnecessary parentheses around 'channel == LMP91000_REG_MODECN_TEMP'
lmp91000.c:214: CHECK: braces {} should be used on all arms of this statement
lmp91000.c:216: CHECK: Unbalanced braces around else statement
lmp91000.c:258: WARNING: line over 80 characters
lmp91000.c:279: CHECK: Please don't use multiple blank lines

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 90e895adf997..6dba26121a62 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -113,7 +113,7 @@ static int lmp91000_read(struct lmp91000_data *data, int channel, int *val)
 		return -EINVAL;
 
 	/* delay till first temperature reading is complete */
-	if ((state != channel) && (channel == LMP91000_REG_MODECN_TEMP))
+	if (state != channel && channel == LMP91000_REG_MODECN_TEMP)
 		usleep_range(3000, 4000);
 
 	data->chan_select = channel != LMP91000_REG_MODECN_3LEAD;
@@ -211,9 +211,9 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 
 	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
 	if (ret) {
-		if (of_property_read_bool(np, "ti,external-tia-resistor"))
+		if (of_property_read_bool(np, "ti,external-tia-resistor")) {
 			val = 0;
-		else {
+		} else {
 			dev_err(dev, "no ti,tia-gain-ohm defined");
 			return ret;
 		}
@@ -255,8 +255,8 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 
 	regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
 	regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
-	regmap_write(data->regmap, LMP91000_REG_REFCN, LMP91000_REG_REFCN_EXT_REF
-					| LMP91000_REG_REFCN_50_ZERO);
+	regmap_write(data->regmap, LMP91000_REG_REFCN,
+		     LMP91000_REG_REFCN_EXT_REF	| LMP91000_REG_REFCN_50_ZERO);
 	regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
 
 	return 0;
@@ -276,7 +276,6 @@ static int lmp91000_buffer_cb(const void *val, void *private)
 static const struct iio_trigger_ops lmp91000_trigger_ops = {
 };
 
-
 static int lmp91000_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct lmp91000_data *data = iio_priv(indio_dev);
-- 
2.20.1

