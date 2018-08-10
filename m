Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB9C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5168222405
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCgIK7pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5168222405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeHJNVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:21:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50499 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeHJNVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:21:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so1429395wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bTRG8xsdnrCdBF8m3hfkHV7gnfH9Vvgxhjc/rmCxFgg=;
        b=PCgIK7paw2SSCMnNZNeGbGz14Cd99CLM5GfJBAFDpbPMIic6JFMZahLSbiw5Fec8CB
         ewnXNNBdsruIJDj3DPnMB3mGPWIwPIofaQu1LPF1THMwibhUr0nwDrDtETPI1l5PdfBX
         voTZRN9YgS/8B8cdkRstF30EegWLlZutWTO4wcOl7O/jQvrzvxyRKuezVFfpl9GclYYj
         qtqvmisie1OxJmQ7WeYesLD36aJHX/xwtEjJfxzjsDC3ReKid7iB73bnFcfz8zHLuwsT
         ZHlK2fVKpka+0yXb/J0/8x8AJIe9hHHrMo99XJONJ0hJEmPJ3nrjlCS+CobjzkdPOr2M
         osXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bTRG8xsdnrCdBF8m3hfkHV7gnfH9Vvgxhjc/rmCxFgg=;
        b=dPV4eZTSOpn2Y5lnZIndO71aV9SgikgS/PD2oAtsQPLd7NmKKYnnd8DgwTF7/Ndr1N
         hoQL6PTmhLB1JH3rA7XsXBmw2LCDfQcF8CDotMVcNmwI3p+BNWZvv3RwT4g5MYllDpNz
         S2HB1bJlSwSzrHd/hB0+SAthjx9jz1dFBplHZeJPtAOMk4/F0ExibMu1l0GLZkZz9rqB
         bO2ozPnPMz7CLrmqB6U+n+tkRedhh0yZeG8aOJW71zeZLL9WvatdJu1t8HlsbWZgWVJw
         veapqhqpPoS2QOrKgQo0zAg+euAdOA6bRikIfJOChz9nVAeZ5R+FoZZCDRSYEkJg1W00
         3qPA==
X-Gm-Message-State: AOUpUlFLNQqQAP8h15RXfSffLS+vzsIPx1peJkE6d1vUdQObT1QwXzd2
        vQ1X/dQcLBlDISfqh642Lcw=
X-Google-Smtp-Source: AA+uWPwDTNZ9wk9h4xjgwkQVdI9TMhJNfBRYSEs6UZn1nCPefSDpgfumqWmfNrRrA1Mso+gjbZQ4wg==
X-Received: by 2002:a1c:1a02:: with SMTP id a2-v6mr1266502wma.52.1533898309861;
        Fri, 10 Aug 2018 03:51:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id p14-v6sm14273994wru.0.2018.08.10.03.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 03:51:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 3/5] staging: rtl8188eu: use is_multicast_ether_addr in rtw_xmit.c
Date:   Fri, 10 Aug 2018 12:51:31 +0200
Message-Id: <20180810105133.31224-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810105133.31224-1-straube.linux@gmail.com>
References: <20180810105133.31224-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
core/rtw_xmit.c. In all uses the address array is properly
aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 35 +++++++++++------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 2130d78e0d9f..fc06a13a6ea1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -399,7 +399,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	struct sta_info *psta = NULL;
 	struct ethhdr etherhdr;
 
-	int bmcast;
+	bool mcast;
 	struct sta_priv		*pstapriv = &padapter->stapriv;
 	struct security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
@@ -460,10 +460,10 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	if ((pattrib->ether_type == ETH_P_ARP) || (pattrib->ether_type == ETH_P_PAE) || (pattrib->dhcp_pkt == 1))
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SPECIAL_PACKET, 1);
 
-	bmcast = IS_MCAST(pattrib->ra);
+	mcast = is_multicast_ether_addr(pattrib->ra);
 
 	/*  get sta_info */
-	if (bmcast) {
+	if (mcast) {
 		psta = rtw_get_bcmc_stainfo(padapter);
 	} else {
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
@@ -517,7 +517,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 			goto exit;
 		}
 	} else {
-		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, bmcast);
+		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, mcast);
 
 		switch (psecuritypriv->dot11AuthAlgrthm) {
 		case dot11AuthAlgrthm_Open:
@@ -526,7 +526,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 			pattrib->key_idx = (u8)psecuritypriv->dot11PrivacyKeyIndex;
 			break;
 		case dot11AuthAlgrthm_8021X:
-			if (bmcast)
+			if (mcast)
 				pattrib->key_idx = (u8)psecuritypriv->dot118021XGrpKeyid;
 			else
 				pattrib->key_idx = 0;
@@ -596,7 +596,6 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
 	u8 hw_hdr_offset = 0;
-	int bmcst = IS_MCAST(pattrib->ra);
 
 	if (pattrib->psta)
 		stainfo = pattrib->psta;
@@ -614,7 +613,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 			pframe = pxmitframe->buf_addr + hw_hdr_offset;
 
-			if (bmcst) {
+			if (is_multicast_ether_addr(pattrib->ra)) {
 				if (!memcmp(psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey, null_key, 16))
 					return _FAIL;
 				/* start to calculate the mic code */
@@ -743,12 +742,10 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 	struct sta_info *psta;
 
-	int bmcst = IS_MCAST(pattrib->ra);
-
 	if (pattrib->psta) {
 		psta = pattrib->psta;
 	} else {
-		if (bmcst)
+		if (is_multicast_ether_addr(pattrib->ra))
 			psta = rtw_get_bcmc_stainfo(padapter);
 		else
 			psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
@@ -914,7 +911,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
 	u8 *pbuf_start;
-	s32 bmcst = IS_MCAST(pattrib->ra);
+	bool mcast = is_multicast_ether_addr(pattrib->ra);
 	s32 res = _SUCCESS;
 	size_t remainder = pkt->len - ETH_HLEN;
 
@@ -964,13 +961,13 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 				WEP_IV(pattrib->iv, psta->dot11txpn, pattrib->key_idx);
 				break;
 			case _TKIP_:
-				if (bmcst)
+				if (mcast)
 					TKIP_IV(pattrib->iv, psta->dot11txpn, pattrib->key_idx);
 				else
 					TKIP_IV(pattrib->iv, psta->dot11txpn, 0);
 				break;
 			case _AES_:
-				if (bmcst)
+				if (mcast)
 					AES_IV(pattrib->iv, psta->dot11txpn, pattrib->key_idx);
 				else
 					AES_IV(pattrib->iv, psta->dot11txpn, 0);
@@ -997,7 +994,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		if ((pattrib->icv_len > 0) && (pattrib->bswenc))
 			mpdu_len -= pattrib->icv_len;
 
-		mem_sz = min_t(size_t, bmcst ? pattrib->pktlen : mpdu_len, remainder);
+		mem_sz = min_t(size_t, mcast ? pattrib->pktlen : mpdu_len, remainder);
 		skb_copy_bits(pkt, pkt->len - remainder, pframe, mem_sz);
 		remainder -= mem_sz;
 
@@ -1010,7 +1007,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 		frg_inx++;
 
-		if (bmcst || remainder == 0) {
+		if (mcast || remainder == 0) {
 			pattrib->nr_frags = frg_inx;
 
 			pattrib->last_txcmdsz = pattrib->hdrlen + pattrib->iv_len + ((pattrib->nr_frags == 1) ? llc_sz : 0) +
@@ -1041,7 +1038,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 	xmitframe_swencrypt(padapter, pxmitframe);
 
-	if (!bmcst)
+	if (!mcast)
 		update_attrib_vcs_info(padapter, pxmitframe);
 	else
 		pattrib->vcs_mode = NONE_VCS;
@@ -1632,7 +1629,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	int bmcst = IS_MCAST(pattrib->ra);
+	bool mcast = is_multicast_ether_addr(pattrib->ra);
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == false)
 		return ret;
@@ -1646,12 +1643,12 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 		return ret;
 
 	if (pattrib->triggered == 1) {
-		if (bmcst)
+		if (mcast)
 			pattrib->qsel = 0x11;/* HIQ */
 		return ret;
 	}
 
-	if (bmcst) {
+	if (mcast) {
 		spin_lock_bh(&psta->sleep_q.lock);
 
 		if (pstapriv->sta_dz_bitmap) {/* if any one sta is in ps mode */
-- 
2.18.0

