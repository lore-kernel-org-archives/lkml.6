Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBDEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4CB20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op7Rtpiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4CB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeHaLTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:19:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36837 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaLTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:19:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id e11-v6so5059927plb.3;
        Fri, 31 Aug 2018 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HHRj52ALbHWqQa3tkAdneT2a51jVfOO/QR9EtesCJjA=;
        b=Op7RtpiyQ+SnMdNMavTQLFiLg7TGdqOEufm60xjCQlALJAauG1NlQZbGJxP8Olollz
         AKa7gCOCPi5S1IGYWV6+pshCldNLBZCaHmI448r0tmdGNFoNn+dlJcUDCzp7z/xsL7zz
         KyAUh5GrYKE0W9kRQM6L0A2zL8uZHNI94UZyXSFxvvICaqmQCgEtHOrcx+Eseyd6T3aH
         pqOtZYaUBjZBAtZTNwTsV3Syt5IGvVhH2xMEz5JqNXguel44XemdHqr8CfAvMFtm3mSs
         8RL9H4lJ8oUpbVV6vuCFpB1wWElAa9VkLi0dWwUgwABsf6M/BPzMAobfnf0wGudo6LEo
         m6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HHRj52ALbHWqQa3tkAdneT2a51jVfOO/QR9EtesCJjA=;
        b=j+pGkBzutCbEaKU5NsHI2xEkmukdKD4rPen74d1hBZ/KikcW15vrAgyESPGJVX1mad
         W76Z4HrFkgQkCHOEpUYLViPQbjTTPrsRzRbeD9OPFRNT9k2L3nV9Ld9lBdP9/mTj3mSr
         lsvwsLOUAsbwGlnkIXy/+lkFfAM7LRH1Yugrd44+OktYKwdyNkBJ+kfP4g6NMmk+YVNV
         00Mjt2ydn8C3iDensENt4GtSDn38ix0Vs8iJtJmMwZLtYzkdG0TgTVQBsel35aGGZ7iC
         ZMaiPKq0eawawXlY8nZBuQTbkEbn7lGYOJWQEanNvglfpcUTzG/7wukPlXaWxJhTaIXT
         T0Hw==
X-Gm-Message-State: APzg51B8LV1vNkv44HhDZmOSD5d0JveOu6d+gtnyZvvf4JcQXiLLaL0F
        CGzxLVVSzMN6b5zFEQDwOsPgssJ2ixs=
X-Google-Smtp-Source: ANB0VdYs7q7J/BvUwZCqorp5MkExY6JICmGdNsBBQQgvy3QVt4LYw90gDRzS1G8ObQxN8pkV3SgiDQ==
X-Received: by 2002:a17:902:49:: with SMTP id 67-v6mr14305655pla.206.1535699600827;
        Fri, 31 Aug 2018 00:13:20 -0700 (PDT)
Received: from localhost.localdomain ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id b6-v6sm5493654pfh.182.2018.08.31.00.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 00:13:20 -0700 (PDT)
From:   Yuan-Chi Pang <fu3mo6goo@gmail.com>
To:     johannes@sipsolutions.net
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan-Chi Pang <fu3mo6goo@gmail.com>
Subject: [PATCH] mac80211: fix TX status reporting for ieee80211s
Date:   Fri, 31 Aug 2018 15:12:55 +0800
Message-Id: <1535699575-5672-1-git-send-email-fu3mo6goo@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ieee80211s_update_metric works only if wireless
driver passes tx_status of data frame to mac80211

Make API and caller of ieee80211s_update_metric to be
similar to rate_control_tx_status

Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>
---
 net/mac80211/mesh.h      | 2 +-
 net/mac80211/mesh_hwmp.c | 8 ++------
 net/mac80211/status.c    | 4 +++-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index ee56f18..3c6095a 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -217,7 +217,7 @@ void mesh_rmc_free(struct ieee80211_sub_if_data *sdata);
 int mesh_rmc_init(struct ieee80211_sub_if_data *sdata);
 void ieee80211s_init(void);
 void ieee80211s_update_metric(struct ieee80211_local *local,
-			      struct sta_info *sta, struct sk_buff *skb);
+			struct sta_info *sta, struct ieee80211_tx_status *st);
 void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata);
 void ieee80211_mesh_teardown_sdata(struct ieee80211_sub_if_data *sdata);
 int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index daf9db3..4286673 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -295,15 +295,11 @@ int mesh_path_error_tx(struct ieee80211_sub_if_data *sdata,
 }
 
 void ieee80211s_update_metric(struct ieee80211_local *local,
-		struct sta_info *sta, struct sk_buff *skb)
+		struct sta_info *sta, struct ieee80211_tx_status *st)
 {
-	struct ieee80211_tx_info *txinfo = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct ieee80211_tx_info *txinfo = st->info;
 	int failed;
 
-	if (!ieee80211_is_data(hdr->frame_control))
-		return;
-
 	failed = !(txinfo->flags & IEEE80211_TX_STAT_ACK);
 
 	/* moving average, scaled to 100.
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 9a6d720..dfcd419 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -811,7 +811,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 
 		rate_control_tx_status(local, sband, status);
 		if (ieee80211_vif_is_mesh(&sta->sdata->vif))
-			ieee80211s_update_metric(local, sta, skb);
+			ieee80211s_update_metric(local, sta, status);
 
 		if (!(info->flags & IEEE80211_TX_CTL_INJECTED) && acked)
 			ieee80211_frame_acked(sta, skb);
@@ -972,6 +972,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		}
 
 		rate_control_tx_status(local, sband, status);
+		if (ieee80211_vif_is_mesh(&sta->sdata->vif))
+			ieee80211s_update_metric(local, sta, status);
 	}
 
 	if (acked || noack_success) {
-- 
2.7.4

