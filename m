Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F1BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070792083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070792083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeHaPVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:21:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeHaPVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:21:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5D6043DCE876;
        Fri, 31 Aug 2018 19:14:18 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Fri, 31 Aug 2018
 19:14:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kvalo@codeaurora.org>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <amit.karwar@redpinesignals.com>,
        <pavani.muthyala@redpinesignals.com>, <keescook@chromium.org>,
        <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] rsi: remove set but not used variable 'header_size'
Date:   Fri, 31 Aug 2018 19:13:25 +0800
Message-ID: <20180831111325.16984-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/wireless/rsi/rsi_91x_hal.c: In function 'rsi_send_data_pkt':
drivers/net/wireless/rsi/rsi_91x_hal.c:288:5: warning:
 variable 'header_size' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove unused 'tx_params'
---
 drivers/net/wireless/rsi/rsi_91x_hal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 01edf96..182b066 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -282,10 +282,8 @@ int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
 	struct rsi_hw *adapter = common->priv;
 	struct ieee80211_vif *vif;
 	struct ieee80211_tx_info *info;
-	struct skb_info *tx_params;
 	struct ieee80211_bss_conf *bss;
 	int status = -EINVAL;
-	u8 header_size;
 
 	if (!skb)
 		return 0;
@@ -297,8 +295,6 @@ int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
 		goto err;
 	vif = info->control.vif;
 	bss = &vif->bss_conf;
-	tx_params = (struct skb_info *)info->driver_data;
-	header_size = tx_params->internal_hdr_size;
 
 	if (((vif->type == NL80211_IFTYPE_STATION) ||
 	     (vif->type == NL80211_IFTYPE_P2P_CLIENT)) &&
-- 
2.7.0


