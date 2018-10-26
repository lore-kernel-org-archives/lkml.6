Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB6BECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCF82084A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="IfrNsM4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCF82084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJZJUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:20:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41290 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeJZJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:20:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id l41-v6so12182218qtl.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J5RxTErJXoIN4DFbUXbMSG5XxKyOAlaWHaLsxy5wXNA=;
        b=IfrNsM4AxhSnWDdkSFRcz+w1o9OyzWXIeRS2LPgnU7cZLE9hG5iC0jvLMFjgMBGhn8
         0TbvVqWOYBEDT2nlu79IZr00SAKUIWO5JetEbgEDG4Si/oWDsZQa7+iLrNEtZ6zFpYac
         b7AntHRcyWJ3PVU0nGXAj8UwPUljobOHT81AOj95nI9WE52hlHVkmTWL/mVdq9gypnk/
         bEtiIGGy2aOd7Dg+heGWJx8Fv/7zGefZatjN1VZ973bxIHVE1LsqipFHBHJiTdxV57gF
         iYE6097l/3sBWivydTAST5U69a5Lck4id7trI14crXdMUV/rjvPvQf3XMVEr1428f4/8
         TR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J5RxTErJXoIN4DFbUXbMSG5XxKyOAlaWHaLsxy5wXNA=;
        b=qYevPOYnyvuj1EJVS6i4IO89fk2z74NL8uxJSQqq8Gh3lwBwZd+VndqbvPJrPIoSCD
         AbW+i5rAXZSoFSHrpnUMPBX3GpBBtZJ7xala/9Kdh2kPF8ZXnguWsP4fAJ7XSo2v4p0F
         /jRYh/jntNLgXCzWWM6/aO6PqIvb+UxewAn7Co07cfVojt/hC9+P0n2LgPEvW0m39CAk
         C54kdH6I5W2is7iZVUkFE7hPVXztc2sBwzE1ZAIXV1AvNRHeTzxl0ojvkQTpzJI02t4M
         unsKX6IUZurbBCutOXsYb2v4T2kgfqPujWt3lzhPcD7hHldzRsptmxyyOdEn1M+C10Ia
         60Zg==
X-Gm-Message-State: AGRZ1gLDCeq0h5we/T4YU5QNJIeBZ4nV1wxVAF/CSGOFCUJipAfEGqh2
        J4/o99V9NC6nMXWReZIjiOe3wXUbUZgbwQ==
X-Google-Smtp-Source: AJdET5eYrL3B/6dDzP8IGUjwaVecsh3FNyp3rV8oNHMSnHyIglObGdVoGIhMr03WixV2ngY3+yxZIg==
X-Received: by 2002:ac8:4506:: with SMTP id q6-v6mr1422639qtn.68.1540514732803;
        Thu, 25 Oct 2018 17:45:32 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id y3-v6sm2371735qti.27.2018.10.25.17.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:45:32 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 3/6] staging:iio:ad2s90: Remove always overwritten assignment
Date:   Thu, 25 Oct 2018 21:45:09 -0300
Message-Id: <20181026004512.31012-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
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
index d6a42e3f1bd8..c20d37dc065a 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -64,7 +64,7 @@ static int ad2s90_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad2s90_state *st;
-	int ret = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
-- 
2.18.0

