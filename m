Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FACEC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF45215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF45215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeHHBjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:39:12 -0400
Received: from gateway30.websitewelcome.com ([192.185.149.4]:38805 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbeHHBjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:39:12 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A0E8A2CDBE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 18:22:28 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nBJ1fjRZsBcCXnBJ4fJTWx; Tue, 07 Aug 2018 18:22:28 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48100 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnBJ1-001vIn-Bl; Tue, 07 Aug 2018 18:22:23 -0500
Date:   Tue, 7 Aug 2018 18:22:22 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org
Subject: [PATCH 19/33] igb_main: Mark expected switch fall-throughs
Message-ID: <1f23933f64740396a518c7bf86a085c295d19759.1533675546.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fnBJ1-001vIn-Bl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48100
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 132
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 200521 ("Missing break in switch")
Addresses-Coverity-ID: 114797 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 636d805..d03c2f0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5175,6 +5175,7 @@ bool igb_has_link(struct igb_adapter *adapter)
 	case e1000_media_type_copper:
 		if (!hw->mac.get_link_status)
 			return true;
+		/* fall through */
 	case e1000_media_type_internal_serdes:
 		hw->mac.ops.check_for_link(hw);
 		link_active = !hw->mac.get_link_status;
@@ -5835,6 +5836,7 @@ static void igb_tx_csum(struct igb_ring *tx_ring, struct igb_tx_buffer *first)
 			type_tucmd = E1000_ADVTXD_TUCMD_L4T_SCTP;
 			break;
 		}
+		/* fall through */
 	default:
 		skb_checksum_help(skb);
 		goto csum_failed;
-- 
2.7.4

