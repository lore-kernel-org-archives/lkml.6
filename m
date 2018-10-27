Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE544ECDE46
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9150A20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="sOjLj73h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9150A20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeJ0KkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 06:40:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41294 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbeJ0KkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 06:40:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id 189so431595qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 19:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NU6uEhiDTDfMKDT6vIKylD1JcOmwJKYVJFXwnpeU4xs=;
        b=sOjLj73hbkjSNHCbjYdY/10ua9GvS5qgofryFwX7Al2Wq0Ah/5T0+uLHRFthjyBSJR
         fTxs1EBvwwPAxu2/CpX6Rp9IcNWvQ4Dczucmuj7hIBEjAjTCvnvcuzwYtr7a7BmczEqD
         EC9Hw3/QdPVRZ54nCM9GZYJzFYhzuMSUc9tSmxuHNoTrd9bXikADe/Jk/AAIe2pLYDxP
         CtEwaCma9AcArR9h9GULLKwSFz0RjwZ0m1s6diAdZp2M1n9k5D3V/8AAAZBJL2Jc4L4R
         +rRwBd4hm+ldGz7/+5i9pky/AHbNqQMzDVnqoYm/juj42YnPhnKwVJn6rjc8PQwroUSd
         GRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NU6uEhiDTDfMKDT6vIKylD1JcOmwJKYVJFXwnpeU4xs=;
        b=Q9JmcUt8CpfUuwHG0sA1nEqPE0hQucqY/2iJqLd9PVBncWagxUw7hPztSvhuJwSKjh
         P7zlhzV2NAucMtUMo/vtU6wf1rbHtRq5U5DD2UFDIdZyvUkyDdXj75/RkAKq/Jccec2p
         UISYzz4wiqiQEImVYEd+yt3emu2nG2A5Btvje6/Jn7BajJtQoofqBxEBXVgHGd/4z9aE
         igbCY43vevG+jTGr+uTOwgIMnBBXswvJoMAvIQ5tD+ZIdeCsGNR2DGcN9PU0ay5uhxS8
         iXy2L4cf9ODw0SQklUlFvdUC8o3x/5UwYsmVwalafHT9dshHSH9L6gtyo9io9t74JSHV
         2l5w==
X-Gm-Message-State: AGRZ1gK+tCcpp9po4KNnni8XpFQsHe8bbXyDV1INEPliphgHYefYca8H
        QYXYjRjSgHWEm5FCseB+rSRE2Q==
X-Google-Smtp-Source: AJdET5cpuLESHD23vMBbkSd1mZMwXcwmH5QzRTLkRUJMo3g/oXciZKeWaC6sNGnbDMdF/eH7p6RlAA==
X-Received: by 2002:a37:1ad9:: with SMTP id l86mr5001061qkh.54.1540605653316;
        Fri, 26 Oct 2018 19:00:53 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id h67-v6sm8499777qkf.32.2018.10.26.19.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 19:00:52 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 6/6] staging:iio:ad2s90: Check channel type at read_raw
Date:   Fri, 26 Oct 2018 23:00:05 -0300
Message-Id: <20181027020005.3140-7-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a channel type check at the beginning of the
ad2s90_read_raw function. Since ad2s90 has only one channel, it just
checks if the given channel is the expected one and if not, return
-EINVAL.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 52b656875ed1..24002042a5c5 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -34,6 +34,9 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct ad2s90_state *st = iio_priv(indio_dev);
 
+	if (chan->type != IIO_ANGL)
+		return -EINVAL;
+
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
 		/* 2 * Pi / (2^12 - 1) ~= 0.001534355 */
-- 
2.18.0

