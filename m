Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711DBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2326420836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEPzTq6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2326420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964855AbeFRRpD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:45:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36555 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964780AbeFRRo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:44:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so17179723wma.1;
        Mon, 18 Jun 2018 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cl5kPV/jXmRtM7UIfPWrPNPANwvqM8gxFSwDRM4zxF4=;
        b=JEPzTq6xELtwNCPHXEthAjQAtuCNziGGwzAZVLiLLwK6zXEpl30S3J99wMUjt6yQ/W
         /+eKtEf5BZPSgNUdsLF2u8qDgSb+5nrHhz7ZExw2/+jxflqim5Uy3SNRYarq01Lmi/R4
         q6etQlRYCM2ri4+blgN2MA0Nnl7/n8DnBBFUHmuk9xFm2ipSS9Zwoez/EgXoRXDFtZff
         L2uEaJGx8nxM64dhC1aLfU2QlaZsmT0BEqaIdENRBEOWkwXNF3gQKXuejRmN3sej2MRS
         q41o/GdAkoVGtq+qeniaJlsketk8WSm67MsAK64+05d3i6WfhXS0wSNvUP0o1fsFi26G
         wlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cl5kPV/jXmRtM7UIfPWrPNPANwvqM8gxFSwDRM4zxF4=;
        b=LoDGSLbbLb++4s5kTsFlTpJBaoIW4TtWPRiMQ6dHBp/Cdmd8W0HUnrHGQtZTem4SBO
         hWnvdLeciIJYIeSYCgmHF+4YqmNU5dLenuegtL8E1uTP4DcVAerAFrCf7zwXOrFt7w2H
         5NXdzlwNpj9uQuK63hPjFhtSuIfFfHQNep9nBmCb5CYCBvCs1MnPFMGXLoEQNXUxgLJ3
         MN2GxMWnqFp/PgIzUvgAFpqZaJWt4vfeUQdpqmAfrBu7iK3k2vmvfIEile7DCnCfO0KT
         z909tKHOkH7tigGFt6lwyrGAcUz/3Y/jxcumyJzD+GwxKWQlsC2gF9alXSjJm/YLoGne
         FjpQ==
X-Gm-Message-State: APt69E1QHi+KDMoAHiXsRuRcbsJJHnaeZ4LkRcZ6cA/5JzUuQnGqzHPU
        rgXj53z5l2kh3J1DKu+cjoM=
X-Google-Smtp-Source: ADUXVKKhRHrgQVpMyrGVAMD1qXkCXtiq8sHvaEhbpPlHjOpeiMN0Hrc1yRaoxIHNWgmRpURAHcnVVg==
X-Received: by 2002:a1c:ee06:: with SMTP id m6-v6mr9882770wmh.70.1529343897743;
        Mon, 18 Jun 2018 10:44:57 -0700 (PDT)
Received: from localhost.localdomain ([156.219.79.32])
        by smtp.gmail.com with ESMTPSA id h4-v6sm16745907wre.89.2018.06.18.10.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 10:44:56 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH v3] staging:iio:accel:adis16240: sign extend function replace hard code duplication
Date:   Mon, 18 Jun 2018 19:44:50 +0200
Message-Id: <20180618174450.3399-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sign_extend32 kernel function instead of code duplication,
Safe also for 16 bit. and remove declaration of bits variable not needed.

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

