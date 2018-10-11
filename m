Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC0FC6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FC520835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/1iG8L9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FC520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJLD0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:26:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34951 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJLD0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:26:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id y19-v6so9427988edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CvC/iXEYIy51vvsdRxzKcbjlFTACnVfcJeDHUGpUKsY=;
        b=Z/1iG8L92RJ48tPrOR9S0AIi7Sopf4HFoz38IQgeIkc8/3TxDIEAs38C2h7CwswHSk
         eBEec6jbhmXknIPUT3f4jrZlFiLB2PsxmzfVrH68f8OCyFTGpN9ZZjvlFWmHRzYqjMra
         XGzfC9ri3MZvOKTEUoCh7O5zHP7q7vIak+R+iC6Hal7pgvqnHSPyHBBdDh3J/+DPN3nd
         Z6vFu+LzqqvgGtwrNd/k3k6VtCusdP8ns8MrzxMEQ7klvDN7vqQu/YZEP5faNvIVo/8E
         Jo1lZU38vClH9iBMycSiXFEBKhiffoQEOW0H+lgj9iFnmqNEWqE69n0EGLDoi3MpuMWN
         TATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CvC/iXEYIy51vvsdRxzKcbjlFTACnVfcJeDHUGpUKsY=;
        b=U1B9ZTsdFi9XjGnuvytdxaGCoG9ingDxiMKike9vn8t1k7yjkxPj4KcfvZxBwxGcjk
         2H2PfcmwEDsQKQdBilLn6onjpWAncCETemtOpmrWt8dIzcH+2imAqZiMtWdOZu0jb16Y
         zn3j6jj1SZrjZCN4R0ZnZs9RyX2c4xEqMU82kUiZNQXRlYU35Jr59wcKaTd6ATJcv3xr
         R+9qaR6ATSloocsPKLyAdpg5i7fiQnuU1ldFW+s/qQu9YV/7swO2TUL1MUQqEGukVNXP
         gXpjhlFqnF4jyKNipDB93AKRBMLk2CfcNNaPfVI5S2NENPmVBMi1cr+d0IekWDJSww2O
         997w==
X-Gm-Message-State: ABuFfoictFuv+RlsjGlw7fgsKCOtI9yyANpHEQTEQ8o7cyKGJz68R26s
        AjOw3GaEfkdb4uf6vviMWAw=
X-Google-Smtp-Source: ACcGV61bu+ARBpMj/WR9F7PllHfKaINWVtebz2jQpvTLHsKX+aQjMorUVpHy22yb/4HpM3XgfnrrYQ==
X-Received: by 2002:a50:852b:: with SMTP id 40-v6mr4757360edr.177.1539287846686;
        Thu, 11 Oct 2018 12:57:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id k22-v6sm919408eja.23.2018.10.11.12.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:57:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: rtl8188eu: cleanup missing spaces around operators
Date:   Thu, 11 Oct 2018 21:57:05 +0200
Message-Id: <20181011195712.1472-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011195712.1472-1-straube.linux@gmail.com>
References: <20181011195712.1472-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear all missing spaces around operators checkpatch issues
in the file core/rtw_xmit.c. Use '+=' or '-=' where possible.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 60 ++++++++++++++---------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index fc06a13a6ea1..8336a7252440 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -494,7 +494,8 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	pattrib->subtype = WIFI_DATA_TYPE;
 	pattrib->priority = 0;
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE|WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE)) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE |
+			  WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE)) {
 		if (psta->qos_option)
 			set_qos(pkt, pattrib);
 	} else {
@@ -628,15 +629,15 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 				rtw_secmicsetkey(&micdata, &stainfo->dot11tkiptxmickey.skey[0]);
 			}
 
-			if (pframe[1]&1) {   /* ToDS == 1 */
+			if (pframe[1] & 1) {   /* ToDS == 1 */
 				rtw_secmicappend(&micdata, &pframe[16], 6);  /* DA */
-				if (pframe[1]&2)  /* From Ds == 1 */
+				if (pframe[1] & 2)  /* From Ds == 1 */
 					rtw_secmicappend(&micdata, &pframe[24], 6);
 				else
 				rtw_secmicappend(&micdata, &pframe[10], 6);
 			} else {	/* ToDS == 0 */
 				rtw_secmicappend(&micdata, &pframe[4], 6);   /* DA */
-				if (pframe[1]&2)  /* From Ds == 1 */
+				if (pframe[1] & 2)  /* From Ds == 1 */
 					rtw_secmicappend(&micdata, &pframe[16], 6);
 				else
 					rtw_secmicappend(&micdata, &pframe[10], 6);
@@ -653,23 +654,31 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 				payload = (u8 *)round_up((size_t)(payload), 4);
 				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
 					 ("=== curfragnum=%d, pframe = 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x,!!!\n",
-					 curfragnum, *payload, *(payload+1),
-					 *(payload+2), *(payload+3),
-					 *(payload+4), *(payload+5),
-					 *(payload+6), *(payload+7)));
+					 curfragnum, *payload, *(payload + 1),
+					 *(payload + 2), *(payload + 3),
+					 *(payload + 4), *(payload + 5),
+					 *(payload + 6), *(payload + 7)));
 
-				payload = payload+pattrib->hdrlen+pattrib->iv_len;
+				payload += pattrib->hdrlen + pattrib->iv_len;
 				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
 					 ("curfragnum=%d pattrib->hdrlen=%d pattrib->iv_len=%d",
 					 curfragnum, pattrib->hdrlen, pattrib->iv_len));
-				if ((curfragnum+1) == pattrib->nr_frags) {
-					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
+				if (curfragnum + 1 == pattrib->nr_frags) {
+					length = pattrib->last_txcmdsz -
+						 pattrib->hdrlen -
+						 pattrib->iv_len -
+						 ((pattrib->bswenc) ?
+						  pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
-					payload = payload+length;
+					payload += length;
 				} else {
-					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
+					length = pxmitpriv->frag_len -
+						 pattrib->hdrlen -
+						 pattrib->iv_len -
+						 ((pattrib->bswenc) ?
+						  pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
-					payload = payload+length+pattrib->icv_len;
+					payload += length + pattrib->icv_len;
 					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("curfragnum=%d length=%d pattrib->icv_len=%d", curfragnum, length, pattrib->icv_len));
 				}
 			}
@@ -685,8 +694,8 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 			pattrib->last_txcmdsz += 8;
 
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("\n ======== last pkt ========\n"));
-			payload = payload-pattrib->last_txcmdsz+8;
-			for (curfragnum = 0; curfragnum < pattrib->last_txcmdsz; curfragnum = curfragnum+8)
+			payload -= pattrib->last_txcmdsz + 8;
+			for (curfragnum = 0; curfragnum < pattrib->last_txcmdsz; curfragnum += 8)
 				RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
 					 (" %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x ",
 					 *(payload + curfragnum), *(payload + curfragnum + 1),
@@ -833,11 +842,11 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 				if (SN_LESS(pattrib->seqnum, tx_seq)) {
 					pattrib->ampdu_en = false;/* AGG BK */
 				} else if (SN_EQUAL(pattrib->seqnum, tx_seq)) {
-					psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (tx_seq+1)&0xfff;
+					psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (tx_seq + 1) & 0xfff;
 
 					pattrib->ampdu_en = true;/* AGG EN */
 				} else {
-					psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (pattrib->seqnum+1)&0xfff;
+					psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (pattrib->seqnum + 1) & 0xfff;
 					pattrib->ampdu_en = true;/* AGG EN */
 				}
 			}
@@ -978,7 +987,10 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_,
 				 ("%s: keyid=%d pattrib->iv[3]=%.2x pframe=%.2x %.2x %.2x %.2x\n",
-				  __func__, padapter->securitypriv.dot11PrivacyKeyIndex, pattrib->iv[3], *pframe, *(pframe+1), *(pframe+2), *(pframe+3)));
+				  __func__,
+				  padapter->securitypriv.dot11PrivacyKeyIndex,
+				  pattrib->iv[3], *pframe, *(pframe + 1),
+				  *(pframe + 2), *(pframe + 3)));
 
 			pframe += pattrib->iv_len;
 
@@ -1118,7 +1130,7 @@ void rtw_count_tx_stats(struct adapter *padapter, struct xmit_frame *pxmitframe,
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
-	if ((pxmitframe->frame_tag&0x0f) == DATA_FRAMETAG) {
+	if ((pxmitframe->frame_tag & 0x0f) == DATA_FRAMETAG) {
 		pxmitpriv->tx_bytes += sz;
 		pmlmepriv->LinkDetectInfo.NumTxOkInPeriod += pxmitframe->agg_num;
 
@@ -1673,10 +1685,10 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 
 	spin_lock_bh(&psta->sleep_q.lock);
 
-	if (psta->state&WIFI_SLEEP_STATE) {
+	if (psta->state & WIFI_SLEEP_STATE) {
 		u8 wmmps_ac = 0;
 
-		if (pstapriv->sta_dz_bitmap&BIT(psta->aid)) {
+		if (pstapriv->sta_dz_bitmap & BIT(psta->aid)) {
 			list_del_init(&pxmitframe->list);
 
 			list_add_tail(&pxmitframe->list, get_list_head(&psta->sleep_q));
@@ -1860,7 +1872,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 		update_mask = BIT(0);
 
-		if (psta->state&WIFI_SLEEP_STATE)
+		if (psta->state & WIFI_SLEEP_STATE)
 			psta->state ^= WIFI_SLEEP_STATE;
 
 		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
@@ -1878,7 +1890,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 	if (!psta_bmc)
 		return;
 
-	if ((pstapriv->sta_dz_bitmap&0xfffe) == 0x0) { /* no any sta in ps mode */
+	if ((pstapriv->sta_dz_bitmap & 0xfffe) == 0x0) { /* no any sta in ps mode */
 		spin_lock_bh(&psta_bmc->sleep_q.lock);
 
 		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
-- 
2.19.1

