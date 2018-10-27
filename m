Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F54ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CBC20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="WjbK4B6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CBC20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJ0KkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 06:40:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39923 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeJ0KkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 06:40:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id e4so1844446qkh.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NGr8UhZ9CwRomF1EVbg7fLmktxQjU3RFkveOlg5US54=;
        b=WjbK4B6Pz9n82ZrdDfd6PM5GbCp+QQyg3yNP3mE7mKzlOXjeN844EOEYIK2yahjQ0o
         mVp8ZHWSiKqLhFU9dnqEusVrxdF5+JSSC859jT7UY984FUY0tflownWmlZ2cmc8CGs+S
         t5xXcLBtcYq4EXaVJKSzsERb14VLzX0FNpZm06WX2ReOxgJAS8HI744ZwIUCV4hU3YMZ
         Kn6aBih4w7SM2pRK7K3QsFWq5UKIh+IaTLkDvcXJ6o/iYJlFE2B0bogytJBkp9fhmehr
         NX5h0px7aJS0V+aFJ7EZpleD7VB0oBRmUpu2ebvwHrP4hrlF8Z2W8ht/UmcwhwFYFgH5
         nsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NGr8UhZ9CwRomF1EVbg7fLmktxQjU3RFkveOlg5US54=;
        b=KpW9T1pzsYhggK16zBs3s+ePl+s5AYX4lifdbTalHAHhKKc6mC3dysF3vJ6kMGHUsW
         v+TC6BseKFIks/01xU5mZQbPsQo+z3M+s0IlSsaL+gXBFAnn9SRz1Ew7XtgfBTG067JL
         fiG6y+8ppq6BA7oe2CTuRa608wWJpGuTSUSGjdGjkgW5DbSKB6en0mohcn4djXRlyDRv
         KiAx44vMZJc1+BjeXf2wK7CS1ktmf8Nne85l94rghpJMTMaxo4tzA99JXDpDk95aJ6ft
         qpode7Yjmr6kBCZNP0B3W7VEG53EgcQgZL1tlWN3LY6Hx9DRtdongPRT40+MektGT5Mz
         tdEg==
X-Gm-Message-State: AGRZ1gIaX3CmmvBY1wWA07slUhloYZcJmQ8+koyzswOyV2/p69IlZIaH
        rM+p/9gGiruC5c1RXbR6GGChDw==
X-Google-Smtp-Source: AJdET5fQuEouxoTq1ebTp9DugDk3pG9h6vIhcvOj+9AFlURyWW6ARC4U0cY76QYXWd4bS/Cds7iOMA==
X-Received: by 2002:a37:fa8:: with SMTP id 40mr5265581qkp.48.1540605641110;
        Fri, 26 Oct 2018 19:00:41 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id h67-v6sm8499777qkf.32.2018.10.26.19.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 19:00:40 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 2/6] staging:iio:ad2s90: Make probe handle spi_setup failure
Date:   Fri, 26 Oct 2018 23:00:01 -0300
Message-Id: <20181027020005.3140-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, ad2s90_probe ignored the return code from spi_setup, not
handling its possible failure. This patch makes ad2s90_probe check if
the code is an error code and, if so, do the following:

- Call dev_err with an appropriate error message.
- Return the spi_setup's error code, aborting the execution of the
rest of the function.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 11fac9f90148..d6a42e3f1bd8 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -88,7 +88,12 @@ static int ad2s90_probe(struct spi_device *spi)
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

