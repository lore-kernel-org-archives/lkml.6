Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64B4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0F020863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzZi8hkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0F020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeGUTvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:51:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50405 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbeGUTvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:51:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so12328807wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KesN/eiuv4Z6N0fsUXYdQH6TYoDOg16YlIXjmXhVg6k=;
        b=EzZi8hkQsquAbcrUX0BecE22cVgo4mHo/Xhh70h9Yvjm5gpHop/mSVi+lsRziXFXJk
         HdHQ+o0L+nokfk4Ixa3d/MZh7HTiyKy3T98+dgpxzqGSAb5BYvv9LNQY4XLq5JUdIxAk
         rfW+H6EJayAAtH3K4J7bkIYX2xP0M3vJEhuhuuLm3v7Z1DYDglrrK7NA5eJlS+CcjhHV
         +986VVrthnkP2cdmls6fMiRvR4/jcPXguDy/N4/LUqEfEjftljjbfJ+YsFcp3ULHvsMT
         a+9R7jQxdPJM/60mukuuY/TOgVV8fPgyG2aS8SyfKD+G1bouBqva8t2eDHZ/RjP4++Zo
         1SUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KesN/eiuv4Z6N0fsUXYdQH6TYoDOg16YlIXjmXhVg6k=;
        b=e87WQ8Uz3KNXj9eHjFs33C4ETN18umIej0RDuPln0EPTITWoy4wmGRUddkNlYXrdMd
         PJkS3SQ0lZ0VDfVsMPLwbRt1gHzC8UVld1jyCHzUlWu3IoJQgsBUt9XpDwFGE2mcoQuE
         ZcYCYdiB1NnL1VzulpsjA5VnRFJ7Pwr8icZv44nyUd+OR+x3dsRih/Cqjubp80egmXB7
         CpYAzB3BWI/x0Pb1Bvhz9s8795F/bbYbVM3aafVk9uLWHVsVQQrON/J/RNndaKyUgTQT
         e0j3GdLKB8U09/M15dFs/t1gjf7cuGq2rOQjlc9QFiWvyBkhjxWa5UbhJnvw4tF7dqEz
         Rmmw==
X-Gm-Message-State: AOUpUlFLF/dalrCk2uDvn0BRdiP/mKCVAE0jh//nVMNhEms9DTJVhX2X
        j3Yj6wiHSun+cm8xxXC2l9w=
X-Google-Smtp-Source: AAOMgpf/evIjaAfpAvvccCwgGXxpfnKxuDaQ/6v+eptyTm9or5lMEZJ9a3F9m5mrNar9bzfMmZhPSw==
X-Received: by 2002:a1c:6d9a:: with SMTP id b26-v6mr3870623wmi.74.1532199485825;
        Sat, 21 Jul 2018 11:58:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:34d9:1402:6a14:c45d])
        by smtp.gmail.com with ESMTPSA id w24-v6sm3657899wmc.15.2018.07.21.11.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:58:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: rtl8188eu: fix comparsions to true
Date:   Sat, 21 Jul 2018 20:57:39 +0200
Message-Id: <20180721185742.7496-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721185742.7496-1-straube.linux@gmail.com>
References: <20180721185742.7496-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(x) instead of if(x == true).

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 6 +++---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index d48840869307..9db19724f168 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -101,14 +101,14 @@ bool rtw_is_cckratesonly_included(u8 *rate)
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 {
 	if (channel > 14) {
-		if ((rtw_is_cckrates_included(rate)) == true)
+		if (rtw_is_cckrates_included(rate))
 			return WIRELESS_INVALID;
 		else
 			return WIRELESS_11A;
 	} else {  /*  could be pure B, pure G, or B/G */
-		if ((rtw_is_cckratesonly_included(rate)) == true)
+		if (rtw_is_cckratesonly_included(rate))
 			return WIRELESS_11B;
-		else if ((rtw_is_cckrates_included(rate)) == true)
+		else if (rtw_is_cckrates_included(rate))
 			return	WIRELESS_11BG;
 		else
 			return WIRELESS_11G;
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 8da43022bb40..221fae22bab6 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -642,12 +642,12 @@ static int rtw_wx_get_name(struct net_device *dev,
 
 		prates = &pcur_bss->SupportedRates;
 
-		if (rtw_is_cckratesonly_included((u8 *)prates) == true) {
+		if (rtw_is_cckratesonly_included((u8 *)prates)) {
 			if (ht_cap)
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bn");
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11b");
-		} else if ((rtw_is_cckrates_included((u8 *)prates)) == true) {
+		} else if (rtw_is_cckrates_included((u8 *)prates)) {
 			if (ht_cap)
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bgn");
 			else
-- 
2.18.0

