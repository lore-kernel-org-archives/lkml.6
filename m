Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47867C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2712098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4ZZY9F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2712098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeJKXG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2964A20652;
        Thu, 11 Oct 2018 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272353;
        bh=buov8hINVsRcmQC7JWTzzoEhIDWt0pu6tG3BQFgeKlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4ZZY9F8TeLqAbDEUdYVACe1izJmwgo7N1/V77MfkxK6Cz8aZyrahkyjCMvPgSJ9D
         UkQz0ga5qorrZaw3WbZrOzKBm5R1kfymgBSTqVA2eTQ4hPJTQ9O790tvjLu7hvNj2F
         NC5nztpKoehwjmTHFcBlkjISsA4ql+AiQHBvphjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 080/120] mac80211: shorten the IBSS debug messages
Date:   Thu, 11 Oct 2018 17:34:21 +0200
Message-Id: <20181011152553.107013064@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit c6e57b3896fc76299913b8cfd82d853bee8a2c84 ]

When tracing is enabled, all the debug messages are recorded and must
not exceed MAX_MSG_LEN (100) columns. Longer debug messages grant the
user with:

WARNING: CPU: 3 PID: 32642 at /tmp/wifi-core-20180806094828/src/iwlwifi-stack-dev/net/mac80211/./trace_msg.h:32 trace_event_raw_event_mac80211_msg_event+0xab/0xc0 [mac80211]
Workqueue: phy1 ieee80211_iface_work [mac80211]
 RIP: 0010:trace_event_raw_event_mac80211_msg_event+0xab/0xc0 [mac80211]
 Call Trace:
  __sdata_dbg+0xbd/0x120 [mac80211]
  ieee80211_ibss_rx_queued_mgmt+0x15f/0x510 [mac80211]
  ieee80211_iface_work+0x21d/0x320 [mac80211]

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/ibss.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -944,8 +944,8 @@ static void ieee80211_rx_mgmt_deauth_ibs
 	if (len < IEEE80211_DEAUTH_FRAME_LEN)
 		return;
 
-	ibss_dbg(sdata, "RX DeAuth SA=%pM DA=%pM BSSID=%pM (reason: %d)\n",
-		 mgmt->sa, mgmt->da, mgmt->bssid, reason);
+	ibss_dbg(sdata, "RX DeAuth SA=%pM DA=%pM\n", mgmt->sa, mgmt->da);
+	ibss_dbg(sdata, "\tBSSID=%pM (reason: %d)\n", mgmt->bssid, reason);
 	sta_info_destroy_addr(sdata, mgmt->sa);
 }
 
@@ -963,9 +963,9 @@ static void ieee80211_rx_mgmt_auth_ibss(
 	auth_alg = le16_to_cpu(mgmt->u.auth.auth_alg);
 	auth_transaction = le16_to_cpu(mgmt->u.auth.auth_transaction);
 
-	ibss_dbg(sdata,
-		 "RX Auth SA=%pM DA=%pM BSSID=%pM (auth_transaction=%d)\n",
-		 mgmt->sa, mgmt->da, mgmt->bssid, auth_transaction);
+	ibss_dbg(sdata, "RX Auth SA=%pM DA=%pM\n", mgmt->sa, mgmt->da);
+	ibss_dbg(sdata, "\tBSSID=%pM (auth_transaction=%d)\n",
+		 mgmt->bssid, auth_transaction);
 
 	if (auth_alg != WLAN_AUTH_OPEN || auth_transaction != 1)
 		return;
@@ -1130,10 +1130,10 @@ static void ieee80211_rx_bss_info(struct
 		rx_timestamp = drv_get_tsf(local, sdata);
 	}
 
-	ibss_dbg(sdata,
-		 "RX beacon SA=%pM BSSID=%pM TSF=0x%llx BCN=0x%llx diff=%lld @%lu\n",
+	ibss_dbg(sdata, "RX beacon SA=%pM BSSID=%pM TSF=0x%llx\n",
 		 mgmt->sa, mgmt->bssid,
-		 (unsigned long long)rx_timestamp,
+		 (unsigned long long)rx_timestamp);
+	ibss_dbg(sdata, "\tBCN=0x%llx diff=%lld @%lu\n",
 		 (unsigned long long)beacon_timestamp,
 		 (unsigned long long)(rx_timestamp - beacon_timestamp),
 		 jiffies);
@@ -1414,9 +1414,9 @@ static void ieee80211_rx_mgmt_probe_req(
 
 	tx_last_beacon = drv_tx_last_beacon(local);
 
-	ibss_dbg(sdata,
-		 "RX ProbeReq SA=%pM DA=%pM BSSID=%pM (tx_last_beacon=%d)\n",
-		 mgmt->sa, mgmt->da, mgmt->bssid, tx_last_beacon);
+	ibss_dbg(sdata, "RX ProbeReq SA=%pM DA=%pM\n", mgmt->sa, mgmt->da);
+	ibss_dbg(sdata, "\tBSSID=%pM (tx_last_beacon=%d)\n",
+		 mgmt->bssid, tx_last_beacon);
 
 	if (!tx_last_beacon && is_multicast_ether_addr(mgmt->da))
 		return;


