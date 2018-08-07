Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDC6C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE8C2172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkQBiy0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE8C2172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHGX3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36620 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeHGX3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so80366wro.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I8COd9+JTFFavTcxiUs085VTH0W4jtC85bFOgAAis3U=;
        b=TkQBiy0sdIYNxP1xt0pb3IxouyvUPf4FvYax1WUa5/q5pjvLy9mGgYVnI0EsZbbZ60
         47WGsj+JXsB5j1avh/cEWGKJY5sbsk3T9UKtQlf7G65qBpyVC5pzRqqu427v4cMR7LvH
         04ANS/sIkK1D0cMPBC4aE2BBEgZB6UmPZ4jpjUmWgBiuELCYFkLtL67e2XUi55glOT+q
         Zs+yJZVBtOy3SAjamLLP38Eq3kr5w9mS+T4R4cGITa+ckIgysvCtb7EA2rMUZvvDmZOz
         khzsGRuN3xMDAd+tSPziWGO86dDJypw8GeE3yV4W+1jTkfY5Hy9yJcXdhl+Owjozp3AM
         5LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I8COd9+JTFFavTcxiUs085VTH0W4jtC85bFOgAAis3U=;
        b=EmJkdbMKmCcn81nRrEPmi3055A5zmO2bGJP5EhqqQ/KZE892zoE34FwOAUEgCcFMId
         KNxodLtURi+1s7tzK4JgXeZRdqgJR6ljDhyJUNw53VUKIhmj+7M9FN1tOyTUX+oJPqMg
         j71cJ/f2O5qgY5c9u5IbmvXlaA/b+KV56uK912bi7HL8zXZkviNTrG7lVli5hbO7ABFr
         ++GEsSOT304mVUSYrrt2P1RTJwKxbvqin1POJw62P2UmFIrMe1IFGYPvDglgQkoNMa8D
         VggDYv1JiwvIl0EQRoflu1SzlOdpg+KqVLDCqzM+6Gj9aa1IYNTMba6B5Xurhf+ohrDp
         LjUQ==
X-Gm-Message-State: AOUpUlF+bAatSRsOav6yzfP+5gU60Wde+8LiGBt0Pn0Cj5+FVqsAVSbm
        b3yGf+hElXBbcFSPRkL1a5zQWAJF
X-Google-Smtp-Source: AA+uWPyz15LnJyMYVaGt2mcE7tM8gVRh8EwrPFswkHgY0Sc9uxXSUfAdH2nvkl2eADKqCPQl8JSMfg==
X-Received: by 2002:adf:bd90:: with SMTP id l16-v6mr45558wrh.250.1533676396829;
        Tue, 07 Aug 2018 14:13:16 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:16 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/17] staging:rtl8192u: Rename Dot11d_UpdateCountryIe - Style
Date:   Tue,  7 Aug 2018 22:12:49 +0100
Message-Id: <20180807211255.29343-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function Dot11d_UpdateCountryIe causes a checkpatch issue due to
its use of CamelCase naming, the function has been renamed to
dot11d_update_country_ie.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c       | 8 ++++----
 drivers/staging/rtl8192u/ieee80211/dot11d.h       | 8 ++++----
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index d6baeec91669..6855b096d0fc 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -49,7 +49,7 @@ EXPORT_SYMBOL(dot11d_reset);
  * 1. IS_DOT11D_ENABLE() is TRUE.
  * 2. Input IE is an valid one.
  */
-void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
+void dot11d_update_country_ie(struct ieee80211_device *dev, u8 *pTaddr,
 			    u16 CoutryIeLen, u8 *pCoutryIe)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
@@ -66,14 +66,14 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 			/* It is not in a monotonically increasing order, so
 			 * stop processing.
 			 */
-			netdev_err(dev->dev, "Dot11d_UpdateCountryIe(): Invalid country IE, skip it........1\n");
+			netdev_err(dev->dev, "dot11d_update_country_ie(): Invalid country IE, skip it........1\n");
 			return;
 		}
 		if (MAX_CHANNEL_NUMBER < (pTriple->first_channel + pTriple->num_channels)) {
 			/* It is not a valid set of channel id, so stop
 			 * processing.
 			 */
-			netdev_err(dev->dev, "Dot11d_UpdateCountryIe(): Invalid country IE, skip it........2\n");
+			netdev_err(dev->dev, "dot11d_update_country_ie(): Invalid country IE, skip it........2\n");
 			return;
 		}
 
@@ -97,7 +97,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 	memcpy(pDot11dInfo->country_ie_buf, pCoutryIe, CoutryIeLen);
 	pDot11dInfo->state = DOT11D_STATE_LEARNED;
 }
-EXPORT_SYMBOL(Dot11d_UpdateCountryIe);
+EXPORT_SYMBOL(dot11d_update_country_ie);
 
 u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel)
 {
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index a015234c94d7..b065781601f1 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -51,10 +51,10 @@ struct rt_dot11d_info {
 
 void dot11d_init(struct ieee80211_device *dev);
 void dot11d_reset(struct ieee80211_device *dev);
-void Dot11d_UpdateCountryIe(struct ieee80211_device *dev,
-			    u8 *pTaddr,
-			    u16 CoutryIeLen,
-			    u8 *pCoutryIe);
+void dot11d_update_country_ie(struct ieee80211_device *dev,
+			      u8 *pTaddr,
+			      u16 CoutryIeLen,
+			      u8 *pCoutryIe);
 u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel);
 void DOT11D_ScanComplete(struct ieee80211_device *dev);
 int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 2f1886b4e977..2ceead4aebad 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1582,7 +1582,7 @@ static inline void ieee80211_extract_country_ie(
 
 			if (!IS_COUNTRY_IE_VALID(ieee))
 			{
-				Dot11d_UpdateCountryIe(ieee, addr2, info_element->len, info_element->data);
+				dot11d_update_country_ie(ieee, addr2, info_element->len, info_element->data);
 			}
 		}
 
-- 
2.18.0

