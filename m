Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BA0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABAA2087F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABAA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbeHIQSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:18:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52703 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:18:43 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fnlNi-0001XM-TF; Thu, 09 Aug 2018 13:53:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: max44000: remove unused variable max44000_alstim_shift
Date:   Thu,  9 Aug 2018 14:53:38 +0100
Message-Id: <20180809135338.10868-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable max44000_alstim_shift is defined but is never used hence it is
redundant and can be removed. This variable has been like this since
the driver was added back in 2016.

Cleans up clang warning:
warning: 'max44000_alstim_shift' defined but not used [-Wunused-const-variable=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/light/max44000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index bcdb0eb9e537..b9b0bd341be8 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -99,7 +99,6 @@ static const int max44000_alspga_shift[] = {0, 2, 4, 7};
  * Handling this internally is also required for buffer support because the
  * channel's scan_type can't be modified dynamically.
  */
-static const int max44000_alstim_shift[] = {0, 2, 4, 6};
 #define MAX44000_ALSTIM_SHIFT(alstim) (2 * (alstim))
 
 /* Available integration times with pretty manual alignment: */
-- 
2.17.1

