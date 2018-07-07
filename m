Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A27AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C8720862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0fKO+QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C8720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeGGO4M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:56:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54119 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754163AbeGGOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id b188-v6so17282129wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z2qgIjjcP2B9OoEPrXGJXq63HXhurnwc4f/t7Mtipms=;
        b=Q0fKO+QYYct+IsZyqZXTWi/L9oumKcuxrxXBtxCM6TF/KfE/Ix1+QCzpvkeNSAS5BL
         KNj8N5C5YIXZ4KOUurVSpvsO7bUCgjweIl7CAUbOtmfhubQDhwIZ0W9MXoCaHullZBEz
         WxE9wTRTDAWaWf9YEIHpUQ+i9SYQwFfybZq7W9SNU0qlXLO4HTWReX6lzC2LhWobI4d/
         aURnQbvVh5jC8rD/gdzz0L4edc0tDzl02Pdc2ecBvX9VydQywdN2LtBa/9RpeEDULZYt
         UrCppBfJgcT000cgTUOhmzM0vgTzbL9fSr77c9vJFwCcdUNKoYIjC1Mx2umyjiSrpDIF
         NeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z2qgIjjcP2B9OoEPrXGJXq63HXhurnwc4f/t7Mtipms=;
        b=l4FrHFHaoSqIO6V4XusP+cuufrPtZE7k6Y4lqDeiY/pzuTBR+kBL/45OE+rpLcbvGp
         ZTqt7VTx7zhAbktbnMFkdp+kBGy5o4/7X9gnFat0bvj/3l7xRBVLGXFyOjs+xiE501FZ
         UZkaV+ZbZQk7HgzTcT841k+4PcNXw0VHVJe0NK1NTlTD5nCAAiAKwq2w0tsSNs8/mVet
         QbM7EsKkod0B5POCM+W9pBWncCtJuyNQz9GFaQJ6Yr8nbbOKgncY+7e7BJacj4YqTPxv
         wHh0B524Hvre/qkufVrG5q305hvm8jAYZ1xMxMZCwtehJNUM110lcXTm7tzRzrzr9EOP
         rXAg==
X-Gm-Message-State: APt69E09+HG1hCNa98Lcgap4d5pZjC4pMMLgUjfsKFWvqdt2YaxCupq2
        473cXiDf1yR6+n5SQrOW7yDpiQ==
X-Google-Smtp-Source: AAOMgpeapRXkLV9bzEX/6jGC/tZqSNEaI9aoYJd+lKCnMtDFPxdwntJuqCGq3OOUee65CAPhNiCuTw==
X-Received: by 2002:a1c:dc1:: with SMTP id 184-v6mr8298277wmn.145.1530975344209;
        Sat, 07 Jul 2018 07:55:44 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:43 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/12] staging:rtl8192u: Correct indentation of ieee80211_softmac_new_net()
Date:   Sat,  7 Jul 2018 15:55:12 +0100
Message-Id: <20180707145513.15325-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style change to correct the indentation of the function
ieee80211_softmac_new_net()

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 101 +++++++++---------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index fd2cf8d8d593..e1a91db7f0a1 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1378,63 +1378,62 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 		 * if the network does broadcast and the user did set essid chech if essid match
 		 */
 		if ((apset && apmatch &&
-				((ssidset && ssidbroad && ssidmatch) || (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
-			/* if the ap is not set, check that the user set the bssid
-			 * and the network does broadcast and that those two bssid matches
+		     ((ssidset && ssidbroad && ssidmatch) || (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
+		    /* if the ap is not set, check that the user set the bssid
+		     * and the network does broadcast and that those two bssid matches
+		     */
+		    (!apset && ssidset && ssidbroad && ssidmatch)) {
+			/* if the essid is hidden replace it with the
+			 * essid provided by the user.
 			 */
-			(!apset && ssidset && ssidbroad && ssidmatch)
-			) {
-				/* if the essid is hidden replace it with the
-				* essid provided by the user.
-				*/
-				if (!ssidbroad) {
-					strncpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
-					tmp_ssid_len = ieee->current_network.ssid_len;
-				}
-				memcpy(&ieee->current_network, net, sizeof(struct ieee80211_network));
-
-				strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
-				ieee->current_network.ssid_len = tmp_ssid_len;
-				printk(KERN_INFO"Linking with %s,channel:%d, qos:%d, myHT:%d, networkHT:%d\n",
-				       ieee->current_network.ssid,
-				       ieee->current_network.channel,
-				       ieee->current_network.qos_data.supported,
-				       ieee->pHTInfo->bEnableHT,
-				       ieee->current_network.bssht.bdSupportHT);
-
-				//ieee->pHTInfo->IOTAction = 0;
-				HTResetIOTSetting(ieee->pHTInfo);
-				if (ieee->iw_mode == IW_MODE_INFRA) {
-					/* Join the network for the first time */
-					ieee->AsocRetryCount = 0;
-					//for HT by amy 080514
-					if ((ieee->current_network.qos_data.supported == 1) &&
-					    // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSupportHT))
-					    ieee->current_network.bssht.bdSupportHT) {
+			if (!ssidbroad) {
+				strncpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
+				tmp_ssid_len = ieee->current_network.ssid_len;
+			}
+			memcpy(&ieee->current_network, net, sizeof(struct ieee80211_network));
+
+			strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
+			ieee->current_network.ssid_len = tmp_ssid_len;
+			printk(KERN_INFO"Linking with %s,channel:%d, qos:%d, myHT:%d, networkHT:%d\n",
+			       ieee->current_network.ssid,
+			       ieee->current_network.channel,
+			       ieee->current_network.qos_data.supported,
+			       ieee->pHTInfo->bEnableHT,
+			       ieee->current_network.bssht.bdSupportHT);
+
+			//ieee->pHTInfo->IOTAction = 0;
+			HTResetIOTSetting(ieee->pHTInfo);
+			if (ieee->iw_mode == IW_MODE_INFRA) {
+				/* Join the network for the first time */
+				ieee->AsocRetryCount = 0;
+				//for HT by amy 080514
+				if ((ieee->current_network.qos_data.supported == 1) &&
+				    // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSupportHT))
+				    ieee->current_network.bssht.bdSupportHT) {
 /*WB, 2008.09.09:bCurrentHTSupport and bEnableHT two flags are going to put together to check whether we are in HT now, so needn't to check bEnableHT flags here. That's is to say we will set to HT support whenever joined AP has the ability to support HT. And whether we are in HT or not, please check bCurrentHTSupport&&bEnableHT now please.*/
 					//	ieee->pHTInfo->bCurrentHTSupport = true;
-						HTResetSelfAndSavePeerSetting(ieee, &ieee->current_network);
-					} else {
-						ieee->pHTInfo->bCurrentHTSupport = false;
-					}
+					HTResetSelfAndSavePeerSetting(ieee, &ieee->current_network);
+				} else {
+					ieee->pHTInfo->bCurrentHTSupport = false;
+				}
 
-					ieee->state = IEEE80211_ASSOCIATING;
-					schedule_work(&ieee->associate_procedure_wq);
+				ieee->state = IEEE80211_ASSOCIATING;
+				schedule_work(&ieee->associate_procedure_wq);
+			} else {
+				if (ieee80211_is_54g(&ieee->current_network) &&
+				    (ieee->modulation & IEEE80211_OFDM_MODULATION)) {
+					ieee->rate = 108;
+					ieee->SetWirelessMode(ieee->dev, IEEE_G);
+					printk(KERN_INFO"Using G rates\n");
 				} else {
-					if (ieee80211_is_54g(&ieee->current_network) &&
-					    (ieee->modulation & IEEE80211_OFDM_MODULATION)) {
-						ieee->rate = 108;
-						ieee->SetWirelessMode(ieee->dev, IEEE_G);
-						printk(KERN_INFO"Using G rates\n");
-					} else {
-						ieee->rate = 22;
-						ieee->SetWirelessMode(ieee->dev, IEEE_B);
-						printk(KERN_INFO"Using B rates\n");
-					}
-					memset(ieee->dot11HTOperationalRateSet, 0, 16);
-					//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
-					ieee->state = IEEE80211_LINKED;
+					ieee->rate = 22;
+					ieee->SetWirelessMode(ieee->dev, IEEE_B);
+					printk(KERN_INFO"Using B rates\n");
 				}
+				memset(ieee->dot11HTOperationalRateSet, 0, 16);
+				//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
+				ieee->state = IEEE80211_LINKED;
+			}
 		}
 	}
 }
-- 
2.18.0

