Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE71CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC73920856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/JLDQzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC73920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeGUUUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39462 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeGUUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so14136252wre.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=82BKWQ3tFaT2O3Tonzvppbm83zfrR2/8JGBTiZhgtZ0=;
        b=B/JLDQzw1WeJdfy82Jct87oVcTUa5Od4DIe0QVsAu6a67pqzPZM1fuWi22lUiSX24E
         2v4rdwjRFK12IHcq7NAApHBDTbDbPNWNSCpe6a53ttMMIxxPMtRwPHXUnzoQYvv7K6nw
         bxB+Gh8YHQcn8XHoMdqTA/r6Vq5w4Ft2ZVU+clnKaGckKW68XbKwD+07NR43kykXsPph
         J0MbNolOzFNpAMIaFMnH8FjY5yVZ7IhbjCKtE23MlA2IjQx8H1zqRx9F63BxwpcRWHwx
         aMJcMzZaRj2nKMtvugGL6h4LR2wWbP6XkLbRr6/zs7tLIQ0WRwC+FybIs1IxlBNCOheR
         kK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=82BKWQ3tFaT2O3Tonzvppbm83zfrR2/8JGBTiZhgtZ0=;
        b=PdLL/M3C2x7AeiwFMhp1X2ftrCvXSKyedPD0JDmEToLycLbCAgtoFf38irBvJpVcpN
         vV9ViR+6llOuhLWikx4rBVmTiOcKFntrrN8uGdOFTpHK3j7Hgy4Qt8JG4EcwJ3THVQ0V
         TItuuym2LA14wu9KrBz4t40JUWos6lH8jKIHGCSm7r1rvVmyoDXwZ0OVuTWjS4wzhw6/
         HNzCZa276S/XUZow/uKpG3JBtpogKbvwUBEbmFPj50Tru8Zqj5NqYRD3DK+C9hLwsLax
         tdmwL0su58X144ZdWWHyCD0rIUl0rmAlsSH3SVwOzsNMsv72g+OMIAc4VkAzo16/YOVo
         OLgA==
X-Gm-Message-State: AOUpUlHsluO2TH6ikmlu0AHc2hkFSD3C/KqI8xiGTP+eOfXJso7rlQ0y
        4df9Po3YKj5r0hwmC/yyJvMe7kIQ
X-Google-Smtp-Source: AAOMgpdBAqzPjnoXhuOGyxfFF2RiIwJ8HM3GpLwM4jk97dVmx61aJ0GFKNC1lHSokIIIwsIaR2ncaA==
X-Received: by 2002:adf:8385:: with SMTP id 5-v6mr4546815wre.13.1532201187593;
        Sat, 21 Jul 2018 12:26:27 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:26 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 06/10] staging:rtl8192u: Rename CountryIeBuf to country_ie_buf - Style
Date:   Sat, 21 Jul 2018 20:25:48 +0100
Message-Id: <20180721192552.5378-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721192552.5378-1-johnfwhitmore@gmail.com>
References: <20180721192552.5378-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable CountryIeBuf to country_ie_buf. This change clears
the checkpatch issue with CamelCase. The change is purely coding style and
should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 87af2ddae349..b1205345a7e0 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -94,7 +94,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 	UPDATE_CIE_SRC(dev, pTaddr);
 
 	pDot11dInfo->country_ie_len = CoutryIeLen;
-	memcpy(pDot11dInfo->CountryIeBuf, pCoutryIe, CoutryIeLen);
+	memcpy(pDot11dInfo->country_ie_buf, pCoutryIe, CoutryIeLen);
 	pDot11dInfo->State = DOT11D_STATE_LEARNED;
 }
 EXPORT_SYMBOL(Dot11d_UpdateCountryIe);
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index a15b21456101..109b82e69b5e 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -21,8 +21,8 @@ struct rt_dot11d_info {
 
 	bool enabled; /* dot11MultiDomainCapabilityEnabled */
 
-	u16 country_ie_len; /* > 0 if CountryIeBuf[] contains valid country information element. */
-	u8  CountryIeBuf[MAX_IE_LEN];
+	u16 country_ie_len; /* > 0 if country_ie_buf[] contains valid country information element. */
+	u8  country_ie_buf[MAX_IE_LEN];
 	u8  CountryIeSrcAddr[6]; /* Source AP of the country IE. */
 	u8  CountryIeWatchdog;
 
@@ -50,7 +50,7 @@ struct rt_dot11d_info {
 #define IS_COUNTRY_IE_CHANGED(__pIeeeDev, __Ie) \
 	(((__Ie).Length == 0 || (__Ie).Length != GET_DOT11D_INFO(__pIeeeDev)->country_ie_len) ? \
 	FALSE : \
-	(!memcmp(GET_DOT11D_INFO(__pIeeeDev)->CountryIeBuf, (__Ie).Octet, (__Ie).Length)))
+	(!memcmp(GET_DOT11D_INFO(__pIeeeDev)->country_ie_buf, (__Ie).Octet, (__Ie).Length)))
 
 #define CIE_WATCHDOG_TH 1
 #define GET_CIE_WATCHDOG(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->CountryIeWatchdog)
-- 
2.18.0

