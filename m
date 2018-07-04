Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A160C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D653123E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZUa+ooC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D653123E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeGDOWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:22:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54105 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeGDOVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:21:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so6037294wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RHjNJOj9nXzrJfZhKoeYftMGzyD7KhyvQ5ezhAo9z3g=;
        b=QZUa+ooCNIJ3mG3tN7wOw3g52Hnhd5kyuB7tPDbuHXLT3CkDhXH0TD+xFr4btmeFd5
         e/GVQAMnZpT2JvtFYcxIskQGTGi+du/bvMMJyEczVSh2gw2W7wJKP2fLCynLL0XIJjkB
         CTGb8o4zEgJGVKSF7HhmNVwx4QmuhFWFoKFoZ8wbxGj4HCZEk/38e0jgfm9LY1aPnWzo
         R3v2GnTLZRo4uM5YyHCt2sC3Waj1OAMODBbrRzMTpMaFiKJTw1dZfQBoVjO7weBJVSBo
         6qSRUWcPnNuFP6EPiouWSTAN3LpoGmYQZ4cwU+M7Nji83QdIh+18tSy8QQPiJl5SQRkp
         4EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RHjNJOj9nXzrJfZhKoeYftMGzyD7KhyvQ5ezhAo9z3g=;
        b=uhii6MkHdEBy5Ce5wJofk9CAmgqZsoBkMEf2lw1ICoPo9IIKSi98Bm+qqq6qzZvm6u
         Xr3xUX8Xxy3XDPC5GQl9+yGKyxxVOQo0KwUZWsZLgXOCPP9S23Gu8UNRM2RV9fG3rNXI
         H8J8IxItPhepoKpZziXlCP/aNDXDLbNo46A5hjKQuH1r9Qo33Xn8+S9U7KfXwf2Yb7f8
         43Uy7SSXm0erBBrSRNtF2JqzP1ntpEkdt7eyQPnUX3vn71R5TdsKg45uMGh+FJNJbQ+v
         pYvB1xrMAjZEckcJfJPZyb4nbHGLQ8RBYgl4nIGp2nQkYAZA2ANuVOnln5hXjXtOdleY
         uFgg==
X-Gm-Message-State: APt69E3eZnMYBAoLGPGr9PgZ63UwWBjxVyi9FMrVSKnYcvZCBKAqOBBv
        rA9M6zDpDd2E013Us9zt+Pj2VvnN
X-Google-Smtp-Source: AAOMgpceuF07slgRmH6TkZ3kmUXSYA0kjnBJKGBxRquk/gDhGA0jyCkUK8DWa+DdfCKGZDKaVJUADg==
X-Received: by 2002:a1c:5b0d:: with SMTP id p13-v6mr1759814wmb.53.1530714075786;
        Wed, 04 Jul 2018 07:21:15 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7109142wrc.5.2018.07.04.07.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:21:15 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 6/9] staging: rtl8192u: Add required spaces around '||' operator - Sytle
Date:   Wed,  4 Jul 2018 15:20:53 +0100
Message-Id: <20180704142056.2179-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704142056.2179-1-johnfwhitmore@gmail.com>
References: <20180704142056.2179-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additon of the coding style required spaces around the '||' operator.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 0e4d1febd958..337d86effa69 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -192,8 +192,8 @@ static u8 MgntQuery_MgntFrameTxRate(struct ieee80211_device *ieee)
 
 	if (rate == 0) {
 		/* 2005.01.26, by rcnjko. */
-		if(ieee->mode == IEEE_A||
-		   ieee->mode == IEEE_N_5G||
+		if(ieee->mode == IEEE_A ||
+		   ieee->mode == IEEE_N_5G ||
 		   (ieee->mode == IEEE_N_24G&&!pHTInfo->bCurSuppCCK))
 			rate = 0x0c;
 		else
@@ -265,8 +265,8 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 			ieee->seq_ctrl[0]++;
 
 		/* check whether the managed packet queued greater than 5 */
-		if(!ieee->check_nic_enough_desc(ieee->dev,tcb_desc->queue_index)||\
-				(skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) != 0)||\
+		if(!ieee->check_nic_enough_desc(ieee->dev,tcb_desc->queue_index) ||\
+				(skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) != 0) ||\
 				(ieee->queue_stop) ) {
 			/* insert the skb packet to the management queue */
 			/* as for the completion function, it does not need
@@ -1315,7 +1315,7 @@ static void ieee80211_associate_complete_wq(struct work_struct *work)
 	}
 	ieee->LinkDetectInfo.SlotNum = 2 * (1 + ieee->current_network.beacon_interval/500);
 	// To prevent the immediately calling watch_dog after association.
-	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0||ieee->LinkDetectInfo.NumRecvDataInPeriod == 0 )
+	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 || ieee->LinkDetectInfo.NumRecvDataInPeriod == 0 )
 	{
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
 		ieee->LinkDetectInfo.NumRecvDataInPeriod= 1;
@@ -2088,7 +2088,7 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 #else
 		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) != 0) ||
 #endif
-		(!ieee->check_nic_enough_desc(ieee->dev,queue_index))||\
+		(!ieee->check_nic_enough_desc(ieee->dev,queue_index)) || \
 		     (ieee->queue_stop)) {
 			/* insert the skb packet to the wait queue */
 			/* as for the completion function, it does not need
-- 
2.17.1

