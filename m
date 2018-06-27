Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCDEC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E2025FEB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG4S2Q2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E2025FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966009AbeF0Sru (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:47:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55917 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965931AbeF0Srs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:47:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so6961284wmv.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ESfE27P1/ngvLPaekTjL3KLDILHKEmNa42xHJkc+2GM=;
        b=BG4S2Q2gbyJu8SLJnsOeBVCTHkL8dX7Gb9EW7VS+6I3wOSvR4pmS6oZNwws+o2w/hi
         dsz4VGpj0kS6UDNOSLW+x/ZNcDM/ZwYABSBQfxsmEJETZHeG2imnMR/PSy0c5vC270Ek
         3lnmmcphseqSXx6AuNBJnFpNt3Jo5kG/L56jt9bNwkQVtRGf31UPrVpL+H/jXNWBHIy7
         yFIX6UW5uHKAP93scanPqM9Igx9T8EThsJQXI/j4lck2NOeCeBhyDR2bzkQG5e0yGoAR
         hpWy6dOBphtWEILfO5c5acoEPPpkHdVEn8tXharH652d79/8AF3KB9Rp+AIv+jBq4WXk
         ayWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ESfE27P1/ngvLPaekTjL3KLDILHKEmNa42xHJkc+2GM=;
        b=aJJrj1eMooZi8xbqQesAHmo6sfTSFPhn20v6xo1mOF+6lQ/u5gKzpFMXyhyjoyWrFg
         TULcCFHa9XM7xwUHDfFWmH/xaAxZfSMZpSLLU5cnNh2ef+06BW61zhzw0zJ0BJkQdfgT
         GVF2cDhteG36CGLWDO4BSQOJ9ks/btOBbixm+BguouhzwP22p1HK27NH/Zl4R+baJNfE
         YxhK4cnLf9OhRCv0pBenrogqneQZdexYVFob9XU8pcpOZq26irIpi+YF5WmXc6ksmaO4
         gSOZW5ohjPegKjV7TgN1TdAL1VrtQpC1UBxbJeUjzM1Io3D0JrHonn3y1L34cu8K/2rt
         iKKw==
X-Gm-Message-State: APt69E1Mi4+QbK4zAuPFyrewc/0VRfAifDF2pe1YjIXl7FQqvGAPzO0H
        /G9dMWa+SinVyqax0mF38bw=
X-Google-Smtp-Source: AAOMgpc4LJ560oVej64epwk0mXyuliI/HztBd0Dt045Se8UtaPWyjhb3Bmyp97HpoBpt07G2pvZ8bg==
X-Received: by 2002:a1c:4596:: with SMTP id l22-v6mr6045770wmi.33.1530125267714;
        Wed, 27 Jun 2018 11:47:47 -0700 (PDT)
Received: from arch.localdomain (x4db2cd79.dyn.telefonica.de. [77.178.205.121])
        by smtp.gmail.com with ESMTPSA id 4-v6sm3880648wmh.14.2018.06.27.11.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 11:47:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove whitespace - coding style
Date:   Wed, 27 Jun 2018 20:47:32 +0200
Message-Id: <20180627184732.11329-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unrequired whitespace in some declarations,
fix an indentation and remove unrequired blank lines.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/recv_linux.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index 9f9a595191b6..deadf26ea2aa 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -28,9 +28,9 @@ int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 {
 	union iwreq_data wrqu;
-	struct iw_michaelmicfailure    ev;
-	struct mlme_priv *pmlmepriv  = &padapter->mlmepriv;
-	struct security_priv	*psecuritypriv = &padapter->securitypriv;
+	struct iw_michaelmicfailure ev;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	u32 cur_time = 0;
 
 	if (psecuritypriv->last_mic_err_time == 0) {
@@ -69,7 +69,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	struct sk_buff *skb;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-
 	precvpriv = &(padapter->recvpriv);
 	pfree_recv_queue = &(precvpriv->free_recv_queue);
 
@@ -129,7 +128,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	RT_TRACE(_module_recv_osdep_c_, _drv_info_,
 		 ("\n rtw_recv_indicatepkt :after netif_rx!!!!\n"));
 
-
 	return _SUCCESS;
 
 _recv_indicatepkt_drop:
@@ -137,12 +135,11 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	 /* enqueue back to free_recv_queue */
 	rtw_free_recvframe(precv_frame, pfree_recv_queue);
 
-	 return _FAIL;
+	return _FAIL;
 }
 
 void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl)
 {
-
 	timer_setup(&preorder_ctrl->reordering_ctrl_timer,
 		    rtw_reordering_ctrl_timeout_handler, 0);
 }
-- 
2.18.0

