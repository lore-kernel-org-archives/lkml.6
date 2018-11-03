Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D297C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65C320685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="DOo6IijD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65C320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeKDICx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:02:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44215 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeKDICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:02:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id n12so8922824qkh.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zqk6KK1zavttyyKgEeKSNj6LjESJAqexffEcPC1/Ftw=;
        b=DOo6IijD1Mam6q+MOjJFKxVaOjeTMd1kXZLk3CJx+nPysyZnEtTZufGjd5e2U5oVM1
         5p3bkAemFRdG8qX1mqzYrKCA9Wcu3RZybxMmDH+T4jOiLFJFtqc0Cn1DBI28jzMNCH+N
         qfBYDYCX9gGfDWMcx3hgCbulG0n+r6uuwjXhZDfq9BLFYSHfhTf0XyeGHa5vizmSIJ6F
         KAL2Z3Yo/Z6cF6YMSDKjmkXOeqe2KoD3dKX7mOrqX1A1SkSFe/Bg2V6X3VaZVHZ9zAHv
         GFXLnZcGLPsrk/ECE4dTW9iGxfhEKCMRp3bFJZJYEX6k1XXGna+Ss9/lfYa5iBvw6pCZ
         yshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zqk6KK1zavttyyKgEeKSNj6LjESJAqexffEcPC1/Ftw=;
        b=ZQXNRoL7psUbAiDlyFTYJ5xFP/mHI3XAeOJhw0tE6w1qURYHkj3FeckvtO9EW2s18a
         vMDRc0ICKi+m2as5Xg9DpwiuoiqCjL/O2LyfKN4Vt7BoQGo4w7hrKfW4wDWaWmO/Gwav
         78G2jvmYHXo6mqwlxpJy2uSftVkDu98eS3WASJIj/ksjhjueqNa1WL9Uja5fx3rVDdPs
         zxGWr7q0IwLpu+82TPQKdWmH4zg/7IGeCW8w3udmSV3NCfrKTXYrqcs9tNTp6RmUVQBY
         K0NzhK3EvLIsyRsX7vQg54iKvdm4ed/BLtf6C2UbtglojnSQ2N5jRkd7bxW6OXz1peQF
         TaTQ==
X-Gm-Message-State: AGRZ1gJe/ja4x4iGxC/ldBI28Iujqa7Wc60fYy2d7WeDMe/y7zVJL5bB
        jcmuOlZXuhXbP+nLUpv8yKnoxQ==
X-Google-Smtp-Source: AJdET5eRWlg54bZ5piysXhrLHCQPip8VGYd98n4hFrBcQGn80uhA+VXcPUjmTOnqPw7b64zmkwN37A==
X-Received: by 2002:a37:a4cf:: with SMTP id n198mr9978343qke.101.1541285411678;
        Sat, 03 Nov 2018 15:50:11 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id 35-v6sm27550924qtu.69.2018.11.03.15.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 15:50:11 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 2/6] staging:iio:ad2s90: Make probe handle spi_setup failure
Date:   Sat,  3 Nov 2018 19:49:44 -0300
Message-Id: <20181103224948.31014-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181103224948.31014-1-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, ad2s90_probe ignored the return code from spi_setup, not
handling its possible failure. This patch makes ad2s90_probe check if
the code is an error code and, if so, do the following:

- Call dev_err with an appropriate error message.
- Return the spi_setup's error code.

Note: The 'return ret' statement could be out of the 'if' block, but
this whole block will be moved up in the function in the patch:
'staging:iio:ad2s90: Move device registration to the end of probe'.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index ba55de29ef36..4908c8a95fad 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -86,7 +86,12 @@ static int ad2s90_probe(struct spi_device *spi)
 	/* need 600ns between CS and the first falling edge of SCLK */
 	spi->max_speed_hz = 830000;
 	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+
+	if (ret < 0) {
+		dev_err(&spi->dev, "spi_setup failed!\n");
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.18.0

