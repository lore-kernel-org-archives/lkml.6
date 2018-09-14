Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A85FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8668220833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjYZEwIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8668220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeINU1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:27:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39181 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbeINU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:27:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id q8-v6so2311194wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=deehyEj+k13wwPLIW0YCKCR+71RrJ/a2PfzRJgDLb4A=;
        b=KjYZEwIAtfaivPizgbwUQ2i/GSWWS7oZaoL59fQRspJ2W52QdIAvLgKWCuR2a907nI
         5zZjBdC0NtyqPzCgnt+suV9zLIUeAWD83Y5FrmV+eurXvf+vUSoQuX6rvv6+jFPy1zLN
         qzbWqkjK4pYS0yAtI8oda/rzU7Y+67+4zYO/EUx13Sg8OMCFmjvueaXz0VJAO4/Edd2B
         n8DU7TXZzyMvUPshxn2+/iYYpoUtNpt/rsjoK/Rk4TmdULP/OPIqlGxUv249svc09JlM
         DSNlfbdH2QrObN9zLWVAVwTJPIJb6Z0iZggQK2nU8VlxgYuRbbHi1sMQIbyKJ93abLzE
         JsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=deehyEj+k13wwPLIW0YCKCR+71RrJ/a2PfzRJgDLb4A=;
        b=oOA8VC7sX7SMfx2Zb06wseXk7fFZ/Hew83/SR3tMdpCsi6xbT06FCVoyc4J8bGA8d3
         K8IheqxARNH65HmWl4/QhQHxCR0JTq4tIqNQlx2o7U296HnNWBLqJaVZfT4XPOp3H7gh
         y9r173JSDGx3P3Dsq0jUYmWwewd/9S2w1pUAyKrxgn9lhhQpMtx8rtrWswqB1WnJ5TVv
         GBJ95f7p0uCs7rPBI3R3KyBXD0huGV1ZKrkez1I+/3vFPxH0UfUIrCih9XI7UPcfw9/j
         t0Mxl106Sp9g9oELRwOgXqIwwxdU1tVGyJEWqpXCVjSfqIk7x0plGX3SosjsK69vf6gM
         pocA==
X-Gm-Message-State: APzg51BOlZ8AU3i1HvpYH8UJxvkbAuCV3ibs2h59iTqLkjGdc1P297jz
        2S9RTg40aZ28NVCNkQMDmjE=
X-Google-Smtp-Source: ANB0Vdb71dUL05UOJ1ZBZYJfRYgKh0Sf9jJ+aKXzSC50FMQ8l9PiduR7zjJ2a2Z/Q8/YzgYeMvZnZw==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr2787632wmf.89.1536937922846;
        Fri, 14 Sep 2018 08:12:02 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa89.dynamic.kabel-deutschland.de. [31.18.250.137])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5198502wrn.58.2018.09.14.08.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 08:12:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: rtl8188eu: add missing spaces around operators
Date:   Fri, 14 Sep 2018 17:11:40 +0200
Message-Id: <20180914151142.1179-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180914151142.1179-1-straube.linux@gmail.com>
References: <20180914151142.1179-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces around '|', '-', and '&' to follow kernel coding
style. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index db983f15ddd6..d6d6a232c4ec 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -141,7 +141,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 		goto release_mlme_lock;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE)) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
 
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
@@ -225,7 +225,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 		goto release_mlme_lock;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE)) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
 			 ("set_ssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
 
@@ -409,14 +409,14 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 		goto exit;
 	}
 
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) ||
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) ||
 	    pmlmepriv->LinkDetectInfo.bBusyTraffic) {
 		/*  Scan or linking is in progress, do nothing. */
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("%s fail since fw_state = %x\n", __func__, get_fwstate(pmlmepriv)));
 		res = true;
 
 		if (check_fwstate(pmlmepriv,
-				  _FW_UNDER_SURVEY|_FW_UNDER_LINKING))
+				  _FW_UNDER_SURVEY | _FW_UNDER_LINKING))
 			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###_FW_UNDER_SURVEY|_FW_UNDER_LINKING\n\n"));
 		else
 			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###pmlmepriv->sitesurveyctrl.traffic_busy == true\n\n"));
@@ -550,8 +550,8 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	    !check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
 		return 0;
 
-	if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N|WIRELESS_11_5N)) {
-		p = rtw_get_ie(&pcur_bss->ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->ie_length-12);
+	if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N | WIRELESS_11_5N)) {
+		p = rtw_get_ie(&pcur_bss->ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->ie_length - 12);
 		if (p && ht_ielen > 0) {
 			/* cur_bwmod is updated by beacon, pmlmeinfo is updated by association response */
 			bw_40MHz = (pmlmeext->cur_bwmode && (HT_INFO_HT_PARAM_REC_TRANS_CHNL_WIDTH & pmlmeinfo->HT_info.infos[0])) ? 1 : 0;
@@ -569,7 +569,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 		}
 	} else {
 		while (pcur_bss->SupportedRates[i] != 0 && pcur_bss->SupportedRates[i] != 0xFF) {
-			rate = pcur_bss->SupportedRates[i]&0x7F;
+			rate = pcur_bss->SupportedRates[i] & 0x7F;
 			if (rate > max_rate)
 				max_rate = rate;
 			i++;
-- 
2.19.0

