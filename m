Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4152084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxsauKk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4152084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeLERDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35282 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbeLERDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so20494053wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sWRn4XuGGhXCprrJr59tzoZcef0Y6d2HdIapkdzvjc=;
        b=uxsauKk+tkU+TJIjdJuBX1zeF4dRe6rHsEz1cHM15M0CUaLfJXA9jg9mMiybLk8RQ+
         V84jW7AF94GL+J4LUeY2B0VcqWECo/nhmliCKHehi+rfHtAe7OKYuJxX0bnxUA98pnGj
         9TKAiYgU4oRYR/9CCg0p79YFJhBS+hPAh9L1gNOpzKXKhMeFw9Uf07+xSjl07suoNXlI
         2o0FcVClswkRqyHZu/fmzq/D79X80ohjxtB2qimrV2XuVs1Q0bxfSXq/r74Z29+g8kbo
         gqWv7iOtqbCYLF2W2YYJkX8YCdzW4GEbHXS/WSRr+X0Cl2Soax+MY8ZCyvLYf5BkcQDG
         X51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sWRn4XuGGhXCprrJr59tzoZcef0Y6d2HdIapkdzvjc=;
        b=EWLv+52B9b1R1YFi+/gANYt5LpjBskLzMJF7xpyeHOwo/vNfZOT0CUVVQDwiHUh3jA
         8A+idRvgXJgPteyj4UYnDz49wFKagwKYf7EP8bZaVZWYdNC97hviB7fpPsDjjIXkNpK1
         tCbrI/fAsoxrj8U5Q35McMAAR5LDXXYjKLswWZtV17HrTRpLJ3rTlyACN9ByjPsOlqHx
         zr6LNVwun7vDXutaSY2jm6eikgpAiHtYsFmtDpBb+fcsQEEWFMsD6nrOEA4XNCQHg5ML
         eTr53/m6N8EOHN2SJQGQ9zKYv9hedL1jpqLVCCffBrsmRH4tth8sgBWbEDgYZ3rEtMnJ
         RD3w==
X-Gm-Message-State: AA+aEWZrM/tUkGBGxSiPbcmNLZKYdoORD+2G4ewFJOsf6514s+T/Q5gN
        OB3/FjDFvWM4uImvMNygVV8=
X-Google-Smtp-Source: AFSGD/VUTVhX4RdPCeNEoZwT6BO3JqudFGS0vNWGewWY3wla8WRFox4BfpmKNZPCU/hpZNyJYd6wzw==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr21442074wrr.313.1544029385893;
        Wed, 05 Dec 2018 09:03:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:03:05 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/12] staging: rtl8188eu: cleanup long lines in rtw_wlan_util.c
Date:   Wed,  5 Dec 2018 18:02:42 +0100
Message-Id: <20181205170247.5401-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205170247.5401-1-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup some lines over 80 characters by adding appropriate
line breaks and removing commented code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 956a331beda2..2ffa0332bf32 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -379,7 +379,8 @@ int is_client_associated_to_ap(struct adapter *padapter)
 	pmlmeext = &padapter->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
 
-	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE))
+	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) &&
+	    (pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
 		return true;
 	else
 		return _FAIL;
@@ -390,7 +391,8 @@ int is_client_associated_to_ibss(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE))
+	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) &&
+	    (pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE)
 		return true;
 	else
 		return _FAIL;
@@ -662,8 +664,6 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var
 		struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
 		struct sta_priv	*pstapriv = &padapter->stapriv;
 
-		/* set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode); */
-
 		/* update ap's stainfo */
 		psta = rtw_get_stainfo(pstapriv, cur_network->MacAddress);
 		if (psta) {
-- 
2.19.2

