Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AD0208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKSkc3QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AD0208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934177AbeGJPGc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:06:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39663 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934134AbeGJPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:06:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id w14-v6so16830919eds.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=62pX/UuEEQdgBg5pOmqkb3G5cNY+MIIXD9s7mwau4VY=;
        b=UKSkc3QSJEHFDd6W5F3wb3H4HtOiUikuPCDuVYMrvQf5TjUZKi016GidCyweBEkpPN
         20l2wy3ADiRi6I8klFFoJ2iR6yM9p+Yn7+94fflNNevip4CWzsgOZE7aVHf9r6u4+uJd
         gs5glhbNKtxiLWvF+bAva3CErdgRv//NXEz3qVY9uSCAd2GVRgGsGou0LBbhuyCl+o3T
         iQHiGHBb/3luWQx3CpOpNWyYF3iq5KQz9rV+4JT+94ouvaWNke7h8TkV2Gvj2NhGXvf3
         4sNNFDJLDZDjEFPdqx/ePqBw+NWIqsGp9Ox/R3e7O15NMyHU3YoyxwXRQ/CtRs9qzXSy
         rccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=62pX/UuEEQdgBg5pOmqkb3G5cNY+MIIXD9s7mwau4VY=;
        b=GYDDwYO2Ooia2ggZDA/uD5VXdoFk6ah/JwSuX6nFJpKqn9KFhGwtBsCU+urX4SYDdK
         ZxkjS83IbEA45PwtQ2QLIX0mbnDXVXtBXAjJlFwv064VfGNknY+h6BxzMrj9RVXUVqbb
         sg5OByVEh6/J5cPJeHjadB3R4CvaAjLAIBZO63nhAZ9XaEWzSvZSHfPXHVWm1zlQFk5L
         KWidEzp6ryECNmt+XA1JfD+XL/xCKefnKB+K5KhY+TrgMkP61UR7TbJcqQ5pX2tKgRKV
         G5a294zaYXoRGQvEnhblT/34E0sdxgAeg3NdvECHxovGqjKtpOS4zMemFz3E8Sw3/stq
         gTdg==
X-Gm-Message-State: APt69E15xrVcGdvxmCa0/qKoIF+48BMzMzeQRocsa7GupLvO3AS1DFfI
        z9X6H8+y73fwXuHnbPGCUjeL1eif
X-Google-Smtp-Source: AAOMgpeZdmpS90BfjYKqNKd3IgvNPuCVceIX3mpu3KIbhz/3j66N4ldNjq4KqHMOcubV8O6KBaSPQQ==
X-Received: by 2002:a50:b764:: with SMTP id g91-v6mr28485240ede.187.1531235162322;
        Tue, 10 Jul 2018 08:06:02 -0700 (PDT)
Received: from localhost.localdomain ([109.76.156.5])
        by smtp.gmail.com with ESMTPSA id s19-v6sm1895389edd.53.2018.07.10.08.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:06:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 7/8] staging:rtl8192u: Correct indentation of ieee80211_softmac_new_net()
Date:   Tue, 10 Jul 2018 16:05:22 +0100
Message-Id: <20180710150523.17384-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710150523.17384-1-johnfwhitmore@gmail.com>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style change to correct the indentation of the function
ieee80211_softmac_new_net(). A large proportion of the function's if statements
were incorrectly indented.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 101 +++++++++---------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 023f23d2eb67..6507b6101342 100644
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

