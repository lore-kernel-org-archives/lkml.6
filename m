Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D74C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A366F20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8EwNQzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A366F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeG2Sk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:40:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37883 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeG2SkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:40:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so10198152wrd.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZ1QwzS1E56AUC/eIEgAiuFJc3XjFppr4xqcYe2+BKg=;
        b=L8EwNQzmzyFJWI6Qhf9WAmKm3bP6aaQFhGu8gsbaY/Ua1Cz3W74jqebOf0ukVo8muu
         g0MwlneZxidI1XEVVBW9D8q/jjf5wEURK8E81wCvA8nC2sezyYU1hOwSyLk7CYXsR5GA
         LFrZRlT/2Bjq+2PiXo6MLhujlS3vTg+2OOTkaCZSkMUsBN9Y5AcuVaeVupMGt8e8WCK8
         9bjMxKMpdUBSfI/xwybEqsVZQjHm/Kf7i8kK/BMbc+AodWZQ6+Vo8g0XaTuGLpR1QFy9
         QFFXwaRjW+ZomjQwx/2pahByX98zNruyd+99L8HdjxLMmAllgDC+5+vXK3xqy23nNTu9
         zcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZ1QwzS1E56AUC/eIEgAiuFJc3XjFppr4xqcYe2+BKg=;
        b=jO3I+KbAyHkc6FRAiXNiAt0SYcj5wAD0QmyLtBTfp38VvWCqR5rOkzlYmhT7h+fhd1
         sufilKjYxX693Wvirqy4NRzZa6ahATEyGI4B3jdYRWCb5iBMqSv69eG8hoguqxor3Eoe
         f7kQyBiJBOjAqX/B4qYTn7yF2C92GZwu6qzOLvceiEEfGasSpOzbF4FkLj3W5CncZjlY
         Rn/JHm61ifm+N/AU3DhTD8KoWxrWRVIO25cIG1TEV/16dX6yNYQP5cC/+fDFL8la+siV
         KCm0NySZhATHoxua8tFDzWytXpUgs8u6LGdrVsRUcYBzMiZZQx9OmN/8edfWKTLDaQF+
         F6Pw==
X-Gm-Message-State: AOUpUlHtJ2GFEB+iu12DLcBNT4EDr/56M3dB4L/kLbhiSWd9TyPj0hGw
        rLSGfnpII+sFodWU/MI/78GWqrt+
X-Google-Smtp-Source: AAOMgpfVwy6GjfBtVvYnm2a9zdmIdzZkTBcOLYJ2URZSXj24t/2I2YJjjPqxfWReWwnkms7MyhFd/w==
X-Received: by 2002:adf:80c9:: with SMTP id 67-v6mr13733212wrl.95.1532884158571;
        Sun, 29 Jul 2018 10:09:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v1-v6sm19916360wrs.34.2018.07.29.10.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 10:09:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: rtl8188eu: remove unused rtw_handle_tkip_mic_err()
Date:   Sun, 29 Jul 2018 19:08:46 +0200
Message-Id: <20180729170851.2581-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729170851.2581-1-straube.linux@gmail.com>
References: <20180729170851.2581-1-straube.linux@gmail.com>
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

