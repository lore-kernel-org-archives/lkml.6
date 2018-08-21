Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5BFC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85998217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwwJaa98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85998217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHUUgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:36:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35429 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeHUUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so675697wre.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ZFQFl7xu4LoRl39V021ODPKhREB5+IqPxFY2+9Ytso=;
        b=uwwJaa98ysjTw9+TNNmndBbIc68P7tzVGDbSbnFEnXlNhZ+2ngIVcP8SIkcd9B5Unl
         nlbGJEj+55JJaVRgnurJOLcGNNSxZeaimxwZCaIjhxtKzhxi2Ga2SMyeesRsGugfijKp
         GClJ2SSkzunguH6Pzb0VTjb30etvZLYcdjgimY/KN+wyb8e7uOoajnI8F/ln3YSfjwym
         Ux7A6lqGb4LocxFlFy/NeB0CVR4vW06cpW5B1xYPEJXa+LNb5iaiJjFL0JW1LE+wIYGn
         Gv5CkUb1y8ZVAQzJbj1Qj+7NgdFSZtO39jKoW5jzdHXuWKsh8GkcZAecsaSawStxsSGb
         uNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ZFQFl7xu4LoRl39V021ODPKhREB5+IqPxFY2+9Ytso=;
        b=qGfChBa5uThYIuIdagZI2I0Zy8SozLGt5g0baVYMCAgnVtxSSQhtILBmNzWxeNjHdk
         wwAXJYuyqZAp7ctwLnkkmPfN7qwHKC79TjVGW5dDebeqFCG0v3InAR4oeO3fw1fNrYgq
         YKf529ni09bHrJdazKE04Z4g/W4XYzpZU5aulqv6DIrFGtqFp/X6RbYptoEoiKuTYcU5
         jjmohnn/FfvQSL+Z4hvaQEDf+snvDwn/WIDsXiLvSJl6o4VoVFUL7TiGPit6MNBh2aiy
         /OWT4UvLtU8Y4FVjlo4sIMpOKu43SUCcxe41L6vowd8eozrG7S3iJeMUVRkT+fu5KO5K
         PAEw==
X-Gm-Message-State: AOUpUlH/DyS8wWrJnR+EsRjmSfKe2iYxVYJZKRSBFBftl9Ua84BV6xqe
        5l3r4LSFW+EfzzZDq4tC2rSDr1d35iY=
X-Google-Smtp-Source: AA+uWPzrjif4jPK01rNHkRu8kb1AY4cOMuM6cJiaqGVXSASbfgd2a6eL2bd698hPmqvHGyKfOdRjEA==
X-Received: by 2002:a5d:5088:: with SMTP id a8-v6mr31382164wrt.37.1534871748353;
        Tue, 21 Aug 2018 10:15:48 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:47 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/17] staging:rtl8192u: Refactor BA_PARAM_SET - Style
Date:   Tue, 21 Aug 2018 18:15:25 +0100
Message-Id: <20180821171537.9330-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the union BA_PARAM_SET, firstly removing the 'typedef', this
clears the checkpatch issue with defining new types. Secondly the union
is renamed to lowercase to comply with the coding standard.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h     | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 6bbabd9e6562..44f820404347 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -30,7 +30,7 @@ union sequence_control {
 	} field;
 };
 
-typedef union _BA_PARAM_SET {
+union ba_param_set {
 	u8 charData[2];
 	u16 shortData;
 	struct {
@@ -39,7 +39,7 @@ typedef union _BA_PARAM_SET {
 		u16 TID:4;
 		u16 BufferSize:10;
 	} field;
-} BA_PARAM_SET, *PBA_PARAM_SET;
+};
 
 typedef union _DELBA_PARAM_SET {
 	u8 charData[2];
@@ -55,7 +55,7 @@ typedef struct _BA_RECORD {
 	struct timer_list		Timer;
 	u8				bValid;
 	u8				DialogToken;
-	BA_PARAM_SET		BaParamSet;
+	union ba_param_set		BaParamSet;
 	u16				BaTimeoutValue;
 	union sequence_control	BaStartSeqCtrl;
 } BA_RECORD, *PBA_RECORD;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 643fd891f476..469e3e9a0d2e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -322,7 +322,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	u16 rc = 0;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
 	PBA_RECORD pBA = NULL;
-	PBA_PARAM_SET	pBaParamSet = NULL;
+	union ba_param_set     *pBaParamSet = NULL;
 	u16 *pBaTimeoutVal = NULL;
 	union sequence_control *pBaStartSeqCtrl = NULL;
 	struct rx_ts_record  *pTS = NULL;
@@ -342,7 +342,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	dst = &req->addr2[0];
 	tag += sizeof(struct rtl_80211_hdr_3addr);
 	pDialogToken = tag + 2;  //category+action
-	pBaParamSet = (PBA_PARAM_SET)(tag + 3);   //+DialogToken
+	pBaParamSet = (union ba_param_set *)(tag + 3);   //+DialogToken
 	pBaTimeoutVal = (u16 *)(tag + 5);
 	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
 
@@ -423,7 +423,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 	struct tx_ts_record     *pTS = NULL;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
 	u16 *pStatusCode = NULL, *pBaTimeoutVal = NULL;
-	PBA_PARAM_SET		pBaParamSet = NULL;
+	union ba_param_set       *pBaParamSet = NULL;
 	u16			ReasonCode;
 
 	if (skb->len < sizeof(struct rtl_80211_hdr_3addr) + 9) {
@@ -439,7 +439,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 	tag += sizeof(struct rtl_80211_hdr_3addr);
 	pDialogToken = tag + 2;
 	pStatusCode = (u16 *)(tag + 3);
-	pBaParamSet = (PBA_PARAM_SET)(tag + 5);
+	pBaParamSet = (union ba_param_set *)(tag + 5);
 	pBaTimeoutVal = (u16 *)(tag + 7);
 
 	// Check the capability
-- 
2.18.0

