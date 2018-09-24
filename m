Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F45AECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88B72098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qmt7huEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88B72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeIYDAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:00:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34288 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbeIYC71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:59:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so9812744pgv.1;
        Mon, 24 Sep 2018 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=haEHP1Iz78Fw98J7Yy0wNUApgo7Zm5Zh0aJ5xbSU/Us=;
        b=Qmt7huEA0NbU+qF3631L2DlKQw8yU2+4ANxgNG2MF0n0dslJV4c5DHAdmVenA8XjKW
         gHBDYg7DJgOXzMW2rNXjbHDrA95132ijtMpzLDJCxTYgBBTZPeZz2NQebAJ5CPjtShtJ
         NysVk0iHut7VoHiTsIfuQySJ4sT4C/VEqr5aWHfVoBj2iVKUaQPLqlBM8dgndrwvCKxQ
         aubSAPaFY9vC6D1SFhQQrQBI9+ZPC0deSV64BzZLmYWqzsmBJM/p4r7iuxNQC0Ax38Gv
         UNzJ64NBdmJi2ZjEhvxLua+lEbVLOAOoQ3H4wJYRj1EOWQ50yjaH1Tu7iACgz9eFAsMF
         Vl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=haEHP1Iz78Fw98J7Yy0wNUApgo7Zm5Zh0aJ5xbSU/Us=;
        b=Ov0/4HGNKf6xWL3MQIth5ad1YdzTG8sbVQ/0HiisBiZDuHOKIduz4C2kFk4I4zq8yW
         4mGOY7P690ciwURXm+qNxD2WDU423Sjj80cM+8vwz35E8LRcBp9tOJh27MjJS3i+/ab5
         eLI/1EsNewLMn19V0EMCyzOs4o72OJXTGw1dOHsIx2S2pwqa5rKfG5aPUP/rkwJLKZXI
         W+icNUu1D6aM/j1SHNQqv8yR9QUTHMqhpeKb3tdS92D8K+eUFEX3Z/0qRRj03S52L6aS
         kAu8sD0HfiRTCjqts/NPEoLjtkSb0RgssvN3TWpfzKqzrpJxDC8pCbrijd08hCR0QY0d
         eyMg==
X-Gm-Message-State: ABuFfoi6itKZdpdvq7yKuBU3w+b/yLrE7hvEBaeAw2JKSRFSmGjUF6bJ
        frGUZibTYamMkh5UMklEHJKbGD4a
X-Google-Smtp-Source: ACcGV61Sdk6257xCESRmPgZt97TacEp/Q/7WzzuKqe3Lgg1O+eW/+cnHx5RqykijDf1vCbuyg7lUKA==
X-Received: by 2002:a63:24c:: with SMTP id 73-v6mr466823pgc.252.1537822523099;
        Mon, 24 Sep 2018 13:55:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b62-v6sm260160pfm.183.2018.09.24.13.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:55:21 -0700 (PDT)
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
Subject: [PATCH net 3/7] lan78xx: Check for supported Wake-on-LAN modes
Date:   Mon, 24 Sep 2018 13:54:16 -0700
Message-Id: <20180924205420.31309-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924205420.31309-1-f.fainelli@gmail.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver supports a fair amount of Wake-on-LAN modes, but is not
checking that the user specified one that is supported.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/lan78xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a9991c5f4736..e0a588d1b8e6 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1415,6 +1415,9 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	if (wol->wolopts & WAKE_ARP)
 		pdata->wol |= WAKE_ARP;
 
+	if (pdata->wol == 0)
+		return -EINVAL;
+
 	device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
 
 	phy_ethtool_set_wol(netdev->phydev, wol);
-- 
2.17.1

