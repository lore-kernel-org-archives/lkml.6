Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B2C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6179B204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxbPZlUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6179B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeHUUkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:40:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51842 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeHUUgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so3678716wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wp0vvVl/+9SQFY3avUxFz5YNIvlro7B0ivirX7S1ZXY=;
        b=LxbPZlUZdIH91sNWSMAs6Zadia92su6t8QfBCfdVr7ghxgYaaKoUQ9AjijO2ci3kqv
         p8es+ig8R6RWGwwMbzjYEDhV3JR1pcwDvdTpW+rfyMxsn1lNl8IOudz6s6pJ2L7oG/97
         9r3oFceDHmIv6pYFNQH2nef7jqfRjdUsnz3fp1QsiMz8sjN34OP4CP6DvnjpUX35Wkhs
         ihTvmUbKtjxm/sBvR5saAZa/RM6fCvpBR36cP5BS9x7oAwzxZF0F0JEWZO22QpetSxeZ
         BZKxQ0jyW+iuKTBrW7IoHJ6ih4qGTzYg2046vJYsVYmcqlQ3lw7Ags8NGRdOXM5TFqwt
         FD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wp0vvVl/+9SQFY3avUxFz5YNIvlro7B0ivirX7S1ZXY=;
        b=lYHMoy2oXoDrYt1kzN0xWmWVyu+lElTkqMshSSPmDSNMLREw8SJjUCrTjn9K5WSPM+
         lv+xvft8jZy7H47CZ+ReApVhKZRRIeLb3C8Au2jGLVGfJyU9Zmb0xbtYc7OFYCqU23Ak
         C4tCEmjkZi/4vH506j2hHygF36C9M63nP4gZS/iUUlFT5Nn8VOQmqHhqGecFOZaNtII7
         iiDqQ4LJAjaLafQg6orY6gX35u2Kz3JpWkSZo2TeCTjZup8GM1rIL+XUpl4+0q6mUHlp
         RdRgA6iJWJMTtdDH9Vnnzbails6IECDS4nxbJkvt6vx8toIgH3t/NJxxUAAYB9HN9CME
         Vzbg==
X-Gm-Message-State: APzg51DdcE353U5162mudNRBmJAKhsMpt4xcTTytT3uxDlsIpc9oL9Qx
        7vEOlAIhu44u6POVP5VHoXtErgMbyls=
X-Google-Smtp-Source: ANB0VdY2TzVCIyyrGf9WdDPsRqnIDjqBGtdjlsmxznbdYMx57qdMgkP+r4prTRU5nGVpA0KsbTXrKw==
X-Received: by 2002:a1c:eb03:: with SMTP id j3-v6mr174359wmh.150.1534871752840;
        Tue, 21 Aug 2018 10:15:52 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:52 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/17] staging:rtl8192u: Refactor DELBA_PARAM_SET - Style
Date:   Tue, 21 Aug 2018 18:15:28 +0100
Message-Id: <20180821171537.9330-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef directive from union DELBA_PARAM_SET, to clear the
checkpatch issue with CamelCase naming.

Rename the union to lowercase to comply with the coding standard.

These changes are coding style changes which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h     | 4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 8beae1af63a1..10e81c3c0ff1 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -40,7 +40,7 @@ union ba_param_set {
 	} field;
 };
 
-typedef union _DELBA_PARAM_SET {
+union delba_param_set {
 	u8 charData[2];
 	u16 shortData;
 	struct {
@@ -48,7 +48,7 @@ typedef union _DELBA_PARAM_SET {
 		u16 Initiator:1;
 		u16 TID:4;
 	} field;
-} DELBA_PARAM_SET, *PDELBA_PARAM_SET;
+};
 
 typedef struct _BA_RECORD {
 	struct timer_list		Timer;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 42f458b4ece0..931123faf9ed 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -187,7 +187,7 @@ static struct sk_buff *ieee80211_DELBA(
 	u16			 ReasonCode
 	)
 {
-	DELBA_PARAM_SET	DelbaParamSet;
+	union delba_param_set	DelbaParamSet;
 	struct sk_buff *skb = NULL;
 	 struct rtl_80211_hdr_3addr *Delba = NULL;
 	u8 *tag = NULL;
@@ -543,7 +543,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 {
 	 struct rtl_80211_hdr_3addr *delba = NULL;
-	PDELBA_PARAM_SET	pDelBaParamSet = NULL;
+	union delba_param_set   *pDelBaParamSet = NULL;
 	u8			*dst = NULL;
 
 	if (skb->len < sizeof(struct rtl_80211_hdr_3addr) + 6) {
@@ -563,7 +563,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_BA, skb->data, skb->len);
 	delba = (struct rtl_80211_hdr_3addr *)skb->data;
 	dst = &delba->addr2[0];
-	pDelBaParamSet = (PDELBA_PARAM_SET)&delba->payload[2];
+	pDelBaParamSet = (union delba_param_set *)&delba->payload[2];
 
 	if (pDelBaParamSet->field.Initiator == 1) {
 		struct rx_ts_record *pRxTs;
-- 
2.18.0

