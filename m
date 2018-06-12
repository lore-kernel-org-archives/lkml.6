Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F35F3C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA4F2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIFjWdpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA4F2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934814AbeFLA6A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:58:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40266 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933405AbeFLA56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:57:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so19850151wmc.5;
        Mon, 11 Jun 2018 17:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=huRr0IxaPrA/WyKuTOWDsm6UmZ0pmfjvJxO9p5TkmcE=;
        b=NIFjWdper875cajcBmixEbIKZdF39cvzXcNlGLWJu4O0G4wR+F7EQlCnEYX3e+aACi
         xqeBJMx9U6k1WtCw4zHz1c/GRxCpR9Td9DNYaSP42agYNVhvp38VjYgV+k7uL8AfHYoZ
         jLJx8PXC2hQrxek+13zkdgWZMQqH6F2Me43PdJ+zqqd+NfZtUor7NxlBYbjqMILpYD2s
         CWfnt6gY1qA1adfP/vsb8I+BqHM273DBqu9jJBUiL1q4b5Its6xa5QqS5T2bhu/Xkqlq
         st8lzS/jYlf8JE7S7W+ZeOV8WInnvBEWm/8VdrEg74xb3JgYOL2egMhFucRkC+v2PDwd
         sivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=huRr0IxaPrA/WyKuTOWDsm6UmZ0pmfjvJxO9p5TkmcE=;
        b=OwFqB3TZyD4ZWOhe6ykZiQFkGShM9qr0T5HJxluOLYVesABUp98pfCpF43R96qMMY0
         QS8wFlCbmgZCnrj7ipuzTi2qzhVPfK+eQwBDijrH9WPr66LTBFahvudwkBkMvSuc+EU0
         HfSFZyWQpGvq51wyy86M62vXm5uGzkAzfKoCTuFoKGk/5gobRCwDrWFfXTiXcxK9EDq2
         o2Qu2V51Qr2CiJsr7MD3WwydON6GLvLEIURiu2NnWp/0yKrYavjosOifi93plMRckFh1
         ujJKg69HYWSf85ecUijSudM7tHsLRg0gPKVlok3GTmC1kH91Q5U2bK5hKaZfcLB3pCiY
         ccWg==
X-Gm-Message-State: APt69E1gC0oWUJz8qYRdASKehBaXKAfiJizDPywyCU6E4P5wsHbf94dZ
        W1slBVviolePAF73etmHN7s=
X-Google-Smtp-Source: ADUXVKLGSOG3Tu7hx5dyUOvJHZzKmVvHS19qbhs6UwSnejBgKUC5g1W6AouYkEVdQ0K1k/zrab4rkw==
X-Received: by 2002:a1c:7506:: with SMTP id o6-v6mr678699wmc.60.1528765076941;
        Mon, 11 Jun 2018 17:57:56 -0700 (PDT)
Received: from localhost.localdomain ([156.219.155.97])
        by smtp.gmail.com with ESMTPSA id l84-v6sm12076119wmi.3.2018.06.11.17.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:57:56 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: Re: [PATCH] staging:iio:accel:adis16240: sign extend function avoiding code  duplication
Date:   Tue, 12 Jun 2018 02:57:48 +0200
Message-Id: <20180612005748.3546-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <48143872d69d231273bd2c8ed835cbf0046a263d.camel@perches.com>
References: <48143872d69d231273bd2c8ed835cbf0046a263d.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sign_extend32 kernel function instead of code duplication.
Safe also for 16 bit.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index fff6d99089cc..24e525f1ef25 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -250,7 +250,6 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
-	int bits;
 	u8 addr;
 	s16 val16;
 
@@ -287,24 +286,18 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		bits = 10;
 		addr = adis16240_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, 9);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
-		bits = 10;
 		addr = adis16240_addresses[chan->scan_index][1];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, 9);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
2.17.1

