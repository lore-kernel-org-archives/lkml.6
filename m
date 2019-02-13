Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DC9C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB702175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbfBMCsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:48:47 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.133]:22456 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733035AbfBMCsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:48:45 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 322C2402C3B63
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 20:48:44 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tkbMgr8WI2PzOtkbMgLobP; Tue, 12 Feb 2019 20:48:44 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=38828 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtkbL-001ogo-Bm; Tue, 12 Feb 2019 20:48:43 -0600
Date:   Tue, 12 Feb 2019 20:48:42 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] iio: chemical: sps30: mark expected switch fall-throughs
Message-ID: <20190213024842.GA25131@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gtkbL-001ogo-Bm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:38828
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/iio/chemical/sps30.c: In function ‘sps30_read_raw’:
drivers/iio/chemical/sps30.c:289:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    switch (chan->channel2) {
    ^~~~~~
drivers/iio/chemical/sps30.c:299:3: note: here
   default:
   ^~~~~~~
drivers/iio/chemical/sps30.c: In function ‘sps30_do_cmd’:
drivers/iio/chemical/sps30.c:120:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
   buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
          ^
drivers/iio/chemical/sps30.c:121:2: note: here
  case SPS30_READ_DATA_READY_FLAG:
  ^~~~
drivers/gpio/gpio-eic-sprd.c: In function ‘sprd_eic_irq_set_type’:
drivers/gpio/gpio-eic-sprd.c:403:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   switch (flow_type) {
   ^~~~~~
drivers/gpio/gpio-eic-sprd.c:435:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/chemical/sps30.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index e03a28a67146..f308d8ddceec 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -118,6 +118,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
 	case SPS30_READ_AUTO_CLEANING_PERIOD:
 		buf[0] = SPS30_AUTO_CLEANING_PERIOD >> 8;
 		buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
+		/* fall through */
 	case SPS30_READ_DATA_READY_FLAG:
 	case SPS30_READ_DATA:
 	case SPS30_READ_SERIAL:
@@ -296,6 +297,7 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 
 				return IIO_VAL_INT_PLUS_MICRO;
 			}
+			/* fall through */
 		default:
 			return -EINVAL;
 		}
-- 
2.20.1

