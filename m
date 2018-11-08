Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7397DC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3865920825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDUHPDrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3865920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKHWjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:39:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46436 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHWjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:39:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so26154979qkf.13;
        Thu, 08 Nov 2018 05:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3AHy7MMTomAjTExN8gkJTDSMBOsSXEc0gUcgV1m0kfY=;
        b=XDUHPDrpCfpI2cd84CEQF0Riccpjge+pk5THXZwS0ydEKtSelfqMZ/+R3RFU5tmHYM
         b1C53dJn2KCNZTl2VkLX9gQzVJ9kqDH646Wv26kEwVYf9msPDDBox6SvUXFBbKqrOqNm
         cIJ9V4yZf9Q49hn6Y8Y0R3Etc2GO0IqzNluDH+UD5rN8sVbuvHuCGqINJDYdamcAcBhz
         YVqi+zv589BV9fS7sCunKkWCGTERaGFIaSrrDzQKEqleF/wW3rMb0xSbrNQ7KBEreFlY
         jmJzWIUQ/ltuRrrnrVWM6AYBOgP9yla05gI9TrUwts3RxdwoCGumdApi1lp55bRfTbe5
         XXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3AHy7MMTomAjTExN8gkJTDSMBOsSXEc0gUcgV1m0kfY=;
        b=q6k+bpZNZUalptrcbLw3ptG7mawhYkwj2dXL39ZFD/f6tnRaQNO1/re704fPARFxYL
         fjTyV8qELA0HPVtGMPJvotuF32oSTDRCLdWltOd5aZ2Y6Qua9eVJWFWymGTUrMPt+kaz
         QyDH9q6gXmMjTFNRc0XwsIed6yh81XaR6ShbQqTVsFV1JtTWdxVLRuD8zmiq/cP7lBuc
         Fsq+EdA83nUSl5a7VlsA8i8HpD/Yi9rJKQaikfmjK4EHPASap1rsD992ISoSOossbB6D
         n/UvF/q2jFBhPn1LreS+NXzDq2DE9ppa+Nc2OxUL3o0WisOqoT7ptrMz1ktPrDMReW82
         k2Hg==
X-Gm-Message-State: AGRZ1gJ4DLnrv7ogAFor1SycnPs8y3mwDkaxDlE0DyLABFzQuOMw/pKc
        xDVK9l0o6kmgLgTpJDqtHr4=
X-Google-Smtp-Source: AJdET5dXN4MnYGmB71vsHF+mZjZTpYFJGSAS2W0rsKbFoalH8b1i6MenvlvwHTb6GkDqvsiPFM7Rlg==
X-Received: by 2002:a37:1054:: with SMTP id a81mr3844521qkh.150.1541682226465;
        Thu, 08 Nov 2018 05:03:46 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id m61-v6sm2174953qte.30.2018.11.08.05.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:03:46 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Thu, 8 Nov 2018 11:03:40 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 2/2] staging: iio: ad7780: generates pattern_mask from PAT
 bits
Message-ID: <ce8ebadd1638810eaaa3b0b30a961a7b3f88ae34.1541681371.git.giuliano.belinassi@usp.br>
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541681371.git.giuliano.belinassi@usp.br>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, all pattern_masks and patterns in the chip_info table were
hardcoded. Now they are generated using the PAT macros, as described in
the datasheets.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
Changes in v2:
	- Added the PATTERN and PATTERN_MASK macros
	- Update BIT macros alignment to match with PATTERN
	- Generate pattern mask with PATTERN_MASK macros.

drivers/staging/iio/adc/ad7780.c | 40 +++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 9ec2b002539e..ff8e3b2d0efc 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -22,14 +22,22 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
 
-#define AD7780_RDY	BIT(7)
-#define AD7780_FILTER	BIT(6)
-#define AD7780_ERR	BIT(5)
-#define AD7780_ID1	BIT(4)
-#define AD7780_ID0	BIT(3)
-#define AD7780_GAIN	BIT(2)
-#define AD7780_PAT1	BIT(1)
-#define AD7780_PAT0	BIT(0)
+#define AD7780_RDY		BIT(7)
+#define AD7780_FILTER		BIT(6)
+#define AD7780_ERR		BIT(5)
+#define AD7780_ID1		BIT(4)
+#define AD7780_ID0		BIT(3)
+#define AD7780_GAIN		BIT(2)
+#define AD7780_PAT1		BIT(1)
+#define AD7780_PAT0		BIT(0)
+
+#define AD7780_PATTERN		(AD7780_PAT0)
+#define AD7780_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1)
+
+#define AD7170_PAT2		BIT(2)
+
+#define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
+#define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
 
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
@@ -136,26 +144,26 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
 		.channel = AD7780_CHANNEL(12, 24),
-		.pattern = 0x5,
-		.pattern_mask = 0x7,
+		.pattern = AD7170_PATTERN,
+		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
 		.channel = AD7780_CHANNEL(16, 24),
-		.pattern = 0x5,
-		.pattern_mask = 0x7,
+		.pattern = AD7170_PATTERN,
+		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7780] = {
 		.channel = AD7780_CHANNEL(24, 32),
-		.pattern = 0x1,
-		.pattern_mask = 0x3,
+		.pattern = AD7780_PATTERN,
+		.pattern_mask = AD7780_PATTERN_MASK,
 		.is_ad778x = true,
 	},
 	[ID_AD7781] = {
 		.channel = AD7780_CHANNEL(20, 32),
-		.pattern = 0x1,
-		.pattern_mask = 0x3,
+		.pattern = AD7780_PATTERN,
+		.pattern_mask = AD7780_PATTERN_MASK,
 		.is_ad778x = true,
 	},
 };
-- 
2.19.1

