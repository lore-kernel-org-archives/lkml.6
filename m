Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CE3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D624B20835
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vP8L0MXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D624B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbeGKL20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:28:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43982 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732544AbeGKL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:28:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id u11-v6so18945644eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4y9Ing/HRDH7nc/zOQigrWraootYU0riKWcLb13vAR0=;
        b=vP8L0MXrj2ffrBLvdPj8zzjPwIWGbk61BSHWRWkhqcedhY/sFZcBmJEwVY76wptroM
         Bxe7QM4C0K8QDM2nKDL6ImuoVYDHRZCB+VEZslJO/YF4kpTEwjZEI21bPFHHvX8yjuoh
         Rnkk1VzI0BZ2Lj3EcKAxbtzc4lzSWuE9ZMqbgWx3Ntww0NOGFWdB9Pl3kyKqicJFzUbP
         2fdotgTQR4O7Sp/34DgfwGQNlYxlGdhTsGEATa6BMP88jqmEpUDQobYEujZstvxjEFDD
         L9a8x20vQN3IpSCxmvQuAZV7L1H826PXZjiw3BNMKin3NScKBuXwznuhJYFEOH0Ppbv5
         Otrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4y9Ing/HRDH7nc/zOQigrWraootYU0riKWcLb13vAR0=;
        b=lR6fiYBd6iyw+C3G+Fs7ajHQxEqoNznLVhniFKHLIKhGcvLDMbvGImaUvnznVGHTVk
         J4P2X8jMn20dzlRmimZCPseCq0ZMO8VW1zsLOBp6Ix6701Xsy0V9gUDmUMguBM0MC1Un
         wpZjMEv5BCELMfwMeAfi03NYaPzRTu7VCSrRylt08tUCeY/gpvBODuDpAuLomhAjOQYT
         oulN2IIuN1AaDMCVpAt4ls2m6ngqqhtLvcyvfq2Kkb64dU6hxtOzXRO3QAffWdbrzIwV
         c4m7UtTpWU1RisHyCnE/lNUgrxABwNepGyaHGrhYY2GNDu2+mBSkhoSYea4beXFiB15y
         ugVg==
X-Gm-Message-State: APt69E09zNK12EzQrqc7XdFnKeKx5zKakNuhB5oPPnBVimSXNaPhRuSM
        964e/tLWGHUiDnlJFdR/LAY=
X-Google-Smtp-Source: AAOMgpegBQEDDkBOwQ2m8VGHclNuV9zdNAlevtkHHiaq13sG7t348yltjsT7lIK0t4dNQrhbNyHUfQ==
X-Received: by 2002:aa7:c4cf:: with SMTP id p15-v6mr2664240edr.240.1531308271261;
        Wed, 11 Jul 2018 04:24:31 -0700 (PDT)
Received: from arch.localdomain (x4db0e292.dyn.telefonica.de. [77.176.226.146])
        by smtp.gmail.com with ESMTPSA id h1-v6sm8186346eds.68.2018.07.11.04.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 04:24:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: rtl8723bs: remove blank lines
Date:   Wed, 11 Jul 2018 13:23:28 +0200
Message-Id: <20180711112330.28020-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711112330.28020-1-straube.linux@gmail.com>
References: <20180711112330.28020-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unrequired blank lines as reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 234e741c87e8..106b4f13efc7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -65,7 +65,6 @@ int cckrates_included(unsigned char *rate, int ratelen)
 	}
 
 	return false;
-
 }
 
 int cckratesonly_included(unsigned char *rate, int ratelen)
@@ -134,10 +133,8 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
 	default:
 		raid = RATEID_IDX_BGN_40M_2SS;
 		break;
-
 	}
 	return raid;
-
 }
 
 unsigned char ratetbl_val_2wifirate(unsigned char rate);
@@ -193,11 +190,9 @@ unsigned char ratetbl_val_2wifirate(unsigned char rate)
 	case 11:
 		val = IEEE80211_OFDM_RATE_54MB;
 		break;
-
 	}
 
 	return val;
-
 }
 
 int is_basicrate(struct adapter *padapter, unsigned char rate);
@@ -292,7 +287,6 @@ void UpdateBrateTbl(struct adapter *Adapter, u8 *mBratesOS)
 			break;
 		}
 	}
-
 }
 
 void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen)
@@ -311,7 +305,6 @@ void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen)
 			break;
 		}
 	}
-
 }
 
 void Save_DM_Func_Flag(struct adapter *padapter)
@@ -499,7 +492,6 @@ u16 get_beacon_interval(struct wlan_bssid_ex *bss)
 	memcpy((unsigned char *)&val, rtw_get_beacon_interval_from_ie(bss->IEs), 2);
 
 	return le16_to_cpu(val);
-
 }
 
 int is_client_associated_to_ap(struct adapter *padapter)
@@ -542,7 +534,6 @@ int is_IBSS_empty(struct adapter *padapter)
 	}
 
 	return true;
-
 }
 
 unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval)
@@ -854,7 +845,6 @@ void flush_all_cam_entry(struct adapter *padapter)
 	rtw_hal_set_hwreg(padapter, HW_VAR_SEC_DK_CFG, (u8 *)false);
 
 	memset((u8 *)(pmlmeinfo->FW_sta_info), 0, sizeof(pmlmeinfo->FW_sta_info));
-
 }
 
 int WMM_param_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
@@ -1068,7 +1058,6 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 		new_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 	}
 
-
 	if ((new_bwmode != pmlmeext->cur_bwmode) || (new_ch_offset != pmlmeext->cur_ch_offset)) {
 		pmlmeinfo->bwmode_updated = true;
 
@@ -1080,7 +1069,6 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 	} else
 		pmlmeinfo->bwmode_updated = false;
 
-
 	if (true == pmlmeinfo->bwmode_updated) {
 		struct sta_info *psta;
 		struct wlan_bssid_ex	*cur_network = &(pmlmeinfo->network);
@@ -1088,7 +1076,6 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 
 		/* set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode); */
 
-
 		/* update ap's stainfo */
 		psta = rtw_get_stainfo(pstapriv, cur_network->MacAddress);
 		if (psta) {
@@ -1208,7 +1195,6 @@ void HT_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	if (phtpriv->ht_option == false)
 		return;
 
-
 	if (pIE->Length > sizeof(struct HT_info_element))
 		return;
 
@@ -1620,7 +1606,6 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 		return false;
 	} else
 		return false;
-
 }
 
 int support_short_GI(struct adapter *padapter, struct HT_caps_element *pHT_caps, u8 bwmode)
@@ -1772,7 +1757,6 @@ void update_IOT_info(struct adapter *padapter)
 		pmlmeinfo->turboMode_rtsen = 1;
 		break;
 	}
-
 }
 
 void update_capinfo(struct adapter *Adapter, u16 updateCap)
@@ -1785,7 +1769,6 @@ void update_capinfo(struct adapter *Adapter, u16 updateCap)
 	/*  Mark to update preamble value forever, 2008.03.18 by lanhsin */
 	/* if (pMgntInfo->RegPreambleMode == PREAMBLE_AUTO) */
 	{
-
 		if (updateCap & cShortPreamble) {
 			/*  Short Preamble */
 			if (pmlmeinfo->preamble_mode != PREAMBLE_SHORT) { /*  PREAMBLE_LONG or PREAMBLE_AUTO */
@@ -1823,7 +1806,6 @@ void update_capinfo(struct adapter *Adapter, u16 updateCap)
 	}
 
 	rtw_hal_set_hwreg(Adapter, HW_VAR_SLOT_TIME, &pmlmeinfo->slotTime);
-
 }
 
 void update_wireless_mode(struct adapter *padapter)
@@ -1908,7 +1890,6 @@ int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_l
 		memcpy((pmlmeinfo->FW_sta_info[cam_idx].SupportedRates + supportRateNum), pIE->data, ie_len);
 
 	return _SUCCESS;
-
 }
 
 void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
@@ -1943,7 +1924,6 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 
 		preorder_ctrl->enable = pmlmeinfo->accept_addba_req;
 	}
-
 }
 
 void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
@@ -1975,7 +1955,6 @@ void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 	u32 delay_ms;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-
 	pmlmeext->bcn_cnt++;
 
 	pIE = pframe + sizeof(struct ieee80211_hdr_3addr);
@@ -2025,7 +2004,6 @@ void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 		for (i = 0; i < 9; i++) {
 			pmlmeext->bcn_delay_ratio[i] = (pmlmeext->bcn_delay_cnt[i] * 100) / pmlmeext->bcn_cnt;
 
-
 			DBG_871X("%s():bcn_delay_cnt[%d]=%d,  bcn_delay_ratio[%d]=%d\n", __func__, i,
 				pmlmeext->bcn_delay_cnt[i], i, pmlmeext->bcn_delay_ratio[i]);
 
@@ -2052,10 +2030,8 @@ void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 
 		pmlmeext->bcn_cnt = 0;
 	}
-
 }
 
-
 void beacon_timing_control(struct adapter *padapter)
 {
 	rtw_hal_bcn_related_reg_setting(padapter);
@@ -2067,7 +2043,6 @@ void rtw_alloc_macid(struct adapter *padapter, struct sta_info *psta)
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct dvobj_priv *pdvobj = adapter_to_dvobj(padapter);
 
-
 	if (!memcmp(psta->hwaddr, bc_addr, ETH_ALEN))
 		return;
 
@@ -2092,7 +2067,6 @@ void rtw_alloc_macid(struct adapter *padapter, struct sta_info *psta)
 		psta->mac_id = i;
 		DBG_871X("%s = %d\n", __func__, psta->mac_id);
 	}
-
 }
 
 void rtw_release_macid(struct adapter *padapter, struct sta_info *psta)
@@ -2100,7 +2074,6 @@ void rtw_release_macid(struct adapter *padapter, struct sta_info *psta)
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct dvobj_priv *pdvobj = adapter_to_dvobj(padapter);
 
-
 	if (!memcmp(psta->hwaddr, bc_addr, ETH_ALEN))
 		return;
 
@@ -2114,10 +2087,8 @@ void rtw_release_macid(struct adapter *padapter, struct sta_info *psta)
 			pdvobj->macid[psta->mac_id] = false;
 			psta->mac_id = NUM_STA;
 		}
-
 	}
 	spin_unlock_bh(&pdvobj->lock);
-
 }
 /* For 8188E RA */
 u8 rtw_search_max_mac_id(struct adapter *padapter)
@@ -2134,7 +2105,6 @@ u8 rtw_search_max_mac_id(struct adapter *padapter)
 	spin_unlock_bh(&pdvobj->lock);
 
 	return max_mac_id;
-
 }
 
 struct adapter *dvobj_get_port0_adapter(struct dvobj_priv *dvobj)
-- 
2.18.0

