Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFC8C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B50721736
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B50721736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeHHBc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:32:56 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.107]:13547 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbeHHBc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:32:56 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id A611618B0EF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 18:16:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nBCyf79NobXuJnBD1fWAyr; Tue, 07 Aug 2018 18:16:14 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48064 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnBCx-001s8Y-LJ; Tue, 07 Aug 2018 18:16:07 -0500
Date:   Tue, 7 Aug 2018 18:16:07 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH 11/33] net: tulip: de4x5: mark expected switch fall-throughs
Message-ID: <dcb7df430a291a7c1f938abdaa8a1d7a7728b256.1533675546.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fnBCx-001s8Y-LJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48064
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 91
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114784 ("Missing break in switch")
Addresses-Coverity-ID: 114785 ("Missing break in switch")
Addresses-Coverity-ID: 114786 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/dec/tulip/de4x5.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index a31b4df..66535d1 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -3204,6 +3204,8 @@ srom_map_media(struct net_device *dev)
       case SROM_10BASETF:
 	if (!lp->params.fdx) return -1;
 	lp->fdx = true;
+	/* fall through */
+
       case SROM_10BASET:
 	if (lp->params.fdx && !lp->fdx) return -1;
 	if ((lp->chipset == DC21140) || ((lp->chipset & ~0x00ff) == DC2114x)) {
@@ -3224,6 +3226,8 @@ srom_map_media(struct net_device *dev)
       case SROM_100BASETF:
         if (!lp->params.fdx) return -1;
 	lp->fdx = true;
+	/* fall through */
+
       case SROM_100BASET:
 	if (lp->params.fdx && !lp->fdx) return -1;
 	lp->media = _100Mb;
@@ -3236,6 +3240,8 @@ srom_map_media(struct net_device *dev)
       case SROM_100BASEFF:
 	if (!lp->params.fdx) return -1;
 	lp->fdx = true;
+	/* fall through */
+
       case SROM_100BASEF:
 	if (lp->params.fdx && !lp->fdx) return -1;
 	lp->media = _100Mb;
-- 
2.7.4

