Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 17DBEC004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B2B208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDR+DHfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B2B208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeFKXiX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 19:38:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41040 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeFKXiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 19:38:21 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so22100389wrq.8;
        Mon, 11 Jun 2018 16:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kowt6W4Lu3VmAcdRbMR+SF4Mfkoi8DfU048bBivC2BM=;
        b=MDR+DHfbC87d0nmXSHD1VFszD0plx83Nk/aGCOgaP0ePeuYyovKdX6hlWGGXYZAMuy
         vWVodmVhDcICKzR2tI6lfoqk6hEBCz5/1114wx/i8axDzVSQW1zTDc5ZmKFi2dEIvvSM
         v5nMI2VEtk6TzvD9BSFS3GtPWZFegaWZQRvLZTaPN9m4OSu5djMKYeeQOPsfL0J0NleG
         nMlSARbLk1ERBixYDzUKyvOx3o8xd88ah6tE7J6XbeYcOVhBs400FdhY6RaRbMPcQRhx
         alS/la6DTX39pYXUd7PkEY3X7AAvIhJZJbvMo6WkwxGpD0+rRgJqqhKEcdzH5mlXQZl8
         Y+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kowt6W4Lu3VmAcdRbMR+SF4Mfkoi8DfU048bBivC2BM=;
        b=NFHJmfI91wiVS3betATiPKHl7ncALuQ11ykJC5jmlCmmr5T1+qu8ymA5p4fPDtlw6b
         FqqdEKcYWEKINjBHKbIOHs0enIgUzpO0/n/N2WzpAqLz1MuJaaleUQN3KAfLkyLvBAWF
         Jtc1ew8fUxG0rz8GNHKa3fd+keAKHq1DuCs2hZwfjKBfoc9FD8Z+zazUh3094hIFuAJn
         t1Xk61MWqEchcpQjIlw1lfmC8qGHTA5STtKcISPNbaHze3JHYQHBPkoKP31mE4eEr9LL
         U1RM93/k42T0HvIWEL3YFH0pWfbp/kY5DH7PyCizHoS4zwKuI2PugLBynba7jY0fc7em
         Mt1w==
X-Gm-Message-State: APt69E3DWk3uctLFcNVxtuyM9UelPDJwI2q71ldmDraXD/yLVWmQKzAl
        1erF0TBzeoZyNZYvUWESw8k=
X-Google-Smtp-Source: ADUXVKJAlYuDxJ2b22hSWzSnC1NAXTs/LEIwKW9fyKGuM0W9JzBVyjUs6QUMlanjZOvuYn/unhvKEA==
X-Received: by 2002:a5d:4503:: with SMTP id s3-v6mr784361wrq.191.1528760300507;
        Mon, 11 Jun 2018 16:38:20 -0700 (PDT)
Received: from localhost.localdomain ([156.219.155.97])
        by smtp.gmail.com with ESMTPSA id s17-v6sm6644718wmc.34.2018.06.11.16.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 16:38:19 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:accel:adis16240: sign extend function avoiding code duplication
Date:   Tue, 12 Jun 2018 01:38:14 +0200
Message-Id: <20180611233814.18597-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sign_extend32 kernel function instead of code duplication.
Safe also for 16 bit.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index fff6d99089cc..9adb5badb915 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -292,9 +292,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, bits - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
 		bits = 10;
@@ -302,9 +300,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, bits - 1);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
2.17.1

