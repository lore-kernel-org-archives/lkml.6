Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A646C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1608820862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3XQ6C6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1608820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbeG0SzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35565 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388955AbeG0SzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so6334961wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AXYH8NAKL+Rkd3reywzuRnFZH9lhSBgUHIDL0kf3vM=;
        b=V3XQ6C6yT1sEltc/bNfXJG6G9L8xhP3sgjD4RD+05YPvzrp/aSAp2LxAm4XN8MuAZY
         UlsPLTUJlxng51Xj6Z3jeZiLfhDxvgHCNMt4LcYcvQJms+jttO+juRpEmMJyD/3DVj9Y
         qHBw0zFhEOLA1dAbSJ2pDANbQTc/SO/kRVKvGmHjiS2NOfMQ0UWfdSw2uwMG54DVaNdg
         bM3ROdhRbYc9t4TTMXsRWAzcYEGCa5syviBNbqE1GIlS+A3pTL7vfWAW+JIPZ39YiikF
         eJCXzBnRMsFibVG0ZHB9oBd8tZLgJKJi6mkt868gjYFdfluZiVr/RbhKc3Rzbapul+Ly
         Fk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0AXYH8NAKL+Rkd3reywzuRnFZH9lhSBgUHIDL0kf3vM=;
        b=Wl8XOYXYbuIkMvuE6Fbuh2dHXvWfubihkGxhBPTplfYcuimCwNZD2+xt9HCFgTZ8S2
         oUvlGK/6Du7YBE8wP2jvcvgybdcmU9I3f8114ONhoppIzxyhAsFUXPr/d2NM+RmyDeEn
         wgspeHH92D+6LxhpNBLDOpAIHz+7fSBfEpCMV0UCEcJv3r8scEWOpS8DnXDwBgBDDTDO
         /vZxdZpKPsKnP23uiVgW0HSde8MSQN1whnemO6pH3YM4XhYFs16taK8pxb+gSfr+V6BE
         nC8uJ+2OQ5vj/X46DuWNiLYhvgGhyHdTC1R/QHb0SGcJUai0oLL4coCsMSRp70g3o6eg
         cb8w==
X-Gm-Message-State: AOUpUlHu+18EUDkAz/Jepz3LjWbxeVY2ljhM/FqfZRLCqrBWj4NtS0Qm
        JuYiP9bdaxPQjuTWvXNHqT7UNVEwJmk=
X-Google-Smtp-Source: AAOMgpd03vCTpnT0sxjML6ChOVs5XwBIBH1ug47Ad6ah0fo0/Jj28zGvVuw48ydyRiCgBDRcw0tBqQ==
X-Received: by 2002:a1c:6c03:: with SMTP id h3-v6mr4879459wmc.38.1532712725745;
        Fri, 27 Jul 2018 10:32:05 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:32:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 18/20] staging:rtl8192u: Rename RxLastSeqNum - Style
Date:   Fri, 27 Jul 2018 18:31:21 +0100
Message-Id: <20180727173123.27391-19-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable RxLastSeqNum to rx_last_seq_num. This change
clears the checkpatch issue with CamelCase naming.

The resulting changes are purely coding style in nature so should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 5a2a7a4aedca..c0c746bfd390 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1028,16 +1028,16 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 				true))
 		{
 
-		//	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): pRxTS->RxLastFragNum is %d,frag is %d,pRxTS->RxLastSeqNum is %d,seq is %d\n",__func__,pRxTS->RxLastFragNum,frag,pRxTS->RxLastSeqNum,WLAN_GET_SEQ_SEQ(sc));
+		//	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): pRxTS->RxLastFragNum is %d,frag is %d,pRxTS->rx_last_seq_num is %d,seq is %d\n",__func__,pRxTS->RxLastFragNum,frag,pRxTS->rx_last_seq_num,WLAN_GET_SEQ_SEQ(sc));
 			if ((fc & (1<<11)) &&
 			    (frag == pRxTS->RxLastFragNum) &&
-			    (WLAN_GET_SEQ_SEQ(sc) == pRxTS->RxLastSeqNum)) {
+			    (WLAN_GET_SEQ_SEQ(sc) == pRxTS->rx_last_seq_num)) {
 				goto rx_dropped;
 			}
 			else
 			{
 				pRxTS->RxLastFragNum = frag;
-				pRxTS->RxLastSeqNum = WLAN_GET_SEQ_SEQ(sc);
+				pRxTS->rx_last_seq_num = WLAN_GET_SEQ_SEQ(sc);
 			}
 		}
 		else
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 7cc13e5dfb2d..0bf877162a8f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -44,7 +44,7 @@ struct rx_ts_record {
 	struct list_head		rx_pending_pkt_list;
 	struct timer_list		rx_pkt_pending_timer;
 	BA_RECORD			rx_admitted_ba_record;	 /*  For BA Recipient */
-	u16				RxLastSeqNum;
+	u16				rx_last_seq_num;
 	u8				RxLastFragNum;
 	u8				num;
 };
-- 
2.18.0

