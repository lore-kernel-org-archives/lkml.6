Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73822C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F1020685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0KcWIKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F1020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeKXH2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:28:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38364 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKXH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:27:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id k198so13067356wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OKtUxA8kdt9J/4te1hAOWL+Id8JHoMHOtAqHcJ92wU=;
        b=C0KcWIKMFT1KFB32+vpu3MncBJXgTiNOuoONMQYK2/KR42FxD5W4Glz5OTqfFEhPb/
         vm8dRceeF3GEaKP//4ZTcqMqGyO6+ry6+250AiW7NIbDj1kN3kskQNE3emHX1/klAq1D
         akuZFd1a4AaMVIbiEhTV2zLrZWzoRJV8OoFMCvjAp4Y0XsZZuBWRQKs5Hx37uRc8485f
         ff67W1SkEy8Tjs7rwUZmFGv3YJ5vuQc0j2XIwDtWB+4Yl6qgjkUB4cMRqx3KsrpPrTd+
         rgFXt6mhq5FFY9jtqa2+BTTN4O/OcvEHnCl/UxYXbzml3qzO8b+n9/xLAP+DbKIrRW3C
         3FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OKtUxA8kdt9J/4te1hAOWL+Id8JHoMHOtAqHcJ92wU=;
        b=ryUvmEJb9V+UCtpZdKx0Ht4PjQfqGv+9eY/CE4oU2aru2w2Rr/kmAeTK9d3znphBP1
         B6H3lVhesd0nTqGht8VgiqOntS6GnMaFHXwLlbb1hvmShQk6axOHm2UGiw+kSPVQF/32
         H9v2UBdsnp2lMuHLR3KXmWrvSU2Vr1GzNdlmSFMEHeGI3fW9mG/hwmh2gMzVn0BbdfSp
         af+w/JUHCf4yI7BPLl5cvr7SNU0cXA+aCVrO5Paodl/NHmGGr+x95vLy181baVRAK6Au
         bArvzpRYffDj76R/mi+sudReJSfkXZOt6OXC7VHCvAOb3k2oXzm3q6PhQujngNUkRcje
         E1fg==
X-Gm-Message-State: AA+aEWZsX4pT3WjReeo5jpjUjTJNPqGLMbDOI8KP3zG0Tr+qoJMLnSCW
        7OE6nYzxHn69NUP5y6tHkb4yEi2s
X-Google-Smtp-Source: AFSGD/WFTvjZQZ05Bif6ghjsmYitKAMhvAWFmNzxveskqyZcatzj/IypD5kWYa8McMKPUXNPzBDAaw==
X-Received: by 2002:a1c:c7cd:: with SMTP id x196mr6822579wmf.12.1543005678379;
        Fri, 23 Nov 2018 12:41:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i9sm24598906wrs.34.2018.11.23.12.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 12:41:17 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/9] staging: rtl8188eu: cleanup remaining comparsions to true
Date:   Fri, 23 Nov 2018 21:40:58 +0100
Message-Id: <20181123204106.2284-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup remaining comparsions to true.
if (x == true) -> if (x)
if (x != true) -> if (!x)
if (!x == true) -> if (!x)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c       |  4 +--
 drivers/staging/rtl8188eu/core/rtw_cmd.c      | 10 +++---
 drivers/staging/rtl8188eu/core/rtw_mlme.c     | 26 +++++++-------
 drivers/staging/rtl8188eu/core/rtw_recv.c     | 16 ++++-----
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c  |  2 +-
 .../staging/rtl8188eu/core/rtw_wlan_util.c    |  2 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c     |  7 ++--
 drivers/staging/rtl8188eu/include/rtw_mlme.h  |  2 +-
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 36 +++++++++----------
 9 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 1c319c2ca86d..1f232ba6651c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -629,7 +629,7 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	}
 
 	/* setting only at  first time */
-	if (pmlmepriv->cur_network.join_res != true) {
+	if (!pmlmepriv->cur_network.join_res) {
 		/* WEP Key will be set before this function, do not
 		 * clear CAM.
 		 */
@@ -756,7 +756,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	DBG_88E("%s, len =%d\n", __func__, len);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return _FAIL;
 
 	if (len < 0 || len > MAX_IE_SZ)
diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index f6dbcf6fe39b..e3e46f7ac834 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -240,7 +240,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	struct cmd_priv		*pcmdpriv = &padapter->cmdpriv;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
+	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SCAN, 1);
 
 	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
@@ -820,7 +820,7 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
 	pmlmepriv = &padapter->mlmepriv;
 
 #ifdef CONFIG_88EU_AP_MODE
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		expire_timeout_chk(padapter);
 #endif
 
@@ -836,13 +836,13 @@ static void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8	mstatus;
 
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE))
 		return;
 
 	switch (lps_ctrl_type) {
 	case LPS_CTRL_SCAN:
-		if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
+		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 			/* connect */
 			LPS_Leave(padapter);
 		}
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index e5c8b02e6ab2..b6210d98ee2d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -315,8 +315,8 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst)
 	d_cap = le16_to_cpu(le_dcap);
 
 	return ((src->Ssid.SsidLength == dst->Ssid.SsidLength) &&
-		((!memcmp(src->MacAddress, dst->MacAddress, ETH_ALEN)) == true) &&
-		((!memcmp(src->Ssid.Ssid, dst->Ssid.Ssid, src->Ssid.SsidLength)) == true) &&
+		(!memcmp(src->MacAddress, dst->MacAddress, ETH_ALEN)) &&
+		(!memcmp(src->Ssid.Ssid, dst->Ssid.Ssid, src->Ssid.SsidLength)) &&
 		((s_cap & WLAN_CAPABILITY_IBSS) ==
 		(d_cap & WLAN_CAPABILITY_IBSS)) &&
 		((s_cap & WLAN_CAPABILITY_ESS) ==
@@ -386,8 +386,8 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 {
 	struct	mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
 
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) &&
-	    (is_same_network(&(pmlmepriv->cur_network.network), pnetwork))) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED) &&
+	    is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
 		update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fixed_ie),
 				      pmlmepriv->cur_network.network.ie_length);
@@ -529,7 +529,7 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 		bselected = false;
 	}
 
-	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
 			bselected = false;
 	}
@@ -561,7 +561,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	/*  update IBSS_network 's timestamp */
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress), pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
@@ -614,7 +614,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 			if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
@@ -1005,14 +1005,14 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 					}
 
 					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.MacAddress);
-					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 						if (ptarget_wlan)
 							ptarget_wlan->fixed = true;
 					}
 				}
 			} else {
 				ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.MacAddress);
-				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 					if (ptarget_wlan)
 						ptarget_wlan->fixed = true;
 				}
@@ -1028,7 +1028,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			}
 
 			/* s3. find ptarget_sta & update ptarget_sta after update cur_network only for station mode */
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
@@ -1038,7 +1038,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			}
 
 			/* s4. indicate connect */
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				rtw_indicate_connect(adapter);
 			} else {
 				/* adhoc mode will rtw_indicate_connect when rtw_stassoc_event_callback */
@@ -1063,7 +1063,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		mod_timer(&pmlmepriv->assoc_timer,
 			  jiffies + msecs_to_jiffies(1));
 
-		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true) {
+		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("fail! clear _FW_UNDER_LINKING ^^^fw_state=%x\n", get_fwstate(pmlmepriv)));
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 		}
@@ -1488,7 +1488,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	}
 
 	/*  check for situation of  _FW_LINKED */
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 		DBG_88E("%s: _FW_LINKED while ask_for_joinbss!!!\n", __func__);
 
 		rtw_disassoc_cmd(adapter, 0, true);
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 7c667a38077b..1d83affc08ce 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -650,8 +650,8 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 	u8 *sta_addr = NULL;
 	bool mcast = is_multicast_ether_addr(pattrib->dst);
 
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) ||
-	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA==myself\n"));
@@ -729,9 +729,9 @@ static int ap2sta_data_frame(
 	u8 *myhwaddr = myid(&adapter->eeprompriv);
 	bool mcast = is_multicast_ether_addr(pattrib->dst);
 
-	if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) &&
-	    (check_fwstate(pmlmepriv, _FW_LINKED) == true ||
-	    check_fwstate(pmlmepriv, _FW_UNDER_LINKING))) {
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
+	    (check_fwstate(pmlmepriv, _FW_LINKED) ||
+	     check_fwstate(pmlmepriv, _FW_UNDER_LINKING))) {
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA==myself\n"));
@@ -817,7 +817,7 @@ static int sta2ap_data_frame(struct adapter *adapter,
 	unsigned char *mybssid  = get_bssid(pmlmepriv);
 	int ret = _SUCCESS;
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		/* For AP mode, RA = BSSID, TX = STA(SRC_ADDR), A3 = DST_ADDR */
 		if (memcmp(pattrib->bssid, mybssid, ETH_ALEN)) {
 			ret = _FAIL;
@@ -949,7 +949,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 				pxmitframe->attrib.triggered = 1;
 
 				spin_unlock_bh(&psta->sleep_q.lock);
-				if (rtw_hal_xmit(padapter, pxmitframe) == true)
+				if (rtw_hal_xmit(padapter, pxmitframe))
 					rtw_os_xmit_complete(padapter, pxmitframe);
 				spin_lock_bh(&psta->sleep_q.lock);
 
@@ -1838,7 +1838,7 @@ void rtw_reordering_ctrl_timeout_handler(struct timer_list *t)
 
 	spin_lock_bh(&ppending_recvframe_queue->lock);
 
-	if (recv_indicatepkts_in_order(padapter, preorder_ctrl, true) == true)
+	if (recv_indicatepkts_in_order(padapter, preorder_ctrl, true))
 		mod_timer(&preorder_ctrl->reordering_ctrl_timer,
 			  jiffies + msecs_to_jiffies(REORDER_WAIT_TIME));
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index f12a12b19d3f..91a30142c567 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -429,7 +429,7 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	while (phead != plist) {
 		psta = container_of(plist, struct sta_info, hash_list);
 
-		if ((!memcmp(psta->hwaddr, addr, ETH_ALEN)) == true) {
+		if (!memcmp(psta->hwaddr, addr, ETH_ALEN)) {
 			/*  if found the matched address */
 			break;
 		}
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index d678dcee7312..24918223499b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -190,7 +190,7 @@ static unsigned int ratetbl2rateset(struct adapter *padapter, unsigned char *rat
 		default:
 			rate = ratetbl_val_2wifirate(rate);
 
-			if (is_basicrate(padapter, rate) == true)
+			if (is_basicrate(padapter, rate))
 				rate |= IEEE80211_BASIC_RATE_MASK;
 
 			rateset[len] = rate;
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 6a2d044ec02b..14e3f59b9009 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -467,7 +467,8 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra: %pM\n", (pattrib->ra)));
 			res = _FAIL;
 			goto exit;
-		} else if ((check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) && (!(psta->state & _FW_LINKED))) {
+		} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE) &&
+			   !(psta->state & _FW_LINKED)) {
 			res = _FAIL;
 			goto exit;
 		}
@@ -758,7 +759,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 	SetFrameSubType(fctrl, pattrib->subtype);
 
 	if (pattrib->subtype & WIFI_DATA_TYPE) {
-		if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE) == true) {
+		if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE)) {
 			/* to_ds = 1, fr_ds = 0; */
 			/* Data transfer to AP */
 			SetToDs(fctrl);
@@ -1984,7 +1985,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 
 		pxmitframe->attrib.triggered = 1;
 
-		if (rtw_hal_xmit(padapter, pxmitframe) == true)
+		if (rtw_hal_xmit(padapter, pxmitframe))
 			rtw_os_xmit_complete(padapter, pxmitframe);
 
 		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index 8d9d663f0645..126b96906171 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -285,7 +285,7 @@ static inline void _clr_fwstate_(struct mlme_priv *pmlmepriv, int state)
 static inline void clr_fwstate(struct mlme_priv *pmlmepriv, int state)
 {
 	spin_lock_bh(&pmlmepriv->lock);
-	if (check_fwstate(pmlmepriv, state) == true)
+	if (check_fwstate(pmlmepriv, state))
 		pmlmepriv->fw_state ^= state;
 	spin_unlock_bh(&pmlmepriv->lock);
 }
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 4ecd2ff48c41..efaa1c779f4b 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -296,7 +296,7 @@ static char *translate_scan(struct adapter *padapter,
 	iwe.cmd = IWEVQUAL;
 	iwe.u.qual.updated = IW_QUAL_QUAL_UPDATED | IW_QUAL_LEVEL_UPDATED | IW_QUAL_NOISE_INVALID;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true &&
+	if (check_fwstate(pmlmepriv, _FW_LINKED) &&
 	    is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network)) {
 		ss = padapter->recvpriv.signal_strength;
 		sq = padapter->recvpriv.signal_qual;
@@ -631,7 +631,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cmd_code =%x\n", info->cmd));
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		/* parsing HT_CAP_IE */
 		p = rtw_get_ie(&pcur_bss->ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->ie_length-12);
 		if (p && ht_ielen > 0)
@@ -1024,9 +1024,9 @@ static int rtw_wx_get_wap(struct net_device *dev,
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_wap\n"));
 
-	if (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
-	    ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
-	    ((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true))
+	if (check_fwstate(pmlmepriv, _FW_LINKED) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		memcpy(wrqu->ap_addr.sa_data, pcur_bss->MacAddress, ETH_ALEN);
 	else
 		eth_zero_addr(wrqu->ap_addr.sa_data);
@@ -1335,7 +1335,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
 					 ("rtw_wx_set_essid: find match, set infra mode\n"));
 
-				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
+				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
 						continue;
 				}
@@ -1691,7 +1691,7 @@ static int rtw_wx_get_enc(struct net_device *dev,
 	struct iw_point *erq = &(wrqu->encoding);
 	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED) != true) {
+	if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 		if (!check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 			erq->length = 0;
 			erq->flags |= IW_ENCODE_DISABLED;
@@ -2425,7 +2425,7 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 
 	DBG_88E("%s, len =%d\n", __func__, len);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
 	memcpy(&pstapriv->max_num_sta, param->u.bcn_ie.reserved, 2);
@@ -2517,7 +2517,7 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 
 	DBG_88E("rtw_del_sta =%pM\n", (param->sta_addr));
 
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
+	if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_AP_STATE))
 		return -EINVAL;
 
 	if (is_broadcast_ether_addr(param->sta_addr))
@@ -2553,7 +2553,7 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 
 	DBG_88E("rtw_ioctl_get_sta_info, sta_addr: %pM\n", (param_ex->sta_addr));
 
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
+	if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_AP_STATE))
 		return -EINVAL;
 
 	if (is_broadcast_ether_addr(param_ex->sta_addr))
@@ -2607,7 +2607,7 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 
 	DBG_88E("rtw_get_sta_wpaie, sta_addr: %pM\n", (param->sta_addr));
 
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
+	if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_AP_STATE))
 		return -EINVAL;
 
 	if (is_broadcast_ether_addr(param->sta_addr))
@@ -2645,7 +2645,7 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 
 	DBG_88E("%s, len =%d\n", __func__, len);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
 	ie_len = len-12-2;/*  12 = param header, 2:no packed */
@@ -2680,7 +2680,7 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 
 	DBG_88E("%s, len =%d\n", __func__, len);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
 	ie_len = len-12-2;/*  12 = param header, 2:no packed */
@@ -2710,7 +2710,7 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 
 	DBG_88E("%s, len =%d\n", __func__, len);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
 	ie_len = len-12-2;/*  12 = param header, 2:no packed */
@@ -2742,7 +2742,7 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 
 	u8 value;
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
 	if (param->u.wpa_param.name != 0) /* dummy test... */
@@ -2762,7 +2762,7 @@ static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *p
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
 	if (is_broadcast_ether_addr(param->sta_addr))
@@ -2776,7 +2776,7 @@ static int rtw_ioctl_acl_add_sta(struct net_device *dev, struct ieee_param *para
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
 	if (is_broadcast_ether_addr(param->sta_addr))
@@ -2791,7 +2791,7 @@ static int rtw_ioctl_set_macaddr_acl(struct net_device *dev, struct ieee_param *
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
 	rtw_set_macaddr_acl(padapter, param->u.mlme.command);
-- 
2.19.2

