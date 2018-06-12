Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1D333C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F52208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KneQnyne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F52208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935079AbeFLQsr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:48:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39361 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935040AbeFLQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:48:45 -0400
Received: by mail-wr0-f195.google.com with SMTP id w7-v6so24826875wrn.6;
        Tue, 12 Jun 2018 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DYS7Mf7H3RVCufF92B/vQD0QXiXp3YbGArlPeqOubXI=;
        b=KneQnyne9zAWoDjVkZzVXORg2/FFTwBtPWVi4SUOa+dTnW9+viux52nrrBBN9rsNwj
         KpyeAZSd0IVW41pWgm7iCek5tAgOrAu8E4a47pIg/OzqBaN9zwsKsfeSfoQUNJGra+XE
         Zq665XTONRTM9gwEUWvDeD7L4Q1tg2rIr0wTi8zuB85UtebPFm/k/cYIO/Nj5GyrQ30F
         6eI6RIsYWBlLPjMo8HhNe/m3+u+X3XeZWz0Q8HBrweRvqNm6fAufyUk5ZETir290qgc5
         7FY32FpdtsIqwKZd7GrfIVAKv6keesMAtjO42APx3UikZo78r0sdDKTh77Hf4k3KkXpI
         s75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DYS7Mf7H3RVCufF92B/vQD0QXiXp3YbGArlPeqOubXI=;
        b=ansE0DzUrAt5J3VNTICpNPT7odMTeZhnafTCpR+G1yNBzNH4QRCf1SKSAGiR7kjcH1
         zui4zzDbIbvi/RFqkyg9qycXgXQHZ/OpGarYGx9yzQaAkN+VW0Q2bZBbtCcA/STDOjPp
         w21AVoXOeQOs/CxP8OexLBevcidNMu6MrHmxTiQkJhPG7gX2WNqmyRYILaZn1C2g6QNl
         N0ka6QKfZbWuL7VQgqufqclWFgwZNGZYk4D3BnBoGIPALLtL/+ut3zoc9wdkA8ELrKOJ
         G9FBKjtP6aOXhbj2jMJcE11Ut2x5QpieQtNWEIydtvqRBUgmIslH4OnCzNVu2xi4J/HZ
         KHhg==
X-Gm-Message-State: APt69E28T42kQWS2Nye+P+V9u2lXSxhRwaafCbDxJusKtEImasYVWq8H
        zlGjXyhXrohTmxC3hNcN+tA=
X-Google-Smtp-Source: ADUXVKLrIaeDX2m7PtcUk8DbbQOxGfHL09a8B4LrsdciREMebMP1xXdh7lp/e0RedaI/HcflHqCx3A==
X-Received: by 2002:a5d:4206:: with SMTP id n6-v6mr914025wrq.13.1528822123850;
        Tue, 12 Jun 2018 09:48:43 -0700 (PDT)
Received: from localhost.localdomain ([197.54.242.32])
        by smtp.gmail.com with ESMTPSA id s191-v6sm1417442wmd.27.2018.06.12.09.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 09:48:42 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:accel:adis16203: sign extend function rather code duplication
Date:   Tue, 12 Jun 2018 18:48:38 +0200
Message-Id: <20180612164838.22961-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sign_extend32 kernel function instead of code duplication.
This function is also safe for 16 bits.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index b3e4571340ab..5cc96c8086b5 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -168,7 +168,6 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
-	int bits;
 	u8 addr;
 	s16 val16;
 
@@ -202,14 +201,11 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		bits = 14;
 		addr = adis16203_addresses[chan->scan_index];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, 13);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
-- 
2.17.1

