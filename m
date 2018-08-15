Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73940C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83611214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83611214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbeHOUEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:04:21 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.119]:17401 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727604AbeHOUEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:04:21 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 463F54011F4A5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 11:14:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pzJdfqIeQbXuJpzJqfE0xS; Wed, 15 Aug 2018 12:11:01 -0500
X-Authority-Reason: nr=8
Received: from [189.250.37.72] (port=60344 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fpzJc-0000Yj-4j; Wed, 15 Aug 2018 12:10:36 -0500
Date:   Wed, 15 Aug 2018 12:10:35 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] pinctrl: lpc18xx: mark expected switch fall-throughs
Message-ID: <20180815171035.GA17360@embeddedor.com>
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
X-Source-IP: 189.250.37.72
X-Source-L: No
X-Exim-ID: 1fpzJc-0000Yj-4j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.37.72]:60344
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1292308 ("Missing break in switch")
Addresses-Coverity-ID: 1292309 ("Missing break in switch")
Addresses-Coverity-ID: 1309546 ("Missing break in switch")
Addresses-Coverity-ID: 1357369 ("Missing break in switch")
Addresses-Coverity-ID: 1357389 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pinctrl/pinctrl-lpc18xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
index 190f17e..a14bc5e 100644
--- a/drivers/pinctrl/pinctrl-lpc18xx.c
+++ b/drivers/pinctrl/pinctrl-lpc18xx.c
@@ -844,8 +844,11 @@ static int lpc18xx_pconf_get_pin(struct pinctrl_dev *pctldev, unsigned param,
 		*arg = (reg & LPC18XX_SCU_PIN_EHD_MASK) >> LPC18XX_SCU_PIN_EHD_POS;
 		switch (*arg) {
 		case 3: *arg += 5;
+			/* fall through */
 		case 2: *arg += 5;
+			/* fall through */
 		case 1: *arg += 3;
+			/* fall through */
 		case 0: *arg += 4;
 		}
 		break;
@@ -1060,8 +1063,11 @@ static int lpc18xx_pconf_set_pin(struct pinctrl_dev *pctldev, unsigned param,
 
 		switch (param_val) {
 		case 20: param_val -= 5;
+			 /* fall through */
 		case 14: param_val -= 5;
+			 /* fall through */
 		case  8: param_val -= 3;
+			 /* fall through */
 		case  4: param_val -= 4;
 			 break;
 		default:
-- 
2.7.4

