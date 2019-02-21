Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E20DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53EE20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDEbwZCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfBULwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:52:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51482 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBULvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:51:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so9860003wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUr4P1TcIthQDt7GZFU6f7i0+6JNrdxeeD68DHf8Dt8=;
        b=BDEbwZCd/W2SXf1CiuwOn0Qk/sP9wowU6I+cfj4i5g+W9STP7lOjBtE8lJXrtW49Zq
         8Ntl4M+ETU1+Cs51rLDV/4ETGwkHC2UluziiBhvI5fZLXQmKUNF5qceorUlG5nQWYizo
         p+pWqTmhy3jk83k1RaHMV4y0X+WBcUnRgg+iE/yE48S+PV7Yuz2zs211qrHRxBM8ni62
         vyx02D77fecx3AsT2L1FEOceRrCgQudwRdCteIO1vLm/0wD5zOA0/FyXRM9HwOgnB7GY
         y8ASsOvzQPF1S01U/Vxc5XQqi7FAdlX98NTR4ykYYIdp7DhEw3w/kx2m6ROyNbJ9VNap
         7OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUr4P1TcIthQDt7GZFU6f7i0+6JNrdxeeD68DHf8Dt8=;
        b=X0RMqFkz4dG9DxpLUDaFi7iCFSLFoJ1i1mwOqVNQN7FZEw0LbXa0CXh0rU+FUisR2z
         ewAT/U6ycfCmBri9TojITuuXQXf4bUEAZhMeS1AVw5f2zhne4jzEgu/ZSVeywrAjb7Gc
         nncyvIhAZlArPUSmJQGQ9/2+kA+Pyfn2+URPqQ1RtIXRaM29x0VJH1o624QHsI8Mqdqb
         Qm+WzEYW1xKFVYm9BSR+/7yBlUUO9H9mjzv5mITC+fmsyC120vnwRppf3/sD7koTmeXE
         KmS2ZCwpFjuMpFfI4K+M56iukYXp9+l4fsGOiaKtLlXVaQCE+qP7bMsEM5yLPOvKAxGn
         G/Rg==
X-Gm-Message-State: AHQUAubsKbuMRig/UAgPCiAu4fLpzoyJKygqLgaWdM/WdMIqYxJsqmqo
        Imrce8VwS2YIup7Upo5qccP9Ysps/Hs=
X-Google-Smtp-Source: AHgI3IbrAbp+XgONW6XF7uODa0xlPRZsvAKQCz1FbVOiHdSMTYcPGg70pYTcIkgsfPmuvixkHOqWpQ==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr9834465wme.119.1550749897117;
        Thu, 21 Feb 2019 03:51:37 -0800 (PST)
Received: from localhost.localdomain (ip5f5abba0.dynamic.kabel-deutschland.de. [95.90.187.160])
        by smtp.gmail.com with ESMTPSA id j5sm15092849wrw.59.2019.02.21.03.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:51:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: rtl8188eu: cleanup declarations in rtl8188e_cmd.c
Date:   Thu, 21 Feb 2019 12:50:53 +0100
Message-Id: <20190221115057.31207-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221115057.31207-1-straube.linux@gmail.com>
References: <20190221115057.31207-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in declarations to cleanup whitespace.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 28 ++++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index 7c61f01665c7..8d96227b85f6 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -22,7 +22,7 @@
 static u8 _is_fw_read_cmd_down(struct adapter *adapt, u8 msgbox_num)
 {
 	u8 read_down = false;
-	int	retry_cnts = 100;
+	int retry_cnts = 100;
 
 	u8 valid;
 
@@ -212,8 +212,8 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	__le16 *fctrl;
 	u32 rate_len, pktlen;
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
@@ -295,7 +295,7 @@ static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 {
 	struct ieee80211_hdr *pwlanhdr;
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	__le16 *fctrl;
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
@@ -331,9 +331,9 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	__le16 *fctrl;
 	u32 pktlen;
 	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
-	struct wlan_network		*cur_network = &pmlmepriv->cur_network;
+	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
@@ -392,8 +392,8 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 	u8 *mac, *bssid;
 	u32 pktlen;
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
@@ -434,11 +434,11 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 /*  2009.10.15 by tynli. */
 static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 {
-	struct xmit_frame	*pmgntframe;
-	struct pkt_attrib	*pattrib;
+	struct xmit_frame *pmgntframe;
+	struct pkt_attrib *pattrib;
 	struct xmit_priv *pxmitpriv;
 	struct mlme_ext_priv *pmlmeext;
-	struct mlme_ext_info	*pmlmeinfo;
+	struct mlme_ext_info *pmlmeinfo;
 	u32 BeaconLength = 0, ProbeRspLength = 0, PSPollLength;
 	u32 NullDataLength, QosNullLength;
 	u8 *ReservedPagePacket;
@@ -543,9 +543,9 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 {
 	struct hal_data_8188e *haldata = adapt->HalData;
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	bool	bSendBeacon = false;
-	bool	bcn_valid = false;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	bool bSendBeacon = false;
+	bool bcn_valid = false;
 	u8 DLBcnCount = 0;
 	u32 poll = 0;
 
-- 
2.20.1

