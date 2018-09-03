Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB16BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CE12077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnF2RJum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CE12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeICWqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:46:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51153 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbeICWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:46:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so2020610wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CF0v3CUL0BbkHPXtKcFpD/N3oU2n8nfdVFmluJscCPQ=;
        b=GnF2RJum8KQo9HbAaghZpNjcUa/KSjtRkNueLB9aoDJLcx8zIbuIlVfLYi3sz+BBoX
         4JdsBk+qlUqK84FhOZ+jGNfRskDCQoNRV4THhwb0U+ycIUxMarc7esBLfqdTKz5REdlI
         mUKd18ugEn9gkkJjAVrfJYIACPRojfPuakkJDHoqK0kiZV7SrqiVP9h/sOpnRTMM4rRQ
         QR0lYxIC0p25VX93+oYh2G89BNo7eEWyFDgnx9sgrxe/tUZkT7hAT/6AtU9+JUA0zi4a
         JphDIi/w2B2kfswuuPLEFbrN/CBsAaWygEQM6rWZpc+SeSlE04bH/sL/+CIkm9a8Yx9H
         1Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CF0v3CUL0BbkHPXtKcFpD/N3oU2n8nfdVFmluJscCPQ=;
        b=f3tME5JMOp1ktej/qIxp0dzZE3XIhfMEhVvPq/fFvH6/O1eRI+B7fZQoQTphAJdSkf
         MRXxAKHLnR1VEj9wMX1clsUlwMGKTTRriNPzdrv1SXb7xl1ZE9Zwg81o26zotSpNYvbq
         wnb44+4wZWOl417JmOP+95mEvcHgx+XlkRVerrnvao6gBG8EadHq1LE8jItBprUP4QwY
         hmWv940JTCSTFu1eitrfRhhnis38nnxTzykU62J4Go3vNWjdeq1rnWlQ4HyUsSSH8qr4
         kwQ82GBy3LEb0Il7vF2oGJluJ3A4l/ldkeIfGgkg+IntxHr4nkVI7Pt3ufq6ESY9GDOX
         KFYg==
X-Gm-Message-State: APzg51B3E6Sk5LmWlLJrucxSDde1ozMtY7rwFvsQ803FxfvNKZhOnay2
        8jhHNUiAcXvgZUQ/b2GZeKM=
X-Google-Smtp-Source: ANB0Vdbvtfs49tpj/UqFA0J+nCIjBLf8PA509686uwAdp8OXubdhL2G7ENYtPN1MAEEfugH+r3cWoQ==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr396279wmd.44.1535999098852;
        Mon, 03 Sep 2018 11:24:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v46-v6sm24201349wrc.63.2018.09.03.11.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:24:58 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: remove whitespace
Date:   Mon,  3 Sep 2018 20:24:44 +0200
Message-Id: <20180903182445.1969-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903182445.1969-1-straube.linux@gmail.com>
References: <20180903182445.1969-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces where appropriate.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 20d7bba2cfd4..a911c254b386 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -107,8 +107,8 @@ unsigned char networktype_to_raid(unsigned char network_type)
 u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int ratelen)
 {
 	u8 network_type = 0;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	if (pmlmeinfo->HT_enable)
 		network_type = WIRELESS_11_24N;
@@ -120,7 +120,7 @@ u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int ratelen
 	else
 		network_type |= WIRELESS_11G;
 
-	return	network_type;
+	return network_type;
 }
 
 static unsigned char ratetbl_val_2wifirate(unsigned char rate)
@@ -1413,10 +1413,10 @@ void update_wireless_mode(struct adapter *padapter)
 {
 	int ratelen, network_type = 0;
 	u32 SIFS_Timer;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex	*cur_network = &(pmlmeinfo->network);
-	unsigned char		*rate = cur_network->SupportedRates;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	unsigned char *rate = cur_network->SupportedRates;
 
 	ratelen = rtw_get_rateset_len(cur_network->SupportedRates);
 
-- 
2.18.0

