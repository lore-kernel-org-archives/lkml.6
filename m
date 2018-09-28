Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C751C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1AB206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGKugrIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1AB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeI2Fp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:45:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51684 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2FpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:45:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id y25-v6so3655894wmi.1;
        Fri, 28 Sep 2018 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7DMULJ6++X4SoASj0cUX2/pBG4ZpMIdbQPejFRKpgBQ=;
        b=tGKugrIR9UczoQu0W5tIwwr8sW5Df249EI+3pe/95ZkxcdHjkWZGreyApigkv4GkVl
         dE6er9Z3GfsyadYyr1KknnIuGR6YNwUQG4YJGoE8H3SkZ5TrmYrrU8fhGnoOnDwkc1Xb
         tWv+G+jl8cHlHR2vYS0P75QlHuaJfCJRhUCrt5YZi7UNu+g4MSjjevX6G1XTh/gFqfzN
         PEM2VOMIt2oO5q80I9nvWEH+GwNXXjfVduI6ScPSZePwlXyCpoxUJ4HBrMWnFB2Kh5Eq
         i04PxaYm0OZgSMKqrUXuFiLPhLfqwJvg41KgaggLafs6EYrriJSsgrI1+58KqmneKkE3
         PIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7DMULJ6++X4SoASj0cUX2/pBG4ZpMIdbQPejFRKpgBQ=;
        b=ezzyzjIcHMx3AQHn2nXvfvy+68M8CJmBf25+8sh+/k5X70+swzXS+soQA/8EeVbDMF
         DnjnoLwZDln2lirkgabxsvkh4cNOsF2nm+9m5MfWZVQalKQFKhLv+ybXBro14WcaPDhx
         Olk7p0lwu2qLVC0ELHkg4YmEJxsPQ3DdHMkEoN1UEjEwruvQBuyPeow1kfPsEilnabk5
         dbqvg4n0Q29te9nCwLxl+yv7gg2uWBk2JMvNtvs6b18oAlNiNKBsUmum+1e8diqvrU5s
         96ee+XnBwwfEJdN8+UMAl4/ZXBeMml8hOVTopJVSyj+TnJ2UvG53lHY97y/TqPuuJ98F
         7anw==
X-Gm-Message-State: ABuFfohjXftdDU7+9pY1psBwuHoHrke9KqFe/g3AlE2VsWVj6deSKtE3
        vVllAXv8cKAUGdrhT+sc3h4h3wck
X-Google-Smtp-Source: ACcGV60+iv/4+1C59oJNOqe5AJ+1FNnvwZjBEXbvX82AqaSAvXwmQp0yB6u7+21YLHF/we4kYhFNoQ==
X-Received: by 2002:a1c:3ec3:: with SMTP id l186-v6mr3041711wma.84.1538176762691;
        Fri, 28 Sep 2018 16:19:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8590730wrb.95.2018.09.28.16.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:19:21 -0700 (PDT)
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
Subject: [PATCH net v2 3/7] lan78xx: Check for supported Wake-on-LAN modes
Date:   Fri, 28 Sep 2018 16:18:52 -0700
Message-Id: <20180928231856.3587-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928231856.3587-1-f.fainelli@gmail.com>
References: <20180928231856.3587-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver supports a fair amount of Wake-on-LAN modes, but is not
checking that the user specified one that is supported.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/lan78xx.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a9991c5f4736..c3c9ba44e2a1 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1401,19 +1401,10 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	if (ret < 0)
 		return ret;
 
-	pdata->wol = 0;
-	if (wol->wolopts & WAKE_UCAST)
-		pdata->wol |= WAKE_UCAST;
-	if (wol->wolopts & WAKE_MCAST)
-		pdata->wol |= WAKE_MCAST;
-	if (wol->wolopts & WAKE_BCAST)
-		pdata->wol |= WAKE_BCAST;
-	if (wol->wolopts & WAKE_MAGIC)
-		pdata->wol |= WAKE_MAGIC;
-	if (wol->wolopts & WAKE_PHY)
-		pdata->wol |= WAKE_PHY;
-	if (wol->wolopts & WAKE_ARP)
-		pdata->wol |= WAKE_ARP;
+	if (wol->wolopts & ~WAKE_ALL)
+		return -EINVAL;
+
+	pdata->wol = wol->wolopts;
 
 	device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
 
-- 
2.17.1

