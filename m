Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20889C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604B204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="rOKyx10R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D604B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeJZJUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:20:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34006 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeJZJUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:20:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id z2-v6so12234005qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NGr8UhZ9CwRomF1EVbg7fLmktxQjU3RFkveOlg5US54=;
        b=rOKyx10RBKfSqOFtomhH6h1F9pCvFTdlBHfhpdYPitYnjM4w60pTYS/+VVgnO8GPh6
         8lpYdCvbst88qyJ+GA0Jo6R/J3zlsy8i6cu/bmUJa1ajX/J/vx4IWlAS/FANAlcrIlqb
         Ok/fzUl8pNPLLHPj+XmhxzpO44mvJRSxspzN/ZzErOOw7XnS7OqukMveU5xxbyXl1aBI
         i6DiyO5ILy8uqyx8X7t9+bDP332/wI0uUzXllGxKQ4H9mDHzNLqMC+nudw/F3YY2R5ll
         HfP5f7dEGRrzdmG9J8itw9tb6Tpoz45Fk/mAy/OMfNVY2Rj9Furwd97Tpj2zquNldt8b
         TH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NGr8UhZ9CwRomF1EVbg7fLmktxQjU3RFkveOlg5US54=;
        b=YKcpnQFHMNN3IQawPHRg0Iy6fJCR7ilc2g+D6OD2pgtbqxYNk9hvvoh8mekQd28bHY
         HnjYyVCiPPKTIk/4WFzfOkSMEzZmC87F8sTra9V84pxzweBkHswM4R8Kf2r1OmNkgYG/
         IZN4syRQDB0KNTxiDD8IU1nhxYUv09cem9bLF5oMtnVrrHsq625/rQubrPjvxO5Q4vQN
         zDNq/sgVZrXTJzk0gAcY1amleTJknBw8GcS0MGF2a4egy9anwtBKxPAaxabQRHKTX+t6
         XqADINKPTDp3zjRxk+XnytgsYeUNJsOor3dZwjr5gUpRKXZakqn0Q6Gutx0X3ztzaL3o
         3g/Q==
X-Gm-Message-State: AGRZ1gJlYo68K95wDQJX4Re/NfRw5txj9vIL6h+iACnLdZJ3+A++/3Og
        NogRpQUwE5508Cb/cdOxggHq1w==
X-Google-Smtp-Source: AJdET5dr5t3m8XMFDiKyAjILMJM7tAbXfincs/RfvmTFPw4kt2EiwgecmvjJwTGxnjfMRI3FEZKL8Q==
X-Received: by 2002:aed:3b4b:: with SMTP id q11-v6mr1333973qte.229.1540514729837;
        Thu, 25 Oct 2018 17:45:29 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id y3-v6sm2371735qti.27.2018.10.25.17.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:45:29 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 2/6] staging:iio:ad2s90: Make probe handle spi_setup failure
Date:   Thu, 25 Oct 2018 21:45:08 -0300
Message-Id: <20181026004512.31012-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
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

