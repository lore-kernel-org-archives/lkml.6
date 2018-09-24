Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B28ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB8A20676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmgvZsrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB8A20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeIYC7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:59:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40836 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeIYC7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:59:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so2914591pgm.7;
        Mon, 24 Sep 2018 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pN80Rw0L9zuyYJtcOwbG8AKZcMeKTKgEirKbEwnLrKo=;
        b=gmgvZsrnuze9Ru26SAsu0AEE901fIv799RwKgsiRmJNBOc0KlayeoFYBKAaBjNn2ET
         n6T9XX6pna18QTGW6IBEIoVRR56PuPdLRcEi25oL6eGaToVxQp74AUpMsPIXpBlg6Gim
         O9zVWgwIRDQ0ANB4/+hJni1xEOA0bHYL47VOF1vXIqs1XLuPxnOZyBQs5/APOfuxl2tO
         d0P6Sr23x3EXl7ugzNOv0XcHGVVK3lFoKa5Vh6/QYitDYLOkJ56ZlKvCL0C1MfhhGMWb
         93yw8yB/h0FwbD6xVQ/2tbUc3b/HvgSP/lX/bLUf2WiFHxHoZ3LGSnolJL6aBO/RxGWx
         ousQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pN80Rw0L9zuyYJtcOwbG8AKZcMeKTKgEirKbEwnLrKo=;
        b=DQUHMZO6d9fMN8W89ZjsCO5rjydo1zncG2K7VmXrCgREK0ftxdKrv5NZF+/g+5GS9/
         Wc3iXd9Xo3Q+J5NLqw7NCCUs1LPxR7f/IujizQP91CZHKxPs/3bsbcJZY9GaJunPvHHi
         l6istwQeGskyueWN0lUc/cPD7bxijITNh/IcF3Qr45vWLtVLggELR1PcpQAKp4yr/kfo
         ZRkreG1uTNARXX7HsIy2H9m83nBIEw92d5hJTFULxLS0ytZxgl2gYrDleHgFAmetp+tJ
         0jDdhOjKI/dzMatU02ByTVooZtibo/disdpKE72HfQg9hbY0rYU3E0L2VRhvvnS2WzpV
         4t6g==
X-Gm-Message-State: ABuFfogYHlCYOWd+or4JOT3P/mgYeZ/VQ09hsZHQGPpZS3fW4t4x/Lg0
        Z8xP0JK/eH61yra5V0ErLk8ccjTt
X-Google-Smtp-Source: ACcGV63W++Arw5ncF0ufnHSgiB11lPBFRcBT9wQbQdl2gcJJkAj0uy5QCMa68iobdPtuE0rej/8Q7A==
X-Received: by 2002:a63:9c19:: with SMTP id f25-v6mr408522pge.447.1537822519083;
        Mon, 24 Sep 2018 13:55:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b62-v6sm260160pfm.183.2018.09.24.13.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:55:18 -0700 (PDT)
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
Subject: [PATCH net 1/7] asix: Check for supported Wake-on-LAN modes
Date:   Mon, 24 Sep 2018 13:54:14 -0700
Message-Id: <20180924205420.31309-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924205420.31309-1-f.fainelli@gmail.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently silently accepts unsupported Wake-on-LAN modes
(other than WAKE_PHY or WAKE_MAGIC) without reporting that to the user,
which is confusing.

Fixes: 2e55cc7210fe ("[PATCH] USB: usbnet (3/9) module for ASIX Ethernet adapters")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/asix_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index e95dd12edec4..023b8d0bf175 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -607,6 +607,9 @@ int asix_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	struct usbnet *dev = netdev_priv(net);
 	u8 opt = 0;
 
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |= AX_MONITOR_LINK;
 	if (wolinfo->wolopts & WAKE_MAGIC)
-- 
2.17.1

