Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964853AbeEXW7c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:59:32 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.253]:38270 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935647AbeEXW7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:59:31 -0400
X-Authority-Reason: nr=8
Date: Thu, 24 May 2018 17:59:28 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Kalle Valo <kvalo@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ath10k: htt_tx: mark expected switch fall-throughs
Message-ID: <20180524225928.GA19570@embeddedor.com>
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
X-Source-IP: 187.162.252.93
X-Source-L: No
X-Exim-ID: 1fLzCk-003BjH-1u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-93.static.axtel.net (embeddedor) [187.162.252.93]:48972
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced "pass through" with
a proper "fall through" comment, which is what GCC is expecting
to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 5d8b97a..89157c5 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -1202,7 +1202,7 @@ static int ath10k_htt_tx_32(struct ath10k_htt *htt,
 	case ATH10K_HW_TXRX_RAW:
 	case ATH10K_HW_TXRX_NATIVE_WIFI:
 		flags0 |= HTT_DATA_TX_DESC_FLAGS0_MAC_HDR_PRESENT;
-		/* pass through */
+		/* fall through */
 	case ATH10K_HW_TXRX_ETHERNET:
 		if (ar->hw_params.continuous_frag_desc) {
 			ext_desc_t = htt->frag_desc.vaddr_desc_32;
@@ -1404,7 +1404,7 @@ static int ath10k_htt_tx_64(struct ath10k_htt *htt,
 	case ATH10K_HW_TXRX_RAW:
 	case ATH10K_HW_TXRX_NATIVE_WIFI:
 		flags0 |= HTT_DATA_TX_DESC_FLAGS0_MAC_HDR_PRESENT;
-		/* pass through */
+		/* fall through */
 	case ATH10K_HW_TXRX_ETHERNET:
 		if (ar->hw_params.continuous_frag_desc) {
 			ext_desc_t = htt->frag_desc.vaddr_desc_64;
-- 
2.7.4
