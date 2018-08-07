Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673D9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CCF217B4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9dHyyUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CCF217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeHGX3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53432 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeHGX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so507137wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3YP1GDcjJZyBlQOEX4+iXC5UkYbTdfmqlJZflzhWVmk=;
        b=Y9dHyyUWEqvLNOvUgehYAFcmixZDbcbfgvu0hd3IdfmPEVYvmrD330lWnF3Ta+6Mqz
         Idq8ERnlF3bbb+rZdK6j34q5UWIO97jsRRa44GJsav4gkoFAUE9tcx9rIcwWQpq2Wq/+
         7Gg5MX4Ib61mO0xDlXOqmfvvjxecgFB6Ils+qoTTEskKUu/3uECIsuQpdyLWTm39XOvl
         BOXdq73DjItUTulByxrxYvKu79kXcU/vzVdS1OqTspZqRqweB+QoNOpcJzMTUDuLA/+x
         4QhBq5ReUl1BNvHmUF9TlR+2TCgc+/IgbLT94g73ymrM1yoXFjAOYhBFbQK21jr+jsby
         Ioag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3YP1GDcjJZyBlQOEX4+iXC5UkYbTdfmqlJZflzhWVmk=;
        b=WjKVzARQvz01opwRmoXzlEKNTtWLby0y+7UcUQI5xT4RAbAAxOI2do13ckHD2vTww7
         B5ESLYX+S3oX9ZXv7KxDoUXzHbMQxdVAemf3L1hYqQbRqVS6EM3qT5PFkXWQZnTF/QU6
         oV2ccv85nI5/TaD2DrHOe88M/2n6IBYm3jHjjDM3IWEYegT7dsLrIK25cjaUw5tvRbXx
         SsSOwjBnDM9XZFod5yOOliscthi2A/+wYhtwA0RvTy+HltDwtjF5MxKALEf0CH/dY9Fc
         amThGQD/T6kDPNeX8XvcpC+2zbV3BQPnF8bQY+GlwRbMPWNUrBcwYfQcXdB6+CReD/kw
         yfbg==
X-Gm-Message-State: AOUpUlHAsvamgcgqGsVazc7DQ5/t5QX1lDBlTBiSIhTPqTdhz2RvS0jW
        6D74GXD+1zfuXIob3yPlhI6zp7SI
X-Google-Smtp-Source: AA+uWPwxbAVVRggHNgVmFcsLybKaWFaEg6gupq8DFEZsYoE2/WBf8hy3UvPnME6NLbphzBAXE4CGcQ==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr41306wmd.77.1533676405320;
        Tue, 07 Aug 2018 14:13:25 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:24 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 16/17] staging:rtl8192u: Rename IsLegalChannel - Style
Date:   Tue,  7 Aug 2018 22:12:54 +0100
Message-Id: <20180807211255.29343-17-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function IsLegalChannel causes a checkpatch issue due to its use
of CamelCase naming. The function has been renamed to is_legal_channel.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c       | 8 ++++----
 drivers/staging/rtl8192u/ieee80211/dot11d.h       | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 6 +++---
 drivers/staging/rtl8192u/r819xU_phy.c             | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 48911c68b7a4..a116858d151c 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -136,19 +136,19 @@ void dot11d_scan_complete(struct ieee80211_device *dev)
 }
 EXPORT_SYMBOL(dot11d_scan_complete);
 
-int IsLegalChannel(struct ieee80211_device *dev, u8 channel)
+int is_legal_channel(struct ieee80211_device *dev, u8 channel)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 
 	if (channel > MAX_CHANNEL_NUMBER) {
-		netdev_err(dev->dev, "IsLegalChannel(): Invalid Channel\n");
+		netdev_err(dev->dev, "is_legal_channel(): Invalid Channel\n");
 		return 0;
 	}
 	if (pDot11dInfo->channel_map[channel] > 0)
 		return 1;
 	return 0;
 }
-EXPORT_SYMBOL(IsLegalChannel);
+EXPORT_SYMBOL(is_legal_channel);
 
 int ToLegalChannel(struct ieee80211_device *dev, u8 channel)
 {
@@ -164,7 +164,7 @@ int ToLegalChannel(struct ieee80211_device *dev, u8 channel)
 	}
 
 	if (channel > MAX_CHANNEL_NUMBER) {
-		netdev_err(dev->dev, "IsLegalChannel(): Invalid Channel\n");
+		netdev_err(dev->dev, "is_legal_channel(): Invalid Channel\n");
 		return default_chn;
 	}
 
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index d52ddad1cd42..e792aaa9995c 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -57,7 +57,7 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
 			      u8 *coutry_ie);
 u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 channel);
 void dot11d_scan_complete(struct ieee80211_device *dev);
-int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
+int is_legal_channel(struct ieee80211_device *dev, u8 channel);
 int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
 
 #endif /* #ifndef __INC_DOT11D_H */
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 2ceead4aebad..d6e56b823f83 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -2439,7 +2439,7 @@ static inline void ieee80211_process_probe_response(
 	//       then wireless adapter should do active scan from ch1~11 and
 	//       passive scan from ch12~14
 
-	if (!IsLegalChannel(ieee, network->channel))
+	if (!is_legal_channel(ieee, network->channel))
 		goto out;
 	if (ieee->bGlobalDomain)
 	{
@@ -2448,7 +2448,7 @@ static inline void ieee80211_process_probe_response(
 			// Case 1: Country code
 			if(IS_COUNTRY_IE_VALID(ieee) )
 			{
-				if (!IsLegalChannel(ieee, network->channel)) {
+				if (!is_legal_channel(ieee, network->channel)) {
 					printk("GetScanInfo(): For Country code, filter probe response at channel(%d).\n", network->channel);
 					goto out;
 				}
@@ -2469,7 +2469,7 @@ static inline void ieee80211_process_probe_response(
 			// Case 1: Country code
 			if(IS_COUNTRY_IE_VALID(ieee) )
 			{
-				if (!IsLegalChannel(ieee, network->channel)) {
+				if (!is_legal_channel(ieee, network->channel)) {
 					printk("GetScanInfo(): For Country code, filter beacon at channel(%d).\n",network->channel);
 					goto out;
 				}
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 7ee10d49894b..0a13a1f8a14d 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1271,7 +1271,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 
 	RT_TRACE(COMP_CH, "%s() stage: %d, step: %d, channel: %d\n",
 		 __func__, *stage, *step, channel);
-	if (!IsLegalChannel(priv->ieee80211, channel)) {
+	if (!is_legal_channel(priv->ieee80211, channel)) {
 		RT_TRACE(COMP_ERR, "set to illegal channel: %d\n", channel);
 		/* return true to tell upper caller function this channel
 		 * setting is finished! Or it will in while loop.
-- 
2.18.0

