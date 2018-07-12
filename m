Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34689C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E57213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyRblyHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E57213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeGLKpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:45:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37669 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeGLKp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:45:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22-v6so21500552edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nwf0luCR0SjaQi0u0T+feUPNCrTDEEd/4EZlBhx2AMg=;
        b=nyRblyHpaXxbaqlP01JZyQMC888dtWC9liVZ8lNegC0P/XBt/riDY3Djn7zFkCr52K
         5/KAZl8zYTkGAuzYBkev3PPAZ2l+1PzyBdgoig0x7uUu7WFNrXVgX01Y/awRLAERBf5F
         zJdEN0lHvoSmx6wE3/l2VBxLCyePk2ZRvTccKmLMBFoJPIufoeKAnykPxBj25podMqMu
         J4skE7RH8saTf07hygUpntB3Ck2alXSXmnuGfeKgGKJvEGDwTLtwGV+nOl23LMQ58LLW
         IdMzWAUqZaUOMjQp+SKNT3Lw5JoaS0g6ckRMVHH59x7EIuW33puMmzyXH/AgimWiMZM1
         bxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nwf0luCR0SjaQi0u0T+feUPNCrTDEEd/4EZlBhx2AMg=;
        b=kDb7ggkMyLKZVeipASA3RKq0Fu+Q6u4YySmIEI7aS36odQolcVWUApSxe3pJdSe16G
         C/l1FSSFEmNzw0ISv95BEoh8MPJ0DeaJgHZFILKX1R1A0AnvgQuPaJXgFLiHhL/8mUW2
         975nLwgr60YzNma7LEg+mDfnRsOpHqWXPOmYV82yTOqNmANTTUJg8AgTj8QDJC8gj/nW
         HxObIreheX7vcD+MVu3WBNXLvKSYOdYqadeuiOkdFBxAnUMW9ozUzNTSdBx2aV/LssLH
         qjlvzAweJvNeyxyApKs1Xke7mLheEXgrtrbr3LOXCZUvCzwmowfdGczb+5g4XBugHdqV
         2/Wg==
X-Gm-Message-State: AOUpUlEiLI2Snqik5IHNu7JGH+Z/XxOIkYOxtGKtda/eLwH/LE7MHbry
        RAaDvIegEAS3vMhI1XK2UFA=
X-Google-Smtp-Source: AAOMgpdm1eDrVKZ3tjzXulmFoA/gqKX6xqTIXnYUiVuO+qpnRjQmn5/FA8FSpGCTaFN51UaJWIzi4Q==
X-Received: by 2002:a50:b3c8:: with SMTP id t8-v6mr1964360edd.95.1531391790827;
        Thu, 12 Jul 2018 03:36:30 -0700 (PDT)
Received: from arch.localdomain (x4d0a32b7.dyn.telefonica.de. [77.10.50.183])
        by smtp.gmail.com with ESMTPSA id r11-v6sm3661567edh.32.2018.07.12.03.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 03:36:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: rtl8723bs: fix comparsions to true
Date:   Thu, 12 Jul 2018 12:36:10 +0200
Message-Id: <20180712103610.19532-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712103610.19532-1-straube.linux@gmail.com>
References: <20180712103610.19532-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(x) instead of if(x == true).

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  6 ++--
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 28 +++++++++----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 62718045f3cc..33f2649ba2ec 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -95,14 +95,14 @@ bool rtw_is_cckratesonly_included(u8 *rate)
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 {
 	if (channel > 14) {
-		if ((rtw_is_cckrates_included(rate)) == true)
+		if (rtw_is_cckrates_included(rate))
 			return WIRELESS_INVALID;
 		else
 			return WIRELESS_11A;
 	} else{ /*  could be pure B, pure G, or B/G */
-		if ((rtw_is_cckratesonly_included(rate)) == true)
+		if (rtw_is_cckratesonly_included(rate))
 			return WIRELESS_11B;
-		else if ((rtw_is_cckrates_included(rate)) == true)
+		else if (rtw_is_cckrates_included(rate))
 			return	WIRELESS_11BG;
 		else
 			return WIRELESS_11G;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 63b79a7eaccf..c38298d960ff 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -126,26 +126,26 @@ static char *translate_scan(struct adapter *padapter,
 
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
-	if ((rtw_is_cckratesonly_included((u8 *)&pnetwork->network.SupportedRates)) == true) {
-		if (ht_cap == true)
+	if (rtw_is_cckratesonly_included((u8 *)&pnetwork->network.SupportedRates)) {
+		if (ht_cap)
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bn");
 		else
 		snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11b");
-	} else if ((rtw_is_cckrates_included((u8 *)&pnetwork->network.SupportedRates)) == true) {
-		if (ht_cap == true)
+	} else if (rtw_is_cckrates_included((u8 *)&pnetwork->network.SupportedRates)) {
+		if (ht_cap)
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bgn");
 		else
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
 	} else {
 		if (pnetwork->network.Configuration.DSConfig > 14) {
-			if (vht_cap == true)
+			if (vht_cap)
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11AC");
-			else if (ht_cap == true)
+			else if (ht_cap)
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11an");
 			else
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11a");
 		} else {
-			if (ht_cap == true)
+			if (ht_cap)
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
 			else
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11g");
@@ -785,26 +785,26 @@ static int rtw_wx_get_name(struct net_device *dev,
 
 		prates = &pcur_bss->SupportedRates;
 
-		if (rtw_is_cckratesonly_included((u8 *)prates) == true) {
-			if (ht_cap == true)
+		if (rtw_is_cckratesonly_included((u8 *)prates)) {
+			if (ht_cap)
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bn");
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11b");
-		} else if ((rtw_is_cckrates_included((u8 *)prates)) == true) {
-			if (ht_cap == true)
+		} else if (rtw_is_cckrates_included((u8 *)prates)) {
+			if (ht_cap)
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bgn");
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
 		} else {
 			if (pcur_bss->Configuration.DSConfig > 14) {
-				if (vht_cap == true)
+				if (vht_cap)
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11AC");
-				else if (ht_cap == true)
+				else if (ht_cap)
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11an");
 				else
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11a");
 			} else {
-				if (ht_cap == true)
+				if (ht_cap)
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
 				else
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g");
-- 
2.18.0

