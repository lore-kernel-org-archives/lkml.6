Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798B2C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 10:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEEC219F3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 10:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlKSKDhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEEC219F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeHKNBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 09:01:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44684 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeHKNBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 09:01:08 -0400
Received: by mail-pl0-f65.google.com with SMTP id ba4-v6so5027091plb.11;
        Sat, 11 Aug 2018 03:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZQShvBK2SpYMU2qzPWJmBLbnquryN45IeArdF60JAf0=;
        b=qlKSKDhPuc6cXA+FaAa9lWF4TkWVnxcVlkEDC7oThE9MJHWJrSIDQAukIwAbTtWMkn
         LmRJllD3fQFEWyB7XVWy5vDKPzRNF3/AmdB3PgwcCBo6rxx3z9Rd4lXNkvTNGHD0dccg
         sqfL4q6GxZXjAnxSNFZdXpFrnbDlr4hc0wxQKrW6uQu4bD10MbCagZhX368mZXOLxpXK
         mTZ/U4euvF762rnkPmnJmqFtdKT8qggNPC/BDe/m1RpWfA7unCi57GoQ+FCu6uVp+zW7
         eizwf8MojeGjjAFo8eSGcDN/UL5emASeWlplF6+QR9BFVAQ5tYxAX6gBB2Ghgz2yrS3B
         b/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZQShvBK2SpYMU2qzPWJmBLbnquryN45IeArdF60JAf0=;
        b=BOtmyLEzXaF7AKVDnJzZjMQkCOJ6c8dTPtSTXuexCB++8clkml2RuJ9OAmxWmmE5EP
         nWrg+9mEjzdFwNBtzjh4SDrS2MFsAJtHaCc/Sqq+qQvI/Yf9Q9RVdgutRkN/SOZrcWes
         pi8DHgo7gaGPvewxR8UC7+TTR1gg6dBjxn0WlEKL08gcwXniit5bv+uZWhx5y53gvTla
         L8U3O54c/jPNB6BBxVaHjo1sMwnpDsF7SHsN2VaTnhbXPxEBI9/4MfweVrB0NeGAKQzW
         xSWfaU5I8JOm3da4vBq8uryo005zSp0n8ths2O/mHSwO2sSTexXsViWdag0hIwJVX/R3
         lxmg==
X-Gm-Message-State: AOUpUlGcvQLSon+bypmzup48MYn8rdVIuXOdolLhJdqrH7BTurcaE8Xq
        E1TQgcXscEWHMce+Q1vN0so=
X-Google-Smtp-Source: AA+uWPzOqEgY4ec+ik10SzcOUyKiPoL/3i7ijoDTg8sLeJBKRSiW6EvhdI70FNqqWg2jwBDcyeW50g==
X-Received: by 2002:a17:902:b81:: with SMTP id 1-v6mr9644886plr.164.1533983242516;
        Sat, 11 Aug 2018 03:27:22 -0700 (PDT)
Received: from localhost.localdomain ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id m26-v6sm31373079pfi.102.2018.08.11.03.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 03:27:21 -0700 (PDT)
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     jic23@kernel.org
Cc:     dpfrey@gmail.com, daniel.baluta@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] iio: chemical: bme680: Add check for val2 in the write_raw function
Date:   Sat, 11 Aug 2018 15:56:36 +0530
Message-Id: <20180811102636.6171-1-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

val2 is responsible for the floating part of the number to be
written to the device. We don't need the floating part
while writing the oversampling ratio for BME680 since the
available oversampling ratios are pure natural numbers.

So, add a sanity check to make sure val2 is 0.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 7d9bb62baa3f..9d5a05e054d1 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -852,6 +852,9 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
+	if (val2 != 0)
+		return -EINVAL;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
-- 
2.17.1

