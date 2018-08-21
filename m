Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE950C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E424217BE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/4G/uGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E424217BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeHUUgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:36:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53017 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeHUUgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so888705wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zq+RUEatbChw81QQTj4bpwaYC89QurKh/RaBFCS1xRY=;
        b=L/4G/uGpPNmZ/aXD+gd+OtZ7TD/CxswdDA/O+v83l/1LJ0FzPcAIq/Ml7lixap70IS
         w8zU0POdSL+3cLS7lmTYQEUG9+/lA7DKVGB2kHXNS81NEuVrdLmoFKpfbVPkdLZxSlrL
         BUbQzZ2SR9/6INbJZQPKO780yWAT3p3oZG7cqs1CUrRCfwZFmZm0cUILxr7Rjams/Jr1
         NO5CvdkxMRNoNDGwnExl+gpxUUKUoKyYZuUGvlT50hAqfHoM9uSpaJX1yUSPQ3pl/NdW
         roQBEX5OFsYbdDzy4ttzXcVy+JczeXV2mr6LRSeoyN1UvJs5L8GGyefIXuzNxFpueEGs
         3hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zq+RUEatbChw81QQTj4bpwaYC89QurKh/RaBFCS1xRY=;
        b=ncOkexkYMFnbdlBN/tjij4g8Bkj09uRUEQQOlYYctgSo9Zoy8Ht5FYNIANlje3l6bJ
         +1+xWe3xxH5qPXlUgvKe544nAyL/hhAbnib+aB8Jp2TuRKr2A4TtJo+OplBXkog+p20C
         pDdlNzWnP7x8j5BpkvDGuJgVUEGk9am0edOnOoI4vkgx8LiYs6XJyYOYK0TEniOnbHrR
         SinqTbQXHiBFRwBJeSAOUTf7XTToNvJzhU0Ba/Dn69MkixQmaYh3cQelMOCYrOuVcLb8
         JBU96ZBOKZPVXuyfXpoQFeMUYJ/1PStLE03sN6FoFYz2gEiiZqlJGoaCgJ5IVvPQF5Ns
         DkRA==
X-Gm-Message-State: APzg51CaIkHPXMgDvG+VeZ8e9VOP2x0xY7Jv1B0y6TTQ2kxjNK4uyqdI
        M2NGu8VgObAzlRsxl3WaEUSO1tqL9oA=
X-Google-Smtp-Source: ANB0VdaGFRoJFrqQQa4oCcPve3ST8as1/ztSDGcoU9pWKB68Q6Ky23wmylskOtgKvM96eB1vqIMNuQ==
X-Received: by 2002:a1c:1f50:: with SMTP id f77-v6mr209232wmf.52.1534871749818;
        Tue, 21 Aug 2018 10:15:49 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:49 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/17] staging:rtl8192u: Remove charData and rename shortData - Style
Date:   Tue, 21 Aug 2018 18:15:26 +0100
Message-Id: <20180821171537.9330-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union ba_param_set contains the member variable charData which is
unused. The variable has been removed.

Additionally the member variable shortData has been renamed to clear
a checkpatch issue with CamelCase naming.

These are coding style changes which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h     | 3 +--
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 44f820404347..d3730fc6c8fe 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -31,8 +31,7 @@ union sequence_control {
 };
 
 union ba_param_set {
-	u8 charData[2];
-	u16 shortData;
+	u16 short_data;
 	struct {
 		u16 AMSDU_Support:1;
 		u16 BAPolicy:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 469e3e9a0d2e..1a9271548b94 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -90,7 +90,7 @@ static u8 RxTsDeleteBA(struct ieee80211_device *ieee, struct rx_ts_record *pRxTs
 void ResetBaEntry(PBA_RECORD pBA)
 {
 	pBA->bValid			= false;
-	pBA->BaParamSet.shortData	= 0;
+	pBA->BaParamSet.short_data	= 0;
 	pBA->BaTimeoutValue		= 0;
 	pBA->DialogToken		= 0;
 	pBA->BaStartSeqCtrl.short_data	= 0;
@@ -151,7 +151,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, P
 	}
 	// BA Parameter Set
 
-	put_unaligned_le16(pBA->BaParamSet.shortData, tag);
+	put_unaligned_le16(pBA->BaParamSet.short_data, tag);
 	tag += 2;
 	// BA Timeout Value
 
-- 
2.18.0

