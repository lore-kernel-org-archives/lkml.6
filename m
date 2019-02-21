Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842582147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkL1Gngx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfBULvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:51:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40687 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfBULvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:51:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15so9490404wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnIc6ISlIUaNylQCXDtdHYxRztVWeWQxgaSeB2AmfdE=;
        b=mkL1GngxlJoNyeQDN+Y2JjJn0/ktCqKXY4UCxWOY6SiZhC1baQlgBirh/0oUw1Yyph
         r7m2Uj/kkMqzSfb9ICzoRaxEyfeXFfF3e5bGijYn8tG8iiRF1VOKsOyIn+31gCp/z8kh
         8SVB0Di05tkXDd1af/I4py/7BMcdY3m4Jw81GS7HcDCy2qtNtsJm2AQx2iPTj+p8jrpa
         A+RKluwPV6JLI0wvrFa7ZQ0jooA+YOKyNuVqYyyRrHqjvWbuT/5WvE9ISyQiXsIROPqX
         qtwu+ziCU2XGbtHRNWv26qnl2BK8Qrr91ryD1WD/W5m5TvYoPOxH260GxazKjJKCBYbt
         NVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnIc6ISlIUaNylQCXDtdHYxRztVWeWQxgaSeB2AmfdE=;
        b=j23m0NpDbVmuVOdAytFhO4hcHaBQ8vwODhHAVdRIsvlKbyCUPxgTPsjYAn2bgXtB1T
         0ibiTvj9JoEKi/J7/NOEh30eKnpKqDsSbvoOZm5M/V3OdmwB/PsZBxs3dIkH5vFG/rgm
         YxYGFk2Mnn/IZoBqCKMm7St2re1X5bnx/CZBTy/+7eUKUKYwLZm2V4K+vq+NZYYRucbn
         iC311IC+/JW4jMqZdRovw+m7I+qEmHpDl/wlQ0ho2F3L07gvM1e2Tez7/nvcCt0BmeFq
         1GiwvkDAE+8sfv2HLpGrtA4kZEHqkB3jBwwaK2memhszSMGDlefTvIdZXlbhmSS8zIgX
         XRSQ==
X-Gm-Message-State: AHQUAuZN/1YHAD/lfZllBZU8wOI3jZq5tD3vOY6L8yf3ZuSk4aaIGn9j
        4hbT60R6r/nJhYP7Nan39LY=
X-Google-Smtp-Source: AHgI3IYQ1DVwzN8zYEbpZN2pGU47N2H0C8QsnL3FC6x0v0JKVcIMHwUJLjsXGJD+IPiexhGcl4Tl1g==
X-Received: by 2002:a1c:6854:: with SMTP id d81mr9537487wmc.91.1550749896066;
        Thu, 21 Feb 2019 03:51:36 -0800 (PST)
Received: from localhost.localdomain (ip5f5abba0.dynamic.kabel-deutschland.de. [95.90.187.160])
        by smtp.gmail.com with ESMTPSA id j5sm15092849wrw.59.2019.02.21.03.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:51:35 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: rtl8188eu: remove unnecessary parentheses in rtl8188e_cmd.c
Date:   Thu, 21 Feb 2019 12:50:52 +0100
Message-Id: <20190221115057.31207-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 42 ++++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index 491d948e9f2a..7c61f01665c7 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -211,9 +211,9 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	u32 rate_len, pktlen;
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
@@ -222,7 +222,7 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	*(fctrl) = 0;
 
 	ether_addr_copy(pwlanhdr->addr1, bc_addr);
-	ether_addr_copy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)));
+	ether_addr_copy(pwlanhdr->addr2, myid(&adapt->eeprompriv));
 	ether_addr_copy(pwlanhdr->addr3, cur_network->MacAddress);
 
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
@@ -294,10 +294,10 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 {
 	struct ieee80211_hdr *pwlanhdr;
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	__le16 *fctrl;
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
@@ -314,7 +314,7 @@ static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	ether_addr_copy(pwlanhdr->addr1, pnetwork->MacAddress);
 
 	/*  TA. */
-	ether_addr_copy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)));
+	ether_addr_copy(pwlanhdr->addr2, myid(&adapt->eeprompriv));
 
 	*pLength = 16;
 }
@@ -332,9 +332,9 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	u32 pktlen;
 	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
 	struct wlan_network		*cur_network = &pmlmepriv->cur_network;
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
@@ -347,19 +347,19 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	case Ndis802_11Infrastructure:
 		SetToDs(fctrl);
 		ether_addr_copy(pwlanhdr->addr1, pnetwork->MacAddress);
-		ether_addr_copy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)));
+		ether_addr_copy(pwlanhdr->addr2, myid(&adapt->eeprompriv));
 		ether_addr_copy(pwlanhdr->addr3, StaAddr);
 		break;
 	case Ndis802_11APMode:
 		SetFrDs(fctrl);
 		ether_addr_copy(pwlanhdr->addr1, StaAddr);
 		ether_addr_copy(pwlanhdr->addr2, pnetwork->MacAddress);
-		ether_addr_copy(pwlanhdr->addr3, myid(&(adapt->eeprompriv)));
+		ether_addr_copy(pwlanhdr->addr3, myid(&adapt->eeprompriv));
 		break;
 	case Ndis802_11IBSS:
 	default:
 		ether_addr_copy(pwlanhdr->addr1, StaAddr);
-		ether_addr_copy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)));
+		ether_addr_copy(pwlanhdr->addr2, myid(&adapt->eeprompriv));
 		ether_addr_copy(pwlanhdr->addr3, pnetwork->MacAddress);
 		break;
 	}
@@ -391,13 +391,13 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 	__le16 *fctrl;
 	u8 *mac, *bssid;
 	u32 pktlen;
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex	*cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
 
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	mac = myid(&(adapt->eeprompriv));
+	mac = myid(&adapt->eeprompriv);
 	bssid = cur_network->MacAddress;
 
 	fctrl = &pwlanhdr->frame_control;
@@ -458,7 +458,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	pxmitpriv = &adapt->xmitpriv;
 	pmlmeext = &adapt->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
-	pnetwork = &(pmlmeinfo->network);
+	pnetwork = &pmlmeinfo->network;
 
 	TxDescLen = TXDESC_SIZE;
 	PageNum = 0;
@@ -542,8 +542,8 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 {
 	struct hal_data_8188e *haldata = adapt->HalData;
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	bool	bSendBeacon = false;
 	bool	bcn_valid = false;
 	u8 DLBcnCount = 0;
-- 
2.20.1

