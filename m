Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1986FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ACE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnKyvHEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ACE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeINU1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:27:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53584 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINU1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:27:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so2299201wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A67bVtHbnVNiPPU1tA7dK6iWxKgLQonn0EiJ9UuUc9k=;
        b=UnKyvHEcM/+XIqWDRPWPSNxdOpMmvD6ZDi1dnXv7lgaX9NMKIveW7sl5j0nCuaqK6H
         DG5qqMOLIkhKlB1BlDhlENT1Z3Qs6emUt13A2ewMu/bwDKySUa3N4eeGwHdjrXfvNZjq
         /oxOytKZM2CpH7IWP8iq+1igpl6rc56mSClGZM5HavFR+rE4na3AUBfC4gASUxmNE/5B
         j+Z28vOTybxmXgcfrPXHoHdfvHpUHMCng7q8gvYfT13Q/LtEUpg070GWc9n6qVj4LqMY
         4ClxfNeqKQTDPAwUsQSQmwnu7VXc7hmB79rfSzKsArW1mi0qCZetE3y27XOhI+PaUW7T
         SIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A67bVtHbnVNiPPU1tA7dK6iWxKgLQonn0EiJ9UuUc9k=;
        b=qbVAJie+HaUO8uRQhz22tsk22seZOd9TG362lArN+a2iKcOJsYy7NXLxZ7MSW8kjZH
         37jtk1O/bh2WUE5eoQeDeLnHphiAIWN6smlsp3dxQVRZPwSCWKe1V9JKce7rsq+h6u1r
         orE33V83GEBqgIx+S7g+SwaNZW+WsLKZx15UOgzXy9meP0+70ZM6UET770aFLnCqq2RB
         EsYhPxPxrQn5P3pNwgmuEjcoLhOuYzzLGW6hhTzD/9+rmXFaVn00mHbmlz8aqhJAWRMq
         LtdCRbSBoaz+3P6YI08C9pupX5frnJ21Yw9Akj7xzouv9ouskN804Hx7+2Y+K0CG7gIR
         LP/w==
X-Gm-Message-State: APzg51BxOpIDds6HObGpaFcSj04Vzy1S5b/6OGLgVBzbVFAN+4VZsBrX
        WxwLwA6UHCw4mJZ53DKGvGg=
X-Google-Smtp-Source: ANB0Vdb4Ip85dcf9vmLvTCrKEgjKSC4Lbq+qzlDc1Bf5hG57W5PQ3Xryo1p/t+Vk3hxraaEz8RGl7w==
X-Received: by 2002:a1c:5e08:: with SMTP id s8-v6mr2806737wmb.88.1536937924438;
        Fri, 14 Sep 2018 08:12:04 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa89.dynamic.kabel-deutschland.de. [31.18.250.137])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5198502wrn.58.2018.09.14.08.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 08:12:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: rtl8188eu: fix lines over 80 characters
Date:   Fri, 14 Sep 2018 17:11:41 +0200
Message-Id: <20180914151142.1179-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180914151142.1179-1-straube.linux@gmail.com>
References: <20180914151142.1179-1-straube.linux@gmail.com>
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

