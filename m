Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D48AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B637F2172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhqoE8I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B637F2172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeHGX3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39316 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeHGX3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so518597wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QMJNh9Nps3lNaky/ZqkpkG5HL0wnEpY/JRWR1C3fWME=;
        b=XhqoE8I1I0xxbsk5/EhOP0h92I7MQrqUF2C0BGMjOqQ9FXO8uuenAmAgi6TzMksa4r
         B8gAADlHVFk6Z27sw9v0ncawFT3I3NwHOidiw2vYpaBVsvnPRNLFsfyP8WlzV1YRjLZ5
         Rn+1KJqC+T2J4SWq8PZO3h7yXlaP9XRZkUB3wBlsvqhGOUzNVUMzX/hqRbvOb33e4CDV
         drhPSdSu/J0G3m/KsjC94Y70iWLA75zcXMsRvRP7No8d9J5iHZi5XvgJ3QbN4dahH5m5
         DQ1opRa++mZYzEuP/IIgv8OVA4U4Lx2Fl/NhVU21zPkmO6vtdi3QHXrPyuryZj3WvPEY
         pPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QMJNh9Nps3lNaky/ZqkpkG5HL0wnEpY/JRWR1C3fWME=;
        b=cDVF1NwEfW7UxhlOIW971IdVEncwm019WK9MP+KZmdE/Q94LlXsF0bqitqshABn2MT
         T+1bKdjXIJJT+c1ZdC2nR0IG6LT/ck5kmp3ckxQVeJUsusnoIDTZ+kUuW3MyETIIUA+4
         SzosdPlcHafb2PJwStWzi2+xzwIp5YuYaOfk7RTdCSlToFkyMVPpMYNNBC0Wunod81go
         Ggmsfn/Bd22GF1Sdtdflljw5E0CMYLhfwt4/bbeDDJKvuxfm7rGZLncLTz5UAdToifry
         mjROGBh/RXcovdk1NJNjsZWGHB2oyuDCCEyRfL0Esx1zBGzcrGWVSkUMO2UB3072GrJ5
         chPA==
X-Gm-Message-State: AOUpUlFiYsQSSdsF+ld9hGtHrWJc/tBfQDO5VvJLXRWt0j+GwzjTv/WJ
        nrCgl7BwDSugmtX5CEb2aqlvFBjV
X-Google-Smtp-Source: AA+uWPzNtjP+66qC3doRON+BHa8/5Zfkl9SlVPeSqdPbAaMWj12V16jwkFTSG6Dn2xRQb8ic1ajqLQ==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr41023wmd.77.1533676395071;
        Tue, 07 Aug 2018 14:13:15 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:14 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/17] staging:rtl8192u: Rename Dot11d_Reset - Style
Date:   Tue,  7 Aug 2018 22:12:48 +0100
Message-Id: <20180807211255.29343-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function Dot11d_Reset causes a checkpatch issue due to its use of
CamelCase naming, so has been rename to dot11d_reset.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c            | 6 +++---
 drivers/staging/rtl8192u/ieee80211/dot11d.h            | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c                 | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index aef16794af76..d6baeec91669 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -20,7 +20,7 @@ void dot11d_init(struct ieee80211_device *ieee)
 EXPORT_SYMBOL(dot11d_init);
 
 /* Reset to the state as we are just entering a regulatory domain. */
-void Dot11d_Reset(struct ieee80211_device *ieee)
+void dot11d_reset(struct ieee80211_device *ieee)
 {
 	u32 i;
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
@@ -38,7 +38,7 @@ void Dot11d_Reset(struct ieee80211_device *ieee)
 	pDot11dInfo->country_ie_len = 0;
 	RESET_CIE_WATCHDOG(ieee);
 }
-EXPORT_SYMBOL(Dot11d_Reset);
+EXPORT_SYMBOL(dot11d_reset);
 
 /*
  * Update country IE from Beacon or Probe Resopnse and configure PHY for
@@ -127,7 +127,7 @@ void DOT11D_ScanComplete(struct ieee80211_device *dev)
 	case DOT11D_STATE_DONE:
 		if (GET_CIE_WATCHDOG(dev) == 0) {
 			/* Reset country IE if previous one is gone. */
-			Dot11d_Reset(dev);
+			dot11d_reset(dev);
 		}
 		break;
 	case DOT11D_STATE_NONE:
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 891cfd49abb9..a015234c94d7 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -50,7 +50,7 @@ struct rt_dot11d_info {
 #define UPDATE_CIE_WATCHDOG(ieee_dev) (++GET_CIE_WATCHDOG(ieee_dev))
 
 void dot11d_init(struct ieee80211_device *dev);
-void Dot11d_Reset(struct ieee80211_device *dev);
+void dot11d_reset(struct ieee80211_device *dev);
 void Dot11d_UpdateCountryIe(struct ieee80211_device *dev,
 			    u8 *pTaddr,
 			    u16 CoutryIeLen,
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 212cc9ccbb96..39ed743a1a56 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2357,7 +2357,7 @@ void ieee80211_disassociate(struct ieee80211_device *ieee)
 	if (ieee->data_hard_stop)
 		ieee->data_hard_stop(ieee->dev);
 	if (IS_DOT11D_ENABLE(ieee))
-		Dot11d_Reset(ieee);
+		dot11d_reset(ieee);
 	ieee->state = IEEE80211_NOLINK;
 	ieee->is_set_key = false;
 	ieee->link_change(ieee->dev);
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index f7b69fbbe5f3..beda0d4c290e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -212,7 +212,7 @@ static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
 		 * otherwise, it shall follow global domain settings.
 		 */
 		GET_DOT11D_INFO(ieee)->enabled = 0;
-		Dot11d_Reset(ieee);
+		dot11d_reset(ieee);
 		ieee->bGlobalDomain = true;
 		break;
 
-- 
2.18.0

