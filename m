Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B9C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EC420883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EC420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933077AbeFUNW5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:22:57 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.35]:30437 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753008AbeFUNW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:22:56 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 54DFA8233
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:22:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VzXQf3OuxbXuJVzXpfFvHQ; Thu, 21 Jun 2018 08:22:54 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=52400 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fVzXQ-000zF8-6e; Thu, 21 Jun 2018 08:22:12 -0500
Date:   Thu, 21 Jun 2018 08:22:09 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Esben Haabendal <eha@deif.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: spi-fsl-dspi: Fix copy-paste error in dspi_probe
Message-ID: <20180621132209.GA27215@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fVzXQ-000zF8-6e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:52400
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the proper structure field to use in this particular
case is *regmap_pushr* instead of regmap.

Addresses-Coverity-ID: 1470126 ("Copy-paste error")
Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode registers")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 1f85dcd..ff7456b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1066,7 +1066,7 @@ static int dspi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to init pushr regmap: %ld\n",
 				PTR_ERR(dspi->regmap_pushr));
-			ret = PTR_ERR(dspi->regmap);
+			ret = PTR_ERR(dspi->regmap_pushr);
 			goto out_master_put;
 		}
 	}
-- 
2.7.4

