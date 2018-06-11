Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dEh2JfCGHlsDOQAAmS7hNA
	; Mon, 11 Jun 2018 14:28:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F290F607A4; Mon, 11 Jun 2018 14:28:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuAoZMdT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 541226074D;
	Mon, 11 Jun 2018 14:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 541226074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934735AbeFKO2N (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:28:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33668 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932897AbeFKO2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:28:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id k16-v6so20656835wro.0;
        Mon, 11 Jun 2018 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q9FUkW40Fi9qLDqkJ5Y4h8RkYEK+y+2ytHxz8OryQHI=;
        b=AuAoZMdTyCgdSWMjDlhSI8klWeQ5hmYPlFNpr7jytdqHVcfCtgfENCmmo77SsnsqRd
         dtOJW80g2ft3eWAxVbM5GLZsSW2uexMQmuNqFS1Ihg3yXPKCDiHyTCnJI1DNWUhDZsW9
         Abf0OCkGZoH8Xw4EorS6E/8cej3VFpuqjt2oWoReezjZRW2bcrNs9ZbFaEGVNLmtHoEy
         vrN9GHJztVhGvMxCm0W6j2Ct+SNsB7URYIMnVCLxDAoqw0O6nR8+FkUQy86RetTbkiDj
         hYeeqB497ig0qfYYHFc0a1aqh6pdW9V4iMt7lm1hjWawLgtEDmSpIuraciviNmXBDmcr
         4Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q9FUkW40Fi9qLDqkJ5Y4h8RkYEK+y+2ytHxz8OryQHI=;
        b=OeOEUYnvirB+ZU0katldxp8WqU2/KtWnrdDCsMoR+ehOdA2U7+sTlWz1qhJToPFZEK
         WTdpYCdHGHMeszqTIKKIcylv5L6xyVEB1ihJ2sKQRkOb9RMORcsiu8/UrgnEXuNHOuvZ
         c3OU9NS46tZbSAoXCIqRJztYRrNJCkLLY0pn0SOgoN1xAwb7HEOOYoA3huK6VupcHUHr
         HzC1Qasuv9R70ajMB0D+bPHrtRP5G0FhPjhAPiPmGFB/iLWg4KxyzQK/Et3foELcn3Xy
         25lSaYRX/bAbashQLpX5yZFzyt1+1OoMEzflE5VwInccuXSURIxdghtspk7vEeTpUnp1
         E83Q==
X-Gm-Message-State: APt69E1x26z2UmZP2kUNTN6atiKcV3lwM5zg+YEWN0RhcI1JwdBsKvJU
        4r/An0d8Jm7DG96+iuHk7218HpNW
X-Google-Smtp-Source: ADUXVKJkg321ulABB1Ht4pXdy9SOLHtyqQBXD+29N0PFX6k9L+1FF63vvWCUym8kYrHnuzg8rSyrmw==
X-Received: by 2002:adf:93c6:: with SMTP id 64-v6mr13023744wrp.119.1528727284101;
        Mon, 11 Jun 2018 07:28:04 -0700 (PDT)
Received: from localhost.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id 194-v6sm12292432wml.20.2018.06.11.07.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 07:28:02 -0700 (PDT)
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: davem@davemloft.net
Cc: tobin@apporbit.com, Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arcnet: com20020: Add ethtool support
Date: Mon, 11 Jun 2018 16:27:56 +0200
Message-Id: <20180611142756.21114-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

Setup ethtols for export com20020 diag register

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 drivers/net/arcnet/com20020-io.c  |  1 +
 drivers/net/arcnet/com20020-isa.c |  1 +
 drivers/net/arcnet/com20020.c     | 24 ++++++++++++++++++++++++
 drivers/net/arcnet/com20020.h     |  1 +
 drivers/net/arcnet/com20020_cs.c  |  1 +
 include/uapi/linux/if_arcnet.h    |  6 ++++++
 6 files changed, 34 insertions(+)

diff --git a/drivers/net/arcnet/com20020-io.c b/drivers/net/arcnet/com20020-io.c
index 23c24d4de5a9..9954d3a30ff6 100644
--- a/drivers/net/arcnet/com20020-io.c
+++ b/drivers/net/arcnet/com20020-io.c
@@ -203,6 +203,7 @@ static int com20020_probe(struct platform_device *pdev)
 
 	dev = alloc_arcdev(NULL);
 	dev->netdev_ops = &com20020_netdev_ops;
+	dev->ethtool_ops = &com20020_ethtool_ops;
 	lp = netdev_priv(dev);
 
 	lp->card_flags = ARC_CAN_10MBIT;
diff --git a/drivers/net/arcnet/com20020-isa.c b/drivers/net/arcnet/com20020-isa.c
index 757586de5d08..eba1bd82226c 100644
--- a/drivers/net/arcnet/com20020-isa.c
+++ b/drivers/net/arcnet/com20020-isa.c
@@ -155,6 +155,7 @@ static int __init com20020_init(void)
 		dev->dev_addr[0] = node;
 
 	dev->netdev_ops = &com20020_netdev_ops;
+	dev->ethtool_ops = &com20020_ethtool_ops;
 
 	lp = netdev_priv(dev);
 
diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index 1a0fd30fe8ae..60e5ae401b1b 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -232,6 +232,29 @@ const struct net_device_ops com20020_netdev_ops = {
 	.ndo_set_rx_mode = com20020_set_mc_list,
 };
 
+static int com20020_ethtool_regs_len(struct net_device *netdev)
+{
+	return sizeof(struct com20020_ethtool_regs);
+}
+
+static void com20020_ethtool_regs_read(struct net_device *dev,
+				       struct ethtool_regs *regs, void *p)
+{
+	struct arcnet_local *lp = netdev_priv(dev);
+	struct com20020_ethtool_regs *com_reg = p;
+
+	memset(p, 0, sizeof(struct com20020_ethtool_regs));
+
+	com_reg->status = lp->hw.status(dev) & 0xFF;
+	com_reg->diag_register = (lp->hw.status(dev) >> 8) & 0xFF;
+	com_reg->reconf_count = lp->num_recons;
+}
+
+const struct ethtool_ops com20020_ethtool_ops = {
+	.get_regs = com20020_ethtool_regs_read,
+	.get_regs_len  = com20020_ethtool_regs_len,
+};
+
 /* Set up the struct net_device associated with this card.  Called after
  * probing succeeds.
  */
@@ -438,6 +461,7 @@ static void com20020_set_mc_list(struct net_device *dev)
 EXPORT_SYMBOL(com20020_check);
 EXPORT_SYMBOL(com20020_found);
 EXPORT_SYMBOL(com20020_netdev_ops);
+EXPORT_SYMBOL(com20020_ethtool_ops);
 #endif
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/arcnet/com20020.h b/drivers/net/arcnet/com20020.h
index af18c7edc4fa..616f047b3661 100644
--- a/drivers/net/arcnet/com20020.h
+++ b/drivers/net/arcnet/com20020.h
@@ -31,6 +31,7 @@
 int com20020_check(struct net_device *dev);
 int com20020_found(struct net_device *dev, int shared);
 extern const struct net_device_ops com20020_netdev_ops;
+extern const struct ethtool_ops com20020_ethtool_ops;
 
 /* The number of low I/O ports used by the card. */
 #define ARCNET_TOTAL_SIZE 8
diff --git a/drivers/net/arcnet/com20020_cs.c b/drivers/net/arcnet/com20020_cs.c
index bca4e6c15e4f..127aff55794d 100644
--- a/drivers/net/arcnet/com20020_cs.c
+++ b/drivers/net/arcnet/com20020_cs.c
@@ -241,6 +241,7 @@ static int com20020_config(struct pcmcia_device *link)
 	}
 
 	dev->irq = link->irq;
+	dev->ethtool_ops = &com20020_ethtool_ops;
 
 	ret = pcmcia_enable_device(link);
 	if (ret)
diff --git a/include/uapi/linux/if_arcnet.h b/include/uapi/linux/if_arcnet.h
index 683878036d76..790c0fa7386d 100644
--- a/include/uapi/linux/if_arcnet.h
+++ b/include/uapi/linux/if_arcnet.h
@@ -127,4 +127,10 @@ struct archdr {
 	} soft;
 };
 
+struct com20020_ethtool_regs {
+	__u8 status;
+	__u8 diag_register;
+	__u32 reconf_count;
+};
+
 #endif				/* _LINUX_IF_ARCNET_H */
-- 
2.14.4
