Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9011ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A252D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGg/TlVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A252D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbeGTVMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:12:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32853 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbeGTVME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:12:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so5044729wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nVHRYe7JDF7zGdtZrlhw5KESr2llmzT8lRJ+Mqg+3gQ=;
        b=XGg/TlVsShXolDiEgMphIBh8Tq1l2EwIeQx2WqACp1IzWJ4uBPVKsNQIWR4cvQSE9/
         p7owt2c34AVZSf3Pbpz1n+aRRTI+vsCye87ZM8121YdWx3L2kI0A/05/BMyfmaLjfPSg
         dFKzdo6+8WbheTDKSqrySi7yvDSSS3s06PjfBwOO2U0I5oDdfuEmhIbARnrZr8mdKxe+
         6NCxLEQagpfsheCEYdbsLrPQu7YTXtEaM3nDf14m6Yw19nvf53VC+QsJNFhlf7F6an6z
         hR7b034ycuIDM7/0igJG0novF/0UOpadVTA+rxztSK2Z6CoZX7n13G3/5PekSaT5BF22
         yIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nVHRYe7JDF7zGdtZrlhw5KESr2llmzT8lRJ+Mqg+3gQ=;
        b=odoLH99eozzNXS2q1CSlup1MCohsbNavWUS3DC17AOUlv9UDNSJXEcul6u2KsZPArS
         mkwt5bJli/NpGTy07owOYlIYqwxu4U85Z6xXZFxDSoIuxzchI0rP/4QLetlHd7x569GM
         3Jq3FxATewSaVSuHQXZHHYHFz2ucPp52scm5KNoyT2mBFueH7Pd7AdXwHDKfoQI+lAKA
         eJxSbQ2XDLB9qZWia5idtpo5KyhP9dxbwRjTOJHE//kW+cBLK6LH23yf0jfmpKoVKXei
         tfQaLAOlirFSJOLAR2DwdDyy0yliVARZ4k7mnHflYQ27yWVq/Fgg0fvgcbbaM/LgkxeA
         qISQ==
X-Gm-Message-State: AOUpUlHAOUOH6TGXiZW7Uhx31Z0dNvqRush1JXrGQeMjsfAEVN82xBvq
        9zHUj2MytX194EzMfAZCGlfBw9Prbs0=
X-Google-Smtp-Source: AAOMgpfi/kzPXrN1zSjw5EqkzKYeIZSx5zyb1B7TaDjYrqWqVIAoOCvF04jfsINC6YTDx1H+DAw/Mw==
X-Received: by 2002:a1c:d892:: with SMTP id p140-v6mr2522049wmg.76.1532118131180;
        Fri, 20 Jul 2018 13:22:11 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:10 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/14] staging:rtl8192u: Rename CountryIeLen > country_ie_len - Style
Date:   Fri, 20 Jul 2018 21:21:37 +0100
Message-Id: <20180720202142.26312-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
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

