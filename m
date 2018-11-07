Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38ADC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E39B2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeCywS48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E39B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbeKHEV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:21:57 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33762 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeKHEV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:21:57 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so22278527qko.0;
        Wed, 07 Nov 2018 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aUmnHASi5VAienY0hiyzBD+kiBDa50KR9QnFaLrop4c=;
        b=YeCywS48uAwP1TAyM+sgynRgPNVY7PsaSOZbwGfvynI7S6qo6K8T+TXclD1MQyQEH6
         hvB7rsC7TLly8p4tZ8aT1V8i/v6SbWdchiwoGii4FTfNLMb/RZcCgbT49CR8pS+3WsBb
         4gjOUxOeHXG9VPLMSjLYKvZvVUlTVzEPfaxNAFNRKj2WKM9+WwPKur7d7gVmL4NLrvEL
         uyEcBa3+7w/EzbWSmh3xssqi2aitnW7smkNA2r87yR9qS9I/ss1eo20T/yE2Ajz5KBFy
         xKY4DtaIfIkAmveAhHz0gK5jMtQpYI2AXC9sFxry/Wa0z3Tsbz92UQLGJAwK4ywmIe+f
         fbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aUmnHASi5VAienY0hiyzBD+kiBDa50KR9QnFaLrop4c=;
        b=S4BR39LllKx3Ie0guyEqVxa0xvFNXf5qjgtLGmCEbaif333+sKqfyE3KFMEEeP0hB6
         4pb4po6aXnkvKmWt3HtsjQxB2KTn4p3xLTyFPvV/W5iTZR0kiIH1fBP7yExTanDqLelT
         zQRZcX5UcrVcE6m1ZNqmHcW5F7etWNJCcjCrpWXfPzeWCq01EAvCNMIWhk/qNMoVtfb6
         wNQqMn1ipJws2ZxMGnuAITkB1gLLY6Pq3Z+qW76B/PJ6uyR1TotcPAehMPQl2i0K64Nk
         Yj/1jmLtkqHq7Wx9vywKxwBolsFMLufR9ygx/5vBmypF+LkJye6HnOy+16WjW2FgnDUl
         4J8Q==
X-Gm-Message-State: AGRZ1gJdBC+6yg5SNJ2lRjbYGDNLU4gvooxgUxyH1/aqwqDk8aYW5hk0
        IBADOZeC6hBFpEqbneLWMcE=
X-Google-Smtp-Source: AJdET5dTCnLaZv4QWPaBZyLT5W4OgPQqOEA5rJAa8A3fXxPw9W5+fF0YcPeUiM785QPEpYxKiQk8lw==
X-Received: by 2002:a37:d1c5:: with SMTP id o66mr1356715qkl.293.1541616618385;
        Wed, 07 Nov 2018 10:50:18 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id f30-v6sm1163673qtf.50.2018.11.07.10.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 10:50:18 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Wed, 7 Nov 2018 16:50:10 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 2/3] staging: iio: ad7780: check if ad778x before gain update
Message-ID: <2a521e5f036eb74b684f368a6227509cac93fe0d.1541615978.git.giuliano.belinassi@usp.br>
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

Only the ad778x have the 'gain' status bit. Check it before updating.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7780.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 6e51bfdb076a..0a473aae52f2 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -114,10 +114,12 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
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
-- 
2.19.1

