Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F2A27540
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nehASLoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F2A27540
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967427AbeF1RDy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:03:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44635 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965914AbeF1RDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:03:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so6232639wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EQev1kNdN2a3K6O0aZBwa9GWPjzYn9SBM3SBVIlGUUE=;
        b=nehASLoMWxk0EJDH4aw5QHpG8gAelcHSdbQi6TuYuVDiIvcuyAqW6GWQd5f7S2dZHi
         bkE9U4K1fm7u90NUNSmCuOQPZuYlIjyFlJ3VD18ocaojyv20ptQg059sa941m80kxrTX
         Rgu5mrigJIUIQk10YCAPELaoJ5LSIsiAH62bKNU0xICZ4Pwt6p/T5jPEQu0uyorNKZ+5
         bbm5daS0ntmB+xfKlx3EVu4CBBDeYD0QJK0rIL8bVJPcJ8Ui4HzKYz0Fq5qkhPZUXkbc
         jVb4Ju6LC5RiCgJTejI+p+dYx/50wccYyx+T2/SpxZARl83xWdpKrHGTTqMj2VbGBrLA
         fySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EQev1kNdN2a3K6O0aZBwa9GWPjzYn9SBM3SBVIlGUUE=;
        b=aNwO4/eitHc83L7MqBDmcPda1iEoyogjCCWWw9U7gaD0EBdM/WMdKjIkLXACLmJPpq
         jESwTL0bpsyxd0gneciFbfDF+FqIfiASRICsHuV5rPDb81fsD97cFgizS6bVFirpzKzn
         gpHGZReWEatsDKeQZq71u+RqZuXsx4P2wXAYfcrPkIJGXQzofIS7sBj53L0R/6Cwu0hW
         n/1LcduufeRgZZgIeOUGTGu2tG3hXnyht5CckK06llxhw9T9wIH7dG22VTBN2hrZcvlR
         eEOEmUMAHQLEcGM8uMdU9rcrMU/2xNl6UU9IYcOsLtpUgsi77DJ5YpqpsDQTWYeRaXKh
         yhRQ==
X-Gm-Message-State: APt69E3QJqJZo9a3WvC4TGPSDlgHyCn4+1ltCtQP5SI4l25QSAic7oP1
        vi8DtssqoY4JVwKXK1DEQJY=
X-Google-Smtp-Source: AAOMgpdIrIUA6bV9Ycv2yHKFufafost0hvyAagPzh3TUOPafZzbZcZ+/tj2HWp6Rq7nsIsQjwx33gg==
X-Received: by 2002:adf:ee81:: with SMTP id b1-v6mr9974411wro.21.1530205431067;
        Thu, 28 Jun 2018 10:03:51 -0700 (PDT)
Received: from arch.localdomain (x4db2000a.dyn.telefonica.de. [77.178.0.10])
        by smtp.gmail.com with ESMTPSA id x11-v6sm9271070wrm.78.2018.06.28.10.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 10:03:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove pointless if else in rtw_sdio_resume()
Date:   Thu, 28 Jun 2018 19:02:52 +0200
Message-Id: <20180628170252.8712-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether any of the conditions is true or not, the return variable
is always set to rtw_resume_process(padapter). Replace the if else
construct with a single call to rtw_resume_process(). Also remove
the now unused local variable pwrpriv.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 22191c9584ad..6d02904de63f 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -605,7 +605,6 @@ static int rtw_sdio_resume(struct device *dev)
 {
 	struct sdio_func *func =dev_to_sdio_func(dev);
 	struct dvobj_priv *psdpriv = sdio_get_drvdata(func);
-	struct pwrctrl_priv *pwrpriv = dvobj_to_pwrctl(psdpriv);
 	struct adapter *padapter = psdpriv->if1;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	int ret = 0;
@@ -615,25 +614,11 @@ static int rtw_sdio_resume(struct device *dev)
 
 	pdbgpriv->dbg_resume_cnt++;
 
-	if (pwrpriv->bInternalAutoSuspend)
-	{
-		ret = rtw_resume_process(padapter);
-	}
-	else
-	{
-		if (pwrpriv->wowlan_mode || pwrpriv->wowlan_ap_mode)
-		{
-			ret = rtw_resume_process(padapter);
-		}
-		else
-		{
-			ret = rtw_resume_process(padapter);
-		}
-	}
+	ret = rtw_resume_process(padapter);
+
 	pmlmeext->last_scan_time = jiffies;
 	DBG_871X("<========  %s return %d\n", __func__, ret);
 	return ret;
-
 }
 
 static int __init rtw_drv_entry(void)
-- 
2.18.0

