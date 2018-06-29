Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001C4C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A950C27C89
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIbSRGo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A950C27C89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934846AbeF2TAD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:00:03 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36850 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932377AbeF2TAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:00:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so9755133wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BpzFtflILIBQy6+Ggs04v8gy+0iK+PFl1KDZN24X0n4=;
        b=uIbSRGo24llsIekRcrbQvv7KryvoaRn8mQlXjWWcUZngY5dF0V/asKD8Xi+mru7Bmx
         kGOYKArn0UYffuaY6RFqE/UaTmdOujB7bb5+dzMIeOahzRdVn6L5G86qY2XnKnU23PqB
         4FHcOUhZNhms+da/Q4TqNR6wwLRJPY44/8WIB0f0HeTxCWjzOn3Oz8PvBtraQvgTu0YO
         Zq3zqpbenNnlI8xePL90s0bBChODooFzIi9asus9T7zbzLUyRqYo5JdIASNpNM+ipm5h
         nlFJS33tpg2bPebWSwODpzkdTw4eHGD4BqAZJkFFbWEhBMed3SZWzkPWFQlg59OHA7oh
         XRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BpzFtflILIBQy6+Ggs04v8gy+0iK+PFl1KDZN24X0n4=;
        b=P7ntRiFAklj2SalKeWlXShK1aFMw6q/bgNCEoAWSBhynl8fhLm+vwfpWMie2bqmoUc
         sKV3Zx9B6Z7PwgwrNTBS4nzhgWPPUYMpTp00+o9rv7haLR5J44wYt1Yq5jpJjhYtOiRI
         fKSp/b+Vk8SM477nVNzsDp6SDQu7J8JkqTXS+itJstFdmfBHURRjJgW9f73IYk+iHIyj
         ct5KgewJfYDD4OQH+6Ym7e39IdbBzQIrdc6boWVB1m5QLiUvqjctGsvaLUIoe3/5oDT0
         8Wc8nDFCYL3Y8KR+MrjutRJIdwodb4pPMXUiRd36FWSNly+74EV5mZz6bA4Vp44qH1CL
         CrZQ==
X-Gm-Message-State: APt69E2qc03DNeTYwz8EkL/5R3s/x8nXWCPYJlZNj/lwyC5nsyIUG4JW
        MeXRT6pwt3qX0+5oAb1ENSg=
X-Google-Smtp-Source: AAOMgpeM+nijV+Lz1eFN1s+9uh2iIbU36LskAQiiQ6zHwKpwqtZTKYIQjaAo3LuDPrhIFTRvryDdLA==
X-Received: by 2002:adf:a86a:: with SMTP id l97-v6mr9101057wrc.164.1530298800932;
        Fri, 29 Jun 2018 12:00:00 -0700 (PDT)
Received: from arch.localdomain (x590dd42e.dyn.telefonica.de. [89.13.212.46])
        by smtp.gmail.com with ESMTPSA id u70-v6sm3458547wmd.3.2018.06.29.11.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 12:00:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unnecessary parentheses
Date:   Fri, 29 Jun 2018 20:59:44 +0200
Message-Id: <20180629185944.8831-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses as reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 53c6ca85d69f..53e518148ae5 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -81,7 +81,7 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 	for (i = 0; i < NUM_STA; i++) {
 		_rtw_init_stainfo(psta);
 
-		INIT_LIST_HEAD(&(pstapriv->sta_hash[i]));
+		INIT_LIST_HEAD(&pstapriv->sta_hash[i]);
 
 		list_add_tail(&psta->list, get_list_head(&pstapriv->free_sta_queue));
 
@@ -138,7 +138,7 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		/*	delete all reordering_ctrl_timer		*/
 		spin_lock_bh(&pstapriv->sta_hash_lock);
 		for (index = 0; index < NUM_STA; index++) {
-			phead = &(pstapriv->sta_hash[index]);
+			phead = &pstapriv->sta_hash[index];
 			plist = phead->next;
 
 			while (phead != plist) {
@@ -266,19 +266,19 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vo_q.sta_pending);
 
-	list_del_init(&(pstaxmitpriv->vo_q.tx_pending));
+	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
 
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vi_q.sta_pending);
 
-	list_del_init(&(pstaxmitpriv->vi_q.tx_pending));
+	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
 
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->bk_q.sta_pending);
 
-	list_del_init(&(pstaxmitpriv->bk_q.tx_pending));
+	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
 
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->be_q.sta_pending);
 
-	list_del_init(&(pstaxmitpriv->be_q.tx_pending));
+	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
 	spin_unlock_bh(&pxmitpriv->lock);
 
@@ -319,7 +319,7 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 			plist = plist->next;
 
-			list_del_init(&(prframe->list));
+			list_del_init(&prframe->list);
 
 			rtw_free_recvframe(prframe, pfree_recv_queue);
 		}
@@ -363,7 +363,7 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 #endif	/*  CONFIG_88EU_AP_MODE */
 
-	spin_lock_bh(&(pfree_sta_queue->lock));
+	spin_lock_bh(&pfree_sta_queue->lock);
 	list_add_tail(&psta->list, get_list_head(pfree_sta_queue));
 	spin_unlock_bh(&pfree_sta_queue->lock);
 
@@ -387,7 +387,7 @@ void rtw_free_all_stainfo(struct adapter *padapter)
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 
 	for (index = 0; index < NUM_STA; index++) {
-		phead = &(pstapriv->sta_hash[index]);
+		phead = &pstapriv->sta_hash[index];
 		plist = phead->next;
 
 		while (phead != plist) {
@@ -423,7 +423,7 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 
-	phead = &(pstapriv->sta_hash[index]);
+	phead = &pstapriv->sta_hash[index];
 	plist = phead->next;
 
 	while (phead != plist) {
@@ -481,7 +481,7 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue *pacl_node_q = &pacl_list->acl_node_q;
 
-	spin_lock_bh(&(pacl_node_q->lock));
+	spin_lock_bh(&pacl_node_q->lock);
 	phead = get_list_head(pacl_node_q);
 	plist = phead->next;
 	while (phead != plist) {
-- 
2.18.0

