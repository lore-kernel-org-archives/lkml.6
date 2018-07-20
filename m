Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521C8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B03920661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkinxG9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B03920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbeGTVMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:12:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35759 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbeGTVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:12:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id y22-v6so10974253wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uw5B6WuSA8Z5tarQK59R9iuWPxw2DZ0O8cTbIxg+xHg=;
        b=pkinxG9z2tBM6F0ju6UGFHHBSRFCykbqDubwnAouirepoqa1Le11DOPP89VTcYxk4M
         AZLQo2dvvZ+MFbj/JkMkFd+2nd4Y/czw7JFI+pBH4SGgwNwChgKzkXQCmRp/VNXzWGWz
         cA9XgOIEkRcFcsDZwWr3OOYKNeKIfk4vN3+ZEwD6vZbYA26nKXKmcwsQ2ufpVmBpK5f1
         KGVOmfuQHZl2Ha4+eQKOKh2GiMFm4cvDDN/0E/f+Nigh34q83bBqh7bi9JpmQcoAANAy
         AEGD45fJspmA95LGocEAj+J6LL+xpBDMfLfZCKzCXaBj2MUao5YSKatDk5dguxSp6tot
         hLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uw5B6WuSA8Z5tarQK59R9iuWPxw2DZ0O8cTbIxg+xHg=;
        b=lhZ4WW64h7KpbnrPchTIeA+v+5XCo8eFVgnGbhfBNhORL1X6pCtwgS1Yww2uEQVBia
         RSf91rNPh8IQ/FVMqyFc//2s0WiQZQJz6plZ+V11Ino+zOCmhZf0YuiWVU7DG0bRJ1d2
         RArAraGNg/AFZMbUREFbm8nN6WOwowNSMUp5cfbwxTxr0z2jDvuUuwDabr5TASCiAeGJ
         uoeVmAXXjcAWRSDWA0K2z2mFKvZtWHEVVU5fIWY5vtbRxEfclA/CpNys9KoCFDiyqGWY
         1ObCmAxPGllecgzr5hoQ7QBUZF9EaC2yW05jWz6shnbWpDbpxO5PJl8DxAJbZITQrqB7
         YRHw==
X-Gm-Message-State: AOUpUlEgNvvLKr7h/6OduOtFG4DfpyqMjW/mv94eW7c0MmiGHoTQUTxH
        2bLgqsvM4qxmoIJgVjI9QgUeijtbEBU=
X-Google-Smtp-Source: AAOMgpezw2ysPk/al0UmVgKQHZjWm6sVXRlJwk1gfbACpfzdIEXjO3u+cusZYKGcGhOkfa8B6Btn8g==
X-Received: by 2002:a1c:9616:: with SMTP id y22-v6mr2415307wmd.72.1532118129620;
        Fri, 20 Jul 2018 13:22:09 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/14] staging:rtl8192u: Rename bEnabled > enabled - Style
Date:   Fri, 20 Jul 2018 21:21:36 +0100
Message-Id: <20180720202142.26312-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable bEnabled to enabled. This change clears the
checkpatch issue with CamelCase. Purely a coding style change which should not
impact runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 4 ++--
 drivers/staging/rtl8192u/r8192U_core.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index cd63e158c7c8..3d2eb19a7f48 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -7,7 +7,7 @@ void Dot11d_Init(struct ieee80211_device *ieee)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
 
-	pDot11dInfo->bEnabled = false;
+	pDot11dInfo->enabled = false;
 
 	pDot11dInfo->State = DOT11D_STATE_NONE;
 	pDot11dInfo->CountryIeLen = 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 8f7426333da5..cfe342d0b4bb 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -19,7 +19,7 @@ enum dot11d_state {
 struct rt_dot11d_info {
 	/* DECLARE_RT_OBJECT(rt_dot11d_info); */
 
-	bool bEnabled; /* dot11MultiDomainCapabilityEnabled */
+	bool enabled; /* dot11MultiDomainCapabilityEnabled */
 
 	u16 CountryIeLen; /* > 0 if CountryIeBuf[] contains valid country information element. */
 	u8  CountryIeBuf[MAX_IE_LEN];
@@ -41,7 +41,7 @@ struct rt_dot11d_info {
 	(des)[5] = (src)[5])
 #define GET_DOT11D_INFO(__pIeeeDev) ((struct rt_dot11d_info *)((__pIeeeDev)->pDot11dInfo))
 
-#define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->bEnabled)
+#define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->enabled)
 #define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->CountryIeLen > 0)
 
 #define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eqMacAddr(GET_DOT11D_INFO(__pIeeeDev)->CountryIeSrcAddr, __pTa)
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 8b17400f6c13..038df372f4a8 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -211,7 +211,7 @@ static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
 		/* this flag enabled to follow 11d country IE setting,
 		 * otherwise, it shall follow global domain settings.
 		 */
-		GET_DOT11D_INFO(ieee)->bEnabled = 0;
+		GET_DOT11D_INFO(ieee)->enabled = 0;
 		Dot11d_Reset(ieee);
 		ieee->bGlobalDomain = true;
 		break;
-- 
2.18.0

