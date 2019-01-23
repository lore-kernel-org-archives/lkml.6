Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7B8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7852184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfAWP7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:59:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42239 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfAWP7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:59:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 10E58207B6; Wed, 23 Jan 2019 16:59:14 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 802CF209BC;
        Wed, 23 Jan 2019 16:58:55 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next 06/10] net: introduce a net_device_ops macsec helper
Date:   Wed, 23 Jan 2019 16:56:34 +0100
Message-Id: <20190123155638.13852-7-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123155638.13852-1-antoine.tenart@bootlin.com>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a net_device_ops MACsec helper to allow net device
drivers to implement a MACsec offloading solution.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 include/linux/netdevice.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e675ef97a426..ee2f40dca515 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -53,6 +53,10 @@
 #include <uapi/linux/pkt_cls.h>
 #include <linux/hashtable.h>
 
+#ifdef CONFIG_MACSEC
+#include <net/macsec.h>
+#endif
+
 struct netpoll_info;
 struct device;
 struct phy_device;
@@ -1441,6 +1445,10 @@ struct net_device_ops {
 						u32 flags);
 	int			(*ndo_xsk_async_xmit)(struct net_device *dev,
 						      u32 queue_id);
+#ifdef CONFIG_MACSEC
+	int			(*ndo_macsec)(struct net_device *dev,
+					      struct netdev_macsec *macsec);
+#endif
 };
 
 /**
-- 
2.20.1

