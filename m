Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31724C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E2625301
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or2HkYbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E2625301
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeFXUPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 16:15:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55505 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeFXUPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 16:15:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so6996953wmh.5;
        Sun, 24 Jun 2018 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0aTDchLjVg7pdQa6ERXyM7zLrCMt6i74RkYisNWuAj0=;
        b=Or2HkYbonNx1Acj9VhA4WCK0jF/Abjk44MpFxZ8WbOPY2PkInCc9bvRG/cJdgimapA
         FcnQ7GG5daNEr3c7XTa8tV7Z5SJauUs/MqcSpkjkWwMHwgMcdnm5Hq3IhwrjbRjGqTck
         NjSZyDJ4zxXT1VSbze33Gp16P9AnQjCMcjk1hblYh7hDKhlfZexfOQ/6GJ+26ZCwgrxx
         1NyRmRp5LC9OdQ38mT3ecpJq+nQG3Fygzzxqb+7qWbeOwf+k6CY/Nm0XrdnkYtymjLKk
         aCkZ1lgp+Tm02T7nhzW21CK3jbJNvRnXZK/EsV2Aj+qx2KLLpIVTv/pG2nd8wtxuXrCf
         v/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0aTDchLjVg7pdQa6ERXyM7zLrCMt6i74RkYisNWuAj0=;
        b=X3jC6JGuzG5SVIhX4oikHjh/J5r+j7sg8w4N82opC4Ua6k1cZ2xrS4AJwHTdvABhaX
         3SZehJuZLyQ1HvyktVltCezxRFmrnwYfprKI5ZBOYEBF6CKbaG06QmSRbmj9ttqEqaM3
         +fuL1t+diqvf1GLopqoFB01RZL9hDbJbO5RLggeGr4q9PlxKjKf1AkatOIn1Ow1XXf5a
         E6zntOS9fL5lSc1pgxFSiLVnSz7+K4rJ4r84RlnADIZWwV2x93fdJEFONWhvLc8qDRFc
         sG6/f18EChhnQ2NQjIeWpHv1lXtAPEVUi6CCsGMCUccrR6JJGQI7Mi9/AwjFkClyxJ1z
         HH2w==
X-Gm-Message-State: APt69E39Fxja+nr/unhMuu2mEAaT7IJnVvuvb7UVsKMFqM4NGDCHBquC
        DKP/jYR8UJZSWF3onYeGWZk=
X-Google-Smtp-Source: ADUXVKImjuT1QUnmGeMLkNDHiYHipA9PkvoZj3kvT5ekNHSrPF4lETNy3KejDveByTlKUmwJ9D5s6g==
X-Received: by 2002:a1c:3544:: with SMTP id c65-v6mr3971278wma.32.1529871318910;
        Sun, 24 Jun 2018 13:15:18 -0700 (PDT)
Received: from localhost.localdomain ([197.54.176.252])
        by smtp.gmail.com with ESMTPSA id v138-v6sm13649019wmd.47.2018.06.24.13.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 13:15:17 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:impedance-analyzer:ad5933: Macro replacment Cleanups.
Date:   Sun, 24 Jun 2018 22:15:11 +0200
Message-Id: <20180624201511.10597-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing some macro replacment to start an array of structures
so it can be reused by manipulating it with different values.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 57 +++++++------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3bcf49466361..14df89510396 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -116,45 +116,26 @@ static struct ad5933_platform_data ad5933_default_pdata  = {
 	.vref_mv = 3300,
 };
 
+#define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _address, \
+		_scan_index, _realbits) { \
+	.type = (_type), \
+	.extend_name = (_extend_name), \
+	.info_mask_separate = (_info_mask_separate), \
+	.address = (_address), \
+	.scan_index = (_scan_index), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = (_realbits), \
+		.storagebits = 16, \
+	}, \
+}
+
 static const struct iio_chan_spec ad5933_channels[] = {
-	{
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE),
-		.address = AD5933_REG_TEMP_DATA,
-		.scan_index = -1,
-		.scan_type = {
-			.sign = 's',
-			.realbits = 14,
-			.storagebits = 16,
-		},
-	}, { /* Ring Channels */
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 0,
-		.extend_name = "real",
-		.address = AD5933_REG_REAL_DATA,
-		.scan_index = 0,
-		.scan_type = {
-			.sign = 's',
-			.realbits = 16,
-			.storagebits = 16,
-		},
-	}, {
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 0,
-		.extend_name = "imag",
-		.address = AD5933_REG_IMAG_DATA,
-		.scan_index = 1,
-		.scan_type = {
-			.sign = 's',
-			.realbits = 16,
-			.storagebits = 16,
-		},
-	},
+	AD5933_CHANNEL(IIO_TEMP, NULL, BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE), AD5933_REG_TEMP_DATA, -1, 14),
+	/* Ring Channels */
+	AD5933_CHANNEL(IIO_VOLTAGE, "real", 0, AD5933_REG_REAL_DATA, 0, 16),
+	AD5933_CHANNEL(IIO_VOLTAGE, "imag", 0, AD5933_REG_IMAG_DATA, 1, 16),
 };
 
 static int ad5933_i2c_write(struct i2c_client *client, u8 reg, u8 len, u8 *data)
-- 
2.17.1

