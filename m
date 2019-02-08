Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68CDC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B7C20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfBHT22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:28:28 -0500
Received: from gateway30.websitewelcome.com ([50.116.127.1]:37289 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727144AbfBHT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:28:27 -0500
X-Greylist: delayed 1257 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 14:28:27 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 5DD32780A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 13:07:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sBUogazsDdnCesBUogauM1; Fri, 08 Feb 2019 13:07:30 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=59358 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gsBUn-000Wvz-Lg; Fri, 08 Feb 2019 13:07:29 -0600
Date:   Fri, 8 Feb 2019 13:07:29 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Petko Manolov <petkan@nucleusys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: usb: pegasus: Mark expected switch fall-through
Message-ID: <20190208190729.GA3970@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gsBUn-000Wvz-Lg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:59358
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/usb/pegasus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index f4247b275e09..63e44e746ccc 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -1011,6 +1011,7 @@ static int pegasus_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
 	switch (cmd) {
 	case SIOCDEVPRIVATE:
 		data[0] = pegasus->phy;
+		/* fall through */
 	case SIOCDEVPRIVATE + 1:
 		read_mii_word(pegasus, data[0], data[1] & 0x1f, &data[3]);
 		res = 0;
-- 
2.20.1

