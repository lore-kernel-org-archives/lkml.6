Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53789C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA5E20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAoNbhvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA5E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeKXH1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:27:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33984 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeKXH1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:27:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so8287595wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shqGV9z7h0Lw4VQKmR7E42fPCP9C0ijFMJUBe3EVmyQ=;
        b=dAoNbhvVSFsLYxYQl5tnNP1RSXUWX1nAKcSKrF4Ymac7UnXc4XXz0pdOP0rkG1naq5
         RE7oHwwkFJUF0KFCIECsxQ4+VZlws1jHc7p8jJfALy9OhtUEhpn/Zs1ogXWB3EBYJP4h
         BX0L40SVjvgbEvDCA/8xiX3DtJWr6VbebPCMIa6oYECEH+Sr7fm3E+rSxb3F76GoysRx
         iWmCI7aeT6AjY0n49GaP1Eke5ghP/asEFlOWlBsyHsjWJO5GNJ+iEshWntYcIxslpCfo
         WUGqrwm4EW5l5oSjiBPLXQKWCBVH8dsDOU8k8ZgzAgCXj9gfkh2zQ7XEjjhI3TmbkM0b
         W9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shqGV9z7h0Lw4VQKmR7E42fPCP9C0ijFMJUBe3EVmyQ=;
        b=XpKQiVr+9L27Wc2YVMXFRpcVdfOIIljMsfXHD0CHQC/WCwdbH2wp9D70AjdrTTK0N9
         8dImSR/sJF+RI3fMYBTpMdMbh8YskkmrRJj6uf4qqO17wDq92tvV02451UxjMi9pzON1
         p3OABhOiIil11Pr8huaCX1KYxX1IZxWKHe/BgaNqIJH5E8TegpURs1AZv4Px+l2MU+Hy
         j0gK9mb8lmFez/b0i8HiOyfHZAeJj26EviW4RBXm+Cig7pc6mPH48EN28br/3CBUiyEz
         TJGCv4+yh32LCCdRTPsgWv6sLB1yIfzMi5Avl1GE6GkbtzupJgCRUDqs8PUcI12nDxA5
         JfdQ==
X-Gm-Message-State: AA+aEWbTdqickl4xCha4PNGgSROzONlRPnpQW7rpTi9/VfoBJYmFDKXC
        WEHiz2FlQ80bu5+zkGCCOQE=
X-Google-Smtp-Source: AFSGD/WV3EVPK/f5hM2fomRh7pgcRiP+tOnvJ2pmXVIrwWYYGpZbOZy97FM5N9G6WdnzvjThCOPfjw==
X-Received: by 2002:a1c:b98e:: with SMTP id j136mr15894564wmf.9.1543005680153;
        Fri, 23 Nov 2018 12:41:20 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i9sm24598906wrs.34.2018.11.23.12.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 12:41:19 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/9] staging: rtl8188eu: use __func__ in rtw_mlme.c
Date:   Fri, 23 Nov 2018 21:41:00 +0100
Message-Id: <20181123204106.2284-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123204106.2284-1-straube.linux@gmail.com>
References: <20181123204106.2284-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __func__ instead of hardcoded function names.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 48 +++++++++++++----------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index d5c22a028905..54f05e62da49 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -230,8 +230,9 @@ int rtw_if_up(struct adapter *padapter)
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
 	    !check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-			 ("rtw_if_up:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
-			 padapter->bDriverStopped, padapter->bSurpriseRemoved));
+			 ("%s:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
+			  __func__, padapter->bDriverStopped,
+			  padapter->bSurpriseRemoved));
 		res = false;
 	} else {
 		res =  true;
@@ -555,11 +556,13 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_survey_event_callback, ssid=%s\n",  pnetwork->Ssid.Ssid));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
+		 ("%s, ssid=%s\n", __func__, pnetwork->Ssid.Ssid));
 
 	len = get_wlan_bssid_ex_sz(pnetwork);
 	if (len > (sizeof(struct wlan_bssid_ex))) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n****rtw_survey_event_callback: return a wrong bss ***\n"));
+		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
+			 ("\n****%s: return a wrong bss ***\n", __func__));
 		return;
 	}
 	spin_lock_bh(&pmlmepriv->lock);
@@ -606,7 +609,8 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		pmlmepriv->wps_probe_req_ie = NULL;
 	}
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_surveydone_event_callback: fw_state:%x\n\n", get_fwstate(pmlmepriv)));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
+		 ("%s: fw_state:%x\n\n", __func__, get_fwstate(pmlmepriv)));
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		del_timer_sync(&pmlmepriv->scan_to_timer);
@@ -695,7 +699,7 @@ static void free_scanqueue(struct	mlme_priv *pmlmepriv)
 	struct __queue *scan_queue = &pmlmepriv->scanned_queue;
 	struct list_head *plist, *phead, *ptemp;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+free_scanqueue\n"));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+%s\n", __func__));
 	spin_lock_bh(&scan_queue->lock);
 	spin_lock_bh(&free_queue->lock);
 
@@ -808,7 +812,7 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_disconnect\n"));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+%s\n", __func__));
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING | WIFI_UNDER_WPS);
 
@@ -1159,12 +1163,15 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
 	if (psta) {
 		/* the sta have been in sta_info_queue => do nothing */
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
+		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
+			 ("Error: %s: sta has been in sta_hash_queue\n",
+			  __func__));
 		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
 	}
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
 	if (!psta) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
+		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
+			 ("Can't alloc sta_info when %s\n", __func__));
 		return;
 	}
 	/* to do: init sta_info variable */
@@ -1293,7 +1300,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 void rtw_cpwm_event_callback(struct adapter *padapter, u8 *pbuf)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_cpwm_event_callback !!!\n"));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+%s !!!\n", __func__));
 }
 
 /*
@@ -1574,22 +1581,23 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n rtw_set_key: psetkeyparm->algorithm=(unsigned char)psecuritypriv->dot118021XGrpPrivacy=%d\n",
-			 psetkeyparm->algorithm));
+			 ("\n %s: psetkeyparm->algorithm=(unsigned char)psecuritypriv->dot118021XGrpPrivacy=%d\n",
+			  __func__, psetkeyparm->algorithm));
 	} else {
 		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm;
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n rtw_set_key: psetkeyparm->algorithm=(u8)psecuritypriv->dot11PrivacyAlgrthm=%d\n",
-			 psetkeyparm->algorithm));
+			 ("\n %s: psetkeyparm->algorithm=(u8)psecuritypriv->dot11PrivacyAlgrthm=%d\n",
+			  __func__, psetkeyparm->algorithm));
 	}
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
 	psetkeyparm->set_tx = set_tx;
 	pmlmepriv->key_mask |= BIT(psetkeyparm->keyid);
-	DBG_88E("==> rtw_set_key algorithm(%x), keyid(%x), key_mask(%x)\n",
-		psetkeyparm->algorithm, psetkeyparm->keyid, pmlmepriv->key_mask);
+	DBG_88E("==> %s algorithm(%x), keyid(%x), key_mask(%x)\n",
+		__func__, psetkeyparm->algorithm, psetkeyparm->keyid,
+		pmlmepriv->key_mask);
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-		 ("\n rtw_set_key: psetkeyparm->algorithm=%d psetkeyparm->keyid=(u8)keyid=%d\n",
-		 psetkeyparm->algorithm, keyid));
+		 ("\n %s: psetkeyparm->algorithm=%d psetkeyparm->keyid=(u8)keyid=%d\n",
+		  __func__, psetkeyparm->algorithm, keyid));
 
 	switch (psetkeyparm->algorithm) {
 	case _WEP40_:
@@ -1614,8 +1622,8 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 		break;
 	default:
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n rtw_set_key:psecuritypriv->dot11PrivacyAlgrthm=%x (must be 1 or 2 or 4 or 5)\n",
-			 psecuritypriv->dot11PrivacyAlgrthm));
+			 ("\n %s:psecuritypriv->dot11PrivacyAlgrthm=%x (must be 1 or 2 or 4 or 5)\n",
+			  __func__, psecuritypriv->dot11PrivacyAlgrthm));
 		res = _FAIL;
 		goto err_free_parm;
 	}
-- 
2.19.2

