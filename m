Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30259C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE51C223BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avb7L3hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE51C223BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeHJJrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:47:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34232 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeHJJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:47:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so675624wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5KJGaoeNBEOcIqLMeozaJQpebrpTm2VWi35KyHXkGYQ=;
        b=Avb7L3hzjXcxu+V9/KZyQUg5VVWsn+owgvTfZiSPc6MVh6mUx4I7NpRrlYzl0b1Bh/
         RARE0Whcq9NI0XoQJsZ8DngbndepTS4euTP2QcnPEM4opdITpZVe/kODCdAYZMDij4tJ
         HBm9OFsdHLsGri6tPcBuT8MQX6ULeGCID4OTR8zywRTptjwfd5P53uJKqXDZN+GJCIaN
         EnKkGD028vCFjnbBQRu3Eh26W1L52iESz2tUju6sAoEcV06hNHBI19e2LAhvQUziscXv
         61+wwgQ8TjDdZ3svIQc6yXCJS6q3ctWCnaQpFl46oQZhWaVPSTEusDTyoXuS4UCxT4O+
         /2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5KJGaoeNBEOcIqLMeozaJQpebrpTm2VWi35KyHXkGYQ=;
        b=i9560LejVo21kQG0p+MzAynjryoZ237IEBGTd3/xEJqG2wqToQ1yQkPM8EDqGVPBJc
         UQnApp/e2OFHDoNx+l7egq1i3GKg5HgtKZ6I7d8jEALZZK/4F9XHm0F9UM2fcLLhaCmU
         DsRxle+CkQ5AuTlOM9JnHAosK2klU78WSq5bi9ddBhpM+VA3Br5iYGa2mxWM6/Etqr3K
         yI2GJZWsfa39KeZ4AiyZTU4R8JHE9eWNunZBazRWHWoDuTg7b1U8iyQqQkBBhZGVwl2I
         zdy25Af5n9+MLxk/XgAscm4KARIxLQLgwpfFITVoGKo/KiZ4obWVpxB2xUSYq1xBuoJ8
         GnUQ==
X-Gm-Message-State: AOUpUlHxDSn86Fohe8OIWKUZV5dIZXsxZBkGM20OVXSABx1cNk5y415j
        EceDbuU2GxKEKNAm35ovrWo=
X-Google-Smtp-Source: AA+uWPxXpiafqdM4p4mmJrwYbLQVeMWegeWectWuAYPn+GYVn+IA8vgTcc7DUzg58EkM5kiTPVdDuA==
X-Received: by 2002:a1c:6546:: with SMTP id z67-v6mr626272wmb.130.1533885527809;
        Fri, 10 Aug 2018 00:18:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id k4-v6sm13253875wrl.12.2018.08.10.00.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 00:18:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/5] staging: rtl8188eu: use is_multicast_ether_addr in rtw_xmit.c
Date:   Fri, 10 Aug 2018 09:18:31 +0200
Message-Id: <20180810071833.1661-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810071833.1661-1-straube.linux@gmail.com>
References: <20180810071833.1661-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
core/rtw_xmit.c. In all uses the address array is properly
aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
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

