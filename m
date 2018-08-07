Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6631C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8914F215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8914F215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeHHBrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:47:13 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.107]:45739 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbeHHBrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:47:13 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id CAC1520244
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 18:30:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nBQlf7nJkbXuJnBQmfWooI; Tue, 07 Aug 2018 18:30:24 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48148 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnBQl-001zCt-7f; Tue, 07 Aug 2018 18:30:23 -0500
Date:   Tue, 7 Aug 2018 18:30:22 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Byungho An <bh74.an@samsung.com>, Girish K S <ks.giri@samsung.com>,
        Vipul Pandya <vipul.pandya@samsung.com>
Subject: [PATCH 30/33] net: ethernet: sxgbe: mark expected switch
 fall-throughs
Message-ID: <2443e17bb9d17024a5f886a05fe91d25a210f7c8.1533675546.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fnBQl-001zCt-7f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48148
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 190
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1357414 ("Missing break in switch")
Addresses-Coverity-ID: 1357415 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
index 542b67d..c9aad0e 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
@@ -319,6 +319,7 @@ static int sxgbe_get_rss_hash_opts(struct sxgbe_priv_data *priv,
 	case TCP_V4_FLOW:
 	case UDP_V4_FLOW:
 		cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		/* Fall through */
 	case SCTP_V4_FLOW:
 	case AH_ESP_V4_FLOW:
 	case AH_V4_FLOW:
@@ -329,6 +330,7 @@ static int sxgbe_get_rss_hash_opts(struct sxgbe_priv_data *priv,
 	case TCP_V6_FLOW:
 	case UDP_V6_FLOW:
 		cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		/* Fall through */
 	case SCTP_V6_FLOW:
 	case AH_ESP_V6_FLOW:
 	case AH_V6_FLOW:
-- 
2.7.4

