Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AC6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000F320862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGXn2fOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000F320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeG1P4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:56:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41142 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbeG1P4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:56:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so7935082wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOJMqQ/tqHNxcv7qth5lpUCRzb1VAci60gjyYxs2Vu8=;
        b=PGXn2fOs7MhwddsPDOmsWrnBl6A5Vm5+7HB8LV6H+MAgkwSTssavHyLwnysQcyenHl
         hbhCIwRG/v0SNFO5QL084x4x+R5AXoLyDtsQ3zX6wEeTi6d271AhCzmbZApoeEgenY6P
         ElyC/89ppxwNCIj1f46cOcbzCyV+j8pj4dUvGAA5pZwBi2B9FC8Nf13RIfpz26SOHUBS
         DIWnmnXjYIgYhnFMPpLwswFU9RcDNXo7sa94rn2/wPBcY159ibad8yvrQ1t0kUID6ZKm
         VYZUvlny9tqoFdIoNWoVfMCYeSoF0GyPow5e3V5bq6e7ZJQvQ/xz+JRQ1WZnl1WvfBli
         Kd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOJMqQ/tqHNxcv7qth5lpUCRzb1VAci60gjyYxs2Vu8=;
        b=V2wstBNrlSNdcgbpTgsq3r77AGDfMtV2Yjn9UWSsJ8wAJAyIRYlmdf4tmdzzozaVlN
         AwIEVnglVp/an3Wpi5HvDnAghoskaPQrD/9ewNSA63XRjVJdDg1dEJtlIkffc7cfkLfo
         J+TMmgupbcDtUq1mDdWuDBWf3aSmdTaTl6Nuuu8wbj2Z/7m301j1ehc2Ngiuy9hjZyiQ
         lg7QNzEmYI4LBJezNyYvl8tNx5ChDVnt9HIHY633CEyY+irgQrEYaYKc54BC18rYJHCj
         xvZ1vultx1lx5Znr8nhkg2Kyb8F9o63UzM50Am7f3Efg9LZn6P6oXTRdJaFc2cTRwGpU
         gLFg==
X-Gm-Message-State: AOUpUlH9gLm9qTvKjRVKP4sTncZZylY758bR7+KY1OiIETrd9LlxYsb0
        wFZjGLbvtpv4NNP5w4QFIx4=
X-Google-Smtp-Source: AAOMgpeKeM/aJkznUN81qu1ZDXNIAQ4n4j4b/8ypo51J2lUY6mBcfjYodqCp0D965q+Pgd3nP/8pMA==
X-Received: by 2002:adf:80c9:: with SMTP id 67-v6mr9260133wrl.95.1532788174173;
        Sat, 28 Jul 2018 07:29:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id z8-v6sm13187019wrp.54.2018.07.28.07.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 07:29:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: remove unused rtw_calculate_wlan_pkt_size_by_attribue()
Date:   Sat, 28 Jul 2018 16:29:17 +0200
Message-Id: <20180728142917.1439-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728142917.1439-1-straube.linux@gmail.com>
References: <20180728142917.1439-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_calculate_wlan_pkt_size_by_attribue() also defined as
rtw_wlan_pkt_size() is never used, so remove it. Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c    | 18 ------------------
 drivers/staging/rtl8188eu/include/rtw_xmit.h |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 4265ad84547d..2130d78e0d9f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -892,24 +892,6 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter, struct pkt_attrib *pat
 	return ptxservq->qcnt;
 }
 
-/*
- * Calculate wlan 802.11 packet MAX size from pkt_attrib
- * This function doesn't consider fragment case
- */
-u32 rtw_calculate_wlan_pkt_size_by_attribue(struct pkt_attrib *pattrib)
-{
-	u32	len = 0;
-
-	len = pattrib->hdrlen + pattrib->iv_len; /*  WLAN Header and IV */
-	len += SNAP_SIZE + sizeof(u16); /*  LLC */
-	len += pattrib->pktlen;
-	if (pattrib->encrypt == _TKIP_)
-		len += 8; /*  MIC */
-	len += ((pattrib->bswenc) ? pattrib->icv_len : 0); /*  ICV */
-
-	return len;
-}
-
 /*
 
 This sub-routine will perform all the following:
diff --git a/drivers/staging/rtl8188eu/include/rtw_xmit.h b/drivers/staging/rtl8188eu/include/rtw_xmit.h
index af6485aa6900..788f59c74ea1 100644
--- a/drivers/staging/rtl8188eu/include/rtw_xmit.h
+++ b/drivers/staging/rtl8188eu/include/rtw_xmit.h
@@ -326,8 +326,6 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv,
 
 s32 rtw_xmit_classifier(struct adapter *padapter,
 			struct xmit_frame *pxmitframe);
-u32 rtw_calculate_wlan_pkt_size_by_attribue(struct pkt_attrib *pattrib);
-#define rtw_wlan_pkt_size(f) rtw_calculate_wlan_pkt_size_by_attribue(&f->attrib)
 s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt,
 			   struct xmit_frame *pxmitframe);
 s32 _rtw_init_hw_txqueue(struct hw_txqueue *phw_txqueue, u8 ac_tag);
-- 
2.18.0

