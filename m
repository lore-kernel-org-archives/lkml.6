Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3498AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F193727850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F193727850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeF1TMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:12:16 -0400
Received: from gateway30.websitewelcome.com ([192.185.193.11]:42567 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752108AbeF1TMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:12:15 -0400
X-Greylist: delayed 1273 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 15:12:15 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id E1C3E35870
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 13:51:01 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Yc0IfekwAaSeyYc0PfKFcH; Thu, 28 Jun 2018 13:51:01 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=60646 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fYc0H-004BIb-EO; Thu, 28 Jun 2018 13:50:49 -0500
Date:   Thu, 28 Jun 2018 13:50:48 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: usb: Mark expected switch fall-throughs
Message-ID: <20180628185048.GA26623@embeddedor.com>
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
X-Exim-ID: 1fYc0H-004BIb-EO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:60646
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
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
 drivers/net/usb/catc.c       | 1 +
 drivers/net/usb/cdc-phonet.c | 1 +
 drivers/net/usb/r8152.c      | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index 18d36df..424053b 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -869,6 +869,7 @@ static int catc_probe(struct usb_interface *intf, const struct usb_device_id *id
 		default:
 			dev_warn(&intf->dev,
 				 "Couldn't detect memory size, assuming 32k\n");
+			/* fall through */
 		case 0x87654321:
 			catc_set_reg(catc, TxBufCount, 4);
 			catc_set_reg(catc, RxBufCount, 16);
diff --git a/drivers/net/usb/cdc-phonet.c b/drivers/net/usb/cdc-phonet.c
index 3c40312..78b16eb 100644
--- a/drivers/net/usb/cdc-phonet.c
+++ b/drivers/net/usb/cdc-phonet.c
@@ -110,6 +110,7 @@ static void tx_complete(struct urb *req)
 	case -ECONNRESET:
 	case -ESHUTDOWN:
 		dev->stats.tx_aborted_errors++;
+		/* fall through */
 	default:
 		dev->stats.tx_errors++;
 		dev_dbg(&dev->dev, "TX error (%d)\n", status);
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 1fd1650..124211a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1376,6 +1376,7 @@ static void intr_callback(struct urb *urb)
 	case -ECONNRESET:	/* unlink */
 	case -ESHUTDOWN:
 		netif_device_detach(tp->netdev);
+		/* fall through */
 	case -ENOENT:
 	case -EPROTO:
 		netif_info(tp, intr, tp->netdev,
@@ -2741,6 +2742,7 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			r8152_mdio_write(tp, MII_BMCR, data);
 
 			data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+			/* fall through */
 
 		default:
 			if (data != PHY_STAT_LAN_ON)
-- 
2.7.4

