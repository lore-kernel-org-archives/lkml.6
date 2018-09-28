Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C2BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2515A206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnlzDIGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2515A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeI2FpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:45:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50548 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2FpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:45:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so3683982wmc.0;
        Fri, 28 Sep 2018 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4RYTqH0+Cakyvsu2OEu5e9Sb/xNwG7fIaEa14Pt55MU=;
        b=GnlzDIGYCE//BEkyYe4CeB+EgCz/AAWc97vG9M0kzdrHNxu75vqL9R8zkdP9WZu19v
         j4G0akkkxYTsM/1Fsp6nkeVB3WVEB0P0pt4QGzK/bb+y/7+n4NkwfsPYc2TGtIhB0r+z
         LJLlaCnzlguS0r08zoeMfkg93C6nazxzKWzEVRivlf1+Q9iYJW0VPiY9d1LYevsmdrne
         7LbqdC4nAH90gJCWfIfYW9XfW0P15vQ/IZhoWVz+jiZO3yT3g66WQm4D1XIH/DFsym6j
         eg2MQY0/7FfqLsOr+5HA3zVK7UG3YnUKtvGQyMFjZi4XOEkOXeWuMmEO9T5dYxrQQPY3
         VUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4RYTqH0+Cakyvsu2OEu5e9Sb/xNwG7fIaEa14Pt55MU=;
        b=HL7yGYLQxGzvz5alralHKvC1xuMGVRgJ+LK2w/ZY2G0tG1GaXefyB7WUeSV1Oi5nwc
         VgQVMQEKa0U7KbcQ97kDOpOSvboU0dNV4GiBcKqqKrFnkM3xFQc0Iy/lYziaecadDW4B
         8rG704WOCAsw2Q8uvPAM3qp2NMbLomX4HjSJwit/OAZQaxqUCEDU02fRmq9BE24BH87r
         9gLUVCHPeDbE8+V2T3TMI42zpFLqFs1WK1I3OaFHFMQlr9qkm56yO9bdCsWhjb4Q2p5E
         su+zcdNQewe1AGiK22Yg14fqAHCnmEROijF1waJAmdD8rAXJmyz0gn3/+Wc2rmbk9nht
         mDqg==
X-Gm-Message-State: ABuFfohk+DNeOlIn31zOQ+VzsjgqRzNVcpDtIaqIQdHpdjwIL1XqyZjg
        Y/elxp7afAnc2+6Eh2koIYup0yRr
X-Google-Smtp-Source: ACcGV624f5QkKGHEKC4c+xYlf7ZNkkIwwIteX/Gcua6T9deTj1RVm0O01ilqvPcm35gb80N3ecZ1Ig==
X-Received: by 2002:a1c:7212:: with SMTP id n18-v6mr3253483wmc.33.1538176758505;
        Fri, 28 Sep 2018 16:19:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8590730wrb.95.2018.09.28.16.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:19:17 -0700 (PDT)
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
Subject: [PATCH net v2 2/7] ax88179_178a: Check for supported Wake-on-LAN modes
Date:   Fri, 28 Sep 2018 16:18:51 -0700
Message-Id: <20180928231856.3587-3-f.fainelli@gmail.com>
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

Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/ax88179_178a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 9e8ad372f419..2207f7a7d1ff 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -566,6 +566,9 @@ ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	struct usbnet *dev = netdev_priv(net);
 	u8 opt = 0;
 
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |= AX_MONITOR_MODE_RWLC;
 	if (wolinfo->wolopts & WAKE_MAGIC)
-- 
2.17.1

