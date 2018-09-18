Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115BCECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45EB20867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eux/cD8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45EB20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbeIRNjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:39:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53781 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbeIRNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:39:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so1368896wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A67bVtHbnVNiPPU1tA7dK6iWxKgLQonn0EiJ9UuUc9k=;
        b=eux/cD8adtg8EpfzNvTbGuEva8AaI2WXHYbP0WIozUgLo6BpMkIlnveKCoGPcxNb0l
         2fYSHdchWYS18op8WXaJ+fSe29GmFKEOe/PzX3WO6X4CyOybwsFKYZTl0rN7Zi6lvWLV
         xITDH8aeQcitM+VQ4w5uT4zRBbixNcRSVhfaKb0MeXoiyCRUDshxzi8T+U0mMrXBxDh9
         atkvKhHQmH7JoZpn0R5c9VG83a9Rb8crUE8jL4PFeAQVwRCDx/P7HPQYgVyaMgru1rlW
         4Skiv71CBYRE5SeE7aPthTmrLWqhWs3o2/kLiU/zAo/PEis4DzW7YSZUwyKLBO0329Qr
         o8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A67bVtHbnVNiPPU1tA7dK6iWxKgLQonn0EiJ9UuUc9k=;
        b=TM8Kx0mYmA6eoFF39KVZ/ULbISs8+yqhbC/ENwdDtd1DUYy4aPXAFnArRljKRnVU8/
         P907LIJRcAUCsmCiE6TeC4jFb0oIMuHtSyXzRaABbuxzNa6JRwJeXLsxQtFa1k6r0tZF
         f+h8PKQP7Jo9dGARG7CtXSMmJb/wmWpcbRwB6gVDEO3nMQyWBWCNWKz+2OGK/7niqkIl
         Cb4Jr/vWvv3TFSoBS/SD7MklOOdJovJjBfncjP8tRQL791+dksVTIPFyqulEFLFbAAvH
         z4FVDHcgx2Kemd7eONxgqdgpF3/cf+TN3I2ZfHa1rp7g5WjzW+cTd2QEq9oT56gGNjpt
         +gVA==
X-Gm-Message-State: APzg51B9rfZsT58sOj2J/faW6NHssN4z7/nf+pfxtSBO1aSFtamheN7i
        AmfbUqjoDwUAbJMrFg+9XQY=
X-Google-Smtp-Source: ANB0VdbHRAqWLm4wjbPFHY3z4l9O/KoDCCyq3d++febr1Mz2owSH4UDlJGWbfQJWdC62SUMET00+9A==
X-Received: by 2002:a1c:5f85:: with SMTP id t127-v6mr13555011wmb.16.1537258066028;
        Tue, 18 Sep 2018 01:07:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id r140-v6sm1386869wmd.7.2018.09.18.01.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:07:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 7/8] staging: rtl8188eu: fix lines over 80 characters
Date:   Tue, 18 Sep 2018 10:07:10 +0200
Message-Id: <20180918080711.21594-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180918080711.21594-1-straube.linux@gmail.com>
References: <20180918080711.21594-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap lines over 80 characters where appropriate to
clear checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index d6d6a232c4ec..c291d3a0fdcc 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -339,7 +339,8 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 		    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
 			rtw_free_assoc_resources(padapter);
 
-		if (*pold_state == Ndis802_11Infrastructure || *pold_state == Ndis802_11IBSS) {
+		if (*pold_state == Ndis802_11Infrastructure ||
+		    *pold_state == Ndis802_11IBSS) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED))
 				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether  issue dis-assoc_cmd or not */
 	       }
@@ -444,7 +445,8 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 	int res;
 	u8 ret;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_802_11_auth.mode(): mode =%x\n", authmode));
+	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
+		 ("set_802_11_auth.mode(): mode =%x\n", authmode));
 
 	psecuritypriv->ndisauthtype = authmode;
 
@@ -497,7 +499,8 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 		 ("rtw_set_802_11_add_wep:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
 		 wep->KeyLength, wep->KeyIndex, keyid));
 
-	memcpy(&psecuritypriv->dot11DefKey[keyid].skey[0], &wep->KeyMaterial, wep->KeyLength);
+	memcpy(&psecuritypriv->dot11DefKey[keyid].skey[0],
+	       &wep->KeyMaterial, wep->KeyLength);
 
 	psecuritypriv->dot11DefKeylen[keyid] = wep->KeyLength;
 
@@ -551,7 +554,8 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 		return 0;
 
 	if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N | WIRELESS_11_5N)) {
-		p = rtw_get_ie(&pcur_bss->ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->ie_length - 12);
+		p = rtw_get_ie(&pcur_bss->ies[12], _HT_CAPABILITY_IE_,
+			       &ht_ielen, pcur_bss->ie_length - 12);
 		if (p && ht_ielen > 0) {
 			/* cur_bwmod is updated by beacon, pmlmeinfo is updated by association response */
 			bw_40MHz = (pmlmeext->cur_bwmode && (HT_INFO_HT_PARAM_REC_TRANS_CHNL_WIDTH & pmlmeinfo->HT_info.infos[0])) ? 1 : 0;
@@ -568,7 +572,8 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 			);
 		}
 	} else {
-		while (pcur_bss->SupportedRates[i] != 0 && pcur_bss->SupportedRates[i] != 0xFF) {
+		while (pcur_bss->SupportedRates[i] != 0 &&
+		       pcur_bss->SupportedRates[i] != 0xFF) {
 			rate = pcur_bss->SupportedRates[i] & 0x7F;
 			if (rate > max_rate)
 				max_rate = rate;
-- 
2.19.0

