Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B311C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D31208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="mW1FtTWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D31208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeKJHoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:44:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39317 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeKJHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:44:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id e4so4340590qkh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V8cYmRlqTfNBOdNYMRR81wcszfkAodJ8iKTi/B1OPdc=;
        b=mW1FtTWZuN9J2aWOjEaZVESgUwH2fQS/c+OPw5pXryIYj6OYo6s3yozhU0eGDH2JbX
         bwabyj9W9AvNnJlEK45ixwZthKMnklaGms7/pAqKPWnUOwMTivk5x9PEd8W8UWDIsTYY
         X7ylmZY7qRxvI/VPmFc1C74fOgAX8vFeoC8mMXRS7wkkz37UpIDv9qST3rdD4MNE+Hhl
         BQpF6CRgdoiC2VTZSh3NLmSbFWaGqrnMr2eijBBwznX0aOFv6Q/DqEB40P2mvwOyIfC3
         DMApsHQxc4GRorgXdUAzHA+wOdfXbxiqdEIVHA0hCcJWGw4oySbeETJn0Wd/pHnbdFss
         aPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V8cYmRlqTfNBOdNYMRR81wcszfkAodJ8iKTi/B1OPdc=;
        b=dk8YmKsCFlSRZc/K1bFrmzQQCBi3UMDZLhWmIQOiTLiN9nw4wN2qjvNxGumDxwXBU7
         5JpvSTxyULj0yb/tU/m5axgg1a9CSdXSc+xt0ACaCSs4TGl7qS8rlZ2guCO5Vc+azLFq
         YRQHVvuxK/MJZHWiWtB/L5Ia4z909msUZXae1hl42UsnfU6k4U+eNcrb9gieGAA8U6+2
         rAmS9582T9NKkJHze9F3pME7M7AnOE8utUU6tH7sVBDZSKv0Nf1n9ikp9N06YihSWF9Y
         Wt0hVn8ccbOF4ys2xYuUTQbGopgAtuvdKfo53xGrKP5kQwjFfgCz7JKKhy+xxyIFLgqq
         JJJg==
X-Gm-Message-State: AGRZ1gLW/l6J454UowXOZtTr1jq0BKv34cErRQvFQ3HoQcJ/kIeITtNK
        6YJ/fGiNWd4xa9I2X6TJ7zuWYQ==
X-Google-Smtp-Source: AJdET5daw5Dp20yirmuN36fsNYUVedPH6Zykq7MjCveOXKknyx3V1clEZLAslfj3Y4gwKvp6fyh2cQ==
X-Received: by 2002:a0c:8ae3:: with SMTP id 32mr10495853qvw.27.1541800893976;
        Fri, 09 Nov 2018 14:01:33 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id k6sm6082723qtk.41.2018.11.09.14.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:01:33 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH 5/6] staging:iio:ad2s90: Add SPDX license identifier
Date:   Fri,  9 Nov 2018 20:00:43 -0200
Message-Id: <20181109220044.24843-6-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181109220044.24843-1-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the SPDX GPL-2.0-only license identifier to ad2s90.c,
which solves the checkpatch.pl warning:
"WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 949ff55ac6b0..f439da721df8 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * ad2s90.c simple support for the ADI Resolver to Digital Converters: AD2S90
  *
-- 
2.18.0

