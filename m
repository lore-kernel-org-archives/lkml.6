Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC666C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB872084A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ZdVgjW8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB872084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJZJUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:20:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36249 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeJZJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:20:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34-v6so12199237qth.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NU6uEhiDTDfMKDT6vIKylD1JcOmwJKYVJFXwnpeU4xs=;
        b=ZdVgjW8o5j0hFmycZse60LAYwk8ZLgVMTfFc/PlA8x3OYy9kyQRpq8HWJbsiY+9TzA
         H5/mEniByRs99eSMaHt7o8ISGkpv6ucZtejmliUQgB5uUc/g1n+OsbI9cFN7S2KySPVg
         Ff3J75XU6zXHQzSZdPj9qTCTsk4C8EzDUstNEsTMqYknQV3ES1bTACfcRQIaUCOnIwR0
         u3jwsYXFQ4hFa2KKQzzQ3ex8ITB+pBOuh5Yhnmhfl3kTIqvmRy+huxwDF8+YiAVtukdW
         0oQ4PdYwbkQrgZYTuEvE1PzCK1kkdwN8c8ClZZTFIVd5pY4zHmN+CjCRz7izB3EyDHbV
         azfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NU6uEhiDTDfMKDT6vIKylD1JcOmwJKYVJFXwnpeU4xs=;
        b=Qi8U7bxxEymoZyP9UJLldBgIwp509q/oYFYbHNRHFJPEnWyK9YQL/vfmWgxJWtqu6h
         jj4e+rkwc3LY1/I8W7M/0zBve4GbeqlNgx7BCqRKMW+RCp1+OgkHblkTpsHpvc317zLT
         37+JEwbx0WhSDivxU5R+xQPgf2Gar20bYvJ5PsaRJAvpImJO907O+/3b2PFadOsdWNCL
         fLV3XRGrzXVZQl/BfOO4WMzmyDgLL+3nJAlUHTNTvBt4siU+bLpV95zakm03XFwc6qdi
         sseugNleio2JWg8sYMPQy0aH08Zmh/mTmm+b1nIL5mjQ5jHw+q7cdJ77Crwp4N/bi25Q
         OzZg==
X-Gm-Message-State: AGRZ1gJbyuTjAA0FvW+zLSp6oUwKlNASqPTKsRa/321rVQxBlX4IY/IT
        wwiIwTmeIFIfdFqmspdVTCQ4qQ==
X-Google-Smtp-Source: AJdET5f6Mgqdy+oiFVJ9tbTYEHDf1YxO93I/lCYm3xwuA+nY9xSIuT5bMCFVn/FmVxK54U9rBhNwGA==
X-Received: by 2002:a0c:9d01:: with SMTP id m1mr1412459qvf.192.1540514741602;
        Thu, 25 Oct 2018 17:45:41 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id y3-v6sm2371735qti.27.2018.10.25.17.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:45:41 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 6/6] staging:iio:ad2s90: Check channel type at read_raw
Date:   Thu, 25 Oct 2018 21:45:12 -0300
Message-Id: <20181026004512.31012-7-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
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

