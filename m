Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B07ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008FF20868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8nkRnEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008FF20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeGUUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39462 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeGUUUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so14136217wre.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nVHRYe7JDF7zGdtZrlhw5KESr2llmzT8lRJ+Mqg+3gQ=;
        b=H8nkRnElC1+J+7115FtX8EiC24DnWiiQwg5kberotLjds8ncu/qqL4ZX8/S7FbwiZv
         4v5jjNC6bOE9vUVO5HH6cTYT7eFFhogV33hpgyJt8eMc4wUME3LD+sVoTArC3CZVpsBS
         3pqXsKNcSxW3jchdvAe0HInU2Iii4iwnqqD18B3D9oY+Wnj706fILKn/IO63jgFaQXvw
         YtWycCxk1SVznMF8pBVPjNZ5GbxA0iC2rGCZtmClMW1GN8zc5fasIQMHhlh5zEza9xWP
         srLXiwsOuDBI+IewlXhcnOktcCUNg/IB4sR+2crLX9sTVABtlXHxRrYw1jz+RadLF5l6
         eYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nVHRYe7JDF7zGdtZrlhw5KESr2llmzT8lRJ+Mqg+3gQ=;
        b=XJVHozIF3ks1pnj7iBSImGtogui3fQxpJ+M/WCA6Lmhh42HlcjgS1sM/DjdLmS/YBE
         rqqEhHZmDrZnWOi4ZeeMFWK7kBodQ79J2WoIP+MmHmjfS5W4CPWzBnxLHGfXWTVas/NL
         CiuwVcMB9l+k8Mt1oXBypgzTP05P0JByptFgNbMW9nXTPm52OCPFSnWkIda5FWeACDQz
         0KVW8gCcPgTFKo+b78D3I6RooBTZC2h6NDL9QZORmKySfVP/rPFHiNs32hAOY5bNPl56
         6BHrFdU2Q6DV8xf1+k4+WR/IgSksuyYibO8QcgT7LEmb5rWPI1QBVX3yhBl4TY4Y5DXl
         eMHw==
X-Gm-Message-State: AOUpUlGapAY6qcJAedHA4Dprx86AkIwqT5xj1wLe46meMCr/XzkOCUxM
        UrteG4EMZR4gRWXMqH7y3PgJK/HU
X-Google-Smtp-Source: AAOMgpclGYGiVBwz5MBL4QxLTjwwMdDl2PgA7GQaqRXGPKdFQAc3UuIfKmucQ9tHi2PKLBBWa2FSJQ==
X-Received: by 2002:adf:96b2:: with SMTP id u47-v6mr4630792wrb.204.1532201185813;
        Sat, 21 Jul 2018 12:26:25 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:25 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 05/10] staging:rtl8192u: Rename CountryIeLen > country_ie_len - Style
Date:   Sat, 21 Jul 2018 20:25:47 +0100
Message-Id: <20180721192552.5378-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721192552.5378-1-johnfwhitmore@gmail.com>
References: <20180721192552.5378-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename CountryIeLen to country_ie_len, coding style change to clear
checkpatch issue with CamelCase naming. The change should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 3d2eb19a7f48..87af2ddae349 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -10,7 +10,7 @@ void Dot11d_Init(struct ieee80211_device *ieee)
 	pDot11dInfo->enabled = false;
 
 	pDot11dInfo->State = DOT11D_STATE_NONE;
-	pDot11dInfo->CountryIeLen = 0;
+	pDot11dInfo->country_ie_len = 0;
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
 	memset(pDot11dInfo->MaxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER+1);
 	RESET_CIE_WATCHDOG(ieee);
@@ -35,7 +35,7 @@ void Dot11d_Reset(struct ieee80211_device *ieee)
 		(pDot11dInfo->channel_map)[i] = 2;
 
 	pDot11dInfo->State = DOT11D_STATE_NONE;
-	pDot11dInfo->CountryIeLen = 0;
+	pDot11dInfo->country_ie_len = 0;
 	RESET_CIE_WATCHDOG(ieee);
 }
 EXPORT_SYMBOL(Dot11d_Reset);
@@ -93,7 +93,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 
 	UPDATE_CIE_SRC(dev, pTaddr);
 
-	pDot11dInfo->CountryIeLen = CoutryIeLen;
+	pDot11dInfo->country_ie_len = CoutryIeLen;
 	memcpy(pDot11dInfo->CountryIeBuf, pCoutryIe, CoutryIeLen);
 	pDot11dInfo->State = DOT11D_STATE_LEARNED;
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index cfe342d0b4bb..a15b21456101 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -21,7 +21,7 @@ struct rt_dot11d_info {
 
 	bool enabled; /* dot11MultiDomainCapabilityEnabled */
 
-	u16 CountryIeLen; /* > 0 if CountryIeBuf[] contains valid country information element. */
+	u16 country_ie_len; /* > 0 if CountryIeBuf[] contains valid country information element. */
 	u8  CountryIeBuf[MAX_IE_LEN];
 	u8  CountryIeSrcAddr[6]; /* Source AP of the country IE. */
 	u8  CountryIeWatchdog;
@@ -42,13 +42,13 @@ struct rt_dot11d_info {
 #define GET_DOT11D_INFO(__pIeeeDev) ((struct rt_dot11d_info *)((__pIeeeDev)->pDot11dInfo))
 
 #define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->enabled)
-#define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->CountryIeLen > 0)
+#define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_len > 0)
 
 #define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eqMacAddr(GET_DOT11D_INFO(__pIeeeDev)->CountryIeSrcAddr, __pTa)
 #define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->CountryIeSrcAddr, __pTa)
 
 #define IS_COUNTRY_IE_CHANGED(__pIeeeDev, __Ie) \
-	(((__Ie).Length == 0 || (__Ie).Length != GET_DOT11D_INFO(__pIeeeDev)->CountryIeLen) ? \
+	(((__Ie).Length == 0 || (__Ie).Length != GET_DOT11D_INFO(__pIeeeDev)->country_ie_len) ? \
 	FALSE : \
 	(!memcmp(GET_DOT11D_INFO(__pIeeeDev)->CountryIeBuf, (__Ie).Octet, (__Ie).Length)))
 
-- 
2.18.0

