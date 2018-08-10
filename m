Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8151DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD8822405
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLGuGUbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD8822405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeHJNVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:21:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38627 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeHJNVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:21:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so7897821wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p8T24ZMSZhctmWk1MRISHqqx7pU3b4jwEY/vZjAG3W8=;
        b=QLGuGUbrKeo0sUf/v0ZImF8iTkCEWyjAEUfiilfmdQ0gceSBwcaoMzrz9LHZOf3oA0
         7uo9okAYJnClvBu+HbXln22/zRomG5/P8pb40qQrxq/JAptstF27TW5hguCmSpHkg26x
         2f04lnInbQjcNYg/KFcCRZXbxsCQ549kvlpRJCSl5i1x2jB5d+iHVfRzd0s/hHqZAfVH
         c6U7xyjS7pQlmK0qvSQZcWDNapKkrs1w5o60huaFCK75T8qhspp4vGlgdHNFURfw43A0
         t+PfyeBjCsdDD4JWh/+TRwVYC7LAzEnX+VwWiGIySO0Ygkr10Xg6Tug96lNxj8qIW0no
         o3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p8T24ZMSZhctmWk1MRISHqqx7pU3b4jwEY/vZjAG3W8=;
        b=euzrJ9oujcETXt5NBGi9uWe7rThC75KNYqkCbZckAI8ZBtAax7HTT044UKgErOZ1oL
         WvPg7PnM6kh1qmMG+QQLRTVnCaxYdPzKyaHOyJheM7Vk/7dpPp+r0fWIWPT9b2t8Y1Hy
         Zhhmwx5FnDy2aUtL2sossfaMivh+YtnvpBumbT5J7tjL1n+X7k7WBlWAZriut6W4gXID
         yYiXDtBACHquZ9T7M1a/RhNv9UzTW7nptXHKPpzQrIrV9ta4gEt1gdzpyhLorUQer8ij
         YBb6/voBC4IViRaTWSaXLP6v4e4rhAJ1c2ucqYAOimBbnnjjIAVW9Cq+9Pc9xfC7/2b9
         gv8A==
X-Gm-Message-State: AOUpUlFCenO9tPIhG4y+rqxwjftlMawTpSlf1hlQhkfuCDm8xiB4oVvy
        PlRu+Av1meZ+VFCiJte36umkWf1R
X-Google-Smtp-Source: AA+uWPz/CwW3739S6I1PyCRsDdkca6uqVzNXDNsKt1oz1tO+TrbvrhvcMtEIMeHQZBEq1/EGzYlTyA==
X-Received: by 2002:a5d:50cd:: with SMTP id f13-v6mr4115422wrt.73.1533898308419;
        Fri, 10 Aug 2018 03:51:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id p14-v6sm14273994wru.0.2018.08.10.03.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 03:51:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 2/5] staging: rtl8188eu: use is_multicast_ether_addr in rtw_recv.c
Date:   Fri, 10 Aug 2018 12:51:30 +0200
Message-Id: <20180810105133.31224-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810105133.31224-1-straube.linux@gmail.com>
References: <20180810105133.31224-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
core/rtw_recv.c. In all uses the address array/memory is
properly aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 35 ++++++++++++-----------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 17b4b9257b49..ab9638d618a9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -233,7 +233,7 @@ static int recvframe_chkmic(struct adapter *adapter,
 
 		/* calculate mic code */
 		if (stainfo) {
-			if (IS_MCAST(prxattrib->ra)) {
+			if (is_multicast_ether_addr(prxattrib->ra)) {
 				if (!psecuritypriv) {
 					res = _FAIL;
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
@@ -321,11 +321,11 @@ static int recvframe_chkmic(struct adapter *adapter,
 
 				/*  double check key_index for some timing issue , */
 				/*  cannot compare with psecuritypriv->dot118021XGrpKeyid also cause timing issue */
-				if ((IS_MCAST(prxattrib->ra) == true)  && (prxattrib->key_index != pmlmeinfo->key_index))
+				if (is_multicast_ether_addr(prxattrib->ra) && prxattrib->key_index != pmlmeinfo->key_index)
 					brpt_micerror = false;
 
 				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
-					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
+					rtw_handle_tkip_mic_err(adapter, (u8)is_multicast_ether_addr(prxattrib->ra));
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
 					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
 				} else {
@@ -335,7 +335,7 @@ static int recvframe_chkmic(struct adapter *adapter,
 				res = _FAIL;
 			} else {
 				/* mic checked ok */
-				if ((!psecuritypriv->bcheck_grpkey) && (IS_MCAST(prxattrib->ra))) {
+				if (!psecuritypriv->bcheck_grpkey && is_multicast_ether_addr(prxattrib->ra)) {
 					psecuritypriv->bcheck_grpkey = true;
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("psecuritypriv->bcheck_grpkey = true"));
 				}
@@ -648,7 +648,7 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 	u8 *mybssid  = get_bssid(pmlmepriv);
 	u8 *myhwaddr = myid(&adapter->eeprompriv);
 	u8 *sta_addr = NULL;
-	int bmcast = IS_MCAST(pattrib->dst);
+	bool mcast = is_multicast_ether_addr(pattrib->dst);
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) ||
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
@@ -659,7 +659,7 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 			goto exit;
 		}
 
-		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast)) {
+		if (memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && !mcast) {
 			ret = _FAIL;
 			goto exit;
 		}
@@ -681,9 +681,9 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 		}
 		sta_addr = pattrib->bssid;
 	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-		if (bmcast) {
+		if (mcast) {
 			/*  For AP mode, if DA == MCAST, then BSSID should be also MCAST */
-			if (!IS_MCAST(pattrib->bssid)) {
+			if (!is_multicast_ether_addr(pattrib->bssid)) {
 					ret = _FAIL;
 					goto exit;
 			}
@@ -700,7 +700,7 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 		ret  = _FAIL;
 	}
 
-	if (bmcast)
+	if (mcast)
 		*psta = rtw_get_bcmc_stainfo(adapter);
 	else
 		*psta = rtw_get_stainfo(pstapriv, sta_addr); /*  get ap_info */
@@ -727,7 +727,7 @@ static int ap2sta_data_frame(
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	u8 *mybssid  = get_bssid(pmlmepriv);
 	u8 *myhwaddr = myid(&adapter->eeprompriv);
-	int bmcast = IS_MCAST(pattrib->dst);
+	bool mcast = is_multicast_ether_addr(pattrib->dst);
 
 	if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) &&
 	    (check_fwstate(pmlmepriv, _FW_LINKED) == true ||
@@ -740,7 +740,7 @@ static int ap2sta_data_frame(
 		}
 
 		/*  da should be for me */
-		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast)) {
+		if (memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && !mcast) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
 				 (" %s:  compare DA fail; DA=%pM\n", __func__, (pattrib->dst)));
 			ret = _FAIL;
@@ -755,7 +755,7 @@ static int ap2sta_data_frame(
 				 (" %s:  compare BSSID fail ; BSSID=%pM\n", __func__, (pattrib->bssid)));
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid=%pM\n", (mybssid)));
 
-			if (!bmcast) {
+			if (!mcast) {
 				DBG_88E("issue_deauth to the nonassociated ap=%pM for the reason(7)\n", (pattrib->bssid));
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 			}
@@ -764,7 +764,7 @@ static int ap2sta_data_frame(
 			goto exit;
 		}
 
-		if (bmcast)
+		if (mcast)
 			*psta = rtw_get_bcmc_stainfo(adapter);
 		else
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get ap_info */
@@ -789,7 +789,7 @@ static int ap2sta_data_frame(
 		ret = RTW_RX_HANDLED;
 		goto exit;
 	} else {
-		if (!memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && (!bmcast)) {
+		if (!memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && !mcast) {
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
 			if (*psta == NULL) {
 				DBG_88E("issue_deauth to the ap =%pM for the reason(7)\n", (pattrib->bssid));
@@ -1129,9 +1129,9 @@ static int validate_recv_data_frame(struct adapter *adapter,
 
 	if (pattrib->privacy) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("%s:pattrib->privacy=%x\n", __func__, pattrib->privacy));
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ^^^^^^^^^^^IS_MCAST(pattrib->ra(0x%02x))=%d^^^^^^^^^^^^^^^6\n", pattrib->ra[0], IS_MCAST(pattrib->ra)));
+		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ^^^^^^^^^^^is_multicast_ether_addr(pattrib->ra(0x%02x))=%d^^^^^^^^^^^^^^^6\n", pattrib->ra[0], is_multicast_ether_addr(pattrib->ra)));
 
-		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, IS_MCAST(pattrib->ra));
+		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, is_multicast_ether_addr(pattrib->ra));
 
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n pattrib->encrypt=%d\n", pattrib->encrypt));
 
@@ -1971,7 +1971,8 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 	if (ret == _SUCCESS) {
 		/* check if need to enqueue into uc_swdec_pending_queue*/
 		if (check_fwstate(mlmepriv, WIFI_STATION_STATE) &&
-		    !IS_MCAST(prxattrib->ra) && prxattrib->encrypt > 0 &&
+		    !is_multicast_ether_addr(prxattrib->ra) &&
+		    prxattrib->encrypt > 0 &&
 		    prxattrib->bdecrypted == 0 &&
 		    !is_wep_enc(psecuritypriv->dot11PrivacyAlgrthm) &&
 		    !psecuritypriv->busetkipkey) {
-- 
2.18.0

