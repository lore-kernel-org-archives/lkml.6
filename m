Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271DFC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37D120847
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="uHDjOW0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37D120847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeKDIC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:02:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47089 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbeKDIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:02:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so8900963qkf.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xuC9nGCa0Xu3GdJ9qRkKK25LaCKIesQs7VLCImXBAKU=;
        b=uHDjOW0HuP8aULg69i2rds4IIrM6qqjylGKMidH6a0hCIzjWk/yq21MFNbeTWcs/KM
         od+fZPThANrhSwAscMQAb2sTx3PeJjSl5JUXD8GEWJN6V6xZvRcomYPRQoEKpTA+KxrY
         jlwIY6vQCJO1Nmhw13/E0vMavTxq7Dm2Smdv7r4Ir9tyCBcBAusW8wwolRLpPHd+/RHw
         1FUiCCGHJrKBjIwdqqFDQ5BfY+sAvU0x8kSF+c8v8Fs2zPuHWSFdR07ZEh3kEZBoIlMk
         nhhRyUe6lBKqgHa5tXGxl2kT1+KI2DQKt2gaklY2ZMw/EAUQKaUFmdfHqbB5c4RfzBi8
         5KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xuC9nGCa0Xu3GdJ9qRkKK25LaCKIesQs7VLCImXBAKU=;
        b=BAoEm7fL300xbgs6m2TGi+CAmFM+nX5vkyGypV4MenHyuM8DEkpiOfHVgM8SpLs/L4
         +CmUxWqa6tLAAbf9d9lcbkYg1rBi0gBqwwt51Bpu/2j8VHRXcgDdaTavjiRCa+6VDar7
         RO+YT4Dr6YqwPVN1E5JS03nI7W0I282BpoF+sN8JtfnMnwBWdvb/9vDnOiWhPUE67w+R
         K9w7qt97kjmcQEdrb7T+Y9DF08E+KG6uEUdOg7lgEQ/GKPMmXQbJX/pveA07DxBcwdUc
         7MxMPtc5M6BHSZ8PDPIO4yh8vdDYL7XtVKqdnK/8eKyD6tbRWYjc2V3hie5UQBC7xZhz
         DbVA==
X-Gm-Message-State: AGRZ1gL4zawCImbtTP7TwPcCYasw23/uUxGZl03XQn1WUKfbAgrm7zVR
        isd6JPNobufM+ryR5nNg+MrNNw==
X-Google-Smtp-Source: AJdET5dyOHMyRB0HIwZuyrebJvu1+lpHLskk6VXSt0X68IeYhYP6Ks8Kh6m2OhI5x49rtF6ioXGJZg==
X-Received: by 2002:a37:14ca:: with SMTP id 71mr14806570qku.295.1541285415382;
        Sat, 03 Nov 2018 15:50:15 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id 35-v6sm27550924qtu.69.2018.11.03.15.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 15:50:14 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 3/6] staging:iio:ad2s90: Remove always overwritten assignment
Date:   Sat,  3 Nov 2018 19:49:45 -0300
Message-Id: <20181103224948.31014-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181103224948.31014-1-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an initial assignment to the variable ret at probe,
that was always overwritten.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 4908c8a95fad..54ad85bd9dc6 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -62,7 +62,7 @@ static int ad2s90_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad2s90_state *st;
-	int ret = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
-- 
2.18.0

