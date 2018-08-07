Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D8BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A37821731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY4AxcEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A37821731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeHGX3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45370 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeHGX3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so38336wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9WyOO34WTl5AhZtjl9ibv8gz/jTnibQH8xfAAM5A/zg=;
        b=DY4AxcEW4kcIdrV7wajTrpCQm4ta+o0av/mZm6mwhfcz9K9E5tUCboh3GCs/FFyztl
         hzvn7yA2kZ1w8lUMDbC9gH/p4mD0MJyQYRX/oImpn1HUoYFTqZMYsbe6kAnlFMeeudzL
         OS2+uoVYRanjkkcpsoknOREJoVKmetg9qIk36rGBtuHCPhjB/5o+3TQOcAIorr+/e/1X
         TKMtOaViQrXHgjFT6/tgSId4tB3UrIHb5+daDGSNO00OC1LCJZ8wvg36x/n79cJh2oDo
         iqFclhTWBZdxfD0HabzxCHuFA9JksqdGxxuo5MYh97nXeKFE2oiQRQWP4KldavTKq4v0
         CB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9WyOO34WTl5AhZtjl9ibv8gz/jTnibQH8xfAAM5A/zg=;
        b=ObpCf/GUMYSz5g6iwSCNGOj4ojkDZ+SqR5NJ3mpvWNx7C/l71Ip8czW49eac1uyPkf
         RBSsTPhyxa42SwUlNQoMyFGD638TAyyAEa09uaW/BS2zrJ3HnruY5B8uLSF0AIwYGh0H
         XjbLCZfmlCO7Z7m+ORI6ldbW4ze7/zmxMUT1Ad1sRhHf2pgMoyk+5gcs9potPIjntrOq
         FTDVNDSdwhSHfkLg1aKfwBiB1+Dx8dn9M2cHDubL8RYG+wvyafoolbzQZGtS7HghJhHQ
         rXfds3wBxiGvx8G49rtDBMsGlAqprklGwO5LCnzWM0bVCfb6sXANErhGwjK2KK3fTaqH
         XH9g==
X-Gm-Message-State: AOUpUlEQaKy5n27e+8J6GBfLa7AE9LUbcCsouiQ0cOoDHu2R1RH+3BvU
        mwFfPDiNjozpUppNiuOZGpuddgpw
X-Google-Smtp-Source: AA+uWPwtZ3G2r3qRwlQeIRuDz/uSY2aV+yTFsFnyUpm4g09iSVgMCU36QpxLWNCnHMtUaCe6zYfvXQ==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr52807wre.29.1533676400064;
        Tue, 07 Aug 2018 14:13:20 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:19 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/17] staging:rtl8192u: Rename DOT11D_GetMaxTxPwrInDbm -  Style
Date:   Tue,  7 Aug 2018 22:12:51 +0100
Message-Id: <20180807211255.29343-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function DOT11D_GetMaxTxPwrInDbm causes a checkpatch issue due to
its use of CamelCase naming. The function has been renamed to
dot11d_get_max_tx_pwr_in_dbm.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 6855b096d0fc..3a11c0ad3f2b 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -99,13 +99,13 @@ void dot11d_update_country_ie(struct ieee80211_device *dev, u8 *pTaddr,
 }
 EXPORT_SYMBOL(dot11d_update_country_ie);
 
-u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel)
+u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 Channel)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 	u8 MaxTxPwrInDbm = 255;
 
 	if (Channel > MAX_CHANNEL_NUMBER) {
-		netdev_err(dev->dev, "DOT11D_GetMaxTxPwrInDbm(): Invalid Channel\n");
+		netdev_err(dev->dev, "dot11d_get_max_tx_pwr_in_dbm(): Invalid Channel\n");
 		return MaxTxPwrInDbm;
 	}
 	if (pDot11dInfo->channel_map[Channel])
@@ -113,7 +113,7 @@ u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel)
 
 	return MaxTxPwrInDbm;
 }
-EXPORT_SYMBOL(DOT11D_GetMaxTxPwrInDbm);
+EXPORT_SYMBOL(dot11d_get_max_tx_pwr_in_dbm);
 
 void DOT11D_ScanComplete(struct ieee80211_device *dev)
 {
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 84c46f5b5a30..b052fae72a4c 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -55,7 +55,7 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
 			      u8 *addr,
 			      u16 coutry_ie_len,
 			      u8 *coutry_ie);
-u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel);
+u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 Channel);
 void DOT11D_ScanComplete(struct ieee80211_device *dev);
 int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
 int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
-- 
2.18.0

