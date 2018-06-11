Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7vm7II6GHlsLNgAAmS7hNA
	; Mon, 11 Jun 2018 14:26:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4B1AF607A4; Mon, 11 Jun 2018 14:26:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r44GrTTN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4F3FD60541;
	Mon, 11 Jun 2018 14:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F3FD60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeFKO0t (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:26:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52231 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbeFKO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:26:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so15077867wmb.2;
        Mon, 11 Jun 2018 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zTW/DBbJ3gHtM9ZNHyoZCaZM4GEqELmo1LOZGvSn+g0=;
        b=r44GrTTNQI1hCyFMVl9++2wHmNaB02gn4Cxp5en5+XEHUuK3kEkZpqF8cNc3dUhFmE
         MYt2kVmyopj2Ju89mB5+H3ymUEMTO2u+QF5fUx4yqDXPs9AxHqyFZErYMzVPqKIpeCmT
         urup1aOzQZFmfbujJmVpnwVW+oiTtSveHNjh/CNGjqBYheJjggq1mHhBaVZySVegK9Er
         U7kQuzcGC3wi0EmKW/WNd+ZaGWEg6YLbU5E/bt3Yl1coCrPZp0x0gelPuXMwXY6hYXQP
         I1T02eXRoyg+1ijuVoaeC7Tvnm6YpIZo5r+p3skf3iwmxr/nd8tdhog1nxJiMgu4HVRk
         fTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zTW/DBbJ3gHtM9ZNHyoZCaZM4GEqELmo1LOZGvSn+g0=;
        b=riyRWzYrRv35PCFj0XLLWdLkPNePHntmZJgK98rTC9x/5VaPUGY2MUdht6HrNApRJY
         xe4Q4dh4cq1WjoAkSWjwDN1/vkWt6OVQz2UDW7znGuG0Kb/paz87ehymYDbI9Hypz4t9
         kx+DM5iXzORk2S4MP7r9yBjvkarrnHMttrxSaBaesDzfTZHQg3Uzqex4g8meNQibsayQ
         kik7An/EsXrvHysBFZY32GV+OZkxOmDATfwwiTUgQFEYm6kZP76V/jfhDej7GrmpWKzX
         A0CqnZmsowhi3hUDnpof8ePyjGi1W38nIOyVzrxY7hopECgQJVaS5GzCsMecxPYZJIvN
         E9zg==
X-Gm-Message-State: APt69E0gyFoNVgzk+zyrj6oeR7abxLuiDnSY352o8aTMtCh4bc5EP3/w
        wuXAJtMqiGLWN5wiN2NVif0=
X-Google-Smtp-Source: ADUXVKKeSV3Xg8Pab92D70hbqYp4ssCbXwUPOp46M7mVYQTXSPtZwSon2QxceVrszZykRKEIdmntbQ==
X-Received: by 2002:a1c:f45:: with SMTP id 66-v6mr8373529wmp.124.1528727203688;
        Mon, 11 Jun 2018 07:26:43 -0700 (PDT)
Received: from localhost.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id r2-v6sm26090832wrq.55.2018.06.11.07.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 07:26:42 -0700 (PDT)
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: davem@davemloft.net
Cc: tobin@apporbit.com, Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 3/6] arcnet: com20020: Add com20020 io mapped version
Date: Mon, 11 Jun 2018 16:26:34 +0200
Message-Id: <20180611142635.20712-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

Add support for com20022I/com20020, io mapped.

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 drivers/net/arcnet/Kconfig       |   9 +-
 drivers/net/arcnet/Makefile      |   1 +
 drivers/net/arcnet/com20020-io.c | 315 +++++++++++++++++++++++++++++++++++++++
 drivers/net/arcnet/com20020.c    |   5 +-
 4 files changed, 327 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/arcnet/com20020-io.c

diff --git a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
index afc5898e7a16..f72620dc63ec 100644
--- a/drivers/net/arcnet/Kconfig
+++ b/drivers/net/arcnet/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig ARCNET
-	depends on NETDEVICES && (ISA || PCI || PCMCIA)
+	depends on NETDEVICES
 	tristate "ARCnet support"
 	---help---
 	  If you have a network card of this type, say Y and check out the
@@ -129,5 +129,12 @@ config ARCNET_COM20020_CS
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called com20020_cs.  If unsure, say N.
+config ARCNET_COM20020_IO
+	tristate "Support for COM20020 (IO mapped)"
+	depends on ARCNET_COM20020
+	help
+	  Say Y here if your custom board mount com20020 chipset or friends.
+	  Supported Chipset: com20020, com20022, com20022I-3v3
+	  If unsure, say N.
 
 endif # ARCNET
diff --git a/drivers/net/arcnet/Makefile b/drivers/net/arcnet/Makefile
index 53525e8ea130..18da4341f404 100644
--- a/drivers/net/arcnet/Makefile
+++ b/drivers/net/arcnet/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_ARCNET_COM20020) += com20020.o
 obj-$(CONFIG_ARCNET_COM20020_ISA) += com20020-isa.o
 obj-$(CONFIG_ARCNET_COM20020_PCI) += com20020-pci.o
 obj-$(CONFIG_ARCNET_COM20020_CS) += com20020_cs.o
+obj-$(CONFIG_ARCNET_COM20020_IO) += com20020-io.o
diff --git a/drivers/net/arcnet/com20020-io.c b/drivers/net/arcnet/com20020-io.c
new file mode 100644
index 000000000000..23c24d4de5a9
--- /dev/null
+++ b/drivers/net/arcnet/com20020-io.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Linux ARCnet driver for com 20020.
+ *
+ * datasheet:
+ * http://ww1.microchip.com/downloads/en/DeviceDoc/200223vrevc.pdf
+ * http://ww1.microchip.com/downloads/en/DeviceDoc/20020.pdf
+ *
+ * Supported chip version:
+ * - com20020
+ * - com20022
+ * - com20022I-3v3
+ */
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+#include <linux/netdevice.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/sizes.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include "arcdevice.h"
+#include "com20020.h"
+
+/* Reset (5 * xTalFreq), minimal com20020 xTal is 10Mhz */
+#define RESET_DELAY 500
+
+static unsigned int io_arc_inb(int addr, int offset)
+{
+	return ioread8((void *__iomem) addr + offset);
+}
+
+static void io_arc_outb(int value, int addr, int offset)
+{
+	iowrite8(value, (void *__iomem)addr + offset);
+}
+
+static void io_arc_insb(int  addr, int offset, void *buffer, int count)
+{
+	ioread8_rep((void *__iomem) (addr + offset), buffer, count);
+}
+
+static void io_arc_outsb(int addr, int offset, void *buffer, int count)
+{
+	iowrite8_rep((void *__iomem) (addr + offset), buffer, count);
+}
+
+enum com20020_xtal_freq {
+	freq_10Mhz = 10,
+	freq_20Mhz = 20,
+};
+
+enum com20020_arcnet_speed {
+	arc_speed_10M_bps = 10000000,
+	arc_speed_5M_bps = 5000000,
+	arc_speed_2M50_bps = 2500000,
+	arc_speed_1M25_bps = 1250000,
+	arc_speed_625K_bps = 625000,
+	arc_speed_312K5_bps = 312500,
+	arc_speed_156K25_bps = 156250,
+};
+
+enum com20020_timeout {
+	arc_timeout_328us =   328000,
+	arc_timeout_164us = 164000,
+	arc_timeout_82us =  82000,
+	arc_timeout_20u5s =  20500,
+};
+
+static int setup_clock(int *clockp, int *clockm, int xtal, int arcnet_speed)
+{
+	int pll_factor, req_clock_frq = 20;
+
+	switch (arcnet_speed) {
+	case arc_speed_10M_bps:
+		req_clock_frq = 80;
+		*clockp = 0;
+		break;
+	case arc_speed_5M_bps:
+		req_clock_frq = 40;
+		*clockp = 0;
+		break;
+	case arc_speed_2M50_bps:
+		*clockp = 0;
+		break;
+	case arc_speed_1M25_bps:
+		*clockp = 1;
+		break;
+	case arc_speed_625K_bps:
+		*clockp = 2;
+		break;
+	case arc_speed_312K5_bps:
+		*clockp = 3;
+		break;
+	case arc_speed_156K25_bps:
+		*clockp = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (xtal != freq_10Mhz && xtal != freq_20Mhz)
+		return -EINVAL;
+
+	pll_factor = (unsigned int)req_clock_frq / xtal;
+
+	switch (pll_factor) {
+	case 1:
+		*clockm = 0;
+		break;
+	case 2:
+		*clockm = 1;
+		break;
+	case 4:
+		*clockm = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int setup_timeout(int *timeout)
+{
+	switch (*timeout) {
+	case arc_timeout_328us:
+		*timeout = 0;
+		break;
+	case arc_timeout_164us:
+		*timeout = 1;
+		break;
+	case arc_timeout_82us:
+		*timeout = 2;
+		break;
+	case arc_timeout_20u5s:
+		*timeout = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int com20020_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	struct net_device *dev;
+	struct arcnet_local *lp;
+	struct resource res, *iores;
+	int ret, phy_reset;
+	u32 timeout, xtal, arc_speed;
+	int clockp, clockm;
+	bool backplane = false;
+	int ioaddr;
+
+	np = pdev->dev.of_node;
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "timeout-ns", &timeout);
+	if (ret) {
+		dev_err(&pdev->dev, "timeout is required param");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "smsc,xtal-mhz", &xtal);
+	if (ret) {
+		dev_err(&pdev->dev, "xtal-mhz is required param");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "bus-speed-bps", &arc_speed);
+	if (ret) {
+		dev_err(&pdev->dev, "Bus speed is required param");
+		return ret;
+	}
+
+	if (of_property_read_bool(np, "smsc,backplane-enabled"))
+		backplane = true;
+
+	phy_reset = of_get_named_gpio(np, "reset-gpios", 0);
+	if (!gpio_is_valid(phy_reset)) {
+		dev_err(&pdev->dev, "reset gpio not valid");
+		return phy_reset;
+	}
+
+	ret = devm_gpio_request_one(&pdev->dev, phy_reset, GPIOF_OUT_INIT_LOW,
+				    "arcnet-reset");
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get phy reset gpio: %d\n", ret);
+		return ret;
+	}
+
+	dev = alloc_arcdev(NULL);
+	dev->netdev_ops = &com20020_netdev_ops;
+	lp = netdev_priv(dev);
+
+	lp->card_flags = ARC_CAN_10MBIT;
+
+	/* Peak random address,
+	 * if required user could set a new-one in userspace
+	 */
+	get_random_bytes(dev->dev_addr, dev->addr_len);
+
+	if (!devm_request_mem_region(&pdev->dev, res.start, resource_size(&res),
+				     lp->card_name))
+		return -EBUSY;
+
+	ioaddr = (int)devm_ioremap(&pdev->dev, iores->start,
+				 resource_size(iores));
+	if (!ioaddr) {
+		dev_err(&pdev->dev, "ioremap fallied\n");
+		return -ENOMEM;
+	}
+
+	gpio_set_value_cansleep(phy_reset, 0);
+	ndelay(RESET_DELAY);
+	gpio_set_value_cansleep(phy_reset, 1);
+
+	lp->hw.arc_inb = io_arc_inb;
+	lp->hw.arc_outb = io_arc_outb;
+	lp->hw.arc_insb = io_arc_insb;
+	lp->hw.arc_outsb = io_arc_outsb;
+
+	/* ARCNET controller needs this access to detect bustype */
+	lp->hw.arc_outb(0x00, ioaddr, COM20020_REG_W_COMMAND);
+	lp->hw.arc_inb(ioaddr, COM20020_REG_R_DIAGSTAT);
+
+	dev->base_addr = (unsigned long)ioaddr;
+
+	dev->irq = of_get_named_gpio(np, "interrupts", 0);
+	if (dev->irq == -EPROBE_DEFER) {
+		return dev->irq;
+	} else if (!gpio_is_valid(dev->irq)) {
+		dev_err(&pdev->dev, "irq-gpios not valid !");
+		return -EIO;
+	}
+	dev->irq = gpio_to_irq(dev->irq);
+
+	ret = setup_clock(&clockp, &clockm, xtal, arc_speed);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Impossible use oscillator:%dMhz and arcnet bus speed:%dKbps",
+			xtal, arc_speed / 1000);
+		return ret;
+	}
+
+	ret = setup_timeout(&timeout);
+	if (ret) {
+		dev_err(&pdev->dev, "Timeout:%d is not valid value", timeout);
+		return ret;
+	}
+
+	lp->backplane = (int)backplane;
+	lp->timeout = timeout;
+	lp->clockm = clockm;
+	lp->clockp = clockp;
+	lp->hw.owner = THIS_MODULE;
+
+	if (lp->hw.arc_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
+		ret = -EIO;
+		goto err_release_mem;
+	}
+
+	if (com20020_check(dev)) {
+		ret = -EIO;
+		goto err_release_mem;
+	}
+
+	ret = com20020_found(dev, IRQF_TRIGGER_FALLING);
+	if (ret)
+		goto err_release_mem;
+
+	dev_dbg(&pdev->dev, "probe Done\n");
+	return 0;
+
+err_release_mem:
+	devm_iounmap(&pdev->dev, (void __iomem *)ioaddr);
+	devm_release_mem_region(&pdev->dev, res.start, resource_size(&res));
+	dev_err(&pdev->dev, "probe failed!\n");
+	return ret;
+}
+
+static const struct of_device_id of_com20020_match[] = {
+	{ .compatible = "smsc,com20020",	},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, of_com20020_match);
+
+static struct platform_driver of_com20020_driver = {
+	.driver			= {
+		.name		= "com20020-memory-bus",
+		.of_match_table = of_com20020_match,
+	},
+	.probe			= com20020_probe,
+};
+
+static int com20020_init(void)
+{
+	return platform_driver_register(&of_com20020_driver);
+}
+late_initcall(com20020_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index cbcea7834378..8d979a66d8e9 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -43,7 +43,7 @@
 #include "com20020.h"
 
 static const char * const clockrates[] = {
-	"XXXXXXX", "XXXXXXXX", "XXXXXX", "2.5 Mb/s",
+	"10 Mb/s", "XXXXXXXX", "XXXXXX", "2.5 Mb/s",
 	"1.25Mb/s", "625 Kb/s", "312.5 Kb/s", "156.25 Kb/s",
 	"Reserved", "Reserved", "Reserved"
 };
@@ -429,7 +429,8 @@ static void com20020_set_mc_list(struct net_device *dev)
 
 #if defined(CONFIG_ARCNET_COM20020_PCI_MODULE) || \
     defined(CONFIG_ARCNET_COM20020_ISA_MODULE) || \
-    defined(CONFIG_ARCNET_COM20020_CS_MODULE)
+    defined(CONFIG_ARCNET_COM20020_CS_MODULE)  || \
+    defined(CONFIG_ARCNET_COM20020_IO)
 EXPORT_SYMBOL(com20020_check);
 EXPORT_SYMBOL(com20020_found);
 EXPORT_SYMBOL(com20020_netdev_ops);
-- 
2.14.4
