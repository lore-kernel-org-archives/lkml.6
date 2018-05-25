Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030260AbeEYVjE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:39:04 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.1]:28773 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030483AbeEYVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:39:02 -0400
X-Authority-Reason: nr=8
Date: Fri, 25 May 2018 16:38:54 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>, Xinming Hu <huxm@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mwifiex: mark expected switch fall-throughs
Message-ID: <20180525213854.GA13392@embeddedor.com>
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
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fMKQO-001YpC-M4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.46.223]:40544
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++++
 drivers/net/wireless/marvell/mwifiex/scan.c     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 54a2297..16a705d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1158,6 +1158,7 @@ mwifiex_cfg80211_change_virtual_intf(struct wiphy *wiphy,
 		case NL80211_IFTYPE_UNSPECIFIED:
 			mwifiex_dbg(priv->adapter, INFO,
 				    "%s: kept type as IBSS\n", dev->name);
+			/* fall through */
 		case NL80211_IFTYPE_ADHOC:	/* This shouldn't happen */
 			return 0;
 		default:
@@ -1188,6 +1189,7 @@ mwifiex_cfg80211_change_virtual_intf(struct wiphy *wiphy,
 		case NL80211_IFTYPE_UNSPECIFIED:
 			mwifiex_dbg(priv->adapter, INFO,
 				    "%s: kept type as STA\n", dev->name);
+			/* fall through */
 		case NL80211_IFTYPE_STATION:	/* This shouldn't happen */
 			return 0;
 		default:
@@ -1210,6 +1212,7 @@ mwifiex_cfg80211_change_virtual_intf(struct wiphy *wiphy,
 		case NL80211_IFTYPE_UNSPECIFIED:
 			mwifiex_dbg(priv->adapter, INFO,
 				    "%s: kept type as AP\n", dev->name);
+			/* fall through */
 		case NL80211_IFTYPE_AP:		/* This shouldn't happen */
 			return 0;
 		default:
@@ -1249,6 +1252,7 @@ mwifiex_cfg80211_change_virtual_intf(struct wiphy *wiphy,
 		case NL80211_IFTYPE_UNSPECIFIED:
 			mwifiex_dbg(priv->adapter, INFO,
 				    "%s: kept type as P2P\n", dev->name);
+			/* fall through */
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_P2P_GO:
 			return 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index d7ce7f7..19df92b 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1308,6 +1308,7 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 
 		case WLAN_EID_CHANNEL_SWITCH:
 			bss_entry->chan_sw_ie_present = true;
+			/* fall through */
 		case WLAN_EID_PWR_CAPABILITY:
 		case WLAN_EID_TPC_REPORT:
 		case WLAN_EID_QUIET:
-- 
2.7.4
