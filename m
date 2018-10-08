Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E076C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2044520882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="YTuBYE6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2044520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJHKjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:39:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36400 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeJHKjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 06:39:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34-v6so19596062qth.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 20:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=0HJFtfBtXyrpZupFgBzUxECYWTLQ+/Rkof+ovmQGJMQ=;
        b=YTuBYE6ot6bcwdlftYJREir8dEI95p2ZLly8SS57LIe1l51RYR/Vx0/Hy1yqVviP3a
         SGyKGJ9k1rFL2mUTEqOK6qyJLlWcimddp4rleJvJvizLhlAa9WV8wkoAcHmewuTrXlEr
         ykJq3jUmSRei6DUyxBeNZx0g7M2Be92zCQwEFa+zS3/iFYdetDErybG7ETeCczcdEqg5
         K0Y/qQI74909NNz55TJs1BDnJm2Bdymp6QUvOpTR2goWmIoZhzIorHG2m06i7rvEGoCW
         lLMspplgfLOdpAnY2KrtBSvPqnApg+x5iLmIxINDt3IAGam4xO3GkyZqsJlXQ2h/nLNn
         MOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0HJFtfBtXyrpZupFgBzUxECYWTLQ+/Rkof+ovmQGJMQ=;
        b=t5wVHfsCZkAAUMP5ARVUNb3FEI1G9DbYrSm7jCLWhqlXgovG6O9L7JyVUoaqinxUvr
         0jqmbMNdw/VxPWeI77ocPbtsWOogSv51oyzbmrd3NWNtnCYlWu7ZdwaLwHvnlTjRLpNq
         9LWatpRgl13XqJkFGvjk2jWE8+DvNyqWwhpRkGWBZreyDwcFlIqWKR+9jtHvuRQ1b3k/
         TbZSEGGD/I7xpmiw0zKU+a8alQbP7HFqvoa6MNaqoUv1V8YirFoj+PRsIyKUcnIuBdAn
         QwWzmIeNKG8v5gaWUaoKr7WM4sVBfZdk7wu9a6v+gqfh6VatOUueJVVpJL3+QR14nN2I
         vpYg==
X-Gm-Message-State: ABuFfohSRi41Xnf5LAQr0B7rYcGQLACSKbuwKWQuLjp36BgY9C7DvltN
        ukrz3NYpQ5Fc+LVyG70fToh88Q==
X-Google-Smtp-Source: ACcGV60ltub7p897MXVP8dJ0lWKInQxjgW4Z1v/GxiqyYL+V+MsCrq2kr1BYNkPbSbWGXr2fQ9p4tw==
X-Received: by 2002:aed:2e04:: with SMTP id j4-v6mr16780678qtd.47.1538969407109;
        Sun, 07 Oct 2018 20:30:07 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id y124-v6sm4289579qke.22.2018.10.07.20.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 20:30:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2] staging: iio: ad2s1210: fix 'assignment operator' style checks
Date:   Mon,  8 Oct 2018 00:29:38 -0300
Message-Id: <20181008032938.18801-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes all "Assignment operator '=' should be on the previous
line" checks found in ad2s1210.c with checkpatch.pl.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2: In v1, tabs were accidentally converted to whitespaces.
Now, tabs were preserved.

 drivers/staging/iio/resolver/ad2s1210.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index ac13b99bd9cb..d4b1c2c010f2 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -301,8 +301,8 @@ static ssize_t ad2s1210_store_control(struct device *dev,
 			"ad2s1210: write control register fail\n");
 		goto error_ret;
 	}
-	st->resolution
-		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+	st->resolution =
+		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
 	if (st->pdata->gpioin) {
 		data = ad2s1210_read_resolution_pin(st);
 		if (data != st->resolution)
@@ -363,8 +363,8 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 		dev_err(dev, "ad2s1210: setting resolution fail\n");
 		goto error_ret;
 	}
-	st->resolution
-		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+	st->resolution =
+		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
 	if (st->pdata->gpioin) {
 		data = ad2s1210_read_resolution_pin(st);
 		if (data != st->resolution)
-- 
2.18.0

