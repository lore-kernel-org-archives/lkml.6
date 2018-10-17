Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C23ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE6221470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iACMOhXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE6221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJRG2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:28:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35766 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJRG2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:28:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so2015321pgu.2;
        Wed, 17 Oct 2018 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MrleH0HbAVlM9Z7cvXBULa7rKzCb+2ZKgMUNDdj5YIo=;
        b=iACMOhXbAtVWh5/eHjxwmUo6G/Zeabjnt2r96ojIBzi2z2qzQ9uphIZjmMY3ngR4BN
         t0p5x8WQni7XInlX1CC+jUo3WpSUCC8e/osxnTu560u90+znc+2uQ9oPRq0xrnNPlTRe
         vY1zlWe5K+9+sLvW/mD6gGrEEeQSG+vdrVQsaJHP4P8CiuQmNLiqz1N3DhCHEFh9uLKM
         TCPNWx60yOZjaNr/AMb9CzmpF7lvwoU0ja3NtEcFZSwx2AKqq+qWViYdhBK+D6q2db9H
         W12b+Bt1VL8g8+g5qEJ6qaZ17n321MU6PKxNFPUcmB/yubZYWMUPZ5J2rWrCHt/kqux5
         jntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MrleH0HbAVlM9Z7cvXBULa7rKzCb+2ZKgMUNDdj5YIo=;
        b=Jh6r6f7Bhl7iW0JhXodyxWkzFKM5ETjsTDFCKln8GaebloHcYUX9Gy3/X47Mg2tNH/
         fiZd+SbWdRZ+AhLX/Fle59HM08aKmcCvL7F4KfMNT2DZrZz+hNk3tB2Te/BpeqRd87Vo
         Oz+qCWYtqfmQRNlmGFavGhFWpH3g9PlnHsligBcgQHR00JSksI05fBz2G0ZCeZlxt+Z6
         d9613Gl80gLUV/xhr3tHfxcr1q76sK44vITRVjB9vXr3dbeUKTDMZz42VsxIElkTKPgk
         PD8aI49uVDO+piX33TE2t8shbwi0dtI6E+lBrhVZ9eYaLl1YP25ly9dGMv/3nEipAJ1O
         dt/g==
X-Gm-Message-State: ABuFfojCdxNNVuKI/5ILxvQnenpTXKN1UIWeXCZDtwL0tPbBIBArs/5W
        kwKRp+qpvShw0NNtOW/3IZr9BGGaFSM=
X-Google-Smtp-Source: ACcGV61AlgswqSeyq6RWpTG73PLZd3YFd21lUHq1LyD6Hq4KTCG46qdKXjGzw05nO4N2KK5Q8yL1RQ==
X-Received: by 2002:a63:e141:: with SMTP id h1-v6mr26133365pgk.47.1539815416952;
        Wed, 17 Oct 2018 15:30:16 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p3-v6sm352597pgl.2.2018.10.17.15.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:30:16 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH V2 5/6] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
Date:   Wed, 17 Oct 2018 18:29:08 -0400
Message-Id: <1539815349-24126-6-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
References: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
was created instead of adding support to the existing ehci platform
driver because of the code required to workaround bugs in the EHCI
controller.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/ehci-brcm.c | 291 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 291 insertions(+)
 create mode 100644 drivers/usb/host/ehci-brcm.c

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
new file mode 100644
index 000000000000..b2a100698bf5
--- /dev/null
+++ b/drivers/usb/host/ehci-brcm.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Broadcom */
+
+#include <linux/acpi.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ehci.h"
+
+#define BRCM_DRIVER_DESC "EHCI Broadcom STB driver"
+
+#define hcd_to_ehci_priv(h) ((struct brcm_priv *)hcd_to_ehci(h)->priv)
+
+struct brcm_priv {
+	struct clk *clk;
+};
+
+static const char brcm_hcd_name[] = "ehci-brcm";
+
+static int (*org_hub_control)(struct usb_hcd *hcd,
+			u16 typeReq, u16 wValue, u16 wIndex,
+			char *buf, u16 wLength);
+
+/* ehci_brcm_wait_for_sof
+ * Wait for start of next microframe, then wait extra delay microseconds
+ */
+static inline void ehci_brcm_wait_for_sof(struct ehci_hcd *ehci, u32 delay)
+{
+	int frame_idx = ehci_readl(ehci, &ehci->regs->frame_index);
+
+	while (frame_idx == ehci_readl(ehci, &ehci->regs->frame_index))
+		;
+	udelay(delay);
+}
+
+/*
+ * ehci_brcm_hub_control
+ * Intercept echi-hcd request to complete RESUME and align it to the start
+ * of the next microframe.
+ * If RESUME is complete too late in the microframe, host controller
+ * detects babble on suspended port and resets the port afterwards.
+ * This s/w workaround allows to avoid this problem.
+ * See SWLINUX-1909 for more details
+ */
+static int ehci_brcm_hub_control(
+	struct usb_hcd	*hcd,
+	u16		typeReq,
+	u16		wValue,
+	u16		wIndex,
+	char		*buf,
+	u16		wLength)
+{
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	int		ports = HCS_N_PORTS(ehci->hcs_params);
+	u32 __iomem	*status_reg = &ehci->regs->port_status[
+				(wIndex & 0xff) - 1];
+	unsigned long flags;
+	int retval, irq_disabled = 0;
+
+	/*
+	 * RESUME is cleared when GetPortStatus() is called 20ms after start
+	 * of RESUME
+	 */
+	if ((typeReq == GetPortStatus) &&
+	    (wIndex && wIndex <= ports) &&
+	    ehci->reset_done[wIndex-1] &&
+	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
+	    (ehci_readl(ehci, status_reg) & PORT_RESUME)) {
+
+		/*
+		 * to make sure we are not interrupted until RESUME bit
+		 * is cleared, disable interrupts on current CPU
+		 */
+		ehci_dbg(ehci, "SOF alignment workaround\n");
+		irq_disabled = 1;
+		local_irq_save(flags);
+		ehci_brcm_wait_for_sof(ehci, 5);
+	}
+	retval = (*org_hub_control)(hcd, typeReq, wValue, wIndex, buf, wLength);
+	if (irq_disabled)
+		local_irq_restore(flags);
+	return retval;
+}
+
+static int ehci_brcm_reset(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+	ehci->big_endian_mmio = 1;
+	hcd->suspend_without_phy_exit = 1;
+
+	ehci->caps = (struct ehci_caps *) hcd->regs;
+	ehci->regs = (struct ehci_regs *) (hcd->regs +
+		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase)));
+
+	/* This fixes the lockup during reboot due to prior interrupts */
+	ehci_writel(ehci, CMD_RESET, &ehci->regs->command);
+	mdelay(10);
+
+	/*
+	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
+	 *   bus usage
+	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
+	 */
+	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+
+	return ehci_setup(hcd);
+}
+
+static struct hc_driver __read_mostly ehci_brcm_hc_driver;
+
+static const struct ehci_driver_overrides brcm_overrides __initconst = {
+
+	.reset =	ehci_brcm_reset,
+	.extra_priv_size = sizeof(struct brcm_priv),
+};
+
+static int ehci_brcm_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res_mem;
+	struct brcm_priv *priv;
+	int irq;
+	int err;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (err)
+		return err;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq provided");
+		return irq;
+	}
+
+	/* Hook the hub control routine to work around a bug */
+	if (org_hub_control == NULL)
+		org_hub_control = ehci_brcm_hc_driver.hub_control;
+	ehci_brcm_hc_driver.hub_control = ehci_brcm_hub_control;
+
+	/* initialize hcd */
+	hcd = usb_create_hcd(&ehci_brcm_hc_driver,
+			&pdev->dev, dev_name(&pdev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hcd);
+	priv = hcd_to_ehci_priv(hcd);
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "Clock not found in Device Tree\n");
+		priv->clk = NULL;
+	}
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		goto err_hcd;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->regs = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(hcd->regs)) {
+		err = PTR_ERR(hcd->regs);
+		goto err_clk;
+	}
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = resource_size(res_mem);
+	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (err)
+		goto err_clk;
+
+	device_wakeup_enable(hcd->self.controller);
+	device_enable_async_suspend(hcd->self.controller);
+	platform_set_drvdata(pdev, hcd);
+
+	return err;
+
+err_clk:
+	clk_disable_unprepare(priv->clk);
+err_hcd:
+	usb_put_hcd(hcd);
+
+	return err;
+}
+
+static int ehci_brcm_remove(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
+
+	usb_remove_hcd(hcd);
+	clk_disable_unprepare(priv->clk);
+	usb_put_hcd(hcd);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+
+static int ehci_brcm_suspend(struct device *dev)
+{
+	int ret;
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
+	bool do_wakeup = device_may_wakeup(dev);
+
+	ret = ehci_suspend(hcd, do_wakeup);
+	clk_disable_unprepare(priv->clk);
+	return ret;
+}
+
+static int ehci_brcm_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
+	int err;
+
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		return err;
+	/*
+	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
+	 *   bus usage
+	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
+	 * @ 0x90
+	 */
+	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+
+	ehci_resume(hcd, false);
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(ehci_brcm_pm_ops, ehci_brcm_suspend,
+		ehci_brcm_resume);
+
+#ifdef CONFIG_OF
+static const struct of_device_id brcm_ehci_of_match[] = {
+	{ .compatible = "brcm,bcm7445-ehci", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, brcm_ehci_of_match);
+#endif /* CONFIG_OF */
+
+static struct platform_driver ehci_brcm_driver = {
+	.probe		= ehci_brcm_probe,
+	.remove		= ehci_brcm_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "ehci-brcm",
+		.pm	= &ehci_brcm_pm_ops,
+		.of_match_table = of_match_ptr(brcm_ehci_of_match),
+	}
+};
+
+static int __init ehci_brcm_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " BRCM_DRIVER_DESC "\n", brcm_hcd_name);
+
+	ehci_init_driver(&ehci_brcm_hc_driver, &brcm_overrides);
+	return platform_driver_register(&ehci_brcm_driver);
+}
+module_init(ehci_brcm_init);
+
+static void __exit ehci_brcm_exit(void)
+{
+	platform_driver_unregister(&ehci_brcm_driver);
+}
+module_exit(ehci_brcm_exit);
+
+MODULE_ALIAS("platform:ehci-brcm");
+MODULE_DESCRIPTION(BRCM_DRIVER_DESC);
+MODULE_AUTHOR("Al Cooper");
+MODULE_LICENSE("GPL");
-- 
1.9.0.138.g2de3478

