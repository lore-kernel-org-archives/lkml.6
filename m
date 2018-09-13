Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222B9C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CA1204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CA1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeIMXuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:50:21 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.62]:37447 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbeIMXuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:50:21 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 59D9F479D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 13:39:37 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0WWSgRH3sbXuJ0WWZgk5aO; Thu, 13 Sep 2018 13:39:36 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.25] (port=50376 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g0WWS-001i4V-0O; Thu, 13 Sep 2018 13:39:24 -0500
Date:   Thu, 13 Sep 2018 13:39:22 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] tg3: Fix fall-through annotations
Message-ID: <20180913183922.GA31390@embeddedor.com>
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
X-Source-IP: 189.250.119.25
X-Source-L: No
X-Exim-ID: 1g0WWS-001i4V-0O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.25]:50376
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index e6f28c7..ee7ef32 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -1598,7 +1598,7 @@ static int tg3_mdio_init(struct tg3 *tp)
 			phydev->dev_flags |= PHY_BRCM_EXT_IBND_RX_ENABLE;
 		if (tg3_flag(tp, RGMII_EXT_IBND_TX_EN))
 			phydev->dev_flags |= PHY_BRCM_EXT_IBND_TX_ENABLE;
-		/* fallthru */
+		/* fall through */
 	case PHY_ID_RTL8211C:
 		phydev->interface = PHY_INTERFACE_MODE_RGMII;
 		break;
@@ -2127,7 +2127,7 @@ static int tg3_phy_init(struct tg3 *tp)
 					      SUPPORTED_Asym_Pause);
 			break;
 		}
-		/* fallthru */
+		/* fall through */
 	case PHY_INTERFACE_MODE_MII:
 		phydev->supported &= (PHY_BASIC_FEATURES |
 				      SUPPORTED_Pause |
@@ -5215,7 +5215,7 @@ static int tg3_fiber_aneg_smachine(struct tg3 *tp,
 		if (ap->flags & (MR_AN_ENABLE | MR_RESTART_AN))
 			ap->state = ANEG_STATE_AN_ENABLE;
 
-		/* fallthru */
+		/* fall through */
 	case ANEG_STATE_AN_ENABLE:
 		ap->flags &= ~(MR_AN_COMPLETE | MR_PAGE_RX);
 		if (ap->flags & MR_AN_ENABLE) {
@@ -5245,7 +5245,7 @@ static int tg3_fiber_aneg_smachine(struct tg3 *tp,
 		ret = ANEG_TIMER_ENAB;
 		ap->state = ANEG_STATE_RESTART;
 
-		/* fallthru */
+		/* fall through */
 	case ANEG_STATE_RESTART:
 		delta = ap->cur_time - ap->link_time;
 		if (delta > ANEG_STATE_SETTLE_TIME)
@@ -5288,7 +5288,7 @@ static int tg3_fiber_aneg_smachine(struct tg3 *tp,
 
 		ap->state = ANEG_STATE_ACK_DETECT;
 
-		/* fallthru */
+		/* fall through */
 	case ANEG_STATE_ACK_DETECT:
 		if (ap->ack_match != 0) {
 			if ((ap->rxconfig & ~ANEG_CFG_ACK) ==
@@ -14013,7 +14013,7 @@ static int tg3_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	case SIOCGMIIPHY:
 		data->phy_id = tp->phy_addr;
 
-		/* fallthru */
+		/* fall through */
 	case SIOCGMIIREG: {
 		u32 mii_regval;
 
-- 
2.7.4

