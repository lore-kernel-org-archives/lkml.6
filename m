Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4533DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE032084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8jYF4/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE032084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeGTVMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:12:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37925 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731945AbeGTVML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:12:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so12341621wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wBkcpHEsygOVfK3SPXq4YWBCalRqJWRS9aTefI9eCgQ=;
        b=B8jYF4/VZvaR40RVBfXIRM96vjY8TLg9Hj8iHfqaEXqt0QbmCX/OyWdh6rkITkn98A
         9/CjLVLIrwNBtUeTVjCJaljOtzFsDobvzIOP/OYLPJZzbrXFArlxqe+DSaRQAq6ltRKz
         +EiVtFIerIQ9IX1xlerleDMRFPdUObUHChhRB8ImODi1LCKWHcK8sUB0WF20yPk6KkDd
         y0UHbFOdAP0UQZKx6ob+brFF1TgOvPmCLQEHqLuEFpfDAUUGwiegVBYPqhCJoWPO78WR
         upMiyQcyA1xSkJkfq6wI/l+HmBmHg7SaohojZMlodoyN6hUCDwISLbNHVn6Iq+vHmjXE
         AKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wBkcpHEsygOVfK3SPXq4YWBCalRqJWRS9aTefI9eCgQ=;
        b=e7Kf55Dq3Rm442I4jYEr/wpae8tju33sbbQhlEekvyn8KXzxmdFx/gOZbWJ6GiJJDV
         hdzBmo+41kVhKzSXqmFYg3JZ4lIdd8TAeZD/VG7EYkS9NaobZzDp7Wf3swLbBaHeaViJ
         zOG8FTeS2nl5VyTFdWGSdp9Qx9H+BlfEJmJCUGbAB3KYazrLg7mnD17lHvoXcIoJgEjd
         N2IiZB+sd8G+L5mYcx5KCS4emY0Fw8qOFCeTQ/VW0YMBeNOGwlVD1yy04N8D9e3UH0xN
         AjMixS0iXexGY4MyP3wvS+l9F6quk/6HZGI5EidySK7qRrY/xPfUa6qg6aWoPa9GhAnk
         8O3g==
X-Gm-Message-State: AOUpUlFL1Zzy7X8O6h+/uOvVppX9QdRfgRuYA2xVFQvk3ueWLp7fuGZk
        LD6L3an5Ofxix/jxgX+URBnOEYant4k=
X-Google-Smtp-Source: AAOMgpccbLVyi/Vh+1AaikCT7VJv+NCdJk7lYNzqVrLveV9qyTaiZkCsUaz/kFLwSn6X6N6zdAngOQ==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr2520134wrg.249.1532118138868;
        Fri, 20 Jul 2018 13:22:18 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:18 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/14] staging:rtl8192u: Rename variable State > state - Style
Date:   Fri, 20 Jul 2018 21:21:42 +0100
Message-Id: <20180720202142.26312-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable State to state, this clears the checkpatch issue
with CamelCase naming. The change is purely coding style and should
not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/dot11d.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 21912b2d728d..2fb575a2b6ab 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -9,7 +9,7 @@ void Dot11d_Init(struct ieee80211_device *ieee)
 
 	pDot11dInfo->enabled = false;
 
-	pDot11dInfo->State = DOT11D_STATE_NONE;
+	pDot11dInfo->state = DOT11D_STATE_NONE;
 	pDot11dInfo->country_ie_len = 0;
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
 	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
@@ -34,7 +34,7 @@ void Dot11d_Reset(struct ieee80211_device *ieee)
 	for (i = 12; i <= 14; i++)
 		(pDot11dInfo->channel_map)[i] = 2;
 
-	pDot11dInfo->State = DOT11D_STATE_NONE;
+	pDot11dInfo->state = DOT11D_STATE_NONE;
 	pDot11dInfo->country_ie_len = 0;
 	RESET_CIE_WATCHDOG(ieee);
 }
@@ -95,7 +95,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 
 	pDot11dInfo->country_ie_len = CoutryIeLen;
 	memcpy(pDot11dInfo->country_ie_buf, pCoutryIe, CoutryIeLen);
-	pDot11dInfo->State = DOT11D_STATE_LEARNED;
+	pDot11dInfo->state = DOT11D_STATE_LEARNED;
 }
 EXPORT_SYMBOL(Dot11d_UpdateCountryIe);
 
@@ -119,9 +119,9 @@ void DOT11D_ScanComplete(struct ieee80211_device *dev)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 
-	switch (pDot11dInfo->State) {
+	switch (pDot11dInfo->state) {
 	case DOT11D_STATE_LEARNED:
-		pDot11dInfo->State = DOT11D_STATE_DONE;
+		pDot11dInfo->state = DOT11D_STATE_DONE;
 		break;
 
 	case DOT11D_STATE_DONE:
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 0c7652a2ebb3..5639bb498865 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -29,7 +29,7 @@ struct rt_dot11d_info {
 	u8  channel_map[MAX_CHANNEL_NUMBER+1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
 	u8  max_tx_pwr_dbm_list[MAX_CHANNEL_NUMBER+1];
 
-	enum dot11d_state State;
+	enum dot11d_state state;
 };
 
 #define eqMacAddr(a, b)		(((a)[0] == (b)[0] &&		    \
-- 
2.18.0

