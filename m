Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE87C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBB422BC6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBB422BC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeGCTgL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:36:11 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.4]:19500 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753664AbeGCTgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:36:07 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 02D16FCC3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 14:36:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aR5bfhsM1bXuJaR5jfsG1t; Tue, 03 Jul 2018 14:36:06 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=49334 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1faR5a-002Z0e-UG; Tue, 03 Jul 2018 14:35:51 -0500
Date:   Tue, 3 Jul 2018 14:35:50 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio:imu:adis: Mark expected switch fall-throughs
Message-ID: <20180703193550.GA12565@embeddedor.com>
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
X-Exim-ID: 1faR5a-002Z0e-UG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:49334
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/imu/adis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index ad6f91d..c771ae6 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -81,9 +81,11 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 		adis->tx[9] = (value >> 24) & 0xff;
 		adis->tx[6] = ADIS_WRITE_REG(reg + 2);
 		adis->tx[7] = (value >> 16) & 0xff;
+		/* fall through */
 	case 2:
 		adis->tx[4] = ADIS_WRITE_REG(reg + 1);
 		adis->tx[5] = (value >> 8) & 0xff;
+		/* fall through */
 	case 1:
 		adis->tx[2] = ADIS_WRITE_REG(reg);
 		adis->tx[3] = value & 0xff;
@@ -167,6 +169,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 		adis->tx[2] = ADIS_READ_REG(reg + 2);
 		adis->tx[3] = 0;
 		spi_message_add_tail(&xfers[1], &msg);
+		/* fall through */
 	case 2:
 		adis->tx[4] = ADIS_READ_REG(reg);
 		adis->tx[5] = 0;
-- 
2.7.4

