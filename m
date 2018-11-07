Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2545EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BBC2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/UpmasQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BBC2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeKHEWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:22:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37226 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeKHEWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:22:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so22235479qkd.4;
        Wed, 07 Nov 2018 10:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fqVW9dmdIWiv8QzanvaPNs8+eLiSJsnKkzhg+ry8T9w=;
        b=k/UpmasQJt3v9ru8qQpWlhEKxShVDvfN9ee/0qWZakyPY/mQwhoKcd4vr/afkhoVsy
         BJDfSEeyMFjdDE/LQsUuSmffAwRaQ2FYlnpMGGHPRH3vFRs1/A1yH6hNf/MMJExJJjyR
         T7Wc0Grot0XmYStw5XZmo2QC89Wdsm3+N+9IQ4IzfzbxuNVImfCifMUVSNdhfZtLBVF1
         /COnRvkSLuafcA3matR4wbK8jH3BUGlXkMqPqaHjTSMZSmlnmhVH60CvsTQX42Yc566Z
         aM60zohn0xslAHivzTURHn1dvEslOMgiogTfNbepfjO3mV3z2GZQU8xHS+XFXbhhOsOg
         QgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqVW9dmdIWiv8QzanvaPNs8+eLiSJsnKkzhg+ry8T9w=;
        b=YLUaNQl1SQ2kO58LhlvqZ5Ww8mz2jhs7sq9GMSzOEuT4E683jRZ1YLWxYyUWyFsrC3
         ODe+sGQU2hxx1HXoPLEGBf6+DOfbCCeTXKtcvY2cYUTebz8pLC+yhAvd3dXjd2mVusLv
         HlQN1L6gUtXqzBJYHIgtCj1ljMCPfh2tBvGqJoSiwMk2BfGrondQ417UPQlSscjb5ZbE
         uhIWmp104VfrN+ewq2yJrr70b9hLbFCRdaNkyA1C7wDY+Fzh9vvZL15/DjjGZRaSsQWm
         bygk8A089uV0ENjm2Mj9V72lbuTAwW9gpfcVqKS+AEc+elCi7ObwWKPJHKbgipObL3f4
         D4lA==
X-Gm-Message-State: AGRZ1gIOBm7my2nEwe19ig1GJeQjjCAVbrBumYxN53+u4VubbtRyWXnl
        mMasd4dAoC3fYx6Ag9K+NIQ=
X-Google-Smtp-Source: AJdET5fnH4ewbda0Jqt+hJ0oSBMTL92rllZMaw1EsftVjsb9/nzhz9Bp+M1wvhHOICfJhUUpSAxzQA==
X-Received: by 2002:ac8:528b:: with SMTP id s11mr1367442qtn.199.1541616659345;
        Wed, 07 Nov 2018 10:50:59 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id m61-v6sm818076qte.30.2018.11.07.10.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 10:50:58 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Wed, 7 Nov 2018 16:50:53 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 3/3] staging: iio: ad7780: generates pattern_mask from PAT
 bits
Message-ID: <f7925df556f37f48ae0b1707239aff5a108fea1d.1541615978.git.giuliano.belinassi@usp.br>
References: <cover.1541615978.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541615978.git.giuliano.belinassi@usp.br>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, all pattern_masks in the chip_info table were hardcoded. Now they
are generated using the PAT macros, as described in the datasheets.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7780.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 0a473aae52f2..fa9e047b5191 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -31,6 +31,8 @@
 #define AD7780_PAT1	BIT(1)
 #define AD7780_PAT0	BIT(0)
 
+#define AD7170_PAT2	BIT(2)
+
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
@@ -137,25 +139,25 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
 		.channel = AD7780_CHANNEL(12, 24),
 		.pattern = 0x5,
-		.pattern_mask = 0x7,
+		.pattern_mask = AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2,
 		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
 		.channel = AD7780_CHANNEL(16, 24),
 		.pattern = 0x5,
-		.pattern_mask = 0x7,
+		.pattern_mask = AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2,
 		.is_ad778x = false,
 	},
 	[ID_AD7780] = {
 		.channel = AD7780_CHANNEL(24, 32),
 		.pattern = 0x1,
-		.pattern_mask = 0x3,
+		.pattern_mask = AD7780_PAT0 | AD7780_PAT1,
 		.is_ad778x = true,
 	},
 	[ID_AD7781] = {
 		.channel = AD7780_CHANNEL(20, 32),
 		.pattern = 0x1,
-		.pattern_mask = 0x3,
+		.pattern_mask = AD7780_PAT0 | AD7780_PAT1,
 		.is_ad778x = true,
 	},
 };
-- 
2.19.1

