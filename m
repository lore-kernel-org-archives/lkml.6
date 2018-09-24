Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D09DECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C7720C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpgXq3W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C7720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeIYC7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:59:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46406 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbeIYC7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:59:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id d8-v6so2660628pfo.13;
        Mon, 24 Sep 2018 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bm4Acqb3XB9RGJLIiUYLiFJb5kSpjfsIqMMRV0ygrNA=;
        b=CpgXq3W82U9O8s+GZihcSFFx0W29OCK6WVO9K6HpFehs/GevgOobio2OCJ+zcTvOjg
         Fx69fWOaeAVQu2i38Jk49hheNloU0Aut/UUneBNWPs3aEP0oYj3W97Ja+WbhGwq4C6hy
         2cw3UIXgabEL7ko0YtbfHbxEEKd2Z+/Ey5sV68ewoyI4FrN6ed+FJLlK373oM6mEDPVf
         IIEYEYWe+DxgHvpTpombpSMSS1rNh4qu+TnJvSUdXKhFH1FVGhiHtsodxe8rPA/nFhJQ
         F/sF2yZU5qgYkPNgL7fl3n6zV+YissnHqawVDQ+096xb0UFOpRr+o2buSePNYfy3srsm
         HPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bm4Acqb3XB9RGJLIiUYLiFJb5kSpjfsIqMMRV0ygrNA=;
        b=L6lAZRm9Vh4pGKw/XV+qHSFIBt/JgoplfOJkBfJF3en2l5iVY2y5pqvFFec/aiOkUb
         4khAME6GXNwC78iaEowQ9H7EFsuUGdgpGmOQVjbTyHc4d1KmkRlnUPqjirGKIgazQZw4
         7DCAM+UEKBpVsLIeqXnCKA+OPWW14CEKUt8TZcee87YtozPo4ugBkp3BSWBgc5asoAXY
         mwuWJV3A2biC28imGSMl7mKzCSeiJSNH6gfIV/LpzRwrcwEcomjTMVwg71Kk6tEqHosJ
         QotUzZyNVLlUWIJMbC/Mq/P996bVLVGc4Y6PgDV+Y0qZff0AUGHfFMUy/gxS1BW6L8wy
         N0cA==
X-Gm-Message-State: ABuFfogC8dLN9cedfm00Pqs2HUBLF7uML0AoRNGeXB8g7UHhaX17zNRY
        W3m8smPS+C6HNzhcgueD/nrQuSt2
X-Google-Smtp-Source: ACcGV63znkDVhcAN29Tx1BY5c4Dbl4N0uO4EC7txAglJikLk1t3eDDm+Kjen+DbSSRB31Ch/3yybrA==
X-Received: by 2002:a63:fa0c:: with SMTP id y12-v6mr435916pgh.177.1537822529193;
        Mon, 24 Sep 2018 13:55:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b62-v6sm260160pfm.183.2018.09.24.13.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:55:28 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Kees Cook <keescook@chromium.org>,
        Alexander Kurz <akurz@blala.de>,
        Hayes Wang <hayeswang@realtek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Grant Grundler <grundler@chromium.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ran Wang <ran.wang_1@nxp.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 6/7] smsc75xx: Check for Wake-on-LAN modes
Date:   Mon, 24 Sep 2018 13:54:19 -0700
Message-Id: <20180924205420.31309-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924205420.31309-1-f.fainelli@gmail.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not check for Wake-on-LAN modes specified by an user,
but will conditionally set the device as wake-up enabled or not based on
that, which could be a very confusing user experience.

Fixes: 6c636503260d ("smsc75xx: add wol magic packet support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/smsc75xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 05553d252446..e5a4cbb366dc 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -731,6 +731,9 @@ static int smsc75xx_ethtool_set_wol(struct net_device *net,
 	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
 	int ret;
 
+	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
+		return -EINVAL;
+
 	pdata->wolopts = wolinfo->wolopts & SUPPORTED_WAKE;
 
 	ret = device_set_wakeup_enable(&dev->udev->dev, pdata->wolopts);
-- 
2.17.1

