Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4046C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8CC20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1RwSRu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8CC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeLESb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35400 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLESbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so20772060wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sWRn4XuGGhXCprrJr59tzoZcef0Y6d2HdIapkdzvjc=;
        b=Y1RwSRu7ptQn+ZDL310IELWQBeKZL6ewfHbBZiK00R4AN6rT7YJf8VBdAsESgWhl63
         6m5kZaulBvND8pPEMaUyD1YVn52eIb69k4AZ4509Li+BoxozCmjoxYu6QYoQ8TkfttT+
         h/N4ORCpvxMSKn7tzWVVaj45SADHF66hFMsluVGg9LyAN+VPQCP5L+iyiSGYO3SHCG4Z
         5lxnXDbhuyHkDwrsaOM3Vw2qoec6P52b39KPUOjm/Q0p5hbO+26FyINL2HP2bwpZ+CMl
         L48iaM1gupkf6F+bHIrrggnGBuHqwKeZy0Wg2YM7XRbhGyS8YhVE0m6FgM5mLHYyV0c2
         D7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sWRn4XuGGhXCprrJr59tzoZcef0Y6d2HdIapkdzvjc=;
        b=kk4emqbYz4PT9d3WiIPc1RHrl3MhBj/hzM2j0FWlsTDcha25s7q/SJPtuTUSBt/khu
         1K9p5j1zkU3yYzIaxoGMvG7YhtosByGNip2es8nSnNRrzKXy18MyuLeh3TpaGcGiO2DG
         5x54zK3cdLWkQnfgk9ydJMtCqa52vMUZPzCi+5iCY7U5BctROzmopf63BgRIJadUAYKv
         OvwxbyhemzU5yrY2udrDzSHV0ICKljTGYtozOs9D822kBlQ8qHBTlJzERxroLgONrchT
         o9LvhJ3QzA6WnOyVOXc9VI2adiVfp6W5TvB7Vu8TTOFMFJlWzQwWltW4gVAPyqzs+seq
         hplw==
X-Gm-Message-State: AA+aEWbiCWjqrDbRSfw+8828UMo5rWVzqVj8ECIhN/2QYRGJY0kHfvw2
        riZprHczQxQMGFXFi0cv3uA=
X-Google-Smtp-Source: AFSGD/VycAcvJ44PZifvCuJ3ntbEvccEj4MrzfO6rYRUN9vTrG+HasVItSgzxhCDVbKqLNN+VfYzzQ==
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr23673342wrv.187.1544034680213;
        Wed, 05 Dec 2018 10:31:20 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:19 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 07/12] staging: rtl8188eu: cleanup long lines in rtw_wlan_util.c
Date:   Wed,  5 Dec 2018 19:30:55 +0100
Message-Id: <20181205183100.16828-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205183100.16828-1-straube.linux@gmail.com>
References: <20181205183100.16828-1-straube.linux@gmail.com>
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

