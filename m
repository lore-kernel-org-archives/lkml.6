Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF00720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAWHsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:48:55 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.36]:33922 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbfAWHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:48:52 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id C8584AAE1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:48:50 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mDHGgxC5HYTGMmDHGgflgD; Wed, 23 Jan 2019 01:48:50 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=47094 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmDHG-003Pm5-3f; Wed, 23 Jan 2019 01:48:50 -0600
Date:   Wed, 23 Jan 2019 01:48:49 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] intel: Mark expected switch fall-throughs
Message-ID: <20190123074849.GA24230@embeddedor>
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
X-Exim-ID: 1gmDHG-003Pm5-3f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:47094
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 48
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/net/ethernet/intel/igb/e1000_82575.c:636:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/ethernet/intel/igb/igb_main.c:6710:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/ethernet/intel/i40e/i40e_xsk.c:237:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 3 ++-
 drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c    | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 96d849460d9b..774e31405ba0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -235,9 +235,10 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
+		/* fall through */
 	case XDP_ABORTED:
 		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
-		/* fallthrough -- handle aborts by dropping packet */
+		/* fall through - handle aborts by dropping packet */
 	case XDP_DROP:
 		result = I40E_XDP_CONSUMED;
 		break;
diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index bafdcf70a353..3ec2ce0725d5 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -638,7 +638,7 @@ static s32 igb_get_invariants_82575(struct e1000_hw *hw)
 			dev_spec->sgmii_active = true;
 			break;
 		}
-		/* fall through for I2C based SGMII */
+		/* fall through - for I2C based SGMII */
 	case E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES:
 		/* read media type from SFP EEPROM */
 		ret_val = igb_set_sfp_media_type_82575(hw);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index dfa357b1a9d6..2c88e47574a7 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6713,7 +6713,7 @@ static int __igb_notify_dca(struct device *dev, void *data)
 			igb_setup_dca(adapter);
 			break;
 		}
-		/* Fall Through since DCA is disabled. */
+		/* Fall Through - since DCA is disabled. */
 	case DCA_PROVIDER_REMOVE:
 		if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
 			/* without this a class_device is left
-- 
2.20.1

