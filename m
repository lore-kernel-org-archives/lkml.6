Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687E4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2614020661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXMs9cEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2614020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeGTVMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:12:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35762 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbeGTVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:12:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id y22-v6so10974332wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3L399++s4wqof9pPK+Kmyk6tWoB0JtAy92gs+04SyrA=;
        b=rXMs9cEUH4j8bLXtCPJCzH+OFDBxvI7vUtFs/CKwDCrpqJLR2Ko1V/yhaRHzaQIdZf
         aMoGQlnWCdh2bvEPQSYb+pBIHb7mwo4NfzgmybPWRm6z2141YQj08ecIU8Bmu9Gj4pgv
         f8FiCXjjym3qKG9iZyM+Y963Dp8GxpjFhH4kyf8peCdkmDG48CxLTf/piiRGVG9VXRu3
         gSQZPLyvyfWFMFOvOR0fRCHvhPsHobCzwe6cT+K4SQbWUyVoUs+4n5eKa1g3/Dag4kr0
         ThuoHxH1ovAUz2BF4c6aweMemmACfiG8uswP2A0IPKB0JELvhmp8drLLAUk+0z780E2o
         xw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3L399++s4wqof9pPK+Kmyk6tWoB0JtAy92gs+04SyrA=;
        b=Nlz5W3K2TDtAhBtcjLxH8uf+zB3osT2x45aUqfIM2XYJJ0VNL6aCr2m581OXJOEnGi
         eAei2xGIqjWmjbfRqwocWFENx6H8uj8jjpF+gZt/MoqsWu5RCUhfWG7+PTFoWA1+tyt5
         almYgg924u5d2osyohg/BRV/gMNZlNgEJaXVtpAuFLKTjpXNWXkU2kSA++H7MisXyYau
         OEnfdqbHbhgRSttgorPYBTr65vqWflRMXUQUY7Pouya27t4hQyPqg6LFqfMZSTW+EcPG
         u3GnW49JtfhktYyOUC3LlydNqBry1O42n07tbj2EsoycToyEZ6prUnX+D0V0gCUPDSRn
         vSYw==
X-Gm-Message-State: AOUpUlG07GLlncu+qFaDKGIgFNVhz9bQB06iu/lpfh+4yYIfmh5pd1pr
        lh+gPxK7FvZy+BLpcoGWvAsTysyxdw4=
X-Google-Smtp-Source: AAOMgpecW6ZGlZjzWsduJsOw6JY7skOJQJkjooCRA0zI+vySNHbSBaQ/+au3gc8pehRF+PFoVHiVMg==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr2498572wmo.84.1532118132699;
        Fri, 20 Jul 2018 13:22:12 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/14] staging:rtl8192u: Rename CountryIeBuf > country_ie_buf - Style
Date:   Fri, 20 Jul 2018 21:21:38 +0100
Message-Id: <20180720202142.26312-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable CountryIeBuf to country_ie_buf, this clears the
checkpatch issue with CamelCase naming. This change is a coding style
change which should not impact runtime code execution.

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

