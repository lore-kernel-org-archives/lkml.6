Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486E4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E041620647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoZdUCP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E041620647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeGZVGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:06:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38352 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731392AbeGZVGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:06:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so3152124wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O8huHUzJeKFCE2lmtT0eudqoCXZEqqiNzBaCzWDORqI=;
        b=JoZdUCP2fSeqQVXrwLyJVNbrg4DYKSXTTvz6urKnihuKD9Cav6NeA6qKAVh9BqnpMP
         BkAhEMYRpJZVzwafmM2i+CfhjJ4QvMyfZhFg1jDAeQz5vpp0NLvBC245yBicLjMAYaKX
         janeNDG9Q1upwIvH4FAfV+FZ4tKIy3uVCfJeInwhneLg4tfJWDZKAZ+TySkZw5Hn4uf2
         OAi7/H56Wd8ZQIRvWq1fTGXsVGaFZY4jillqXAB/L8KyZA/mEK1HJRGBHsAwZsw9TGvz
         951R01QzM6LTK7MDAuz13uTuPm2RA+xU+EtrJ/KbSJlreKaB+cW1yc4/EFQ0YshLjNyC
         tvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O8huHUzJeKFCE2lmtT0eudqoCXZEqqiNzBaCzWDORqI=;
        b=TWR+SeLwLtaHOY6YOw3HAKKkSYSRZ6J28ld7fKkaoKZbdy+CAX84XJvqij8GiN+UJe
         qFJPQAWOvVKulBpnAlGSySCoYDOwqbtcSQ4mBSdWLeyF188jGWT6W3m8qSq3mNNe4Pe4
         l2PM9/ycGRjr8CiRYhpFogGyS3w4KLFI3Mh2i9DbwsQgu6XVgipolUIVT7QW8Ue4kIwG
         EAi1WpbiIwNVNwunqiBWw1xuVPRJCYGIxZ7HJyiSWxBdhGPBE0BJzn4lxFO9wvMxXO6e
         Z7I2SA5OjuIIfwLu3fCWsdrIjkUgid66+0cyttHVlqJ8FVDe2qxSRsFSynhvFnRJEbo5
         CQbQ==
X-Gm-Message-State: AOUpUlFAKIsi9rwr3cRisu4v2X1hRLwRZId1teYqYGiyZu3FZzXAcG6Q
        VjpeDgJiNZdvTV+XoMtilaC5OQr8
X-Google-Smtp-Source: AAOMgpfi6FtWUYK1/Vl+1JSfVR5bSajcT/Bcida7m6IZsn7Mpd5uhHSx334FBSrEccWtYTQdV7WOEQ==
X-Received: by 2002:a1c:9a15:: with SMTP id c21-v6mr2549301wme.112.1532634461895;
        Thu, 26 Jul 2018 12:47:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id z14-v6sm3340013wrr.71.2018.07.26.12.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:47:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unused sreset_get_wifi_status()
Date:   Thu, 26 Jul 2018 21:46:59 +0200
Message-Id: <20180726194659.2336-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sreset_get_wifi_status() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sreset.c   | 27 -------------------
 .../staging/rtl8188eu/include/rtw_sreset.h    |  1 -
 2 files changed, 28 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sreset.c b/drivers/staging/rtl8188eu/core/rtw_sreset.c
index 4097380b0bc9..fb5adaf4a42c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sreset.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sreset.c
@@ -15,33 +15,6 @@ void rtw_hal_sreset_init(struct adapter *padapter)
 	psrtpriv->Wifi_Error_Status = WIFI_STATUS_SUCCESS;
 }
 
-u8 sreset_get_wifi_status(struct adapter *padapter)
-{
-	struct sreset_priv *psrtpriv = &padapter->HalData->srestpriv;
-
-	u8 status = WIFI_STATUS_SUCCESS;
-	u32 val32 = 0;
-
-	val32 = usb_read32(padapter, REG_TXDMA_STATUS);
-	if (val32 == 0xeaeaeaea) {
-		psrtpriv->Wifi_Error_Status = WIFI_IF_NOT_EXIST;
-	} else if (val32 != 0) {
-		DBG_88E("txdmastatu(%x)\n", val32);
-		psrtpriv->Wifi_Error_Status = WIFI_MAC_TXDMA_ERROR;
-	}
-
-	if (WIFI_STATUS_SUCCESS != psrtpriv->Wifi_Error_Status) {
-		DBG_88E("==>%s error_status(0x%x)\n", __func__, psrtpriv->Wifi_Error_Status);
-		status = psrtpriv->Wifi_Error_Status & (~(USB_READ_PORT_FAIL|USB_WRITE_PORT_FAIL));
-	}
-	DBG_88E("==> %s wifi_status(0x%x)\n", __func__, status);
-
-	/* status restore */
-	psrtpriv->Wifi_Error_Status = WIFI_STATUS_SUCCESS;
-
-	return status;
-}
-
 void sreset_set_wifi_error_status(struct adapter *padapter, u32 status)
 {
 	padapter->HalData->srestpriv.Wifi_Error_Status = status;
diff --git a/drivers/staging/rtl8188eu/include/rtw_sreset.h b/drivers/staging/rtl8188eu/include/rtw_sreset.h
index a03989461985..3ee6a4a7847d 100644
--- a/drivers/staging/rtl8188eu/include/rtw_sreset.h
+++ b/drivers/staging/rtl8188eu/include/rtw_sreset.h
@@ -25,7 +25,6 @@ struct sreset_priv {
 #define	WIFI_RX_HANG			BIT(5)
 #define		WIFI_IF_NOT_EXIST	BIT(6)
 
-u8 sreset_get_wifi_status(struct adapter *padapter);
 void sreset_set_wifi_error_status(struct adapter *padapter, u32 status);
 
 #endif
-- 
2.18.0

