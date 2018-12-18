Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3621AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA81D218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzV0M7pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbeLRSff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40868 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbeLRSf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so16960345wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjrJiymrhD7SudNTUoAaD2ULOJ2LSNY02wMKonNPu3E=;
        b=SzV0M7pIBd8RaD4yNC1wHFt0DeBYHw7nkLJieOiIkcQLtQ4tkFpbe3dCrSYdHWL2JK
         E8vhsViVbkKiK1ZARiaQ+hR95p6h4beabVLm5CIPP207TLId1iepNyFo3JL/BFOtOpzs
         gyOV8iUpANsXplT3DV02ftVnrnFbrsL9jO3uhDRQ/rlOp1inX21MmcO4AYpbZ7G/3IGy
         KNDO8b4RcD7LbZK10ukbqvUxCf/RzmP+ISPp6RO4bXo6A6dL7dI5ts67KE4V2TpLjJ/3
         4SUtTVBOfng3DtcHP0wnBo2ovrMIWCb1M/n5y6Z5aeKVGE9XJi6GxV1ae4ZwOOy44dVb
         jlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjrJiymrhD7SudNTUoAaD2ULOJ2LSNY02wMKonNPu3E=;
        b=tsPkQAH/yPmWH960W26a4KwTV7gMQ0T+1xonIpSP7+3697jn5jSHx9Qw0UAvEVogqG
         VL0FYwqTRISW3N3JG8Ox20akt6OkVX1imxmo+r2M8+sGjSRgSkbBD5b0XAWqDwdO3H9u
         bqyCGe2Lgc7CGK5IfrLRzY32YrlxISahJNWRfnMJOEgp6iTWz0MhcrmKUzIbqyluXB9R
         Z7HDpCOt/lkIN7RpjRNEbFHolivYPzjkLZkP57G52mAdjOqx3CYb0e7S/pVg0ENLDNIb
         UMyQAwoWbGWjxhDf35TSErksA6r5FFEFSirCfH3mHUHjTgkHJpl0g5QjtWFj243tatQ5
         tYoA==
X-Gm-Message-State: AA+aEWYvYMKLqajNetYNo/zm399dtn3aFyxcsG1HIKQp11HD4gkI8c89
        QOL7+4w69d1FWvq/+mzlgeU=
X-Google-Smtp-Source: AFSGD/VnNIk7YlCE6B5q63ZBi6B+h+XOwIkqcdKsndEnfMSXbO3TL6SJTzmVb8GLOns0uKOIAyfKkw==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr15077145wrw.323.1545158123012;
        Tue, 18 Dec 2018 10:35:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:22 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 16/17] staging: rtl8188eu: add spaces around '&' in rtw_mlme_ext.c
Date:   Tue, 18 Dec 2018 19:34:50 +0100
Message-Id: <20181218183451.18692-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '&' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 90 +++++++++----------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 2a42f80d1970..7a36661ebbed 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -355,7 +355,7 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		int len_diff;
 		u8 *wps_ie;
 		uint wps_ielen;
@@ -503,7 +503,7 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 		return;
 
 #if defined(CONFIG_88EU_AP_MODE)
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		pwps_ie = rtw_get_wps_ie(cur_network->ies+_FIXED_IE_LENGTH_, cur_network->ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 		/* inerset & update wps_probe_resp_ie */
@@ -571,7 +571,7 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 		/*  DS parameter set */
 		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&cur_network->Configuration.DSConfig, &pattrib->pktlen);
 
-		if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+		if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 			u8 erpinfo = 0;
 			u32 ATIMWindow;
 			/*  IBSS Parameter Set... */
@@ -1218,9 +1218,9 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da,
 	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
 		SetFrDs(fctrl);
-	else if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
+	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
 		SetToDs(fctrl);
 
 	if (power_mode)
@@ -1339,9 +1339,9 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
 		SetFrDs(fctrl);
-	else if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
+	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
 		SetToDs(fctrl);
 
 	if (pattrib->mdata)
@@ -1612,7 +1612,7 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 
 			psta = rtw_get_stainfo(pstapriv, raddr);
 			if (psta) {
-				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07]&0xfff) + 1;
+				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07] & 0xfff) + 1;
 
 				DBG_88E("BA_starting_seqctrl=%d for TID=%d\n", start_seq, status & 0x07);
 
@@ -1828,7 +1828,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u16 tid;
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		if (!(pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS))
 			return _SUCCESS;
 
@@ -1840,7 +1840,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
 				DBG_88E("rx agg disable tid(%d)\n", tid);
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
+				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
 			}
@@ -1849,7 +1849,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
 				DBG_88E("tx agg disable tid(%d)\n", tid);
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
+				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			}
@@ -2194,7 +2194,7 @@ static void start_create_ibss(struct adapter *padapter)
 	/* update capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
-	if (caps&cap_IBSS) {/* adhoc master */
+	if (caps & cap_IBSS) {/* adhoc master */
 		val8 = 0xcf;
 		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
@@ -2246,7 +2246,7 @@ static void start_clnt_join(struct adapter *padapter)
 	/* update capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
-	if (caps&cap_ESS) {
+	if (caps & cap_ESS) {
 		Set_MSR(padapter, WIFI_FW_STATION_STATE);
 
 		val8 = (pmlmeinfo->auth_algo == dot11AuthAlgrthm_8021X) ? 0xcc : 0xcf;
@@ -2264,7 +2264,7 @@ static void start_clnt_join(struct adapter *padapter)
 			  msecs_to_jiffies((REAUTH_TO * REAUTH_LIMIT) + (REASSOC_TO * REASSOC_LIMIT) + beacon_timeout));
 
 		pmlmeinfo->state = WIFI_FW_AUTH_NULL | WIFI_FW_STATION_STATE;
-	} else if (caps&cap_IBSS) { /* adhoc client */
+	} else if (caps & cap_IBSS) { /* adhoc client */
 		Set_MSR(padapter, WIFI_FW_ADHOC_STATE);
 
 		val8 = 0xcf;
@@ -2341,7 +2341,7 @@ static unsigned int receive_disconnect(struct adapter *padapter,
 
 	DBG_88E("%s\n", __func__);
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 			report_del_sta_event(padapter, MacAddr, reason);
@@ -2594,7 +2594,7 @@ static unsigned int OnBeacon(struct adapter *padapter,
 			return _SUCCESS;
 		}
 
-		if (((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
+		if (((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
 			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 			if (psta != NULL) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
@@ -2608,7 +2608,7 @@ static unsigned int OnBeacon(struct adapter *padapter,
 				if ((sta_rx_pkts(psta) & 0xf) == 0)
 					update_beacon_info(padapter, pframe, len, psta);
 			}
-		} else if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+		} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 			if (psta != NULL) {
 				/* update WMM, ERP in the beacon */
@@ -2659,7 +2659,7 @@ static unsigned int OnAuth(struct adapter *padapter,
 	u8 *pframe = precv_frame->pkt->data;
 	uint len = precv_frame->pkt->len;
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
 	DBG_88E("+%s\n", __func__);
@@ -2910,7 +2910,7 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	u8 *pframe = precv_frame->pkt->data;
 	uint ie_len, pkt_len = precv_frame->pkt->len;
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
 	frame_type = GetFrameSubType(pframe);
@@ -3035,8 +3035,8 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 			pstat->dot8021xalg = 1;/* psk,  todo:802.1x */
 			pstat->wpa_psk |= BIT(1);
 
-			pstat->wpa2_group_cipher = group_cipher&psecuritypriv->wpa2_group_cipher;
-			pstat->wpa2_pairwise_cipher = pairwise_cipher&psecuritypriv->wpa2_pairwise_cipher;
+			pstat->wpa2_group_cipher = group_cipher & psecuritypriv->wpa2_group_cipher;
+			pstat->wpa2_pairwise_cipher = pairwise_cipher & psecuritypriv->wpa2_pairwise_cipher;
 
 			if (!pstat->wpa2_group_cipher)
 				status = WLAN_STATUS_INVALID_GROUP_CIPHER;
@@ -3056,8 +3056,8 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 			pstat->dot8021xalg = 1;/* psk,  todo:802.1x */
 			pstat->wpa_psk |= BIT(0);
 
-			pstat->wpa_group_cipher = group_cipher&psecuritypriv->wpa_group_cipher;
-			pstat->wpa_pairwise_cipher = pairwise_cipher&psecuritypriv->wpa_pairwise_cipher;
+			pstat->wpa_group_cipher = group_cipher & psecuritypriv->wpa_group_cipher;
+			pstat->wpa_pairwise_cipher = pairwise_cipher & psecuritypriv->wpa_pairwise_cipher;
 
 			if (!pstat->wpa_group_cipher)
 				status = WLAN_STATUS_INVALID_GROUP_CIPHER;
@@ -3153,30 +3153,30 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 					pstat->qos_option = 1;
 					pstat->qos_info = *(p+8);
 
-					pstat->max_sp_len = (pstat->qos_info>>5)&0x3;
+					pstat->max_sp_len = (pstat->qos_info>>5) & 0x3;
 
-					if ((pstat->qos_info&0xf) != 0xf)
+					if ((pstat->qos_info & 0xf) != 0xf)
 						pstat->has_legacy_ac = true;
 					else
 						pstat->has_legacy_ac = false;
 
-					if (pstat->qos_info&0xf) {
-						if (pstat->qos_info&BIT(0))
+					if (pstat->qos_info & 0xf) {
+						if (pstat->qos_info & BIT(0))
 							pstat->uapsd_vo = BIT(0)|BIT(1);
 						else
 							pstat->uapsd_vo = 0;
 
-						if (pstat->qos_info&BIT(1))
+						if (pstat->qos_info & BIT(1))
 							pstat->uapsd_vi = BIT(0)|BIT(1);
 						else
 							pstat->uapsd_vi = 0;
 
-						if (pstat->qos_info&BIT(2))
+						if (pstat->qos_info & BIT(2))
 							pstat->uapsd_bk = BIT(0)|BIT(1);
 						else
 							pstat->uapsd_bk = 0;
 
-						if (pstat->qos_info&BIT(3))
+						if (pstat->qos_info & BIT(3))
 							pstat->uapsd_be = BIT(0)|BIT(1);
 						else
 							pstat->uapsd_be = 0;
@@ -3203,14 +3203,14 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	} else {
 		pstat->flags &= ~WLAN_STA_HT;
 	}
-	if ((!pmlmepriv->htpriv.ht_option) && (pstat->flags&WLAN_STA_HT)) {
+	if ((!pmlmepriv->htpriv.ht_option) && (pstat->flags & WLAN_STA_HT)) {
 		status = _STATS_FAILURE_;
 		goto OnAssocReqFail;
 	}
 
 	if ((pstat->flags & WLAN_STA_HT) &&
-	    ((pstat->wpa2_pairwise_cipher&WPA_CIPHER_TKIP) ||
-	    (pstat->wpa_pairwise_cipher&WPA_CIPHER_TKIP))) {
+	    ((pstat->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
+	    (pstat->wpa_pairwise_cipher & WPA_CIPHER_TKIP))) {
 		DBG_88E("HT: %pM tried to "
 			"use TKIP with HT association\n", pstat->hwaddr);
 
@@ -3365,7 +3365,7 @@ static unsigned int OnAssocRsp(struct adapter *padapter,
 	pmlmeinfo->slotTime = (pmlmeinfo->capability & BIT(10)) ? 9 : 20;
 
 	/* AID */
-	pmlmeinfo->aid = (int)(le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 4))&0x3fff);
+	pmlmeinfo->aid = (int)(le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 4)) & 0x3fff);
 	res = pmlmeinfo->aid;
 
 	/* following are moved to join event callback function */
@@ -3596,7 +3596,7 @@ static unsigned int OnAction_back(struct adapter *padapter,
 
 	DBG_88E("%s\n", __func__);
 
-	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		if (!(pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS))
 			return _SUCCESS;
 
@@ -3661,7 +3661,7 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 	struct adapter *adapter = recv_frame->adapter;
 	struct mlme_ext_priv *mlmeext = &adapter->mlmeextpriv;
 	u8 *frame = recv_frame->pkt->data;
-	u16 seq_ctrl = ((recv_frame->attrib.seq_num&0xffff) << 4) |
+	u16 seq_ctrl = ((recv_frame->attrib.seq_num & 0xffff) << 4) |
 		(recv_frame->attrib.frag_num & 0xf);
 
 	if (GetRetry(frame)) {
@@ -4474,7 +4474,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		goto exit_mlmeext_joinbss_event_callback;
 	}
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		/* for bc/mc */
 		psta_bmc = rtw_get_bcmc_stainfo(padapter);
 		if (psta_bmc) {
@@ -4522,7 +4522,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	join_type = 2;
 	rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		/*  correcting TSF */
 		correct_TSF(padapter, pmlmeext);
 	}
@@ -4541,7 +4541,7 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 
 	DBG_88E("%s\n", __func__);
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {/* adhoc master or sta_count>1 */
 			/* nothing to do */
 		} else { /* adhoc client */
@@ -5048,7 +5048,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	/* restore to initial setting. */
 	update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
 
-	if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
+	if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)) {
 		/* Stop BCN */
 		val8 = 0;
 		rtw_hal_set_hwreg(padapter, HW_VAR_BCN_FUNC, (u8 *)(&val8));
@@ -5248,7 +5248,7 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 
 	DBG_88E_LEVEL(_drv_info_, "set pairwise key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) camid:%d\n",
 		      pparm->algorithm, cam_id);
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
@@ -5305,7 +5305,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 		return H2C_SUCCESS;
 
 	if (((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && (pmlmeinfo->HT_enable)) ||
-	    ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
+	    ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)) {
 		issue_action_BA(padapter, pparm->addr, RTW_WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid);
 		mod_timer(&psta->addba_retry_timer,
 			  jiffies + msecs_to_jiffies(ADDBA_TO));
@@ -5360,8 +5360,8 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	void (*event_callback)(struct adapter *dev, u8 *pbuf);
 
 	peventbuf = (uint *)pbuf;
-	evt_sz = (u16)(*peventbuf&0xffff);
-	evt_code = (u8)((*peventbuf>>16)&0xff);
+	evt_sz = (u16)(*peventbuf & 0xffff);
+	evt_code = (u8)((*peventbuf>>16) & 0xff);
 
 	/*  checking if event code is valid */
 	if (evt_code >= MAX_C2HEVT) {
@@ -5407,7 +5407,7 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 		if (!psta_bmc)
 			return H2C_SUCCESS;
 
-		if ((pstapriv->tim_bitmap&BIT(0)) && (psta_bmc->sleepq_len > 0)) {
+		if ((pstapriv->tim_bitmap & BIT(0)) && (psta_bmc->sleepq_len > 0)) {
 			msleep(10);/*  10ms, ATIM(HIQ) Windows */
 			spin_lock_bh(&psta_bmc->sleep_q.lock);
 
-- 
2.20.1

