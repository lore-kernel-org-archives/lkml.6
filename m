Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF618C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D6420864
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzzxdsDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D6420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756877AbeFPGD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 02:03:29 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37998 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbeFPGD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 02:03:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id b14-v6so6386562pls.5;
        Fri, 15 Jun 2018 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+VzEqbBKzVBTdM11cwTXo5712b5DHL2DQGTDC8I+mU=;
        b=dzzxdsDFmoMCxUiKlF+hx7G8GPnyY/nPiRqTHB1fbNWKrFOAMZpDZB75JcV5f0Wy9f
         7fZL7zzfljzZEt/4J4UhP2G7VPO4j3Y8PiFhd0XR3B3YtmDLpWwgXeKWV8VlqccFsSaw
         pVb3wvRTyK9ZQc1OSWGFLwHstgPfbYWZf9KADRpug0fh+qkki0OOXmMf3tTB4ZkSJrju
         v7oXizv3pVSquekN+0Iv+tXGx8Jj8jfxjXehMkSorQ+97OjyETO/JwCKrbUAX/LDESnI
         dfYiL6g3q7qSpD5ln9dSa4QihLvFiUTzKst3xPEXzPw0oTGrpc/9oFKibGq0CNk9ycbz
         YcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+VzEqbBKzVBTdM11cwTXo5712b5DHL2DQGTDC8I+mU=;
        b=PiBU17vm4XvqwqLeQtnusAgY4ucqGLm9RFfirXcXlheCp9sOwHfaNcVEHclHUvjyMz
         Mx0LQv9TW5XDZSUOLo6n1nB6VSQXlVTXRbfGJeg8bHoJmPl63rIPgjv0dUyOrtHzaoLd
         AgOvZ3EHc19fySqshbFitlel/UjQTVkvNoyHO1ELAbv5TC5qe7WinMDgDJ9uRwEbsxf9
         yXbXYefX8+2wVh+2qgr9z8SwUzADB+P4MyKlbY1sUs9zedte+/CXK0/bUhKjcAb8Dz/b
         Js1MQbr7htjuvyDgDXCe+2Hjhew7lBmBHbopsf0Tx3ac0sjo4Bn/Yq4v2FzUftA4XETu
         AbYg==
X-Gm-Message-State: APt69E0RgAltrQurcbiXjihKAYyQkEQ1G54jH2STfWGybTD6a8SSRBVJ
        kqqIbYgjCCHlyDLhpDxd04Y=
X-Google-Smtp-Source: ADUXVKLr+rFjqgrWjvMCicsIdcZOCdCmYy1bfSqNO4W5TCkvhZDCAga+U7JUW6xlDpvsV5jlxtHIfA==
X-Received: by 2002:a17:902:1023:: with SMTP id b32-v6mr5430556pla.145.1529129006185;
        Fri, 15 Jun 2018 23:03:26 -0700 (PDT)
Received: from joonhwan-virtualbox.localnet ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id o77-v6sm18235874pfj.0.2018.06.15.23.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 23:03:25 -0700 (PDT)
From:   Joonhwan Kim <spilit464@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        liamryandev@gmail.com, martin@martinhomuth.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        stefano.manni@gmail.com, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] staging: rtl8712: Adjust if statements to reduce indentation level
Date:   Sat, 16 Jun 2018 15:03:22 +0900
Message-ID: <3225099.6uizQ2pf4A@joonhwan-virtualbox>
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
v2: fix my name without period in email header

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




