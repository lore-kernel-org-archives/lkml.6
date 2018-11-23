Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF4CC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329A720685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiU3m0Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329A720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeKXH1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:27:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39544 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKXH1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:27:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so5471673wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s3FPuHb102v1J4KVMGb1vQM97gNLJGXk8c/WILfaN90=;
        b=RiU3m0JfGz+KEIfLBp/kiba5xebzSJ4oBE+A3zq2qU6LB1uGsCUt1XQWpEJj6QVIfu
         7dK/tdIWOVTCZTBiNrb0kTt3rpsL0RN2vUjBnF274PqSYLBz7lg7KzsPgZOfDk1Xv4dz
         wNi8jpNnrIvqcbibCAo3Oh9Wz756G1G/MFC0P+hiW/AZpzwDnirwf0f5UV9uHnuQa676
         TFva2HwmvM2Ibz+mxhvwEHauRTq6qHV71k+zYFgrtqA/M7LVtjQnFU6GV57mhK0gpn7F
         PkQG2jktJ4gktqGNVEB0PzHRJ1bSGcp127askbgPSCnAlUTCLcF8M44/yCGBle5B2RCu
         BFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s3FPuHb102v1J4KVMGb1vQM97gNLJGXk8c/WILfaN90=;
        b=WZrHFqeUFTR35m/Y+jTHGMHk0USqjzVGAET+wxIAcc+vggb/8wE4RTiatLbzJx9qxV
         Ffs+HSpky6OW2v6PYAj5Ei/C8ntgw83LqGBwQaaNXUwZYGAXr3FtKGM/28ZXpvXVzJdf
         UF6L2VuQzhdgio8nJEa4Qyb89hzNvfGMu9NTPDRpO8TUrwgJztKYMiJQpX6hdxiHx/yl
         QTZI1GDBu7ZEyTCyC0rSxZ+dNIgnBy/74eGNjY0FcJmzLi5Z1k0D1d1f7HLu8Pz+tKtm
         3nGVSmyDEr86B9xGq0pbvayfQ2CwJdnqkrLj9O/+JizdObJNubeX/PvX1j6GAvssQ4Gf
         +/xg==
X-Gm-Message-State: AA+aEWYcy7aTOWLaG1/zIihH4b1FtkuAGPLHW6GJGFQ3wX1onEDIjSof
        O8e2LKXyle+lhzL5Jgk6+9c=
X-Google-Smtp-Source: AFSGD/VwXxl+XVcwqJ5vf54DhMHfN/6wFyTlG4iYTOMeUsPsZFH9g8YhypBHilbc5VbNUYTQcXDBeQ==
X-Received: by 2002:adf:e18d:: with SMTP id k13mr15676039wri.36.1543005679284;
        Fri, 23 Nov 2018 12:41:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i9sm24598906wrs.34.2018.11.23.12.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 12:41:18 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/9] staging: rtl8188eu: remove unnecessary parentheses in rtw_mlme.c
Date:   Fri, 23 Nov 2018 21:40:59 +0100
Message-Id: <20181123204106.2284-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123204106.2284-1-straube.linux@gmail.com>
References: <20181123204106.2284-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 120 ++++++++++++----------
 1 file changed, 63 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index b6210d98ee2d..d5c22a028905 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -39,9 +39,9 @@ int rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
 	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
 
-	spin_lock_init(&(pmlmepriv->lock));
-	_rtw_init_queue(&(pmlmepriv->free_bss_pool));
-	_rtw_init_queue(&(pmlmepriv->scanned_queue));
+	spin_lock_init(&pmlmepriv->lock);
+	_rtw_init_queue(&pmlmepriv->free_bss_pool);
+	_rtw_init_queue(&pmlmepriv->scanned_queue);
 
 	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 
@@ -56,9 +56,9 @@ int rtw_init_mlme_priv(struct adapter *padapter)
 	pnetwork = (struct wlan_network *)pbuf;
 
 	for (i = 0; i < MAX_BSS_CNT; i++) {
-		INIT_LIST_HEAD(&(pnetwork->list));
+		INIT_LIST_HEAD(&pnetwork->list);
 
-		list_add_tail(&(pnetwork->list), &(pmlmepriv->free_bss_pool.queue));
+		list_add_tail(&pnetwork->list, &pmlmepriv->free_bss_pool.queue);
 
 		pnetwork++;
 	}
@@ -137,7 +137,7 @@ static void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *
 	unsigned long curr_time;
 	u32 delta_time;
 	u32 lifetime = SCANQUEUE_LIFETIME;
-	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -154,21 +154,21 @@ static void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *
 			return;
 	}
 	spin_lock_bh(&free_queue->lock);
-	list_del_init(&(pnetwork->list));
-	list_add_tail(&(pnetwork->list), &(free_queue->queue));
+	list_del_init(&pnetwork->list);
+	list_add_tail(&pnetwork->list, &free_queue->queue);
 	spin_unlock_bh(&free_queue->lock);
 }
 
 void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
 {
-	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
 	if (pnetwork->fixed)
 		return;
-	list_del_init(&(pnetwork->list));
-	list_add_tail(&(pnetwork->list), get_list_head(free_queue));
+	list_del_init(&pnetwork->list);
+	list_add_tail(&pnetwork->list, get_list_head(free_queue));
 }
 
 /*
@@ -354,7 +354,8 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	rtw_hal_antdiv_rssi_compared(padapter, dst, src); /* this will update src.Rssi, need consider again */
 
 	/* The rule below is 1/5 for sample value, 4/5 for history value */
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&(padapter->mlmepriv.cur_network.network), src)) {
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) &&
+	    is_same_network(&padapter->mlmepriv.cur_network.network, src)) {
 		/* Take the recvpriv's value for the connected AP*/
 		ss_final = padapter->recvpriv.signal_strength;
 		sq_final = padapter->recvpriv.signal_qual;
@@ -384,11 +385,11 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 
 static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 {
-	struct	mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) &&
 	    is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
-		update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
+		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fixed_ie),
 				      pmlmepriv->cur_network.network.ie_length);
 	}
@@ -401,8 +402,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 {
 	struct list_head *plist, *phead;
 	u32	bssid_ex_sz;
-	struct mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct wlan_network	*pnetwork = NULL;
 	struct wlan_network	*oldest = NULL;
 
@@ -413,7 +414,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 	while (phead != plist) {
 		pnetwork	= container_of(plist, struct wlan_network, list);
 
-		if (is_same_network(&(pnetwork->network), target))
+		if (is_same_network(&pnetwork->network, target))
 			break;
 		if ((oldest == ((struct wlan_network *)0)) ||
 		    time_after(oldest->last_scanned, pnetwork->last_scanned))
@@ -424,12 +425,14 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 	 * with this beacon's information
 	 */
 	if (phead == plist) {
-		if (list_empty(&(pmlmepriv->free_bss_pool.queue))) {
+		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
 			/* If there are no more slots, expire the oldest */
 			pnetwork = oldest;
 
-			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &(target->PhyInfo.Optimum_antenna));
-			memcpy(&(pnetwork->network), target,  get_wlan_bssid_ex_sz(target));
+			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA,
+					    &target->PhyInfo.Optimum_antenna);
+			memcpy(&pnetwork->network, target,
+			       get_wlan_bssid_ex_sz(target));
 			/*  variable initialize */
 			pnetwork->fixed = false;
 			pnetwork->last_scanned = jiffies;
@@ -453,15 +456,16 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->Length = bssid_ex_sz;
-			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &(target->PhyInfo.Optimum_antenna));
-			memcpy(&(pnetwork->network), target, bssid_ex_sz);
+			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA,
+					    &target->PhyInfo.Optimum_antenna);
+			memcpy(&pnetwork->network, target, bssid_ex_sz);
 
 			pnetwork->last_scanned = jiffies;
 
 			/* bss info not receiving from the right channel */
 			if (pnetwork->network.PhyInfo.SignalQuality == 101)
 				pnetwork->network.PhyInfo.SignalQuality = 0;
-			list_add_tail(&(pnetwork->list), &(queue->queue));
+			list_add_tail(&pnetwork->list, &queue->queue);
 		}
 	} else {
 		/* we have an entry and we are going to update it. But this entry may
@@ -476,7 +480,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 		if ((pnetwork->network.ie_length > target->ie_length) && (target->Reserved[0] == 1))
 			update_ie = false;
 
-		update_network(&(pnetwork->network), target, adapter, update_ie);
+		update_network(&pnetwork->network, target, adapter, update_ie);
 	}
 
 exit:
@@ -547,7 +551,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	u32 len;
 	struct wlan_bssid_ex *pnetwork;
-	struct	mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
@@ -562,11 +566,11 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  update IBSS_network 's timestamp */
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
-		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress), pnetwork->MacAddress, ETH_ALEN)) {
+		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
 			memcpy(pmlmepriv->cur_network.network.ies, pnetwork->ies, 8);
-			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->MacAddress);
 			if (ibss_wlan) {
 				memcpy(ibss_wlan->network.ies, pnetwork->ies, 8);
@@ -592,7 +596,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	spin_lock_bh(&pmlmepriv->lock);
 
@@ -622,7 +626,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					mod_timer(&pmlmepriv->assoc_timer,
 						  jiffies + msecs_to_jiffies(MAX_JOIN_TIMEOUT));
 				} else {
-					struct wlan_bssid_ex    *pdev_network = &(adapter->registrypriv.dev_network);
+					struct wlan_bssid_ex *pdev_network = &adapter->registrypriv.dev_network;
 					u8 *pibss = adapter->registrypriv.dev_network.MacAddress;
 
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
@@ -741,7 +745,7 @@ void rtw_free_assoc_resources_locked(struct adapter *adapter)
 
 		psta = rtw_get_stainfo(&adapter->stapriv, tgt_network->network.MacAddress);
 
-		spin_lock_bh(&(pstapriv->sta_hash_lock));
+		spin_lock_bh(&pstapriv->sta_hash_lock);
 		rtw_free_stainfo(adapter,  psta);
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 	}
@@ -752,7 +756,7 @@ void rtw_free_assoc_resources_locked(struct adapter *adapter)
 		rtw_free_all_stainfo(adapter);
 
 		psta = rtw_get_bcmc_stainfo(adapter);
-		spin_lock_bh(&(pstapriv->sta_hash_lock));
+		spin_lock_bh(&pstapriv->sta_hash_lock);
 		rtw_free_stainfo(adapter, psta);
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 
@@ -900,8 +904,8 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 /* ptarget_wlan: found from scanned_queue */
 static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_network *ptarget_wlan, struct wlan_network  *pnetwork)
 {
-	struct mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
-	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 
 	DBG_88E("%s\n", __func__);
 
@@ -958,9 +962,9 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 {
 	struct sta_info *ptarget_sta = NULL, *pcur_sta = NULL;
 	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct	mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct wlan_network	*pnetwork	= (struct wlan_network *)pbuf;
-	struct wlan_network	*cur_network = &(pmlmepriv->cur_network);
+	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 
@@ -986,7 +990,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\nrtw_joinbss_event_callback!! _enter_critical\n"));
 
 	if (pnetwork->join_res > 0) {
-		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 			/* s1. find ptarget_wlan */
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
@@ -999,7 +1003,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
 					pcur_sta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
 					if (pcur_sta) {
-						spin_lock_bh(&(pstapriv->sta_hash_lock));
+						spin_lock_bh(&pstapriv->sta_hash_lock);
 						rtw_free_stainfo(adapter,  pcur_sta);
 						spin_unlock_bh(&pstapriv->sta_hash_lock);
 					}
@@ -1091,11 +1095,11 @@ static u8 search_max_mac_id(struct adapter *padapter)
 	u8 mac_id;
 #if defined(CONFIG_88EU_AP_MODE)
 	u8 aid;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 #endif
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 #if defined(CONFIG_88EU_AP_MODE)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
@@ -1133,9 +1137,9 @@ void rtw_stassoc_hw_rpt(struct adapter *adapter, struct sta_info *psta)
 void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 {
 	struct sta_info *psta;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct stassoc_event	*pstassoc = (struct stassoc_event *)pbuf;
-	struct wlan_network	*cur_network = &(pmlmepriv->cur_network);
+	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	struct wlan_network	*ptarget_wlan = NULL;
 
 	if (!rtw_access_ctrl(adapter, pstassoc->macaddr))
@@ -1177,7 +1181,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) ||
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE))) {
 		if (adapter->stapriv.asoc_sta_count == 2) {
-			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.MacAddress);
 			if (ptarget_wlan)
 				ptarget_wlan->fixed = true;
@@ -1197,10 +1201,10 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network *pwlan = NULL;
 	struct wlan_bssid_ex *pdev_network = NULL;
 	u8 *pibss = NULL;
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct	stadel_event *pstadel = (struct stadel_event *)pbuf;
 	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
+	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	psta = rtw_get_stainfo(&adapter->stapriv, pstadel->macaddr);
 	if (psta)
@@ -1238,7 +1242,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 		rtw_free_assoc_resources(adapter);
 		rtw_indicate_disconnect(adapter);
-		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		/*  remove the network entry in scanned_queue */
 		pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
 		if (pwlan) {
@@ -1250,12 +1254,12 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	}
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
 	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-		spin_lock_bh(&(pstapriv->sta_hash_lock));
+		spin_lock_bh(&pstapriv->sta_hash_lock);
 		rtw_free_stainfo(adapter,  psta);
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 
 		if (adapter->stapriv.asoc_sta_count == 1) { /* a sta + bc/mc_stainfo (not Ibss_stainfo) */
-			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			/* free old ibss network */
 			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
 			if (pwlan) {
@@ -1264,7 +1268,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			}
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			/* re-create ibss */
-			pdev_network = &(adapter->registrypriv.dev_network);
+			pdev_network = &adapter->registrypriv.dev_network;
 			pibss = adapter->registrypriv.dev_network.MacAddress;
 
 			memcpy(pdev_network, &tgt_network->network, get_wlan_bssid_ex_sz(&tgt_network->network));
@@ -1458,12 +1462,12 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	int ret;
 	struct list_head *phead;
 	struct adapter *adapter;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	struct	wlan_network	*candidate = NULL;
 	u8	supp_ant_div = false;
 
-	spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 	phead = get_list_head(queue);
 	adapter = (struct adapter *)pmlmepriv->nic_hdl;
 	pmlmepriv->pscanned = phead->next;
@@ -1518,7 +1522,7 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 {
 	struct	cmd_obj *pcmd;
 	struct	setauth_parm *psetauthparm;
-	struct	cmd_priv *pcmdpriv = &(adapter->cmdpriv);
+	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	int		res = _SUCCESS;
 
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
@@ -1553,8 +1557,8 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	u8	keylen;
 	struct cmd_obj		*pcmd;
 	struct setkey_parm	*psetkeyparm;
-	struct cmd_priv		*pcmdpriv = &(adapter->cmdpriv);
-	struct mlme_priv		*pmlmepriv = &(adapter->mlmepriv);
+	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	int	res = _SUCCESS;
 
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
@@ -1590,11 +1594,13 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	switch (psetkeyparm->algorithm) {
 	case _WEP40_:
 		keylen = 5;
-		memcpy(&(psetkeyparm->key[0]), &(psecuritypriv->dot11DefKey[keyid].skey[0]), keylen);
+		memcpy(&psetkeyparm->key[0],
+		       &psecuritypriv->dot11DefKey[keyid].skey[0], keylen);
 		break;
 	case _WEP104_:
 		keylen = 13;
-		memcpy(&(psetkeyparm->key[0]), &(psecuritypriv->dot11DefKey[keyid].skey[0]), keylen);
+		memcpy(&psetkeyparm->key[0],
+		       &psecuritypriv->dot11DefKey[keyid].skey[0], keylen);
 		break;
 	case _TKIP_:
 		keylen = 16;
@@ -1929,7 +1935,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 	struct ht_priv		*phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (!phtpriv->ht_option)
 		return;
-- 
2.19.2

