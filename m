Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C53C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F453217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzS5Y3gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F453217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeHUUgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:36:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44141 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeHUUgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so2067076wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vqKCyU5MO32rSLd4tVRBwDP+bTinDapRseliHOUC8RI=;
        b=YzS5Y3gHbqUyAjL9dLkIRMrJZhzEN7HE2y+9z8JiQqK/W7vu8aBwsLYaXtmU3iSeBx
         mENJLSnBFc7fDISQ8taMlJKJc3PPo7uwLlT/+S4QhWs/RsiuQGiChc0WjMNnItIAuPeG
         gZMM6+bQxOFYz3wpvwK8766ZkGDQG2hvKf82LVEkCIDWNt4qqwY5qDlznud924S2lx0z
         +ca06X8R5e8RQl/YB8Wb3GDyKOZEdyRxPKN0OFk6b1ACoPi9YCzGmJl0ePRcDV2zYXYY
         /yntwDQmbdo2nyaV5ly5OUWGFB1+CUFGY5hXM9bF1aNBhs15yhHrAwdrJO1rA+LSMRN7
         XGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vqKCyU5MO32rSLd4tVRBwDP+bTinDapRseliHOUC8RI=;
        b=McIcw3alHKMRuyS++HZQ+Hjo9NunclYhkFp8VuATnHra5ZcKVtZkhZUCHAqUtDMEb7
         U0p1llRpulu/zcnmFnj2z+tYBkkB+a/jiGGFc9/e42i+40fdi3L8HVAkQOn1HB0BLanu
         1isvXRKprZgGsGNP2A1qTLhIagcBNtpz6HKkPB6aIdjPQGHC5sbcS4z4jovlMyKy/pgs
         GfM4m/IT/s3HBGrurB5ot7RILPfa6PRODxkRj9h9CLGZrZXr6wxszdyGDAzofxZZA6ki
         /U1Q5/kOGT9kVr7nAeKBi3aY0EhGlLvDO316W9rNa828n0bnTNPHeU+W1ZlRE0zp9jqp
         InTA==
X-Gm-Message-State: APzg51CJx+s3kw0njk9o8lQ+2+ipep0y//kBXT5m7RuQFn4EzqW62HeT
        kZyZrSLVcdAHx/4hQSlaB+WJ0DK2zOw=
X-Google-Smtp-Source: ANB0VdYWgWUX3pCGGyUN4IkOkk0yh7xIDHF2myNZBEmBRPZgdwVYHPB3pEHYizQTeEuWVIomlfas3Q==
X-Received: by 2002:adf:e486:: with SMTP id i6-v6mr2071346wrm.145.1534871742644;
        Tue, 21 Aug 2018 10:15:42 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:41 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/17] staging:rtl8192u: Refactor SEQUENCE_CONTROL - Style
Date:   Tue, 21 Aug 2018 18:15:22 +0100
Message-Id: <20180821171537.9330-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the 'typedef' from union SEQUENCE_CONTROL. This clears a
checkpatch issue with defining new types.

Additionally renamed the union to lowercase to comply with coding
standard.

These are coding style changes which should not impact runtime
code execution.

typedef union _SEQUENCE_CONTROL{
+union sequence_control {

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h     | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 8a74faedf6d6..446de58f1849 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -22,13 +22,13 @@ struct ieee80211_ADDBA_Req{
 } __attribute__ ((packed));
 */
 //Is this need?I put here just to make it easier to define structure BA_RECORD //WB
-typedef union _SEQUENCE_CONTROL{
+union sequence_control {
 	u16 ShortData;
 	struct {
 		u16	FragNum:4;
 		u16	SeqNum:12;
 	} field;
-} SEQUENCE_CONTROL, *PSEQUENCE_CONTROL;
+};
 
 typedef union _BA_PARAM_SET {
 	u8 charData[2];
@@ -57,7 +57,7 @@ typedef struct _BA_RECORD {
 	u8				DialogToken;
 	BA_PARAM_SET		BaParamSet;
 	u16				BaTimeoutValue;
-	SEQUENCE_CONTROL	BaStartSeqCtrl;
+	union sequence_control	BaStartSeqCtrl;
 } BA_RECORD, *PBA_RECORD;
 
 #endif //end _BATYPE_H_
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 01b631c2a180..c1fe42e0893c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -324,7 +324,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	PBA_RECORD pBA = NULL;
 	PBA_PARAM_SET	pBaParamSet = NULL;
 	u16 *pBaTimeoutVal = NULL;
-	PSEQUENCE_CONTROL pBaStartSeqCtrl = NULL;
+	union sequence_control *pBaStartSeqCtrl = NULL;
 	struct rx_ts_record  *pTS = NULL;
 
 	if (skb->len < sizeof(struct rtl_80211_hdr_3addr) + 9) {
@@ -344,7 +344,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	pDialogToken = tag + 2;  //category+action
 	pBaParamSet = (PBA_PARAM_SET)(tag + 3);   //+DialogToken
 	pBaTimeoutVal = (u16 *)(tag + 5);
-	pBaStartSeqCtrl = (PSEQUENCE_CONTROL)(req + 7);
+	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
 
 	netdev_info(ieee->dev, "====================>rx ADDBAREQ from :%pM\n", dst);
 //some other capability is not ready now.
-- 
2.18.0

