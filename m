Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FC0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D142183C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D142183C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965295AbeGBKOH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:14:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55483 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965036AbeGBKOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:14:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZvqK-0004Cn-6i; Mon, 02 Jul 2018 10:14:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Silvan Murer <silvan.murer@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: remove redundant pointer chip_info and spi_dev_id
Date:   Mon,  2 Jul 2018 11:13:59 +0100
Message-Id: <20180702101359.16461-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointers chip_info and spi_dev_id are being assigned but are never used
hence they are redundant and can be removed.

Cleans up clang warning:
warning: variable 'chip_info' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/dac/ltc2632.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index cca278eaa138..28e9b7656b20 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -87,12 +87,7 @@ static int ltc2632_read_raw(struct iio_dev *indio_dev,
 			    int *val2,
 			    long m)
 {
-	struct ltc2632_chip_info *chip_info;
-
 	const struct ltc2632_state *st = iio_priv(indio_dev);
-	const struct spi_device_id *spi_dev_id = spi_get_device_id(st->spi_dev);
-
-	chip_info = (struct ltc2632_chip_info *)spi_dev_id->driver_data;
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-- 
2.17.1

