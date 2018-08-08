Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CDBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B2D21A9A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqn4GEXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B2D21A9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbeHHXWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40869 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732106AbeHHXWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so1890624edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=41UFIzTqgRoRdMIK+qXTiXEHBQ2aNOj7qVPvNXynBKQ=;
        b=oqn4GEXtklVooDwFvhH38IRbAegbVYeUSA1HW4icfVqWaE011cL+cc2rGtudxHKX9t
         8yoHC4aRTDkjD4P0NyZ4RVWUPorECCU9F+w7Fd2PODnjcDyM4xnQLIKluaD1S5oLWkPh
         KfmK/iuC/krRtvw99q4sGyphSF0r7+LjVpcap/eZsBAxZ6nFA/ETUHMl2mBtwOgmzH7f
         CQsKPRDY6tZNPEKfUq7nll7AV71LGQWSuC8rKFULTNE/KIVeJQRZvzIH1B060hQ6UMBL
         j6OlVVzM5aN3vRYc8sDLloMmtGjADf4Oumyo9u7F5zLnU8NJc4hQs/NxX3Ce+QsSgaX5
         6lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=41UFIzTqgRoRdMIK+qXTiXEHBQ2aNOj7qVPvNXynBKQ=;
        b=bVoJYsY+MQBlpg1DrIMr+xAGX6mCfvaBkxzLWjHGkIRR6bsmqyTRCE448CMOQf+B2D
         pjnt1KBMsf05pm4Shido8cL4EsAU6EG5QC31sItwyblXAgLaurQHSShMageQ6dS0Brf3
         jFtc/Bd4NDQo2zmJIUKwM7Qw32FOlGOr962W+RaFt9BlnsOZBKfkBkGQeVhJMOMYW2jA
         jgde3RPmPLOGoBx0OHNViXiA1r5pYwdBGdgVI4KVH6/bOIwyhoeZh9dIGI6luCr0942T
         JJNozB/UIz78zTS07qUw8/Y162KVdrmx/CO+tnlUe8Wu+TlBzEdx0Cbhxx56LiOMjf0S
         CsVQ==
X-Gm-Message-State: AOUpUlHdDrmCM5RNv8gMuLDJfGTy57qAsxlh1BG13lNUD77qZ7VqAwKV
        Jn9tSo4GKLkJ1z2JEU5xOw50mWM8TrM=
X-Google-Smtp-Source: AA+uWPwsc0Ki4R9h0FEWLuYAnbArYaCqmnjZjuLr2jw8FbgXC5bbHpIJblWaVgMrHKjfjL50YiVydw==
X-Received: by 2002:a50:8d19:: with SMTP id s25-v6mr4867547eds.238.1533762071204;
        Wed, 08 Aug 2018 14:01:11 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:10 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 11/15] staging:rtl8192u: Rename DOT11D_GetMaxTxPwrInDbm -  Style
Date:   Wed,  8 Aug 2018 22:00:32 +0100
Message-Id: <20180808210036.22580-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
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
index ff18ad26ea0d..cbf93cd27f45 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -49,7 +49,7 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
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

