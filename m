Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DEAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D5A218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVNjWS5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeLRSfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32881 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeLRSfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so16983048wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nEnd+1bkL6RYZDo284fZAbsSYMixz2J2SRXnuhxGyzQ=;
        b=OVNjWS5i9O5uJ8has7PSUoVGUMEDlpyBws9N0xjD3PtVhDf+xczrJF0rTJZ5FeV8be
         PT7UPZR1xVVRbpqIK9Cap3zE7KJ+ZdVZBH+hLERQJQHwl/6lc19BiIP2xHh3HaEizixP
         7+LNoUknG0mZ6FpRvvy7t9rXPgWKPFJGmAVpYBl8MPTnchCrB0XS44R6MrlSleTsSP/W
         nprrL9hvj9dMn1CdNludzJkiiMBjjh//iGti1QbZslqKtjUkgsRYX1i60A15IbDROT81
         ytWQX0Vco/eqX4unlaZUa4Ni8x3gz1feN6h48kBEF39dplEofXVcIDTUFsiPoN9/AIMF
         Nq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nEnd+1bkL6RYZDo284fZAbsSYMixz2J2SRXnuhxGyzQ=;
        b=HSvWlJ7A0tPhmyz8PVd7FGNZA3UjkbLzxwleEBb1r3cstgjJx5YlN2FmIBDo0Pug56
         Mo/ga9Q8g3h6HiTgZzsfKQnjZPd+erv4Fsd5igQjljEHPSeqqrdVulGugCO0rvV7XWsm
         JdA7vHom3HXK01UErVcoqQ9AwTP/slmK13lvDjhyVyvgFSmIfeURr3nC+f1b74zkEC0f
         Yo2eARq6tyKWh21vT6UZsoLQOwFSDbhVmXGeBxuGdwNqNGGLM56PyI4MO9lhXV8zCSuv
         PN46qUx0B0CXd0zQLPnujnOrRwb6bSuY8YesNIX0q9jrvC/En0NJgOT58dsTUaEDyKJ1
         GrnQ==
X-Gm-Message-State: AA+aEWY69rfMf66T8XVR8wUTjNHFt3avojo83UZYG82gYlgWStM7f9Dz
        OxI7/9+W0eLpk+4PTP7DxtI=
X-Google-Smtp-Source: AFSGD/UyA+alhjoo7ce3xlHSax7T29Rki7d6AvwC6V+egq7Fb1GVQqFmVzEgMEh23LIvr5UQ3f9HcQ==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr14877079wrv.316.1545158110388;
        Tue, 18 Dec 2018 10:35:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:09 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 03/17] staging: rtl8188eu: remove commented declarations in rtw_mlme_ext.c
Date:   Tue, 18 Dec 2018 19:34:37 +0100
Message-Id: <20181218183451.18692-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused/commented declarations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 8c566180d808..f2eb63634972 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -1828,7 +1828,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 {
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *psta = NULL;
-	/* struct recv_reorder_ctrl *preorder_ctrl; */
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u16 tid;
@@ -3338,7 +3337,6 @@ static unsigned int OnAssocRsp(struct adapter *padapter,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	/* struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network); */
 	u8 *pframe = precv_frame->pkt->data;
 	uint pkt_len = precv_frame->pkt->len;
 
@@ -4871,7 +4869,6 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 	struct wlan_bssid_ex *pparm = (struct wlan_bssid_ex *)pbuf;
-	/* u32	initialgain; */
 
 	if (pparm->InfrastructureMode == Ndis802_11APMode) {
 #ifdef CONFIG_88EU_AP_MODE
-- 
2.20.1

