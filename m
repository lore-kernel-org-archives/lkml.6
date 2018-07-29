Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F4113C627
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A978720893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/gqknrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A978720893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeG2U0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:26:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33766 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeG2U0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:26:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so6528226wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZ1QwzS1E56AUC/eIEgAiuFJc3XjFppr4xqcYe2+BKg=;
        b=p/gqknrxHB8XngK3uqaw4G2JX0gi42KfgLzkiV23Zo3yBvx0sR3vTdMRTiZ/Z2RS8t
         rnoFxxzE+DayBloKns2WpaG7mny2JDJjkYeRaZmnunvX6YhoXuQxz/ZrjM4KbXkNdRDW
         GP1tj/PxWKsuqXgF9ZXbVfVY36tdeF6sKL8ksE3s88Wx36nk8trnFsm7o4ocLBz8u2K7
         8RlyI+lQ8YGRY9QKhDkStoE2jYJo70yvRMtlv2EMiSO9M5jvl3LkwkifDcBsAT06XCAS
         uYgEmntFZN5CFWw8iyDl3Bdnp7EwR/gtKHxf2iKoMlEaezugx2TOtL1fwUtY1EEPx36W
         K9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZ1QwzS1E56AUC/eIEgAiuFJc3XjFppr4xqcYe2+BKg=;
        b=Rs/C+eSVPZU377LoM24OIMlHL4oXR1yUp0AOmx5QAWawqlGmjbiMWVvEAzme8SD3Ss
         Ayv2ykjSJiMdda2XpYSXhPDIcRyyi5MfjBcsNNtvyJ/K+jnUZVuowmBQRukDYT/HEFmU
         SdqIhz+ts2z+esqTdjMDema9Tbj29W+nNtL74bKVwVsOyWFNZ0xQH+c9Zi4pZBUjMsGo
         OtwmjPJcG5Luw9aC2f9M0qEMNpFBbMPkAi87QtfFZLWdvHGbbct4qqcgl0UQR0gU8Pqp
         9+d+ce6DthIvQAn4i8KmtDoE5AHPWCnE9RMRl+dDGDdpUzXZy3NW1E1MOm9VdWy0N5fs
         a/6w==
X-Gm-Message-State: AOUpUlHVfpuhlU8wes/g+c4Ek3sSd6qfqG73RvpRMm5IowPLhvwDE7Uo
        M+LWoQQtZAGMUhpawqbqtS8=
X-Google-Smtp-Source: AAOMgpeDvPbhfjbJgFsuVXlw7mSUgOP9THaEbR5xvRDeTrRZkSyVR37RvAei3TN/IrO5kxH20dqB3A==
X-Received: by 2002:a1c:6585:: with SMTP id z127-v6mr11687209wmb.5.1532890507136;
        Sun, 29 Jul 2018 11:55:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id g125-v6sm8674247wmf.16.2018.07.29.11.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:55:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/7] staging: rtl8188eu: remove unused rtw_handle_tkip_mic_err()
Date:   Sun, 29 Jul 2018 20:54:43 +0200
Message-Id: <20180729185447.19903-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729185447.19903-1-straube.linux@gmail.com>
References: <20180729185447.19903-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_handle_tkip_mic_err() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/include/recv_osdep.h    |  2 --
 drivers/staging/rtl8188eu/os_dep/recv_linux.c | 36 -------------------
 2 files changed, 38 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/recv_osdep.h b/drivers/staging/rtl8188eu/include/recv_osdep.h
index d2341521cc8e..2c05964b757d 100644
--- a/drivers/staging/rtl8188eu/include/recv_osdep.h
+++ b/drivers/staging/rtl8188eu/include/recv_osdep.h
@@ -19,8 +19,6 @@ s32  rtw_recv_entry(struct recv_frame *precv_frame);
 int rtw_recv_indicatepkt(struct adapter *adapter,
 			 struct recv_frame *recv_frame);
 
-void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
-
 int rtw_os_recvbuf_resource_alloc(struct adapter *adapt, struct recv_buf *buf);
 
 void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl);
diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index deadf26ea2aa..148ee94bbf3d 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -25,42 +25,6 @@ int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 	return _SUCCESS;
 }
 
-void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
-{
-	union iwreq_data wrqu;
-	struct iw_michaelmicfailure ev;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	u32 cur_time = 0;
-
-	if (psecuritypriv->last_mic_err_time == 0) {
-		psecuritypriv->last_mic_err_time = jiffies;
-	} else {
-		cur_time = jiffies;
-
-		if (cur_time - psecuritypriv->last_mic_err_time < 60*HZ) {
-			psecuritypriv->btkip_countermeasure = true;
-			psecuritypriv->last_mic_err_time = 0;
-			psecuritypriv->btkip_countermeasure_time = cur_time;
-		} else {
-			psecuritypriv->last_mic_err_time = jiffies;
-		}
-	}
-
-	memset(&ev, 0x00, sizeof(ev));
-	if (bgroup)
-		ev.flags |= IW_MICFAILURE_GROUP;
-	else
-		ev.flags |= IW_MICFAILURE_PAIRWISE;
-
-	ev.src_addr.sa_family = ARPHRD_ETHER;
-	memcpy(ev.src_addr.sa_data, &pmlmepriv->assoc_bssid[0], ETH_ALEN);
-	memset(&wrqu, 0x00, sizeof(wrqu));
-	wrqu.data.length = sizeof(ev);
-	wireless_send_event(padapter->pnetdev, IWEVMICHAELMICFAILURE,
-			    &wrqu, (char *)&ev);
-}
-
 int rtw_recv_indicatepkt(struct adapter *padapter,
 			 struct recv_frame *precv_frame)
 {
-- 
2.18.0

