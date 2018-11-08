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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC24C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDCC20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdEPqE/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDCC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeKHWiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:38:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38063 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHWiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:38:51 -0500
Received: by mail-qk1-f195.google.com with SMTP id d19so26239423qkg.5;
        Thu, 08 Nov 2018 05:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CSTyTQVebQoEyb5YW7uEXU9YiShfNNKeiURGdRFNLfI=;
        b=MdEPqE/B1Wtw1OYqbGAW7Lj/WKKQpHBYYd0PUOkrnX+b190sKb2OVhqQ8VyaIPaXdF
         cXd++AtOAlrnujv8SjdrmKPktMVtol8tIuv8YG+rp3m0j+FJ+EpJDH9GxnmLwMkCVoZA
         AS/D9UG6AttwXzeASvaxMBn5I9YYhls5g+KWf56U8e0lGlr4oWKEUQeFwF7legBWa4e+
         iY2+TH8l3X7ALfJ7ASwX/kYrZ1kgTvDyuF+mfMAtxkJRFjwyn7uNlc4Lf+YGmNE9U/KM
         /5SkDLoelN7LxwTuum9tgLflPbcZ2ougWYom+zJcoIQQ7LgdKado/tJh0zHTibS71MiV
         xXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CSTyTQVebQoEyb5YW7uEXU9YiShfNNKeiURGdRFNLfI=;
        b=M60Xgs5/TtkfRuGLBFJ6kyiQXjAcFcI5RJYaGrExm51PqEaBANU/Tew27pl6b272al
         Jh4ZwP6H/bnzQh75p/Ut6dJxDuNO79u2xIl6A8AekbUn1/WhLBhriaiOmvFptExKElfH
         xKMmR5JqKk97xj1H7GJpC2A4BdJWnTiIKcBvDIyvR/vwNGIC7Ydoj8f6scW9/8V3sSqj
         7pIaCHc6JJqZc0nG9qzB8XDCFx6nxY3L7I6dmEoT1AgYoSL2dqbGMjw198CACR2CHqUK
         ZS64vpnngchf8HnZTbfo41x3nSz/gA9yUFauoBT54KH/DzFlGy527Ci2ssPtfmJt32Il
         3Z/Q==
X-Gm-Message-State: AGRZ1gI2v4fGdMzpzh23EU3+JL4l7Qbyg0xZ3DAkpQjIUIUR4FxsqtIh
        vmqJe1/qTXyeyfIW4d8xOiw=
X-Google-Smtp-Source: AJdET5fNc/a3SPtBSNZIqg7QhoeagN6KPuracQDOYFH4n8QH3YXe4moAdKY10ZQpFzcOTLubwdIgnA==
X-Received: by 2002:ac8:17f0:: with SMTP id r45mr4124425qtk.206.1541682206102;
        Thu, 08 Nov 2018 05:03:26 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id h66-v6sm1920259qkc.53.2018.11.08.05.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:03:25 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Thu, 8 Nov 2018 11:03:20 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 1/2] staging: iio: ad7780: check if ad778x before gain
 update
Message-ID: <762e851dd819f27e3955cb695cd8422d84a19438.1541681371.git.giuliano.belinassi@usp.br>
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

Only the ad778x have the 'gain' status bit. Check it before updating
through a new variable is_ad778x in chip_info.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
Changes in v2:
	- Squashed is_ad778x declaration commit with the ad778x checkage
	- Changed is_ad778x type to bool
 
 drivers/staging/iio/adc/ad7780.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 91e016d534ed..9ec2b002539e 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -35,6 +35,7 @@ struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
 	unsigned int		pattern;
+	bool			is_ad778x;
 };
 
 struct ad7780_state {
@@ -113,10 +114,12 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
 	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
 		return -EIO;
 
-	if (raw_sample & AD7780_GAIN)
-		st->gain = 1;
-	else
-		st->gain = 128;
+	if (chip_info->is_ad778x) {
+		if (raw_sample & AD7780_GAIN)
+			st->gain = 1;
+		else
+			st->gain = 128;
+	}
 
 	return 0;
 }
@@ -135,21 +138,25 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 		.channel = AD7780_CHANNEL(12, 24),
 		.pattern = 0x5,
 		.pattern_mask = 0x7,
+		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
 		.channel = AD7780_CHANNEL(16, 24),
 		.pattern = 0x5,
 		.pattern_mask = 0x7,
+		.is_ad778x = false,
 	},
 	[ID_AD7780] = {
 		.channel = AD7780_CHANNEL(24, 32),
 		.pattern = 0x1,
 		.pattern_mask = 0x3,
+		.is_ad778x = true,
 	},
 	[ID_AD7781] = {
 		.channel = AD7780_CHANNEL(20, 32),
 		.pattern = 0x1,
 		.pattern_mask = 0x3,
+		.is_ad778x = true,
 	},
 };
 
-- 
2.19.1

