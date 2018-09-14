Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FABECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E9320833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY7ISmR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E9320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeINU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:26:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36979 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeINU04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:26:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so10968281wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w25zZdr2faTENtCKns6z7t2N3+CJgCFP3hkHZ0CDn6g=;
        b=TY7ISmR7z+VS8YP7os/T0En9dXa2DrMmax8z4GM0uryIObCTNClxXMk6PFzPPy4faL
         8M8OhUAI1NYIJwmzBIbizOE/Si0EylS439BgTDiAMtZ0jKY54Ie7cKlzi2zilEja8IyT
         VGzST40rPLO6pMPleMjng6MiW1txZPFYK2QFEX8d+J2hqQhDSDM/BAZqcW/oGnVjA1s1
         3iKiYufq2F+51WSnNtqOkrWl0mVdSKEV4W+oz4iYMvJ60dhnOOKo8fh5aJYTRs0uCMqH
         7x/tNU9oNMDXYW+bcqHlCjXpP1j/ojkMu4Haz1uGnYPWtuPMxvLmdK/gvI+qNTeeeajp
         NB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w25zZdr2faTENtCKns6z7t2N3+CJgCFP3hkHZ0CDn6g=;
        b=RdpiS0zecx2wg1Lr27xdl4nfg/D67e2tBnWXSaHGKRZVAzx4YTJTMiFsSG+ExBeHh0
         5NB4ZSZmgMa/rucF5hABJ8MKTmeTSTg0Z5E9FGpMHVZXX5wZRuf8iMdrwiPAmVyk7Bob
         npW4fmdNcR16dy33wpVm/t9kyqJ2C+jbe71GLxadwXUwugO+tHN0+pvgPbM8IQ3aAR8m
         wj20i5JpSSistcLKIumh+ddyfa9pJoJ28RjvOy30RhLQDIZYdykcKDs+vtS2Vvs4axj7
         M/9YubM4LriAUm76wplPOCdIXpV1GJ4qWDiTGdUDpFl+fb6Nb4PSaAIeAf1hKKVCPr49
         L1SA==
X-Gm-Message-State: APzg51CzKFo36QuExNTmEAe1DK1ER5qCM1djOxKuJWWuNUr6jM34ie9g
        kSz/pwfWxzSm/P1imibAE1s=
X-Google-Smtp-Source: ANB0Vdbgl/XFg7nZts4B2caZ49hVNLjDDE32svpeHZsj/E9Fx+19bYnhZxAZE74sUZRq1L7E7cyZqA==
X-Received: by 2002:a5d:55ca:: with SMTP id i10-v6mr10131878wrw.38.1536937917683;
        Fri, 14 Sep 2018 08:11:57 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa89.dynamic.kabel-deutschland.de. [31.18.250.137])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5198502wrn.58.2018.09.14.08.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 08:11:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: rtl8188eu: remove whitespace
Date:   Fri, 14 Sep 2018 17:11:37 +0200
Message-Id: <20180914151142.1179-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180914151142.1179-1-straube.linux@gmail.com>
References: <20180914151142.1179-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces or just remove spaces in declarations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_ioctl_set.c    | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index 9b67f33cb568..a00272540846 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -17,8 +17,8 @@ u8 rtw_do_join(struct adapter *padapter)
 {
 	struct list_head *plist, *phead;
 	u8 *pibss = NULL;
-	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct __queue *queue	= &pmlmepriv->scanned_queue;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	u8 ret = _SUCCESS;
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
@@ -308,8 +308,8 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	enum ndis_802_11_network_infra networktype)
 {
-	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct	wlan_network	*cur_network = &pmlmepriv->cur_network;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	enum ndis_802_11_network_infra *pold_state = &cur_network->network.InfrastructureMode;
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
@@ -394,8 +394,8 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 
 u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_ssid *pssid, int ssid_max_num)
 {
-	struct	mlme_priv		*pmlmepriv = &padapter->mlmepriv;
-	u8	res = true;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	u8 res = true;
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("+%s(), fw_state =%x\n", __func__, get_fwstate(pmlmepriv)));
 
@@ -467,9 +467,9 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 
 u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 {
-	int		keyid, res;
+	int keyid, res;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	u8		ret = _SUCCESS;
+	u8 ret = _SUCCESS;
 
 	keyid = wep->KeyIndex & 0x3fffffff;
 
@@ -535,16 +535,16 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 */
 u16 rtw_get_cur_max_rate(struct adapter *adapter)
 {
-	int	i = 0;
-	u8	*p;
-	u16	rate = 0, max_rate = 0;
-	struct mlme_ext_priv	*pmlmeext = &adapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	int i = 0;
+	u8 *p;
+	u16 rate = 0, max_rate = 0;
+	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
-	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
-	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
-	u8	bw_40MHz = 0, short_GI_20 = 0, short_GI_40 = 0;
-	u32	ht_ielen = 0;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct wlan_bssid_ex *pcur_bss = &pmlmepriv->cur_network.network;
+	u8 bw_40MHz = 0, short_GI_20 = 0, short_GI_40 = 0;
+	u32 ht_ielen = 0;
 
 	if (!check_fwstate(pmlmepriv, _FW_LINKED) &&
 	    !check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
-- 
2.19.0

