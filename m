Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611DAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F48217BF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHiGUcNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F48217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeHUUg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:36:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45737 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHUUg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so10536543wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmRyjblLoKPklHXWzh8kvQ95VHb0ecWwjqmdXo5UaQg=;
        b=pHiGUcNgYoAQqHlxSVIpZH4mRpXTiwarTFZj0EVTNZ+50+65c/OSU8KiSQ00e4I+b/
         PUi/kP9mDT6nlJqkRvip8iMLqWm4IrDc2W7KVPCgluWidyfuwGV/i/YGhGtM33MnKup/
         yFn9Ttf656070fc+UnFOAskmoy8Pj/ZZl4bE4YsnBEh3QWh9xhrCj8mXl2wHNysPDUWx
         zMrBwLWSL58cqLwP2aidzAnZR05WCAyEqOhJQy2ACviQlAK0qcaMEELvBkH+PTDk18wc
         Kg3afgGXuKqe6kfHFXTysmdisQeLFIrk8WhpL+OdxQ2024n/wM3AaAoWntdEcZJTZXlA
         /06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmRyjblLoKPklHXWzh8kvQ95VHb0ecWwjqmdXo5UaQg=;
        b=Utx5mp5udfLjnAW3asXeOTI8CuQuTzBhMWVmF/Z02jN9o76cKT/dUMkIQKWngpH1J1
         tIhvcrCRBkkT7achRMYhA/1wxj/5Oa+fEFQSIETJVTKnOSoqErwZwYt6wWT242Kqt0ys
         p6Jc+Yd+sqpGsYhErDzNyKEOP7GzQqLD3YvveW14n22ViDtwLXqv7n//ci3iS/F8k5nC
         2VFP0RWtMLDotJDWCUW7gq7OFOZygVZmfPBwY/VNoNlgP83/NFPgyUIrStS6uDSgXfGp
         xDXg2lXdGBkHLwjWb+R49ETy2ye1okQUEtaOeGVRMXLHlGtCrbTfr205v1mQPJPsTqs/
         XsxQ==
X-Gm-Message-State: APzg51BT4wpkUQJip+6bjJi3DF3cFzvlXV5e+lOpoOI0f0wAdvom6P6Z
        mccXOMvRGzyTyN7TIkkYx718yn4T+4M=
X-Google-Smtp-Source: ANB0VdbsSOVF4TfFhsGvZ96AwyG3oePjXAm1rYKLB8qNpLqqfusFzKuR5YfBbWnrnbR1IulCwuM+0g==
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr8847359wra.100.1534871754456;
        Tue, 21 Aug 2018 10:15:54 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:53 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/17] staging:rtl8192u: Refactor union delba_param_set - Style
Date:   Tue, 21 Aug 2018 18:15:29 +0100
Message-Id: <20180821171537.9330-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove member 'charData' from the union delba_param_set, as it is not
used in code. The remaining member variables have all been renamed to
clear the checkpatch issue with CamelCase naming.

shortData  to short_data
Reserved   to reserved
Initiator  to initiator
TID        to tid

These changes are all coding style changes which should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h     |  9 ++++-----
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 12 ++++++------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 10e81c3c0ff1..008fe722af03 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -41,12 +41,11 @@ union ba_param_set {
 };
 
 union delba_param_set {
-	u8 charData[2];
-	u16 shortData;
+	u16 short_data;
 	struct {
-		u16 Reserved:11;
-		u16 Initiator:1;
-		u16 TID:4;
+		u16 reserved:11;
+		u16 initiator:1;
+		u16 tid:4;
 	} field;
 };
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 931123faf9ed..e504d1eb2ccf 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -201,8 +201,8 @@ static struct sk_buff *ieee80211_DELBA(
 
 	memset(&DelbaParamSet, 0, 2);
 
-	DelbaParamSet.field.Initiator	= (TxRxSelect == TX_DIR) ? 1 : 0;
-	DelbaParamSet.field.TID	= pBA->BaParamSet.field.tid;
+	DelbaParamSet.field.initiator	= (TxRxSelect == TX_DIR) ? 1 : 0;
+	DelbaParamSet.field.tid	= pBA->BaParamSet.field.tid;
 
 	skb = dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); //need to add something others? FIXME
 	if (!skb) {
@@ -226,7 +226,7 @@ static struct sk_buff *ieee80211_DELBA(
 
 	// DELBA Parameter Set
 
-	put_unaligned_le16(DelbaParamSet.shortData, tag);
+	put_unaligned_le16(DelbaParamSet.short_data, tag);
 	tag += 2;
 	// Reason Code
 
@@ -565,14 +565,14 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 	dst = &delba->addr2[0];
 	pDelBaParamSet = (union delba_param_set *)&delba->payload[2];
 
-	if (pDelBaParamSet->field.Initiator == 1) {
+	if (pDelBaParamSet->field.initiator == 1) {
 		struct rx_ts_record *pRxTs;
 
 		if (!GetTs(
 				ieee,
 				(struct ts_common_info **)&pRxTs,
 				dst,
-				(u8)pDelBaParamSet->field.TID,
+				(u8)pDelBaParamSet->field.tid,
 				RX_DIR,
 				false)) {
 			IEEE80211_DEBUG(IEEE80211_DL_ERR,  "can't get TS for RXTS in %s()\n", __func__);
@@ -587,7 +587,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 			ieee,
 			(struct ts_common_info **)&pTxTs,
 			dst,
-			(u8)pDelBaParamSet->field.TID,
+			(u8)pDelBaParamSet->field.tid,
 			TX_DIR,
 			false)) {
 			IEEE80211_DEBUG(IEEE80211_DL_ERR,  "can't get TS for TXTS in %s()\n", __func__);
-- 
2.18.0

