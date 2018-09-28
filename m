Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029B1C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8856206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FraKfHsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8856206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeI2Fpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:45:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44490 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2Fpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:45:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so681453wra.11;
        Fri, 28 Sep 2018 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bm4Acqb3XB9RGJLIiUYLiFJb5kSpjfsIqMMRV0ygrNA=;
        b=FraKfHsbjCznufPl+GjcFxF42gdCWAnPnycn7Qp3Wp0yXNheuHDhwrk3REqTWWf7uA
         YRdWsQwemyBTV+DhjG2IdD3q1lFW019SL1vOSvpMmljB6hNJwrB2lwbYFYcuCvBOpDmj
         mYE4HVh4oge6q4U7+QtBw0B3AvNNyCWkKhTKDLuzfuDjSDAxt557rxclBZb/cEAOq+uT
         kqrj6JLGjT0/LPye0X67o/wxU/jO/4P7/D++ZkvXp0dAXiLTe10mT2tTndMlBXAbLn6E
         vUE1AI9HhqwWLID8MOv7fCAJke6yvjkTqiGQqnsrePS9CkAId5G82dtLLoWEP6sWFagv
         r6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bm4Acqb3XB9RGJLIiUYLiFJb5kSpjfsIqMMRV0ygrNA=;
        b=VgcdQ6wSxfz5gzB6Jmk1elfNomIYh18G4y2B1aSUE5FYWU1rqlC/UxxSAomYfPWUlx
         IfRAPhO9vOX/iDoku6/AuVPwlbL1QIS0GWIWn9xnolXgdhV30INJbXMJQcE25h5YeTtW
         8cxhaNx1+S3ysWLt4xIgcMl1dHWdh585GMm2Tp6eJi09pi4cdnIozcH43umHQbkG9G6Y
         OQpcu2lR2pkuEOq53qC+3EaPstSMKgMBdszUK4vvV0+RXJX2Ftl+CNZD/FPek/0qkyRU
         YHy3Ksa7gFSWufDwCDjiVMMZAYhBaRTx+vlP+6Vuzr3UMZNcrS42rfAQcjDOKKek5IRs
         C2AA==
X-Gm-Message-State: ABuFfoiWTPkwcdsv0C+Cx3kZkzoK6U3WsxYiEd312thkwshgGpRv7WPx
        9ZlJoI+RK5r90ok0duUBzR0Mxg0X
X-Google-Smtp-Source: ACcGV62lnsy5BggsiCDEQQjXeI0HlkoqAEuzXneAWCeQoSR4A3KOsCktBsl8JguDrMc2rWz1M98dHQ==
X-Received: by 2002:adf:de8c:: with SMTP id w12-v6mr471105wrl.270.1538176775253;
        Fri, 28 Sep 2018 16:19:35 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8590730wrb.95.2018.09.28.16.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:19:34 -0700 (PDT)
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
Subject: [PATCH net v2 6/7] smsc75xx: Check for Wake-on-LAN modes
Date:   Fri, 28 Sep 2018 16:18:55 -0700
Message-Id: <20180928231856.3587-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928231856.3587-1-f.fainelli@gmail.com>
References: <20180928231856.3587-1-f.fainelli@gmail.com>
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

