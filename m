Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDEALW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:11:22 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.195]:48769 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752529AbeDEALV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:11:21 -0400
Date: Wed, 4 Apr 2018 19:09:44 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] brcm80211: brcmsmac: phy_lcn: remove duplicate code
Message-ID: <20180405000944.GA22743@embeddedor.com>
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
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f3sTK-000T1v-8t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:35280
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove and refactor some code in order to avoid having identical code
for different branches.

Notice that this piece of code hasn't been modified since 2011.

Addresses-Coverity-ID: 1226756 ("Identical code for different branches")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index 93d4cde..9d830d2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -3388,13 +3388,8 @@ void wlc_lcnphy_deaf_mode(struct brcms_phy *pi, bool mode)
 	u8 phybw40;
 	phybw40 = CHSPEC_IS40(pi->radio_chanspec);
 
-	if (LCNREV_LT(pi->pubpi.phy_rev, 2)) {
-		mod_phy_reg(pi, 0x4b0, (0x1 << 5), (mode) << 5);
-		mod_phy_reg(pi, 0x4b1, (0x1 << 9), 0 << 9);
-	} else {
-		mod_phy_reg(pi, 0x4b0, (0x1 << 5), (mode) << 5);
-		mod_phy_reg(pi, 0x4b1, (0x1 << 9), 0 << 9);
-	}
+	mod_phy_reg(pi, 0x4b0, (0x1 << 5), (mode) << 5);
+	mod_phy_reg(pi, 0x4b1, (0x1 << 9), 0 << 9);
 
 	if (phybw40 == 0) {
 		mod_phy_reg((pi), 0x410,
-- 
2.7.4
