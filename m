Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CC2C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984772086E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiyMGjAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984772086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeI2Fpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:45:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2Fp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:45:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so3666517wme.3;
        Fri, 28 Sep 2018 16:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TKgRBdcbaLjCLYFNNphXO7D7Dwz80ZmX3ouxX2MzgvY=;
        b=fiyMGjACH7SDcTB1+tZSz1L/V932cPSByVOm0f2zm8CTItuiNIkj4wf9QHAysl9AMi
         BRUwV0+aeBbx1IxlNpScSyvD7hhOvQgbl5X5cYTGRZ/QZsB1pZbIOVC8lMeJA1L0/YDT
         /6K8geMWbG6PHy+zdqyUwZ9oQOdyY2t06QMYYC31/utc7HNov3HwsPZeiEyjTx2AHPNz
         4a7do1UivlHnUstIO7wXhvdhxo6KmkWgMu4dTEQalAsEonjRYVtMb39y7+3R1PatJT+J
         CIl1g/K3Md7J/kIRxikemAhx9HX0Z8vIlRohaNIAOzaHhGXk8V/WEsRw79FSy193hByL
         pvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TKgRBdcbaLjCLYFNNphXO7D7Dwz80ZmX3ouxX2MzgvY=;
        b=CbWV7jAVHQ4W1nmVSyrn6KPj6G8vjbRxqKDX4gR8M7qzr2U8ODT8SRIhHHzt9jzoEz
         F0VHwrPfD/qij/4EKtVFT7HDcUtyhKqAu5oo++AwE8XgXQzYk3wXJNFlIU+7ftjlLWWe
         i/5QeRmNEjHSyLeBLZKjiOXIRVBXtEw7gLtiW+8SY5esWLm6wNHWEX+B5z7VQaHLY32I
         tBzZKYZPWeE/Y2hOKbsOOpZnM93WCvFC8KZyB2ymmxou8LxqohQJl2ayVMVlDdZUXzeQ
         ldKOLmh/xumcISqYBatMGvAOIio6XpZyKc5EnBSPRm4aagmEtZt8a99T4tCJHPyuZgSN
         j0Tg==
X-Gm-Message-State: ABuFfojO2HJH9YYZz8pZOJVYzor8V4IB9tAx+gtYAOnhAuLwmgDd7O3Q
        yziwKJnW5NQE7HUVQCaG7LH1SW0Y
X-Google-Smtp-Source: ACcGV61v4IEyTEZbBPwvjqt2GWiqrJr+dpLxY2/ZGphzfLHgKdZNncn7I5aKOhL1HllqGjzpNA0R8g==
X-Received: by 2002:a1c:d785:: with SMTP id o127-v6mr3036028wmg.67.1538176766877;
        Fri, 28 Sep 2018 16:19:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8590730wrb.95.2018.09.28.16.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:19:25 -0700 (PDT)
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
Subject: [PATCH net v2 4/7] sr9800: Check for supported Wake-on-LAN modes
Date:   Fri, 28 Sep 2018 16:18:53 -0700
Message-Id: <20180928231856.3587-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928231856.3587-1-f.fainelli@gmail.com>
References: <20180928231856.3587-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently silently accepts unsupported Wake-on-LAN modes
(other than WAKE_PHY or WAKE_MAGIC) without reporting that to the user,
which is confusing.

Fixes: 19a38d8e0aa3 ("USB2NET : SR9800 : One chip USB2.0 USB2NET SR9800 Device Driver Support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/sr9800.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 9277a0f228df..35f39f23d881 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -421,6 +421,9 @@ sr_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	struct usbnet *dev = netdev_priv(net);
 	u8 opt = 0;
 
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |= SR_MONITOR_LINK;
 	if (wolinfo->wolopts & WAKE_MAGIC)
-- 
2.17.1

