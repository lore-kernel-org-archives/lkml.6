Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A4C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FBC2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsG51LeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FBC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeLERD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54585 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbeLERDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id z18so14088214wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rB6tDCYHm2b4W483elDCHFF0vfW5iuOqm7C3z67usVI=;
        b=AsG51LeMJIgWy5/VzwIBufAFIPe0O0wByegQ45ClEdyzFWi4qMWRfetGZ3qN3cb9cL
         iBpXsPQDZ8nqlhFjMyrvMN5cq+fUdmjD/i/3smo6EVm43TW8CM2q1oEEYrBXT7sU+8tV
         JGjUZqd/kCyf/seXN4Oz+XLua9J+gqDWluBqk2NMgM0RgovCwWAX6dAhU6ikCNiUAu6X
         yWWcN9FSpKH2t9+xBO3tozubRDRVGByRaudinmPS2g5yApeFBAKxMbuv10ZPaq5ErsTg
         b+EEU0Pzqqu08lcDwfTuBsZldRInr2rb1oxvDdpOu235XWjABuYdSQ1MRW/kPvsHGQ8r
         S1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rB6tDCYHm2b4W483elDCHFF0vfW5iuOqm7C3z67usVI=;
        b=ejf8wjAQntOOlwy93t8ubcWKaY744v4m5b+GNX7bpm7QZjipBTQsQBfJyTfQZIsxSi
         I1dKzlCIWdRSHVdWfom81VM4nz8jFd1shtK2RhpjOlOVxX04zSPbxL+h36mhIvooJDW0
         g2lohFX0qiFEkk9/2hkIF+RccLafqng6EcQRs1h4Cl5Ml3W6PbZGNMI6XhWDvXj5ktqh
         CNTkCAqEQ1itbA7C5Xzi6KTsEzjl2ECuhagKwTPJ7Ozg9UNzBm2YPj/bmDLIs1egnf95
         gIjDIaDOjPCs9nrL86/BTg+icUw2QZyRUixSKjpoyP+b8cF4UWRLKuA0xs9uP7Qu0WKv
         P1Eg==
X-Gm-Message-State: AA+aEWaDcj3GmB3N+N2EizWSJh0p+Sk73vaGR7zOh2rSwleNq4fSAXeC
        W3AlwnbQ2AHtO70tysikd5w=
X-Google-Smtp-Source: AFSGD/WxnEj8P7dpXaZO/kE90omhMQ/p5sfVVHoRjAZx1WQ6OClFpoJNXJV262vMtyaecwG5ybRaew==
X-Received: by 2002:a1c:8d46:: with SMTP id p67mr15830147wmd.28.1544029384025;
        Wed, 05 Dec 2018 09:03:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:03:03 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/12] staging: rtl8188eu: cleanup declarations in rtw_wlan_util.c
Date:   Wed,  5 Dec 2018 18:02:40 +0100
Message-Id: <20181205170247.5401-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205170247.5401-1-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove spaces in declarations
to cleanup whitespace. Remove unused/commented declarations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 175 +++++++++---------
 1 file changed, 86 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 0e2653a68f4f..e61fc7ce65e8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -177,7 +177,7 @@ static unsigned int ratetbl2rateset(struct adapter *padapter, unsigned char *rat
 {
 	int i;
 	unsigned char rate;
-	unsigned int	len = 0;
+	unsigned int len = 0;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	for (i = 0; i < NumRates; i++) {
@@ -213,8 +213,8 @@ void get_rate_set(struct adapter *padapter, unsigned char *pbssrate, int *bssrat
 
 void UpdateBrateTbl(struct adapter *Adapter, u8 *mbrate)
 {
-	u8	i;
-	u8	rate;
+	u8 i;
+	u8 rate;
 
 	/*  1M, 2M, 5.5M, 11M, 6M, 12M, 24M are mandatory. */
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
@@ -235,8 +235,8 @@ void UpdateBrateTbl(struct adapter *Adapter, u8 *mbrate)
 
 void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen)
 {
-	u8	i;
-	u8	rate;
+	u8 i;
+	u8 rate;
 
 	for (i = 0; i < bssratelen; i++) {
 		rate = bssrateset[i] & 0x7f;
@@ -253,14 +253,14 @@ void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen)
 
 void Save_DM_Func_Flag(struct adapter *padapter)
 {
-	u8	saveflag = true;
+	u8 saveflag = true;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
 }
 
 void Restore_DM_Func_Flag(struct adapter *padapter)
 {
-	u8	saveflag = false;
+	u8 saveflag = false;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
 }
@@ -370,8 +370,8 @@ u16 get_beacon_interval(struct wlan_bssid_ex *bss)
 
 int is_client_associated_to_ap(struct adapter *padapter)
 {
-	struct mlme_ext_priv	*pmlmeext;
-	struct mlme_ext_info	*pmlmeinfo;
+	struct mlme_ext_priv *pmlmeext;
+	struct mlme_ext_info *pmlmeinfo;
 
 	if (!padapter)
 		return _FAIL;
@@ -387,8 +387,8 @@ int is_client_associated_to_ap(struct adapter *padapter)
 
 int is_client_associated_to_ibss(struct adapter *padapter)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE))
 		return true;
@@ -399,8 +399,8 @@ int is_client_associated_to_ibss(struct adapter *padapter)
 int is_IBSS_empty(struct adapter *padapter)
 {
 	unsigned int i;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	for (i = IBSS_START_MAC_ID; i < NUM_STA; i++) {
 		if (pmlmeinfo->FW_sta_info[i].status == 1)
@@ -426,9 +426,9 @@ void invalidate_cam_all(struct adapter *padapter)
 
 void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
 {
-	unsigned int	i, val, addr;
+	unsigned int i, val, addr;
 	int j;
-	u32	cam_val[2];
+	u32 cam_val[2];
 
 	addr = entry << 3;
 
@@ -464,8 +464,8 @@ void clear_cam_entry(struct adapter *padapter, u8 entry)
 int allocate_fw_sta_entry(struct adapter *padapter)
 {
 	unsigned int mac_id;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	for (mac_id = IBSS_START_MAC_ID; mac_id < NUM_STA; mac_id++) {
 		if (pmlmeinfo->FW_sta_info[mac_id].status == 0) {
@@ -480,8 +480,8 @@ int allocate_fw_sta_entry(struct adapter *padapter)
 
 void flush_all_cam_entry(struct adapter *padapter)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
 
@@ -490,10 +490,9 @@ void flush_all_cam_entry(struct adapter *padapter)
 
 int WMM_param_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
-	/* struct registry_priv	*pregpriv = &padapter->registrypriv; */
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmepriv->qospriv.qos_option == 0) {
 		pmlmeinfo->WMM_enable = 0;
@@ -507,15 +506,15 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 
 void WMMOnAssocRsp(struct adapter *padapter)
 {
-	u8	ACI, ACM, AIFS, ECWMin, ECWMax, aSifsTime;
-	u8	acm_mask;
-	u16	TXOP;
-	u32	acParm, i;
-	u32	edca[4], inx[4];
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
-	struct registry_priv	*pregpriv = &padapter->registrypriv;
+	u8 ACI, ACM, AIFS, ECWMin, ECWMax, aSifsTime;
+	u8 acm_mask;
+	u16 TXOP;
+	u32 acParm, i;
+	u32 edca[4], inx[4];
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct registry_priv *pregpriv = &padapter->registrypriv;
 
 	if (pmlmeinfo->WMM_enable == 0) {
 		padapter->mlmepriv.acm_mask = 0;
@@ -575,7 +574,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 	inx[0] = 0; inx[1] = 1; inx[2] = 2; inx[3] = 3;
 
 	if (pregpriv->wifi_spec == 1) {
-		u32	j, change_inx = false;
+		u32 j, change_inx = false;
 
 		/* entry indx: 0->vo, 1->vi, 2->be, 3->bk. */
 		for (i = 0; i < 4; i++) {
@@ -606,14 +605,14 @@ void WMMOnAssocRsp(struct adapter *padapter)
 
 static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
-	unsigned char	 new_bwmode;
-	unsigned char  new_ch_offset;
-	struct HT_info_element	 *pHT_info;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	unsigned char new_bwmode;
+	unsigned char new_ch_offset;
+	struct HT_info_element *pHT_info;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct ht_priv			*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	if (!pIE)
 		return;
@@ -684,12 +683,12 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var
 
 void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
-	unsigned int	i;
-	u8	max_AMPDU_len, min_MPDU_spacing;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv			*phtpriv = &pmlmepriv->htpriv;
+	unsigned int i;
+	u8 max_AMPDU_len, min_MPDU_spacing;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	u8 *HT_cap = (u8 *)(&pmlmeinfo->HT_caps);
 
 	if (!pIE)
@@ -727,10 +726,10 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 
 void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv			*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	if (!pIE)
 		return;
@@ -747,11 +746,10 @@ void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 
 void HTOnAssocRsp(struct adapter *padapter)
 {
-	unsigned char		max_AMPDU_len;
-	unsigned char		min_MPDU_spacing;
-	/* struct registry_priv	 *pregpriv = &padapter->registrypriv; */
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	unsigned char max_AMPDU_len;
+	unsigned char min_MPDU_spacing;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	DBG_88E("%s\n", __func__);
 
@@ -778,8 +776,8 @@ void HTOnAssocRsp(struct adapter *padapter)
 
 void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pIE->Length > 1)
 		return;
@@ -790,9 +788,9 @@ void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 
 void VCS_update(struct adapter *padapter, struct sta_info *psta)
 {
-	struct registry_priv	 *pregpriv = &padapter->registrypriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct registry_priv *pregpriv = &padapter->registrypriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	switch (pregpriv->vrtl_carrier_sense) { /* 0:off 1:on 2:auto */
 	case 0: /* off */
@@ -828,11 +826,10 @@ void VCS_update(struct adapter *padapter, struct sta_info *psta)
 
 int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 {
-	unsigned int		len;
-	unsigned char		*p;
-	unsigned short	val16, subtype;
+	unsigned int len;
+	unsigned char *p;
+	unsigned short val16, subtype;
 	struct wlan_network *cur_network = &Adapter->mlmepriv.cur_network;
-	/* u8 wpa_ie[255], rsn_ie[255]; */
 	u16 wpa_len = 0, rsn_len = 0;
 	u8 encryp_protocol = 0;
 	struct wlan_bssid_ex *bssid;
@@ -842,8 +839,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	u8 *pbssid = GetAddr3Ptr(pframe);
 	struct HT_info_element *pht_info = NULL;
 	u32 bcn_channel;
-	unsigned short	ht_cap_info;
-	unsigned char	ht_info_infos_0;
+	unsigned short ht_cap_info;
+	unsigned char ht_info_infos_0;
 	int ssid_len;
 
 	if (!is_client_associated_to_ap(Adapter))
@@ -1061,8 +1058,8 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 	u32 i;
 	struct ndis_802_11_var_ie *pIE;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 
 	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
 		for (i = sizeof(struct ndis_802_11_fixed_ie); i < pmlmeinfo->network.ie_length;) {
@@ -1093,8 +1090,8 @@ unsigned int is_ap_in_wep(struct adapter *padapter)
 	u32 i;
 	struct ndis_802_11_var_ie *pIE;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 
 	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
 		for (i = sizeof(struct ndis_802_11_fixed_ie); i < pmlmeinfo->network.ie_length;) {
@@ -1190,9 +1187,9 @@ unsigned int update_MSC_rate(struct ieee80211_ht_cap *pHT_caps)
 
 int support_short_GI(struct adapter *padapter, struct ieee80211_ht_cap *pHT_caps)
 {
-	unsigned char					bit_offset;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	unsigned char bit_offset;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (!(pmlmeinfo->HT_enable))
 		return _FAIL;
@@ -1264,8 +1261,8 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 {
 	unsigned int i;
 	struct ndis_802_11_var_ie *pIE;
-	u8	epigram_vendor_flag;
-	u8	ralink_vendor_flag;
+	u8 epigram_vendor_flag;
+	u8 ralink_vendor_flag;
 
 	epigram_vendor_flag = 0;
 	ralink_vendor_flag = 0;
@@ -1334,8 +1331,8 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 
 void update_IOT_info(struct adapter *padapter)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	switch (pmlmeinfo->assoc_AP_vendor) {
 	case HT_IOT_PEER_MARVELL:
@@ -1365,9 +1362,9 @@ void update_IOT_info(struct adapter *padapter)
 
 void update_capinfo(struct adapter *Adapter, u16 updateCap)
 {
-	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	bool		ShortPreamble;
+	struct mlme_ext_priv *pmlmeext = &Adapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	bool ShortPreamble;
 
 	/*  Check preamble mode, 2005.01.06, by rcnjko. */
 	/*  Mark to update preamble value forever, 2008.03.18 by lanhsin */
@@ -1448,8 +1445,8 @@ void update_wireless_mode(struct adapter *padapter)
 
 void update_bmc_sta_support_rate(struct adapter *padapter, u32 mac_id)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeext->cur_wireless_mode & WIRELESS_11B) {
 		/*  Only B, B/G, and B/G/N AP could use CCK rate */
@@ -1461,11 +1458,11 @@ void update_bmc_sta_support_rate(struct adapter *padapter, u32 mac_id)
 
 int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_len, int cam_idx)
 {
-	unsigned int	ie_len;
+	unsigned int ie_len;
 	struct ndis_802_11_var_ie *pIE;
-	int	supportRateNum = 0;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	int supportRateNum = 0;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pIE = (struct ndis_802_11_var_ie *)rtw_get_ie(pvar_ie, _SUPPORTEDRATES_IE_, &ie_len, var_ie_len);
 	if (!pIE)
@@ -1493,9 +1490,9 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 	u16 param;
 	struct recv_reorder_ctrl *preorder_ctrl;
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct ADDBA_request	*preq = (struct ADDBA_request *)paddba_req;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct ADDBA_request *preq = (struct ADDBA_request *)paddba_req;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	psta = rtw_get_stainfo(pstapriv, addr);
 
-- 
2.19.2

