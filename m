Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539AFC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9AD2086B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9AD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeICXKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:10:42 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.85]:14147 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727493AbeICXKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:10:42 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 0FD24ECA65
        for <linux-kernel@vger.kernel.org>; Mon,  3 Sep 2018 13:49:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wtu8fgZf2bXuJwtuLf0zWe; Mon, 03 Sep 2018 13:49:13 -0500
X-Authority-Reason: nr=8
Received: from [189.250.106.191] (port=40570 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fwtu6-002QHE-8M; Mon, 03 Sep 2018 13:48:50 -0500
Date:   Mon, 3 Sep 2018 13:48:45 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: usbnet: mark expected switch fall-through
Message-ID: <20180903184845.GA8150@embeddedor.com>
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
X-Source-IP: 189.250.106.191
X-Source-L: No
X-Exim-ID: 1fwtu6-002QHE-8M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.191]:40570
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 27
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1077614 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/usb/usbnet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 770aa62..73aa333 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1527,6 +1527,7 @@ static void usbnet_bh (struct timer_list *t)
 			continue;
 		case tx_done:
 			kfree(entry->urb->sg);
+			/* fall through */
 		case rx_cleanup:
 			usb_free_urb (entry->urb);
 			dev_kfree_skb (skb);
-- 
2.7.4

