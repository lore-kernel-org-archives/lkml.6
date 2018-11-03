Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA660C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EF020685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="1CtKVcdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EF020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeKDIDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:03:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41425 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeKDIDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:03:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so8946275qkj.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uRaFpWiqq0590LAIWCKDCZV7Qjo+FL/9V7eRidlfT3s=;
        b=1CtKVcdxkcaI283xQLfB0FmveXFcTjA/J4RM6cOTw0TWTWyYJxs1hfN4KODCcC4rs4
         PdacCMMokO7XCZmntj9zaKaRwMHeTKdUb75OZ+DR6cLWhnvxiK85DN2A1b31MEVefbgu
         X3MhEvXnjvs0IODEaQ8wOx2wPIe50dn+iJY3G7+T49qRBFrcJYJjiQQOG7CM7zrq8jMC
         20DpfgzBZhpwwx/Pxdv4D4CNz3FcYgZ0D5jLK6qEq4cDs7+4eQnNg84gUI067LCdP2CL
         OfZsA447baszPcwSqb2UbHrxngRNGF+sXEjoTcONlbi6TKC4DJvyOWuXWEPYWPwmRXf9
         ZmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRaFpWiqq0590LAIWCKDCZV7Qjo+FL/9V7eRidlfT3s=;
        b=ihlrzYlSE4Qh+yu4Oas4CVtoEE5d2A3JahUr9IK5bf87XUeUTj07L0y8TX0DXcS+Xq
         jy/if6Ib+5aPHnHKtMPjO3hQ+mta3fgVbl9iZE0gEkLX9LwMRTyaDpBxOFBEbq/J1+5P
         mBmuRv3cXZbFi9yTXctJ72Q9Ks1/QJRC6ogGunAKcVRMsOwplhPvvqCeCowV2Dhc1pL2
         +/i3jhp6t+ueLNoH+8AVtWdxIuIKsCRHcx0w9KJ8TeJSLnxYpAmVUNLbHlVfQSvxAIEk
         bvF/Z1ElDagFHmukPhVlJa9gGPIvHBabLj7lmd5q0cEto0A4JXVTXlywpsi42uLDsOTH
         bTIA==
X-Gm-Message-State: AGRZ1gJfb84NoDIv5R1hySSBsD7LqIKajSfPYahzAAH4cw2nmGDIOFZn
        Z7OM9WTwsdJHwUznNYk4r2ujlg==
X-Google-Smtp-Source: AJdET5eBeXKxiHKO8ookz4GGM6+/EUtIbCMcPq4mgVcRBDAoKdwpzrgYl/IHkNdR6ZkZ8j1mPy1+6g==
X-Received: by 2002:a0c:d107:: with SMTP id a7mr16112704qvh.104.1541285425687;
        Sat, 03 Nov 2018 15:50:25 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id 35-v6sm27550924qtu.69.2018.11.03.15.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 15:50:25 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 6/6] staging:iio:ad2s90: Check channel type at read_raw
Date:   Sat,  3 Nov 2018 19:49:48 -0300
Message-Id: <20181103224948.31014-7-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181103224948.31014-1-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
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
index 9c168b7410d0..3e257ac46f7a 100644
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
 		/* 2 * Pi / 2^12 */
-- 
2.18.0

