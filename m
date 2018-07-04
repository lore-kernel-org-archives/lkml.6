Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAF0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933BF23E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqPwALLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933BF23E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeGDOVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:21:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35887 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeGDOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:21:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so5959700wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+nOPvXYIOPBNfKzbmHwqVn2EmoIDcNS9oOPE2YRktcw=;
        b=UqPwALLKQQEFQ160FDUvdPcGynkvBrjFdYmmQ8qkSZSD1WC69rCUo1BGRQ9v6dweq7
         iQzNPGGgTQByiUHLVA6r0jF5AWmPGAD6Ne+fYO/dgrMGWjr+5o6/BcfHnuJTr7adEg2Q
         kHzDZ4icaB2GF4q31/2YY4bUi1mrO9NzrIdvSfQqFnlq8kGDFf75N2u9l9vPV0jxTVJA
         eFik5zmkU8QStlaPI3viGSU+gE+bxVnOZdDYaVrVBNAkxEq5af4dCU6t+XtZ97sV93d3
         l3DZXwq+czSfyO80WDqhSkWNZaVPjl/7z/9bVUdchVmUmm7DyLqkrL/5DaWC8vH4+89x
         uWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+nOPvXYIOPBNfKzbmHwqVn2EmoIDcNS9oOPE2YRktcw=;
        b=R7xCypfMzdmqbfyXijg7jSoI3MecUcZVGdm6qwX8XMF3qP7+c8XVjRxDCsV1ysWgMZ
         eFUVBrDOepOdlskWICpFoMGpimp2uPx9oElYOdsOaSd5g11h8PGSbU9Ksc9Ek0aF1s2m
         wat+e/3NlhXT0EWTi2+HSX6k/u+BHJlhkVJ7Rf3V9WfwAcmFbyZ92FDyrBrpL/zhuZWk
         Zq2d644AJjaE7hXPRZKUYHxJn9SBwVbsWMrU/fo7r330rp2/T3hIkJnv39ropC+serps
         jd6Q0/ZzPa74mVWeEIvu+/4eczaXKJ/4ExtNMnCmCktK0+5oz5XS/hReaErqRb+gp4ES
         +OvA==
X-Gm-Message-State: APt69E0dZb01aGWyS9NVPwAVwlZW9xb4y/OC51T5KQAmhcj8qVZL3sdw
        LbwpKQVNOhEueqMyMKQco59BrgjL
X-Google-Smtp-Source: AAOMgpd1+WIsjmmyypx19+Syqz0xQc7lMsX2bi+VWxxKxNCyP2wAIBrXcvIQaTWi3b1Nc83+WY0mAA==
X-Received: by 2002:a5d:6401:: with SMTP id z1-v6mr1767280wru.64.1530714074159;
        Wed, 04 Jul 2018 07:21:14 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7109142wrc.5.2018.07.04.07.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:21:13 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 5/9] staging: rtl8192u: Add space required around '==' opeartor - Style
Date:   Wed,  4 Jul 2018 15:20:52 +0100
Message-Id: <20180704142056.2179-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704142056.2179-1-johnfwhitmore@gmail.com>
References: <20180704142056.2179-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple addition of the coding style required spaces around '==' operator.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 7ef761632629..0e4d1febd958 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -193,8 +193,8 @@ static u8 MgntQuery_MgntFrameTxRate(struct ieee80211_device *ieee)
 	if (rate == 0) {
 		/* 2005.01.26, by rcnjko. */
 		if(ieee->mode == IEEE_A||
-		   ieee->mode== IEEE_N_5G||
-		   (ieee->mode== IEEE_N_24G&&!pHTInfo->bCurSuppCCK))
+		   ieee->mode == IEEE_N_5G||
+		   (ieee->mode == IEEE_N_24G&&!pHTInfo->bCurSuppCCK))
 			rate = 0x0c;
 		else
 			rate = 0x02;
@@ -1315,7 +1315,7 @@ static void ieee80211_associate_complete_wq(struct work_struct *work)
 	}
 	ieee->LinkDetectInfo.SlotNum = 2 * (1 + ieee->current_network.beacon_interval/500);
 	// To prevent the immediately calling watch_dog after association.
-	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod==0||ieee->LinkDetectInfo.NumRecvDataInPeriod==0 )
+	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0||ieee->LinkDetectInfo.NumRecvDataInPeriod == 0 )
 	{
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
 		ieee->LinkDetectInfo.NumRecvDataInPeriod= 1;
@@ -1391,8 +1391,8 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 		 */
 		apset = ieee->wap_set;//(memcmp(ieee->current_network.bssid, zero,ETH_ALEN)!=0 );
 		ssidset = ieee->ssid_set;//ieee->current_network.ssid[0] != '\0';
-		ssidbroad =  !(net->ssid_len == 0 || net->ssid[0]== '\0');
-		apmatch = (memcmp(ieee->current_network.bssid, net->bssid, ETH_ALEN)==0);
+		ssidbroad =  !(net->ssid_len == 0 || net->ssid[0] == '\0');
+		apmatch = (memcmp(ieee->current_network.bssid, net->bssid, ETH_ALEN) == 0);
 		ssidmatch = (ieee->current_network.ssid_len == net->ssid_len)&&\
 				(!strncmp(ieee->current_network.ssid, net->ssid, net->ssid_len));
 
@@ -1595,8 +1595,8 @@ static inline u16 assoc_parse(struct ieee80211_device *ieee, struct sk_buff *skb
 	*aid = le16_to_cpu(response_head->aid) & 0x3fff;
 
 	status_code = le16_to_cpu(response_head->status);
-	if((status_code==WLAN_STATUS_ASSOC_DENIED_RATES || \
-	   status_code==WLAN_STATUS_CAPS_UNSUPPORTED)&&
+	if((status_code == WLAN_STATUS_ASSOC_DENIED_RATES || \
+	   status_code == WLAN_STATUS_CAPS_UNSUPPORTED)&&
 	   ((ieee->mode == IEEE_G) &&
 	    (ieee->current_network.mode == IEEE_N_24G) &&
 	    (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT-1)))) {
-- 
2.17.1

