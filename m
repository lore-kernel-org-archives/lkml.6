Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF77BECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE0020882
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVhppJXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE0020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeGUUUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36099 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeGUUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so14175455wro.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F1zG/SIZWKGkL2iwN2jH1GH820pnEdT+C7PUS7qWW+8=;
        b=sVhppJXgiJ5hCIarPNOQz7h/GdMtzJf7o5nENy7RlK1kQjLh5nvtZ6e+cBAdMokxkb
         2xByw+kVge2TwAcAdiAf7lqjTjr9E3+YWRwDFc+itOXrIGUlSx5Pa7Q0MwS8jGeE3z2V
         qhq8Zs5PB0fCXSI+c6Dtfr7c9GewpI4PrYd7lhj4POHzUdRUCtQg4cA1vQONaYFjVbaX
         /n2xg4W/Z0r+jyuKQgKXfOk4ethswqjuXfNrpzCfGIXuQ0tsFhTmbnuwacMo9FFH2OLJ
         zmY3z8ep9ddCDb1ckrJfIMdEEAtBkn6pHAT5RA366VYQRqvNlxVxIsOgBZCGhhB5lINN
         Gu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F1zG/SIZWKGkL2iwN2jH1GH820pnEdT+C7PUS7qWW+8=;
        b=H88qlwJ78eAuiBoJ60PnxMCNvnT0iPBt3mV9dsTCgb3Rf6grc5LqQSmF++ihUlnF0/
         8NmMNp6BjM9Mn8MrHwEV9P0DKfRPZ1zz784uesOchnaC/klEthhSZa8ItcmG9juXG6as
         zCd0WItTJRlzAQSzy0y2+Q68vk5yvEtwR8L7XuY9bS9gn12jTeDZU0N7Rx4DDpiIupQF
         /60JTEuzmVlUvVLkEpgfFP1QYX2Z0fYyOTUBLYg0ULJoocbn8zoIMPr5LQHu9fAPm8ka
         v2RbHHJI7f+7SqQczlon6hPidxOsZZHIhb8T8A/VBWe8G2FxsF/YxlDJOwFeY4hpb5s6
         w+HQ==
X-Gm-Message-State: AOUpUlGHXEW54RxJwMSjdQcH7GhqZFhf8RYzwxZ3rmIYTa4h2PnC91Uq
        uooy524qgm42F3nSF2oIWaSU4N6v
X-Google-Smtp-Source: AAOMgpdCDN4r0un6RZzE00lk6RsE1ZIesZUvq4RsbcqSieTJ/8xQw2R+2RYoYs87BCtJL8XfJ1TMwA==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr4800721wra.90.1532201183978;
        Sat, 21 Jul 2018 12:26:23 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:23 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 04/10] staging:rtl8192u: Rename bEnabled > enabled - Style
Date:   Sat, 21 Jul 2018 20:25:46 +0100
Message-Id: <20180721192552.5378-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721192552.5378-1-johnfwhitmore@gmail.com>
References: <20180721192552.5378-1-johnfwhitmore@gmail.com>
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
index cf39c0bc2a26..c99923d467a7 100644
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

