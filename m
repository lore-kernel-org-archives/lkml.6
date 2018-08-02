Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ADCC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91656208A6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91656208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeHBCTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:19:30 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.252]:11043 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbeHBCT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:19:29 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id BBF8C43E8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 19:31:04 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id l1WCf2Vr0bXuJl1WCfSWrE; Wed, 01 Aug 2018 19:31:04 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=43246 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fl1WC-001q51-5I; Wed, 01 Aug 2018 19:31:04 -0500
Date:   Wed, 1 Aug 2018 19:31:01 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Wei Liu <wei.liu2@citrix.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] xen-netback: use true and false for boolean values
Message-ID: <20180802003101.GA19256@embeddedor.com>
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
X-Source-IP: 189.250.61.218
X-Source-L: No
X-Exim-ID: 1fl1WC-001q51-5I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:43246
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/xen-netback/netback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index a27daa2..3621e05 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1603,9 +1603,9 @@ static void xenvif_ctrl_action(struct xenvif *vif)
 static bool xenvif_ctrl_work_todo(struct xenvif *vif)
 {
 	if (likely(RING_HAS_UNCONSUMED_REQUESTS(&vif->ctrl)))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 irqreturn_t xenvif_ctrl_irq_fn(int irq, void *data)
-- 
2.7.4

