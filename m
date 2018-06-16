Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC18C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 05:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97A3208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 05:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifXmzb8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97A3208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756803AbeFPFpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 01:45:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39273 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753774AbeFPFpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 01:45:22 -0400
Received: by mail-pf0-f194.google.com with SMTP id r11-v6so5795551pfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 22:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ij6uHezBEVb87+QR7Y0BNa770bOIt7YP0Bb8HRePZSs=;
        b=ifXmzb8l0iRqHm6TLBVZgC3FoVdLBs+KwyqAHDfUEjkRuoAc27Tg7oMYq8pz0yvj2s
         7kf0XjXGE0pW5nqWtatQrAF1hbPsy3P7Cws2HFL324WDN0nPiCvQSs14wERbksi38HX4
         zVa/fmcRYiGtOMNR2BNMEKT05pfN0H6XqqgHG8U0Ev+3zmJZVHL0tzr7l2lsEetu+dVY
         A38Bt8wpIoAWqdIo9bA91o5I/k7rSn4V9d4f1DMR7eLTLzRr05UithGR+5VmhXNp6q1u
         vYbY9AUHKqcokU6yAJBbJyGvAnys9uTwmqNe6CDJIfH3QeN+LNzSJqiChUecm3kkIiV0
         +RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ij6uHezBEVb87+QR7Y0BNa770bOIt7YP0Bb8HRePZSs=;
        b=FtcVct65f050Ff7JAMmjuh5Dz+GroFCFkz5fm8UpDn2LKvhFAoNfU8V+CWyDYjC4gu
         mJMcKyrKj/yLbk3Ji2C5x/QpdCC0egxsHMTAsgMvdd5UUeDSQTDjq8fbGfiCvlMz2tsy
         mee0Gz7jVkesPLEhKArsky8YB3wyYkDKeHsV6W6XQQez4JBZntc5DwEkq7nITJecudBr
         1FgHiaFWDWnFeKQ3kIhw/Hjob/VbSXBIwZB03XkN8pAi2eBmUVqxtoOUDaOBTjpcHUtr
         gzeY7xU/FQ6fOH1ITD87svSeIC8e8kECLCMma/iFEr9t0+gYZ4HbIf8TRpFkfgWZd4bu
         kRZw==
X-Gm-Message-State: APt69E0KMTU0lM1TenetO1LSTfxyRrnk51QJvNOuN229+Cn+3VbHD5Qw
        JI6Ka44NJStxa4uBkMWME9o=
X-Google-Smtp-Source: ADUXVKLIgubiD/nyL53jyBNiifFvPSbbJ295n7JR1a3hLtB6FSoEVjx8mqAgLKCRGQSjV8oyBKRQrA==
X-Received: by 2002:a62:8f8c:: with SMTP id n134-v6mr5122805pfd.66.1529127921481;
        Fri, 15 Jun 2018 22:45:21 -0700 (PDT)
Received: from joonhwan-virtualbox.localnet ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id y20-v6sm11364502pge.46.2018.06.15.22.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 22:45:20 -0700 (PDT)
From:   "JoonHwan.Kim" <spilit464@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        stefano.manni@gmail.com, liamryandev@gmail.com,
        martin@martinhomuth.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Adjust if statements to reduce indentation level
Date:   Sat, 16 Jun 2018 14:45:17 +0900
Message-ID: <11086518.O9o76ZdvQC@joonhwan-virtualbox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge two condition of if statements in
r8712_surveydone_event_callback()

Signed-off-by: Joonhwan Kim <spilit464@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 51 +++++++++++++-------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index ac547ddd72d1..b8618b0565d5 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -566,32 +566,31 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 	}
 
 	if (pmlmepriv->to_join) {
-		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-			if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
-				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
-
-				if (r8712_select_and_join_from_scan(pmlmepriv)
-				    == _SUCCESS) {
-					mod_timer(&pmlmepriv->assoc_timer, jiffies +
-						  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
-				} else {
-					struct wlan_bssid_ex *pdev_network =
-					  &(adapter->registrypriv.dev_network);
-					u8 *pibss =
-						 adapter->registrypriv.
-							dev_network.MacAddress;
-					pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
-					memcpy(&pdev_network->Ssid,
-						&pmlmepriv->assoc_ssid,
-						sizeof(struct
-							 ndis_802_11_ssid));
-					r8712_update_registrypriv_dev_network
-						(adapter);
-					r8712_generate_random_ibss(pibss);
-					pmlmepriv->fw_state =
-						 WIFI_ADHOC_MASTER_STATE;
-					pmlmepriv->to_join = false;
-				}
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) &&
+		    !check_fwstate(pmlmepriv, _FW_LINKED)) {
+			set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
+
+			if (r8712_select_and_join_from_scan(pmlmepriv)
+			    == _SUCCESS) {
+				mod_timer(&pmlmepriv->assoc_timer, jiffies +
+					  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
+			} else {
+				struct wlan_bssid_ex *pdev_network =
+				  &(adapter->registrypriv.dev_network);
+				u8 *pibss =
+					 adapter->registrypriv.
+						dev_network.MacAddress;
+				pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
+				memcpy(&pdev_network->Ssid,
+					&pmlmepriv->assoc_ssid,
+					sizeof(struct
+						 ndis_802_11_ssid));
+				r8712_update_registrypriv_dev_network
+					(adapter);
+				r8712_generate_random_ibss(pibss);
+				pmlmepriv->fw_state =
+					 WIFI_ADHOC_MASTER_STATE;
+				pmlmepriv->to_join = false;
 			}
 		} else {
 			pmlmepriv->to_join = false;
-- 
2.17.1




