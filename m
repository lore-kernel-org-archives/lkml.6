Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA37BC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0B9218C3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg74gj1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0B9218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeHEVLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 17:11:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40704 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeHEVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 17:11:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so10286934wrs.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cOx4dHS42bYsoKUHGwvx7dw+fot+Y45/6s6dBpig3v4=;
        b=Qg74gj1Jg/Jioq8XTsTBEK2dV9RtNSC+QluifXXlWfEh/v0FbfE8XRU9VSXcrZoBBO
         ZvH6e+Ce9uyVIq0vdsew50XZOB8QTohOTRv+O2cWER32PXvfR7GUiK3iG0NrOKAxMWLU
         5OOfkIEI9FFYfqjcWeeJFi2BZIOiDIkTxKcOITo+BzbTmYm/B/JMwHui3ceo2Q9gGKyD
         FQ7ht77t4vVN0JMrhsTFjVkXogJgMi3I2+2o7qfCaMVfz2Uq68/cvx0/tR/YA01uYijj
         XyQXayQ8ZkdUD/E9tJy+k5jOderUGNRBTHxwWNgBSAdmtIlohjSNLXbLW+NynFJQ0hyW
         xWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cOx4dHS42bYsoKUHGwvx7dw+fot+Y45/6s6dBpig3v4=;
        b=ZS24pgumzcguo1jtNtKYnyB/MGkubiMiKS7UfK2RBrUwtmuopiZJWiVDHh3V8w4HFv
         Zq5BkGcYyKaC3Ej8umWwyjnFlfxk3NbmvIywEvT9BXrO0R+ltEanAHz2x52z0u3JDzv8
         beXH3VvMTvXwxtUmYRGrsPYXztatFxl9UPFcaRhcdCKiY8kYg8CWJsNPBROQxb4fXXGB
         zw6I+CMMcdM+DM2kxTRD/4PnbZ21H5NlsGxilKCPDwNuDPDJTNl8rfSJVHScECZeaIAk
         Yw/tpyPJZkucXYQQ7N9CwmEDe6zUO86jOlAgWSPzpUKJTHi1m9gIIskcmzPXUlLQyge7
         nghw==
X-Gm-Message-State: AOUpUlFS0wg24NEn4DIsmrPzIWo8T/0q+7fvQ6G7pPzWfxZzX08Zj08j
        1T+MN92pVPqHwjvj05LiKro=
X-Google-Smtp-Source: AAOMgpeU/ZPaa8/PiYA3LhHcg9Eud7aESgzvZdaNXIH4UnIIkT/xhLB0pMKO5AB1h+Z0Bz8aAgtT2Q==
X-Received: by 2002:adf:a4d4:: with SMTP id h20-v6mr7775886wrb.167.1533495934285;
        Sun, 05 Aug 2018 12:05:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id g125-v6sm4500884wmf.16.2018.08.05.12.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 12:05:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 6/6] staging: rtl8188eu: remove whitespace, add missing blank line
Date:   Sun,  5 Aug 2018 21:05:16 +0200
Message-Id: <20180805190516.2133-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180805190516.2133-1-straube.linux@gmail.com>
References: <20180805190516.2133-1-straube.linux@gmail.com>
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

