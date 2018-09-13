Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5858BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFB120833
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tz6MHqpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFB120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeIMI73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:59:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44187 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:59:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so2076806pgp.11;
        Wed, 12 Sep 2018 20:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m9xhX8/BiQDyqokLrSJV49GjJPvdwE/vv1tVO/83JB4=;
        b=tz6MHqpzXUn48EOsTIkd5kaYzdpSTA4zAkMmMu9ouTw/t3es2yTTNYDiY2xtXAHtf2
         RAZurBQktwAbQ/Dq2BY3KteDjqp6rM2OuiFM1br00QGoAeipjE6yzL8JsoX61lgD6QFH
         tfC0MOkIf9xgQUQ2SzUcueoHkW4T8Ea4h62phv3yx5xIaCEfMIpOB3lZyk6/v2NkisJV
         FbfYO+hBbCKW+zXioNTmaRpZZV4fAe81Rxtw3Mhb7vU3U8gLfEr2CaYMSMCj5RygwaQW
         jBLCtK/lwEiHZVKhHpCma1pdrA4JNz1GKDztuLO+Bf3cXh3ykvAAYkXrMgPX5d1AiMFi
         yZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m9xhX8/BiQDyqokLrSJV49GjJPvdwE/vv1tVO/83JB4=;
        b=mKT0saecwu1CGZNgOJ9o+05ar4NMdL6MKqXHulZldkLq4V2xY8afL7FRJFrijFp/tZ
         rm78SoMkxlxpUGEKWsEyc1TBxs8/B1jW/5yA8IA5DOEhlOldejMMU5rqDgE0Q37EQoEr
         MAjytCoVAn1zLqdhXKv0AZ+yIR/VtFjBCxBN4XIUkPq+4zGbp0oWqxtK+UmCOfxbhKQG
         6tz0/xhNgxU4T3bC4YR2bIeqiEgejkPEzu/jzH4uHs1Uzpb4tNGq4CABrqfQeu6a9HAc
         inO87w03F6MeTZfLyXXbN4xZNPsYJ44HVZtxdlUjbQKJt9JpmPVvzJBJinlcIx53enXr
         B3qg==
X-Gm-Message-State: APzg51CCh4gnLcqXJ6l9j1oBPCt2B50+7IDiDGhlTmve7+7zRa2JlMwq
        1k8zpVokL4RxQ5rtje2mJlg=
X-Google-Smtp-Source: ANB0VdbCu/1XM0DbZxiO+JQKab1ZykY1UOUOBjOA6SvuTBnr5B8CCsnTdWK5NPo6B+GNzgaOvIDA8A==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr5055254pga.353.1536810711881;
        Wed, 12 Sep 2018 20:51:51 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id 83-v6sm4949499pft.40.2018.09.12.20.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 20:51:51 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
X-Google-Original-From: Song Qiang <songqiang.1304521@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: [PATCH] iio: proximity: lidar-v2: replace i2c block access method with the one already implemented.
Date:   Thu, 13 Sep 2018 11:51:45 +0800
Message-Id: <20180913035145.28056-1-songqiang.1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver tries to access a block of data on a i2c bus and it tries
to manually make a device command frame and a consecutively read frame,
then uses i2c_transfer() to read data. But this has already been
implemented in i2c_smbus_read_i2c_block_data().
Sorry for not having this device by my hand, which is a little expansive
for me, but I have another i2c device and tested with both i2c_transfer()
and i2c_smbus_read_i2c_block_data() and they all ends the same.
I'm not familiar with the SMBus, don't know if the lidar_smbus_xfer()
function is the same as i2c_smbus_read_block_data()? The original code
is commented with something I'm not sure, but I think if it's a standard
SMBus, it should be able to use in here.
Hoping for someone to explain.

Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
---
 .../iio/proximity/pulsedlight-lidar-lite-v2.c  | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 47af54f14756..ca880ba8e820 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -63,23 +63,7 @@ static const struct iio_chan_spec lidar_channels[] = {
 
 static int lidar_i2c_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
 {
-	struct i2c_client *client = data->client;
-	struct i2c_msg msg[2];
-	int ret;
-
-	msg[0].addr = client->addr;
-	msg[0].flags = client->flags | I2C_M_STOP;
-	msg[0].len = 1;
-	msg[0].buf  = (char *) &reg;
-
-	msg[1].addr = client->addr;
-	msg[1].flags = client->flags | I2C_M_RD;
-	msg[1].len = len;
-	msg[1].buf = (char *) val;
-
-	ret = i2c_transfer(client->adapter, msg, 2);
-
-	return (ret == 2) ? 0 : -EIO;
+	return i2c_smbus_read_i2c_block_data(data->client, reg, len, val);
 }
 
 static int lidar_smbus_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
-- 
2.17.1

