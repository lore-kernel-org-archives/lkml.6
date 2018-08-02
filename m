Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B9C21546
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6YFBX9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B9C21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbeHBTK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:10:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40522 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387482AbeHBTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:10:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so3440588wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cOx4dHS42bYsoKUHGwvx7dw+fot+Y45/6s6dBpig3v4=;
        b=L6YFBX9yuvEFuxx/ha2tiouKIEeunsvLjc6/CjFJ+MBYhBTpxL5pv4/UMME2NB4X8N
         MqoIQtPJMZLuPPKO2A25UZyEkxUnsDYj/BJeJWt8VcIdj3fQ41Z1trQPXVwt2ByF9TH3
         IwlXua5nE+s0+BZueeVQ7tFLJfEiEvFvGWySV/NxLZEvuulTfXZcKywWmNvh/nNxK+sC
         9jeLgf34H4f5XA6+CTvdi20d2zEs1L4OV+udGVqLgd8mWmhqRVNJA1wv8La7ayiwhT2Q
         1veFaW1VqMLQqOmYkSjglJ4lsOKTO3FsxNgb4m9WQW5TD2ASA1AZKd1LyFhXetv2UZsg
         5XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cOx4dHS42bYsoKUHGwvx7dw+fot+Y45/6s6dBpig3v4=;
        b=qlzZzwPNhBYF518DU5Iy3izlVS4jnfpZ2Kbv5s+zMfFfW1knykIl1eYJtXStH6mEWf
         shLATOzhXQA49vZHZkmUqQv26KVWaX8rbF+ppQDlXcyHOEQ1eoEf4GgwBr5jJLY5+Gj3
         V/MdnpN2TfapTaLJRlWjAzIQdI2+a1i68I7sc0714/1vUPjd3QM6a0mLTyiHeQV2LbBk
         CBtOAW8dOIS9FacmswAQfTKltzJY2eztUIbZyqqmmkuyapTeRwNrpkjfZgMelbynPtMA
         KQ4F0ToOVlCnhIqV4dhyElLVDw5QUGSvplQ/cBP1n3qVbYMLwVZsD1qYyOZyhn+McM+H
         cqBA==
X-Gm-Message-State: AOUpUlGq7WRa1kbVdumZwgmXOg3fw89FbyKzVlidv9QbU2W96VjkPvtN
        O8z775E86DgKsli4ADevXzs=
X-Google-Smtp-Source: AAOMgperRauUaVs/Tiy0dpoaCXNDiwnFx0jIM6/dKHrNM25mbBj9QjTRawa4qmSpdI6+kn9sXg8M/A==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74-v6mr2817750wme.70.1533230330540;
        Thu, 02 Aug 2018 10:18:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t15-v6sm3205081wrn.34.2018.08.02.10.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 10:18:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: rtl8188eu: remove whitespace, add missing blank line
Date:   Thu,  2 Aug 2018 19:18:23 +0200
Message-Id: <20180802171823.1571-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802171823.1571-1-straube.linux@gmail.com>
References: <20180802171823.1571-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove spaces where appropriate.
Add a missing blank line after declarations.

Also clears checkpatch warnings.
WARNING: Statements should start on a tabstop
WARNING: suspect code indent for conditional statements (8, 17)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 37 ++++++++++----------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 34c3e2af63c1..f12a12b19d3f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -18,7 +18,7 @@ static void _rtw_init_stainfo(struct sta_info *psta)
 {
 	memset((u8 *)psta, 0, sizeof(struct sta_info));
 
-	 spin_lock_init(&psta->lock);
+	spin_lock_init(&psta->lock);
 	INIT_LIST_HEAD(&psta->list);
 	INIT_LIST_HEAD(&psta->hash_list);
 	_rtw_init_queue(&psta->sleep_q);
@@ -55,7 +55,7 @@ static void _rtw_init_stainfo(struct sta_info *psta)
 #endif	/*  CONFIG_88EU_AP_MODE */
 }
 
-u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
+u32 _rtw_init_sta_priv(struct sta_priv *pstapriv)
 {
 	struct sta_info *psta;
 	s32 i;
@@ -127,15 +127,15 @@ inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
-u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
+u32 _rtw_free_sta_priv(struct sta_priv *pstapriv)
 {
 	struct list_head *phead, *plist;
 	struct sta_info *psta = NULL;
 	struct recv_reorder_ctrl *preorder_ctrl;
-	int	index;
+	int index;
 
 	if (pstapriv) {
-		/*	delete all reordering_ctrl_timer		*/
+		/* delete all reordering_ctrl_timer */
 		spin_lock_bh(&pstapriv->sta_hash_lock);
 		for (index = 0; index < NUM_STA; index++) {
 			phead = &pstapriv->sta_hash[index];
@@ -171,7 +171,7 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	struct __queue *pfree_sta_queue;
 	struct recv_reorder_ctrl *preorder_ctrl;
 	int i = 0;
-	u16  wRxSeqInitialValue = 0xffff;
+	u16 wRxSeqInitialValue = 0xffff;
 
 	pfree_sta_queue = &pstapriv->free_sta_queue;
 
@@ -243,14 +243,14 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 }
 
 /*  using pstapriv->sta_hash_lock to protect */
-u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
+u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 {
 	int i;
 	struct __queue *pfree_sta_queue;
 	struct recv_reorder_ctrl *preorder_ctrl;
-	struct	sta_xmit_priv	*pstaxmitpriv;
-	struct	xmit_priv	*pxmitpriv = &padapter->xmitpriv;
-	struct	sta_priv *pstapriv = &padapter->stapriv;
+	struct sta_xmit_priv *pstaxmitpriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	if (!psta)
 		goto exit;
@@ -376,9 +376,9 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 void rtw_free_all_stainfo(struct adapter *padapter)
 {
 	struct list_head *plist, *phead;
-	s32	index;
+	s32 index;
 	struct sta_info *psta = NULL;
-	struct	sta_priv *pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *pbcmc_stainfo = rtw_get_bcmc_stainfo(padapter);
 
 	if (pstapriv->asoc_sta_count == 1)
@@ -407,7 +407,7 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 {
 	struct list_head *plist, *phead;
 	struct sta_info *psta = NULL;
-	u32	index;
+	u32 index;
 	u8 *addr;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
@@ -443,10 +443,10 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 
 u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 {
-	struct sta_info		*psta;
+	struct sta_info *psta;
 	u32 res = _SUCCESS;
 	unsigned char bcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-	struct	sta_priv *pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	psta = rtw_alloc_stainfo(pstapriv, bcast_addr);
 
@@ -465,9 +465,10 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter)
 {
-	struct sta_priv		*pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-	 return rtw_get_stainfo(pstapriv, bc_addr);
+
+	return rtw_get_stainfo(pstapriv, bc_addr);
 }
 
 u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
@@ -502,7 +503,7 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 	else if (pacl_list->mode == 2)/* deny unless in accept list */
 		res = (match) ? true : false;
 	else
-		 res = true;
+		res = true;
 
 #endif
 
-- 
2.18.0

