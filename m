Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329BEECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D493820867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXqKZkvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D493820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeIRNjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:39:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51627 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbeIRNjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:39:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id y2-v6so1377064wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w25zZdr2faTENtCKns6z7t2N3+CJgCFP3hkHZ0CDn6g=;
        b=OXqKZkvXg5Kaf08hutlOJZuXPsrV1KQzGIpD7Gg6vVZFotMDQ1CMstAWVX4TtxXbjg
         WP1XUaHnWICCfQBE04azUlRrQr+h8rOv+g2NPvOXow5PzLIWTmI8chQNMnbdsz6GWa2U
         tdkuI539W7z74Ioa4YA8SuqB0G8Nqv2/WFj4E1unWQMHBbrxcjKNwcNdUQfZdL52j6Yp
         L/fzMU+6qrsdk3OAwKkpIj/HqRvmzDelIoQAWOluqKv6lm9tbE89f+3SoH1FfQxR1u68
         rGDSQR62G0t0NKqzj4a2vAOfmV+6vNZm4cfVbndfhnw7zwNOxkgVthwdNaPi4IISfzRc
         V0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w25zZdr2faTENtCKns6z7t2N3+CJgCFP3hkHZ0CDn6g=;
        b=Gg05pSpTBjlUVH0HBhXbuKLGJYP3VDZMK4b9TDmQ/Iw3Hh/USBA4VgcCvLVwUTr92Z
         OTowY8yde3V9z+7mynyiJ2KJF3X8w9RkqMm/b6N5JBr0/pAj8JQ98YXae7aEvwTd00Re
         2j8WhjH2DhoJpqjYv91QbV+aBa69jKJm16LFUNrm3Y8N0yteflUVdyH/8coA4z/PXzgW
         aKnPHHE2pJ0yrWZYqeOTiqgypSlqVjVwqrOTIhIU8u3dUnXV4f5Ck2s1GU9XO7Z6EsGF
         NBQDuPPhKbuTtwJkb2m83jvhQcRxFwldIuNhU1hTDMTpNOhFAulaCSFvI8LXGvcYLANL
         l40A==
X-Gm-Message-State: APzg51AvfGKEX46Xv7sev9MV7yOw0Q6et1KpErAQG+DUkBy2E3yL7MnF
        LgzijG27OzlQxIe5pfQGAnYN+/En
X-Google-Smtp-Source: ANB0VdYX07BcyHSGq7ovTwBkSKYf6f7FKiAr3dYuR091rrLY4LeBCQh92xauzuxmVRKPNMdwEWqmpw==
X-Received: by 2002:a1c:7dc7:: with SMTP id y190-v6mr13825817wmc.62.1537258059866;
        Tue, 18 Sep 2018 01:07:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id r140-v6sm1386869wmd.7.2018.09.18.01.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:07:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/8] staging: rtl8188eu: remove whitespace
Date:   Tue, 18 Sep 2018 10:07:06 +0200
Message-Id: <20180918080711.21594-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180918080711.21594-1-straube.linux@gmail.com>
References: <20180918080711.21594-1-straube.linux@gmail.com>
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

