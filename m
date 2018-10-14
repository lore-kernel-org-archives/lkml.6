Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DABC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C292064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVKoNjIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C292064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJOCvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 22:51:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41071 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbeJOCvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 22:51:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id x31-v6so15839143edd.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvPrih719l0JPA20/k3pzjDap2zn6V8b5eNI9LIGVy4=;
        b=XVKoNjIbPuCG/IobKo9oof+2bUvG79/0vQrlovd5miMjEaO9s7qlR6m1phE+tFmrtl
         iGdXqTZ0gh6J/JRoMQmXgVmohoQurIoVukJ/eVMHPNJWyPhgbGFWUDZL0nlzshBB4Ks6
         IPmt2L1Ald3urVIg72NvcA6PMMOw1VEUtcXiFdQRBXZC8PF200XFnDyZmX16/zoXzOwj
         /coCmRUA0/MWXVT6kum2tk0w1dAVwoeQcsq6j3aZJLcq+1PDReTyJ7mLAn6xVshBN5AQ
         T/Nbua/R2S/oEm+LIyi1mr22DhWE64IHOkbAa/Q+5mPC1iraLl7u2OEmoXlxfzLCQ1Go
         GzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvPrih719l0JPA20/k3pzjDap2zn6V8b5eNI9LIGVy4=;
        b=fpXjqqSYTSFDmpJ2jLMa1Pzk6+mU8Qg1qiDlXXqyP4cQKGM15tEIOEBlLbfTBOUdDN
         nXe6bLTJAPCKr/8rqWNxPeEZulfdXlyJLM6CXcyR20bidjYc5qICxZnMhOVN5yj0NVeF
         cfFJhpLzgTRVM5EuczdvOailPMm7lOWVfyFqOtwUmcnubzpIV9ogd/Dsk+g1I7u0hhgC
         LcqL8V4NgDwrY8zuWSZd5h+DvlbTSMsB7ZbEITGu4f+Jz0xCiEdovxeGlHm0eYFdtH2m
         9e3pwM4cpAbvojVWHDmDRkFWBmnAf+ZAlu23mKTKej5AJg5AltZvKDrM3L5/GQA84iBf
         2+bA==
X-Gm-Message-State: ABuFfohUWXiMBlB7Rbi4kjQTbpGid2PmddIfOuAgu/PxJEzBvMHeY7kj
        PpjeE8BQhBZUlUxNPlKU9yo=
X-Google-Smtp-Source: ACcGV60wQIU07tkWNnM1MKZ7z1mpP3D3pIYeSdarGLvfmYOJbK63LVbsHXEglWxA1NTqNaidMxEzZw==
X-Received: by 2002:a50:9622:: with SMTP id y31-v6mr20329030eda.282.1539544188806;
        Sun, 14 Oct 2018 12:09:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id d12-v6sm3822453ede.32.2018.10.14.12.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 12:09:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: cleanup comparsions to false
Date:   Sun, 14 Oct 2018 21:09:33 +0200
Message-Id: <20181014190933.16517-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup remaining comparsions to false.
if(x == false) -> if(!x)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c     |  2 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c      | 12 ++++++------
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c   |  7 ++++---
 drivers/staging/rtl8188eu/core/rtw_recv.c      |  2 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c |  2 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c      |  4 ++--
 drivers/staging/rtl8188eu/hal/usb_halinit.c    |  2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 11 +++++------
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c  |  2 +-
 9 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index cb6d1fb776da..b7be71f904ed 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -451,7 +451,7 @@ int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 								bDataEmpty = false;
 						}
 					}
-					if (bDataEmpty == false) {
+					if (!bDataEmpty) {
 						ReadState = PG_STATE_DATA;
 					} else {/* read next header */
 						efuse_addr = efuse_addr + (word_cnts*2)+1;
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 6302be43c2e0..b9bd864f323c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -228,7 +228,7 @@ int rtw_if_up(struct adapter *padapter)
 	int res;
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
-	    (check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false)) {
+	    !check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
 			 ("rtw_if_up:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
 			 padapter->bDriverStopped, padapter->bSurpriseRemoved));
@@ -578,7 +578,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 	}
 
 	/*  lock pmlmepriv->lock when you accessing network_q */
-	if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == false) {
+	if (!check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 		if (pnetwork->Ssid.Ssid[0] == 0)
 			pnetwork->Ssid.SsidLength = 0;
 		rtw_add_network(adapter, pnetwork);
@@ -615,7 +615,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	if (pmlmepriv->to_join) {
 		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
-			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
+			if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
 				if (rtw_select_and_join_from_scanned_queue(pmlmepriv) == _SUCCESS) {
@@ -1138,7 +1138,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network	*cur_network = &(pmlmepriv->cur_network);
 	struct wlan_network	*ptarget_wlan = NULL;
 
-	if (rtw_access_ctrl(adapter, pstassoc->macaddr) == false)
+	if (!rtw_access_ctrl(adapter, pstassoc->macaddr))
 		return;
 
 #if defined(CONFIG_88EU_AP_MODE)
@@ -1418,13 +1418,13 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 			goto exit;
 	}
 
-	if (rtw_is_desired_network(adapter, competitor)  == false)
+	if (!rtw_is_desired_network(adapter, competitor))
 		goto exit;
 
 	if (pmlmepriv->to_roaming) {
 		since_scan = jiffies - competitor->last_scanned;
 		if (jiffies_to_msecs(since_scan) >= RTW_SCAN_RESULT_EXPIRE ||
-		    is_same_ess(&competitor->network, &pmlmepriv->cur_network.network) == false)
+		    !is_same_ess(&competitor->network, &pmlmepriv->cur_network.network))
 			goto exit;
 	}
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index a3d3e9eb133c..9764e85c000c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -344,7 +344,7 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 	if (delta_time < LPS_DELAY_TIME)
 		return false;
 
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == false) ||
+	if ((!check_fwstate(pmlmepriv, _FW_LINKED)) ||
 	    (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) ||
 	    (check_fwstate(pmlmepriv, WIFI_AP_STATE)) ||
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) ||
@@ -352,7 +352,8 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 		return false;
 	if (pwrpriv->bInSuspend)
 		return false;
-	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) && (padapter->securitypriv.binstallGrpkey == false)) {
+	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X &&
+	    !padapter->securitypriv.binstallGrpkey) {
 		DBG_88E("Group handshake still in progress !!!\n");
 		return false;
 	}
@@ -438,7 +439,7 @@ void LPS_Enter(struct adapter *padapter)
 {
 	struct pwrctrl_priv	*pwrpriv = &padapter->pwrctrlpriv;
 
-	if (PS_RDY_CHECK(padapter) == false)
+	if (!PS_RDY_CHECK(padapter))
 		return;
 
 	if (pwrpriv->bLeisurePs) {
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 380d544c8ca7..dc447cc78c32 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -2042,7 +2042,7 @@ static void rtw_signal_stat_timer_hdl(struct timer_list *t)
 	}
 
 	/* update value of signal_strength, rssi, signal_qual */
-	if (check_fwstate(&adapter->mlmepriv, _FW_UNDER_SURVEY) == false) {
+	if (!check_fwstate(&adapter->mlmepriv, _FW_UNDER_SURVEY)) {
 		tmp_s = avg_signal_strength +
 			(_alpha - 1) * recvpriv->signal_strength;
 		tmp_s = DIV_ROUND_UP(tmp_s, _alpha);
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 53fac22ff621..3e05e2c7f61b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -846,7 +846,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	unsigned char	ht_info_infos_0;
 	int ssid_len;
 
-	if (is_client_associated_to_ap(Adapter) == false)
+	if (!is_client_associated_to_ap(Adapter))
 		return true;
 
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index ce631efd48e5..0a3e710590ed 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -1619,7 +1619,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	spin_unlock_bh(&pxmitpriv->lock);
 #endif
 
-	if (rtw_hal_xmit(padapter, pxmitframe) == false)
+	if (!rtw_hal_xmit(padapter, pxmitframe))
 		return 1;
 
 	return 0;
@@ -1636,7 +1636,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	bool mcast = is_multicast_ether_addr(pattrib->ra);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == false)
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return ret;
 
 	if (pattrib->psta)
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index f25d52fbb341..70c02c49b177 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -980,7 +980,7 @@ u32 rtw_hal_inirp_init(struct adapter *Adapter)
 	/* issue Rx irp to receive data */
 	precvbuf = precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		if (usb_read_port(Adapter, RECV_BULK_IN_ADDR, precvbuf) == false) {
+		if (!usb_read_port(Adapter, RECV_BULK_IN_ADDR, precvbuf)) {
 			RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("usb_rx_init: usb_read_port error\n"));
 			status = _FAIL;
 			goto exit;
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 408fabf9f34a..4ecd2ff48c41 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -737,7 +737,7 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported\n", iw_operation_mode[wrqu->mode]));
 		goto exit;
 	}
-	if (rtw_set_802_11_infrastructure_mode(padapter, networkType) == false) {
+	if (!rtw_set_802_11_infrastructure_mode(padapter, networkType)) {
 		ret = -EPERM;
 		goto exit;
 	}
@@ -1000,8 +1000,7 @@ static int rtw_wx_set_wap(struct net_device *dev,
 	spin_unlock_bh(&queue->lock);
 
 	rtw_set_802_11_authentication_mode(padapter, authmode);
-	/* set_802_11_encryption_mode(padapter, padapter->securitypriv.ndisencryptstatus); */
-	if (rtw_set_802_11_bssid(padapter, temp->sa_data) == false) {
+	if (!rtw_set_802_11_bssid(padapter, temp->sa_data)) {
 		ret = -1;
 		goto exit;
 	}
@@ -1354,7 +1353,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
 			 ("set ssid: set_802_11_auth. mode =%d\n", authmode));
 		rtw_set_802_11_authentication_mode(padapter, authmode);
-		if (rtw_set_802_11_ssid(padapter, &ndis_ssid) == false) {
+		if (!rtw_set_802_11_ssid(padapter, &ndis_ssid)) {
 			ret = -1;
 			goto exit;
 		}
@@ -1673,7 +1672,7 @@ static int rtw_wx_set_enc(struct net_device *dev,
 
 	memcpy(wep.KeyMaterial, keybuf, wep.KeyLength);
 
-	if (rtw_set_802_11_add_wep(padapter, &wep) == false) {
+	if (!rtw_set_802_11_add_wep(padapter, &wep)) {
 		if (rf_on == pwrpriv->rf_pwrstate)
 			ret = -EOPNOTSUPP;
 		goto exit;
@@ -2496,7 +2495,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 			psta->htpriv.ht_option = false;
 		}
 
-		if (pmlmepriv->htpriv.ht_option == false)
+		if (!pmlmepriv->htpriv.ht_option)
 			psta->htpriv.ht_option = false;
 
 		update_sta_info_apmode(padapter, psta);
diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index d93be3ca2960..017e1d628461 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -173,7 +173,7 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("+xmit_enry\n"));
 
-	if (rtw_if_up(padapter) == false) {
+	if (!rtw_if_up(padapter)) {
 		RT_TRACE(_module_xmit_osdep_c_, _drv_err_,
 			 ("%s: rtw_if_up fail\n", __func__));
 		goto drop_packet;
-- 
2.19.1

