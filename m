Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D15C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98D520818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SakyNVVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfBERNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:13:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45882 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBERNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:13:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so2496923qka.12;
        Tue, 05 Feb 2019 09:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mzFr4ZazdF13ZK91RywtNQq3/uZe6MS2/htomMdeAJU=;
        b=SakyNVVVHRYogzNYAhrpqC6e01neaA2pn+77ZIMdzQABGC3ApEC3k+guQfN6Ezv0/I
         /xPfnlYRnzt3eaaycfK6eRCbr5MfMLT19jHXWpvyGedNvhyawGon6eoH+S0v/a469ph8
         MKv1dGQi2uZ7vxYLVYfiuCmgf8qvc6z0wQaNL4tkbwsUmYf7Cd1zRPFriLTYOZTUTrgX
         8aOHr5/ga2+Zi8cddzWpIj5VD5wTPwLyitFLRet3394WX/+FwWYKmNAVTSkWjGkR+kDD
         3P+8YcFEvMrMJebaNngYzyXTyJWIEXuE8OcnXyRi6L8RKo6ED0cgbMZHIvf8VErHssJA
         KBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzFr4ZazdF13ZK91RywtNQq3/uZe6MS2/htomMdeAJU=;
        b=CirQNtjtB4SuDACMbgMVUNwLRVGzf7uyAUHX5UnJYSK8uNeSe5sb67LBuThJumxXzM
         wZpHpf/AJL2vW4fksND9UJinHlk/KG4QqPOtAhKuUDucVIkQtCO7JAkQ9dY4n+PtdC0e
         jAYN3o1XumT94Ztp4ZdmdmjCk90fm3Zwb5ozVREOT9xTfLOdJTjqBKZUxuFR0C6WOhco
         pbWTJr/cMwJpYKBW399YM+i6tDxZ6HwS+RXU8V4U3CAQMo+m44jGGbAivkWFWiPa+kJ/
         Hg1v4Awtk1bUQAWSbWFhwDvFc4ZwuVCLE8dWInu36R8tsAYwKQeCxZwxJA8a6UQyiXbC
         baIQ==
X-Gm-Message-State: AHQUAubVZ1jDUZbIPIAF0OZKySvX4jBPAAyoc6dYqiEKPqpLjAIMQ8K8
        ew27ZXHrg8H3Ga7pH6DqNR0=
X-Google-Smtp-Source: AHgI3IaQv/hqA0YRemE3agBF8PF50/WUn3T1AuTJE+XW8bAnLqVqHhWjYSY77osmJUVXJhC4xUy71w==
X-Received: by 2002:a37:360a:: with SMTP id d10mr4361756qka.40.1549386828190;
        Tue, 05 Feb 2019 09:13:48 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y33sm9039675qty.11.2019.02.05.09.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 09:13:47 -0800 (PST)
Date:   Tue, 5 Feb 2019 15:13:42 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 3/4] staging: iio: ad7780: add SPDX identifier
Message-ID: <8efd5090342542766380f8f2276ed52bacf84cf1.1549385784.git.renatogeh@gmail.com>
References: <cover.1549385784.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1549385784.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifier (GPL-2.0) to the AD7780 driver.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 7804cd2b273e..163e3c983598 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
-- 
2.20.1

