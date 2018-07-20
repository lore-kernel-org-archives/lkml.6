Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DBDECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923D220661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCE0yHt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923D220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeGTVLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:11:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55937 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbeGTVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:11:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so10555555wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eI2A7GKKUKKDBks0BJNzX7OPxvhrHXIDpp3s+mL+y48=;
        b=YCE0yHt5H40qKTEi8hXPE7EEX3GvXdBByvGu8mFnTOzIQH3DXZo4QDPH+FoE2dtsQ2
         6TxXfynWheC35xNYhEJGFHRWlZfSIN8Dm0W5X7mDjvkfs5dEPoBdbyR723TizWk5DtYu
         OP5DZPzLG+142ipHoIced8oISjUBIV7iPAUonCIBt3dkJnhkzSDtJEc86bPSgfaByfex
         JllT7Wi5OhAI9om2vjiGGtk3sI8vZqrMdYB/HgPv3cPeTsJFLYLuyFT+Nk/xvtsqtu27
         87WPsLwwFAAo4CvwVqweMWy1frBd0f8M5UyFw/GoVfRWP1k/5DD0S9ObwdivZk8s2liC
         hYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eI2A7GKKUKKDBks0BJNzX7OPxvhrHXIDpp3s+mL+y48=;
        b=s7hMhAR1VZotBzAZ6FxPFyxPNZNbRc/G2tk+uOZPXkTP3BJVaW7jcJM2wyQh/b1wW1
         l+qyAofXUNqnOQhEYtiBssDtsuHDyl/HCULtk1CUedxrLNU4xjDBJ5tPOpZCOdRpGIQa
         RZeQgsVJjl07LkiWjluxPCQJn54SZ1h9SsfcGaVksDQ6kcnl7OhaSw8jOdssZ6hQ4+t0
         np5BU770MCaC3LllfhBfguMOBE+GY1iUGOCQeL4/vSjy5hSk5SK0K1NBiL+okWg20ZVU
         gC8tsUmRQPiyaVLEcgyloj7FFjfVTtv77JPF1noCdJ20nyUBR4ynowE01y6t4F0QKWH7
         /2+w==
X-Gm-Message-State: AOUpUlHE7Fd62HVsYnLsNLgQPmyWKc69xDhANOSrk0NR4Ozv4HGmed1l
        wC6+qt7PAZn9mOsBBO1TVWYXYo3vun0=
X-Google-Smtp-Source: AAOMgpeSULUv9Profili7KK0mnGkgH6QOIUxCK3rk4evTOeIuV58YKS/Cxamdt177TTvO7zyb43mJw==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr2205458wmf.1.1532118121504;
        Fri, 20 Jul 2018 13:22:01 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/14] staging:rtl8192u: Rename structure member FirstChnl - Style
Date:   Fri, 20 Jul 2018 21:21:31 +0100
Message-Id: <20180720202142.26312-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename structure member FirstChnl to first_channel. This coding style change
clears a checkpatch issue with CamelCase naming. This change should not impact
the runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/dot11d.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 8ac08ee5256e..f24dae97bc0d 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -62,14 +62,14 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 	NumTriples = (CoutryIeLen - 3) / 3; /* skip 3-byte country string. */
 	pTriple = (struct chnl_txpower_triple *)(pCoutryIe + 3);
 	for (i = 0; i < NumTriples; i++) {
-		if (MaxChnlNum >= pTriple->FirstChnl) {
+		if (MaxChnlNum >= pTriple->first_channel) {
 			/* It is not in a monotonically increasing order, so
 			 * stop processing.
 			 */
 			netdev_err(dev->dev, "Dot11d_UpdateCountryIe(): Invalid country IE, skip it........1\n");
 			return;
 		}
-		if (MAX_CHANNEL_NUMBER < (pTriple->FirstChnl + pTriple->NumChnls)) {
+		if (MAX_CHANNEL_NUMBER < (pTriple->first_channel + pTriple->NumChnls)) {
 			/* It is not a valid set of channel id, so stop
 			 * processing.
 			 */
@@ -78,9 +78,9 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 		}
 
 		for (j = 0; j < pTriple->NumChnls; j++) {
-			pDot11dInfo->channel_map[pTriple->FirstChnl + j] = 1;
-			pDot11dInfo->MaxTxPwrDbmList[pTriple->FirstChnl + j] = pTriple->MaxTxPowerInDbm;
-			MaxChnlNum = pTriple->FirstChnl + j;
+			pDot11dInfo->channel_map[pTriple->first_channel + j] = 1;
+			pDot11dInfo->MaxTxPwrDbmList[pTriple->first_channel + j] = pTriple->MaxTxPowerInDbm;
+			MaxChnlNum = pTriple->first_channel + j;
 		}
 
 		pTriple = (struct chnl_txpower_triple *)((u8 *)pTriple + 3);
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 9471279cf8e6..968c622137df 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -5,7 +5,7 @@
 #include "ieee80211.h"
 
 struct chnl_txpower_triple {
-	u8 FirstChnl;
+	u8  first_channel;
 	u8  NumChnls;
 	u8  MaxTxPowerInDbm;
 };
-- 
2.18.0

