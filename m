Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F222C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B823821736
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B823821736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeHHBZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:25:59 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.66]:26167 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbeHHBZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:25:59 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 08494BEEB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 18:09:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nB6Ef6mIebXuJnB6JfVo2x; Tue, 07 Aug 2018 18:09:18 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48024 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnB6E-001ogG-2E; Tue, 07 Aug 2018 18:09:10 -0500
Date:   Tue, 7 Aug 2018 18:09:09 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 01/33] 8390: axnet_cs: Mark expected switch fall-through
Message-ID: <6995d932701f9df0c88b0f071af8a67edc31c8b8.1533675546.git.gustavo@embeddedor.com>
References: <cover.1533675546.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533675546.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.73.102
X-Source-L: No
X-Exim-ID: 1fnB6E-001ogG-2E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48024
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 46
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114889 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/8390/axnet_cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/8390/axnet_cs.c b/drivers/net/ethernet/8390/axnet_cs.c
index d422a12..0b6bbf6 100644
--- a/drivers/net/ethernet/8390/axnet_cs.c
+++ b/drivers/net/ethernet/8390/axnet_cs.c
@@ -610,6 +610,7 @@ static int axnet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
     switch (cmd) {
     case SIOCGMIIPHY:
 	data->phy_id = info->phy_id;
+	/* Fall through */
     case SIOCGMIIREG:		/* Read MII PHY register. */
 	data->val_out = mdio_read(mii_addr, data->phy_id, data->reg_num & 0x1f);
 	return 0;
-- 
2.7.4

