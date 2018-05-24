Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966521AbeEXXN1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:13:27 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:39025 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965389AbeEXXNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:13:23 -0400
X-Authority-Reason: nr=8
Date: Thu, 24 May 2018 18:13:22 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Kalle Valo <kvalo@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ath6kl: mark expected switch fall-throughs
Message-ID: <20180524231322.GA22704@embeddedor.com>
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
X-Exim-ID: 1fLzQA-003L5d-GY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-93.static.axtel.net (embeddedor) [187.162.252.93]:49066
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 2ba8cf3..29e32cd 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -3898,17 +3898,17 @@ int ath6kl_cfg80211_init(struct ath6kl *ar)
 	wiphy->max_scan_ie_len = 1000; /* FIX: what is correct limit? */
 	switch (ar->hw.cap) {
 	case WMI_11AN_CAP:
-		ht = true;
+		ht = true; /* fall through */
 	case WMI_11A_CAP:
 		band_5gig = true;
 		break;
 	case WMI_11GN_CAP:
-		ht = true;
+		ht = true; /* fall through */
 	case WMI_11G_CAP:
 		band_2gig = true;
 		break;
 	case WMI_11AGN_CAP:
-		ht = true;
+		ht = true; /* fall through */
 	case WMI_11AG_CAP:
 		band_2gig = true;
 		band_5gig = true;
-- 
2.7.4
