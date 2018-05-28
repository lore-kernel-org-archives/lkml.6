Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937903AbeE1K5w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932527AbeE1K5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:57:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anilkumar Kolli <akolli@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 364/496] ath10k: advertize beacon_int_min_gcd
Date: Mon, 28 May 2018 12:02:29 +0200
Message-Id: <20180528100335.133360897@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anilkumar Kolli <akolli@codeaurora.org>

[ Upstream commit 8ebee73b574ad3dd1f14d461f65ceaffbd637650 ]

This patch fixes regression caused by 0c317a02ca98
("cfg80211: support virtual interfaces with different beacon intervals"),
with this change cfg80211 expects the driver to advertize
'beacon_int_min_gcd' to support different beacon intervals in multivap
scenario. This support is added for, QCA988X/QCA99X0/QCA9984/QCA4019.

Verifed AP + mesh bring up on QCA9984 with beacon interval 100msec and
1000msec respectively.
Frimware: firmware-5.bin_10.4-3.5.3-00053

Fixes: 0c317a02ca98 ("cfg80211: support virtual interfaces with different beacon intervals")
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7810,6 +7810,7 @@ static const struct ieee80211_iface_comb
 		.max_interfaces = 8,
 		.num_different_channels = 1,
 		.beacon_int_infra_match = true,
+		.beacon_int_min_gcd = 1,
 #ifdef CONFIG_ATH10K_DFS_CERTIFIED
 		.radar_detect_widths =	BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 					BIT(NL80211_CHAN_WIDTH_20) |
@@ -7933,6 +7934,7 @@ static const struct ieee80211_iface_comb
 		.max_interfaces = 16,
 		.num_different_channels = 1,
 		.beacon_int_infra_match = true,
+		.beacon_int_min_gcd = 1,
 #ifdef CONFIG_ATH10K_DFS_CERTIFIED
 		.radar_detect_widths =	BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 					BIT(NL80211_CHAN_WIDTH_20) |
