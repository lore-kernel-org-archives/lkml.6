Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD0DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FE821A9A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIaCqx/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FE821A9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbeHHXXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:23:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33893 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731300AbeHHXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so1902031eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H+qsOUo+t/jQ3iT3ApXk9GP0gzEyYahSqxPEtl3EYW4=;
        b=LIaCqx/i2lQmN3ksTp+Y3tgy9/upIiuhY6G5oacGgUUaQCaYo7ouQxjqKm2P/RuVwC
         ah/XefegKNoxXYnNbDkJm2JRUonEwOhpTbAW6fhqykd9s6t3jyEMlj0MWCYNcL5dgFJh
         OKUootiZhaXAr3eOnqJIZZCDvHnlvTLIyZFrcA9VhW08Cmby2VhPOjxZmAMtETeshH0/
         GXxqOwUXHg5LR4/XdaiTNoaC0lMQgdl43DXo84ZBe7lwfuXtSEPEhQsybXtMI3dKKr1c
         23tSgS3KE0ysiIP1Cv+QQOFMUVZ9QDgrkfvxSEsT26QS4w8/C6qSIGk3Mb/Kdeu+cFJl
         Bz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H+qsOUo+t/jQ3iT3ApXk9GP0gzEyYahSqxPEtl3EYW4=;
        b=rX/tynpGp0RP6hBo8H4FCrCVxP/MDwt/lnvrES7CCaUm3q9H7mPFRI10tOj5Bp8SAJ
         xR+UibI6WJpKWuUrra6cu60Jr6NM8b0xkmJR25Y9UElvEwDqpmmm0z76XlBi6gi1jNCC
         uCDD+1xC6ZpM31+dKYs+Xvh+pwa0RJr4QyOotXl0HC3C2qaZL555VPR+ecmncYj015bN
         dJ7/TmweT0wD1S36iGan3YP33WAlFBQAWLDt1T1ARJ7G/PnzTOqc7dBFmTvSBMX7fJ9y
         KebEWvK1RhEckZvgcQ38J+1qcwUn3PbxEax/TmfWhoKpZn8t/0/DRfwE+pjxwoYPQTRp
         jDFA==
X-Gm-Message-State: AOUpUlG4T5DlMnF4Qwba3JuUOvr/lOgJPHJNEkyI45BH1l5jEvlrhLgz
        lShVfUinmfFiQaNqPvYO/AdMtytlQRI=
X-Google-Smtp-Source: AA+uWPwJGxX9fz9rkm0kP1haXNDsv16CmXotGIOZxMMiuA7c+glvdme66vRCNIZZgW4zWjvvCF+5iw==
X-Received: by 2002:a50:b8a6:: with SMTP id l35-v6mr5133999ede.273.1533762068450;
        Wed, 08 Aug 2018 14:01:08 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 09/15] staging:rtl8192u: Rename Dot11d_UpdateCountryIe - Style
Date:   Wed,  8 Aug 2018 22:00:30 +0100
Message-Id: <20180808210036.22580-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
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
index 73cf2e6aeb06..a45223171a55 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -45,10 +45,10 @@ struct rt_dot11d_info {
 
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
index 2c11d3ef63d7..787aefa4656e 100644
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

