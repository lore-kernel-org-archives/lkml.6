Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B86DC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4688D21736
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4688D21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHHBoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:44:25 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.129]:36693 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbeHHBoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:44:24 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 236C01809F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 18:27:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nBO5fjgXIBcCXnBO6fJiPh; Tue, 07 Aug 2018 18:27:38 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48128 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnBO5-001xdh-5f; Tue, 07 Aug 2018 18:27:37 -0500
Date:   Tue, 7 Aug 2018 18:27:36 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com
Subject: [PATCH 27/33] qede: qede_fp: Mark expected switch fall-through
Message-ID: <12936b5b7b6b9bc7a029ae761137018cc89bedc4.1533675546.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fnBO5-001xdh-5f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48128
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 173
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1384501 ("Missing break in switch")
Addresses-Coverity-ID: 1398869 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 6c70239..8c9e95b 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -1119,8 +1119,10 @@ static bool qede_rx_xdp(struct qede_dev *edev,
 
 	default:
 		bpf_warn_invalid_xdp_action(act);
+		/* Fall through */
 	case XDP_ABORTED:
 		trace_xdp_exception(edev->ndev, prog, act);
+		/* Fall through */
 	case XDP_DROP:
 		qede_recycle_rx_bd_ring(rxq, cqe->bd_num);
 	}
-- 
2.7.4

