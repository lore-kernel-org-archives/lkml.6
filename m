Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA03C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D2520870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfAWHwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:52:30 -0500
Received: from gateway36.websitewelcome.com ([192.185.200.11]:11265 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbfAWHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:52:30 -0500
X-Greylist: delayed 1353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 02:52:29 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 1F23C40375770
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:42:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mCyygKkf3dnCemCyygNvjy; Wed, 23 Jan 2019 01:29:56 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46920 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmCyx-003ERC-LZ; Wed, 23 Jan 2019 01:29:55 -0600
Date:   Wed, 23 Jan 2019 01:29:55 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: 3c509: mark expected switch fall-throughs
Message-ID: <20190123072955.GA10978@embeddedor>
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
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmCyx-003ERC-LZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:46920
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 34
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/net/ethernet/3com/3c509.c:1265:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/ethernet/3com/3c509.c:1271:8: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/3com/3c509.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/3com/3c509.c b/drivers/net/ethernet/3com/3c509.c
index b223769d6a5e..3da97996bdf3 100644
--- a/drivers/net/ethernet/3com/3c509.c
+++ b/drivers/net/ethernet/3com/3c509.c
@@ -1266,12 +1266,14 @@ el3_up(struct net_device *dev)
 					pr_cont("Forcing 3c5x9b full-duplex mode");
 					break;
 				}
+				/* fall through */
 			case 8:
 				/* set full-duplex mode based on eeprom config setting */
 				if ((sw_info & 0x000f) && (sw_info & 0x8000)) {
 					pr_cont("Setting 3c5x9b full-duplex mode (from EEPROM configuration bit)");
 					break;
 				}
+				/* fall through */
 			default:
 				/* xcvr=(0 || 4) OR user has an old 3c5x9 non "B" model */
 				pr_cont("Setting 3c5x9/3c5x9B half-duplex mode");
-- 
2.20.1

