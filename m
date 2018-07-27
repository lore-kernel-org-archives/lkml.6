Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C76AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35355208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35355208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbeG0O2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:28:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730771AbeG0O2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:28:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BAE358ADF689B;
        Fri, 27 Jul 2018 21:06:02 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Fri, 27 Jul 2018
 21:05:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <sgruszka@redhat.com>,
        <helmut.schaa@googlemail.com>, <kvalo@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] rt2x00:  remove redundant functions rt2x00mac_sta_{add/remove}
Date:   Fri, 27 Jul 2018 21:05:49 +0800
Message-ID: <20180727130549.12980-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only rt2800 subdriver of rt2x00 implement sta_add() and sta_remove(),
rt2x00mac_sta_add and rt2x00mac_sta_remove has no callers after
commit 9c87758cf089 ("rt2x00: call sta_add/remove directly in rt2800").
So can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index c380c1f..fa2fd64 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -527,24 +527,6 @@ int rt2x00mac_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 EXPORT_SYMBOL_GPL(rt2x00mac_set_key);
 #endif /* CONFIG_RT2X00_LIB_CRYPTO */
 
-int rt2x00mac_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		      struct ieee80211_sta *sta)
-{
-	struct rt2x00_dev *rt2x00dev = hw->priv;
-
-	return rt2x00dev->ops->lib->sta_add(rt2x00dev, vif, sta);
-}
-EXPORT_SYMBOL_GPL(rt2x00mac_sta_add);
-
-int rt2x00mac_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta)
-{
-	struct rt2x00_dev *rt2x00dev = hw->priv;
-
-	return rt2x00dev->ops->lib->sta_remove(rt2x00dev, sta);
-}
-EXPORT_SYMBOL_GPL(rt2x00mac_sta_remove);
-
 void rt2x00mac_sw_scan_start(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     const u8 *mac_addr)
-- 
2.7.0


