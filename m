Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CBBC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF2724029
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF2724029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeGEQN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:13:56 -0400
Received: from gateway36.websitewelcome.com ([192.185.201.2]:39961 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753400AbeGEQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:13:54 -0400
X-Greylist: delayed 1316 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2018 12:13:54 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id C374C4011CCA4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jul 2018 09:52:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id b6XZfPPHHRPojb6Xpfzmjc; Thu, 05 Jul 2018 10:51:57 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=47106 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fb6XY-0046X9-GQ; Thu, 05 Jul 2018 10:51:28 -0500
Date:   Thu, 5 Jul 2018 10:51:27 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] pinctrl: baytrail: Mark expected switch fall-throughs
Message-ID: <20180705155127.GA1458@embeddedor.com>
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
X-Exim-ID: 1fb6XY-0046X9-GQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:47106
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

Addresses-Coverity-ID: 1292308 ("Missing break in switch")
Addresses-Coverity-ID: 1292309 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 6b52ea1..3420e7e 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1542,11 +1542,13 @@ static void byt_irq_unmask(struct irq_data *d)
 	switch (irqd_get_trigger_type(d)) {
 	case IRQ_TYPE_LEVEL_HIGH:
 		value |= BYT_TRIG_LVL;
+		/* fall through */
 	case IRQ_TYPE_EDGE_RISING:
 		value |= BYT_TRIG_POS;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		value |= BYT_TRIG_LVL;
+		/* fall through */
 	case IRQ_TYPE_EDGE_FALLING:
 		value |= BYT_TRIG_NEG;
 		break;
-- 
2.7.4

