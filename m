Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF90BECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C20420867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5zhrVf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C20420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbeIRNjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:39:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35133 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIRNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:39:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so1564123wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MOFBUbk7yvZkIuTkcwzyuDnZkrG0pVuJ7UCyc82oRS0=;
        b=J5zhrVf5GnkR9jZbPu2+yYM9CGyuOkOsMhZt94BSH5b99WNJoQBsfNPh9d6HTaqUxq
         Bag7j+AtqM4CqCYJW4l/D/87WntzfEwnvw3eMl8uGZiQsEYjrMrB8ZYRuK3hsAhUy9O/
         WxEJflSl8HxmaY/VObnroo5Ke6qAbOuVcQOQ5AgBydCasEzdpHQK6z2xSmILx6kmf2gg
         ZGhyh8q2ToXfVHh81ap8HcQJXv8eD4DbrVB5mv1ijrCplCmeUUHGKi7j3khSEq5PHwnC
         sqR5mMsplCCyFfF/SgvEByOSdTUXNlTut/W8JNXl6lbSvxfdu8OK52YpXe01olRufSJl
         whsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOFBUbk7yvZkIuTkcwzyuDnZkrG0pVuJ7UCyc82oRS0=;
        b=PbZ5dfoFRpVHdKLX6a35DoSqOahoZwFVzvGXIXmfwQUyqlynIY4XM8Tfi2TgJR50Fe
         2KDPHD8PTWkAf7kRMuVRiMyN6mBeSc+zRR0CKAfXo9F4GQ3jfu/X2xkGn/WO+xQVdyyf
         fug6+apLworVdkDsQIqSHbVIJkWyxKzldZK8It6Gd/uiMab5AjPIcmcT9emybsqoqSpZ
         Ik8HRXa6PX4x0Ar3BMDtxNklwiiO//r08p65IhoFDdGa+y8I/qwhXRHSk9lt0hhTaixB
         x03wX1bMNM4B5l71s9OQesBLzpd17/joySI6NnJ4wS0mO2nsqLG4Ot0rCyj/Yy48PgBj
         58sQ==
X-Gm-Message-State: APzg51D/iFO9jCSQRdbqb4kH31eLLW4e+d/8ob6BV37+G0VwercGaW3D
        jjFIfyJxOunZureG3d81O/4=
X-Google-Smtp-Source: ANB0VdadbLDhXH3D3QCJKFstDbLxamWC6IXxFq6zhDc9mHayrF6JRiz5diwzZR7ZW8iONJQ4OAF7EQ==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr13661718wmd.6.1537258058347;
        Tue, 18 Sep 2018 01:07:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id r140-v6sm1386869wmd.7.2018.09.18.01.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:07:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/8] staging: rtl8188eu: remove unnecessary parentheses
Date:   Tue, 18 Sep 2018 10:07:05 +0200
Message-Id: <20180918080711.21594-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180918080711.21594-1-straube.linux@gmail.com>
References: <20180918080711.21594-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses as reported by checkpatch
and from conditionals.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_ioctl_set.c    | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index 0880f18520a0..9b67f33cb568 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -17,11 +17,11 @@ u8 rtw_do_join(struct adapter *padapter)
 {
 	struct list_head *plist, *phead;
 	u8 *pibss = NULL;
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	u8 ret = _SUCCESS;
 
-	spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 	phead = get_list_head(queue);
 	plist = phead->next;
 
@@ -36,7 +36,7 @@ u8 rtw_do_join(struct adapter *padapter)
 	pmlmepriv->to_join = true;
 
 	if (list_empty(&queue->queue)) {
-		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
 		/* when set_ssid/set_bssid for rtw_do_join(), but scanning queue is empty */
@@ -60,7 +60,7 @@ u8 rtw_do_join(struct adapter *padapter)
 	} else {
 		int select_ret;
 
-		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 		select_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
 		if (select_ret == _SUCCESS) {
 			pmlmepriv->to_join = false;
@@ -71,7 +71,7 @@ u8 rtw_do_join(struct adapter *padapter)
 				/*  submit createbss_cmd to change to a ADHOC_MASTER */
 
 				/* pmlmepriv->lock has been acquired by caller... */
-				struct wlan_bssid_ex    *pdev_network = &(padapter->registrypriv.dev_network);
+				struct wlan_bssid_ex    *pdev_network = &padapter->registrypriv.dev_network;
 
 				pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
@@ -172,7 +172,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	if (padapter->securitypriv.btkip_countermeasure) {
 		cur_time = jiffies;
 
-		if ((cur_time - padapter->securitypriv.btkip_countermeasure_time) > 60 * HZ) {
+		if (cur_time - padapter->securitypriv.btkip_countermeasure_time > 60 * HZ) {
 			padapter->securitypriv.btkip_countermeasure = false;
 			padapter->securitypriv.btkip_countermeasure_time = 0;
 		} else {
@@ -229,8 +229,8 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
 			 ("set_ssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
 
-		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
-		    (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength))) {
+		if (pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength &&
+		    !memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength)) {
 			if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)) {
 				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
 					 ("Set SSID is the same ssid, fw_state = 0x%08x\n",
@@ -279,7 +279,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	if (padapter->securitypriv.btkip_countermeasure) {
 		cur_time = jiffies;
 
-		if ((cur_time - padapter->securitypriv.btkip_countermeasure_time) > 60 * HZ) {
+		if (cur_time - padapter->securitypriv.btkip_countermeasure_time > 60 * HZ) {
 			padapter->securitypriv.btkip_countermeasure = false;
 			padapter->securitypriv.btkip_countermeasure_time = 0;
 		} else {
@@ -310,7 +310,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 {
 	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct	wlan_network	*cur_network = &pmlmepriv->cur_network;
-	enum ndis_802_11_network_infra *pold_state = &(cur_network->network.InfrastructureMode);
+	enum ndis_802_11_network_infra *pold_state = &cur_network->network.InfrastructureMode;
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
 		 ("+rtw_set_802_11_infrastructure_mode: old =%d new =%d fw_state = 0x%08x\n",
@@ -331,15 +331,15 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 #endif
 		}
 
-		if ((check_fwstate(pmlmepriv, _FW_LINKED)) ||
-		    (*pold_state == Ndis802_11IBSS))
+		if (check_fwstate(pmlmepriv, _FW_LINKED) ||
+		    *pold_state == Ndis802_11IBSS)
 			rtw_disassoc_cmd(padapter, 0, true);
 
-		if ((check_fwstate(pmlmepriv, _FW_LINKED)) ||
-		    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)))
+		if (check_fwstate(pmlmepriv, _FW_LINKED) ||
+		    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
 			rtw_free_assoc_resources(padapter);
 
-		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
+		if (*pold_state == Ndis802_11Infrastructure || *pold_state == Ndis802_11IBSS) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
 				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether  issue dis-assoc_cmd or not */
 	       }
@@ -409,8 +409,8 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 		goto exit;
 	}
 
-	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING)) ||
-	    (pmlmepriv->LinkDetectInfo.bBusyTraffic)) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) ||
+	    pmlmepriv->LinkDetectInfo.bBusyTraffic) {
 		/*  Scan or linking is in progress, do nothing. */
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("%s fail since fw_state = %x\n", __func__, get_fwstate(pmlmepriv)));
 		res = true;
@@ -468,7 +468,7 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 {
 	int		keyid, res;
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	u8		ret = _SUCCESS;
 
 	keyid = wep->KeyIndex & 0x3fffffff;
@@ -497,7 +497,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 		 ("rtw_set_802_11_add_wep:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
 		 wep->KeyLength, wep->KeyIndex, keyid));
 
-	memcpy(&(psecuritypriv->dot11DefKey[keyid].skey[0]), &(wep->KeyMaterial), wep->KeyLength);
+	memcpy(&psecuritypriv->dot11DefKey[keyid].skey[0], &wep->KeyMaterial, wep->KeyLength);
 
 	psecuritypriv->dot11DefKeylen[keyid] = wep->KeyLength;
 
@@ -539,15 +539,15 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	u8	*p;
 	u16	rate = 0, max_rate = 0;
 	struct mlme_ext_priv	*pmlmeext = &adapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
 	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	u8	bw_40MHz = 0, short_GI_20 = 0, short_GI_40 = 0;
 	u32	ht_ielen = 0;
 
-	if ((!check_fwstate(pmlmepriv, _FW_LINKED)) &&
-	    (!check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)))
+	if (!check_fwstate(pmlmepriv, _FW_LINKED) &&
+	    !check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
 		return 0;
 
 	if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N|WIRELESS_11_5N)) {
@@ -561,14 +561,14 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 
 			max_rate = rtw_mcs_rate(
 				RF_1T1R,
-				bw_40MHz & (pregistrypriv->cbw40_enable),
+				bw_40MHz & pregistrypriv->cbw40_enable,
 				short_GI_20,
 				short_GI_40,
 				pmlmeinfo->HT_caps.mcs.rx_mask
 			);
 		}
 	} else {
-		while ((pcur_bss->SupportedRates[i] != 0) && (pcur_bss->SupportedRates[i] != 0xFF)) {
+		while (pcur_bss->SupportedRates[i] != 0 && pcur_bss->SupportedRates[i] != 0xFF) {
 			rate = pcur_bss->SupportedRates[i]&0x7F;
 			if (rate > max_rate)
 				max_rate = rate;
-- 
2.19.0

