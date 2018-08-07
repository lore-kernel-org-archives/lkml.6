Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E45C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813DE215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813DE215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHHBpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:45:08 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.129]:23496 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbeHHBpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:45:08 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 2E4CCA4FB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 18:28:23 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nBOnfjj4iBcCXnBOofJkx0; Tue, 07 Aug 2018 18:28:22 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48130 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnBOn-001y4y-6W; Tue, 07 Aug 2018 18:28:21 -0500
Date:   Tue, 7 Aug 2018 18:28:20 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com
Subject: [PATCH 28/33] qlcnic: Mark expected switch fall-througs
Message-ID: <43bf00764c0d67757207669b2482557695c1cc9b.1533675546.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fnBOn-001y4y-6W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48130
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 178
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1410181 ("Missing break in switch")
Addresses-Coverity-ID: 1410184 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
index 7f7deea..3b0adda 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
@@ -351,9 +351,9 @@ static int qlcnic_82xx_get_link_ksettings(struct qlcnic_adapter *adapter,
 	case QLCNIC_BRDTYPE_P3P_REF_QG:
 	case QLCNIC_BRDTYPE_P3P_4_GB:
 	case QLCNIC_BRDTYPE_P3P_4_GB_MM:
-
 		supported |= SUPPORTED_Autoneg;
 		advertising |= ADVERTISED_Autoneg;
+		/* fall through */
 	case QLCNIC_BRDTYPE_P3P_10G_CX4:
 	case QLCNIC_BRDTYPE_P3P_10G_CX4_LP:
 	case QLCNIC_BRDTYPE_P3P_10000_BASE_T:
@@ -377,6 +377,7 @@ static int qlcnic_82xx_get_link_ksettings(struct qlcnic_adapter *adapter,
 		supported |= SUPPORTED_TP;
 		check_sfp_module = netif_running(adapter->netdev) &&
 				   ahw->has_link_events;
+		/* fall through */
 	case QLCNIC_BRDTYPE_P3P_10G_XFP:
 		supported |= SUPPORTED_FIBRE;
 		advertising |= ADVERTISED_FIBRE;
-- 
2.7.4

