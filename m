Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7034C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8727E208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSJui0Ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8727E208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbeGHKja (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:39:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38099 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932380AbeGHKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:39:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id a5-v6so11630214edt.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lf5xPcPPP0VNJuibn9eL6dnxc1WpwObE29ctEdrDcWY=;
        b=hSJui0IreUYQJ57TynswsKRVJN/c6ZcCfLzxfIOZG+wMtvQH9ML916SYevfOrFN38D
         jJGxshnNJ1po0ZOvwUOzv6+NO7wUYGF1joQx/l3w7q031CMmyIR4+2TwEskKle4kDVWW
         w817Fr2g18KL4e+nR7yMDgtp5uWzdS2PQVpJ45yx5LARsM+kh1nUYui3uZyU3iOmEj5c
         sVaPUs0piAIQ4Z3JqTnLalVoTY4l3zNDWgQoGeFCjElTSd2aYpQMh4K66nW0D4uLrPwN
         E2Uz25i5BXOhUYCEtlAU2BAoOfSPEzjbnWcP8aiex75bgaUhGYRcSECplwmvIL4OMfwQ
         sYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lf5xPcPPP0VNJuibn9eL6dnxc1WpwObE29ctEdrDcWY=;
        b=ClRqo8/t8s1bpocQ9RQnjfLU6NIDG+lOkfB8PSCzPUWsVlPY8gw9HJdYwvO9wDsTTT
         hqJTmjhU65LAm3Ye8uHaMxChuEc0yHJOEjnwWjmebLQIhlwXHyd1hJz4uH9qBEZkFLkH
         ubmBYV/ctfqs6lRtLCfc8PvZOagbLMy9aFvd28TPqbsGVhpcCBTnw15e/SgTDj8LAxb4
         lu1bsht4DzrIRxH6CU9xer1R7fa5bAdtWOcpKNC3+9IBliMGeUf0jlb7QswkVl03PyAb
         TfxMSmSW3501zkV0UD+XGBcYYEnHBHRz2sCcdSpXGR2LA73dBNfm4CNkPS4pdPFstIA8
         veTA==
X-Gm-Message-State: APt69E1NVcsScW8fc8upuz8J84OpMIWwC26sEeQ99fFWfUzD4v9nJxDA
        mit2Cy2mIZTQ7RHQrZAjg9GF1wDoEvw=
X-Google-Smtp-Source: AAOMgpd6cnQjk5VrMtH4yJhz/aPVx6XyJ8jCmXeMdkMFv+okGUvzcln6VFyQgykEzrlhSte/RgqaAA==
X-Received: by 2002:a50:aa43:: with SMTP id p3-v6mr12819768edc.233.1531046363419;
        Sun, 08 Jul 2018 03:39:23 -0700 (PDT)
Received: from arch.localdomain (x4db1e3f8.dyn.telefonica.de. [77.177.227.248])
        by smtp.gmail.com with ESMTPSA id p59-v6sm6295886edp.54.2018.07.08.03.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 03:39:22 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: rtl8723bs: remove blank lines
Date:   Sun,  8 Jul 2018 12:38:53 +0200
Message-Id: <20180708103855.12473-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708103855.12473-1-straube.linux@gmail.com>
References: <20180708103855.12473-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unrequired blank lines as reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index adf216de113b..ab1174f7c83a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -53,11 +53,9 @@ static u8 WIFI_OFDMRATES[] = {
 		IEEE80211_OFDM_RATE_54MB
 };
 
-
 int rtw_get_bit_value_from_ieee_value(u8 val)
 {
 	unsigned char dot11_rate_table[] = {2, 4, 11, 22, 12, 18, 24, 36, 48, 72, 96, 108, 0}; /*  last element must be zero!! */
-
 	int i = 0;
 	while (dot11_rate_table[i] != 0) {
 		if (dot11_rate_table[i] == val)
@@ -85,7 +83,6 @@ uint rtw_is_cckratesonly_included(u8 *rate)
 {
 	u32 i = 0;
 
-
 	while (rate[i] != 0) {
 		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
 		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
@@ -111,7 +108,6 @@ int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 		else
 			return WIRELESS_11G;
 	}
-
 }
 
 u8 *rtw_set_fixed_ie(unsigned char *pbuf, unsigned int len, unsigned char *source,
@@ -191,7 +187,6 @@ u8 *rtw_get_ie_ex(u8 *in_ie, uint in_len, u8 eid, u8 *oui, u8 oui_len, u8 *ie, u
 	uint cnt;
 	u8 *target_ie = NULL;
 
-
 	if (ielen)
 		*ielen = 0;
 
@@ -215,7 +210,6 @@ u8 *rtw_get_ie_ex(u8 *in_ie, uint in_len, u8 eid, u8 *oui, u8 oui_len, u8 *ie, u
 		} else{
 			cnt += in_ie[cnt+1]+2; /* goto next */
 		}
-
 	}
 
 	return target_ie;
@@ -292,7 +286,6 @@ void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
 		memcpy(SupportedRates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
 		memcpy(SupportedRates + IEEE80211_CCK_RATE_LEN, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
 		break;
-
 	}
 }
 
@@ -363,7 +356,6 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	/* DS parameter set */
 	ie = rtw_set_ie(ie, _DSSET_IE_, 1, (u8 *)&(pdev_network->Configuration.DSConfig), &sz);
 
-
 	/* IBSS Parameter Set */
 
 	ie = rtw_set_ie(ie, _IBSS_PARA_IE_, 2, (u8 *)&(pdev_network->Configuration.ATIMWindow), &sz);
@@ -398,10 +390,8 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 		pbuf = rtw_get_ie(pbuf, _WPA_IE_ID_, &len, limit_new);
 
 		if (pbuf) {
-
 			/* check if oui matches... */
 			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type))) {
-
 				goto check_next_ie;
 			}
 
@@ -417,7 +407,6 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 			return pbuf;
 
 		} else{
-
 			*wpa_ie_len = 0;
 			return NULL;
 		}
@@ -430,20 +419,16 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 			break;
 
 		pbuf += (2 + len);
-
 	}
 
 	*wpa_ie_len = 0;
 
 	return NULL;
-
 }
 
 unsigned char *rtw_get_wpa2_ie(unsigned char *pie, int *rsn_ie_len, int limit)
 {
-
 	return rtw_get_ie(pie, _WPA2_IE_ID_, rsn_ie_len, limit);
-
 }
 
 int rtw_get_wpa_cipher_suite(u8 *s)
@@ -478,7 +463,6 @@ int rtw_get_wpa2_cipher_suite(u8 *s)
 	return 0;
 }
 
-
 int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwise_cipher, int *is_8021x)
 {
 	int i, ret = _SUCCESS;
@@ -491,7 +475,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		return _FAIL;
 	}
 
-
 	if ((*wpa_ie != _WPA_IE_ID_) || (*(wpa_ie+1) != (u8)(wpa_ie_len - 2)) ||
 	   (memcmp(wpa_ie+2, RTW_WPA_OUI_TYPE, WPA_SELECTOR_LEN))) {
 		return _FAIL;
@@ -502,10 +485,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 	pos += 8;
 	left = wpa_ie_len - 8;
 
-
 	/* group_cipher */
 	if (left >= WPA_SELECTOR_LEN) {
-
 		*group_cipher = rtw_get_wpa_cipher_suite(pos);
 
 		pos += WPA_SELECTOR_LEN;
@@ -517,7 +498,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		return _FAIL;
 	}
 
-
 	/* pairwise_cipher */
 	if (left >= 2) {
 		/* count = le16_to_cpu(*(u16*)pos); */
@@ -554,7 +534,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 	}
 
 	return ret;
-
 }
 
 int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwise_cipher, int *is_8021x)
@@ -569,7 +548,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		return _FAIL;
 	}
 
-
 	if ((*rsn_ie != _WPA2_IE_ID_) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2))) {
 		return _FAIL;
 	}
@@ -580,7 +558,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 
 	/* group_cipher */
 	if (left >= RSN_SELECTOR_LEN) {
-
 		*group_cipher = rtw_get_wpa2_cipher_suite(pos);
 
 		pos += RSN_SELECTOR_LEN;
@@ -628,7 +605,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 	}
 
 	return ret;
-
 }
 
 /* ifdef CONFIG_WAPI_SUPPORT */
@@ -730,7 +706,6 @@ int rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie,
 				cnt += in_ie[cnt+1]+2;   /* get next */
 			}
 		}
-
 	}
 
 	return (*rsn_len + *wpa_len);
@@ -795,7 +770,6 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 		} else{
 			cnt += in_ie[cnt+1]+2; /* goto next */
 		}
-
 	}
 
 	return wpsie_ptr;
@@ -848,7 +822,6 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 		} else{
 			attr_ptr += attr_len; /* goto next */
 		}
-
 	}
 
 	return target_attr_ptr;
@@ -981,7 +954,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	}
 
 	return 0;
-
 }
 
 /**
@@ -1128,7 +1100,6 @@ ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 		return ParseFailed;
 
 	return unknown ? ParseUnknown : ParseOK;
-
 }
 
 void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
@@ -1173,7 +1144,6 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	if (pbuf && (wpa_ielen > 0)) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_cipher_info: wpa_ielen: %d", wpa_ielen));
 		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
-
 			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 			pnetwork->BcnInfo.group_cipher = group_cipher;
 			pnetwork->BcnInfo.is_8021x = is8021x;
@@ -1182,7 +1152,6 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 			ret = _SUCCESS;
 		}
 	} else {
-
 		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
 
 		if (pbuf && (wpa_ielen > 0)) {
-- 
2.18.0

