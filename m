Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB1E23EA6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB1E23EA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeGDVF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:05:57 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.129]:37616 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752667AbeGDVF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:05:56 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 2A4F518758
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jul 2018 16:05:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aoyJf3IrHRPojaoyJfdpIU; Wed, 04 Jul 2018 16:05:55 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=56770 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1faoyI-0045Qq-II; Wed, 04 Jul 2018 16:05:54 -0500
Date:   Wed, 4 Jul 2018 16:05:53 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] wireless: mark expected switch fall-throughs
Message-ID: <20180704210553.GA7869@embeddedor.com>
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
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1faoyI-0045Qq-II
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:56770
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/wireless/chan.c        | 2 ++
 net/wireless/nl80211.c     | 9 +++++++++
 net/wireless/wext-compat.c | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 2db713d..145cb51 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -747,6 +747,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 	case NL80211_CHAN_WIDTH_20:
 		if (!ht_cap->ht_supported)
 			return false;
+		/* else: fall through */
 	case NL80211_CHAN_WIDTH_20_NOHT:
 		prohibited_flags |= IEEE80211_CHAN_NO_20MHZ;
 		width = 20;
@@ -769,6 +770,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		cap = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 		if (cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
 			return false;
+		/* else: fall through */
 	case NL80211_CHAN_WIDTH_80:
 		if (!vht_cap->vht_supported)
 			return false;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e4e5f02..59b0ac5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1676,6 +1676,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		state->split_start++;
 		if (state->split)
 			break;
+		/* else: fall through */
 	case 1:
 		if (nla_put(msg, NL80211_ATTR_CIPHER_SUITES,
 			    sizeof(u32) * rdev->wiphy.n_cipher_suites,
@@ -1722,6 +1723,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		state->split_start++;
 		if (state->split)
 			break;
+		/* else: fall through */
 	case 2:
 		if (nl80211_put_iftypes(msg, NL80211_ATTR_SUPPORTED_IFTYPES,
 					rdev->wiphy.interface_modes))
@@ -1729,6 +1731,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		state->split_start++;
 		if (state->split)
 			break;
+		/* else: fall through */
 	case 3:
 		nl_bands = nla_nest_start(msg, NL80211_ATTR_WIPHY_BANDS);
 		if (!nl_bands)
@@ -1754,6 +1757,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 				state->chan_start++;
 				if (state->split)
 					break;
+				/* else: fall through */
 			default:
 				/* add frequencies */
 				nl_freqs = nla_nest_start(
@@ -1807,6 +1811,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			state->split_start++;
 		if (state->split)
 			break;
+		/* else: fall through */
 	case 4:
 		nl_cmds = nla_nest_start(msg, NL80211_ATTR_SUPPORTED_COMMANDS);
 		if (!nl_cmds)
@@ -1833,6 +1838,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		state->split_start++;
 		if (state->split)
 			break;
+		/* else: fall through */
 	case 5:
 		if (rdev->ops->remain_on_channel &&
 		    (rdev->wiphy.flags & WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL) &&
@@ -1850,6 +1856,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		state->split_start++;
 		if (state->split)
 			break;
+		/* else: fall through */
 	case 6:
 #ifdef CONFIG_PM
 		if (nl80211_send_wowlan(msg, rdev, state->split))
@@ -1872,6 +1879,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		state->split_start++;
 		if (state->split)
 			break;
+		/* else: fall through */
 	case 8:
 		if ((rdev->wiphy.flags & WIPHY_FLAG_HAVE_AP_SME) &&
 		    nla_put_u32(msg, NL80211_ATTR_DEVICE_AP_SME,
@@ -4466,6 +4474,7 @@ static int parse_station_flags(struct genl_info *info,
 		params->sta_flags_mask = BIT(NL80211_STA_FLAG_AUTHENTICATED) |
 					 BIT(NL80211_STA_FLAG_MFP) |
 					 BIT(NL80211_STA_FLAG_AUTHORIZED);
+		/* fall through */
 	default:
 		return -EINVAL;
 	}
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 167f702..9db3920 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -1333,6 +1333,7 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 			wstats.qual.qual = sig + 110;
 			break;
 		}
+		/* else: fall through */
 	case CFG80211_SIGNAL_TYPE_UNSPEC:
 		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
 			wstats.qual.updated |= IW_QUAL_LEVEL_UPDATED;
@@ -1341,6 +1342,7 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 			wstats.qual.qual = sinfo.signal;
 			break;
 		}
+		/* else: fall through */
 	default:
 		wstats.qual.updated |= IW_QUAL_LEVEL_INVALID;
 		wstats.qual.updated |= IW_QUAL_QUAL_INVALID;
-- 
2.7.4

