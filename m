Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D92ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324A321471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="droE+RCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324A321471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeIRNjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:39:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37811 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbeIRNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:39:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id n11-v6so1543556wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=deehyEj+k13wwPLIW0YCKCR+71RrJ/a2PfzRJgDLb4A=;
        b=droE+RCRjk734fWUvdponn6zNGFbTHHHL/ImfD5NhKYfQ9d8kwprqIcKtKnQtaqzkN
         zAvModU/hceb7yJNt0/dD/t0sohOLqksMlD1D4clOenqpuXXDylDqSh/dyg6MCMByNwB
         DTAhDaxDAY4S16TOL1se3FtLBTWRJDUgLCS/S+rCOSiZoXF1Xze19dyi0I1wJP49vR9G
         KMfDBRsny3r2lwsbelxI7gRDy/BE+3AuC2eUrone8Dp7NKtVNBTvShUA2doO7LpZ5flI
         B/10d4whdiZj9xVe1al6m3dWEZvCTwH3S4M95DM9smFp1uPAIm1z98iRhVXKtGgYYuYa
         haIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=deehyEj+k13wwPLIW0YCKCR+71RrJ/a2PfzRJgDLb4A=;
        b=ab/beA5WtpOwRTOL4Eijc1tu+GYv8/mYS386uKvuR+vYt33EKetxfwFXDAYCPSo7IP
         JDDNfYUaods68nFISRpDJeoFIJSrh3p/JMLCmg2tng4mi3W/RVJ1OyOVuZGtVBu8xmso
         OAel2HsbeoofyjNrCpDFjRjfImlCdBLu7/q8JzzxLykMyaTOCZRk7d2WeX4EFc8HK0Ud
         oU0yf+v+6ycNWY7m+76tBwDE9Y0ZNOXB3wE8NTrxo7LttIN0SBlW8DCE+cNQsTsYDdm9
         0bQHsQj7AIKEJUiNno3oOo3xb38kJ9oaYYInoAva58SUOYQsXJ96t+ooBlUgDu0D2aPX
         mP7Q==
X-Gm-Message-State: APzg51B/s2xyoTA7oW8/5Cj/vLLAY9o9g1NO6E8q3r+5+5OUL9YynP7C
        4+81ME2AvfivJd+8/e8fbpg=
X-Google-Smtp-Source: ANB0VdY/B/EemV6+P6Oh0nNkjpCHTa/prgFh2oRJA1kYKK1M/9/GpEPoo7lCRsmPEPvylhv4o8iaFQ==
X-Received: by 2002:a1c:3a08:: with SMTP id h8-v6mr13682017wma.126.1537258064525;
        Tue, 18 Sep 2018 01:07:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id r140-v6sm1386869wmd.7.2018.09.18.01.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:07:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 6/8] staging: rtl8188eu: add missing spaces around operators
Date:   Tue, 18 Sep 2018 10:07:09 +0200
Message-Id: <20180918080711.21594-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180918080711.21594-1-straube.linux@gmail.com>
References: <20180918080711.21594-1-straube.linux@gmail.com>
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

