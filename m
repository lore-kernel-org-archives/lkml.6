Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hyyvBo6GHlvTNQAAmS7hNA
	; Mon, 11 Jun 2018 14:26:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0193C607A4; Mon, 11 Jun 2018 14:26:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNLpQIwl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B8DCE6074D;
	Mon, 11 Jun 2018 14:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8DCE6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeFKO0a (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:26:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36182 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeFKO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:26:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id v131-v6so16936872wma.1;
        Mon, 11 Jun 2018 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kyFM1DtSQIFl40hPHmuqVlP2Ivk0X2jRWWaE3JwM0P0=;
        b=kNLpQIwlSfo0YiY5QH1vbLZxkICNYxJCNv8AJVqpAsmZyIbsZJt2PUUFz83j6HPJBA
         ejbgaXplG2cixvPH/vB5YrOOAe0Jif9BMCwT9hVonIZ/t5bayM7wawOf186zFg6RlVAn
         IlwK+qQA+KAWovp6MrqDuyH+glVIKr4RwW19AUkiZ1QPQRtKfYQVxr2pAd3lNLnOLdQO
         3PBPdozLfBRz/BTgBGq0KjqVIYVvlSc5AUY2N4oXzfR19x3/KxhSXomoHxB7SfdXErix
         O8gndMhhH1GCDxD+n+DlH/5O/jXIPvenL58FiZM8K/DH0EFld0MwnG5pBCauftYQSUw3
         0UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kyFM1DtSQIFl40hPHmuqVlP2Ivk0X2jRWWaE3JwM0P0=;
        b=ncXR+oslo8nkZwNAWn/eqCUhhmWSgsQYuSXxc8gQJZOGfR+5IX7aI8HRW7u/ZcLqMB
         W3reoDN4M9jvE3orbysi62m7VetQ4WscJUulwuB2PH2zzu398lM2eg4ro8RDp6toaAZZ
         jPTmEiNoCIyWzx0x0yWXJMsITRIq5V4FHQDVXiROzmY0MJoTW52E51ZNv4EO87FCQkE6
         viHLp30qR+gITF92byn7RCWaZgrT5qQ3owTH3XoIHxiO0C/PtaroSSZkFuPk4+W+a0lM
         qstRBlloaagIso1Kmj00qjMuVveaWZBUns69Gz3y1poCMpSmweeKPCrOtLEtnlA5CML2
         KjYA==
X-Gm-Message-State: APt69E0XtMexpkynGBh5Fz/Mriw6H0E6vRelZnnhrElNclq1Gns3OCmA
        Vyyqo0VuFTUDUUgI9WNbOOM=
X-Google-Smtp-Source: ADUXVKLoOyrbrOzZCaswjiWQwe1dNo+jzJBcADb/a6+TB+mQyS2MfRo19TZFYa2HBYUlJdpfiw7M2w==
X-Received: by 2002:a1c:443:: with SMTP id 64-v6mr9139772wme.140.1528727183764;
        Mon, 11 Jun 2018 07:26:23 -0700 (PDT)
Received: from localhost.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id l41-v6sm80855518wre.87.2018.06.11.07.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 07:26:22 -0700 (PDT)
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: davem@davemloft.net
Cc: tobin@apporbit.com, Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arcnet: com20020: Add IO cb for configure rw
Date: Mon, 11 Jun 2018 16:26:15 +0200
Message-Id: <20180611142616.20582-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

Add IO callback. No logic change are intended.
Now every driver implementation could specify IO callback.
Default IO callback is provided.

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 drivers/net/arcnet/arcdevice.h    |   4 ++
 drivers/net/arcnet/com20020-isa.c |  21 ++++--
 drivers/net/arcnet/com20020-pci.c |  11 +++-
 drivers/net/arcnet/com20020.c     | 134 ++++++++++++++++++++++++--------------
 drivers/net/arcnet/com20020.h     |   9 ++-
 drivers/net/arcnet/com20020_cs.c  |  23 +++++--
 6 files changed, 134 insertions(+), 68 deletions(-)

diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index d09b2b46ab63..cb7afadac5f6 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -324,6 +324,10 @@ struct arcnet_local {
 		void (*close)(struct net_device *dev);
 		void (*datatrigger) (struct net_device * dev, int enable);
 		void (*recontrigger) (struct net_device * dev, int enable);
+		unsigned int (*arc_inb)(int addr, int offset);
+		void (*arc_outb)(int value, int addr, int offset);
+		void (*arc_insb)(int addr, int offset, void *buff, int cnt);
+		void (*arc_outsb)(int addr, int offset, void *buff, int cnt);
 
 		void (*copy_to_card)(struct net_device *dev, int bufnum,
 				     int offset, void *buf, int count);
diff --git a/drivers/net/arcnet/com20020-isa.c b/drivers/net/arcnet/com20020-isa.c
index 38fa60ddaf2e..757586de5d08 100644
--- a/drivers/net/arcnet/com20020-isa.c
+++ b/drivers/net/arcnet/com20020-isa.c
@@ -67,7 +67,7 @@ static int __init com20020isa_probe(struct net_device *dev)
 			   ioaddr, ioaddr + ARCNET_TOTAL_SIZE - 1);
 		return -ENXIO;
 	}
-	if (arcnet_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
+	if (lp->hw.arc_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
 		arc_printk(D_NORMAL, dev, "IO address %x empty\n", ioaddr);
 		err = -ENODEV;
 		goto out;
@@ -83,20 +83,21 @@ static int __init com20020isa_probe(struct net_device *dev)
 		 * we tell it to start receiving.
 		 */
 		arc_printk(D_INIT_REASONS, dev, "intmask was %02Xh\n",
-			   arcnet_inb(ioaddr, COM20020_REG_R_STATUS));
-		arcnet_outb(0, ioaddr, COM20020_REG_W_INTMASK);
+			   lp->hw.arc_inb(ioaddr, COM20020_REG_R_STATUS));
+		lp->hw.arc_outb(0, ioaddr, COM20020_REG_W_INTMASK);
 		airqmask = probe_irq_on();
-		arcnet_outb(NORXflag, ioaddr, COM20020_REG_W_INTMASK);
+		lp->hw.arc_outb(NORXflag, ioaddr, COM20020_REG_W_INTMASK);
 		udelay(1);
-		arcnet_outb(0, ioaddr, COM20020_REG_W_INTMASK);
+		lp->hw.arc_outb(0, ioaddr, COM20020_REG_W_INTMASK);
 		dev->irq = probe_irq_off(airqmask);
 
 		if ((int)dev->irq <= 0) {
 			arc_printk(D_INIT_REASONS, dev, "Autoprobe IRQ failed first time\n");
 			airqmask = probe_irq_on();
-			arcnet_outb(NORXflag, ioaddr, COM20020_REG_W_INTMASK);
+			lp->hw.arc_outb(NORXflag, ioaddr,
+					COM20020_REG_W_INTMASK);
 			udelay(5);
-			arcnet_outb(0, ioaddr, COM20020_REG_W_INTMASK);
+			lp->hw.arc_outb(0, ioaddr, COM20020_REG_W_INTMASK);
 			dev->irq = probe_irq_off(airqmask);
 			if ((int)dev->irq <= 0) {
 				arc_printk(D_NORMAL, dev, "Autoprobe IRQ failed.\n");
@@ -156,6 +157,12 @@ static int __init com20020_init(void)
 	dev->netdev_ops = &com20020_netdev_ops;
 
 	lp = netdev_priv(dev);
+
+	lp->hw.arc_inb = com20020_def_arc_inb;
+	lp->hw.arc_outb = com20020_def_arc_outb;
+	lp->hw.arc_insb = com20020_def_arc_insb;
+	lp->hw.arc_outsb = com20020_def_arc_outsb;
+
 	lp->backplane = backplane;
 	lp->clockp = clockp & 7;
 	lp->clockm = clockm & 3;
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index eb7f76753c9c..dcf12e5cf889 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -181,12 +181,17 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			goto out_port;
 		}
 
+		lp->hw.arc_inb = com20020_def_arc_inb;
+		lp->hw.arc_outb = com20020_def_arc_outb;
+		lp->hw.arc_insb = com20020_def_arc_insb;
+		lp->hw.arc_outsb = com20020_def_arc_outsb;
+
 		/* Dummy access after Reset
 		 * ARCNET controller needs
 		 * this access to detect bustype
 		 */
-		arcnet_outb(0x00, ioaddr, COM20020_REG_W_COMMAND);
-		arcnet_inb(ioaddr, COM20020_REG_R_DIAGSTAT);
+		lp->hw.arc_outb(0x00, ioaddr, COM20020_REG_W_COMMAND);
+		lp->hw.arc_inb(ioaddr, COM20020_REG_R_DIAGSTAT);
 
 		SET_NETDEV_DEV(dev, &pdev->dev);
 		dev->base_addr = ioaddr;
@@ -213,7 +218,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 
 		snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
 
-		if (arcnet_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
+		if (lp->hw.arc_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
 			pr_err("IO address %Xh is empty!\n", ioaddr);
 			ret = -EIO;
 			goto out_port;
diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index 78043a9c5981..cbcea7834378 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -59,44 +59,75 @@ static void com20020_copy_from_card(struct net_device *dev, int bufnum,
 static void com20020_set_mc_list(struct net_device *dev);
 static void com20020_close(struct net_device *);
 
+unsigned int com20020_def_arc_inb(int addr, int offset)
+{
+	return inb(addr + offset);
+}
+EXPORT_SYMBOL(com20020_def_arc_inb);
+
+void com20020_def_arc_outb(int value, int addr, int offset)
+{
+	outb(value, addr + offset);
+}
+EXPORT_SYMBOL(com20020_def_arc_outb);
+
+void com20020_def_arc_insb(int addr, int offset, void *buffer, int count)
+{
+	insb(addr + offset, buffer, count);
+}
+EXPORT_SYMBOL(com20020_def_arc_insb);
+
+void com20020_def_arc_outsb(int addr, int offset, void *buffer, int count)
+{
+	outsb(addr + offset, buffer, count);
+}
+EXPORT_SYMBOL(com20020_def_arc_outsb);
+
 static void com20020_copy_from_card(struct net_device *dev, int bufnum,
 				    int offset, void *buf, int count)
 {
-	int ioaddr = dev->base_addr, ofs = 512 * bufnum + offset;
+	int ioaddr = dev->base_addr;
+	int ofs = 512 * bufnum + offset;
+	struct arcnet_local *lp = netdev_priv(dev);
 
 	/* set up the address register */
-	arcnet_outb((ofs >> 8) | RDDATAflag | AUTOINCflag,
+	lp->hw.arc_outb((ofs >> 8) | RDDATAflag | AUTOINCflag,
 		    ioaddr, COM20020_REG_W_ADDR_HI);
-	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
+	lp->hw.arc_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
 	TIME(dev, "insb", count,
-	     arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	     lp->hw.arc_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
 }
 
 static void com20020_copy_to_card(struct net_device *dev, int bufnum,
 				  int offset, void *buf, int count)
 {
-	int ioaddr = dev->base_addr, ofs = 512 * bufnum + offset;
+	int ioaddr = dev->base_addr;
+	int ofs = 512 * bufnum + offset;
+	struct arcnet_local *lp = netdev_priv(dev);
 
 	/* set up the address register */
-	arcnet_outb((ofs >> 8) | AUTOINCflag, ioaddr, COM20020_REG_W_ADDR_HI);
-	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
+	lp->hw.arc_outb((ofs >> 8) | AUTOINCflag,
+			ioaddr, COM20020_REG_W_ADDR_HI);
+	lp->hw.arc_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
 	TIME(dev, "outsb", count,
-	     arcnet_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	     lp->hw.arc_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
 }
 
 /* Reset the card and check some basic stuff during the detection stage. */
 int com20020_check(struct net_device *dev)
 {
-	int ioaddr = dev->base_addr, status;
+	int ioaddr = dev->base_addr;
 	struct arcnet_local *lp = netdev_priv(dev);
+	int status;
 
-	arcnet_outb(XTOcfg(3) | RESETcfg, ioaddr, COM20020_REG_W_CONFIG);
+	lp->hw.arc_outb(XTOcfg(3) | RESETcfg, ioaddr,
+			COM20020_REG_W_CONFIG);
 	udelay(5);
-	arcnet_outb(XTOcfg(3), ioaddr, COM20020_REG_W_CONFIG);
+	lp->hw.arc_outb(XTOcfg(3), ioaddr, COM20020_REG_W_CONFIG);
 	mdelay(RESETtime);
 
 	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
@@ -107,23 +138,23 @@ int com20020_check(struct net_device *dev)
 	lp->setup = lp->setup | P1MODE;
 
 	com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
-	arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+	lp->hw.arc_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
 
 	if (lp->clockm != 0) {
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP2);
-		arcnet_outb(lp->setup2, ioaddr, COM20020_REG_W_XREG);
+		lp->hw.arc_outb(lp->setup2, ioaddr, COM20020_REG_W_XREG);
 
 		/* must now write the magic "restart operation" command */
 		mdelay(1);
-		arcnet_outb(STARTIOcmd, ioaddr, COM20020_REG_W_COMMAND);
+		lp->hw.arc_outb(STARTIOcmd, ioaddr, COM20020_REG_W_COMMAND);
 	}
 
 	lp->config = (lp->timeout << 3) | (lp->backplane << 2) | SUB_NODE;
 	/* set node ID to 0x42 (but transmitter is disabled, so it's okay) */
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
-	arcnet_outb(0x42, ioaddr, COM20020_REG_W_XREG);
+	lp->hw.arc_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	lp->hw.arc_outb(0x42, ioaddr, COM20020_REG_W_XREG);
 
-	status = arcnet_inb(ioaddr, COM20020_REG_R_STATUS);
+	status = lp->hw.arc_inb(ioaddr, COM20020_REG_R_STATUS);
 
 	if ((status & 0x99) != (NORXflag | TXFREEflag | RESETflag)) {
 		arc_printk(D_NORMAL, dev, "status invalid (%Xh).\n", status);
@@ -131,18 +162,18 @@ int com20020_check(struct net_device *dev)
 	}
 	arc_printk(D_INIT_REASONS, dev, "status after reset: %X\n", status);
 
-	arcnet_outb(CFLAGScmd | RESETclear | CONFIGclear,
+	lp->hw.arc_outb(CFLAGScmd | RESETclear | CONFIGclear,
 		    ioaddr, COM20020_REG_W_COMMAND);
-	status = arcnet_inb(ioaddr, COM20020_REG_R_STATUS);
+	status = lp->hw.arc_inb(ioaddr, COM20020_REG_R_STATUS);
 	arc_printk(D_INIT_REASONS, dev, "status after reset acknowledged: %X\n",
 		   status);
 
 	/* Read first location of memory */
-	arcnet_outb(0 | RDDATAflag | AUTOINCflag,
+	lp->hw.arc_outb(0 | RDDATAflag | AUTOINCflag,
 		    ioaddr, COM20020_REG_W_ADDR_HI);
-	arcnet_outb(0, ioaddr, COM20020_REG_W_ADDR_LO);
+	lp->hw.arc_outb(0, ioaddr, COM20020_REG_W_ADDR_LO);
 
-	status = arcnet_inb(ioaddr, COM20020_REG_RW_MEMDATA);
+	status = lp->hw.arc_inb(ioaddr, COM20020_REG_RW_MEMDATA);
 	if (status != TESTvalue) {
 		arc_printk(D_NORMAL, dev, "Signature byte not found (%02Xh != D1h).\n",
 			   status);
@@ -159,7 +190,7 @@ static int com20020_set_hwaddr(struct net_device *dev, void *addr)
 
 	memcpy(dev->dev_addr, hwaddr->sa_data, 1);
 	com20020_set_subaddress(lp, ioaddr, SUB_NODE);
-	arcnet_outb(dev->dev_addr[0], ioaddr, COM20020_REG_W_XREG);
+	lp->hw.arc_outb(dev->dev_addr[0], ioaddr, COM20020_REG_W_XREG);
 
 	return 0;
 }
@@ -170,7 +201,7 @@ static int com20020_netdev_open(struct net_device *dev)
 	struct arcnet_local *lp = netdev_priv(dev);
 
 	lp->config |= TXENcfg;
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	lp->hw.arc_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 
 	return arcnet_open(dev);
 }
@@ -184,7 +215,7 @@ static int com20020_netdev_close(struct net_device *dev)
 
 	/* disable transmitter */
 	lp->config &= ~TXENcfg;
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	lp->hw.arc_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 	return 0;
 }
 
@@ -203,6 +234,7 @@ const struct net_device_ops com20020_netdev_ops = {
 int com20020_found(struct net_device *dev, int shared)
 {
 	struct arcnet_local *lp;
+
 	int ioaddr = dev->base_addr;
 
 	/* Initialize the rest of the device structure. */
@@ -220,24 +252,24 @@ int com20020_found(struct net_device *dev, int shared)
 
 	/* FIXME: do this some other way! */
 	if (!dev->dev_addr[0])
-		dev->dev_addr[0] = arcnet_inb(ioaddr, 8);
+		dev->dev_addr[0] = lp->hw.arc_inb(ioaddr, 8);
 
 	com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
-	arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+	lp->hw.arc_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
 
 	if (lp->card_flags & ARC_CAN_10MBIT) {
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP2);
-		arcnet_outb(lp->setup2, ioaddr, COM20020_REG_W_XREG);
+		lp->hw.arc_outb(lp->setup2, ioaddr, COM20020_REG_W_XREG);
 
 		/* must now write the magic "restart operation" command */
 		mdelay(1);
-		arcnet_outb(STARTIOcmd, ioaddr, COM20020_REG_W_COMMAND);
+		lp->hw.arc_outb(STARTIOcmd, ioaddr, COM20020_REG_W_COMMAND);
 	}
 
 	lp->config = (lp->timeout << 3) | (lp->backplane << 2) | SUB_NODE;
 	/* Default 0x38 + register: Node ID */
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
-	arcnet_outb(dev->dev_addr[0], ioaddr, COM20020_REG_W_XREG);
+	lp->hw.arc_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	lp->hw.arc_outb(dev->dev_addr[0], ioaddr, COM20020_REG_W_XREG);
 
 	/* reserve the irq */
 	if (request_irq(dev->irq, arcnet_interrupt, shared,
@@ -282,31 +314,32 @@ int com20020_found(struct net_device *dev, int shared)
 static int com20020_reset(struct net_device *dev, int really_reset)
 {
 	struct arcnet_local *lp = netdev_priv(dev);
-	u_int ioaddr = dev->base_addr;
+	int  ioaddr = dev->base_addr;
 	u_char inbyte;
 
 	arc_printk(D_DEBUG, dev, "%s: %d: %s: dev: %p, lp: %p, dev->name: %s\n",
 		   __FILE__, __LINE__, __func__, dev, lp, dev->name);
 	arc_printk(D_INIT, dev, "Resetting %s (status=%02Xh)\n",
-		   dev->name, arcnet_inb(ioaddr, COM20020_REG_R_STATUS));
+		   dev->name, lp->hw.arc_inb(ioaddr, COM20020_REG_R_STATUS));
 
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
 	lp->config |= (lp->timeout << 3) | (lp->backplane << 2);
 	/* power-up defaults */
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	lp->hw.arc_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
 
 	if (really_reset) {
 		/* reset the card */
-		arcnet_outb(lp->config | RESETcfg, ioaddr, COM20020_REG_W_CONFIG);
+		lp->hw.arc_outb(lp->config | RESETcfg, ioaddr,
+				COM20020_REG_W_CONFIG);
 		udelay(5);
-		arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+		lp->hw.arc_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 		mdelay(RESETtime * 2);
 				/* COM20020 seems to be slower sometimes */
 	}
 	/* clear flags & end reset */
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
-	arcnet_outb(CFLAGScmd | RESETclear | CONFIGclear,
+	lp->hw.arc_outb(CFLAGScmd | RESETclear | CONFIGclear,
 		    ioaddr, COM20020_REG_W_COMMAND);
 
 	/* verify that the ARCnet signature byte is present */
@@ -321,7 +354,7 @@ static int com20020_reset(struct net_device *dev, int really_reset)
 		return 1;
 	}
 	/* enable extended (512-byte) packets */
-	arcnet_outb(CONFIGcmd | EXTconf, ioaddr, COM20020_REG_W_COMMAND);
+	lp->hw.arc_outb(CONFIGcmd | EXTconf, ioaddr, COM20020_REG_W_COMMAND);
 
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
 
@@ -331,35 +364,38 @@ static int com20020_reset(struct net_device *dev, int really_reset)
 
 static void com20020_setmask(struct net_device *dev, int mask)
 {
-	u_int ioaddr = dev->base_addr;
+	int ioaddr = dev->base_addr;
+	struct arcnet_local *lp = netdev_priv(dev);
 
 	arc_printk(D_DURING, dev, "Setting mask to %x at %x\n", mask, ioaddr);
-	arcnet_outb(mask, ioaddr, COM20020_REG_W_INTMASK);
+	lp->hw.arc_outb(mask, ioaddr, COM20020_REG_W_INTMASK);
 }
 
 static void com20020_command(struct net_device *dev, int cmd)
 {
-	u_int ioaddr = dev->base_addr;
+	int ioaddr = dev->base_addr;
+	struct arcnet_local *lp = netdev_priv(dev);
 
-	arcnet_outb(cmd, ioaddr, COM20020_REG_W_COMMAND);
+	lp->hw.arc_outb(cmd, ioaddr, COM20020_REG_W_COMMAND);
 }
 
 static int com20020_status(struct net_device *dev)
 {
-	u_int ioaddr = dev->base_addr;
+	int ioaddr = dev->base_addr;
+	struct arcnet_local *lp = netdev_priv(dev);
 
-	return arcnet_inb(ioaddr, COM20020_REG_R_STATUS) +
-		(arcnet_inb(ioaddr, COM20020_REG_R_DIAGSTAT) << 8);
+	return lp->hw.arc_inb(ioaddr, COM20020_REG_R_STATUS) +
+		(lp->hw.arc_inb(ioaddr, COM20020_REG_R_DIAGSTAT) << 8);
 }
 
 static void com20020_close(struct net_device *dev)
 {
-	struct arcnet_local *lp = netdev_priv(dev);
 	int ioaddr = dev->base_addr;
+	struct arcnet_local *lp = netdev_priv(dev);
 
 	/* disable transmitter */
 	lp->config &= ~TXENcfg;
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	lp->hw.arc_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 }
 
 /* Set or clear the multicast filter for this adaptor.
@@ -380,14 +416,14 @@ static void com20020_set_mc_list(struct net_device *dev)
 			arc_printk(D_NORMAL, dev, "Setting promiscuous flag...\n");
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
 		lp->setup |= PROMISCset;
-		arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+		lp->hw.arc_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
 	} else {
 		/* Disable promiscuous mode, use normal mode */
 		if ((lp->setup & PROMISCset))
 			arc_printk(D_NORMAL, dev, "Resetting promiscuous flag...\n");
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
 		lp->setup &= ~PROMISCset;
-		arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+		lp->hw.arc_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
 	}
 }
 
diff --git a/drivers/net/arcnet/com20020.h b/drivers/net/arcnet/com20020.h
index 0bcc5d0a6903..af18c7edc4fa 100644
--- a/drivers/net/arcnet/com20020.h
+++ b/drivers/net/arcnet/com20020.h
@@ -118,14 +118,19 @@ struct com20020_dev {
 #define SUB_BUSCTL	5	/* bus control options */
 #define SUB_DMACOUNT	6	/* DMA count options */
 
+unsigned int com20020_def_arc_inb(int addr, int offset);
+void com20020_def_arc_outb(int value, int addr, int offset);
+void com20020_def_arc_insb(int addr, int offset, void *buffer, int count);
+void com20020_def_arc_outsb(int addr, int offset, void *buffer, int count);
+
 static inline void com20020_set_subaddress(struct arcnet_local *lp,
 					   int ioaddr, int val)
 {
 	if (val < 4) {
 		lp->config = (lp->config & ~0x03) | val;
-		arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+		lp->hw.arc_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 	} else {
-		arcnet_outb(val, ioaddr, COM20020_REG_W_SUBADR);
+		lp->hw.arc_outb(val, ioaddr, COM20020_REG_W_SUBADR);
 	}
 }
 
diff --git a/drivers/net/arcnet/com20020_cs.c b/drivers/net/arcnet/com20020_cs.c
index cf607ffcf358..bca4e6c15e4f 100644
--- a/drivers/net/arcnet/com20020_cs.c
+++ b/drivers/net/arcnet/com20020_cs.c
@@ -53,29 +53,31 @@ static void regdump(struct net_device *dev)
 {
 #ifdef DEBUG
 	int ioaddr = dev->base_addr;
+	struct arcnet_local *lp = netdev_priv(dev);
 	int count;
 
 	netdev_dbg(dev, "register dump:\n");
 	for (count = 0; count < 16; count++) {
 		if (!(count % 16))
 			pr_cont("%04X:", ioaddr + count);
-		pr_cont(" %02X", arcnet_inb(ioaddr, count));
+		pr_cont(" %02X", lp->hw.arc_inb(ioaddr, count));
 	}
 	pr_cont("\n");
 
 	netdev_dbg(dev, "buffer0 dump:\n");
 	/* set up the address register */
 	count = 0;
-	arcnet_outb((count >> 8) | RDDATAflag | AUTOINCflag,
-		    ioaddr, com20020_REG_W_ADDR_HI);
-	arcnet_outb(count & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
+	lp->hw.arc_outb((count >> 8) | RDDATAflag | AUTOINCflag,
+			ioaddr, com20020_REG_W_ADDR_HI);
+	lp->hw.arc_outb(count & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
 
 	for (count = 0; count < 256 + 32; count++) {
 		if (!(count % 16))
 			pr_cont("%04X:", count);
 
 		/* copy the data */
-		pr_cont(" %02X", arcnet_inb(ioaddr, COM20020_REG_RW_MEMDATA));
+		pr_cont(" %02X", lp->hw.arc_inb(ioaddr,
+						COM20020_REG_RW_MEMDATA));
 	}
 	pr_cont("\n");
 #endif
@@ -126,6 +128,12 @@ static int com20020_probe(struct pcmcia_device *p_dev)
 		goto fail_alloc_dev;
 
 	lp = netdev_priv(dev);
+
+	lp->hw.arc_inb = com20020_def_arc_inb;
+	lp->hw.arc_outb = com20020_def_arc_outb;
+	lp->hw.arc_insb = com20020_def_arc_insb;
+	lp->hw.arc_outsb = com20020_def_arc_outsb;
+
 	lp->timeout = timeout;
 	lp->backplane = backplane;
 	lp->clockp = clockp;
@@ -293,9 +301,10 @@ static int com20020_resume(struct pcmcia_device *link)
 		int ioaddr = dev->base_addr;
 		struct arcnet_local *lp = netdev_priv(dev);
 
-		arcnet_outb(lp->config | 0x80, ioaddr, COM20020_REG_W_CONFIG);
+		lp->hw.arc_outb(lp->config | 0x80, ioaddr,
+				COM20020_REG_W_CONFIG);
 		udelay(5);
-		arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+		lp->hw.arc_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 	}
 
 	return 0;
-- 
2.14.4
