Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE3C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF837206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF837206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeI2SLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:11:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38141 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeI2SLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:11:33 -0400
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g6DeZ-0006y2-3i; Sat, 29 Sep 2018 11:43:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: fix spelling mistakeis "[En]queing" -> "[En]queuing"
Date:   Sat, 29 Sep 2018 12:43:13 +0100
Message-Id: <20180929114313.10557-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in debug warning messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 +-
 drivers/usb/gadget/udc/udc-xilinx.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 5939eb1e97f2..e9ee2b72af19 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -353,7 +353,7 @@ static int ast_vhub_epn_queue(struct usb_ep* u_ep, struct usb_request *u_req,
 	/* Endpoint enabled ? */
 	if (!ep->epn.enabled || !u_ep->desc || !ep->dev || !ep->d_idx ||
 	    !ep->dev->enabled || ep->dev->suspended) {
-		EPDBG(ep,"Enqueing request on wrong or disabled EP\n");
+		EPDBG(ep, "Enqueuing request on wrong or disabled EP\n");
 		return -ESHUTDOWN;
 	}
 
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 6407e433bc78..b1f4104d1283 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1078,7 +1078,7 @@ static int xudc_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	unsigned long flags;
 
 	if (!ep->desc) {
-		dev_dbg(udc->dev, "%s:queing request to disabled %s\n",
+		dev_dbg(udc->dev, "%s: queuing request to disabled %s\n",
 			__func__, ep->name);
 		return -ESHUTDOWN;
 	}
-- 
2.17.1

