Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A9221852
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfAWHlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:41:23 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.164]:41409 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfAWHlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:41:23 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 23150C6994
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:41:22 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mDA2g3i3z2qH7mDA2gfptS; Wed, 23 Jan 2019 01:41:22 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=47018 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmDA1-003L0w-9L; Wed, 23 Jan 2019 01:41:21 -0600
Date:   Wed, 23 Jan 2019 01:41:19 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ariel Elior <ariel.elior@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] broadcom: Mark expected switch fall-throughs
Message-ID: <20190123074119.GA18304@embeddedor>
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
X-Exim-ID: 1gmDA1-003L0w-9L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:47018
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 43
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:6336:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:2231:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/ethernet/broadcom/tg3.c:722:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/ethernet/broadcom/tg3.c:783:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c  | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 2 +-
 drivers/net/ethernet/broadcom/tg3.c               | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index 29738dfa878c..d581d0ae6584 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -6335,7 +6335,7 @@ int bnx2x_set_led(struct link_params *params,
 		 */
 		if (!vars->link_up)
 			break;
-		/* else: fall through */
+		/* fall through */
 	case LED_MODE_ON:
 		if (((params->phy[EXT_PHY1].type ==
 			  PORT_HW_CFG_XGXS_EXT_PHY_TYPE_BCM8727) ||
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index c835f6c7ecd0..c97b642e6537 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -2230,7 +2230,7 @@ int bnx2x_vf_free(struct bnx2x *bp, struct bnx2x_virtf *vf)
 		rc = bnx2x_vf_close(bp, vf);
 		if (rc)
 			goto op_err;
-		/* Fallthrough to release resources */
+		/* Fall through - to release resources */
 	case VF_ACQUIRED:
 		DP(BNX2X_MSG_IOV, "about to free resources\n");
 		bnx2x_vf_free_resc(bp, vf);
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index b1627dd5f2fd..328373e0578f 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -721,7 +721,7 @@ static int tg3_ape_lock(struct tg3 *tp, int locknum)
 	case TG3_APE_LOCK_GPIO:
 		if (tg3_asic_rev(tp) == ASIC_REV_5761)
 			return 0;
-		/* else: fall through */
+		/* fall through */
 	case TG3_APE_LOCK_GRC:
 	case TG3_APE_LOCK_MEM:
 		if (!tp->pci_fn)
@@ -782,7 +782,7 @@ static void tg3_ape_unlock(struct tg3 *tp, int locknum)
 	case TG3_APE_LOCK_GPIO:
 		if (tg3_asic_rev(tp) == ASIC_REV_5761)
 			return;
-		/* else: fall through */
+		/* fall through */
 	case TG3_APE_LOCK_GRC:
 	case TG3_APE_LOCK_MEM:
 		if (!tp->pci_fn)
-- 
2.20.1

