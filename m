Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CCCECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF4E20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNL26g0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF4E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbeGTVLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:11:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40091 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbeGTVLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:11:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so10923511wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2DFxTPAis2sgG5gggsVuL4itH/oRRa6UTfFfkdg5PQs=;
        b=SNL26g0NYuiqMx1ZN1Dh40pLBYrsKe76Dcv6mTAMyE46Sp5AX46SwiRkoHOExaGmsk
         vb0oO89bfUj9aAb0z1rD6UC0ipoGCP1yoG2YyxMIlP/naDGASjYGIqFYf0ci1UvJvLft
         Hp44akyTHaPHPU45T/ZiirhAEseE8pb/moctBUsy7N3NHv29IxQ/kT2Pm3etFDNiSXQB
         fwWGQhNMePJ0ghiG3qRk4CuMBSdLs2n0Ts9exn7uQbhTFa3j3SJNUdJiluEGOXtdZjKL
         naTpeJ3MVDR2PY1dDMK3pkNrKE0iAl+0qktOs5Tnav9Nn7AzgmsVx1K+rVMc33szD8RK
         ibkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2DFxTPAis2sgG5gggsVuL4itH/oRRa6UTfFfkdg5PQs=;
        b=SCTlpc5TEGaeqUTAQIsrg2wiacgba61ydedLPnIcrVUAxiPf13JvF/aNo7bi3BC8BZ
         PQcejxrzHNBCsu2si7M0cZHInrmp5T1H1y+K5T9YxWKKPFs2wFnBy2pTVbupf16oz9hY
         O1MND+T9Yd/c1c6lRtgjjBVFsiqnvONuZMKVjh3S2z0GEDY441IQmLYyiHsj/w1aAL+u
         23SPDp0pT9Rd5oReT/ulX+bDAnqLcW67nv6qdbS7EL3eeWzbzDLAGxg9ryNkzLnU6YQx
         c+G+JNIIsYio6OpgLUcnI03KgzDxPyIOy+v/HG6IYR5WkHb2pSxJzvF1aA9sOWINjcwu
         ur9w==
X-Gm-Message-State: AOUpUlEUD3Vfrvai4i2wyBq7fiAbY0hrKoh/8HPk1c5Qjunag0Ilk1kd
        pbD5MmFcv2hCYN0O4ifiIsv9TwdhSnU=
X-Google-Smtp-Source: AAOMgpdVmNcn5Z5QiBbDg7Vo8SZDIh/8WIdogHlUu0x9llNndVQ+fhGVTO9NZTDOrk1FSn9iSUVOtg==
X-Received: by 2002:a1c:ad50:: with SMTP id w77-v6mr2472519wme.54.1532118119975;
        Fri, 20 Jul 2018 13:21:59 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:21:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/14] staging:rtl8192u: Remove typedef from structure - Style
Date:   Fri, 20 Jul 2018 21:21:30 +0100
Message-Id: <20180720202142.26312-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef directive from struct _CHNL_TXPOWER_TRIPLE. This is a
coding style change which clears a checkpatch issue with declaring new types.
There should be no impact on runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index ba284bfb3b6d..8ac08ee5256e 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -54,13 +54,13 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 {
 	PRT_DOT11D_INFO pDot11dInfo = GET_DOT11D_INFO(dev);
 	u8 i, j, NumTriples, MaxChnlNum;
-	PCHNL_TXPOWER_TRIPLE pTriple;
+	struct chnl_txpower_triple *pTriple;
 
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER+1);
 	memset(pDot11dInfo->MaxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER+1);
 	MaxChnlNum = 0;
 	NumTriples = (CoutryIeLen - 3) / 3; /* skip 3-byte country string. */
-	pTriple = (PCHNL_TXPOWER_TRIPLE)(pCoutryIe + 3);
+	pTriple = (struct chnl_txpower_triple *)(pCoutryIe + 3);
 	for (i = 0; i < NumTriples; i++) {
 		if (MaxChnlNum >= pTriple->FirstChnl) {
 			/* It is not in a monotonically increasing order, so
@@ -83,7 +83,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 			MaxChnlNum = pTriple->FirstChnl + j;
 		}
 
-		pTriple = (PCHNL_TXPOWER_TRIPLE)((u8 *)pTriple + 3);
+		pTriple = (struct chnl_txpower_triple *)((u8 *)pTriple + 3);
 	}
 	netdev_info(dev->dev, "Channel List:");
 	for (i = 1; i <= MAX_CHANNEL_NUMBER; i++)
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 23ab2dae8347..9471279cf8e6 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -4,11 +4,11 @@
 
 #include "ieee80211.h"
 
-typedef struct _CHNL_TXPOWER_TRIPLE {
+struct chnl_txpower_triple {
 	u8 FirstChnl;
 	u8  NumChnls;
 	u8  MaxTxPowerInDbm;
-} CHNL_TXPOWER_TRIPLE, *PCHNL_TXPOWER_TRIPLE;
+};
 
 typedef enum _DOT11D_STATE {
 	DOT11D_STATE_NONE = 0,
-- 
2.18.0

