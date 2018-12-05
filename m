Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C6EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B1F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3LyDBO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B1F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeLERDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45076 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeLERDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id b14so6874801wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cVMlFRiAKUDS8KnnKNF3PgjqdefKhsnxWK+4fcJqSM=;
        b=j3LyDBO5iHYzGg7xKx6AJTZtGI14LGQSEg+F89qfHVY3dEvmoi7Yady37kx6gMZ/FV
         Gq+iELGqoqqhgvFBAOddAS8CJBQ5shPBumqbBwWGbp3ZHozL1vREi+HEERBfiOzEPqvL
         2Lqc8JI+/5SYTFI43d26PZXj1V7seFHE6KWBBREp12ko8gbWla2h3tyeTYskTerNsq4E
         bQw/AxECzmAWA4Eeew9WlbVhptmN25gahiUOfduKPKZdxv4SXXUeAjMkBDpEu34AkF86
         aVQuyq1IGkX5CSyxgqlWJM85pwDWt3nW0mjrvqTRmhng1oY4S5IRZZUrhO3fbqqxKmmZ
         GcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cVMlFRiAKUDS8KnnKNF3PgjqdefKhsnxWK+4fcJqSM=;
        b=jnpvmipwodibk4GWiDheBKzKJFi/pKr9N8NLVgEtMWN/Sfeiv5D58xT0/Agd4coqd2
         gNuHn7siaPOCD/bWRZIRMSY14fCTIx3Aiuxf1s/6yOibNHCIXMY0m5XpcxPpOoE5PxLm
         OAjOluM8DYVXeuxxPol4VA3Vny9EtaUubU0/NGjQuP3cZSjm1bwBvp0BBcqVIPREFYwc
         U4/T5kAxhBlPVB/k/ot0rXK5vhNA38ujNvgP30sCzkQsR1cvo/rCugMxo1FZbfARl1jW
         GYNN5HQSSDbTbgjI6qlcVVvFoYVb1FzKZzJqug1LEEnb/GxXMfsnUFLurzzkyZL4pZJd
         HZTQ==
X-Gm-Message-State: AA+aEWZGgytOlroPxzXnpMiHKTlBKpH5R7a2JYiZHchtB6t44vrhE2NN
        2gfh87VUaM9+70ySSsYKbeGoOeGt
X-Google-Smtp-Source: AFSGD/VG50wZCsBwiYrGMmr78HdpSICH0bK1Sq9Hrng06fbADu4c1SGWimIa0gz1WYaKRxSw5zmKFQ==
X-Received: by 2002:adf:e18d:: with SMTP id k13mr23066061wri.36.1544029386847;
        Wed, 05 Dec 2018 09:03:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:03:06 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/12] staging: rtl8188eu: add spaces around operators in rtw_wlan_util.c
Date:   Wed,  5 Dec 2018 18:02:43 +0100
Message-Id: <20181205170247.5401-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205170247.5401-1-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+', '-', '&' and '>>' to follow kernel coding
style. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 2ffa0332bf32..0eb904317118 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -444,7 +444,8 @@ void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
 			break;
 		default:
 			i = (j - 2) << 2;
-			val = key[i] | (key[i+1] << 8) | (key[i+2] << 16) | (key[i+3] << 24);
+			val = key[i] | (key[i + 1] << 8) | (key[i + 2] << 16) |
+			      (key[i + 3] << 24);
 			break;
 		}
 
@@ -580,7 +581,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 
 		/* entry indx: 0->vo, 1->vi, 2->be, 3->bk. */
 		for (i = 0; i < 4; i++) {
-			for (j = i+1; j < 4; j++) {
+			for (j = i + 1; j < 4; j++) {
 				/* compare CW and AIFS */
 				if ((edca[j] & 0xFFFF) < (edca[i] & 0xFFFF)) {
 					change_inx = true;
@@ -894,7 +895,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 			ht_info_infos_0 = 0;
 	}
 	if (ht_cap_info != cur_network->BcnInfo.ht_cap_info ||
-	    ((ht_info_infos_0&0x03) != (cur_network->BcnInfo.ht_info_infos_0&0x03))) {
+	    ((ht_info_infos_0 & 0x03) != (cur_network->BcnInfo.ht_info_infos_0 & 0x03))) {
 			DBG_88E("%s bcn now: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
 				ht_cap_info, ht_info_infos_0);
 			DBG_88E("%s bcn link: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
@@ -983,18 +984,20 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
-		pbuf = rtw_get_wpa_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length-12);
+		pbuf = rtw_get_wpa_ie(&bssid->ies[12], &wpa_ielen,
+				      bssid->ie_length - 12);
 		if (pbuf && (wpa_ielen > 0)) {
-			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
+			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is_8021x)) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
 					 ("%s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is %d\n", __func__,
 					 pairwise_cipher, group_cipher, is_8021x));
 			}
 		} else {
-			pbuf = rtw_get_wpa2_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length-12);
+			pbuf = rtw_get_wpa2_ie(&bssid->ies[12], &wpa_ielen,
+					       bssid->ie_length - 12);
 
 			if (pbuf && (wpa_ielen > 0)) {
-				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
+				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is_8021x)) {
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
 						 ("%s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_802x is %d\n",
 						  __func__, pairwise_cipher, group_cipher, is_8021x));
@@ -1498,7 +1501,7 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 
 	if (psta) {
 		param = le16_to_cpu(preq->BA_para_set);
-		tid = (param>>2)&0x0f;
+		tid = (param >> 2) & 0x0f;
 		preorder_ctrl = &psta->recvreorder_ctrl[tid];
 		preorder_ctrl->indicate_seq = 0xffff;
 		preorder_ctrl->enable = pmlmeinfo->accept_addba_req;
@@ -1513,7 +1516,7 @@ void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 	pIE = pframe + sizeof(struct ieee80211_hdr_3addr);
 	pbuf = (__le32 *)pIE;
 
-	pmlmeext->TSFValue = le32_to_cpu(*(pbuf+1));
+	pmlmeext->TSFValue = le32_to_cpu(*(pbuf + 1));
 
 	pmlmeext->TSFValue = pmlmeext->TSFValue << 32;
 
-- 
2.19.2

