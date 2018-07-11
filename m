Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB70C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A453320835
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qasT+k5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A453320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbeGKL20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:28:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45510 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeGKL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:28:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id i20-v6so5929323eds.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C+t1eAGF2xieG8S63z3q2Y1gcyWToPOR65bLNaYxJUs=;
        b=qasT+k5Et3sjOoNd+Ov5WbdGa+eUwMZymlizdh234pseO7w1bERiNgooFQDUzxw60G
         rjS3BYiPgK9WguYMddD7LeuQsElnIEf+L/fbJc6l+GveVALxomdu6BbAQGWj7IPNoVA3
         BiEi5IDTOzItRc32efHWmJtWf2ssnPEye4PtZM1iQzudiQAxD183RFuswnApBkcGDqdp
         VnX+gExBbvDcBGX5MHX2hH8CxVSDf9Tib5ytqc7A3LOCBdRemajN23eXl3rkTPRnVX46
         stij0DnWE8iLCi5F7iG0Fj7HpqcdAkvFCHvlV0/N2f4cQqjiigtnhmdLbT2Pzg+4V30K
         sNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C+t1eAGF2xieG8S63z3q2Y1gcyWToPOR65bLNaYxJUs=;
        b=TPWKnaVpaZ9MVS6qBXNC1fuVST1CoJ1paWWXaACBkvH4if1EZTJXOJ2Fv5OknycTXn
         TPkGth0S+4fwLyL+QuRqgsjiekb9intOKnU4mjL2OrD44FjzUUO+nwlOmSzjcGcgnyM5
         3nKONi0tTNjq0NIxkN8vhUtk3DT8EdPbeIdNkAmnj6ju9SORNMcq0dI6lYdTvQukQtjx
         f42M4iCsSi7bID9S5PY7iHQ+E7d088NqynH9dj/buEwb+qw4W6x1RG5ME3WTB5CeGPy1
         tQ6VxpcxgBrfDpwLqiODQcfsffW87gjVrvo+tJJo28/ERHcxcenIpIS2f4VFx9jKT86m
         H2Vg==
X-Gm-Message-State: APt69E1C+Eh58yhbq10K8f3gwmbO+acTNm4EOIhpG0SmJWov5lt2up3p
        zcKwLI5RdHehDyWq0M9CCbU=
X-Google-Smtp-Source: AAOMgpeBTkvs6GzZEt74dC87hVnt1SGoFUvI/JnuvuMz/TnNEdpIUCjmb5mxw/hzAn8al76itMJUDA==
X-Received: by 2002:a50:8ea1:: with SMTP id w30-v6mr23743505edw.295.1531308272655;
        Wed, 11 Jul 2018 04:24:32 -0700 (PDT)
Received: from arch.localdomain (x4db0e292.dyn.telefonica.de. [77.176.226.146])
        by smtp.gmail.com with ESMTPSA id h1-v6sm8186346eds.68.2018.07.11.04.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 04:24:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: rtl8723bs: fix comparsions to NULL
Date:   Wed, 11 Jul 2018 13:23:29 +0200
Message-Id: <20180711112330.28020-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711112330.28020-1-straube.linux@gmail.com>
References: <20180711112330.28020-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comparsions to NULL to follow kernel coding style.
x == NULL -> !x
x != NULL -> x

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 106b4f13efc7..fef04310ccd8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1106,7 +1106,7 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv 		*phtpriv = &pmlmepriv->htpriv;
 
-	if (pIE == NULL)
+	if (!pIE)
 		return;
 
 	if (phtpriv->ht_option == false)
@@ -1189,7 +1189,7 @@ void HT_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv 		*phtpriv = &pmlmepriv->htpriv;
 
-	if (pIE == NULL)
+	if (!pIE)
 		return;
 
 	if (phtpriv->ht_option == false)
@@ -1341,7 +1341,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	bssid = rtw_zmalloc(sizeof(struct wlan_bssid_ex));
-	if (bssid == NULL) {
+	if (!bssid) {
 		DBG_871X("%s rtw_zmalloc fail !!!\n", __func__);
 		return true;
 	}
@@ -1416,7 +1416,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 
 	/* checking SSID */
 	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
-	if (p == NULL) {
+	if (!p) {
 		DBG_871X("%s marc: cannot find SSID for survey event\n", __func__);
 		hidden_ssid = true;
 	} else {
@@ -1879,7 +1879,7 @@ int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_l
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	pIE = (struct ndis_80211_var_ie *)rtw_get_ie(pvar_ie, _SUPPORTEDRATES_IE_, &ie_len, var_ie_len);
-	if (pIE == NULL)
+	if (!pIE)
 		return _FAIL;
 
 	memcpy(pmlmeinfo->FW_sta_info[cam_idx].SupportedRates, pIE->data, ie_len);
@@ -2219,9 +2219,9 @@ void rtw_get_current_ip_address(struct adapter *padapter, u8 *pcurrentip)
 
 	if ((pmlmeinfo->state & WIFI_FW_LINKING_STATE) ||
 			pmlmeinfo->state & WIFI_FW_AP_STATE) {
-		if (my_ip_ptr != NULL) {
+		if (my_ip_ptr) {
 			struct in_ifaddr *my_ifa_list = my_ip_ptr->ifa_list;
-			if (my_ifa_list != NULL) {
+			if (my_ifa_list) {
 				ipaddress[0] = my_ifa_list->ifa_address & 0xFF;
 				ipaddress[1] = (my_ifa_list->ifa_address >> 8) & 0xFF;
 				ipaddress[2] = (my_ifa_list->ifa_address >> 16) & 0xFF;
-- 
2.18.0

