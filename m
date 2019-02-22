Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB80BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7850420700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ZIIR996g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfBVUco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:32:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43221 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfBVUcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:32:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id y4so3997408qtc.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWrDT+N2hTJztj5qg3/F190Jbid6q1JWQQqk7w1nQHk=;
        b=ZIIR996g2a525uzIzoHH7wyxHA46C4r1XCwqy1KEpi38vgU43lq6jWMKHLu28/UvRt
         Ju7nRtb01XOt5WS15JWzTXd1mozlNlln6O8vBo4qduyS3F8SOIEPsTMpgZcSp2hovlE0
         FV++ecxyaxiQxcHvSPK3l+8BLHe8Rx8r9tNaS83DpDDYt1TyGqN9ImB1S+8RAVeuvgqI
         2exgCoY4wkD6dtLkqeLjj9BrG+xlkhPz1q808iZC63tPe8S2wvAYccXOkYpMqKf4qkzX
         0dmd0EPsi+GjoDfjzWJlabGYWMhZ6U9U9QrJwHJSyg4zOrPoNBlyN5OFYRyeRaoBNoPi
         MPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWrDT+N2hTJztj5qg3/F190Jbid6q1JWQQqk7w1nQHk=;
        b=KrYZSs2dXV+OfuZtRA/m5w6efUtWx1lfpblfd+H1fMSirL6R+/K6MwC+8ZFwODdYkn
         Qq/EbRC27PNqz+MDXuGDXNk0CneAqv8cF0e4ejfrmyrSkMXUDdy/AGKJaDUl7MeIdbXb
         S4XSnPzfLL7hPjmNhExh0f3aIrWFwQeUhL7U6vBQWkGJHnxSf51b+uy1dt9wlrcwOq+l
         T1IilhPEQ0yWmbWGfC/5obuMgHmal2AaJIOVccbmIKbmoZ7JKp7Gwl/XhmTsXDkAvySt
         338HbDQeKpMOcDso2+JFfcE2pN65Pu9ZzWaUes0B4NqEJwdg6/jbXdJqirQoE+JbwtGP
         lENQ==
X-Gm-Message-State: AHQUAuZmyFQGuPukZjBudCpzWO+Y/+ZV7r+kaOOnqKeZ91ZpHu2aAo67
        7HhoqVR+bZkF58PSi/1FQgdeTQ==
X-Google-Smtp-Source: AHgI3IbaMKql4aox766FC7vjTtMxLaJYWeE2bmiXIYFXJMKlBpnJFOfYcUj6u1RpYE74XTQwKesSDg==
X-Received: by 2002:a0c:b5c8:: with SMTP id o8mr4697533qvf.213.1550867562632;
        Fri, 22 Feb 2019 12:32:42 -0800 (PST)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v26sm1449149qtk.22.2019.02.22.12.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:32:41 -0800 (PST)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
Subject: [PATCH 4/4] iio:adc:ad7923: Rewrite comparison to NULL
Date:   Fri, 22 Feb 2019 17:31:59 -0300
Message-Id: <20190222203159.15116-5-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222203159.15116-1-barbara.fernandes@usp.br>
References: <20190222203159.15116-1-barbara.fernandes@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solves checkpath.pl's message:

CHECK: Comparison to NULL could be written "!indio_dev"

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
---
 drivers/iio/adc/ad7923.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index dbece44e26e4..cb7b854df00c 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -272,7 +272,7 @@ static int ad7923_probe(struct spi_device *spi)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-- 
2.17.1

