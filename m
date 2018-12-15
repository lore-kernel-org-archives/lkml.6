Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA1AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D262171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrB2C2MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeLOQrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:47:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55247 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeLOQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:46:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so8453601wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AeQo/UQIzVrMt3x9MnwlbH1BwEObuQEcL5KRC6fkZ74=;
        b=SrB2C2MSi2ArVyWL/CwnqsVgqf7rMLvSZeRvcROe0Cq7rT3m9GaAay+PSBVpCj1VSd
         mdQBdjCs5MM77ZiFg/zte1PDu7tEsaxySD2RCwLyUzywGgHzK2T66bjkyD3xrAz15TCT
         VjCng/JD2v0FWiFGPrIV1l4e70IA3AVjLuYNFC+rmg96NOK3lfOb5l9WxpTd87VRdYVq
         aS32KqiJPAYzv3e9C7xeSQ3ubHfvlxUIX0ceZvySwUi8QNMv+ISTexZL9BcXQFMYRacV
         /CDS8YoyXSkbzO0I1XRSgYScLmItgg+WLfVznRUmpHkYZjP8xulXDgTI/+08H5vIlk5O
         Kaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AeQo/UQIzVrMt3x9MnwlbH1BwEObuQEcL5KRC6fkZ74=;
        b=ZrzhnH1sPcaYzOVR1ufaxyzt1LiWCzMFujjW/2s8SgieuM9saPT+QPy/Ec1kSpPcK7
         r71SqclD7QSaBvPAktU5nvwT+VarQzHs3sVS2eJyMOlaDa0TaojbFGedp4wRW/+AevqH
         dMuuhuvlN0m8Lcs2zJWSeSIGG3LShonFLQ4mmAXxGhRlOWMwwLlgKcrquAzQ+SR+pwzf
         PMSxer86J/w6U697QY0VXYOO1aeWK0e5K/Qs/lOXXMLcQvBlUOE1cffJfmVExRwAOStw
         qNsJ4e2rJcqS982S2ntywgqCIeUlAb98kM6ndmjU/9fvla1vKm1hB8ecIGhwBHX7zRbP
         Wiqw==
X-Gm-Message-State: AA+aEWb9GBnV2pGp6qdwxmxS3LMf500sY3RsmgZ/nnsBbpjFcedUe5kb
        kJoCubAbpT8DSC0j9Bnvdqg=
X-Google-Smtp-Source: AFSGD/VAsuGTz+zLhSk8/YVGiJl6dBFuV45d2Npv8lNusiE9CgH4hnxQmnt1+qaUFkK+uS5tGAie6g==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr6271746wmj.48.1544892388999;
        Sat, 15 Dec 2018 08:46:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i186sm8820935wmd.19.2018.12.15.08.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 08:46:28 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/9] staging: rtl8188eu: remove unnecessary parentheses in rtw_mlme_ext.c
Date:   Sat, 15 Dec 2018 17:46:09 +0100
Message-Id: <20181215164616.2643-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215164616.2643-1-straube.linux@gmail.com>
References: <20181215164616.2643-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 324 +++++++++---------
 1 file changed, 162 insertions(+), 162 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 4996227b6a2e..16c449d2e6c2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -184,7 +184,7 @@ Following are some TX functions for WiFi MLME
 
 void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 {
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	pmlmeext->tx_rate = rate;
 	DBG_88E("%s(): rate = %x\n", __func__, rate);
@@ -192,7 +192,7 @@ void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 
 void update_mgntframe_attrib(struct adapter *padapter, struct pkt_attrib *pattrib)
 {
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	memset((u8 *)(pattrib), 0, sizeof(struct pkt_attrib));
 
@@ -319,11 +319,11 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned int rate_len;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -349,7 +349,7 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	*(fctrl) = 0;
 
 	ether_addr_copy(pwlanhdr->addr1, bc_addr);
-	ether_addr_copy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)));
+	ether_addr_copy(pwlanhdr->addr2, myid(&padapter->eeprompriv));
 	ether_addr_copy(pwlanhdr->addr3, cur_network->MacAddress);
 
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
@@ -413,7 +413,7 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, min_t(unsigned int, rate_len, 8), cur_network->SupportedRates, &pattrib->pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&cur_network->Configuration.DSConfig, &pattrib->pktlen);
 
 	{
 		u8 erpinfo = 0;
@@ -460,15 +460,15 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned char *mac, *bssid;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 #if defined(CONFIG_88EU_AP_MODE)
 	u8 *pwps_ie;
 	uint wps_ielen;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 #endif
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 	unsigned int rate_len;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -486,7 +486,7 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	mac = myid(&(padapter->eeprompriv));
+	mac = myid(&padapter->eeprompriv);
 	bssid = cur_network->MacAddress;
 
 	fctrl = &pwlanhdr->frame_control;
@@ -573,7 +573,7 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, min_t(unsigned int, rate_len, 8), cur_network->SupportedRates, &pattrib->pktlen);
 
 		/*  DS parameter set */
-		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&cur_network->Configuration.DSConfig, &pattrib->pktlen);
 
 		if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 			u8 erpinfo = 0;
@@ -610,9 +610,9 @@ static int issue_probereq(struct adapter *padapter,
 	__le16 *fctrl;
 	unsigned char *mac;
 	unsigned char bssrate[NumRates];
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	int bssrate_len = 0;
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
@@ -631,7 +631,7 @@ static int issue_probereq(struct adapter *padapter,
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	mac = myid(&(padapter->eeprompriv));
+	mac = myid(&padapter->eeprompriv);
 
 	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
@@ -656,17 +656,17 @@ static int issue_probereq(struct adapter *padapter,
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if (pssid)
-		pframe = rtw_set_ie(pframe, _SSID_IE_, pssid->SsidLength, pssid->Ssid, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SSID_IE_, pssid->SsidLength, pssid->Ssid, &pattrib->pktlen);
 	else
-		pframe = rtw_set_ie(pframe, _SSID_IE_, 0, NULL, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SSID_IE_, 0, NULL, &pattrib->pktlen);
 
 	get_rate_set(padapter, bssrate, &bssrate_len);
 
 	if (bssrate_len > 8) {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, bssrate_len - 8, bssrate + 8, &pattrib->pktlen);
 	} else {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &pattrib->pktlen);
 	}
 
 	/* add wps_ie for wps2.0 */
@@ -749,10 +749,10 @@ static void issue_auth(struct adapter *padapter, struct sta_info *psta,
 	__le16 le_val16;
 #endif
 	int use_shared_key = 0;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (pmgntframe == NULL)
@@ -782,9 +782,9 @@ static void issue_auth(struct adapter *padapter, struct sta_info *psta,
 
 		ether_addr_copy(pwlanhdr->addr1, psta->hwaddr);
 		ether_addr_copy(pwlanhdr->addr2,
-				myid(&(padapter->eeprompriv)));
+				myid(&padapter->eeprompriv));
 		ether_addr_copy(pwlanhdr->addr3,
-				myid(&(padapter->eeprompriv)));
+				myid(&padapter->eeprompriv));
 
 		/*  setting auth algo number */
 		val16 = (u16)psta->authalg;
@@ -816,7 +816,7 @@ static void issue_auth(struct adapter *padapter, struct sta_info *psta,
 
 		/*  added challenging text... */
 		if ((psta->auth_seq == 2) && (psta->state & WIFI_FW_AUTH_STATE) && (use_shared_key == 1))
-			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, psta->chg_txt, &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, psta->chg_txt, &pattrib->pktlen);
 #endif
 	} else {
 		__le32 le_tmp32;
@@ -858,7 +858,7 @@ static void issue_auth(struct adapter *padapter, struct sta_info *psta,
 
 		/*  then checking to see if sending challenging text... */
 		if ((pmlmeinfo->auth_seq == 3) && (pmlmeinfo->state & WIFI_FW_AUTH_STATE) && (use_shared_key == 1)) {
-			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, pmlmeinfo->chg_txt, &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, pmlmeinfo->chg_txt, &pattrib->pktlen);
 
 			SetPrivacy(fctrl);
 
@@ -889,11 +889,11 @@ static void issue_asocrsp(struct adapter *padapter, unsigned short status,
 	unsigned char *pbuf, *pframe;
 	unsigned short val;
 	__le16 *fctrl;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	u8 *ie = pnetwork->ies;
 	__le16 lestatus, leval;
 
@@ -917,7 +917,7 @@ static void issue_asocrsp(struct adapter *padapter, unsigned short status,
 
 	ether_addr_copy((void *)GetAddr1Ptr(pwlanhdr), pstat->hwaddr);
 	ether_addr_copy((void *)GetAddr2Ptr(pwlanhdr),
-			myid(&(padapter->eeprompriv)));
+			myid(&padapter->eeprompriv));
 	ether_addr_copy((void *)GetAddr3Ptr(pwlanhdr), pnetwork->MacAddress);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -944,10 +944,10 @@ static void issue_asocrsp(struct adapter *padapter, unsigned short status,
 	pframe = rtw_set_fixed_ie(pframe, _ASOC_ID_, &leval, &pattrib->pktlen);
 
 	if (pstat->bssratelen <= 8) {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, pstat->bssratelen, pstat->bssrateset, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, pstat->bssratelen, pstat->bssrateset, &pattrib->pktlen);
 	} else {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, pstat->bssrateset, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (pstat->bssratelen-8), pstat->bssrateset+8, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, pstat->bssrateset, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (pstat->bssratelen-8), pstat->bssrateset+8, &pattrib->pktlen);
 	}
 
 	if ((pstat->flags & WLAN_STA_HT) && (pmlmepriv->htpriv.ht_option)) {
@@ -990,7 +990,7 @@ static void issue_asocrsp(struct adapter *padapter, unsigned short status,
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
-		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &pattrib->pktlen);
 
 	/* add WPS IE ie for wps 2.0 */
 	if (pmlmepriv->wps_assoc_resp_ie && pmlmepriv->wps_assoc_resp_ie_len > 0) {
@@ -1017,12 +1017,12 @@ static void issue_assocreq(struct adapter *padapter)
 	unsigned char bssrate[NumRates], sta_bssrate[NumRates];
 	struct ndis_802_11_var_ie *pIE;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	int bssrate_len = 0, sta_bssrate_len = 0;
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -1039,7 +1039,7 @@ static void issue_assocreq(struct adapter *padapter)
 	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 	ether_addr_copy(pwlanhdr->addr1, pnetwork->MacAddress);
-	ether_addr_copy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)));
+	ether_addr_copy(pwlanhdr->addr2, myid(&padapter->eeprompriv));
 	ether_addr_copy(pwlanhdr->addr3, pnetwork->MacAddress);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -1063,7 +1063,7 @@ static void issue_assocreq(struct adapter *padapter)
 	pattrib->pktlen += 2;
 
 	/* SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_,  pmlmeinfo->network.Ssid.SsidLength, pmlmeinfo->network.Ssid.Ssid, &(pattrib->pktlen));
+	pframe = rtw_set_ie(pframe, _SSID_IE_,  pmlmeinfo->network.Ssid.SsidLength, pmlmeinfo->network.Ssid.Ssid, &pattrib->pktlen);
 
 	/* supported rate & extended supported rate */
 
@@ -1110,16 +1110,16 @@ static void issue_assocreq(struct adapter *padapter)
 	}
 
 	if (bssrate_len > 8) {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, bssrate_len - 8, bssrate + 8, &pattrib->pktlen);
 	} else {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &pattrib->pktlen);
 	}
 
 	/* RSN */
 	p = rtw_get_ie((pmlmeinfo->network.ies + sizeof(struct ndis_802_11_fixed_ie)), _RSN_IE_2_, &ie_len, (pmlmeinfo->network.ie_length - sizeof(struct ndis_802_11_fixed_ie)));
 	if (p)
-		pframe = rtw_set_ie(pframe, _RSN_IE_2_, ie_len, (p + 2), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _RSN_IE_2_, ie_len, (p + 2), &pattrib->pktlen);
 
 	/* HT caps */
 	if (padapter->mlmepriv.htpriv.ht_option) {
@@ -1139,7 +1139,7 @@ static void issue_assocreq(struct adapter *padapter)
 			if (pregpriv->rx_stbc)
 				pmlmeinfo->HT_caps.cap_info |= cpu_to_le16(0x0100);/* RX STBC One spatial stream */
 			memcpy((u8 *)&pmlmeinfo->HT_caps.mcs, MCS_rate_1R, 16);
-			pframe = rtw_set_ie(pframe, _HT_CAPABILITY_IE_, ie_len, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, _HT_CAPABILITY_IE_, ie_len, (u8 *)(&pmlmeinfo->HT_caps), &pattrib->pktlen);
 		}
 	}
 
@@ -1159,7 +1159,7 @@ static void issue_assocreq(struct adapter *padapter)
 					if (!memcmp(pIE->data, WPS_OUI, 4))
 						pIE->Length = 14;
 				}
-				pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, pIE->Length, pIE->data, &(pattrib->pktlen));
+				pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, pIE->Length, pIE->data, &pattrib->pktlen);
 			}
 			break;
 		default:
@@ -1168,7 +1168,7 @@ static void issue_assocreq(struct adapter *padapter)
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
-		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &pattrib->pktlen);
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 	dump_mgntframe(padapter, pmgntframe);
@@ -1200,10 +1200,10 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da,
 	if (!padapter)
 		goto exit;
 
-	pxmitpriv = &(padapter->xmitpriv);
-	pmlmeext = &(padapter->mlmeextpriv);
-	pmlmeinfo = &(pmlmeext->mlmext_info);
-	pnetwork = &(pmlmeinfo->network);
+	pxmitpriv = &padapter->xmitpriv;
+	pmlmeext = &padapter->mlmeextpriv;
+	pmlmeinfo = &pmlmeext->mlmext_info;
+	pnetwork = &pmlmeinfo->network;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -1231,7 +1231,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da,
 		SetPwrMgt(fctrl);
 
 	ether_addr_copy(pwlanhdr->addr1, da);
-	ether_addr_copy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)));
+	ether_addr_copy(pwlanhdr->addr2, myid(&padapter->eeprompriv));
 	ether_addr_copy(pwlanhdr->addr3, pnetwork->MacAddress);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -1262,9 +1262,9 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da,
 	int ret;
 	int i = 0;
 	unsigned long start = jiffies;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	/* da == NULL, assume it's null data for sta to ap*/
 	if (da == NULL)
@@ -1314,10 +1314,10 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned short *qc;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	DBG_88E("%s\n", __func__);
 
@@ -1360,7 +1360,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	SetAckpolicy(qc, pattrib->ack_policy);
 
 	ether_addr_copy(pwlanhdr->addr1, da);
-	ether_addr_copy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)));
+	ether_addr_copy(pwlanhdr->addr2, myid(&padapter->eeprompriv));
 	ether_addr_copy(pwlanhdr->addr3, pnetwork->MacAddress);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -1391,9 +1391,9 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	int ret;
 	int i = 0;
 	unsigned long start = jiffies;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	/* da == NULL, assume it's null data for sta to ap*/
 	if (da == NULL)
@@ -1440,10 +1440,10 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 	unsigned char *pframe;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	int ret = _FAIL;
 	__le16 le_tmp;
 
@@ -1465,7 +1465,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 	*(fctrl) = 0;
 
 	ether_addr_copy(pwlanhdr->addr1, da);
-	ether_addr_copy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)));
+	ether_addr_copy(pwlanhdr->addr2, myid(&padapter->eeprompriv));
 	ether_addr_copy(pwlanhdr->addr3, pnetwork->MacAddress);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -1556,13 +1556,13 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 	u8 *pframe;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct sta_info *psta;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	DBG_88E("%s, category=%d, action=%d, status=%d\n", __func__, category, action, status);
 
@@ -1583,7 +1583,7 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 	*(fctrl) = 0;
 
 	ether_addr_copy(pwlanhdr->addr1, raddr);
-	ether_addr_copy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)));
+	ether_addr_copy(pwlanhdr->addr2, myid(&padapter->eeprompriv));
 	ether_addr_copy(pwlanhdr->addr3, pnetwork->MacAddress);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -1593,8 +1593,8 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
 
 	if (category == 3) {
 		switch (action) {
@@ -1602,7 +1602,7 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 			do {
 				pmlmeinfo->dialogToken++;
 			} while (pmlmeinfo->dialogToken == 0);
-			pframe = rtw_set_fixed_ie(pframe, 1, &(pmlmeinfo->dialogToken), &(pattrib->pktlen));
+			pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->dialogToken, &pattrib->pktlen);
 
 			BA_para_set = 0x1002 | ((status & 0xf) << 2); /* immediate ack & 64 buffer size */
 			le_tmp = cpu_to_le16(BA_para_set);
@@ -1703,14 +1703,14 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct wlan_network *pnetwork = NULL;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct __queue *queue = &(pmlmepriv->scanned_queue);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	u8 InfoContent[16] = {0};
 	u8 ICS[8][15];
-	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 
 	if ((pmlmepriv->num_FortyMHzIntolerant == 0) || (pmlmepriv->num_sta_no_ht == 0))
 		return;
@@ -1740,7 +1740,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	*(fctrl) = 0;
 
 	ether_addr_copy(pwlanhdr->addr1, cur_network->MacAddress);
-	ether_addr_copy(pwlanhdr->addr2, myid(&(padapter->eeprompriv)));
+	ether_addr_copy(pwlanhdr->addr2, myid(&padapter->eeprompriv));
 	ether_addr_copy(pwlanhdr->addr3, cur_network->MacAddress);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -1750,8 +1750,8 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
-	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
-	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
+	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
 
 	/*  */
 	if (pmlmepriv->num_FortyMHzIntolerant > 0) {
@@ -1759,7 +1759,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 		iedata |= BIT(2);/* 20 MHz BSS Width Request */
 
-		pframe = rtw_set_ie(pframe, EID_BSSCoexistence,  1, &iedata, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, EID_BSSCoexistence,  1, &iedata, &pattrib->pktlen);
 	}
 
 	/*  */
@@ -1767,7 +1767,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	if (pmlmepriv->num_sta_no_ht > 0) {
 		int i;
 
-		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
 		phead = get_list_head(queue);
 		plist = phead->next;
@@ -1814,7 +1814,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 					}
 				}
 
-				pframe = rtw_set_ie(pframe, EID_BSSIntolerantChlReport, k, InfoContent, &(pattrib->pktlen));
+				pframe = rtw_set_ie(pframe, EID_BSSIntolerantChlReport, k, InfoContent, &pattrib->pktlen);
 			}
 		}
 	}
@@ -1829,7 +1829,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *psta = NULL;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u16 tid;
 
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
@@ -1909,7 +1909,7 @@ static void site_survey(struct adapter *padapter)
 	unsigned char survey_channel = 0, val8;
 	enum rt_scan_type ScanType = SCAN_PASSIVE;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u32 initialgain = 0;
 	struct rtw_ieee80211_channel *ch;
 
@@ -2023,7 +2023,7 @@ static u8 collect_bss_info(struct adapter *padapter,
 	u8 ie_offset;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
@@ -2186,8 +2186,8 @@ static void start_create_ibss(struct adapter *padapter)
 	u8 val8;
 	u8 join_type;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 
 	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
@@ -2237,8 +2237,8 @@ static void start_clnt_join(struct adapter *padapter)
 	unsigned short caps;
 	u8 val8;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 	int beacon_timeout;
 
 	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
@@ -2290,7 +2290,7 @@ static void start_clnt_join(struct adapter *padapter)
 static void start_clnt_auth(struct adapter *padapter)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	del_timer_sync(&pmlmeext->link_timer);
 
@@ -2308,7 +2308,7 @@ static void start_clnt_auth(struct adapter *padapter)
 	/*  issue deauth before issuing auth to deal with the situation */
 	/*	Commented by Albert 2012/07/21 */
 	/*	For the Win8 P2P connection, it will be hard to have a successful connection if this Wi-Fi doesn't connect to it. */
-	issue_deauth(padapter, (&(pmlmeinfo->network))->MacAddress, WLAN_REASON_DEAUTH_LEAVING);
+	issue_deauth(padapter, (&pmlmeinfo->network)->MacAddress, WLAN_REASON_DEAUTH_LEAVING);
 
 	DBG_88E_LEVEL(_drv_info_, "start auth\n");
 	issue_auth(padapter, NULL, 0);
@@ -2319,7 +2319,7 @@ static void start_clnt_auth(struct adapter *padapter)
 static void start_clnt_assoc(struct adapter *padapter)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	del_timer_sync(&pmlmeext->link_timer);
 
@@ -2336,8 +2336,8 @@ static unsigned int receive_disconnect(struct adapter *padapter,
 				       unsigned short reason)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	/* check A3 */
 	if (memcmp(MacAddr, pnetwork->MacAddress, ETH_ALEN))
@@ -2513,8 +2513,8 @@ static unsigned int OnProbeReq(struct adapter *padapter,
 	unsigned char *p;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *cur = &(pmlmeinfo->network);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur = &pmlmeinfo->network;
 	u8 *pframe = precv_frame->pkt->data;
 	uint len = precv_frame->pkt->len;
 
@@ -2560,14 +2560,14 @@ static unsigned int OnBeacon(struct adapter *padapter,
 	int cam_idx;
 	struct sta_info *psta;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->pkt->data;
 	uint len = precv_frame->pkt->len;
 	struct wlan_bssid_ex *pbss;
 	int ret = _SUCCESS;
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
 		report_survey_event(padapter, precv_frame);
@@ -2580,8 +2580,8 @@ static unsigned int OnBeacon(struct adapter *padapter,
 			pbss = (struct wlan_bssid_ex *)rtw_malloc(sizeof(struct wlan_bssid_ex));
 			if (pbss) {
 				if (collect_bss_info(padapter, precv_frame, pbss) == _SUCCESS) {
-					update_network(&(pmlmepriv->cur_network.network), pbss, padapter, true);
-					rtw_get_bcn_info(&(pmlmepriv->cur_network));
+					update_network(&pmlmepriv->cur_network.network, pbss, padapter, true);
+					rtw_get_bcn_info(&pmlmepriv->cur_network);
 				}
 				kfree(pbss);
 			}
@@ -2659,7 +2659,7 @@ static unsigned int OnAuth(struct adapter *padapter,
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->pkt->data;
 	uint len = precv_frame->pkt->len;
 
@@ -2822,14 +2822,14 @@ static unsigned int OnAuthClient(struct adapter *padapter,
 	unsigned char *p;
 	unsigned int go2asoc = 0;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->pkt->data;
 	uint pkt_len = precv_frame->pkt->len;
 
 	DBG_88E("%s\n", __func__);
 
 	/* check A1 matches or not */
-	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
+	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
 
 	if (!(pmlmeinfo->state & WIFI_FW_AUTH_STATE))
@@ -2908,8 +2908,8 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *cur = &(pmlmeinfo->network);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur = &pmlmeinfo->network;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->pkt->data;
 	uint ie_len, pkt_len = precv_frame->pkt->len;
@@ -3335,14 +3335,14 @@ static unsigned int OnAssocRsp(struct adapter *padapter,
 	struct ndis_802_11_var_ie *pIE;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->pkt->data;
 	uint pkt_len = precv_frame->pkt->len;
 
 	DBG_88E("%s\n", __func__);
 
 	/* check A1 matches or not */
-	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
+	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
 
 	if (!(pmlmeinfo->state & (WIFI_FW_AUTH_SUCCESS | WIFI_FW_ASSOC_STATE)))
@@ -3420,9 +3420,9 @@ static unsigned int OnDeAuth(struct adapter *padapter,
 	unsigned short reason;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->pkt->data;
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	/* check A3 */
 	if (memcmp(GetAddr3Ptr(pframe), pnetwork->MacAddress, ETH_ALEN))
@@ -3474,9 +3474,9 @@ static unsigned int OnDisassoc(struct adapter *padapter,
 	u16 reason;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->pkt->data;
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	/* check A3 */
 	if (memcmp(GetAddr3Ptr(pframe), pnetwork->MacAddress, ETH_ALEN))
@@ -3589,12 +3589,12 @@ static unsigned int OnAction_back(struct adapter *padapter,
 	unsigned char category, action;
 	unsigned short tid, status, reason_code = 0;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->pkt->data;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	/* check RA matches or not */
-	if (memcmp(myid(&(padapter->eeprompriv)), GetAddr1Ptr(pframe),
+	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe),
 		   ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
 
@@ -3620,8 +3620,8 @@ static unsigned int OnAction_back(struct adapter *padapter,
 		DBG_88E("%s, action=%d\n", __func__, action);
 		switch (action) {
 		case RTW_WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
-			memcpy(&(pmlmeinfo->ADDBA_req), &(frame_body[2]), sizeof(struct ADDBA_request));
-			process_addba_req(padapter, (u8 *)&(pmlmeinfo->ADDBA_req), addr);
+			memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
+			process_addba_req(padapter, (u8 *)&pmlmeinfo->ADDBA_req, addr);
 
 			/* 37 = reject ADDBA Req */
 			issue_action_BA(padapter, addr,
@@ -3663,7 +3663,7 @@ static unsigned int OnAction_back(struct adapter *padapter,
 static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 {
 	struct adapter *adapter = recv_frame->adapter;
-	struct mlme_ext_priv *mlmeext = &(adapter->mlmeextpriv);
+	struct mlme_ext_priv *mlmeext = &adapter->mlmeextpriv;
 	u8 *frame = recv_frame->pkt->data;
 	u16 seq_ctrl = ((recv_frame->attrib.seq_num&0xffff) << 4) |
 		(recv_frame->attrib.frag_num & 0xf);
@@ -3747,7 +3747,7 @@ static unsigned int on_action_public(struct adapter *padapter,
 	u8 category, action;
 
 	/* check RA matches or not */
-	if (memcmp(myid(&(padapter->eeprompriv)), GetAddr1Ptr(pframe), ETH_ALEN))
+	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))
 		goto exit;
 
 	category = frame_body[0];
@@ -3861,7 +3861,7 @@ int init_hw_mlme_ext(struct adapter *padapter)
 static void init_mlme_ext_priv_value(struct adapter *padapter)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	unsigned char mixed_datarate[NumRates] = {
 		_1M_RATE_, _2M_RATE_, _5M_RATE_, _11M_RATE_, _6M_RATE_,
 		_9M_RATE_, _12M_RATE_, _18M_RATE_, _24M_RATE_, _36M_RATE_,
@@ -4027,8 +4027,8 @@ int init_mlme_ext_priv(struct adapter *padapter)
 {
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pmlmeext->padapter = padapter;
 
@@ -4270,7 +4270,7 @@ void report_join_res(struct adapter *padapter, int res)
 	struct joinbss_event *pjoinbss_evt;
 	struct C2HEvent_Header *pc2h_evt_hdr;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
@@ -4299,7 +4299,7 @@ void report_join_res(struct adapter *padapter, int res)
 	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	pjoinbss_evt = (struct joinbss_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
-	memcpy((unsigned char *)(&(pjoinbss_evt->network.network)), &(pmlmeinfo->network), sizeof(struct wlan_bssid_ex));
+	memcpy((unsigned char *)(&pjoinbss_evt->network.network), &pmlmeinfo->network, sizeof(struct wlan_bssid_ex));
 	pjoinbss_evt->network.join_res	= res;
 	pjoinbss_evt->network.aid = res;
 
@@ -4349,7 +4349,7 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	pdel_sta_evt = (struct stadel_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
-	ether_addr_copy((unsigned char *)(&(pdel_sta_evt->macaddr)), MacAddr);
+	ether_addr_copy((unsigned char *)(&pdel_sta_evt->macaddr), MacAddr);
 	memcpy((unsigned char *)(pdel_sta_evt->rsvd), (unsigned char *)(&reason), 2);
 
 	psta = rtw_get_stainfo(&padapter->stapriv, MacAddr);
@@ -4402,7 +4402,7 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	padd_sta_evt = (struct stassoc_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
-	ether_addr_copy((unsigned char *)(&(padd_sta_evt->macaddr)), MacAddr);
+	ether_addr_copy((unsigned char *)(&padd_sta_evt->macaddr), MacAddr);
 	padd_sta_evt->cam_id = cam_idx;
 
 	DBG_88E("%s: add STA\n", __func__);
@@ -4419,9 +4419,9 @@ Following are the event callback functions
 /* for sta/adhoc mode */
 void update_sta_info(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	/* ERP */
 	VCS_update(padapter, psta);
@@ -4461,8 +4461,8 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 {
 	struct sta_info *psta, *psta_bmc;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 join_type;
 	u16 media_status;
@@ -4539,8 +4539,8 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 
 void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 join_type;
 
 	DBG_88E("%s\n", __func__);
@@ -4577,7 +4577,7 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 void mlmeext_sta_del_event_callback(struct adapter *padapter)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (is_client_associated_to_ap(padapter) || is_IBSS_empty(padapter)) {
 		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_DISCONNECT, NULL);
@@ -4630,9 +4630,9 @@ void linked_status_chk(struct adapter *padapter)
 {
 	u32 i;
 	struct sta_info *psta;
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	if (is_client_associated_to_ap(padapter)) {
@@ -4789,7 +4789,7 @@ void link_timer_hdl(struct timer_list *t)
 	struct adapter *padapter = from_timer(padapter, t,
 					      mlmeextpriv.link_timer);
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
 		DBG_88E("%s:no beacon while connecting\n", __func__);
@@ -4841,7 +4841,7 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	u8 type;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct setopmode_parm *psetop = (struct setopmode_parm *)pbuf;
 
 	if (psetop->mode == Ndis802_11APMode) {
@@ -4866,8 +4866,8 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 	struct wlan_bssid_ex *pparm = (struct wlan_bssid_ex *)pbuf;
 	/* u32	initialgain; */
 
@@ -4929,8 +4929,8 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	struct ndis_802_11_var_ie *pIE;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 	struct wlan_bssid_ex *pparm = (struct wlan_bssid_ex *)pbuf;
 	u32 i;
 
@@ -5040,8 +5040,8 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	struct disconnect_parm *param = (struct disconnect_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
 	u8 val8;
 
 	if (is_client_associated_to_ap(padapter))
@@ -5199,7 +5199,7 @@ u8 setauth_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	struct setauth_parm *pparm = (struct setauth_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pparm->mode < 4)
 		pmlmeinfo->auth_algo = pparm->mode;
@@ -5211,7 +5211,7 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 	unsigned short ctrl;
 	struct setkey_parm *pparm = (struct setkey_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	unsigned char null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
 	/* main tx key for wep. */
@@ -5233,7 +5233,7 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 	u16 ctrl = 0;
 	u8 cam_id;/* cam_entry */
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct set_stakey_parm *pparm = (struct set_stakey_parm *)pbuf;
 
 	/* cam_entry: */
@@ -5303,7 +5303,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	struct addBaReq_parm *pparm = (struct addBaReq_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, pparm->addr);
 
@@ -5325,9 +5325,9 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 {
 	struct cmd_obj *ph2c;
 	struct wlan_bssid_ex *ptxBeacon_parm;
-	struct cmd_priv *pcmdpriv = &(padapter->cmdpriv);
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 res = _SUCCESS;
 	int len_diff = 0;
 
@@ -5337,8 +5337,8 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 		goto exit;
 	}
 
-	ptxBeacon_parm = kmemdup(&(pmlmeinfo->network),
-				sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
+	ptxBeacon_parm = kmemdup(&pmlmeinfo->network,
+				 sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
 	if (ptxBeacon_parm == NULL) {
 		kfree(ph2c);
 		res = _FAIL;
-- 
2.20.0

