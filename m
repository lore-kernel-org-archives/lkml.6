Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513F0C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F82605C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJQejwNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1F82605C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934967AbeFYTLe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:11:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50693 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752718AbeFYTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:11:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so10458764wmd.0;
        Mon, 25 Jun 2018 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kYPHcw0afZAbcT0enjQcBJ+BrJljLcIcai6woZCLfx8=;
        b=iJQejwNYkbVlnc8563W3THuDO89LR+nJ+OhuDQt1s+rn0MWCrx35H/dfDh3lfG5NMh
         GHdJEZVaS0IcOhN3Qd2QTmgYfMhyg/jQdi74YTGUoIDc+80x7+z5YPgYlWCZDnKfKDir
         XFGmA0uKa0TWy9+yZ43QOjioBf0nki9e8EmLOOc5vh6OTe6VrFJwymLK3B0fMezmPnJS
         aIWWHi43W/pSYk9wZQqeW/TCOM411RxrQvBhfYYGcCT4iujj+wAlPc6ItvyEPzWJq8GY
         ReJtOCWdi+WvtNP0biT/FlyDQnxYicueQ87e5X0N9ArW9O7Q6ceOd9tCXI4ScW6PPnIu
         DnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kYPHcw0afZAbcT0enjQcBJ+BrJljLcIcai6woZCLfx8=;
        b=Rc7F35M/hpcMpH0Dlp/euEy5cEJnDgTCAm63SKOsnOOmiShOYHpSiz6C4wNCtbV5wN
         5RBgmxXhR6ZHlHNkq/OSXA3BCuEJP5AFCx0Y/D4tmfgQbZ1LxqhGBzBDQ68eaU2+56pb
         ATWGCJbyYeif5f0RGkJvZbqjdljNlWmwKC7P8od1apui3uebEogj1bpBflNytyCLiMR/
         Kordwptp7mGEkzZU5OKLTk+iNiXs6p/MMZPfODaE7+qrseWw+e6GVjqgZeWbhRasRYNt
         4BZHs2pJkFJT4kGNsVRMPra08poxIMPvJoy9/VsJ0iOKca6+hxwIiIlKy5ZW5UOHA4WS
         hw7A==
X-Gm-Message-State: APt69E04rGCgSwlX+tkzcbghxm75JZ+T6g0xADvv/QtiIIB8URIQSOZ7
        zhRWIQjTMDKxpncgeJ7wPAc=
X-Google-Smtp-Source: AAOMgpdLqKQe9WP7HeQe9MtQm6r4CLX5o6KPrz+9XPmmBOHRj0c5rUGhBLBv5Ug+g8DC1IXWOOpv7w==
X-Received: by 2002:a1c:d287:: with SMTP id j129-v6mr1834635wmg.106.1529953890853;
        Mon, 25 Jun 2018 12:11:30 -0700 (PDT)
Received: from localhost.localdomain ([156.218.198.157])
        by smtp.gmail.com with ESMTPSA id h193-v6sm14826152wmd.25.2018.06.25.12.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:11:29 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH v2] staging:iio:impedance-analyzer:ad5933: Macro replacement Cleanups.
Date:   Mon, 25 Jun 2018 21:11:23 +0200
Message-Id: <20180625191123.3685-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing some macro replacement to start an array of structures
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

