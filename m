Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836A7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4679D215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4679D215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeHHBl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:41:27 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.233]:11025 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbeHHBl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:41:26 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id B66391AE25
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 18:24:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nBLDfjXtsBcCXnBLFfJZpn; Tue, 07 Aug 2018 18:24:42 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48116 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnBLC-001wL8-QL; Tue, 07 Aug 2018 18:24:38 -0500
Date:   Tue, 7 Aug 2018 18:24:38 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 23/33] vxge: Mark expected switch fall-throughs
Message-ID: <35840312011d92c056108066810769751722ef9c.1533675546.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fnBLC-001wL8-QL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48116
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 152
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114796 ("Missing break in switch")
Addresses-Coverity-ID: 114804 ("Missing break in switch")
Addresses-Coverity-ID: 114806 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index a2c0a93..ae81498 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -3783,17 +3783,20 @@ vxge_hw_rts_rth_data0_data1_get(u32 j, u64 *data0, u64 *data1,
 			VXGE_HW_RTS_ACCESS_STEER_DATA0_RTH_ITEM0_ENTRY_EN |
 			VXGE_HW_RTS_ACCESS_STEER_DATA0_RTH_ITEM0_BUCKET_DATA(
 			itable[j]);
+		/* fall through */
 	case 2:
 		*data0 |=
 			VXGE_HW_RTS_ACCESS_STEER_DATA0_RTH_ITEM1_BUCKET_NUM(j)|
 			VXGE_HW_RTS_ACCESS_STEER_DATA0_RTH_ITEM1_ENTRY_EN |
 			VXGE_HW_RTS_ACCESS_STEER_DATA0_RTH_ITEM1_BUCKET_DATA(
 			itable[j]);
+		/* fall through */
 	case 3:
 		*data1 = VXGE_HW_RTS_ACCESS_STEER_DATA1_RTH_ITEM0_BUCKET_NUM(j)|
 			VXGE_HW_RTS_ACCESS_STEER_DATA1_RTH_ITEM0_ENTRY_EN |
 			VXGE_HW_RTS_ACCESS_STEER_DATA1_RTH_ITEM0_BUCKET_DATA(
 			itable[j]);
+		/* fall through */
 	case 4:
 		*data1 |=
 			VXGE_HW_RTS_ACCESS_STEER_DATA1_RTH_ITEM1_BUCKET_NUM(j)|
-- 
2.7.4

