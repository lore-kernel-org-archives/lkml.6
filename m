Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4ACC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D13A20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk7zCB4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D13A20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbeGKMbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:31:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40509 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733244AbeGKMbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:31:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so19067381edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hS0c9Q4FLdJnn5wLwdiXGqgLYM6hAoVwT+eOvDl6Yc=;
        b=Bk7zCB4Bm7iB/5eAhvZbdp61wdmD6i9QXopskhB+ZXC8IVHaTpJztPmZ3Q4X416aSh
         fTKDyi7JxcWd02KRr3FyCuuaSjYYVguAZdqqImkycNL36Y34omHjnQZDpQJ+bFjruUjr
         kJh2GknuSy9sag+6363H1u54R8bW7SbwXCuVNB0pKozEpRJV4S45wGF1HMMznOPrSJp7
         W8kKEMah7pRC8CFbw2PWI2Og2FddFNGUJWJws0BeUh+Is97iYP8SjcOzPqmmXb09Q1nn
         7p1jx2tK8rGI508Er58H8LIk4rsoq9/6Ui0jThT7CAYdkf3E5YXSKVlvSQ7hfQ2lppJt
         bztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0hS0c9Q4FLdJnn5wLwdiXGqgLYM6hAoVwT+eOvDl6Yc=;
        b=di8beWImjrYv3RLJLgl06+qyPL/OJ41nPDpQ2FT/H/BhdgRDU+QFit3UwqlMwcdkZy
         G8FXCn2NYwCK0aOay/lXCpASIpVZ0GBxspp8coArT5F56sC7jdw+1iYx0Da/Uora3L7d
         wYJoz/a7av8XUAA8ivCd8zbj2hzRE+TkPlBGKE6XeV3RAXOHc62XOlZZf9bUdtW+v2c2
         YtxUFJrjinc1JLocnknmFn1k1UbnCL57wo04+8/ASbBQT3QGpGiyd5uqbWI0ChzzRc/8
         3/9d2PsB7cU66XSM9Our0kG9cXwVqzhRIZL/FnRxNSfdNrsPH16mFB6V+HMVWWawuXdC
         emGQ==
X-Gm-Message-State: APt69E1bCBovydBSVwrfZYF+V78Tc5fHT5hAz432pEqnX0E9+0PIsF7X
        XC+8SXhe5sDA4jvKWOZ1yjW4Kq0W
X-Google-Smtp-Source: AAOMgpf6mcc8Bm/oNN9tXvZMKgFzpj5NrwkfwTvnhxUxfGGyNCihvnyMXt/V5NEpGiAH1XkMpRpqJA==
X-Received: by 2002:a50:f4aa:: with SMTP id s39-v6mr31078668edm.262.1531312058642;
        Wed, 11 Jul 2018 05:27:38 -0700 (PDT)
Received: from arch.localdomain (x4db0e292.dyn.telefonica.de. [77.176.226.146])
        by smtp.gmail.com with ESMTPSA id i12-v6sm11855623edf.26.2018.07.11.05.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:27:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: remove blank lines
Date:   Wed, 11 Jul 2018 14:27:15 +0200
Message-Id: <20180711122715.22234-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711122715.22234-1-straube.linux@gmail.com>
References: <20180711122715.22234-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unrequired blank lines as reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c        | 6 ------
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index be1e8bf41e00..454a975a14f2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -626,7 +626,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	else
 		psta->ieee8021x_blocked = false;
 
-
 	/* update sta's cap */
 
 	/* ERP */
@@ -725,7 +724,6 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	cur_bwmode = HT_CHANNEL_WIDTH_20;
 	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
-
 	/* check if there is wps ie,
 	 * if there is wpsie in beacon, the hostapd will update
 	 * beacon twice when stating hostapd, and at first time the
@@ -875,7 +873,6 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return _FAIL;
 
-
 	if (len < 0 || len > MAX_IE_SZ)
 		return _FAIL;
 
@@ -885,7 +882,6 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	memcpy(ie, pbuf, pbss_network->ie_length);
 
-
 	if (pbss_network->InfrastructureMode != Ndis802_11APMode)
 		return _FAIL;
 
@@ -1681,7 +1677,6 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 	/* clear cam entry / key */
 	rtw_clearstakey_cmd(padapter, (u8 *)psta, (u8)(psta->mac_id + 3), true);
 
-
 	spin_lock_bh(&psta->lock);
 	psta->state &= ~_FW_LINKED;
 	spin_unlock_bh(&psta->lock);
@@ -1730,7 +1725,6 @@ int rtw_sta_flush(struct adapter *padapter)
 	}
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
-
 	issue_deauth(padapter, bc_addr, WLAN_REASON_DEAUTH_LEAVING);
 
 	associated_clients_update(padapter, true);
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 1aed507dd7cb..5c4f3f8d013f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1308,7 +1308,6 @@ void update_tx_basic_rate(struct adapter *padapter, u8 wirelessmode)
 	else
 		memcpy(supported_rates, rtw_basic_rate_ofdm, 3);
 
-
 	if (wirelessmode & WIRELESS_11B)
 		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
 	else
-- 
2.18.0

