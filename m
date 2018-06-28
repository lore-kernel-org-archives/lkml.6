Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2D0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DCD240FF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DCD240FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeF1Bct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:32:49 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.2]:25823 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750936AbeF1Bcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:32:47 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id AE09A400C6EE4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 20:32:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YLnOfcuiKaSeyYLnZfIWTc; Wed, 27 Jun 2018 20:32:45 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=51900 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fYLnM-002LCl-PZ; Wed, 27 Jun 2018 20:32:24 -0500
Date:   Wed, 27 Jun 2018 20:32:23 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ariel Elior <ariel.elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] bnx2x: Mark expected switch fall-throughs
Message-ID: <20180628013223.GA22163@embeddedor.com>
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
X-Exim-ID: 1fYLnM-002LCl-PZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:51900
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
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
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c  | 3 +++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c    | 4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index 22243c4..98d4c5a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -6339,6 +6339,7 @@ int bnx2x_set_led(struct link_params *params,
 		 */
 		if (!vars->link_up)
 			break;
+		/* else: fall through */
 	case LED_MODE_ON:
 		if (((params->phy[EXT_PHY1].type ==
 			  PORT_HW_CFG_XGXS_EXT_PHY_TYPE_BCM8727) ||
@@ -12521,11 +12522,13 @@ static void bnx2x_phy_def_cfg(struct link_params *params,
 	switch (link_config  & PORT_FEATURE_LINK_SPEED_MASK) {
 	case PORT_FEATURE_LINK_SPEED_10M_HALF:
 		phy->req_duplex = DUPLEX_HALF;
+		/* fall through */
 	case PORT_FEATURE_LINK_SPEED_10M_FULL:
 		phy->req_line_speed = SPEED_10;
 		break;
 	case PORT_FEATURE_LINK_SPEED_100M_HALF:
 		phy->req_duplex = DUPLEX_HALF;
+		/* fall through */
 	case PORT_FEATURE_LINK_SPEED_100M_FULL:
 		phy->req_line_speed = SPEED_100;
 		break;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 5b1ed24..44a6f28 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -8561,11 +8561,11 @@ int bnx2x_set_int_mode(struct bnx2x *bp)
 			       bp->num_queues,
 			       1 + bp->num_cnic_queues);
 
-		/* falling through... */
+		/* fall through */
 	case BNX2X_INT_MODE_MSI:
 		bnx2x_enable_msi(bp);
 
-		/* falling through... */
+		/* fall through */
 	case BNX2X_INT_MODE_INTX:
 		bp->num_ethernet_queues = 1;
 		bp->num_queues = bp->num_ethernet_queues + bp->num_cnic_queues;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
index 8baf9d3..3f4d2c8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
@@ -3258,7 +3258,7 @@ static int bnx2x_mcast_validate_e2(struct bnx2x *bp,
 	/* DEL command deletes all currently configured MACs */
 	case BNX2X_MCAST_CMD_DEL:
 		o->set_registry_size(o, 0);
-		/* Don't break */
+		/* fall through */
 
 	/* RESTORE command will restore the entire multicast configuration */
 	case BNX2X_MCAST_CMD_RESTORE:
@@ -3592,7 +3592,7 @@ static int bnx2x_mcast_validate_e1(struct bnx2x *bp,
 	/* DEL command deletes all currently configured MACs */
 	case BNX2X_MCAST_CMD_DEL:
 		o->set_registry_size(o, 0);
-		/* Don't break */
+		/* fall through */
 
 	/* RESTORE command will restore the entire multicast configuration */
 	case BNX2X_MCAST_CMD_RESTORE:
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index dc77bfd..62da465 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -1827,6 +1827,7 @@ int bnx2x_iov_eq_sp_event(struct bnx2x *bp, union event_ring_elem *elem)
 		DP(BNX2X_MSG_IOV, "got VF [%d:%d] RSS update ramrod\n",
 		   vf->abs_vfid, qidx);
 		bnx2x_vf_handle_rss_update_eqe(bp, vf);
+		/* fall through */
 	case EVENT_RING_OPCODE_VF_FLR:
 		/* Do nothing for now */
 		return 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b5fc641..d2dadad 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1727,7 +1727,7 @@ static int bnxt_async_event_process(struct bnxt *bp,
 					    speed);
 		}
 		set_bit(BNXT_LINK_SPEED_CHNG_SP_EVENT, &bp->sp_event);
-		/* fall thru */
+		/* fall through */
 	}
 	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE:
 		set_bit(BNXT_LINK_CHNG_SP_EVENT, &bp->sp_event);
-- 
2.7.4

