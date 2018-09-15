Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE0ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9CA208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFMvBil3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9CA208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeIOIHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:07:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39711 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIOIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:07:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id w14-v6so4970967plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 19:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LySzGqsz2vpW9BQwmzvVPe0wjlWKCkMEOQaPki73R8Q=;
        b=GFMvBil3J+pBosEiTTv55QhpL/IyPXIjx1NrgIg+UJZcBLpsS+wYsqTSDeLlY98fu2
         pC0/JZAKBvgjdeo5L61RGDsH21WeV2q8fg8WfVHrAJnNjdSCu9bX8VZd+HeZpIADzcwd
         Vz2oMkx8UORlHpeFxukG0ZhzuPvIICJT2NprN0dMXrMuh9EICHXj9g7PKa+r0A/mStQz
         eHiX4VI5MfVAoG5avtNUagM+tOGniD0f6tmfCuw2tXokTcSuEYOhUhr4Ig264M/Vc3CB
         +kZb9m9c2k0PAS2b0aJZXu2csO39Xnbppz0Vt5Kx8kYdg81szsBv5OBvKuO9zspeu9rB
         vhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LySzGqsz2vpW9BQwmzvVPe0wjlWKCkMEOQaPki73R8Q=;
        b=AXiAGxVBcaONLd8+qWeTJ94KYa42+w1HCC6+KLW6SL5NddcTMzRUN9DCa10F2bDA4e
         ijY0iEY28Yf3MwEFS04BiU+ZjwMyDF1jNXsgG7rk6hvqinjgZ56W58Sm6TRdF+siG5UF
         hzPTorWHhL5kVMfwYgRE17YzAkAtnAeRVxIgxhdJJ/hi/8Q7VmU6Ef7whsgxxVYMvjII
         2iIZx4KVMcerjE755f9Sew4n7Hia4dhkueYGGUN2Yeb+u3x9AV/endPm7DdcgsIIGBiP
         vDwD9rGEYuLouH4lCRIgjiJYmuvtLn/rhtVoA6xAGut523CVP36UnsorTgr5Y0CPXhRf
         XRwA==
X-Gm-Message-State: APzg51DyFxJSOWKYq9UZxkKtHASaylXBIfXAx7flX+xfcpjH8oX4m9HH
        kg1rlgToO8ZSbox8JzbmoO8=
X-Google-Smtp-Source: ANB0VdYfQSYfvRz4LFrYmsKPAo2COc43TU/1JEY7D9L94O9fMwr7p0e1sFtavpcHi5QFy1L9VMZNwA==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8-v6mr14787013plo.308.1536979793119;
        Fri, 14 Sep 2018 19:49:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id b14-v6sm14356454pfc.178.2018.09.14.19.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 19:49:52 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, julia.lawall@lip6.fr,
        aastha.gupta4104@gmail.com, aishpant@gmail.com,
        florian.harbecke@fau.de, quytelda@tamalin.org,
        shreeya.patel23498@gmail.com, tavery321@gmail.com,
        georgiana.chelu93@gmail.com, joe@perches.com,
        keescook@chromium.org, natechancellor@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: Fix two sleep-in-atomic-context bugs in _rtw_pwr_wakeup()
Date:   Sat, 15 Sep 2018 10:49:44 +0800
Message-Id: <20180915024944.32553-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] msleep
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c, 1243: 
	msleep in _rtw_pwr_wakeup
drivers/staging/rtl8723bs/core/rtw_ioctl_set.c, 510: 
	_rtw_pwr_wakeup in rtw_set_802_11_disassociate
drivers/staging/rtl8723bs/core/rtw_ioctl_set.c, 501: 
	spin_lock_bh in rtw_set_802_11_disassociate

[FUNC] msleep
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c, 1255: 
	msleep in _rtw_pwr_wakeup
drivers/staging/rtl8723bs/core/rtw_ioctl_set.c, 510: 
	_rtw_pwr_wakeup in rtw_set_802_11_disassociate
drivers/staging/rtl8723bs/core/rtw_ioctl_set.c, 501: 
	spin_lock_bh in rtw_set_802_11_disassociate

To fix these bugs, msleep() is replaced with mdelay().

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 110bbe340b78..59a667753266 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -1232,7 +1232,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	if (pwrpriv->ps_processing) {
 		DBG_871X("%s wait ps_processing...\n", __func__);
 		while (pwrpriv->ps_processing && jiffies_to_msecs(jiffies - start) <= 3000)
-			msleep(10);
+			mdelay(10);
 		if (pwrpriv->ps_processing)
 			DBG_871X("%s wait ps_processing timeout\n", __func__);
 		else
@@ -1244,7 +1244,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		while (pwrpriv->bInSuspend
 			&& jiffies_to_msecs(jiffies - start) <= 3000
 		) {
-			msleep(10);
+			mdelay(10);
 		}
 		if (pwrpriv->bInSuspend)
 			DBG_871X("%s wait bInSuspend timeout\n", __func__);
-- 
2.17.0

