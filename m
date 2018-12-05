Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE757C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC960214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNw+TMLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC960214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeLESbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35401 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbeLESbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so20772121wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cVMlFRiAKUDS8KnnKNF3PgjqdefKhsnxWK+4fcJqSM=;
        b=CNw+TMLAcjhw6w2D4uuHVVk1/EVmf9bSa3n3qQF3nFqVmsaNWTbMAJ6HRG1xu9fpHw
         XBU0a5UnqztldT2Ik4giqPNjr17dubYEDg8457P4bpHPhI6GLt7qpVX6WlvJ8dU7fhwi
         JghTjN82u2l2tiNvoIqm3yqTMRVPJt2LIBzejyl64idwz8vhKonprnikHu5MX+8L8N1j
         S2O8w4p0xAGmYgIdUwC0r2l4Gl2aPKoZ8IGcXQ4kCL3h4iIqHucQfWXcEM4dQnINL9XC
         XTFGGLTVT4Dwc1It2utl9nwT8eDzCq5Bn1HpeqFeZJh9pSWDbicgFC2lcZE9RD1XC9Mj
         84pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cVMlFRiAKUDS8KnnKNF3PgjqdefKhsnxWK+4fcJqSM=;
        b=stQANQSD4328xST8/mAcac8wf2HVqAiYTx8AOQ4YLv8O/LesvQyZMB9wPUQHYK2dTq
         mH+7iBkh2VYES2OBv4TOb9ZYhWkzHxSe9RPU6UGh+bat4Cus8FfHDfuNfgnI/r+5qSfF
         cHPEDRm7RvctqXm500LRTyiTZRrkucUup4FxzIv9GFpkNkkyGI9SNkszpoXhjzPDaE8r
         gsEU0y3DD7lIo0BiS2pI7fUBxO1WX4wyCUoMoob7sxwyrbIhSCjRyKFn3uwgn2KxhRo7
         NVp9IerQuOiNfWjuMv0CMU0WpolSysNOOaasAgXRCwqtt6IKRKDUYBJjdd9sYIXyr7VY
         I+NQ==
X-Gm-Message-State: AA+aEWazonT5d1i32Wl9S0obd+bioXJT2Ei5DI/fgsUHykGHNbisjkEU
        uZDH6CHgJWHzpXKe9zuqwyI=
X-Google-Smtp-Source: AFSGD/WUWNuuQ2Oi2byBKy2LbaJpZonuA9IkwtVD/oS/eZxgCG714OZEpKgtIym1LXIKkEZObd9SqA==
X-Received: by 2002:adf:f350:: with SMTP id e16mr21658945wrp.125.1544034681220;
        Wed, 05 Dec 2018 10:31:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:20 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 08/12] staging: rtl8188eu: add spaces around operators in rtw_wlan_util.c
Date:   Wed,  5 Dec 2018 19:30:56 +0100
Message-Id: <20181205183100.16828-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205183100.16828-1-straube.linux@gmail.com>
References: <20181205183100.16828-1-straube.linux@gmail.com>
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

