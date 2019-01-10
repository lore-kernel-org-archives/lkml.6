Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD72C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF392177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6pi8WyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfAJBbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:31:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33460 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfAJBbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:31:08 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so7667834ioi.0;
        Wed, 09 Jan 2019 17:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+hDjkNopmCIaNIPajtyDzyKeVMcATGHvYgQ/iMzhRM=;
        b=f6pi8WyB3ZzxSvoFkJwGS8DEL15FzJvSJN7vMbGWgfb7bZ6W6rapD98RlHIxOIMXLv
         BQugVKAucS4oVcw6cKk2NHvM2epc1Qh0EIWE2UjGEUEfVbHA62zTWzaj1a8yFo7O0Cpu
         PLcwHuh6swwPMcpaSFckxuiX3+eKyJFAPLBq+Jibtx0NEVX3bXY2pu8qGLUUYlc/i9Tb
         4gUSQlHMweo/0GCLgburyf7SZL0QvC41gW7v54fLxja+/blE3iYTkajj4yzc+PZ+z7ka
         NWGqjTKuxEYn9czIlbfnQ+vGAhrKRljocMMDRbfFVhLKPBMl1AWcU1Rtg/2hnhiDQnYn
         tw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+hDjkNopmCIaNIPajtyDzyKeVMcATGHvYgQ/iMzhRM=;
        b=UAusg6UIQIFFdVA8gCFzuDp4+lI2bJTqXONVObOCZwFjt22B+NeyiGlPeBMP6Y1H9O
         N9+qO9MRE+9WCC77ZQ+mHi2V0t5yUueo9cv2kF2PIssr7ioZYCZcF+qpauuAmLJV7G7y
         TC5QSrqK9qiw04wjsfbMOKcL/sqXFuIzg+4+AfIplKUjWSzWS7Tf/sLZkO5/WdgDor0n
         eTWPbecjYlVY9bHK+ArUsUr7+8XkZCJIzry5giicHvRT/F6+uTqPupZbAgqpBmiJtBgo
         mI7K4ui3uZiO94qakUcijVc+cprzNLLZ6UH2xJIjzqL42arFpkw7Yobrh+hbvNfFwDnF
         lptg==
X-Gm-Message-State: AJcUukcZ6d+M0MO1gLViNW14qOs3qUIcKWSsOprbwr1aCYAfaKOIdX+N
        bClxGDHZjXtvLLW2u/EEC7rbCzVQlrz4oN1bKKQ=
X-Google-Smtp-Source: ALg8bN7EmE19OPdaQlMnMSiv5G8yuNfnpm1B3nfecfuoeD9LI93YG5jxxBfG9RudracK8ipPKZArw+6ovZG8tEym7BE=
X-Received: by 2002:a6b:3806:: with SMTP id f6mr5745723ioa.194.1547083855806;
 Wed, 09 Jan 2019 17:30:55 -0800 (PST)
MIME-Version: 1.0
References: <1545577992-4013-1-git-send-email-pawell@cadence.com> <1545577992-4013-6-git-send-email-pawell@cadence.com>
In-Reply-To: <1545577992-4013-6-git-send-email-pawell@cadence.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Thu, 10 Jan 2019 09:30:41 +0800
Message-ID: <CAL411-oF2j1Xjz60Q3B1beBoUoFUxN+rBi9_Z0nx7R2P0p_3tg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        hdegoede@redhat.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, rogerq@ti.com,
        lkml <linux-kernel@vger.kernel.org>, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Content-Type: multipart/mixed; boundary="000000000000aa40e6057f108708"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000aa40e6057f108708
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 24, 2018 at 12:44 AM Pawel Laszczak <pawell@cadence.com> wrote:
>
> This patch introduce new Cadence USBSS DRD driver
> to linux kernel.
>
> The Cadence USBSS DRD Driver is a highly
> configurable IP Core which can be
> instantiated as Dual-Role Device (DRD),
> Peripheral Only and Host Only (XHCI)
> configurations.
>
> The current driver has been validated with
> FPGA burned. We have support for PCIe
> bus, which is used on FPGA prototyping.
>
> The host side of USBSS-DRD controller is compliance
> with XHCI specification, so it works with
> standard XHCI linux driver.
>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/Kconfig                |    2 +
>  drivers/usb/Makefile               |    2 +
>  drivers/usb/cdns3/Kconfig          |   44 +
>  drivers/usb/cdns3/Makefile         |   16 +
>  drivers/usb/cdns3/cdns3-pci-wrap.c |  157 +++
>  drivers/usb/cdns3/core.c           |  406 ++++++
>  drivers/usb/cdns3/core.h           |  116 ++
>  drivers/usb/cdns3/debug.h          |  166 +++
>  drivers/usb/cdns3/debugfs.c        |  168 +++
>  drivers/usb/cdns3/drd.c            |  350 +++++
>  drivers/usb/cdns3/drd.h            |  162 +++

Hi Pawel,

- I reviewed your dual-switch flow, and the handling for dr_mode, it
is a little complicated.
In fact, dr_mode is static, it is only used to decide which role
driver (host/gadget) needs
to be created, after that, we use variable cdns->role to track the current role.

- I find the strap value is always device mode at my platform, so I
delete its handling,
meanwhile, I keep id handling and add vbus handling for you use, and
add external connector
support for my platform.

- runtime power manage is not supported at this version, so I delete
related code at core.c
and drd.c.

- debugfs is nice to have feature, I suggest removing it at this
initial version. Besides, role switch
through /sys is normal feature, the end user may use it at real
product, so, it is better at device's
/sys entry instead of debugfs.

- I don't know why you add "disable" at debugfs, please comment.

My changes for drd flow is attached for your reference, It works well
at my platform,
and I attached my local code base too.

Other main changes:
diff --git a/drivers/usb/cdns3/trace.h b/drivers/usb/cdns3/trace.h
index f3d7a91fae86..8e97575a6b01 100644
--- a/drivers/usb/cdns3/trace.h
+++ b/drivers/usb/cdns3/trace.h
@@ -179,7 +179,7 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
                __entry->flags = req->flags;
        ),
        TP_printk("%s: req: %p, length: %u/%u %s%s%s, status: %d,"
-                 " trb: [start:%d, end:%d: virt addr %pa], flags:%x ",
+                 " trb: [start:%d, end:%d: virt addr 0x%p], flags:%x ",
                __get_str(name), __entry->req, __entry->actual, __entry->length,
                __entry->zero ? "zero | " : "",
                __entry->short_not_ok ? "short | " : "",
@@ -236,7 +236,7 @@ DECLARE_EVENT_CLASS(cdns3_log_trb,
                __entry->control = trb->control;
                __entry->type = usb_endpoint_type(priv_ep->endpoint.desc);
        ),
-       TP_printk("%s: trb 0x%pa, dma buf: 0x%08x, size: %ld, ctrl:
0x%08x (%s%s%s%s%s%s%s)",
+       TP_printk("%s: trb 0x%p, dma buf: 0x%08x, size: %ld, ctrl:
0x%08x (%s%s%s%s%s%s%s)",
                __get_str(name), __entry->trb, __entry->buffer,
                TRB_LEN(__entry->length), __entry->control,
                __entry->control & TRB_CYCLE ? "C=1, " : "C=0, ",

%pa is used for physical address, the former code print zero value.

@@ -951,6 +996,9 @@ static irqreturn_t cdns3_device_irq_handler(int
irq, void *data)
        unsigned long flags;
        u32 reg;

+       if (cdns->role != CDNS3_ROLE_GADGET)
+               return ret;
+

Need to add judgement, otherwise, host interrupt will cause oops.

Peter

>  drivers/usb/cdns3/ep0.c            |  896 ++++++++++++
>  drivers/usb/cdns3/gadget-export.h  |   28 +
>  drivers/usb/cdns3/gadget.c         | 2102 ++++++++++++++++++++++++++++
>  drivers/usb/cdns3/gadget.h         | 1206 ++++++++++++++++
>  drivers/usb/cdns3/host-export.h    |   28 +
>  drivers/usb/cdns3/host.c           |   72 +
>  drivers/usb/cdns3/trace.c          |   11 +
>  drivers/usb/cdns3/trace.h          |  389 +++++
>  19 files changed, 6321 insertions(+)
>  create mode 100644 drivers/usb/cdns3/Kconfig
>  create mode 100644 drivers/usb/cdns3/Makefile
>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>  create mode 100644 drivers/usb/cdns3/core.c
>  create mode 100644 drivers/usb/cdns3/core.h
>  create mode 100644 drivers/usb/cdns3/debug.h
>  create mode 100644 drivers/usb/cdns3/debugfs.c
>  create mode 100644 drivers/usb/cdns3/drd.c
>  create mode 100644 drivers/usb/cdns3/drd.h
>  create mode 100644 drivers/usb/cdns3/ep0.c
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
>  create mode 100644 drivers/usb/cdns3/gadget.h
>  create mode 100644 drivers/usb/cdns3/host-export.h
>  create mode 100644 drivers/usb/cdns3/host.c
>  create mode 100644 drivers/usb/cdns3/trace.c
>  create mode 100644 drivers/usb/cdns3/trace.h
>
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 987fc5ba6321..5f9334019d04 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -112,6 +112,8 @@ source "drivers/usb/usbip/Kconfig"
>
>  endif
>
> +source "drivers/usb/cdns3/Kconfig"
> +
>  source "drivers/usb/mtu3/Kconfig"
>
>  source "drivers/usb/musb/Kconfig"
> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
> index 7d1b8c82b208..ab125b966cac 100644
> --- a/drivers/usb/Makefile
> +++ b/drivers/usb/Makefile
> @@ -12,6 +12,8 @@ obj-$(CONFIG_USB_DWC3)                += dwc3/
>  obj-$(CONFIG_USB_DWC2)         += dwc2/
>  obj-$(CONFIG_USB_ISP1760)      += isp1760/
>
> +obj-$(CONFIG_USB_CDNS3)                += cdns3/
> +
>  obj-$(CONFIG_USB_MON)          += mon/
>  obj-$(CONFIG_USB_MTU3)         += mtu3/
>
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> new file mode 100644
> index 000000000000..4adfd87811e8
> --- /dev/null
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -0,0 +1,44 @@
> +config USB_CDNS3
> +       tristate "Cadence USB3 Dual-Role Controller"
> +       depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
> +       help
> +         Say Y here if your system has a cadence USB3 dual-role controller.
> +         It supports: dual-role switch, Host-only, and Peripheral-only.
> +
> +         If you choose to build this driver is a dynamically linked
> +         module, the module will be called cdns3.ko.
> +
> +if USB_CDNS3
> +
> +config USB_CDNS3_GADGET
> +        bool "Cadence USB3 device controller"
> +        depends on USB_GADGET
> +        help
> +          Say Y here to enable device controller functionality of the
> +          cadence USBSS-DEV driver.
> +
> +          This controller supports FF, HS and SS mode. It doesn't support
> +          LS and SSP mode
> +
> +config USB_CDNS3_HOST
> +        bool "Cadence USB3 host controller"
> +        depends on USB_XHCI_HCD
> +        help
> +          Say Y here to enable host controller functionality of the
> +          cadence driver.
> +
> +          Host controller is compliance with XHCI so it will use
> +          standard XHCI driver.
> +
> +config USB_CDNS3_PCI_WRAP
> +       tristate "Cadence USB3 support on PCIe-based platforms"
> +       depends on USB_PCI && ACPI
> +       default USB_CDNS3
> +       help
> +         If you're using the USBSS Core IP with a PCIe, please say
> +         'Y' or 'M' here.
> +
> +         If you choose to build this driver as module it will
> +         be dynamically linked and module will be called cdns3-pci.ko
> +
> +endif
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> new file mode 100644
> index 000000000000..3f63baa24294
> --- /dev/null
> +++ b/drivers/usb/cdns3/Makefile
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# define_trace.h needs to know how to find our header
> +CFLAGS_trace.o                         := -I$(src)
> +
> +obj-$(CONFIG_USB_CDNS3)                        += cdns3.o
> +obj-$(CONFIG_USB_CDNS3_PCI_WRAP)       += cdns3-pci.o
> +
> +cdns3-y                                        := core.o drd.o trace.o
> +
> +ifneq ($(CONFIG_DEBUG_FS),)
> +       cdns3-y                         += debugfs.o
> +endif
> +
> +cdns3-$(CONFIG_USB_CDNS3_GADGET)       += gadget.o ep0.o
> +cdns3-$(CONFIG_USB_CDNS3_HOST)         += host.o
> +cdns3-pci-y                            := cdns3-pci-wrap.o
> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> new file mode 100644
> index 000000000000..e93179c45ece
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS PCI Glue driver
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +
> +struct cdns3_wrap {
> +       struct platform_device *plat_dev;
> +       struct pci_dev *hg_dev;
> +       struct resource dev_res[4];
> +};
> +
> +struct cdns3_wrap wrap;
> +
> +#define RES_IRQ_ID             0
> +#define RES_HOST_ID            1
> +#define RES_DEV_ID             2
> +#define RES_DRD_ID             3
> +
> +#define PCI_BAR_HOST           0
> +#define PCI_BAR_DEV            2
> +#define PCI_BAR_OTG            4
> +
> +#define PCI_DEV_FN_HOST_DEVICE 0
> +#define PCI_DEV_FN_OTG         1
> +
> +#define PCI_DRIVER_NAME                "cdns3-pci-usbss"
> +#define PLAT_DRIVER_NAME       "cdns-usb3"
> +
> +#define CDNS_VENDOR_ID 0x17cd
> +#define CDNS_DEVICE_ID 0x0100
> +
> +/**
> + * cdns3_pci_probe - Probe function for Cadence USB wrapper driver
> + * @pdev: platform device object
> + * @id: pci device id
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_pci_probe(struct pci_dev *pdev,
> +                          const struct pci_device_id *id)
> +{
> +       struct platform_device_info plat_info;
> +       struct cdns3_wrap *wrap;
> +       struct resource *res;
> +       int err;
> +
> +       /*
> +        * for GADGET/HOST PCI (devfn) function number is 0,
> +        * for OTG PCI (devfn) function number is 1
> +        */
> +       if (!id || pdev->devfn != PCI_DEV_FN_HOST_DEVICE)
> +               return -EINVAL;
> +
> +       err = pcim_enable_device(pdev);
> +       if (err) {
> +               dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
> +               return err;
> +       }
> +
> +       pci_set_master(pdev);
> +       wrap = devm_kzalloc(&pdev->dev, sizeof(*wrap), GFP_KERNEL);
> +       if (!wrap) {
> +               dev_err(&pdev->dev, "Failed to allocate memory\n");
> +               return -ENOMEM;
> +       }
> +
> +       /* function 0: host(BAR_0) + device(BAR_1) + otg(BAR_2)). */
> +       memset(wrap->dev_res, 0x00,
> +              sizeof(struct resource) * ARRAY_SIZE(wrap->dev_res));
> +       dev_dbg(&pdev->dev, "Initialize Device resources\n");
> +       res = wrap->dev_res;
> +
> +       res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
> +       res[RES_DEV_ID].end =   pci_resource_end(pdev, PCI_BAR_DEV);
> +       res[RES_DEV_ID].name = "cdns3-dev-regs";
> +       res[RES_DEV_ID].flags = IORESOURCE_MEM;
> +       dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
> +               &res[RES_DEV_ID].start);
> +
> +       res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
> +       res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
> +       res[RES_HOST_ID].name = "cdns3-xhci-regs";
> +       res[RES_HOST_ID].flags = IORESOURCE_MEM;
> +       dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
> +               &res[RES_HOST_ID].start);
> +
> +       res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
> +       res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
> +       res[RES_DRD_ID].name = "cdns3-otg";
> +       res[RES_DRD_ID].flags = IORESOURCE_MEM;
> +       dev_dbg(&pdev->dev, "USBSS-DRD physical base addr: %pa\n",
> +               &res[RES_DRD_ID].start);
> +
> +       /* Interrupt common for both device and XHCI */
> +       wrap->dev_res[RES_IRQ_ID].start = pdev->irq;
> +       wrap->dev_res[RES_IRQ_ID].name = "cdns3-irq";
> +       wrap->dev_res[RES_IRQ_ID].flags = IORESOURCE_IRQ;
> +
> +       /* set up platform device info */
> +       memset(&plat_info, 0, sizeof(plat_info));
> +       plat_info.parent = &pdev->dev;
> +       plat_info.fwnode = pdev->dev.fwnode;
> +       plat_info.name = PLAT_DRIVER_NAME;
> +       plat_info.id = pdev->devfn;
> +       plat_info.res = wrap->dev_res;
> +       plat_info.num_res = ARRAY_SIZE(wrap->dev_res);
> +       plat_info.dma_mask = pdev->dma_mask;
> +
> +       /* register platform device */
> +       wrap->plat_dev = platform_device_register_full(&plat_info);
> +       if (IS_ERR(wrap->plat_dev)) {
> +               err = PTR_ERR(wrap->plat_dev);
> +               return err;
> +       }
> +
> +       pci_set_drvdata(pdev, wrap);
> +
> +       return err;
> +}
> +
> +void cdns3_pci_remove(struct pci_dev *pdev)
> +{
> +       struct cdns3_wrap *wrap = (struct cdns3_wrap *)pci_get_drvdata(pdev);
> +
> +       platform_device_unregister(wrap->plat_dev);
> +}
> +
> +static const struct pci_device_id cdns3_pci_ids[] = {
> +       { PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
> +       { 0, }
> +};
> +
> +static struct pci_driver cdns3_pci_driver = {
> +       .name = PCI_DRIVER_NAME,
> +       .id_table = cdns3_pci_ids,
> +       .probe = cdns3_pci_probe,
> +       .remove = cdns3_pci_remove,
> +};
> +
> +module_pci_driver(cdns3_pci_driver);
> +MODULE_DEVICE_TABLE(pci, cdns3_pci_ids);
> +
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USBSS PCI wrapperr");
> +
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> new file mode 100644
> index 000000000000..d274586aca36
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018 Cadence.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Author: Peter Chen <peter.chen@nxp.com>
> + *         Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "gadget.h"
> +#include "core.h"
> +#include "host-export.h"
> +#include "gadget-export.h"
> +#include "drd.h"
> +#include "debug.h"
> +
> +static inline
> +struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> +{
> +       WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
> +       return cdns->roles[cdns->role];
> +}
> +
> +static inline int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
> +{
> +       int ret;
> +
> +       if (WARN_ON(role >= CDNS3_ROLE_END))
> +               return 0;
> +
> +       if (!cdns->roles[role])
> +               return -ENXIO;
> +
> +       if (cdns->roles[role]->state == CDNS3_ROLE_STATE_ACTIVE)
> +               return 0;
> +
> +       mutex_lock(&cdns->mutex);
> +       cdns->role = role;
> +       ret = cdns->roles[role]->start(cdns);
> +       if (!ret)
> +               cdns->roles[role]->state = CDNS3_ROLE_STATE_ACTIVE;
> +       mutex_unlock(&cdns->mutex);
> +       return ret;
> +}
> +
> +void cdns3_role_stop(struct cdns3 *cdns)
> +{
> +       enum cdns3_roles role = cdns->role;
> +
> +       if (role >= CDNS3_ROLE_END) {
> +               WARN_ON(role > CDNS3_ROLE_END);
> +               return;
> +       }
> +
> +       if (cdns->roles[role]->state == CDNS3_ROLE_STATE_INACTIVE)
> +               return;
> +
> +       mutex_lock(&cdns->mutex);
> +       cdns->roles[role]->stop(cdns);
> +       cdns->roles[role]->state = CDNS3_ROLE_STATE_INACTIVE;
> +       mutex_unlock(&cdns->mutex);
> +}
> +
> +/*
> + * cdns->role gets from cdns3_get_initial_role, and this API tells role at the
> + * runtime.
> + * If both roles are supported, the role is selected based on vbus/id.
> + * It could be read from OTG register or external connector.
> + * If only single role is supported, only one role structure
> + * is allocated, cdns->roles[CDNS3_ROLE_HOST] or cdns->roles[CDNS3_ROLE_GADGET].
> + */
> +static enum cdns3_roles cdns3_get_initial_role(struct cdns3 *cdns)
> +{
> +       if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
> +               if (cdns3_is_host(cdns))
> +                       return CDNS3_ROLE_HOST;
> +               if (cdns3_is_device(cdns))
> +                       return CDNS3_ROLE_GADGET;
> +       }
> +       return cdns->roles[CDNS3_ROLE_HOST]
> +               ? CDNS3_ROLE_HOST
> +               : CDNS3_ROLE_GADGET;
> +}
> +
> +static void cdns3_exit_roles(struct cdns3 *cdns)
> +{
> +       cdns3_role_stop(cdns);
> +       cdns3_drd_exit(cdns);
> +}
> +
> +/**
> + * cdns3_core_init_role - initialize role of operation
> + * @cdns: Pointer to cdns3 structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_core_init_role(struct cdns3 *cdns)
> +{
> +       struct device *dev = cdns->dev;
> +       enum usb_dr_mode best_dr_mode;
> +       enum usb_dr_mode dr_mode;
> +       int ret = 0;
> +
> +       dr_mode = usb_get_dr_mode(dev);
> +       cdns->role = CDNS3_ROLE_END;
> +
> +       /*
> +        * If driver can't read mode by means of usb_get_dr_mdoe function then
> +        * chooses mode according with Kernel configuration. This setting
> +        * can be restricted later depending on strap pin configuration.
> +        */
> +       if (dr_mode == USB_DR_MODE_UNKNOWN) {
> +               if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
> +                   IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +                       dr_mode = USB_DR_MODE_OTG;
> +               else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +                       dr_mode = USB_DR_MODE_HOST;
> +               else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +                       dr_mode = USB_DR_MODE_PERIPHERAL;
> +       }
> +
> +       best_dr_mode = USB_DR_MODE_OTG;
> +
> +       if (dr_mode == USB_DR_MODE_OTG) {
> +               best_dr_mode = cdns->dr_mode;
> +       } else if (cdns->dr_mode == USB_DR_MODE_OTG) {
> +               best_dr_mode = dr_mode;
> +       } else if (cdns->dr_mode != dr_mode) {
> +               dev_err(dev, "Incorrect DRD configuration\n");
> +               return -EINVAL;
> +       }
> +
> +       dr_mode = best_dr_mode;
> +
> +       if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> +               ret = cdns3_host_init(cdns);
> +               if (ret) {
> +                       dev_err(dev, "Host initialization failed with %d\n",
> +                               ret);
> +                       goto err;
> +               }
> +       }
> +
> +       if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
> +               ret = cdns3_gadget_init(cdns);
> +               if (ret) {
> +                       dev_err(dev, "Device initialization failed with %d\n",
> +                               ret);
> +                       goto err;
> +               }
> +       }
> +
> +       cdns->desired_dr_mode = dr_mode;
> +       cdns->dr_mode = dr_mode;
> +       /*
> +        * dr_mode could be change so DRD must update controller
> +        * configuration
> +        */
> +       ret = cdns3_drd_update_mode(cdns);
> +
> +       cdns->role = cdns3_get_initial_role(cdns);
> +
> +       ret = cdns3_role_start(cdns, cdns->role);
> +       if (ret) {
> +               dev_err(dev, "can't start %s role\n",
> +                       cdns3_get_current_role_driver(cdns)->name);
> +               goto err;
> +       }
> +
> +       return ret;
> +err:
> +       cdns3_exit_roles(cdns);
> +       return ret;
> +}
> +
> +/**
> + * cdsn3_get_real_role - get real role of controller based on hardware settings.
> + * @cdns: Pointer to cdns3 structure
> + *
> + * Returns role
> + */
> +enum cdns3_roles cdsn3_get_real_role(struct cdns3 *cdns)
> +{
> +       enum cdns3_roles role = CDNS3_ROLE_END;
> +
> +       if (cdns->current_dr_mode == USB_DR_MODE_OTG) {
> +               if (cdns3_get_id(cdns))
> +                       role = CDNS3_ROLE_GADGET;
> +               else
> +                       role = CDNS3_ROLE_HOST;
> +       } else {
> +               if (cdns3_is_host(cdns))
> +                       role = CDNS3_ROLE_HOST;
> +               if (cdns3_is_device(cdns))
> +                       role = CDNS3_ROLE_GADGET;
> +       }
> +
> +       return role;
> +}
> +
> +/**
> + * cdns3_role_switch - work queue handler for role switch
> + *
> + * @work: work queue item structure
> + *
> + * Handles below events:
> + * - Role switch for dual-role devices
> + * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
> + */
> +static void cdns3_role_switch(struct work_struct *work)
> +{
> +       enum cdns3_roles role = CDNS3_ROLE_END;
> +       struct cdns3_role_driver *role_drv;
> +       enum cdns3_roles current_role;
> +       struct cdns3 *cdns;
> +       int ret = 0;
> +
> +       cdns = container_of(work, struct cdns3, role_switch_wq);
> +
> +       /* During switching cdns->role can be different then role */
> +       role = cdsn3_get_real_role(cdns);
> +
> +       role_drv = cdns3_get_current_role_driver(cdns);
> +
> +       pm_runtime_get_sync(cdns->dev);
> +
> +       /* Disable current role. This state can be forced from user space. */
> +       if (cdns->debug_disable && role_drv->state == CDNS3_ROLE_STATE_ACTIVE) {
> +               cdns3_role_stop(cdns);
> +               goto exit;
> +       }
> +
> +       /* Do nothing if nothing changed */
> +       if (cdns->role == role && role_drv->state == CDNS3_ROLE_STATE_ACTIVE)
> +               goto exit;
> +
> +       cdns3_role_stop(cdns);
> +
> +       role = cdsn3_get_real_role(cdns);
> +
> +       current_role = cdns->role;
> +       dev_dbg(cdns->dev, "Switching role");
> +
> +       ret = cdns3_role_start(cdns, role);
> +
> +       if (ret) {
> +               /* Back to current role */
> +               dev_err(cdns->dev, "set %d has failed, back to %d\n",
> +                       role, current_role);
> +               cdns3_role_start(cdns, current_role);
> +       }
> +exit:
> +       pm_runtime_put_sync(cdns->dev);
> +}
> +
> +/**
> + * cdns3_probe - probe for cdns3 core device
> + * @pdev: Pointer to cdns3 core platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       struct cdns3 *cdns;
> +       void __iomem *regs;
> +       int ret;
> +
> +       cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> +       if (!cdns)
> +               return -ENOMEM;
> +
> +       cdns->dev = dev;
> +
> +       platform_set_drvdata(pdev, cdns);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       if (!res) {
> +               dev_err(dev, "missing IRQ\n");
> +               return -ENODEV;
> +       }
> +       cdns->irq = res->start;
> +
> +       cdns->xhci_res[0] = *res;
> +
> +       /*
> +        * Request memory region
> +        * region-0: xHCI
> +        * region-1: Peripheral
> +        * region-2: OTG registers
> +        */
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       cdns->xhci_res[1] = *res;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       regs = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
> +       cdns->dev_regs  = regs;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +       cdns->otg_res = *res;
> +
> +       mutex_init(&cdns->mutex);
> +
> +       cdns->phy = devm_phy_get(dev, "cdns3,usbphy");
> +       if (IS_ERR(cdns->phy)) {
> +               ret = PTR_ERR(cdns->phy);
> +               if (ret == -ENODEV) {
> +                       cdns->phy = NULL;
> +               } else if (ret == -EPROBE_DEFER) {
> +                       return ret;
> +               } else {
> +                       dev_err(dev, "no phy found\n");
> +                       goto err0;
> +               }
> +       }
> +
> +       phy_init(cdns->phy);
> +
> +       INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
> +
> +       ret = cdns3_drd_init(cdns);
> +       if (ret)
> +               goto err1;
> +
> +       ret = cdns3_core_init_role(cdns);
> +       if (ret)
> +               goto err1;
> +
> +       cdns3_debugfs_init(cdns);
> +       device_set_wakeup_capable(dev, true);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
> +       /*
> +        * The controller needs less time between bus and controller suspend,
> +        * and we also needs a small delay to avoid frequently entering low
> +        * power mode.
> +        */
> +       pm_runtime_set_autosuspend_delay(dev, 20);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_use_autosuspend(dev);
> +       dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
> +
> +       return 0;
> +
> +err1:
> +       phy_exit(cdns->phy);
> +err0:
> +       return ret;
> +}
> +
> +/**
> + * cdns3_remove - unbind drd driver and clean up
> + * @pdev: Pointer to Linux platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_remove(struct platform_device *pdev)
> +{
> +       struct cdns3 *cdns = platform_get_drvdata(pdev);
> +
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +       cdns3_debugfs_exit(cdns);
> +       cdns3_exit_roles(cdns);
> +       phy_exit(cdns->phy);
> +       return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_cdns3_match[] = {
> +       { .compatible = "cdns,usb3-1.0.0" },
> +       { .compatible = "cdns,usb3-1.0.1" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, of_cdns3_match);
> +#endif
> +
> +static struct platform_driver cdns3_driver = {
> +       .probe          = cdns3_probe,
> +       .remove         = cdns3_remove,
> +       .driver         = {
> +               .name   = "cdns-usb3",
> +               .of_match_table = of_match_ptr(of_cdns3_match),
> +       },
> +};
> +
> +module_platform_driver(cdns3_driver);
> +
> +MODULE_ALIAS("platform:cdns3");
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> new file mode 100644
> index 000000000000..fb4b39206158
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.h
> @@ -0,0 +1,116 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Header File.
> + *
> + * Copyright (C) 2017-2018 NXP
> + * Copyright (C) 2018 Cadence.
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + *          Pawel Laszczak <pawell@cadence.com>
> + */
> +#include <linux/usb/otg.h>
> +
> +#ifndef __LINUX_CDNS3_CORE_H
> +#define __LINUX_CDNS3_CORE_H
> +
> +struct cdns3;
> +enum cdns3_roles {
> +       CDNS3_ROLE_HOST = 0,
> +       CDNS3_ROLE_GADGET,
> +       CDNS3_ROLE_END,
> +};
> +
> +/**
> + * struct cdns3_role_driver - host/gadget role driver
> + * @start: start this role
> + * @stop: stop this role
> + * @suspend: suspend callback for this role
> + * @resume: resume callback for this role
> + * @irq: irq handler for this role
> + * @name: role name string (host/gadget)
> + * @state: current state
> + */
> +struct cdns3_role_driver {
> +       int (*start)(struct cdns3 *cdns);
> +       void (*stop)(struct cdns3 *cdns);
> +       int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
> +       int (*resume)(struct cdns3 *cdns, bool hibernated);
> +       const char *name;
> +#define CDNS3_ROLE_STATE_INACTIVE      0
> +#define CDNS3_ROLE_STATE_ACTIVE                1
> +       int state;
> +};
> +
> +#define CDNS3_XHCI_RESOURCES_NUM       2
> +/**
> + * struct cdns3 - Representation of Cadence USB3 DRD controller.
> + * @dev: pointer to Cadence device struct
> + * @xhci_regs: pointer to base of xhci registers
> + * @xhci_res: the resource for xhci
> + * @dev_regs: pointer to base of dev registers
> + * @otg_regs: pointer to base of otg registers
> + * @irq: irq number for controller
> + * @roles: array of supported roles for this controller
> + * @role: current role
> + * @host_dev: the child host device pointer for cdns3 core
> + * @gadget_dev: the child gadget device pointer for cdns3 core
> + * @usb: phy for this controller
> + * @role_switch_wq: work queue item for role switch
> + * @in_lpm: the controller in low power mode
> + * @wakeup_int: the wakeup interrupt
> + * @mutex: the mutex for concurrent code at driver
> + * @dr_mode: supported mode of operation it can be only Host, only Device
> + *           or OTG mode that allow to switch between Device and Host mode.
> + *           This field based on firmware setting, kernel configuration
> + *           and hardware configuration.
> + * @current_dr_mode: current mode of operation when in dual-role mode
> + * @desired_dr_mode: desired mode of operation when in dual-role mode.
> + *           This value can be changed during runtime.
> + *           Available options depends on  dr_mode:
> + *           dr_mode                 |  desired_dr_mode and current_dr_mode
> + *           ----------------------------------------------------------------
> + *           USB_DR_MODE_HOST        | only USB_DR_MODE_HOST
> + *           USB_DR_MODE_PERIPHERAL  | only USB_DR_MODE_PERIPHERAL
> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_HOST
> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_PERIPHERAL
> + *           USB_DR_MODE_OTG         | USB_DR_MODE_OTG
> + *
> + *           Desired_dr_role can be changed by means of debugfs.
> + * @root: debugfs root folder pointer
> + * @debug_disable:
> + */
> +struct cdns3 {
> +       struct device                   *dev;
> +       void __iomem                    *xhci_regs;
> +       struct resource                 xhci_res[CDNS3_XHCI_RESOURCES_NUM];
> +       struct cdns3_usb_regs __iomem   *dev_regs;
> +
> +       struct resource                 otg_res;
> +       struct cdns3_otg_legacy_regs    *otg_v0_regs;
> +       struct cdns3_otg_regs           *otg_v1_regs;
> +       struct cdns3_otg_common_regs    *otg_regs;
> +#define CDNS3_CONTROLLER_V0    0
> +#define CDNS3_CONTROLLER_V1    1
> +       u32                             version;
> +
> +       int                             irq;
> +       struct cdns3_role_driver        *roles[CDNS3_ROLE_END];
> +       enum cdns3_roles                role;
> +       struct platform_device          *host_dev;
> +       struct cdns3_device             *gadget_dev;
> +       struct phy                      *phy;
> +       struct work_struct              role_switch_wq;
> +       int                             in_lpm:1;
> +       int                             wakeup_int:1;
> +       /* mutext used in workqueue*/
> +       struct mutex                    mutex;
> +       enum usb_dr_mode                dr_mode;
> +       enum usb_dr_mode                current_dr_mode;
> +       enum usb_dr_mode                desired_dr_mode;
> +       struct dentry                   *root;
> +       int                             debug_disable:1;
> +};
> +
> +void cdns3_role_stop(struct cdns3 *cdns);
> +
> +#endif /* __LINUX_CDNS3_CORE_H */
> diff --git a/drivers/usb/cdns3/debug.h b/drivers/usb/cdns3/debug.h
> new file mode 100644
> index 000000000000..94f9ef15f899
> --- /dev/null
> +++ b/drivers/usb/cdns3/debug.h
> @@ -0,0 +1,166 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver.
> + * Debug header file.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +#ifndef __LINUX_CDNS3_DEBUG
> +#define __LINUX_CDNS3_DEBUG
> +
> +#include "core.h"
> +
> +static inline char *cdns3_decode_usb_irq(char *str,
> +                                        enum usb_device_speed speed,
> +                                        u32 usb_ists)
> +{
> +       int ret;
> +
> +       ret = sprintf(str, "IRQ %08x = ", usb_ists);
> +
> +       if (usb_ists & (USB_ISTS_CON2I | USB_ISTS_CONI)) {
> +               ret += sprintf(str + ret, "Connection %s\n",
> +                              usb_speed_string(speed));
> +       }
> +       if (usb_ists & USB_ISTS_CON2I || usb_ists & USB_ISTS_CONI)
> +               ret += sprintf(str + ret, "Disconnection ");
> +       if (usb_ists & USB_ISTS_L2ENTI)
> +               ret += sprintf(str + ret, "suspended ");
> +
> +       if (usb_ists & USB_ISTS_L2EXTI)
> +               ret += sprintf(str + ret, "L2 exit ");
> +       if (usb_ists & USB_ISTS_U3EXTI)
> +               ret += sprintf(str + ret, "U3 exit ");
> +       if (usb_ists & USB_ISTS_UWRESI)
> +               ret += sprintf(str + ret, "Warm Reset ");
> +       if (usb_ists & USB_ISTS_UHRESI)
> +               ret += sprintf(str + ret, "Hot Reset ");
> +       if (usb_ists & USB_ISTS_U2RESI)
> +               ret += sprintf(str + ret, "Reset");
> +
> +       return str;
> +}
> +
> +static inline  char *cdns3_decode_ep_irq(char *str,
> +                                        u32 ep_sts,
> +                                        const char *ep_name)
> +{
> +       int ret;
> +
> +       ret = sprintf(str, "IRQ for %s: %08x ", ep_name, ep_sts);
> +
> +       if (ep_sts & EP_STS_SETUP)
> +               ret += sprintf(str + ret, "SETUP ");
> +       if (ep_sts & EP_STS_IOC)
> +               ret += sprintf(str + ret, "IOC ");
> +       if (ep_sts & EP_STS_ISP)
> +               ret += sprintf(str + ret, "ISP ");
> +       if (ep_sts & EP_STS_DESCMIS)
> +               ret += sprintf(str + ret, "DESCMIS ");
> +       if (ep_sts & EP_STS_STREAMR)
> +               ret += sprintf(str + ret, "STREAMR ");
> +       if (ep_sts & EP_STS_MD_EXIT)
> +               ret += sprintf(str + ret, "MD_EXIT ");
> +       if (ep_sts & EP_STS_TRBERR)
> +               ret += sprintf(str + ret, "TRBERR ");
> +       if (ep_sts & EP_STS_NRDY)
> +               ret += sprintf(str + ret, "NRDY ");
> +       if (ep_sts & EP_STS_PRIME)
> +               ret += sprintf(str + ret, "PRIME ");
> +       if (ep_sts & EP_STS_SIDERR)
> +               ret += sprintf(str + ret, "SIDERRT ");
> +       if (ep_sts & EP_STS_OUTSMM)
> +               ret += sprintf(str + ret, "OUTSMM ");
> +       if (ep_sts & EP_STS_ISOERR)
> +               ret += sprintf(str + ret, "ISOERR ");
> +       if (ep_sts & EP_STS_IOT)
> +               ret += sprintf(str + ret, "IOT ");
> +
> +       return str;
> +}
> +
> +static inline char *cdns3_decode_epx_irq(char *str,
> +                                        char *ep_name,
> +                                        u32 ep_sts)
> +{
> +       return cdns3_decode_ep_irq(str, ep_sts, ep_name);
> +}
> +
> +static inline char *cdns3_decode_ep0_irq(char *str,
> +                                        int dir,
> +                                        u32 ep_sts)
> +{
> +       return cdns3_decode_ep_irq(str, ep_sts,
> +                                  dir ? "ep0IN" : "ep0OUT");
> +}
> +
> +/**
> + * Debug a transfer ring.
> + *
> + * Prints out all TRBs in the endpoint ring, even those after the Link TRB.
> + *.
> + */
> +static inline char *cdns3_dbg_ring(struct cdns3_endpoint *priv_ep,
> +                                  struct cdns3_trb *ring, char *str)
> +{
> +       dma_addr_t addr = priv_ep->trb_pool_dma;
> +       struct cdns3_trb *trb;
> +       int trb_per_sector;
> +       int ret = 0;
> +       int i;
> +
> +       trb_per_sector = GET_TRBS_PER_SEGMENT(priv_ep->type);
> +
> +       trb = &priv_ep->trb_pool[priv_ep->dequeue];
> +       ret += sprintf(str + ret, "\n\t\tRing contents for %s:", priv_ep->name);
> +
> +       ret += sprintf(str + ret,
> +                      "\n\t\tRing deq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +                      priv_ep->dequeue, trb,
> +                      (unsigned long long)cdns3_trb_virt_to_dma(priv_ep, trb));
> +
> +       trb = &priv_ep->trb_pool[priv_ep->enqueue];
> +       ret += sprintf(str + ret,
> +                      "\t\tRing enq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +                      priv_ep->enqueue, trb,
> +                      (unsigned long long)cdns3_trb_virt_to_dma(priv_ep, trb));
> +
> +       ret += sprintf(str + ret,
> +                      "\t\tfree trbs: %d, CCS=%d, PCS=%d\n",
> +                      priv_ep->free_trbs, priv_ep->ccs, priv_ep->pcs);
> +
> +       if (trb_per_sector > TRBS_PER_SEGMENT)
> +               trb_per_sector = TRBS_PER_SEGMENT;
> +
> +       if (trb_per_sector > TRBS_PER_SEGMENT) {
> +               sprintf(str + ret, "\t\tTo big transfer ring %d\n",
> +                       trb_per_sector);
> +               return str;
> +       }
> +
> +       for (i = 0; i < trb_per_sector; ++i) {
> +               trb = &ring[i];
> +               ret += sprintf(str + ret,
> +                       "\t\t@%pad %08x %08x %08x\n", &addr,
> +                       le32_to_cpu(trb->buffer),
> +                       le32_to_cpu(trb->length),
> +                       le32_to_cpu(trb->control));
> +               addr += sizeof(*trb);
> +       }
> +
> +       return str;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +void cdns3_debugfs_init(struct cdns3 *cdns);
> +void cdns3_debugfs_exit(struct cdns3 *cdns);
> +#else
> +void cdns3_debugfs_init(struct cdns3 *cdns);
> +{  }
> +void cdns3_debugfs_exit(struct cdns3 *cdns);
> +{  }
> +#endif
> +
> +#endif /*__LINUX_CDNS3_DEBUG*/
> diff --git a/drivers/usb/cdns3/debugfs.c b/drivers/usb/cdns3/debugfs.c
> new file mode 100644
> index 000000000000..d7919f5c1d90
> --- /dev/null
> +++ b/drivers/usb/cdns3/debugfs.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Controller DebugFS filer.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/uaccess.h>
> +
> +#include "core.h"
> +#include "gadget.h"
> +#include "drd.h"
> +
> +static int cdns3_mode_show(struct seq_file *s, void *unused)
> +{
> +       struct cdns3 *cdns = s->private;
> +
> +       switch (cdns->current_dr_mode) {
> +       case USB_DR_MODE_HOST:
> +               seq_puts(s, "host\n");
> +               break;
> +       case USB_DR_MODE_PERIPHERAL:
> +               seq_puts(s, "device\n");
> +               break;
> +       case USB_DR_MODE_OTG:
> +               seq_puts(s, "otg\n");
> +               break;
> +       default:
> +               seq_puts(s, "UNKNOWN mode\n");
> +       }
> +
> +       return 0;
> +}
> +
> +static int cdns3_mode_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, cdns3_mode_show, inode->i_private);
> +}
> +
> +static ssize_t cdns3_mode_write(struct file *file,
> +                               const char __user *ubuf,
> +                               size_t count, loff_t *ppos)
> +{
> +       struct seq_file  *s = file->private_data;
> +       struct cdns3 *cdns = s->private;
> +       u32 mode = USB_DR_MODE_UNKNOWN;
> +       char buf[32];
> +
> +       if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +               return -EFAULT;
> +
> +       if (!strncmp(buf, "host", 4)) {
> +               if (cdns->dr_mode == USB_DR_MODE_HOST ||
> +                   cdns->dr_mode == USB_DR_MODE_OTG) {
> +                       mode = USB_DR_MODE_HOST;
> +               }
> +       }
> +
> +       if (!strncmp(buf, "device", 6))
> +               if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL ||
> +                   cdns->dr_mode == USB_DR_MODE_OTG)
> +                       mode = USB_DR_MODE_PERIPHERAL;
> +
> +       if (!strncmp(buf, "otg", 3) && cdns->dr_mode == USB_DR_MODE_OTG)
> +               mode = USB_DR_MODE_OTG;
> +
> +       if (mode == USB_DR_MODE_UNKNOWN) {
> +               dev_err(cdns->dev, "Failed: incorrect mode setting\n");
> +               return -EFAULT;
> +       }
> +
> +       if (cdns->current_dr_mode != mode) {
> +               cdns->desired_dr_mode = mode;
> +               cdns->debug_disable = 0;
> +               cdns3_role_stop(cdns);
> +               cdns3_drd_update_mode(cdns);
> +               queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +       }
> +
> +       return count;
> +}
> +
> +static const struct file_operations cdns3_mode_fops = {
> +       .open                   = cdns3_mode_open,
> +       .write                  = cdns3_mode_write,
> +       .read                   = seq_read,
> +       .llseek                 = seq_lseek,
> +       .release                = single_release,
> +};
> +
> +static int cdns3_disable_show(struct seq_file *s, void *unused)
> +{
> +       struct cdns3 *cdns = s->private;
> +
> +       if (!cdns->debug_disable)
> +               seq_puts(s, "0\n");
> +       else
> +               seq_puts(s, "1\n");
> +
> +       return 0;
> +}
> +
> +static ssize_t cdns3_disable_write(struct file *file,
> +                                  const char __user *ubuf,
> +                                  size_t count, loff_t *ppos)
> +{
> +       struct seq_file  *s = file->private_data;
> +       struct cdns3 *cdns = s->private;
> +       int disable;
> +       char buf[32];
> +
> +       if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +               return -EFAULT;
> +
> +       if (!strncmp(buf, "1", 1) || !strncmp(buf, "yes", 3)) {
> +               disable = 1;
> +       } else if (!strncmp(buf, "0", 1) || !strncmp(buf, "no", 2)) {
> +               disable = 0;
> +       } else {
> +               dev_err(cdns->dev, "Failed: incorrect disable setting\n");
> +               return -EFAULT;
> +       }
> +
> +       if (disable != cdns->debug_disable) {
> +               cdns->debug_disable = disable;
> +               queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +       }
> +
> +       return count;
> +}
> +
> +static int cdns3_disable_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, cdns3_disable_show, inode->i_private);
> +}
> +
> +static const struct file_operations cdns3_disable_fops = {
> +       .open                   = cdns3_disable_open,
> +       .write                  = cdns3_disable_write,
> +       .read                   = seq_read,
> +       .llseek                 = seq_lseek,
> +       .release                = single_release,
> +};
> +
> +void cdns3_debugfs_init(struct cdns3 *cdns)
> +{
> +       struct dentry *root;
> +
> +       root = debugfs_create_dir(dev_name(cdns->dev), NULL);
> +       cdns->root = root;
> +       if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET) &&
> +           IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +               debugfs_create_file("mode", 0644, root, cdns,
> +                                   &cdns3_mode_fops);
> +
> +       debugfs_create_file("disable", 0644, root, cdns,
> +                           &cdns3_disable_fops);
> +}
> +
> +void cdns3_debugfs_exit(struct cdns3 *cdns)
> +{
> +       debugfs_remove_recursive(cdns->root);
> +}
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> new file mode 100644
> index 000000000000..b0c32302eb0b
> --- /dev/null
> +++ b/drivers/usb/cdns3/drd.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/usb/otg.h>
> +
> +#include "gadget.h"
> +#include "drd.h"
> +#include "core.h"
> +
> +static int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on);
> +static int cdns3_drd_switch_host(struct cdns3 *cdns, int on);
> +
> +/**
> + * cdns3_set_mode - change mode of OTG Core
> + * @cdns: pointer to context structure
> + * @mode: selected mode from cdns_role
> + */
> +void cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
> +{
> +       u32 reg;
> +
> +       cdns->current_dr_mode = mode;
> +
> +       switch (mode) {
> +       case USB_DR_MODE_PERIPHERAL:
> +               dev_info(cdns->dev, "Set controller to Gadget mode\n");
> +               cdns3_drd_switch_gadget(cdns, 1);
> +               break;
> +       case USB_DR_MODE_HOST:
> +               dev_info(cdns->dev, "Set controller to Host mode\n");
> +               cdns3_drd_switch_host(cdns, 1);
> +               break;
> +       case USB_DR_MODE_OTG:
> +               dev_info(cdns->dev, "Set controller to OTG mode\n");
> +               if (cdns->version == CDNS3_CONTROLLER_V1) {
> +                       reg = readl(&cdns->otg_v1_regs->override);
> +                       reg |= OVERRIDE_IDPULLUP;
> +                       writel(reg, &cdns->otg_v1_regs->override);
> +               } else {
> +                       reg = readl(&cdns->otg_v0_regs->ctrl1);
> +                       reg |= OVERRIDE_IDPULLUP_V0;
> +                       writel(reg, &cdns->otg_v0_regs->ctrl1);
> +               }
> +
> +               /*
> +                * Hardware specification says: "ID_VALUE must be valid within
> +                * 50ms after idpullup is set to '1" so driver must wait
> +                * 50ms before reading this pin.
> +                */
> +               usleep_range(50000, 60000);
> +               break;
> +       default:
> +               cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +               dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
> +               return;
> +       }
> +}
> +
> +int cdns3_get_id(struct cdns3 *cdns)
> +{
> +       int id;
> +
> +       id = readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
> +       dev_dbg(cdns->dev, "OTG ID: %d", id);
> +       return  1 ; //id;
> +}
> +
> +int cdns3_is_host(struct cdns3 *cdns)
> +{
> +       if (cdns->current_dr_mode == USB_DR_MODE_HOST)
> +               return 1;
> +       else if (!cdns3_get_id(cdns))
> +               return 1;
> +
> +       return 0;
> +}
> +
> +int cdns3_is_device(struct cdns3 *cdns)
> +{
> +       if (cdns->current_dr_mode == USB_DR_MODE_PERIPHERAL)
> +               return 1;
> +       else if (cdns->current_dr_mode == USB_DR_MODE_OTG)
> +               if (cdns3_get_id(cdns))
> +                       return 1;
> +
> +       return 0;
> +}
> +
> +/**
> + * cdns3_otg_disable_irq - Disable all OTG interrupts
> + * @cdns: Pointer to controller context structure
> + */
> +static void cdns3_otg_disable_irq(struct cdns3 *cdns)
> +{
> +       writel(0, &cdns->otg_regs->ien);
> +}
> +
> +/**
> + * cdns3_otg_enable_irq - enable id and sess_valid interrupts
> + * @cdns: Pointer to controller context structure
> + */
> +static void cdns3_otg_enable_irq(struct cdns3 *cdns)
> +{
> +       writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
> +              OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_regs->ien);
> +}
> +
> +/**
> + * cdns3_drd_switch_host - start/stop host
> + * @cdns: Pointer to controller context structure
> + * @on: 1 for start, 0 for stop
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
> +{
> +       int ret;
> +       u32 reg = OTGCMD_OTG_DIS;
> +
> +       /* switch OTG core */
> +       if (on) {
> +               writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +
> +               dev_dbg(cdns->dev, "Waiting for Host mode is turned on\n");
> +               ret = cdns3_handshake(&cdns->otg_regs->sts, OTGSTS_XHCI_READY,
> +                                     OTGSTS_XHCI_READY, 100000);
> +
> +               if (ret)
> +                       return ret;
> +       } else {
> +               usleep_range(30, 40);
> +               writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> +                      OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> +                      &cdns->otg_regs->cmd);
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * cdns3_drd_switch_gadget - start/stop gadget
> + * @cdns: Pointer to controller context structure
> + * @on: 1 for start, 0 for stop
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on)
> +{
> +       int ret;
> +       u32 reg = OTGCMD_OTG_DIS;
> +
> +       /* switch OTG core */
> +       if (on) {
> +               writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +
> +               dev_dbg(cdns->dev, "Waiting for Device mode is turned on\n");
> +
> +               ret = cdns3_handshake(&cdns->otg_regs->sts, OTGSTS_DEV_READY,
> +                                     OTGSTS_DEV_READY, 100000);
> +
> +               if (ret)
> +                       return ret;
> +       } else {
> +               /*
> +                * driver should wait at least 10us after disabling Device
> +                * before turning-off Device (DEV_BUS_DROP)
> +                */
> +               usleep_range(20, 30);
> +               writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> +                      OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> +                      &cdns->otg_regs->cmd);
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * cdns3_init_otg_mode - initialize drd controller
> + * @cdns: Pointer to controller context structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static void cdns3_init_otg_mode(struct cdns3 *cdns)
> +{
> +       cdns3_otg_disable_irq(cdns);
> +       /* clear all interrupts */
> +       writel(~0, &cdns->otg_regs->ivect);
> +
> +       cdns3_set_mode(cdns, USB_DR_MODE_OTG);
> +
> +       if (cdns3_is_host(cdns))
> +               cdns3_drd_switch_host(cdns, 1);
> +       else
> +               cdns3_drd_switch_gadget(cdns, 1);
> +
> +       cdns3_otg_enable_irq(cdns);
> +}
> +
> +/**
> + * cdns3_drd_update_mode - initialize mode of operation
> + * @cdns: Pointer to controller context structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +int cdns3_drd_update_mode(struct cdns3 *cdns)
> +{
> +       int ret = 0;
> +
> +       if (cdns->desired_dr_mode == cdns->current_dr_mode)
> +               return ret;
> +
> +       cdns3_drd_switch_gadget(cdns, 0);
> +       cdns3_drd_switch_host(cdns, 0);
> +
> +       switch (cdns->desired_dr_mode) {
> +       case USB_DR_MODE_PERIPHERAL:
> +               cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
> +               break;
> +       case USB_DR_MODE_HOST:
> +               cdns3_set_mode(cdns, USB_DR_MODE_HOST);
> +               break;
> +       case USB_DR_MODE_OTG:
> +               cdns3_init_otg_mode(cdns);
> +               break;
> +       default:
> +               dev_err(cdns->dev, "Unsupported mode of operation %d\n",
> +                       cdns->dr_mode);
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * cdns3_drd_irq - interrupt handler for OTG events
> + *
> + * @irq: irq number for cdns3 core device
> + * @data: structure of cdns3
> + *
> + * Returns IRQ_HANDLED or IRQ_NONE
> + */
> +static irqreturn_t cdns3_drd_irq(int irq, void *data)
> +{
> +       irqreturn_t ret = IRQ_NONE;
> +       struct cdns3 *cdns = data;
> +       u32 reg;
> +
> +       if (cdns->dr_mode != USB_DR_MODE_OTG)
> +               return ret;
> +
> +       reg = readl(&cdns->otg_regs->ivect);
> +
> +       if (!reg)
> +               return ret;
> +
> +       if (reg & OTGIEN_ID_CHANGE_INT) {
> +               dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
> +                       cdns3_get_id(cdns));
> +
> +               queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       writel(~0, &cdns->otg_regs->ivect);
> +       return ret;
> +}
> +
> +int cdns3_drd_init(struct cdns3 *cdns)
> +{
> +       void __iomem *regs;
> +       int ret = 0;
> +       u32 state;
> +
> +       regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
> +
> +       /* Detection of DRD version. Controller has been released
> +        * in two versions. Both are similar, but they have same changes
> +        * in register maps.
> +        * The first register in old version is command register and it's read
> +        * only, so driver should read 0 from it. On the other hand, in v1
> +        * the first register contains device ID number which is not set to 0.
> +        * Driver uses this fact to detect the proper version of
> +        * controller.
> +        */
> +       cdns->otg_v0_regs = regs;
> +       if (!readl(&cdns->otg_v0_regs->cmd)) {
> +               cdns->version  = CDNS3_CONTROLLER_V0;
> +               cdns->otg_v1_regs = NULL;
> +               cdns->otg_regs = regs;
> +               dev_info(cdns->dev, "DRD version v0 (%08x)\n",
> +                        readl(&cdns->otg_v0_regs->version));
> +       } else {
> +               cdns->otg_v0_regs = NULL;
> +               cdns->otg_v1_regs = regs;
> +               cdns->otg_regs = (void *)&cdns->otg_v1_regs->cmd;
> +               cdns->version  = CDNS3_CONTROLLER_V1;
> +               dev_info(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
> +                        readl(&cdns->otg_v1_regs->did),
> +                        readl(&cdns->otg_v1_regs->rid));
> +       }
> +
> +       state = OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
> +
> +       /* Update dr_mode according to STRAP configuration. */
> +       cdns->dr_mode = USB_DR_MODE_OTG;
> +       if (state == OTGSTS_STRAP_HOST) {
> +               dev_info(cdns->dev, "Controller strapped to HOST\n");
> +               cdns->dr_mode = USB_DR_MODE_HOST;
> +       } else if (state == OTGSTS_STRAP_GADGET) {
> +               dev_info(cdns->dev, "Controller strapped to PERIPHERAL\n");
> +               cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
> +       }
> +
> +       cdns->desired_dr_mode = cdns->dr_mode;
> +       cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +
> +       ret = devm_request_threaded_irq(cdns->dev, cdns->irq, cdns3_drd_irq,
> +                                       NULL, IRQF_SHARED,
> +                                       dev_name(cdns->dev), cdns);
> +
> +       if (ret)
> +               return ret;
> +
> +       state = readl(&cdns->otg_regs->sts);
> +       if (OTGSTS_OTG_NRDY(state) != 0) {
> +               dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
> +               return -ENODEV;
> +       }
> +
> +       ret = cdns3_drd_update_mode(cdns);
> +
> +       return ret;
> +}
> +
> +int cdns3_drd_exit(struct cdns3 *cdns)
> +{
> +       return cdns3_drd_switch_host(cdns, 0);
> +}
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> new file mode 100644
> index 000000000000..6a29cdcb492d
> --- /dev/null
> +++ b/drivers/usb/cdns3/drd.h
> @@ -0,0 +1,162 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USB3 DRD header file.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +#ifndef __LINUX_CDNS3_DRD
> +#define __LINUX_CDNS3_DRD
> +
> +#include <linux/usb/otg.h>
> +#include <linux/phy/phy.h>
> +#include "core.h"
> +
> +/*  DRD register interface for version v1. */
> +struct cdns3_otg_regs {
> +       __le32 did;
> +       __le32 rid;
> +       __le32 capabilities;
> +       __le32 reserved1;
> +       __le32 cmd;
> +       __le32 sts;
> +       __le32 state;
> +       __le32 reserved2;
> +       __le32 ien;
> +       __le32 ivect;
> +       __le32 refclk;
> +       __le32 tmr;
> +       __le32 reserved3[4];
> +       __le32 simulate;
> +       __le32 override;
> +       __le32 susp_ctrl;
> +       __le32 reserved4;
> +       __le32 anasts;
> +       __le32 adp_ramp_time;
> +       __le32 ctrl1;
> +       __le32 ctrl2;
> +};
> +
> +/*  DRD register interface for version v0. */
> +struct cdns3_otg_legacy_regs {
> +       __le32 cmd;
> +       __le32 sts;
> +       __le32 state;
> +       __le32 refclk;
> +       __le32 ien;
> +       __le32 ivect;
> +       __le32 reserved1[3];
> +       __le32 tmr;
> +       __le32 reserved2[2];
> +       __le32 version;
> +       __le32 capabilities;
> +       __le32 reserved3[2];
> +       __le32 simulate;
> +       __le32 reserved4[5];
> +       __le32 ctrl1;
> +};
> +
> +/*
> + * Common registers interface for both version of DRD.
> + */
> +struct cdns3_otg_common_regs {
> +       __le32 cmd;
> +       __le32 sts;
> +       __le32 state;
> +       __le32 different1;
> +       __le32 ien;
> +       __le32 ivect;
> +};
> +
> +/* CDNS_RID - bitmasks */
> +#define CDNS_RID(p)                    ((p) & GENMASK(15, 0))
> +
> +/* CDNS_VID - bitmasks */
> +#define CDNS_DID(p)                    ((p) & GENMASK(31, 0))
> +
> +/* OTGCMD - bitmasks */
> +/* "Request the bus for Device mode. */
> +#define OTGCMD_DEV_BUS_REQ             BIT(0)
> +/* Request the bus for Host mode */
> +#define OTGCMD_HOST_BUS_REQ            BIT(1)
> +/* Enable OTG mode. */
> +#define OTGCMD_OTG_EN                  BIT(2)
> +/* Disable OTG mode */
> +#define OTGCMD_OTG_DIS                 BIT(3)
> +/*"Configure OTG as A-Device. */
> +#define OTGCMD_A_DEV_EN                        BIT(4)
> +/*"Configure OTG as A-Device. */
> +#define OTGCMD_A_DEV_DIS               BIT(5)
> +/* Drop the bus for Device mod e. */
> +#define OTGCMD_DEV_BUS_DROP            BIT(8)
> +/* Drop the bus for Host mode*/
> +#define OTGCMD_HOST_BUS_DROP           BIT(9)
> +/* Power Down USBSS-DEV. */
> +#define OTGCMD_DEV_POWER_OFF           BIT(11)
> +/* Power Down CDNSXHCI. */
> +#define OTGCMD_HOST_POWER_OFF          BIT(12)
> +
> +/* OTGIEN - bitmasks */
> +/* ID change interrupt enable */
> +#define OTGIEN_ID_CHANGE_INT           BIT(0)
> +/* Vbusvalid fall detected interrupt enable.*/
> +#define OTGIEN_VBUSVALID_RISE_INT      BIT(4)
> +/* Vbusvalid fall detected interrupt enable */
> +#define OTGIEN_VBUSVALID_FALL_INT      BIT(5)
> +
> +/* OTGSTS - bitmasks */
> +/*
> + * Current value of the ID pin. It is only valid when idpullup in
> + *  OTGCTRL1_TYPE register is set to '1'.
> + */
> +#define OTGSTS_ID_VALUE                        BIT(0)
> +/* Current value of the vbus_valid */
> +#define OTGSTS_VBUS_VALID              BIT(1)
> +/* Current value of the b_sess_vld */
> +#define OTGSTS_SESSION_VALID           BIT(2)
> +/*Device mode is active*/
> +#define OTGSTS_DEV_ACTIVE              BIT(3)
> +/* Host mode is active. */
> +#define OTGSTS_HOST_ACTIVE             BIT(4)
> +/* OTG Controller not ready. */
> +#define OTGSTS_OTG_NRDY_MASK           BIT(11)
> +#define OTGSTS_OTG_NRDY(p)             ((p) & OTGSTS_OTG_NRDY_MASK)
> +/*
> + * Value of the strap pins.
> + * 000 - no default configuration
> + * 010 - Controller initiall configured as Host
> + * 100 - Controller initially configured as Device
> + */
> +#define OTGSTS_STRAP(p)                        (((p) & GENMASK(14, 12)) >> 12)
> +#define OTGSTS_STRAP_NO_DEFAULT_CFG    0x00
> +#define OTGSTS_STRAP_HOST_OTG          0x01
> +#define OTGSTS_STRAP_HOST              0x02
> +#define OTGSTS_STRAP_GADGET            0x04
> +/* Host mode is turned on. */
> +#define OTGSTS_XHCI_READY              BIT(26)
> +/* "Device mode is turned on .*/
> +#define OTGSTS_DEV_READY               BIT(27)
> +
> +/* OTGSTATE- bitmasks */
> +#define OTGSTATE_HOST_STATE_MASK       GENMASK(5, 3)
> +#define OTGSTATE_HOST_STATE_IDLE       0x0
> +#define OTGSTATE_HOST_STATE_VBUS_FALL   0x7
> +#define OTGSTATE_HOST_STATE(p)         (((p) & OTGSTATE_HOST_STATE_MASK) >> 3)
> +
> +/* OTGREFCLK - bitmasks */
> +#define OTGREFCLK_STB_CLK_SWITCH_EN    BIT(31)
> +
> +/* OVERRIDE - bitmasks */
> +#define OVERRIDE_IDPULLUP              BIT(0)
> +/* Only for CDNS3_CONTROLLER_V0 version */
> +#define OVERRIDE_IDPULLUP_V0           BIT(24)
> +
> +int cdns3_is_host(struct cdns3 *cdns);
> +int cdns3_is_device(struct cdns3 *cdns);
> +int cdns3_get_id(struct cdns3 *cdns);
> +int cdns3_drd_init(struct cdns3 *cdns);
> +int cdns3_drd_exit(struct cdns3 *cdns);
> +int cdns3_drd_update_mode(struct cdns3 *cdns);
> +
> +#endif /* __LINUX_CDNS3_DRD */
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> new file mode 100644
> index 000000000000..89cf1cde1555
> --- /dev/null
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -0,0 +1,896 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - gadget side.
> + *
> + * Copyright (C) 2018 Cadence Design Systems.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Pawel Jez <pjez@cadence.com>,
> + *          Pawel Laszczak <pawell@cadence.com>
> + *         Peter Chen <peter.chen@nxp.com>
> + */
> +
> +#include <linux/usb/composite.h>
> +
> +#include "gadget.h"
> +#include "trace.h"
> +
> +static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
> +       .bLength = USB_DT_ENDPOINT_SIZE,
> +       .bDescriptorType = USB_DT_ENDPOINT,
> +       .bmAttributes = USB_ENDPOINT_XFER_CONTROL,
> +};
> +
> +/**
> + * cdns3_ep0_run_transfer - Do transfer on default endpoint hardware
> + * @priv_dev: extended gadget object
> + * @dma_addr: physical address where data is/will be stored
> + * @length: data length
> + * @erdy: set it to 1 when ERDY packet should be sent -
> + *        exit from flow control state
> + */
> +static void cdns3_ep0_run_transfer(struct cdns3_device *priv_dev,
> +                                  dma_addr_t dma_addr,
> +                                  unsigned int length, int erdy)
> +{
> +       struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
> +       struct cdns3_endpoint *priv_ep = priv_dev->eps[0];
> +
> +       priv_ep->trb_pool->buffer = TRB_BUFFER(dma_addr);
> +       priv_ep->trb_pool->length = TRB_LEN(length);
> +       priv_ep->trb_pool->control = TRB_CYCLE | TRB_IOC | TRB_TYPE(TRB_NORMAL);
> +
> +       trace_cdns3_prepare_trb(priv_ep, priv_ep->trb_pool);
> +
> +       cdns3_select_ep(priv_dev, priv_dev->ep0_data_dir);
> +
> +       writel(EP_STS_TRBERR, &regs->ep_sts);
> +       writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma), &regs->ep_traddr);
> +       trace_cdns3_doorbell_ep0(priv_dev->ep0_data_dir ? "ep0in" : "ep0out",
> +                                readl(&regs->ep_traddr));
> +
> +       /* TRB should be prepared before starting transfer */
> +       writel(EP_CMD_DRDY, &regs->ep_cmd);
> +
> +       if (erdy)
> +               writel(EP_CMD_ERDY, &priv_dev->regs->ep_cmd);
> +}
> +
> +/**
> + * cdns3_ep0_delegate_req - Returns status of handling setup packet
> + * Setup is handled by gadget driver
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns zero on success or negative value on failure
> + */
> +static int cdns3_ep0_delegate_req(struct cdns3_device *priv_dev,
> +                                 struct usb_ctrlrequest *ctrl_req)
> +{
> +       int ret;
> +
> +       spin_unlock(&priv_dev->lock);
> +       priv_dev->setup_pending = 1;
> +       ret = priv_dev->gadget_driver->setup(&priv_dev->gadget, ctrl_req);
> +       priv_dev->setup_pending = 0;
> +       spin_lock(&priv_dev->lock);
> +       return ret;
> +}
> +
> +static void cdns3_prepare_setup_packet(struct cdns3_device *priv_dev)
> +{
> +       priv_dev->ep0_data_dir = 0;
> +       priv_dev->ep0_stage = CDNS3_SETUP_STAGE;
> +       cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma,
> +                              sizeof(struct usb_ctrlrequest), 0);
> +}
> +
> +static void cdns3_ep0_complete_setup(struct cdns3_device *priv_dev,
> +                                    u8 send_stall, u8 send_erdy)
> +{
> +       struct cdns3_endpoint *priv_ep = priv_dev->eps[0];
> +       struct usb_request *request;
> +
> +       request = cdns3_next_request(&priv_ep->pending_req_list);
> +       if (request)
> +               list_del_init(&request->list);
> +
> +       if (send_stall) {
> +               dev_dbg(priv_dev->dev, "STALL for ep0\n");
> +               /* set_stall on ep0 */
> +               cdns3_select_ep(priv_dev, 0x00);
> +               writel(EP_CMD_SSTALL, &priv_dev->regs->ep_cmd);
> +       } else {
> +               cdns3_prepare_setup_packet(priv_dev);
> +       }
> +
> +       priv_dev->ep0_stage = CDNS3_SETUP_STAGE;
> +       writel((send_erdy ? EP_CMD_ERDY : 0) | EP_CMD_REQ_CMPL,
> +              &priv_dev->regs->ep_cmd);
> +}
> +
> +/**
> + * cdns3_req_ep0_set_configuration - Handling of SET_CONFIG standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, USB_GADGET_DELAYED_STATUS on deferred status stage,
> + * error code on error
> + */
> +static int cdns3_req_ep0_set_configuration(struct cdns3_device *priv_dev,
> +                                          struct usb_ctrlrequest *ctrl_req)
> +{
> +       enum usb_device_state device_state = priv_dev->gadget.state;
> +       struct cdns3_endpoint *priv_ep;
> +       u32 config = le16_to_cpu(ctrl_req->wValue);
> +       int result = 0;
> +       int i;
> +
> +       switch (device_state) {
> +       case USB_STATE_ADDRESS:
> +               /* Configure non-control EPs */
> +               for (i = 0; i < CDNS3_ENDPOINTS_MAX_COUNT; i++) {
> +                       priv_ep = priv_dev->eps[i];
> +                       if (!priv_ep)
> +                               continue;
> +
> +                       if (priv_ep->flags & EP_CLAIMED)
> +                               cdns3_ep_config(priv_ep);
> +               }
> +
> +               result = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
> +
> +               if (result)
> +                       return result;
> +
> +               if (config) {
> +                       cdns3_set_hw_configuration(priv_dev);
> +               } else {
> +                       cdns3_hw_reset_eps_config(priv_dev);
> +                       usb_gadget_set_state(&priv_dev->gadget,
> +                                            USB_STATE_ADDRESS);
> +               }
> +               break;
> +       case USB_STATE_CONFIGURED:
> +               result = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
> +
> +               if (!config && !result) {
> +                       cdns3_hw_reset_eps_config(priv_dev);
> +                       usb_gadget_set_state(&priv_dev->gadget,
> +                                            USB_STATE_ADDRESS);
> +               }
> +               break;
> +       default:
> +               result = -EINVAL;
> +       }
> +
> +       return result;
> +}
> +
> +/**
> + * cdns3_req_ep0_set_address - Handling of SET_ADDRESS standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_set_address(struct cdns3_device *priv_dev,
> +                                    struct usb_ctrlrequest *ctrl_req)
> +{
> +       enum usb_device_state device_state = priv_dev->gadget.state;
> +       u32 reg;
> +       u32 addr;
> +
> +       addr = le16_to_cpu(ctrl_req->wValue);
> +
> +       if (addr > USB_DEVICE_MAX_ADDRESS) {
> +               dev_err(priv_dev->dev,
> +                       "Device address (%d) cannot be greater than %d\n",
> +                       addr, USB_DEVICE_MAX_ADDRESS);
> +               return -EINVAL;
> +       }
> +
> +       if (device_state == USB_STATE_CONFIGURED) {
> +               dev_err(priv_dev->dev,
> +                       "can't set_address from configured state\n");
> +               return -EINVAL;
> +       }
> +
> +       reg = readl(&priv_dev->regs->usb_cmd);
> +
> +       writel(reg | USB_CMD_FADDR(addr) | USB_CMD_SET_ADDR,
> +              &priv_dev->regs->usb_cmd);
> +
> +       usb_gadget_set_state(&priv_dev->gadget,
> +                            (addr ? USB_STATE_ADDRESS : USB_STATE_DEFAULT));
> +
> +       return 0;
> +}
> +
> +/**
> + * cdns3_req_ep0_get_status - Handling of GET_STATUS standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
> +                                   struct usb_ctrlrequest *ctrl)
> +{
> +       __le16 *response_pkt;
> +       u16 usb_status = 0;
> +       u32 recip;
> +       u32 reg;
> +
> +       recip = ctrl->bRequestType & USB_RECIP_MASK;
> +
> +       switch (recip) {
> +       case USB_RECIP_DEVICE:
> +               /* self powered */
> +               if (priv_dev->is_selfpowered)
> +                       usb_status = BIT(USB_DEVICE_SELF_POWERED);
> +
> +               if (priv_dev->wake_up_flag)
> +                       usb_status |= BIT(USB_DEVICE_REMOTE_WAKEUP);
> +
> +               if (priv_dev->gadget.speed != USB_SPEED_SUPER)
> +                       break;
> +
> +               reg = readl(&priv_dev->regs->usb_sts);
> +
> +               if (priv_dev->u1_allowed)
> +                       usb_status |= BIT(USB_DEV_STAT_U1_ENABLED);
> +
> +               if (priv_dev->u2_allowed)
> +                       usb_status |= BIT(USB_DEV_STAT_U2_ENABLED);
> +
> +               break;
> +       case USB_RECIP_INTERFACE:
> +               return cdns3_ep0_delegate_req(priv_dev, ctrl);
> +       case USB_RECIP_ENDPOINT:
> +               /* check if endpoint is stalled */
> +               cdns3_select_ep(priv_dev, ctrl->wIndex);
> +               if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
> +                       usb_status =  BIT(USB_ENDPOINT_HALT);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       response_pkt = (__le16 *)priv_dev->setup_buf;
> +       *response_pkt = cpu_to_le16(usb_status);
> +
> +       cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma,
> +                              sizeof(*response_pkt), 1);
> +       return 0;
> +}
> +
> +static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
> +                                          struct usb_ctrlrequest *ctrl,
> +                                          int set)
> +{
> +       enum usb_device_state state;
> +       enum usb_device_speed speed;
> +       int ret = 0;
> +       u32 wValue;
> +       u32 wIndex;
> +       u16 tmode;
> +
> +       wValue = le16_to_cpu(ctrl->wValue);
> +       wIndex = le16_to_cpu(ctrl->wIndex);
> +       state = priv_dev->gadget.state;
> +       speed = priv_dev->gadget.speed;
> +
> +       switch (ctrl->wValue) {
> +       case USB_DEVICE_REMOTE_WAKEUP:
> +               priv_dev->wake_up_flag = !!set;
> +               break;
> +       case USB_DEVICE_U1_ENABLE:
> +               if (state != USB_STATE_CONFIGURED || speed != USB_SPEED_SUPER)
> +                       return -EINVAL;
> +
> +               priv_dev->u1_allowed = !!set;
> +               break;
> +       case USB_DEVICE_U2_ENABLE:
> +               if (state != USB_STATE_CONFIGURED || speed != USB_SPEED_SUPER)
> +                       return -EINVAL;
> +
> +               priv_dev->u2_allowed = !!set;
> +               break;
> +       case USB_DEVICE_LTM_ENABLE:
> +               ret = -EINVAL;
> +               break;
> +       case USB_DEVICE_TEST_MODE:
> +               if (state != USB_STATE_CONFIGURED || speed > USB_SPEED_HIGH)
> +                       return -EINVAL;
> +
> +               tmode = le16_to_cpu(ctrl->wIndex);
> +
> +               if (!set || (tmode & 0xff) != 0)
> +                       return -EINVAL;
> +
> +               switch (tmode >> 8) {
> +               case TEST_J:
> +               case TEST_K:
> +               case TEST_SE0_NAK:
> +               case TEST_PACKET:
> +                       cdns3_ep0_complete_setup(priv_dev, 0, 1);
> +                       /**
> +                        *  Little delay to give the controller some time
> +                        * for sending status stage.
> +                        * This time should be less then 3ms.
> +                        */
> +                       usleep_range(1000, 2000);
> +                       cdns3_set_register_bit(&priv_dev->regs->usb_cmd,
> +                                              USB_CMD_STMODE |
> +                                              USB_STS_TMODE_SEL(tmode - 1));
> +                       break;
> +               default:
> +                       ret = -EINVAL;
> +               }
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int cdns3_ep0_feature_handle_intf(struct cdns3_device *priv_dev,
> +                                        struct usb_ctrlrequest *ctrl,
> +                                        int set)
> +{
> +       u32 wValue;
> +       int ret = 0;
> +
> +       wValue = le16_to_cpu(ctrl->wValue);
> +
> +       switch (wValue) {
> +       case USB_INTRF_FUNC_SUSPEND:
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
> +                                            struct usb_ctrlrequest *ctrl,
> +                                            int set)
> +{
> +       struct cdns3_endpoint *priv_ep;
> +       int ret = 0;
> +       u8 index;
> +
> +       if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
> +               return -EINVAL;
> +
> +       if (!(ctrl->wIndex & ~USB_DIR_IN))
> +               return 0;
> +
> +       index = cdns3_ep_addr_to_index(ctrl->wIndex);
> +       priv_ep = priv_dev->eps[index];
> +
> +       cdns3_select_ep(priv_dev, ctrl->wIndex);
> +
> +       if (set) {
> +               writel(EP_CMD_SSTALL, &priv_dev->regs->ep_cmd);
> +               priv_ep->flags |= EP_STALL;
> +       } else {
> +               struct usb_request *request;
> +
> +               if (priv_dev->eps[index]->flags & EP_WEDGE) {
> +                       cdns3_select_ep(priv_dev, 0x00);
> +                       return 0;
> +               }
> +
> +               writel(EP_CMD_CSTALL | EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> +
> +               /* wait for EPRST cleared */
> +               ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
> +                                     EP_CMD_EPRST, 0, 100);
> +               if (ret)
> +                       return -EINVAL;
> +
> +               priv_ep->flags &= ~EP_STALL;
> +
> +               request = cdns3_next_request(&priv_ep->pending_req_list);
> +               if (request)
> +                       cdns3_ep_run_transfer(priv_ep, request);
> +       }
> +       return ret;
> +}
> +
> +/**
> + * cdns3_req_ep0_handle_feature -
> + * Handling of GET/SET_FEATURE standard USB request
> + *
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + * @set: must be set to 1 for SET_FEATURE request
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_handle_feature(struct cdns3_device *priv_dev,
> +                                       struct usb_ctrlrequest *ctrl,
> +                                       int set)
> +{
> +       int ret = 0;
> +       u32 recip;
> +
> +       recip = ctrl->bRequestType & USB_RECIP_MASK;
> +
> +       switch (recip) {
> +       case USB_RECIP_DEVICE:
> +               ret = cdns3_ep0_feature_handle_device(priv_dev, ctrl, set);
> +               break;
> +       case USB_RECIP_INTERFACE:
> +               ret = cdns3_ep0_feature_handle_intf(priv_dev, ctrl, set);
> +               break;
> +       case USB_RECIP_ENDPOINT:
> +               ret = cdns3_ep0_feature_handle_endpoint(priv_dev, ctrl, set);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * cdns3_req_ep0_set_sel - Handling of SET_SEL standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_set_sel(struct cdns3_device *priv_dev,
> +                                struct usb_ctrlrequest *ctrl_req)
> +{
> +       if (priv_dev->gadget.state < USB_STATE_ADDRESS)
> +               return -EINVAL;
> +
> +       if (ctrl_req->wLength != 6) {
> +               dev_err(priv_dev->dev, "Set SEL should be 6 bytes, got %d\n",
> +                       ctrl_req->wLength);
> +               return -EINVAL;
> +       }
> +
> +       cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma, 6, 1);
> +       return 0;
> +}
> +
> +/**
> + * cdns3_req_ep0_set_isoch_delay -
> + * Handling of GET_ISOCH_DELAY standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_set_isoch_delay(struct cdns3_device *priv_dev,
> +                                        struct usb_ctrlrequest *ctrl_req)
> +{
> +       if (ctrl_req->wIndex || ctrl_req->wLength)
> +               return -EINVAL;
> +
> +       priv_dev->isoch_delay = ctrl_req->wValue;
> +
> +       return 0;
> +}
> +
> +/**
> + * cdns3_ep0_standard_request - Handling standard USB requests
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_ep0_standard_request(struct cdns3_device *priv_dev,
> +                                     struct usb_ctrlrequest *ctrl_req)
> +{
> +       int ret;
> +
> +       switch (ctrl_req->bRequest) {
> +       case USB_REQ_SET_ADDRESS:
> +               ret = cdns3_req_ep0_set_address(priv_dev, ctrl_req);
> +               break;
> +       case USB_REQ_SET_CONFIGURATION:
> +               ret = cdns3_req_ep0_set_configuration(priv_dev, ctrl_req);
> +               break;
> +       case USB_REQ_GET_STATUS:
> +               ret = cdns3_req_ep0_get_status(priv_dev, ctrl_req);
> +               break;
> +       case USB_REQ_CLEAR_FEATURE:
> +               ret = cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 0);
> +               break;
> +       case USB_REQ_SET_FEATURE:
> +               ret = cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 1);
> +               break;
> +       case USB_REQ_SET_SEL:
> +               ret = cdns3_req_ep0_set_sel(priv_dev, ctrl_req);
> +               break;
> +       case USB_REQ_SET_ISOCH_DELAY:
> +               ret = cdns3_req_ep0_set_isoch_delay(priv_dev, ctrl_req);
> +               break;
> +       default:
> +               ret = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static void __pending_setup_status_handler(struct cdns3_device *priv_dev)
> +{
> +       struct usb_request *request = priv_dev->pending_status_request;
> +
> +       if (priv_dev->status_completion_no_call && request &&
> +           request->complete) {
> +               request->complete(&priv_dev->eps[0]->endpoint, request);
> +               priv_dev->status_completion_no_call = 0;
> +       }
> +}
> +
> +void cdns3_pending_setup_status_handler(struct work_struct *work)
> +{
> +       struct cdns3_device *priv_dev = container_of(work, struct cdns3_device,
> +                       pending_status_wq);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +       __pending_setup_status_handler(priv_dev);
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +}
> +
> +/**
> + * cdns3_gadget_ep_giveback - call struct usb_request's ->complete callback
> + * @priv_ep: The endpoint to whom the request belongs to
> + * @priv_req: The request we're giving back
> + * @status: completion code for the request
> + *
> + * Must be called with controller's lock held and interrupts disabled. This
> + * function will unmap @req and call its ->complete() callback to notify upper
> + * layers that it has completed.
> + */
> +
> +void cdns3_gadget_ep0_giveback(struct cdns3_device *priv_dev,
> +                              int status)
> +{
> +       struct cdns3_endpoint *priv_ep;
> +       struct usb_request *request;
> +
> +       priv_ep = priv_dev->eps[0];
> +       request = cdns3_next_request(&priv_ep->pending_req_list);
> +
> +       priv_ep->dir = priv_dev->ep0_data_dir;
> +       cdns3_gadget_giveback(priv_ep, to_cdns3_request(request), status);
> +}
> +
> +/**
> + * cdns3_ep0_setup_phase - Handling setup USB requests
> + * @priv_dev: extended gadget object
> + */
> +static void cdns3_ep0_setup_phase(struct cdns3_device *priv_dev)
> +{
> +       struct usb_ctrlrequest *ctrl = priv_dev->setup_buf;
> +       struct cdns3_endpoint *priv_ep = priv_dev->eps[0];
> +       int result;
> +
> +       priv_dev->ep0_data_dir = ctrl->bRequestType & USB_DIR_IN;
> +
> +       trace_cdns3_ctrl_req(ctrl);
> +
> +       if (!list_empty(&priv_ep->pending_req_list)) {
> +               struct usb_request *request;
> +
> +               request = cdns3_next_request(&priv_ep->pending_req_list);
> +               priv_ep->dir = priv_dev->ep0_data_dir;
> +               cdns3_gadget_giveback(priv_ep, to_cdns3_request(request),
> +                                     -ECONNRESET);
> +       }
> +
> +       if (le16_to_cpu(ctrl->wLength))
> +               priv_dev->ep0_stage = CDNS3_DATA_STAGE;
> +       else
> +               priv_dev->ep0_stage = CDNS3_STATUS_STAGE;
> +
> +       if ((ctrl->bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
> +               result = cdns3_ep0_standard_request(priv_dev, ctrl);
> +       else
> +               result = cdns3_ep0_delegate_req(priv_dev, ctrl);
> +
> +       if (priv_dev->ep0_stage == CDNS3_STATUS_STAGE &&
> +           result != USB_GADGET_DELAYED_STATUS) {
> +               cdns3_ep0_complete_setup(priv_dev, 0, 1);
> +       } else if (result < 0) {
> +               cdns3_ep0_complete_setup(priv_dev, 1, 1);
> +       }
> +}
> +
> +static void cdns3_transfer_completed(struct cdns3_device *priv_dev)
> +{
> +       struct cdns3_endpoint *priv_ep = priv_dev->eps[0];
> +
> +       if (!list_empty(&priv_ep->pending_req_list)) {
> +               struct usb_request *request;
> +
> +               trace_cdns3_complete_trb(priv_ep, priv_ep->trb_pool);
> +               request = cdns3_next_request(&priv_ep->pending_req_list);
> +
> +               request->actual =
> +                       TRB_LEN(le32_to_cpu(priv_ep->trb_pool->length));
> +
> +               priv_ep->dir = priv_dev->ep0_data_dir;
> +               cdns3_gadget_giveback(priv_ep, to_cdns3_request(request), 0);
> +       }
> +
> +       cdns3_ep0_complete_setup(priv_dev, 0, 0);
> +}
> +
> +/**
> + * cdns3_check_new_setup - Check if controller receive new SETUP packet.
> + * @priv_dev: extended gadget object
> + *
> + * The SETUP packet can be kept in on-chip memory or in system memory.
> + */
> +static bool cdns3_check_new_setup(struct cdns3_device *priv_dev)
> +{
> +       u32 ep_sts_reg;
> +
> +       cdns3_select_ep(priv_dev, 0 | USB_DIR_OUT);
> +       ep_sts_reg = readl(&priv_dev->regs->ep_sts);
> +
> +       return !!(ep_sts_reg & (EP_STS_SETUP | EP_STS_STPWAIT));
> +}
> +
> +/**
> + * cdns3_check_ep0_interrupt_proceed - Processes interrupt related to endpoint 0
> + * @priv_dev: extended gadget object
> + * @dir: USB_DIR_IN for IN direction, USB_DIR_OUT for OUT direction
> + */
> +void cdns3_check_ep0_interrupt_proceed(struct cdns3_device *priv_dev, int dir)
> +{
> +       u32 ep_sts_reg;
> +
> +       cdns3_select_ep(priv_dev, dir);
> +
> +       ep_sts_reg = readl(&priv_dev->regs->ep_sts);
> +       writel(ep_sts_reg, &priv_dev->regs->ep_sts);
> +
> +       trace_cdns3_ep0_irq(priv_dev, ep_sts_reg);
> +
> +       __pending_setup_status_handler(priv_dev);
> +
> +       if ((ep_sts_reg & EP_STS_SETUP)) {
> +               cdns3_ep0_setup_phase(priv_dev);
> +       } else if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP)) {
> +               priv_dev->ep0_data_dir = dir;
> +               cdns3_transfer_completed(priv_dev);
> +       }
> +
> +       if (ep_sts_reg & EP_STS_DESCMIS) {
> +               if (dir == 0 && !priv_dev->setup_pending)
> +                       cdns3_prepare_setup_packet(priv_dev);
> +       }
> +}
> +
> +/**
> + * cdns3_gadget_ep0_enable
> + * Function shouldn't be called by gadget driver,
> + * endpoint 0 is allways active
> + */
> +static int cdns3_gadget_ep0_enable(struct usb_ep *ep,
> +                                  const struct usb_endpoint_descriptor *desc)
> +{
> +       return -EINVAL;
> +}
> +
> +/**
> + * cdns3_gadget_ep0_disable
> + * Function shouldn't be called by gadget driver,
> + * endpoint 0 is allways active
> + */
> +static int cdns3_gadget_ep0_disable(struct usb_ep *ep)
> +{
> +       return -EINVAL;
> +}
> +
> +/**
> + * cdns3_gadget_ep0_set_halt
> + * @ep: pointer to endpoint zero object
> + * @value: 1 for set stall, 0 for clear stall
> + *
> + * Returns 0
> + */
> +static int cdns3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
> +{
> +       /* TODO */
> +       return 0;
> +}
> +
> +/**
> + * cdns3_gadget_ep0_queue Transfer data on endpoint zero
> + * @ep: pointer to endpoint zero object
> + * @request: pointer to request object
> + * @gfp_flags: gfp flags
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +static int cdns3_gadget_ep0_queue(struct usb_ep *ep,
> +                                 struct usb_request *request,
> +                                 gfp_t gfp_flags)
> +{
> +       struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       unsigned long flags;
> +       int erdy_sent = 0;
> +       int ret = 0;
> +
> +       dev_dbg(priv_dev->dev, "Queue to Ep0%s L: %d\n",
> +               priv_dev->ep0_data_dir ? "IN" : "OUT",
> +               request->length);
> +
> +       /* cancel the request if controller receive new SETUP packet. */
> +       if (cdns3_check_new_setup(priv_dev))
> +               return -ECONNRESET;
> +
> +       /* send STATUS stage. Should be called only for SET_CONFIGURATION */
> +       if (priv_dev->ep0_stage == CDNS3_STATUS_STAGE) {
> +               spin_lock_irqsave(&priv_dev->lock, flags);
> +               cdns3_select_ep(priv_dev, 0x00);
> +
> +               erdy_sent = !priv_dev->hw_configured_flag;
> +               cdns3_set_hw_configuration(priv_dev);
> +
> +               if (!erdy_sent)
> +                       cdns3_ep0_complete_setup(priv_dev, 0, 1);
> +
> +               request->actual = 0;
> +               priv_dev->status_completion_no_call = true;
> +               priv_dev->pending_status_request = request;
> +               spin_unlock_irqrestore(&priv_dev->lock, flags);
> +
> +               /*
> +                * Since there is no completion interrupt for status stage,
> +                * it needs to call ->completion in software after
> +                * ep0_queue is back.
> +                */
> +               queue_work(system_freezable_wq, &priv_dev->pending_status_wq);
> +               return 0;
> +       }
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +       if (!list_empty(&priv_ep->pending_req_list)) {
> +               dev_err(priv_dev->dev,
> +                       "can't handle multiple requests for ep0\n");
> +               spin_unlock_irqrestore(&priv_dev->lock, flags);
> +               return -EBUSY;
> +       }
> +
> +       ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
> +                                           priv_dev->ep0_data_dir);
> +       if (ret) {
> +               spin_unlock_irqrestore(&priv_dev->lock, flags);
> +               dev_err(priv_dev->dev, "failed to map request\n");
> +               return -EINVAL;
> +       }
> +
> +       request->status = -EINPROGRESS;
> +       list_add_tail(&request->list, &priv_ep->pending_req_list);
> +       cdns3_ep0_run_transfer(priv_dev, request->dma, request->length, 1);
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +
> +       return ret;
> +}
> +
> +/**
> + * cdns3_gadget_ep_set_wedge Set wedge on selected endpoint
> + * @ep: endpoint object
> + *
> + * Returns 0
> + */
> +int cdns3_gadget_ep_set_wedge(struct usb_ep *ep)
> +{
> +       struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +
> +       dev_dbg(priv_dev->dev, "Wedge for %s\n", ep->name);
> +       cdns3_gadget_ep_set_halt(ep, 1);
> +       priv_ep->flags |= EP_WEDGE;
> +
> +       return 0;
> +}
> +
> +const struct usb_ep_ops cdns3_gadget_ep0_ops = {
> +       .enable = cdns3_gadget_ep0_enable,
> +       .disable = cdns3_gadget_ep0_disable,
> +       .alloc_request = cdns3_gadget_ep_alloc_request,
> +       .free_request = cdns3_gadget_ep_free_request,
> +       .queue = cdns3_gadget_ep0_queue,
> +       .dequeue = cdns3_gadget_ep_dequeue,
> +       .set_halt = cdns3_gadget_ep0_set_halt,
> +       .set_wedge = cdns3_gadget_ep_set_wedge,
> +};
> +
> +/**
> + * cdns3_ep0_config - Configures default endpoint
> + * @priv_dev: extended gadget object
> + *
> + * Functions sets parameters: maximal packet size and enables interrupts
> + */
> +void cdns3_ep0_config(struct cdns3_device *priv_dev)
> +{
> +       struct cdns3_usb_regs __iomem *regs;
> +       struct cdns3_endpoint *priv_ep;
> +       u32 max_packet_size = 64;
> +
> +       regs = priv_dev->regs;
> +
> +       if (priv_dev->gadget.speed == USB_SPEED_SUPER)
> +               max_packet_size = 512;
> +
> +       priv_ep = priv_dev->eps[0];
> +
> +       if (!list_empty(&priv_ep->pending_req_list)) {
> +               struct usb_request *request;
> +
> +               request = cdns3_next_request(&priv_ep->pending_req_list);
> +               list_del_init(&request->list);
> +       }
> +
> +       priv_dev->u1_allowed = 0;
> +       priv_dev->u2_allowed = 0;
> +
> +       priv_dev->gadget.ep0->maxpacket = max_packet_size;
> +       cdns3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(max_packet_size);
> +
> +       /* init ep out */
> +       cdns3_select_ep(priv_dev, USB_DIR_OUT);
> +
> +       writel(EP_CFG_ENABLE | EP_CFG_MAXPKTSIZE(max_packet_size),
> +              &regs->ep_cfg);
> +
> +       writel(EP_STS_EN_SETUPEN | EP_STS_EN_DESCMISEN | EP_STS_EN_TRBERREN,
> +              &regs->ep_sts_en);
> +
> +       /* init ep in */
> +       cdns3_select_ep(priv_dev, USB_DIR_IN);
> +
> +       writel(EP_CFG_ENABLE | EP_CFG_MAXPKTSIZE(max_packet_size),
> +              &regs->ep_cfg);
> +
> +       writel(EP_STS_EN_SETUPEN | EP_STS_EN_TRBERREN, &regs->ep_sts_en);
> +
> +       cdns3_set_register_bit(&regs->usb_conf, USB_CONF_U1DS | USB_CONF_U2DS);
> +}
> +
> +/**
> + * cdns3_init_ep0 Initializes software endpoint 0 of gadget
> + * @priv_dev: extended gadget object
> + * @ep_priv: extended endpoint object
> + *
> + * Returns 0 on success else error code.
> + */
> +int cdns3_init_ep0(struct cdns3_device *priv_dev,
> +                  struct cdns3_endpoint *priv_ep)
> +{
> +       sprintf(priv_ep->name, "ep0");
> +
> +       /* fill linux fields */
> +       priv_ep->endpoint.ops = &cdns3_gadget_ep0_ops;
> +       priv_ep->endpoint.maxburst = 1;
> +       usb_ep_set_maxpacket_limit(&priv_ep->endpoint,
> +                                  CDNS3_EP0_MAX_PACKET_LIMIT);
> +       priv_ep->endpoint.address = 0;
> +       priv_ep->endpoint.caps.type_control = 1;
> +       priv_ep->endpoint.caps.dir_in = 1;
> +       priv_ep->endpoint.caps.dir_out = 1;
> +       priv_ep->endpoint.name = priv_ep->name;
> +       priv_ep->endpoint.desc = &cdns3_gadget_ep0_desc;
> +       priv_dev->gadget.ep0 = &priv_ep->endpoint;
> +       priv_ep->type = USB_ENDPOINT_XFER_CONTROL;
> +
> +       return cdns3_allocate_trb_pool(priv_ep);
> +}
> diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-export.h
> new file mode 100644
> index 000000000000..577469eee961
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget-export.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver - Gadget Export APIs.
> + *
> + * Copyright (C) 2017 NXP
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + */
> +#ifndef __LINUX_CDNS3_GADGET_EXPORT
> +#define __LINUX_CDNS3_GADGET_EXPORT
> +
> +#ifdef CONFIG_USB_CDNS3_GADGET
> +
> +int cdns3_gadget_init(struct cdns3 *cdns);
> +void cdns3_gadget_exit(struct cdns3 *cdns);
> +#else
> +
> +static inline int cdns3_gadget_init(struct cdns3 *cdns)
> +{
> +       return -ENXIO;
> +}
> +
> +static inline void cdns3_gadget_exit(struct cdns3 *cdns) { }
> +
> +#endif
> +
> +#endif /* __LINUX_CDNS3_GADGET_EXPORT */
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> new file mode 100644
> index 000000000000..0d95eb00be37
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -0,0 +1,2102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - gadget side.
> + *
> + * Copyright (C) 2018 Cadence Design Systems.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Pawel Jez <pjez@cadence.com>,
> + *          Pawel Laszczak <pawell@cadence.com>
> + *         Peter Chen <peter.chen@nxp.com>
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/usb/gadget.h>
> +
> +#include "core.h"
> +#include "gadget-export.h"
> +#include "gadget.h"
> +
> +#include "trace.h"
> +
> +static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
> +                                  struct usb_request *request,
> +                                  gfp_t gfp_flags);
> +
> +/**
> + * cdns3_handshake - spin reading  until handshake completes or fails
> + * @ptr: address of device controller register to be read
> + * @mask: bits to look at in result of read
> + * @done: value of those bits when handshake succeeds
> + * @usec: timeout in microseconds
> + *
> + * Returns negative errno, or zero on success
> + *
> + * Success happens when the "mask" bits have the specified value (hardware
> + * handshake done). There are two failure modes: "usec" have passed (major
> + * hardware flakeout), or the register reads as all-ones (hardware removed).
> + */
> +int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
> +{
> +       u32     result;
> +
> +       do {
> +               result = readl(ptr);
> +               if (result == ~(u32)0)  /* card removed */
> +                       return -ENODEV;
> +               result &= mask;
> +               if (result == done)
> +                       return 0;
> +               udelay(1);
> +               usec--;
> +       } while (usec > 0);
> +       return -ETIMEDOUT;
> +}
> +
> +/**
> + * cdns3_set_register_bit - set bit in given register.
> + * @ptr: address of device controller register to be read and changed
> + * @mask: bits requested to set
> + */
> +void cdns3_set_register_bit(void __iomem *ptr, u32 mask)
> +{
> +       mask = readl(ptr) | mask;
> +       writel(mask, ptr);
> +}
> +
> +/**
> + * cdns3_ep_addr_to_index - Macro converts endpoint address to
> + * index of endpoint object in cdns3_device.eps[] container
> + * @ep_addr: endpoint address for which endpoint object is required
> + *
> + */
> +u8 cdns3_ep_addr_to_index(u8 ep_addr)
> +{
> +       return (((ep_addr & 0x7F)) + ((ep_addr & USB_DIR_IN) ? 16 : 0));
> +}
> +
> +/**
> + * cdns3_next_request - returns next request from list
> + * @list: list containing requests
> + *
> + * Returns request or NULL if no requests in list
> + */
> +struct usb_request *cdns3_next_request(struct list_head *list)
> +{
> +       if (list_empty(list))
> +               return NULL;
> +       return list_first_entry_or_null(list, struct usb_request, list);
> +}
> +
> +/**
> + * cdns3_next_priv_request - returns next request from list
> + * @list: list containing requests
> + *
> + * Returns request or NULL if no requests in list
> + */
> +struct cdns3_request *cdns3_next_priv_request(struct list_head *list)
> +{
> +       if (list_empty(list))
> +               return NULL;
> +       return list_first_entry_or_null(list, struct cdns3_request, list);
> +}
> +
> +/**
> + * select_ep - selects endpoint
> + * @priv_dev:  extended gadget object
> + * @ep: endpoint address
> + */
> +void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep)
> +{
> +       if (priv_dev->selected_ep == ep)
> +               return;
> +
> +       priv_dev->selected_ep = ep;
> +       writel(ep, &priv_dev->regs->ep_sel);
> +}
> +
> +dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
> +                                struct cdns3_trb *trb)
> +{
> +       u32 offset = (char *)trb - (char *)priv_ep->trb_pool;
> +
> +       return priv_ep->trb_pool_dma + offset;
> +}
> +
> +int cdns3_ring_size(struct cdns3_endpoint *priv_ep)
> +{
> +       switch (priv_ep->type) {
> +       case USB_ENDPOINT_XFER_ISOC:
> +               return TRB_ISO_RING_SIZE;
> +       case USB_ENDPOINT_XFER_CONTROL:
> +               return TRB_CTRL_RING_SIZE;
> +       default:
> +               return TRB_RING_SIZE;
> +       }
> +}
> +
> +/**
> + * cdns3_allocate_trb_pool - Allocates TRB's pool for selected endpoint
> + * @priv_ep:  endpoint object
> + *
> + * Function will return 0 on success or -ENOMEM on allocation error
> + */
> +int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
> +{
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       int ring_size = cdns3_ring_size(priv_ep);
> +       struct cdns3_trb *link_trb;
> +
> +       if (!priv_ep->trb_pool) {
> +               priv_ep->trb_pool = dma_zalloc_coherent(priv_dev->sysdev,
> +                                                       ring_size,
> +                                                       &priv_ep->trb_pool_dma,
> +                                                       GFP_DMA);
> +               if (!priv_ep->trb_pool)
> +                       return -ENOMEM;
> +       } else {
> +               memset(priv_ep->trb_pool, 0, ring_size);
> +       }
> +
> +       if (!priv_ep->num)
> +               return 0;
> +
> +       if (!priv_ep->aligned_buff) {
> +               void *buff = dma_alloc_coherent(priv_dev->sysdev,
> +                                               CDNS3_ALIGNED_BUF_SIZE,
> +                                               &priv_ep->aligned_dma_addr,
> +                                               GFP_DMA);
> +
> +               priv_ep->aligned_buff  = buff;
> +               if (!priv_ep->aligned_buff) {
> +                       dma_free_coherent(priv_dev->sysdev,
> +                                         ring_size,
> +                                         priv_ep->trb_pool,
> +                                         priv_ep->trb_pool_dma);
> +                       priv_ep->trb_pool = NULL;
> +
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       priv_ep->num_trbs = ring_size / TRB_SIZE;
> +       /* Initialize the last TRB as Link TRB */
> +       link_trb = (priv_ep->trb_pool + (priv_ep->num_trbs - 1));
> +       link_trb->buffer = TRB_BUFFER(priv_ep->trb_pool_dma);
> +       link_trb->control = TRB_CYCLE | TRB_TYPE(TRB_LINK) |
> +                           TRB_CHAIN | TRB_TOGGLE;
> +
> +       return 0;
> +}
> +
> +static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
> +{
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +
> +       if (priv_ep->trb_pool) {
> +               dma_free_coherent(priv_dev->sysdev,
> +                                 cdns3_ring_size(priv_ep),
> +                                 priv_ep->trb_pool, priv_ep->trb_pool_dma);
> +               priv_ep->trb_pool = NULL;
> +       }
> +
> +       if (priv_ep->aligned_buff) {
> +               dma_free_coherent(priv_dev->sysdev, CDNS3_ALIGNED_BUF_SIZE,
> +                                 priv_ep->aligned_buff,
> +                                 priv_ep->aligned_dma_addr);
> +               priv_ep->aligned_buff = NULL;
> +       }
> +}
> +
> +/**
> + * cdns3_data_flush - flush data at onchip buffer
> + * @priv_ep: endpoint object
> + *
> + * Endpoint must be selected before call to this function
> + *
> + * Returns zero on success or negative value on failure
> + */
> +static int cdns3_data_flush(struct cdns3_endpoint *priv_ep)
> +{
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +
> +       writel(EP_CMD_DFLUSH, &priv_dev->regs->ep_cmd);
> +
> +       /* wait for DFLUSH cleared */
> +       return cdns3_handshake(&priv_dev->regs->ep_cmd, EP_CMD_DFLUSH, 0, 100);
> +}
> +
> +/**
> + * cdns3_ep_stall_flush - Stalls and flushes selected endpoint
> + * @priv_ep: endpoint object
> + *
> + * Endpoint must be selected before call to this function
> + */
> +static void cdns3_ep_stall_flush(struct cdns3_endpoint *priv_ep)
> +{
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +
> +       writel(EP_CMD_DFLUSH | EP_CMD_ERDY | EP_CMD_SSTALL,
> +              &priv_dev->regs->ep_cmd);
> +
> +       /* wait for DFLUSH cleared */
> +       cdns3_handshake(&priv_dev->regs->ep_cmd, EP_CMD_DFLUSH, 0, 100);
> +       priv_ep->flags |= EP_STALL;
> +}
> +
> +/**
> + * cdns3_hw_reset_eps_config - reset endpoints configuration kept by controller.
> + * @priv_dev: extended gadget object
> + */
> +void cdns3_hw_reset_eps_config(struct cdns3_device *priv_dev)
> +{
> +       writel(USB_CONF_CFGRST, &priv_dev->regs->usb_conf);
> +
> +       cdns3_allow_enable_l1(priv_dev, 0);
> +       priv_dev->hw_configured_flag = 0;
> +       priv_dev->onchip_mem_allocated_size = 0;
> +}
> +
> +/**
> + * cdns3_ep_inc_trb - increment a trb index.
> + * @index: Pointer to the TRB index to increment.
> + * @cs: Cycle state
> + * @trb_in_seg: number of TRBs in segment
> + *
> + * The index should never point to the link TRB. After incrementing,
> + * if it is point to the link TRB, wrap around to the beginning and revert
> + * cycle state bit The
> + * link TRB is always at the last TRB entry.
> + */
> +static void cdns3_ep_inc_trb(int *index, u8 *cs, int trb_in_seg)
> +{
> +       (*index)++;
> +       if (*index == (trb_in_seg - 1)) {
> +               *index = 0;
> +               *cs ^=  1;
> +       }
> +}
> +
> +/**
> + * cdns3_ep_inc_enq - increment endpoint's enqueue pointer
> + * @priv_ep: The endpoint whose enqueue pointer we're incrementing
> + */
> +static void cdns3_ep_inc_enq(struct cdns3_endpoint *priv_ep)
> +{
> +       priv_ep->free_trbs--;
> +       cdns3_ep_inc_trb(&priv_ep->enqueue, &priv_ep->pcs, priv_ep->num_trbs);
> +}
> +
> +/**
> + * cdns3_ep_inc_deq - increment endpoint's dequeue pointer
> + * @priv_ep: The endpoint whose dequeue pointer we're incrementing
> + */
> +static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
> +{
> +       priv_ep->free_trbs++;
> +       cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs, priv_ep->num_trbs);
> +}
> +
> +/**
> + * cdns3_allow_enable_l1 - enable/disable permits to transition to L1.
> + * @priv_dev: Extended gadget object
> + * @enable: Enable/disable permit to transition to L1.
> + *
> + * If bit USB_CONF_L1EN is set and device receive Extended Token packet,
> + * then controller answer with ACK handshake.
> + * If bit USB_CONF_L1DS is set and device receive Extended Token packet,
> + * then controller answer with NYET handshake.
> + */
> +void cdns3_allow_enable_l1(struct cdns3_device *priv_dev, int enable)
> +{
> +       if (enable)
> +               writel(USB_CONF_L1EN, &priv_dev->regs->usb_conf);
> +       else
> +               writel(USB_CONF_L1DS, &priv_dev->regs->usb_conf);
> +}
> +
> +enum usb_device_speed cdns3_get_speed(struct cdns3_device *priv_dev)
> +{
> +       u32 reg;
> +
> +       reg = readl(&priv_dev->regs->usb_sts);
> +
> +       if (DEV_SUPERSPEED(reg))
> +               return USB_SPEED_SUPER;
> +       else if (DEV_HIGHSPEED(reg))
> +               return USB_SPEED_HIGH;
> +       else if (DEV_FULLSPEED(reg))
> +               return USB_SPEED_FULL;
> +       else if (DEV_LOWSPEED(reg))
> +               return USB_SPEED_LOW;
> +       return USB_SPEED_UNKNOWN;
> +}
> +
> +/**
> + * cdns3_start_all_request - add to ring all request not started
> + * @priv_dev: Extended gadget object
> + * @priv_ep: The endpoint for whom request will be started.
> + *
> + * Returns return ENOMEM if transfer ring i not enough TRBs to start
> + *         all requests.
> + */
> +static int cdns3_start_all_request(struct cdns3_device *priv_dev,
> +                                  struct cdns3_endpoint *priv_ep)
> +{
> +       struct cdns3_request *priv_req;
> +       struct usb_request *request;
> +       int ret = 0;
> +
> +       while (!list_empty(&priv_ep->deferred_req_list)) {
> +               request = cdns3_next_request(&priv_ep->deferred_req_list);
> +               priv_req = to_cdns3_request(request);
> +
> +               ret = cdns3_ep_run_transfer(priv_ep, request);
> +               if (ret)
> +                       return ret;
> +
> +               list_del(&request->list);
> +               list_add_tail(&request->list,
> +                             &priv_ep->pending_req_list);
> +       }
> +
> +       priv_ep->flags &= ~EP_RING_FULL;
> +       return ret;
> +}
> +
> +/**
> + * cdns3_descmiss_copy_data copy data from internal requests to request queued
> + * by class driver.
> + * @priv_ep: extended endpoint object
> + * @request: request object
> + */
> +static void cdns3_descmiss_copy_data(struct cdns3_endpoint *priv_ep,
> +                                    struct usb_request *request)
> +{
> +       struct usb_request *descmiss_req;
> +       struct cdns3_request *descmiss_priv_req;
> +
> +       while (!list_empty(&priv_ep->descmiss_req_list)) {
> +               int chunk_end;
> +               int length;
> +
> +               descmiss_priv_req =
> +                       cdns3_next_priv_request(&priv_ep->descmiss_req_list);
> +               descmiss_req = &descmiss_priv_req->request;
> +
> +               /* driver can't touch pending request */
> +               if (descmiss_priv_req->flags & REQUEST_PENDING)
> +                       break;
> +
> +               chunk_end = descmiss_priv_req->flags & REQUEST_INTERNAL_CH;
> +               length = request->actual + descmiss_req->actual;
> +
> +               if (length <= request->length) {
> +                       memcpy(&((u8 *)request->buf)[request->actual],
> +                              descmiss_req->buf,
> +                              descmiss_req->actual);
> +                       request->actual = length;
> +               } else {
> +                       /* It should never occures */
> +                       request->status = -ENOMEM;
> +               }
> +
> +               list_del_init(&descmiss_priv_req->list);
> +
> +               kfree(descmiss_req->buf);
> +               cdns3_gadget_ep_free_request(&priv_ep->endpoint, descmiss_req);
> +
> +               if (!chunk_end)
> +                       break;
> +       }
> +}
> +
> +/**
> + * cdns3_gadget_giveback - call struct usb_request's ->complete callback
> + * @priv_ep: The endpoint to whom the request belongs to
> + * @priv_req: The request we're giving back
> + * @status: completion code for the request
> + *
> + * Must be called with controller's lock held and interrupts disabled. This
> + * function will unmap @req and call its ->complete() callback to notify upper
> + * layers that it has completed.
> + */
> +void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
> +                          struct cdns3_request *priv_req,
> +                          int status)
> +{
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       struct usb_request *request = &priv_req->request;
> +
> +       list_del_init(&request->list);
> +
> +       if (request->status == -EINPROGRESS)
> +               request->status = status;
> +
> +       usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
> +                                       priv_ep->dir);
> +
> +       priv_req->flags &= ~REQUEST_PENDING;
> +       trace_cdns3_gadget_giveback(priv_req);
> +
> +       /* WA1: */
> +       if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN &&
> +           priv_req->flags & REQUEST_INTERNAL) {
> +               struct usb_request *req;
> +
> +               req = cdns3_next_request(&priv_ep->deferred_req_list);
> +               request = req;
> +               priv_ep->descmis_req = NULL;
> +
> +               if (!req)
> +                       return;
> +
> +               cdns3_descmiss_copy_data(priv_ep, req);
> +               if (!(priv_ep->flags & EP_QUIRK_END_TRANSFER) &&
> +                   req->length != req->actual) {
> +                       /* wait for next part of transfer */
> +                       return;
> +               }
> +
> +               if (req->status == -EINPROGRESS)
> +                       req->status = 0;
> +
> +               list_del_init(&req->list);
> +               cdns3_start_all_request(priv_dev, priv_ep);
> +       }
> +
> +       /* Start all not pending request */
> +       if (priv_ep->flags & EP_RING_FULL)
> +               cdns3_start_all_request(priv_dev, priv_ep);
> +
> +       if (request->complete) {
> +               spin_unlock(&priv_dev->lock);
> +               usb_gadget_giveback_request(&priv_ep->endpoint,
> +                                           request);
> +               spin_lock(&priv_dev->lock);
> +       }
> +
> +       if (request->buf == priv_dev->zlp_buf)
> +               cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
> +}
> +
> +/**
> + * cdns3_ep_run_transfer - start transfer on no-default endpoint hardware
> + * @priv_ep: endpoint object
> + *
> + * Returns zero on success or negative value on failure
> + */
> +int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
> +                         struct usb_request *request)
> +{
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       struct cdns3_request *priv_req;
> +       struct cdns3_trb *trb;
> +       dma_addr_t trb_dma;
> +       int sg_iter = 0;
> +       u32 first_pcs;
> +       int  num_trb;
> +       int address;
> +       int pcs;
> +
> +       if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
> +               num_trb = priv_ep->interval;
> +       else
> +               num_trb = request->num_sgs ? request->num_sgs : 1;
> +
> +       if (num_trb > priv_ep->free_trbs) {
> +               priv_ep->flags |= EP_RING_FULL;
> +               return -ENOBUFS;
> +       }
> +
> +       priv_req = to_cdns3_request(request);
> +       address = priv_ep->endpoint.desc->bEndpointAddress;
> +
> +       priv_ep->flags |= EP_PENDING_REQUEST;
> +       trb_dma = request->dma;
> +
> +       /* must allocate buffer aligned to 8 */
> +       if ((request->dma % 8)) {
> +               if (request->length <= CDNS3_ALIGNED_BUF_SIZE) {
> +                       memcpy(priv_ep->aligned_buff, request->buf,
> +                              request->length);
> +                       trb_dma = priv_ep->aligned_dma_addr;
> +               } else {
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       trb = priv_ep->trb_pool + priv_ep->enqueue;
> +       priv_req->start_trb = priv_ep->enqueue;
> +       priv_req->trb = trb;
> +
> +       /* prepare ring */
> +       if ((priv_ep->enqueue + num_trb)  >= (priv_ep->num_trbs - 1)) {
> +               /*updating C bt in  Link TRB before starting DMA*/
> +               struct cdns3_trb *link_trb = priv_ep->trb_pool +
> +                                            (priv_ep->num_trbs - 1);
> +               link_trb->control = ((priv_ep->pcs) ? TRB_CYCLE : 0) |
> +                                   TRB_TYPE(TRB_LINK) | TRB_CHAIN |
> +                                   TRB_TOGGLE;
> +       }
> +
> +       first_pcs = priv_ep->pcs ? TRB_CYCLE : 0;
> +
> +       do {
> +       /* fill TRB */
> +               trb->buffer = TRB_BUFFER(request->num_sgs == 0
> +                               ? trb_dma : request->sg[sg_iter].dma_address);
> +
> +               trb->length = TRB_BURST_LEN(16) |
> +                   TRB_LEN(request->num_sgs == 0 ?
> +                               request->length : request->sg[sg_iter].length);
> +
> +               trb->control = TRB_TYPE(TRB_NORMAL);
> +               pcs = priv_ep->pcs ? TRB_CYCLE : 0;
> +
> +               /*
> +                * first trb should be prepared as last to avoid processing
> +                *  transfer to early
> +                */
> +               if (sg_iter != 0)
> +                       trb->control |= pcs;
> +
> +               if (priv_ep->type == USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir) {
> +                       trb->control |= TRB_IOC | TRB_ISP;
> +               } else {
> +                       /* for last element in TD or in SG list */
> +                       if (sg_iter == (num_trb - 1) && sg_iter != 0)
> +                               trb->control |= pcs | TRB_IOC | TRB_ISP;
> +               }
> +               ++sg_iter;
> +               priv_req->end_trb = priv_ep->enqueue;
> +               cdns3_ep_inc_enq(priv_ep);
> +               trb = priv_ep->trb_pool + priv_ep->enqueue;
> +       } while (sg_iter < num_trb);
> +
> +       trb = priv_req->trb;
> +
> +       /*
> +        * Memory barrier = Cycle Bit must be set before trb->length  and
> +        * trb->buffer fields.
> +        */
> +       wmb();
> +
> +       priv_req->flags |= REQUEST_PENDING;
> +
> +       /* give the TD to the consumer*/
> +       if (sg_iter == 1)
> +               trb->control |= first_pcs | TRB_IOC | TRB_ISP;
> +       else
> +               trb->control |= first_pcs;
> +
> +       trace_cdns3_prepare_trb(priv_ep, priv_req->trb);
> +       trace_cdns3_ring(priv_ep);
> +
> +       /* arm transfer on selected endpoint */
> +       cdns3_select_ep(priv_ep->cdns3_dev, address);
> +
> +       /*
> +        * For DMULT mode we can set address to transfer ring only once after
> +        * enabling endpoint.
> +        */
> +       if (priv_ep->flags & EP_UPDATE_EP_TRBADDR) {
> +               writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma),
> +                      &priv_dev->regs->ep_traddr);
> +               priv_ep->flags &= ~EP_UPDATE_EP_TRBADDR;
> +       }
> +
> +       /*clearing TRBERR and EP_STS_DESCMIS before seting DRDY*/
> +       writel(EP_STS_TRBERR | EP_STS_DESCMIS, &priv_dev->regs->ep_sts);
> +       trace_cdns3_doorbell_epx(priv_ep->name,
> +                                readl(&priv_dev->regs->ep_traddr));
> +       writel(EP_CMD_DRDY, &priv_dev->regs->ep_cmd);
> +
> +       return 0;
> +}
> +
> +void cdns3_set_hw_configuration(struct cdns3_device *priv_dev)
> +{
> +       struct cdns3_endpoint *priv_ep;
> +       struct usb_ep *ep;
> +       int result = 0;
> +
> +       if (priv_dev->hw_configured_flag)
> +               return;
> +
> +       writel(USB_CONF_CFGSET, &priv_dev->regs->usb_conf);
> +       writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
> +
> +       cdns3_set_register_bit(&priv_dev->regs->usb_conf,
> +                              USB_CONF_U1EN | USB_CONF_U2EN);
> +
> +       /* wait until configuration set */
> +       result = cdns3_handshake(&priv_dev->regs->usb_sts,
> +                                USB_STS_CFGSTS_MASK, 1, 100);
> +
> +       priv_dev->hw_configured_flag = 1;
> +       cdns3_allow_enable_l1(priv_dev, 1);
> +
> +       list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
> +               if (ep->enabled) {
> +                       priv_ep = ep_to_cdns3_ep(ep);
> +                       cdns3_start_all_request(priv_dev, priv_ep);
> +               }
> +       }
> +}
> +
> +/**
> + * cdns3_request_handled - check whether request has been handled by DMA
> + *
> + * @priv_ep: extended endpoint object.
> + * @priv_req: request object for checking
> + *
> + * Endpoint must be selected before invoking this function.
> + *
> + * Returns false if request has not been handled by DMA, else returns true.
> + *
> + * SR - start ring
> + * ER -  end ring
> + * DQ = priv_ep->dequeue - dequeue position
> + * EQ = priv_ep->enqueue -  enqueue position
> + * ST = priv_req->start_trb - index of first TRB in transfer ring
> + * ET = priv_req->end_trb - index of last TRB in transfer ring
> + * CI = current_index - index of processed TRB by DMA.
> + *
> + * As first step, function checks if cycle bit for priv_req->start_trb is
> + * correct.
> + *
> + * some rules:
> + * 1. priv_ep->dequeue never exceed current_index.
> + * 2  priv_ep->enqueue never exceed priv_ep->dequeue
> + *
> + * Then We can split recognition into two parts:
> + * Case 1 - priv_ep->dequeue < current_index
> + *      SR ... EQ ... DQ ... CI ... ER
> + *      SR ... DQ ... CI ... EQ ... ER
> + *
> + *      Request has been handled by DMA if ST and ET is between DQ and CI.
> + *
> + * Case 2 - priv_ep->dequeue > current_index
> + * This situation take place when CI go through the LINK TRB at the end of
> + * transfer ring.
> + *      SR ... CI ... EQ ... DQ ... ER
> + *
> + *      Request has been handled by DMA if ET is less then CI or
> + *      ET is greater or equal DQ.
> + */
> +static bool cdns3_request_handled(struct cdns3_endpoint *priv_ep,
> +                                 struct cdns3_request *priv_req)
> +{
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       struct cdns3_trb *trb = priv_req->trb;
> +       int current_index = 0;
> +       int handled = 0;
> +
> +       current_index = (readl(&priv_dev->regs->ep_traddr) -
> +                        priv_ep->trb_pool_dma) / TRB_SIZE;
> +
> +       trb = &priv_ep->trb_pool[priv_req->start_trb];
> +
> +       if ((trb->control  & TRB_CYCLE) != priv_ep->ccs)
> +               goto finish;
> +
> +       if (priv_ep->dequeue < current_index) {
> +               if ((current_index == (priv_ep->num_trbs - 1)) &&
> +                   !priv_ep->dequeue)
> +                       goto finish;
> +
> +               if (priv_req->end_trb >= priv_ep->dequeue &&
> +                   priv_req->end_trb < current_index)
> +                       handled = 1;
> +       } else if (priv_ep->dequeue  > current_index) {
> +               if (priv_req->end_trb  < current_index ||
> +                   priv_req->end_trb >= priv_ep->dequeue)
> +                       handled = 1;
> +       }
> +
> +finish:
> +       trace_cdns3_request_handled(priv_req, current_index, handled);
> +
> +       return handled;
> +}
> +
> +static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
> +                                    struct cdns3_endpoint *priv_ep)
> +{
> +       struct cdns3_request *priv_req;
> +       struct usb_request *request;
> +       struct cdns3_trb *trb;
> +       int current_trb;
> +
> +       while (!list_empty(&priv_ep->pending_req_list)) {
> +               request = cdns3_next_request(&priv_ep->pending_req_list);
> +               priv_req = to_cdns3_request(request);
> +
> +               if (!cdns3_request_handled(priv_ep, priv_req))
> +                       return;
> +
> +               if (request->dma % 8 && priv_ep->dir == USB_DIR_OUT)
> +                       memcpy(request->buf, priv_ep->aligned_buff,
> +                              request->length);
> +
> +               trb = priv_ep->trb_pool + priv_ep->dequeue;
> +               trace_cdns3_complete_trb(priv_ep, trb);
> +
> +               if (trb != priv_req->trb)
> +                       dev_warn(priv_dev->dev,
> +                                "request_trb=0x%p, queue_trb=0x%p\n",
> +                                priv_req->trb, trb);
> +
> +               request->actual = TRB_LEN(le32_to_cpu(trb->length));
> +               current_trb = priv_req->start_trb;
> +
> +               while (current_trb != priv_req->end_trb) {
> +                       cdns3_ep_inc_deq(priv_ep);
> +                       current_trb = priv_ep->dequeue;
> +               }
> +
> +               cdns3_ep_inc_deq(priv_ep);
> +               cdns3_gadget_giveback(priv_ep, priv_req, 0);
> +       }
> +       priv_ep->flags &= ~EP_PENDING_REQUEST;
> +}
> +
> +/**
> + * cdns3_descmissing_packet - handles descriptor missing event.
> + * @priv_dev: extended gadget object
> + *
> + * WA1: Controller for OUT endpoints has shared on-chip buffers for all incoming
> + * packets, including ep0out. It's FIFO buffer, so packets must be handle by DMA
> + * in correct order. If the first packet in the buffer will not be handled,
> + * then the following packets directed for other endpoints and  functions
> + * will be blocked.
> + * Additionally the packets directed to one endpoint can block entire on-chip
> + * buffers. In this case transfer to other endpoints also will blocked.
> + *
> + * To resolve this issue after raising the descriptor missing interrupt
> + * driver prepares internal usb_request object and use it to arm DMA transfer.
> + *
> + * The problematic situation was observed in case when endpoint has been enabled
> + * but no usb_request were queued. Driver try detects such endpoints and will
> + * use this workaround only for these endpoint.
> + *
> + * Driver use limited number of buffer. This number can be set by macro
> + * CDNS_WA1_NUM_BUFFERS.
> + *
> + * Such blocking situation was observed on ACM gadget. For this function
> + * host send OUT data packet but ACM function is not prepared for this packet.
> + *
> + * It's limitation of controller but maybe this issues should be fixed in
> + * function driver.
> + */
> +static int cdns3_descmissing_packet(struct cdns3_endpoint *priv_ep)
> +{
> +       struct cdns3_request *priv_req;
> +       struct usb_request *request;
> +
> +       if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET) {
> +               priv_ep->flags &= ~EP_QUIRK_EXTRA_BUF_DET;
> +               priv_ep->flags |= EP_QUIRK_EXTRA_BUF_EN;
> +       }
> +
> +       request = cdns3_gadget_ep_alloc_request(&priv_ep->endpoint,
> +                                               GFP_ATOMIC);
> +       if (!request)
> +               return -ENOMEM;
> +
> +       priv_req = to_cdns3_request(request);
> +       priv_req->flags |= REQUEST_INTERNAL;
> +
> +       /* if this field is still assigned it indicate that transfer related
> +        * with this request has not been finished yet. Driver in this
> +        * case simply allocate next request and assign flag REQUEST_INTERNAL_CH
> +        * flag to previous one. It will indicate that current request is
> +        * part of the previous one.
> +        */
> +       if (priv_ep->descmis_req)
> +               priv_ep->descmis_req->flags |= REQUEST_INTERNAL_CH;
> +
> +       priv_req->request.buf = kzalloc(CDNS3_DESCMIS_BUF_SIZE,
> +                                       GFP_ATOMIC);
> +       if (!priv_req) {
> +               cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
> +               return -ENOMEM;
> +       }
> +
> +       priv_req->request.length = CDNS3_DESCMIS_BUF_SIZE;
> +       priv_ep->descmis_req = priv_req;
> +
> +       __cdns3_gadget_ep_queue(&priv_ep->endpoint,
> +                               &priv_ep->descmis_req->request,
> +                               GFP_ATOMIC);
> +
> +       return 0;
> +}
> +
> +/**
> + * cdns3_check_ep_interrupt_proceed - Processes interrupt related to endpoint
> + * @priv_ep: endpoint object
> + *
> + * Returns 0
> + */
> +static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
> +{
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       u32 ep_sts_reg;
> +
> +       cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
> +
> +       trace_cdns3_epx_irq(priv_dev, priv_ep);
> +
> +       ep_sts_reg = readl(&priv_dev->regs->ep_sts);
> +       writel(ep_sts_reg, &priv_dev->regs->ep_sts);
> +
> +       if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP)) {
> +               if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN) {
> +                       if (ep_sts_reg & EP_STS_ISP)
> +                               priv_ep->flags |= EP_QUIRK_END_TRANSFER;
> +                       else
> +                               priv_ep->flags &= ~EP_QUIRK_END_TRANSFER;
> +               }
> +               cdns3_transfer_completed(priv_dev, priv_ep);
> +       }
> +
> +       /*
> +        * For isochronous transfer driver completes request on IOC or on
> +        * TRBERR. IOC appears only when device receive OUT data packet.
> +        * If host disable stream or lost some packet then the only way to
> +        * finish all queued transfer is to do it on TRBERR event.
> +        */
> +       if ((ep_sts_reg & EP_STS_TRBERR) &&
> +           priv_ep->type == USB_ENDPOINT_XFER_ISOC)
> +               cdns3_transfer_completed(priv_dev, priv_ep);
> +
> +       /*
> +        * WA1: this condition should only be meet when
> +        * priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET or
> +        * priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN.
> +        * In other cases this interrupt will be disabled/
> +        */
> +       if (ep_sts_reg & EP_STS_DESCMIS) {
> +               int err;
> +
> +               err = cdns3_descmissing_packet(priv_ep);
> +               if (err)
> +                       dev_err(priv_dev->dev,
> +                               "Failed: No sufficient memory for DESCMIS\n");
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * cdns3_check_usb_interrupt_proceed - Processes interrupt related to device
> + * @priv_dev: extended gadget object
> + * @usb_ists: bitmap representation of device's reported interrupts
> + * (usb_ists register value)
> + */
> +static void cdns3_check_usb_interrupt_proceed(struct cdns3_device *priv_dev,
> +                                             u32 usb_ists)
> +{
> +       int speed = 0;
> +
> +       trace_cdns3_usb_irq(priv_dev, usb_ists);
> +       /* Connection detected */
> +       if (usb_ists & (USB_ISTS_CON2I | USB_ISTS_CONI)) {
> +               speed = cdns3_get_speed(priv_dev);
> +               priv_dev->gadget.speed = speed;
> +               usb_gadget_set_state(&priv_dev->gadget, USB_STATE_POWERED);
> +               cdns3_ep0_config(priv_dev);
> +       }
> +
> +       /* Disconnection detected */
> +       if (usb_ists & (USB_ISTS_DIS2I | USB_ISTS_DISI)) {
> +               if (priv_dev->gadget_driver &&
> +                   priv_dev->gadget_driver->disconnect) {
> +                       spin_unlock(&priv_dev->lock);
> +                       priv_dev->gadget_driver->disconnect(&priv_dev->gadget);
> +                       spin_lock(&priv_dev->lock);
> +               }
> +
> +               priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> +               usb_gadget_set_state(&priv_dev->gadget, USB_STATE_NOTATTACHED);
> +               cdns3_hw_reset_eps_config(priv_dev);
> +       }
> +
> +       /* reset*/
> +       if (usb_ists & (USB_ISTS_UWRESI | USB_ISTS_UHRESI | USB_ISTS_U2RESI)) {
> +               /*read again to check the actuall speed*/
> +               speed = cdns3_get_speed(priv_dev);
> +               usb_gadget_set_state(&priv_dev->gadget, USB_STATE_DEFAULT);
> +               priv_dev->gadget.speed = speed;
> +               cdns3_hw_reset_eps_config(priv_dev);
> +               cdns3_ep0_config(priv_dev);
> +       }
> +}
> +
> +/**
> + * cdns3_device_irq_handler- interrupt handler for device part of controller
> + *
> + * @irq: irq number for cdns3 core device
> + * @data: structure of cdns3
> + *
> + * Returns IRQ_HANDLED or IRQ_NONE
> + */
> +static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
> +{
> +       struct cdns3_device *priv_dev;
> +       struct cdns3 *cdns = data;
> +       irqreturn_t ret = IRQ_NONE;
> +       unsigned long flags;
> +       u32 reg;
> +
> +       priv_dev = cdns->gadget_dev;
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +       /* check USB device interrupt */
> +       reg = readl(&priv_dev->regs->usb_ists);
> +       writel(reg, &priv_dev->regs->usb_ists);
> +
> +       if (reg) {
> +               cdns3_check_usb_interrupt_proceed(priv_dev, reg);
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       /* check endpoint interrupt */
> +       reg = readl(&priv_dev->regs->ep_ists);
> +
> +       if (reg) {
> +               reg = ~reg & readl(&priv_dev->regs->ep_ien);
> +               /* mask deferred interrupt. */
> +               writel(reg, &priv_dev->regs->ep_ien);
> +               ret = IRQ_WAKE_THREAD;
> +       }
> +
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +       return ret;
> +}
> +
> +/**
> + * cdns3_device_thread_irq_handler- interrupt handler for device part
> + * of controller
> + *
> + * @irq: irq number for cdns3 core device
> + * @data: structure of cdns3
> + *
> + * Returns IRQ_HANDLED or IRQ_NONE
> + */
> +static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
> +{
> +       struct cdns3_device *priv_dev;
> +       struct cdns3 *cdns = data;
> +       irqreturn_t ret = IRQ_NONE;
> +       unsigned long flags;
> +       u32 ep_ien;
> +       int bit;
> +       u32 reg;
> +
> +       priv_dev = cdns->gadget_dev;
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +       reg = readl(&priv_dev->regs->ep_ists);
> +       ep_ien = reg;
> +
> +       /* handle default endpoint OUT */
> +       if (reg & EP_ISTS_EP_OUT0) {
> +               cdns3_check_ep0_interrupt_proceed(priv_dev, USB_DIR_OUT);
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       /* handle default endpoint IN */
> +       if (reg & EP_ISTS_EP_IN0) {
> +               cdns3_check_ep0_interrupt_proceed(priv_dev, USB_DIR_IN);
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       /* check if interrupt from non default endpoint, if no exit */
> +       reg &= ~(EP_ISTS_EP_OUT0 | EP_ISTS_EP_IN0);
> +       if (!reg)
> +               goto irqend;
> +
> +       for_each_set_bit(bit, (unsigned long *)&reg,
> +                        sizeof(u32) * BITS_PER_BYTE) {
> +               cdns3_check_ep_interrupt_proceed(priv_dev->eps[bit]);
> +               ret = IRQ_HANDLED;
> +       }
> +
> +irqend:
> +       ep_ien |= readl(&priv_dev->regs->ep_ien);
> +       /* Unmask all handled EP interrupts */
> +       writel(ep_ien, &priv_dev->regs->ep_ien);
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +       return ret;
> +}
> +
> +/**
> + * cdns3_ep_onchip_buffer_reserve - Try to reserve onchip buf for EP
> + *
> + * The real reservation will occur during write to EP_CFG register,
> + * this function is used to check if the 'size' reservation is allowed.
> + *
> + * @priv_dev: extended gadget object
> + * @size: the size (KB) for EP would like to allocate
> + *
> + * Return 0 if the required size can met or negative value on failure
> + */
> +static int cdns3_ep_onchip_buffer_reserve(struct cdns3_device *priv_dev,
> +                                         int size)
> +{
> +       u32 onchip_mem;
> +
> +       priv_dev->onchip_mem_allocated_size += size;
> +
> +       onchip_mem = USB_CAP2_ACTUAL_MEM_SIZE(readl(&priv_dev->regs->usb_cap2));
> +       if (!onchip_mem)
> +               onchip_mem = 256;
> +
> +       /* 2KB is reserved for EP0*/
> +       onchip_mem -= 2;
> +       if (priv_dev->onchip_mem_allocated_size > onchip_mem) {
> +               priv_dev->onchip_mem_allocated_size -= size;
> +               return -EPERM;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * cdns3_ep_config Configure hardware endpoint
> + * @priv_ep: extended endpoint object
> + */
> +void cdns3_ep_config(struct cdns3_endpoint *priv_ep)
> +{
> +       bool is_iso_ep = (priv_ep->type == USB_ENDPOINT_XFER_ISOC);
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       u32 bEndpointAddress = priv_ep->num | priv_ep->dir;
> +       u32 max_packet_size = 0;
> +       u32 ep_cfg = 0;
> +       int ret;
> +
> +       switch (priv_ep->type) {
> +       case USB_ENDPOINT_XFER_INT:
> +               ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_INT);
> +               break;
> +       case USB_ENDPOINT_XFER_BULK:
> +               ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_BULK);
> +               break;
> +       default:
> +               ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
> +       }
> +
> +       switch (priv_dev->gadget.speed) {
> +       case USB_SPEED_FULL:
> +               max_packet_size = is_iso_ep ? 1023 : 64;
> +               break;
> +       case USB_SPEED_HIGH:
> +               max_packet_size = is_iso_ep ? 1024 : 512;
> +               break;
> +       case USB_SPEED_SUPER:
> +               max_packet_size = 1024;
> +               break;
> +       default:
> +               /* all other speed are not supported */
> +               return;
> +       }
> +
> +       ret = cdns3_ep_onchip_buffer_reserve(priv_dev, CDNS3_EP_BUF_SIZE);
> +       if (ret) {
> +               dev_err(priv_dev->dev, "onchip mem is full, ep is invalid\n");
> +               return;
> +       }
> +
> +       ep_cfg |= EP_CFG_MAXPKTSIZE(max_packet_size) |
> +                 EP_CFG_BUFFERING(CDNS3_EP_BUF_SIZE - 1) |
> +                 EP_CFG_MAXBURST(priv_ep->endpoint.maxburst);
> +
> +       cdns3_select_ep(priv_dev, bEndpointAddress);
> +       writel(ep_cfg, &priv_dev->regs->ep_cfg);
> +
> +       dev_dbg(priv_dev->dev, "Configure %s: with val %08x\n",
> +               priv_ep->name, ep_cfg);
> +}
> +
> +/* Find correct direction for HW endpoint according to description */
> +static int cdns3_ep_dir_is_correct(struct usb_endpoint_descriptor *desc,
> +                                  struct cdns3_endpoint *priv_ep)
> +{
> +       return (priv_ep->endpoint.caps.dir_in && usb_endpoint_dir_in(desc)) ||
> +              (priv_ep->endpoint.caps.dir_out && usb_endpoint_dir_out(desc));
> +}
> +
> +static struct
> +cdns3_endpoint *cdns3_find_available_ep(struct cdns3_device *priv_dev,
> +                                       struct usb_endpoint_descriptor *desc)
> +{
> +       struct usb_ep *ep;
> +       struct cdns3_endpoint *priv_ep;
> +
> +       list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
> +               unsigned long num;
> +               int ret;
> +               /* ep name pattern likes epXin or epXout */
> +               char c[2] = {ep->name[2], '\0'};
> +
> +               ret = kstrtoul(c, 10, &num);
> +               if (ret)
> +                       return ERR_PTR(ret);
> +
> +               priv_ep = ep_to_cdns3_ep(ep);
> +               if (cdns3_ep_dir_is_correct(desc, priv_ep)) {
> +                       if (!(priv_ep->flags & EP_CLAIMED)) {
> +                               priv_ep->num  = num;
> +                               return priv_ep;
> +                       }
> +               }
> +       }
> +
> +       return ERR_PTR(-ENOENT);
> +}
> +
> +/*
> + *  Cadence IP has one limitation that all endpoints must be configured
> + * (Type & MaxPacketSize) before setting configuration through hardware
> + * register, it means we can't change endpoints configuration after
> + * set_configuration.
> + *
> + * This function set EP_CLAIMED flag which is added when the gadget driver
> + * uses usb_ep_autoconfig to configure specific endpoint;
> + * When the udc driver receives set_configurion request,
> + * it goes through all claimed endpoints, and configure all endpoints
> + * accordingly.
> + *
> + * At usb_ep_ops.enable/disable, we only enable and disable endpoint through
> + * ep_cfg register which can be changed after set_configuration, and do
> + * some software operation accordingly.
> + */
> +static struct
> +usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
> +                             struct usb_endpoint_descriptor *desc,
> +                             struct usb_ss_ep_comp_descriptor *comp_desc)
> +{
> +       struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> +       struct cdns3_endpoint *priv_ep;
> +       unsigned long flags;
> +
> +       priv_ep = cdns3_find_available_ep(priv_dev, desc);
> +       if (IS_ERR(priv_ep)) {
> +               dev_err(priv_dev->dev, "no available ep\n");
> +               return NULL;
> +       }
> +
> +       dev_dbg(priv_dev->dev, "match endpoint: %s\n", priv_ep->name);
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +       priv_ep->endpoint.desc = desc;
> +       priv_ep->dir  = usb_endpoint_dir_in(desc) ? USB_DIR_IN : USB_DIR_OUT;
> +       priv_ep->type = usb_endpoint_type(desc);
> +       priv_ep->flags |= EP_CLAIMED;
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +       return &priv_ep->endpoint;
> +}
> +
> +/**
> + * cdns3_gadget_ep_alloc_request Allocates request
> + * @ep: endpoint object associated with request
> + * @gfp_flags: gfp flags
> + *
> + * Returns allocated request address, NULL on allocation error
> + */
> +struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
> +                                                 gfp_t gfp_flags)
> +{
> +       struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
> +       struct cdns3_request *priv_req;
> +
> +       priv_req = kzalloc(sizeof(*priv_req), gfp_flags);
> +       if (!priv_req)
> +               return NULL;
> +
> +       priv_req->priv_ep = priv_ep;
> +
> +       trace_cdns3_alloc_request(priv_req);
> +       return &priv_req->request;
> +}
> +
> +/**
> + * cdns3_gadget_ep_free_request Free memory occupied by request
> + * @ep: endpoint object associated with request
> + * @request: request to free memory
> + */
> +void cdns3_gadget_ep_free_request(struct usb_ep *ep,
> +                                 struct usb_request *request)
> +{
> +       struct cdns3_request *priv_req = to_cdns3_request(request);
> +
> +       trace_cdns3_free_request(priv_req);
> +       kfree(priv_req);
> +}
> +
> +/**
> + * cdns3_gadget_ep_enable Enable endpoint
> + * @ep: endpoint object
> + * @desc: endpoint descriptor
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +static int cdns3_gadget_ep_enable(struct usb_ep *ep,
> +                                 const struct usb_endpoint_descriptor *desc)
> +{
> +       struct cdns3_endpoint *priv_ep;
> +       struct cdns3_device *priv_dev;
> +       u32 reg = EP_STS_EN_TRBERREN;
> +       u32 bEndpointAddress;
> +       unsigned long flags;
> +       int ret;
> +
> +       priv_ep = ep_to_cdns3_ep(ep);
> +       priv_dev = priv_ep->cdns3_dev;
> +
> +       if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
> +               dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!desc->wMaxPacketSize) {
> +               dev_err(priv_dev->dev, "usbss: missing wMaxPacketSize\n");
> +               return -EINVAL;
> +       }
> +
> +       if (dev_WARN_ONCE(priv_dev->dev, priv_ep->flags & EP_ENABLED,
> +                         "%s is already enabled\n", priv_ep->name))
> +               return 0;
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +       priv_ep->endpoint.desc = desc;
> +       priv_ep->type = usb_endpoint_type(desc);
> +       priv_ep->interval = desc->bInterval ? BIT(desc->bInterval - 1) : 0;
> +
> +       if (priv_ep->interval > ISO_MAX_INTERVAL &&
> +           priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
> +               dev_err(priv_dev->dev, "Driver is limited to %d period\n",
> +                       ISO_MAX_INTERVAL);
> +
> +               ret =  -EINVAL;
> +               goto exit;
> +       }
> +
> +       ret = cdns3_allocate_trb_pool(priv_ep);
> +
> +       if (ret)
> +               goto exit;
> +
> +       bEndpointAddress = priv_ep->num | priv_ep->dir;
> +       cdns3_select_ep(priv_dev, bEndpointAddress);
> +
> +       trace_cdns3_gadget_ep_enable(priv_ep);
> +
> +       writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> +
> +       ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
> +                             EP_CMD_CSTALL | EP_CMD_EPRST, 0, 100);
> +
> +       /* enable interrupt for selected endpoint */
> +       cdns3_set_register_bit(&priv_dev->regs->ep_ien,
> +                              BIT(cdns3_ep_addr_to_index(bEndpointAddress)));
> +       /*
> +        * WA1: Set flag for all not ISOC OUT endpoints. If this flag is set
> +        * driver try to detect whether endpoint need additional internal
> +        * buffer for unblocking on-chip FIFO buffer. This flag will be cleared
> +        * if before first DESCMISS interrupt the DMA will be armed.
> +        */
> +       if (!priv_ep->dir && priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
> +               priv_ep->flags |= EP_QUIRK_EXTRA_BUF_DET;
> +               reg |= EP_STS_EN_DESCMISEN;
> +       }
> +
> +       writel(reg, &priv_dev->regs->ep_sts_en);
> +
> +       cdns3_set_register_bit(&priv_dev->regs->ep_cfg, EP_CFG_ENABLE);
> +
> +       ep->desc = desc;
> +       priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALL |
> +                           EP_QUIRK_EXTRA_BUF_EN);
> +       priv_ep->flags |= EP_ENABLED | EP_UPDATE_EP_TRBADDR;
> +       priv_ep->enqueue = 0;
> +       priv_ep->dequeue = 0;
> +       reg = readl(&priv_dev->regs->ep_sts);
> +       priv_ep->pcs = !!EP_STS_CCS(reg);
> +       priv_ep->ccs = !!EP_STS_CCS(reg);
> +       /* one TRB is reserved for link TRB used in DMULT mode*/
> +       priv_ep->free_trbs = priv_ep->num_trbs - 1;
> +exit:
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +
> +       return ret;
> +}
> +
> +/**
> + * cdns3_gadget_ep_disable Disable endpoint
> + * @ep: endpoint object
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +static int cdns3_gadget_ep_disable(struct usb_ep *ep)
> +{
> +       struct cdns3_endpoint *priv_ep;
> +       struct cdns3_request *priv_req;
> +       struct cdns3_device *priv_dev;
> +       struct usb_request *request;
> +       unsigned long flags;
> +       int ret = 0;
> +       u32 ep_cfg;
> +
> +       if (!ep) {
> +               pr_err("usbss: invalid parameters\n");
> +               return -EINVAL;
> +       }
> +
> +       priv_ep = ep_to_cdns3_ep(ep);
> +       priv_dev = priv_ep->cdns3_dev;
> +
> +       if (dev_WARN_ONCE(priv_dev->dev, !(priv_ep->flags & EP_ENABLED),
> +                         "%s is already disabled\n", priv_ep->name))
> +               return 0;
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +       trace_cdns3_gadget_ep_disable(priv_ep);
> +
> +       cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
> +       ret = cdns3_data_flush(priv_ep);
> +
> +       ep_cfg = readl(&priv_dev->regs->ep_cfg);
> +       ep_cfg &= ~EP_CFG_ENABLE;
> +       writel(ep_cfg, &priv_dev->regs->ep_cfg);
> +
> +       while (!list_empty(&priv_ep->pending_req_list)) {
> +               request = cdns3_next_request(&priv_ep->pending_req_list);
> +
> +               cdns3_gadget_giveback(priv_ep, to_cdns3_request(request),
> +                                     -ESHUTDOWN);
> +       }
> +
> +       while (!list_empty(&priv_ep->descmiss_req_list)) {
> +               priv_req = cdns3_next_priv_request(&priv_ep->descmiss_req_list);
> +
> +               kfree(priv_req->request.buf);
> +               cdns3_gadget_ep_free_request(&priv_ep->endpoint,
> +                                            &priv_req->request);
> +       }
> +
> +       while (!list_empty(&priv_ep->deferred_req_list)) {
> +               request = cdns3_next_request(&priv_ep->deferred_req_list);
> +
> +               cdns3_gadget_giveback(priv_ep, to_cdns3_request(request),
> +                                     -ESHUTDOWN);
> +       }
> +
> +       priv_ep->descmis_req = NULL;
> +
> +       ep->desc = NULL;
> +       priv_ep->flags &= ~EP_ENABLED;
> +
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +
> +       return ret;
> +}
> +
> +/**
> + * cdns3_gadget_ep_queue Transfer data on endpoint
> + * @ep: endpoint object
> + * @request: request object
> + * @gfp_flags: gfp flags
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
> +                                  struct usb_request *request,
> +                                  gfp_t gfp_flags)
> +{
> +       struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       struct cdns3_request *priv_req;
> +       int deferred = 0;
> +       int ret = 0;
> +
> +       request->actual = 0;
> +       request->status = -EINPROGRESS;
> +       priv_req = to_cdns3_request(request);
> +       trace_cdns3_ep_queue(priv_req);
> +
> +       /*
> +        * WA1: if transfer was queued before DESCMISS appear than we
> +        * can disable handling of DESCMISS interrupt. Driver assumes that it
> +        * can disable special treatment for this endpoint.
> +        */
> +       if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET) {
> +               u32 reg;
> +
> +               cdns3_select_ep(priv_dev, priv_ep->num | priv_ep->dir);
> +               reg = readl(&priv_dev->regs->ep_sts_en);
> +               priv_ep->flags &= ~EP_QUIRK_EXTRA_BUF_DET;
> +               reg &= EP_STS_EN_DESCMISEN;
> +               writel(reg, &priv_dev->regs->ep_sts_en);
> +       }
> +
> +       /* WA1 */
> +       if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN) {
> +               u8 pending_empty = list_empty(&priv_ep->pending_req_list);
> +               u8 descmiss_empty = list_empty(&priv_ep->descmiss_req_list);
> +
> +               /*
> +                *  DESCMISS transfer has been finished, so data will be
> +                *  directly copied from internal allocated usb_request
> +                *  objects.
> +                */
> +               if (pending_empty && !descmiss_empty &&
> +                   !(priv_req->flags & REQUEST_INTERNAL)) {
> +                       cdns3_descmiss_copy_data(priv_ep, request);
> +                       list_add_tail(&request->list,
> +                                     &priv_ep->pending_req_list);
> +                       cdns3_gadget_giveback(priv_ep, priv_req,
> +                                             request->status);
> +                       return ret;
> +               }
> +
> +               /*
> +                * WA1 driver will wait for completion DESCMISS transfer,
> +                * before starts new, not DESCMISS transfer.
> +                */
> +               if (!pending_empty && !descmiss_empty)
> +                       deferred = 1;
> +
> +               if (priv_req->flags & REQUEST_INTERNAL)
> +                       list_add_tail(&priv_req->list,
> +                                     &priv_ep->descmiss_req_list);
> +       }
> +
> +       ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
> +                                           usb_endpoint_dir_in(ep->desc));
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * If hardware endpoint configuration has not been set yet then
> +        * just queue request in deferred list. Transfer will be started in
> +        * cdns3_set_hw_configuration.
> +        */
> +       if (!priv_dev->hw_configured_flag)
> +               deferred = 1;
> +       else
> +               ret = cdns3_ep_run_transfer(priv_ep, request);
> +
> +       if (ret || deferred)
> +               list_add_tail(&request->list, &priv_ep->deferred_req_list);
> +       else
> +               list_add_tail(&request->list, &priv_ep->pending_req_list);
> +
> +       return ret;
> +}
> +
> +static int cdns3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
> +                                gfp_t gfp_flags)
> +{
> +       struct usb_request *zlp_request;
> +       struct cdns3_endpoint *priv_ep;
> +       struct cdns3_device *priv_dev;
> +       unsigned long flags;
> +       int ret;
> +
> +       if (!request || !ep)
> +               return -EINVAL;
> +
> +       priv_ep = ep_to_cdns3_ep(ep);
> +       priv_dev = priv_ep->cdns3_dev;
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +       ret = __cdns3_gadget_ep_queue(ep, request, gfp_flags);
> +
> +       if (ret == 0 && request->zero && request->length &&
> +           (request->length % ep->maxpacket == 0)) {
> +               struct cdns3_request *priv_req;
> +
> +               zlp_request = cdns3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
> +               zlp_request->buf = priv_dev->zlp_buf;
> +               zlp_request->length = 0;
> +
> +               priv_req = to_cdns3_request(zlp_request);
> +               priv_req->flags |= REQUEST_ZLP;
> +
> +               dev_dbg(priv_dev->dev, "Queuing ZLP for endpoint: %s\n",
> +                       priv_ep->name);
> +               ret = __cdns3_gadget_ep_queue(ep, zlp_request, gfp_flags);
> +       }
> +
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +       return ret;
> +}
> +
> +/**
> + * cdns3_gadget_ep_dequeue Remove request from transfer queue
> + * @ep: endpoint object associated with request
> + * @request: request object
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
> +                           struct usb_request *request)
> +{
> +       struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       struct usb_request *req, *req_temp;
> +       struct cdns3_request *priv_req;
> +       unsigned long flags;
> +       int ret = 0;
> +
> +       if (!ep || !request || !ep->desc)
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +       priv_req = to_cdns3_request(request);
> +
> +       trace_cdns3_ep_dequeue(priv_req);
> +
> +       cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
> +
> +       list_for_each_entry_safe(req, req_temp, &priv_ep->pending_req_list,
> +                                list) {
> +               if (request == req)
> +                       goto found;
> +       }
> +
> +       list_for_each_entry_safe(req, req_temp, &priv_ep->deferred_req_list,
> +                                list) {
> +               if (request == req)
> +                       goto found;
> +       }
> +
> +found:
> +       if (request == req)
> +               cdns3_gadget_giveback(priv_ep, priv_req, -ECONNRESET);
> +
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +       return ret;
> +}
> +
> +/**
> + * cdns3_gadget_ep_set_halt Sets/clears stall on selected endpoint
> + * @ep: endpoint object to set/clear stall on
> + * @value: 1 for set stall, 0 for clear stall
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value)
> +{
> +       struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
> +       struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +       unsigned long flags;
> +       int ret = 0;
> +
> +       if (!(priv_ep->flags & EP_ENABLED))
> +               return -EPERM;
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +       /* if actual transfer is pending defer setting stall on this endpoint */
> +       if ((priv_ep->flags & EP_PENDING_REQUEST) && value) {
> +               priv_ep->flags |= EP_STALL;
> +               goto finish;
> +       }
> +
> +       dev_dbg(priv_dev->dev, "Halt endpoint %s\n", priv_ep->name);
> +
> +       cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
> +       if (value) {
> +               cdns3_ep_stall_flush(priv_ep);
> +       } else {
> +               priv_ep->flags &= ~EP_WEDGE;
> +               writel(EP_CMD_CSTALL | EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> +
> +               /* wait for EPRST cleared */
> +               ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
> +                                     EP_CMD_EPRST, 0, 100);
> +               if (unlikely(ret)) {
> +                       dev_err(priv_dev->dev,
> +                               "Clearing halt condition failed for %s\n",
> +                               priv_ep->name);
> +                       goto finish;
> +
> +               } else {
> +                       priv_ep->flags &= ~EP_STALL;
> +               }
> +       }
> +
> +       priv_ep->flags &= ~EP_PENDING_REQUEST;
> +finish:
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +
> +       return ret;
> +}
> +
> +extern const struct usb_ep_ops cdns3_gadget_ep0_ops;
> +
> +static const struct usb_ep_ops cdns3_gadget_ep_ops = {
> +       .enable = cdns3_gadget_ep_enable,
> +       .disable = cdns3_gadget_ep_disable,
> +       .alloc_request = cdns3_gadget_ep_alloc_request,
> +       .free_request = cdns3_gadget_ep_free_request,
> +       .queue = cdns3_gadget_ep_queue,
> +       .dequeue = cdns3_gadget_ep_dequeue,
> +       .set_halt = cdns3_gadget_ep_set_halt,
> +       .set_wedge = cdns3_gadget_ep_set_wedge,
> +};
> +
> +/**
> + * cdns3_gadget_get_frame Returns number of actual ITP frame
> + * @gadget: gadget object
> + *
> + * Returns number of actual ITP frame
> + */
> +static int cdns3_gadget_get_frame(struct usb_gadget *gadget)
> +{
> +       struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> +
> +       return readl(&priv_dev->regs->usb_iptn);
> +}
> +
> +static int cdns3_gadget_wakeup(struct usb_gadget *gadget)
> +{
> +       return 0;
> +}
> +
> +static int cdns3_gadget_set_selfpowered(struct usb_gadget *gadget,
> +                                       int is_selfpowered)
> +{
> +       struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +       priv_dev->is_selfpowered = !!is_selfpowered;
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +       return 0;
> +}
> +
> +static int cdns3_gadget_pullup(struct usb_gadget *gadget, int is_on)
> +{
> +       struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> +
> +       if (is_on)
> +               writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
> +       else
> +               writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
> +
> +       return 0;
> +}
> +
> +static void cdns3_gadget_config(struct cdns3_device *priv_dev)
> +{
> +       struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
> +
> +       cdns3_ep0_config(priv_dev);
> +
> +       /* enable interrupts for endpoint 0 (in and out) */
> +       writel(EP_IEN_EP_OUT0 | EP_IEN_EP_IN0, &regs->ep_ien);
> +
> +       /* enable generic interrupt*/
> +       writel(USB_IEN_INIT, &regs->usb_ien);
> +       writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
> +       writel(USB_CONF_DMULT, &regs->usb_conf);
> +       cdns3_gadget_pullup(&priv_dev->gadget, 1);
> +}
> +
> +/**
> + * cdns3_gadget_udc_start Gadget start
> + * @gadget: gadget object
> + * @driver: driver which operates on this gadget
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
> +                                 struct usb_gadget_driver *driver)
> +{
> +       struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +       priv_dev->gadget_driver = driver;
> +       cdns3_gadget_config(priv_dev);
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +       return 0;
> +}
> +
> +/**
> + * cdns3_gadget_udc_stop Stops gadget
> + * @gadget: gadget object
> + *
> + * Returns 0
> + */
> +static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
> +{
> +       struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> +       struct cdns3_endpoint *priv_ep;
> +       u32 bEndpointAddress;
> +       struct usb_ep *ep;
> +       int ret = 0;
> +
> +       priv_dev->gadget_driver = NULL;
> +
> +       priv_dev->onchip_mem_allocated_size = 0;
> +       priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> +
> +       list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
> +               priv_ep = ep_to_cdns3_ep(ep);
> +               bEndpointAddress = priv_ep->num | priv_ep->dir;
> +               cdns3_select_ep(priv_dev, bEndpointAddress);
> +               writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> +               ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
> +                                     EP_CMD_EPRST, 0, 100);
> +               cdns3_free_trb_pool(priv_ep);
> +       }
> +
> +       /* disable interrupt for device */
> +       writel(0, &priv_dev->regs->usb_ien);
> +       writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
> +
> +       return ret;
> +}
> +
> +static const struct usb_gadget_ops cdns3_gadget_ops = {
> +       .get_frame = cdns3_gadget_get_frame,
> +       .wakeup = cdns3_gadget_wakeup,
> +       .set_selfpowered = cdns3_gadget_set_selfpowered,
> +       .pullup = cdns3_gadget_pullup,
> +       .udc_start = cdns3_gadget_udc_start,
> +       .udc_stop = cdns3_gadget_udc_stop,
> +       .match_ep = cdns3_gadget_match_ep,
> +};
> +
> +static void cdns3_free_all_eps(struct cdns3_device *priv_dev)
> +{
> +       int i;
> +
> +       /*ep0 OUT point to ep0 IN*/
> +       priv_dev->eps[16] = NULL;
> +
> +       cdns3_free_trb_pool(priv_dev->eps[0]);
> +
> +       for (i = 0; i < CDNS3_ENDPOINTS_MAX_COUNT; i++)
> +               if (priv_dev->eps[i])
> +                       devm_kfree(priv_dev->dev, priv_dev->eps[i]);
> +}
> +
> +/**
> + * cdns3_init_eps Initializes software endpoints of gadget
> + * @cdns3: extended gadget object
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +static int cdns3_init_eps(struct cdns3_device *priv_dev)
> +{
> +       u32 ep_enabled_reg, iso_ep_reg;
> +       struct cdns3_endpoint *priv_ep;
> +       int ep_dir, ep_number;
> +       u32 ep_mask;
> +       int ret = 0;
> +       int i;
> +
> +       /* Read it from USB_CAP3 to USB_CAP5 */
> +       ep_enabled_reg = readl(&priv_dev->regs->usb_cap3);
> +       iso_ep_reg = readl(&priv_dev->regs->usb_cap4);
> +
> +       dev_dbg(priv_dev->dev, "Initializing non-zero endpoints\n");
> +
> +       for (i = 0; i < CDNS3_ENDPOINTS_MAX_COUNT; i++) {
> +               ep_dir = i >> 4;        /* i div 16 */
> +               ep_number = i & 0xF;    /* i % 16 */
> +               ep_mask = BIT(i);
> +
> +               if (!(ep_enabled_reg & ep_mask))
> +                       continue;
> +
> +               if (ep_dir && !ep_number) {
> +                       priv_dev->eps[i] = priv_dev->eps[0];
> +                       continue;
> +               }
> +
> +               priv_ep = devm_kzalloc(priv_dev->dev, sizeof(*priv_ep),
> +                                      GFP_KERNEL);
> +               if (!priv_ep) {
> +                       ret = -ENOMEM;
> +                       goto err;
> +               }
> +
> +               /* set parent of endpoint object */
> +               priv_ep->cdns3_dev = priv_dev;
> +               priv_dev->eps[i] = priv_ep;
> +               priv_ep->num = ep_number;
> +               priv_ep->dir = ep_dir ? USB_DIR_IN : USB_DIR_OUT;
> +
> +               if (!ep_number) {
> +                       ret = cdns3_init_ep0(priv_dev, priv_ep);
> +                       if (ret) {
> +                               dev_err(priv_dev->dev, "Failed to init ep0\n");
> +                               goto err;
> +                       }
> +               } else {
> +                       snprintf(priv_ep->name, sizeof(priv_ep->name), "ep%d%s",
> +                                ep_number, !!ep_dir ? "in" : "out");
> +                       priv_ep->endpoint.name = priv_ep->name;
> +
> +                       usb_ep_set_maxpacket_limit(&priv_ep->endpoint,
> +                                                  CDNS3_EP_MAX_PACKET_LIMIT);
> +                       priv_ep->endpoint.max_streams = CDNS3_EP_MAX_STREAMS;
> +                       priv_ep->endpoint.ops = &cdns3_gadget_ep_ops;
> +                       if (ep_dir)
> +                               priv_ep->endpoint.caps.dir_in = 1;
> +                       else
> +                               priv_ep->endpoint.caps.dir_out = 1;
> +
> +                       if (iso_ep_reg & ep_mask)
> +                               priv_ep->endpoint.caps.type_iso = 1;
> +
> +                       priv_ep->endpoint.caps.type_bulk = 1;
> +                       priv_ep->endpoint.caps.type_int = 1;
> +                       priv_ep->endpoint.maxburst = CDNS3_EP_BUF_SIZE - 1;
> +
> +                       list_add_tail(&priv_ep->endpoint.ep_list,
> +                                     &priv_dev->gadget.ep_list);
> +               }
> +
> +               priv_ep->flags = 0;
> +
> +               dev_info(priv_dev->dev, "Initialized  %s support: %s %s\n",
> +                        priv_ep->name,
> +                        priv_ep->endpoint.caps.type_bulk ? "BULK, INT" : "",
> +                        priv_ep->endpoint.caps.type_iso ? "ISO" : "");
> +
> +               INIT_LIST_HEAD(&priv_ep->pending_req_list);
> +               INIT_LIST_HEAD(&priv_ep->deferred_req_list);
> +               INIT_LIST_HEAD(&priv_ep->descmiss_req_list);
> +       }
> +
> +       return 0;
> +err:
> +       cdns3_free_all_eps(priv_dev);
> +       return -ENOMEM;
> +}
> +
> +static void cdns3_gadget_disable(struct cdns3 *cdns)
> +{
> +       struct cdns3_device *priv_dev;
> +
> +       priv_dev = cdns->gadget_dev;
> +
> +       if (priv_dev->gadget_driver)
> +               priv_dev->gadget_driver->disconnect(&priv_dev->gadget);
> +
> +       usb_gadget_disconnect(&priv_dev->gadget);
> +       priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> +}
> +
> +void cdns3_gadget_exit(struct cdns3 *cdns)
> +{
> +       struct cdns3_device *priv_dev;
> +
> +       priv_dev = cdns->gadget_dev;
> +
> +       cdns3_gadget_disable(cdns);
> +
> +       devm_free_irq(cdns->dev, cdns->irq, cdns);
> +
> +       pm_runtime_mark_last_busy(cdns->dev);
> +       pm_runtime_put_autosuspend(cdns->dev);
> +
> +       usb_del_gadget_udc(&priv_dev->gadget);
> +
> +       cdns3_free_all_eps(priv_dev);
> +
> +       dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
> +                         priv_dev->setup_dma);
> +
> +       kfree(priv_dev->zlp_buf);
> +       kfree(priv_dev);
> +       cdns->gadget_dev = NULL;
> +}
> +
> +static int cdns3_gadget_start(struct cdns3 *cdns)
> +{
> +       struct cdns3_device *priv_dev;
> +       u32 max_speed;
> +       int ret;
> +
> +       priv_dev = kzalloc(sizeof(*priv_dev), GFP_KERNEL);
> +       if (!priv_dev)
> +               return -ENOMEM;
> +
> +       cdns->gadget_dev = priv_dev;
> +       priv_dev->sysdev = cdns->dev;
> +       priv_dev->dev = cdns->dev;
> +       priv_dev->regs = cdns->dev_regs;
> +
> +       max_speed = usb_get_maximum_speed(cdns->dev);
> +
> +       /* Check the maximum_speed parameter */
> +       switch (max_speed) {
> +       case USB_SPEED_FULL:
> +       case USB_SPEED_HIGH:
> +       case USB_SPEED_SUPER:
> +               break;
> +       default:
> +               dev_err(cdns->dev, "invalid maximum_speed parameter %d\n",
> +                       max_speed);
> +               /* fall through */
> +       case USB_SPEED_UNKNOWN:
> +               /* default to superspeed */
> +               max_speed = USB_SPEED_SUPER;
> +               break;
> +       }
> +
> +       /* fill gadget fields */
> +       priv_dev->gadget.max_speed = max_speed;
> +       priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> +       priv_dev->gadget.ops = &cdns3_gadget_ops;
> +       priv_dev->gadget.name = "usb-ss-gadget";
> +       priv_dev->gadget.sg_supported = 1;
> +
> +       spin_lock_init(&priv_dev->lock);
> +       INIT_WORK(&priv_dev->pending_status_wq,
> +                 cdns3_pending_setup_status_handler);
> +
> +       /* initialize endpoint container */
> +       INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
> +
> +       ret = cdns3_init_eps(priv_dev);
> +       if (ret) {
> +               dev_err(priv_dev->dev, "Failed to create endpoints\n");
> +               goto err1;
> +       }
> +
> +       /* allocate memory for setup packet buffer */
> +       priv_dev->setup_buf = dma_alloc_coherent(priv_dev->sysdev, 8,
> +                                                &priv_dev->setup_dma, GFP_DMA);
> +       if (!priv_dev->setup_buf) {
> +               dev_err(priv_dev->dev, "Failed to allocate memory for SETUP buffer\n");
> +               ret = -ENOMEM;
> +               goto err2;
> +       }
> +
> +       priv_dev->dev_ver = readl(&priv_dev->regs->usb_cap6);
> +       dev_dbg(priv_dev->dev, "Device Controller version: %08x\n",
> +               readl(&priv_dev->regs->usb_cap6));
> +       dev_dbg(priv_dev->dev, "USB Capabilities:: %08x\n",
> +               readl(&priv_dev->regs->usb_cap1));
> +       dev_dbg(priv_dev->dev, "On-Chip memory cnfiguration: %08x\n",
> +               readl(&priv_dev->regs->usb_cap2));
> +
> +       priv_dev->zlp_buf = kzalloc(CDNS3_EP_ZLP_BUF_SIZE, GFP_KERNEL);
> +       if (!priv_dev->zlp_buf) {
> +               ret = -ENOMEM;
> +               goto err3;
> +       }
> +
> +       /* add USB gadget device */
> +       ret = usb_add_gadget_udc(priv_dev->dev, &priv_dev->gadget);
> +       if (ret < 0) {
> +               dev_err(priv_dev->dev,
> +                       "Failed to register USB device controller\n");
> +               goto err4;
> +       }
> +
> +       return 0;
> +err4:
> +       kfree(priv_dev->zlp_buf);
> +err3:
> +       dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
> +                         priv_dev->setup_dma);
> +err2:
> +       cdns3_free_all_eps(priv_dev);
> +err1:
> +       cdns->gadget_dev = NULL;
> +       return ret;
> +}
> +
> +static int __cdns3_gadget_init(struct cdns3 *cdns)
> +{
> +       struct cdns3_device *priv_dev;
> +       unsigned long flags;
> +       int ret = 0;
> +
> +       ret = cdns3_gadget_start(cdns);
> +       if (ret)
> +               return ret;
> +
> +       priv_dev = cdns->gadget_dev;
> +       ret = devm_request_threaded_irq(cdns->dev, cdns->irq,
> +                                       cdns3_device_irq_handler,
> +                                       cdns3_device_thread_irq_handler,
> +                                       IRQF_SHARED, dev_name(cdns->dev), cdns);
> +       if (ret)
> +               goto err0;
> +
> +       pm_runtime_get_sync(cdns->dev);
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +       return 0;
> +err0:
> +       cdns3_gadget_exit(cdns);
> +       return ret;
> +}
> +
> +static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
> +{
> +       cdns3_gadget_disable(cdns);
> +       return 0;
> +}
> +
> +static int cdns3_gadget_resume(struct cdns3 *cdns, bool hibernated)
> +{
> +       struct cdns3_device *priv_dev;
> +       unsigned long flags;
> +
> +       priv_dev = cdns->gadget_dev;
> +       spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +       if (!priv_dev->gadget_driver) {
> +               spin_unlock_irqrestore(&priv_dev->lock, flags);
> +               return 0;
> +       }
> +
> +       cdns3_gadget_config(priv_dev);
> +       spin_unlock_irqrestore(&priv_dev->lock, flags);
> +       return 0;
> +}
> +
> +/**
> + * cdns3_gadget_init - initialize device structure
> + *
> + * cdns: cdns3 instance
> + *
> + * This function initializes the gadget.
> + */
> +int cdns3_gadget_init(struct cdns3 *cdns)
> +{
> +       struct cdns3_role_driver *rdrv;
> +
> +       rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
> +       if (!rdrv)
> +               return -ENOMEM;
> +
> +       rdrv->start     = __cdns3_gadget_init;
> +       rdrv->stop      = cdns3_gadget_exit;
> +       rdrv->suspend   = cdns3_gadget_suspend;
> +       rdrv->resume    = cdns3_gadget_resume;
> +       rdrv->state     = CDNS3_ROLE_STATE_INACTIVE;
> +       rdrv->name      = "gadget";
> +       cdns->roles[CDNS3_ROLE_GADGET] = rdrv;
> +
> +       return 0;
> +}
> diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
> new file mode 100644
> index 000000000000..41cec7f085ad
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget.h
> @@ -0,0 +1,1206 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * USBSS device controller driver header file
> + *
> + * Copyright (C) 2018 Cadence.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *         Pawel Jez <pjez@cadence.com>
> + *         Peter Chen <peter.chen@nxp.com>
> + */
> +#ifndef __LINUX_CDNS3_GADGET
> +#define __LINUX_CDNS3_GADGET
> +#include <linux/usb/gadget.h>
> +
> +/*
> + * USBSS-DEV register interface.
> + * This corresponds to the USBSS Device Controller Interface
> + */
> +
> +/**
> + * struct cdns3_usb_regs - device controller registers.
> + * @usb_conf:      Global Configuration Register.
> + * @usb_sts:       Global Status Register.
> + * @usb_cmd:       Global Command Register.
> + * @usb_iptn:      ITP/SOF number Register.
> + * @usb_lpm:       Global Command Register.
> + * @usb_ien:       USB Interrupt Enable Register.
> + * @usb_ists:      USB Interrupt Status Register.
> + * @ep_sel:        Endpoint Select Register.
> + * @ep_traddr:     Endpoint Transfer Ring Address Register.
> + * @ep_cfg:        Endpoint Configuration Register.
> + * @ep_cmd:        Endpoint Command Register.
> + * @ep_sts:        Endpoint Status Register.
> + * @ep_sts_sid:    Endpoint Status Register.
> + * @ep_sts_en:     Endpoint Status Register Enable.
> + * @drbl:          Doorbell Register.
> + * @ep_ien:        EP Interrupt Enable Register.
> + * @ep_ists:       EP Interrupt Status Register.
> + * @usb_pwr:       Global Power Configuration Register.
> + * @usb_conf2:     Global Configuration Register 2.
> + * @usb_cap1:      Capability Register 1.
> + * @usb_cap2:      Capability Register 2.
> + * @usb_cap3:      Capability Register 3.
> + * @usb_cap4:      Capability Register 4.
> + * @usb_cap5:      Capability Register 5.
> + * @usb_cap6:      Capability Register 6.
> + * @usb_cpkt1:     Custom Packet Register 1.
> + * @usb_cpkt2:     Custom Packet Register 2.
> + * @usb_cpkt3:     Custom Packet Register 3.
> + * @reserved1:     Reserved.
> + * @cfg_regs:      Configuration registers.
> + * @reserved2:     Reserved.
> + * @dma_axi_ctrl:  AXI Control register.
> + * @dma_axi_id:    AXI ID register.
> + * @dma_axi_cap:   AXI Capability register.
> + * @dma_axi_ctrl0: AXI Control 0 register.
> + * @dma_axi_ctrl1: AXI Control 1 register.
> + */
> +struct cdns3_usb_regs {
> +       __le32 usb_conf;
> +       __le32 usb_sts;
> +       __le32 usb_cmd;
> +       __le32 usb_iptn;
> +       __le32 usb_lpm;
> +       __le32 usb_ien;
> +       __le32 usb_ists;
> +       __le32 ep_sel;
> +       __le32 ep_traddr;
> +       __le32 ep_cfg;
> +       __le32 ep_cmd;
> +       __le32 ep_sts;
> +       __le32 ep_sts_sid;
> +       __le32 ep_sts_en;
> +       __le32 drbl;
> +       __le32 ep_ien;
> +       __le32 ep_ists;
> +       __le32 usb_pwr;
> +       __le32 usb_conf2;
> +       __le32 usb_cap1;
> +       __le32 usb_cap2;
> +       __le32 usb_cap3;
> +       __le32 usb_cap4;
> +       __le32 usb_cap5;
> +       __le32 usb_cap6;
> +       __le32 usb_cpkt1;
> +       __le32 usb_cpkt2;
> +       __le32 usb_cpkt3;
> +       __le32 reserved1[36];
> +       __le32 cfg_reg1;
> +       __le32 dbg_link1;
> +       __le32 dbg_link2;
> +       __le32 cfg_regs[74];
> +       __le32 reserved2[34];
> +       __le32 dma_axi_ctrl;
> +       __le32 dma_axi_id;
> +       __le32 dma_axi_cap;
> +       __le32 dma_axi_ctrl0;
> +       __le32 dma_axi_ctrl1;
> +};
> +
> +/* USB_CONF - bitmasks */
> +/* Reset USB device configuration. */
> +#define USB_CONF_CFGRST                BIT(0)
> +/* Set Configuration. */
> +#define USB_CONF_CFGSET                BIT(1)
> +/* Disconnect USB device in SuperSpeed. */
> +#define USB_CONF_USB3DIS       BIT(3)
> +/* Disconnect USB device in HS/FS */
> +#define USB_CONF_USB2DIS       BIT(4)
> +/* Little Endian access - default */
> +#define USB_CONF_LENDIAN       BIT(5)
> +/*
> + * Big Endian access. Driver assume that byte order for
> + * SFRs access always is as Little Endian so this bit
> + * is not used.
> + */
> +#define USB_CONF_BENDIAN       BIT(6)
> +/* Device software reset. */
> +#define USB_CONF_SWRST         BIT(7)
> +/* Singular DMA transfer mode. */
> +#define USB_CONF_DSING         BIT(8)
> +/* Multiple DMA transfers mode. */
> +#define USB_CONF_DMULT         BIT(9)
> +/* DMA clock turn-off enable. */
> +#define USB_CONF_DMAOFFEN      BIT(10)
> +/* DMA clock turn-off disable. */
> +#define USB_CONF_DMAOFFDS      BIT(11)
> +/* Clear Force Full Speed. */
> +#define USB_CONF_CFORCE_FS     BIT(12)
> +/* Set Force Full Speed. */
> +#define USB_CONF_SFORCE_FS     BIT(13)
> +/* Device enable. */
> +#define USB_CONF_DEVEN         BIT(14)
> +/* Device disable. */
> +#define USB_CONF_DEVDS         BIT(15)
> +/* L1 LPM state entry enable (used in HS/FS mode). */
> +#define USB_CONF_L1EN          BIT(16)
> +/* L1 LPM state entry disable (used in HS/FS mode). */
> +#define USB_CONF_L1DS          BIT(17)
> +/* USB 2.0 clock gate disable. */
> +#define USB_CONF_CLK2OFFEN     BIT(18)
> +/* USB 2.0 clock gate enable. */
> +#define USB_CONF_CLK2OFFDS     BIT(19)
> +/* L0 LPM state entry request (used in HS/FS mode). */
> +#define USB_CONF_LGO_L0                BIT(20)
> +/* USB 3.0 clock gate disable. */
> +#define USB_CONF_CLK3OFFEN     BIT(21)
> +/* USB 3.0 clock gate enable. */
> +#define USB_CONF_CLK3OFFDS     BIT(22)
> +/* Bit 23 is reserved*/
> +/* U1 state entry enable (used in SS mode). */
> +#define USB_CONF_U1EN          BIT(24)
> +/* U1 state entry disable (used in SS mode). */
> +#define USB_CONF_U1DS          BIT(25)
> +/* U2 state entry enable (used in SS mode). */
> +#define USB_CONF_U2EN          BIT(26)
> +/* U2 state entry disable (used in SS mode). */
> +#define USB_CONF_U2DS          BIT(27)
> +/* U0 state entry request (used in SS mode). */
> +#define USB_CONF_LGO_U0                BIT(28)
> +/* U1 state entry request (used in SS mode). */
> +#define USB_CONF_LGO_U1                BIT(29)
> +/* U2 state entry request (used in SS mode). */
> +#define USB_CONF_LGO_U2                BIT(30)
> +/* SS.Inactive state entry request (used in SS mode) */
> +#define USB_CONF_LGO_SSINACT   BIT(31)
> +
> +/* USB_STS - bitmasks */
> +/*
> + * Configuration status.
> + * 1 - device is in the configured state.
> + * 0 - device is not configured.
> + */
> +#define USB_STS_CFGSTS_MASK    BIT(0)
> +#define USB_STS_CFGSTS(p)      ((p) & USB_STS_CFGSTS_MASK)
> +/*
> + * On-chip memory overflow.
> + * 0 - On-chip memory status OK.
> + * 1 - On-chip memory overflow.
> + */
> +#define USB_STS_OV_MASK                BIT(1)
> +#define USB_STS_OV(p)          ((p) & USB_STS_OV_MASK)
> +/*
> + * SuperSpeed connection status.
> + * 0 - USB in SuperSpeed mode disconnected.
> + * 1 - USB in SuperSpeed mode connected.
> + */
> +#define USB_STS_USB3CONS_MASK  BIT(2)
> +#define USB_STS_USB3CONS(p)    ((p) & USB_STS_USB3CONS_MASK)
> +/*
> + * DMA transfer configuration status.
> + * 0 - single request.
> + * 1 - multiple TRB chain
> + */
> +#define USB_STS_DTRANS_MASK    BIT(3)
> +#define USB_STS_DTRANS(p)      ((p) & USB_STS_DTRANS_MASK)
> +/*
> + * Device speed.
> + * 0 - Undefined (value after reset).
> + * 1 - Low speed
> + * 2 - Full speed
> + * 3 - High speed
> + * 4 - Super speed
> + */
> +#define USB_STS_USBSPEED_MASK  GENMASK(6, 4)
> +#define USB_STS_USBSPEED(p)    (((p) & USB_STS_USBSPEED_MASK) >> 4)
> +#define USB_STS_LS             (0x1 << 4)
> +#define USB_STS_FS             (0x2 << 4)
> +#define USB_STS_HS             (0x3 << 4)
> +#define USB_STS_SS             (0x4 << 4)
> +#define DEV_UNDEFSPEED(p)      (((p) & USB_STS_USBSPEED_MASK) == (0x0 << 4))
> +#define DEV_LOWSPEED(p)                (((p) & USB_STS_USBSPEED_MASK) == USB_STS_LS)
> +#define DEV_FULLSPEED(p)       (((p) & USB_STS_USBSPEED_MASK) == USB_STS_FS)
> +#define DEV_HIGHSPEED(p)       (((p) & USB_STS_USBSPEED_MASK) == USB_STS_HS)
> +#define DEV_SUPERSPEED(p)      (((p) & USB_STS_USBSPEED_MASK) == USB_STS_SS)
> +/*
> + * Endianness for SFR access.
> + * 0 - Little Endian order (default after hardware reset).
> + * 1 - Big Endian order
> + */
> +#define USB_STS_ENDIAN_MASK    BIT(7)
> +#define USB_STS_ENDIAN(p)      ((p) & USB_STS_ENDIAN_MASK)
> +/*
> + * HS/FS clock turn-off status.
> + * 0 - hsfs clock is always on.
> + * 1 - hsfs clock turn-off in L2 (HS/FS mode) is enabled
> + *          (default after hardware reset).
> + */
> +#define USB_STS_CLK2OFF_MASK   BIT(8)
> +#define USB_STS_CLK2OFF(p)     ((p) & USB_STS_CLK2OFF_MASK)
> +/*
> + * PCLK clock turn-off status.
> + * 0 - pclk clock is always on.
> + * 1 - pclk clock turn-off in U3 (SS mode) is enabled
> + *          (default after hardware reset).
> + */
> +#define USB_STS_CLK3OFF_MASK   BIT(9)
> +#define USB_STS_CLK3OFF(p)     ((p) & USB_STS_CLK3OFF_MASK)
> +/*
> + * Controller in reset state.
> + * 0 - Internal reset is active.
> + * 1 - Internal reset is not active and controller is fully operational.
> + */
> +#define USB_STS_IN_RST_MASK    BIT(10)
> +#define USB_STS_IN_RST(p)      ((p) & USB_STS_IN_RST_MASK)
> +/*
> + * Device enable Status.
> + * 0 - USB device is disabled (VBUS input is disconnected from internal logic).
> + * 1 - USB device is enabled (VBUS input is connected to the internal logic).
> + */
> +#define USB_STS_DEVS_MASK      BIT(14)
> +#define USB_STS_DEVS(p)                ((p) & USB_STS_DEVS_MASK)
> +/*
> + * DAddress statuss.
> + * 0 - USB device is default state.
> + * 1 - USB device is at least in address state.
> + */
> +#define USB_STS_ADDRESSED_MASK BIT(15)
> +#define USB_STS_ADDRESSED(p)   ((p) & USB_STS_ADDRESSED_MASK)
> +/*
> + * L1 LPM state enable status (used in HS/FS mode).
> + * 0 - Entering to L1 LPM state disabled.
> + * 1 - Entering to L1 LPM state enabled.
> + */
> +#define USB_STS_L1ENS_MASK     BIT(16)
> +#define USB_STS_L1ENS(p)       ((p) & USB_STS_L1ENS_MASK)
> +/*
> + * Internal VBUS connection status (used both in HS/FS  and SS mode).
> + * 0 - internal VBUS is not detected.
> + * 1 - internal VBUS is detected.
> + */
> +#define USB_STS_VBUSS_MASK     BIT(17)
> +#define USB_STS_VBUSS(p)       ((p) & USB_STS_VBUSS_MASK)
> +/*
> + * HS/FS LPM  state (used in FS/HS mode).
> + * 0 - L0 State
> + * 1 - L1 State
> + * 2 - L2 State
> + * 3 - L3 State
> + */
> +#define USB_STS_LPMST_MASK     GENMASK(19, 18)
> +#define DEV_L0_STATE(p)                (((p) & USB_STS_LPMST_MASK) == (0x0 << 18))
> +#define DEV_L1_STATE(p)                (((p) & USB_STS_LPMST_MASK) == (0x1 << 18))
> +#define DEV_L2_STATE(p)                (((p) & USB_STS_LPMST_MASK) == (0x2 << 18))
> +#define DEV_L3_STATE(p)                (((p) & USB_STS_LPMST_MASK) == (0x3 << 18))
> +/*
> + * Disable HS status (used in FS/HS mode).
> + * 0 - the disconnect bit for HS/FS mode is set .
> + * 1 - the disconnect bit for HS/FS mode is not set.
> + */
> +#define USB_STS_USB2CONS_MASK  BIT(20)
> +#define USB_STS_USB2CONS(p)    ((p) & USB_STS_USB2CONS_MASK)
> +/*
> + * HS/FS mode connection status (used in FS/HS mode).
> + * 0 - High Speed operations in USB2.0 (FS/HS) mode not disabled.
> + * 1 - High Speed operations in USB2.0 (FS/HS).
> + */
> +#define USB_STS_DISABLE_HS_MASK        BIT(21)
> +#define USB_STS_DISABLE_HS(p)  ((p) & USB_STS_DISABLE_HS_MASK)
> +/*
> + * U1 state enable status (used in SS mode).
> + * 0 - Entering to  U1 state disabled.
> + * 1 - Entering to  U1 state enabled.
> + */
> +#define USB_STS_U1ENS_MASK     BIT(24)
> +#define USB_STS_U1ENS(p)       ((p) & USB_STS_U1ENS_MASK)
> +/*
> + * U2 state enable status (used in SS mode).
> + * 0 - Entering to  U2 state disabled.
> + * 1 - Entering to  U2 state enabled.
> + */
> +#define USB_STS_U2ENS_MASK     BIT(25)
> +#define USB_STS_U2ENS(p)       ((p) & USB_STS_U2ENS_MASK)
> +/*
> + * SuperSpeed Link LTSSM state. This field reflects USBSS-DEV current
> + * SuperSpeed link state
> + */
> +#define USB_STS_LST_MASK       GENMASK(29, 26)
> +#define DEV_LST_U0             (((p) & USB_STS_LST_MASK) == (0x0 << 26))
> +#define DEV_LST_U1             (((p) & USB_STS_LST_MASK) == (0x1 << 26))
> +#define DEV_LST_U2             (((p) & USB_STS_LST_MASK) == (0x2 << 26))
> +#define DEV_LST_U3             (((p) & USB_STS_LST_MASK) == (0x3 << 26))
> +#define DEV_LST_DISABLED       (((p) & USB_STS_LST_MASK) == (0x4 << 26))
> +#define DEV_LST_RXDETECT       (((p) & USB_STS_LST_MASK) == (0x5 << 26))
> +#define DEV_LST_INACTIVE       (((p) & USB_STS_LST_MASK) == (0x6 << 26))
> +#define DEV_LST_POLLING                (((p) & USB_STS_LST_MASK) == (0x7 << 26))
> +#define DEV_LST_RECOVERY       (((p) & USB_STS_LST_MASK) == (0x8 << 26))
> +#define DEV_LST_HOT_RESET      (((p) & USB_STS_LST_MASK) == (0x9 << 26))
> +#define DEV_LST_COMP_MODE      (((p) & USB_STS_LST_MASK) == (0xa << 26))
> +#define DEV_LST_LB_STATE       (((p) & USB_STS_LST_MASK) == (0xb << 26))
> +/*
> + * DMA clock turn-off status.
> + * 0 - DMA clock is always on (default after hardware reset).
> + * 1 - DMA clock turn-off in U1, U2 and U3 (SS mode) is enabled.
> + */
> +#define USB_STS_DMAOFF_MASK    BIT(30)
> +#define USB_STS_DMAOFF(p)      ((p) & USB_STS_DMAOFF_MASK)
> +/*
> + * SFR Endian statuss.
> + * 0 - Little Endian order (default after hardware reset).
> + * 1 - Big Endian order.
> + */
> +#define USB_STS_ENDIAN2_MASK   BIT(31)
> +#define USB_STS_ENDIAN2(p)     ((p) & USB_STS_ENDIAN2_MASK)
> +
> +/* USB_CMD -  bitmasks */
> +/* Set Function Address */
> +#define USB_CMD_SET_ADDR       BIT(0)
> +/*
> + * Function Address This field is saved to the device only when the field
> + * SET_ADDR is set '1 ' during write to USB_CMD register.
> + * Software is responsible for entering the address of the device during
> + * SET_ADDRESS request service. This field should be set immediately after
> + * the SETUP packet is decoded, and prior to confirmation of the status phase
> + */
> +#define USB_CMD_FADDR_MASK     GENMASK(7, 1)
> +#define USB_CMD_FADDR(p)       (((p) << 1) & USB_CMD_FADDR_MASK)
> +/* Send Function Wake Device Notification TP (used only in SS mode). */
> +#define USB_CMD_SDNFW          BIT(8)
> +/* Set Test Mode (used only in HS/FS mode). */
> +#define USB_CMD_STMODE         BIT(9)
> +/* Test mode selector (used only in HS/FS mode) */
> +#define USB_STS_TMODE_SEL_MASK GENMASK(11, 10)
> +#define USB_STS_TMODE_SEL(p)   (((p) << 10) & USB_STS_TMODE_SEL_MASK)
> +/*
> + *  Send Latency Tolerance Message Device Notification TP (used only
> + *  in SS mode).
> + */
> +#define USB_CMD_SDNLTM         BIT(12)
> +/* Send Custom Transaction Packet (used only in SS mode) */
> +#define USB_CMD_SPKT           BIT(13)
> +/*Device Notification 'Function Wake' - Interface value (only in SS mode. */
> +#define USB_CMD_DNFW_INT_MASK  GENMASK(23, 16)
> +#define USB_STS_DNFW_INT(p)    (((p) << 16) & USB_CMD_DNFW_INT_MASK)
> +/*
> + * Device Notification 'Latency Tolerance Message' -373 BELT value [7:0]
> + * (used only in SS mode).
> + */
> +#define USB_CMD_DNLTM_BELT_MASK        GENMASK(27, 16)
> +#define USB_STS_DNLTM_BELT(p)  (((p) << 16) & USB_CMD_DNLTM_BELT_MASK)
> +
> +/* USB_ITPN - bitmasks */
> +/*
> + * ITP(SS) / SOF (HS/FS) number
> + * In SS mode this field represent number of last ITP received from host.
> + * In HS/FS mode this field represent number of last SOF received from host.
> + */
> +#define USB_ITPN_MASK          GENMASK(13, 0)
> +#define USB_ITPN(p)            ((p) & USB_ITPN_MASK)
> +
> +/* USB_LPM - bitmasks */
> +/* Host Initiated Resume Duration. */
> +#define USB_LPM_HIRD_MASK      GENMASK(3, 0)
> +#define USB_LPM_HIRD(p)                ((p) & USB_LPM_HIRD_MASK)
> +/* Remote Wakeup Enable (bRemoteWake). */
> +#define USB_LPM_BRW            BIT(4)
> +
> +/* USB_IEN - bitmasks */
> +/* SS connection interrupt enable */
> +#define USB_IEN_CONIEN         BIT(0)
> +/* SS disconnection interrupt enable. */
> +#define USB_IEN_DISIEN         BIT(1)
> +/* USB SS warm reset interrupt enable. */
> +#define USB_IEN_UWRESIEN       BIT(2)
> +/* USB SS hot reset interrupt enable */
> +#define USB_IEN_UHRESIEN       BIT(3)
> +/* SS link U3 state enter interrupt enable (suspend).*/
> +#define USB_IEN_U3ENTIEN       BIT(4)
> +/* SS link U3 state exit interrupt enable (wakeup). */
> +#define USB_IEN_U3EXTIEN       BIT(5)
> +/* SS link U2 state enter interrupt enable.*/
> +#define USB_IEN_U2ENTIEN       BIT(6)
> +/* SS link U2 state exit interrupt enable.*/
> +#define USB_IEN_U2EXTIEN       BIT(7)
> +/* SS link U1 state enter interrupt enable.*/
> +#define USB_IEN_U1ENTIEN       BIT(8)
> +/* SS link U1 state exit interrupt enable.*/
> +#define USB_IEN_U1EXTIEN       BIT(9)
> +/* ITP/SOF packet detected interrupt enable.*/
> +#define USB_IEN_ITPIEN         BIT(10)
> +/* Wakeup interrupt enable.*/
> +#define USB_IEN_WAKEIEN                BIT(11)
> +/* Send Custom Packet interrupt enable.*/
> +#define USB_IEN_SPKTIEN                BIT(12)
> +/* HS/FS mode connection interrupt enable.*/
> +#define USB_IEN_CON2IEN                BIT(16)
> +/* HS/FS mode disconnection interrupt enable.*/
> +#define USB_IEN_DIS2IEN                BIT(17)
> +/* USB reset (HS/FS mode) interrupt enable.*/
> +#define USB_IEN_U2RESIEN       BIT(18)
> +/* LPM L2 state enter interrupt enable.*/
> +#define USB_IEN_L2ENTIEN       BIT(20)
> +/* LPM  L2 state exit interrupt enable.*/
> +#define USB_IEN_L2EXTIEN       BIT(21)
> +/* LPM L1 state enter interrupt enable.*/
> +#define USB_IEN_L1ENTIEN       BIT(24)
> +/* LPM  L1 state exit interrupt enable.*/
> +#define USB_IEN_L1EXTIEN       BIT(25)
> +/* Configuration reset interrupt enable.*/
> +#define USB_IEN_CFGRESIEN      BIT(26)
> +/* Start of the USB SS warm reset interrupt enable.*/
> +#define USB_IEN_UWRESSIEN      BIT(28)
> +/* End of the USB SS warm reset interrupt enable.*/
> +#define USB_IEN_UWRESEIEN      BIT(29)
> +
> +#define USB_IEN_INIT  (USB_IEN_U2RESIEN | USB_ISTS_DIS2I | USB_IEN_CON2IEN \
> +                      | USB_IEN_UHRESIEN | USB_IEN_UWRESIEN | USB_IEN_DISIEN \
> +                      | USB_IEN_CONIEN | USB_IEN_U3EXTIEN | USB_IEN_L2ENTIEN \
> +                      | USB_IEN_L2EXTIEN)
> +
> +/* USB_ISTS - bitmasks */
> +/* SS Connection detected. */
> +#define USB_ISTS_CONI          BIT(0)
> +/* SS Disconnection detected. */
> +#define USB_ISTS_DISI          BIT(1)
> +/* UUSB warm reset detectede. */
> +#define USB_ISTS_UWRESI                BIT(2)
> +/* USB hot reset detected. */
> +#define USB_ISTS_UHRESI                BIT(3)
> +/* U3 link state enter detected (suspend).*/
> +#define USB_ISTS_U3ENTI                BIT(4)
> +/* U3 link state exit detected (wakeup). */
> +#define USB_ISTS_U3EXTI                BIT(5)
> +/* U2 link state enter detected.*/
> +#define USB_ISTS_U2ENTI                BIT(6)
> +/* U2 link state exit detected.*/
> +#define USB_ISTS_U2EXTI                BIT(7)
> +/* U1 link state enter detected.*/
> +#define USB_ISTS_U1ENTI                BIT(8)
> +/* U1 link state exit detected.*/
> +#define USB_ISTS_U1EXTI                BIT(9)
> +/* ITP/SOF packet detected.*/
> +#define USB_ISTS_ITPI          BIT(10)
> +/* Wakeup detected.*/
> +#define USB_ISTS_WAKEI         BIT(11)
> +/* Send Custom Packet detected.*/
> +#define USB_ISTS_SPKTI         BIT(12)
> +/* HS/FS mode connection detected.*/
> +#define USB_ISTS_CON2I         BIT(16)
> +/* HS/FS mode disconnection detected.*/
> +#define USB_ISTS_DIS2I         BIT(17)
> +/* USB reset (HS/FS mode) detected.*/
> +#define USB_ISTS_U2RESI                BIT(18)
> +/* LPM L2 state enter detected.*/
> +#define USB_ISTS_L2ENTI                BIT(20)
> +/* LPM  L2 state exit detected.*/
> +#define USB_ISTS_L2EXTI                BIT(21)
> +/* LPM L1 state enter detected.*/
> +#define USB_ISTS_L1ENTI                BIT(24)
> +/* LPM L1 state exit detected.*/
> +#define USB_ISTS_L1EXTI                BIT(25)
> +/* USB configuration reset detected.*/
> +#define USB_ISTS_CFGRESI       BIT(26)
> +/* Start of the USB warm reset detected.*/
> +#define USB_ISTS_UWRESSI       BIT(28)
> +/* End of the USB warm reset detected.*/
> +#define USB_ISTS_UWRESEI       BIT(29)
> +
> +/* USB_SEL - bitmasks */
> +#define EP_SEL_EPNO_MASK       GENMASK(3, 0)
> +/* Endpoint number. */
> +#define EP_SEL_EPNO(p)         ((p) & EP_SEL_EPNO_MASK)
> +/* Endpoint direction bit - 0 - OUT, 1 - IN. */
> +#define EP_SEL_DIR             BIT(7)
> +
> +#define select_ep_in(nr)       (EP_SEL_EPNO(p) | EP_SEL_DIR)
> +#define select_ep_out          (EP_SEL_EPNO(p))
> +
> +/* EP_TRADDR - bitmasks */
> +/* Transfer Ring address. */
> +#define EP_TRADDR_TRADDR(p)    ((p))
> +
> +/* EP_CFG - bitmasks */
> +/* Endpoint enable */
> +#define EP_CFG_ENABLE          BIT(0)
> +/*
> + *  Endpoint type.
> + * 1 - isochronous
> + * 2 - bulk
> + * 3 - interrupt
> + */
> +#define EP_CFG_EPTYPE_MASK     GENMASK(2, 1)
> +#define EP_CFG_EPTYPE(p)       (((p) << 1)  & EP_CFG_EPTYPE_MASK)
> +/* Stream support enable (only in SS mode). */
> +#define EP_CFG_STREAM_EN       BIT(3)
> +/* TDL check (only in SS mode for BULK EP). */
> +#define EP_CFG_TDL_CHK         BIT(4)
> +/* SID check (only in SS mode for BULK OUT EP). */
> +#define EP_CFG_SID_CHK         BIT(5)
> +/* DMA transfer endianness. */
> +#define EP_CFG_EPENDIAN                BIT(7)
> +/* Max burst size (used only in SS mode). */
> +#define EP_CFG_MAXBURST_MASK   GENMASK(11, 8)
> +#define EP_CFG_MAXBURST(p)     (((p) << 8) & EP_CFG_MAXBURST_MASK)
> +/* ISO max burst. */
> +#define EP_CFG_MULT_MASK       GENMASK(15, 14)
> +#define EP_CFG_MULT(p)         (((p) << 14) & EP_CFG_MULT)
> +/* ISO max burst. */
> +#define EP_CFG_MAXPKTSIZE_MASK GENMASK(26, 16)
> +#define EP_CFG_MAXPKTSIZE(p)   (((p) << 16) & EP_CFG_MAXPKTSIZE_MASK)
> +/* Max number of buffered packets. */
> +#define EP_CFG_BUFFERING_MASK  GENMASK(31, 27)
> +#define EP_CFG_BUFFERING(p)    (((p) << 27) & EP_CFG_BUFFERING_MASK)
> +
> +/* EP_CMD - bitmasks */
> +/* Endpoint reset. */
> +#define EP_CMD_EPRST           BIT(0)
> +/* Endpoint STALL set. */
> +#define EP_CMD_SSTALL          BIT(1)
> +/* Endpoint STALL clear. */
> +#define EP_CMD_CSTALL          BIT(2)
> +/* Send ERDY TP. */
> +#define EP_CMD_ERDY            BIT(3)
> +/* Request complete. */
> +#define EP_CMD_REQ_CMPL                BIT(5)
> +/* Transfer descriptor ready. */
> +#define EP_CMD_DRDY            BIT(6)
> +/* Data flush. */
> +#define EP_CMD_DFLUSH          BIT(7)
> +/*
> + * Transfer Descriptor Length write  (used only for Bulk Stream capable
> + * endpoints in SS mode).
> + */
> +#define EP_CMD_STDL            BIT(8)
> +/* Transfer Descriptor Length (used only in SS mode for bulk endpoints). */
> +#define EP_CMD_TDL_MASK                GENMASK(15, 9)
> +#define EP_CMD_TDL(p)          (((p) << 9) & EP_CMD_TDL_MASK)
> +/* ERDY Stream ID value (used in SS mode). */
> +#define EP_CMD_ERDY_SID_MASK   GENMASK(31, 16)
> +#define EP_CMD_ERDY_SID(p)     (((p) << 16) & EP_CMD_SID_MASK)
> +
> +/* EP_STS - bitmasks */
> +/* Setup transfer complete. */
> +#define EP_STS_SETUP           BIT(0)
> +/* Endpoint STALL status. */
> +#define EP_STS_STALL(p)                ((p) & BIT(1))
> +/* Interrupt On Complete. */
> +#define EP_STS_IOC             BIT(2)
> +/* Interrupt on Short Packet. */
> +#define EP_STS_ISP             BIT(3)
> +/* Transfer descriptor missing. */
> +#define EP_STS_DESCMIS         BIT(4)
> +/* Stream Rejected (used only in SS mode) */
> +#define EP_STS_STREAMR         BIT(5)
> +/* EXIT from MOVE DATA State (used only for stream transfers in SS mode). */
> +#define EP_STS_MD_EXIT         BIT(6)
> +/* TRB error. */
> +#define EP_STS_TRBERR          BIT(7)
> +/* Not ready (used only in SS mode). */
> +#define EP_STS_NRDY            BIT(8)
> +/* DMA busy. */
> +#define EP_STS_DBUSY(p)                ((p) & BIT(9))
> +/* Endpoint Buffer Empty */
> +#define EP_STS_BUFFEMPTY(p)    ((p) & BIT(10))
> +/* Current Cycle Status */
> +#define EP_STS_CCS(p)          ((p) & BIT(11))
> +/* Prime (used only in SS mode. */
> +#define EP_STS_PRIME           BIT(12)
> +/* Stream error (used only in SS mode). */
> +#define EP_STS_SIDERR          BIT(13)
> +/* OUT size mismatch. */
> +#define EP_STS_OUTSMM          BIT(14)
> +/* ISO transmission error. */
> +#define EP_STS_ISOERR          BIT(15)
> +/* Host Packet Pending (only for SS mode). */
> +#define EP_STS_HOSTPP(p)       ((p) & BIT(16))
> +/* Stream Protocol State Machine State (only for Bulk stream endpoints). */
> +#define EP_STS_SPSMST_MASK             GENMASK(18, 17)
> +#define EP_STS_SPSMST_DISABLED(p)      (((p) & EP_STS_SPSMST_MASK) >> 17)
> +#define EP_STS_SPSMST_IDLE(p)          (((p) & EP_STS_SPSMST_MASK) >> 17)
> +#define EP_STS_SPSMST_START_STREAM(p)  (((p) & EP_STS_SPSMST_MASK) >> 17)
> +#define EP_STS_SPSMST_MOVE_DATA(p)     (((p) & EP_STS_SPSMST_MASK) >> 17)
> +/* Interrupt On Transfer complete. */
> +#define EP_STS_IOT             BIT(19)
> +/* OUT queue endpoint number. */
> +#define EP_STS_OUTQ_NO_MASK    GENMASK(27, 24)
> +#define EP_STS_OUTQ_NO(p)      (((p) & EP_STS_OUTQ_NO_MASK) >> 24)
> +/* OUT queue valid flag. */
> +#define EP_STS_OUTQ_VAL_MASK   BIT(28)
> +#define EP_STS_OUTQ_VAL(p)     ((p) & EP_STS_OUTQ_VAL_MASK)
> +/* SETUP WAIT. */
> +#define EP_STS_STPWAIT         BIT(31)
> +
> +/* EP_STS_SID - bitmasks */
> +/* Stream ID (used only in SS mode). */
> +#define EP_STS_SID_MASK                GENMASK(15, 0)
> +#define EP_STS_SID(p)          ((p) & EP_STS_SID_MASK)
> +
> +/* EP_STS_EN - bitmasks */
> +/* SETUP interrupt enable. */
> +#define EP_STS_EN_SETUPEN      BIT(0)
> +/* OUT transfer missing descriptor enable. */
> +#define EP_STS_EN_DESCMISEN    BIT(4)
> +/* Stream Rejected enable. */
> +#define EP_STS_EN_STREAMREN    BIT(5)
> +/* Move Data Exit enable.*/
> +#define EP_STS_EN_MD_EXITEN    BIT(6)
> +/* TRB enable. */
> +#define EP_STS_EN_TRBERREN     BIT(7)
> +/* NRDY enable. */
> +#define EP_STS_EN_NRDYEN       BIT(8)
> +/* Prime enable. */
> +#define EP_STS_EN_PRIMEEEN     BIT(12)
> +/* Stream error enable. */
> +#define EP_STS_EN_SIDERREN     BIT(13)
> +/* OUT size mismatch enable. */
> +#define EP_STS_EN_OUTSMMEN     BIT(14)
> +/* ISO transmission error enable. */
> +#define EP_STS_EN_ISOERREN     BIT(15)
> +/* Interrupt on Transmission complete enable. */
> +#define EP_STS_EN_IOTEN                BIT(19)
> +/* Setup Wait interrupt enable. */
> +#define EP_STS_EN_STPWAITEN    BIT(31)
> +
> +/* DRBL- bitmasks */
> +#define DB_VALUE_BY_INDEX(index) (1 << (index))
> +#define DB_VALUE_EP0_OUT       BIT(0)
> +#define DB_VALUE_EP0_IN                BIT(16)
> +
> +/* EP_IEN - bitmasks */
> +#define EP_IEN(index)          (1 << (index))
> +#define EP_IEN_EP_OUT0         BIT(0)
> +#define EP_IEN_EP_IN0          BIT(16)
> +
> +/* EP_ISTS - bitmasks */
> +#define EP_ISTS(index)         (1 << (index))
> +#define EP_ISTS_EP_OUT0                BIT(0)
> +#define EP_ISTS_EP_IN0         BIT(16)
> +
> +/* EP_PWR- bitmasks */
> +/*Power Shut Off capability enable*/
> +#define PUSB_PWR_PSO_EN                BIT(0)
> +/*Power Shut Off capability disable*/
> +#define PUSB_PWR_PSO_DS                BIT(1)
> +/*
> + * Enables turning-off Reference Clock.
> + * This bit is optional and implemented only when support for OTG is
> + * implemented (indicated by OTG_READY bit set to '1').
> + */
> +#define PUSB_PWR_STB_CLK_SWITCH_EN     BIT(8)
> +/*
> + * Status bit indicating that operation required by STB_CLK_SWITCH_EN write
> + * is completed
> + */
> +#define PUSB_PWR_STB_CLK_SWITCH_DONE   BIT(9)
> +/* This bit informs if Fast Registers Access is enabled. */
> +#define PUSB_PWR_FST_REG_ACCESS_STAT   BIT(30)
> +/* Fast Registers Access Enable. */
> +#define PUSB_PWR_FST_REG_ACCESS        BIT(31)
> +
> +/* USB_CAP1- bitmasks */
> +/*
> + * SFR Interface type
> + * These field reflects type of SFR interface implemented:
> + * 0x0 - OCP
> + * 0x1 - AHB,
> + * 0x2 - PLB
> + * 0x3 - AXI
> + * 0x4-0xF - reserved
> + */
> +#define USB_CAP1_SFR_TYPE_MASK GENMASK(3, 0)
> +#define DEV_SFR_TYPE_OCP(p)    (((p) & USB_CAP1_SFR_TYPE_MASK) == 0x0)
> +#define DEV_SFR_TYPE_AHB(p)    (((p) & USB_CAP1_SFR_TYPE_MASK) == 0x1)
> +#define DEV_SFR_TYPE_PLB(p)    (((p) & USB_CAP1_SFR_TYPE_MASK) == 0x2)
> +#define DEV_SFR_TYPE_AXI(p)    (((p) & USB_CAP1_SFR_TYPE_MASK) == 0x3)
> +/*
> + * SFR Interface width
> + * These field reflects width of SFR interface implemented:
> + * 0x0 - 8 bit interface,
> + * 0x1 - 16 bit interface,
> + * 0x2 - 32 bit interface
> + * 0x3 - 64 bit interface
> + * 0x4-0xF - reserved
> + */
> +#define USB_CAP1_SFR_WIDTH_MASK        GENMASK(7, 4)
> +#define DEV_SFR_WIDTH_8(p)     (((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x0 << 4))
> +#define DEV_SFR_WIDTH_16(p)    (((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x1 << 4))
> +#define DEV_SFR_WIDTH_32(p)    (((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x2 << 4))
> +#define DEV_SFR_WIDTH_64(p)    (((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x3 << 4))
> +/*
> + * DMA Interface type
> + * These field reflects type of DMA interface implemented:
> + * 0x0 - OCP
> + * 0x1 - AHB,
> + * 0x2 - PLB
> + * 0x3 - AXI
> + * 0x4-0xF - reserved
> + */
> +#define USB_CAP1_DMA_TYPE_MASK GENMASK(11, 8)
> +#define DEV_DMA_TYPE_OCP(p)    (((p) & USB_CAP1_DMA_TYPE_MASK) == (0x0 << 8))
> +#define DEV_DMA_TYPE_AHB(p)    (((p) & USB_CAP1_DMA_TYPE_MASK) == (0x1 << 8))
> +#define DEV_DMA_TYPE_PLB(p)    (((p) & USB_CAP1_DMA_TYPE_MASK) == (0x2 << 8))
> +#define DEV_DMA_TYPE_AXI(p)    (((p) & USB_CAP1_DMA_TYPE_MASK) == (0x3 << 8))
> +/*
> + * DMA Interface width
> + * These field reflects width of DMA interface implemented:
> + * 0x0 - reserved,
> + * 0x1 - reserved,
> + * 0x2 - 32 bit interface
> + * 0x3 - 64 bit interface
> + * 0x4-0xF - reserved
> + */
> +#define USB_CAP1_DMA_WIDTH_MASK        GENMASK(15, 12)
> +#define DEV_DMA_WIDTH_32(p)    (((p) & USB_CAP1_DMA_WIDTH_MASK) == (0x2 << 12))
> +#define DEV_DMA_WIDTH_64(p)    (((p) & USB_CAP1_DMA_WIDTH_MASK) == (0x3 << 12))
> +/*
> + * USB3 PHY Interface type
> + * These field reflects type of USB3 PHY interface implemented:
> + * 0x0 - USB PIPE,
> + * 0x1 - RMMI,
> + * 0x2-0xF - reserved
> + */
> +#define USB_CAP1_U3PHY_TYPE_MASK GENMASK(19, 16)
> +#define DEV_U3PHY_PIPE(p) (((p) & USB_CAP1_U3PHY_TYPE_MASK) == (0x0 << 16))
> +#define DEV_U3PHY_RMMI(p) (((p) & USB_CAP1_U3PHY_TYPE_MASK) == (0x1 << 16))
> +/*
> + * USB3 PHY Interface width
> + * These field reflects width of USB3 PHY interface implemented:
> + * 0x0 - 8 bit PIPE interface,
> + * 0x1 - 16 bit PIPE interface,
> + * 0x2 - 32 bit PIPE interface,
> + * 0x3 - 64 bit PIPE interface
> + * 0x4-0xF - reserved
> + * Note: When SSIC interface is implemented this field shows the width of
> + * internal PIPE interface. The RMMI interface is always 20bit wide.
> + */
> +#define USB_CAP1_U3PHY_WIDTH_MASK GENMASK(23, 20)
> +#define DEV_U3PHY_WIDTH_8(p) \
> +       (((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x0 << 20))
> +#define DEV_U3PHY_WIDTH_16(p) \
> +       (((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x1 << 16))
> +#define DEV_U3PHY_WIDTH_32(p) \
> +       (((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x2 << 20))
> +#define DEV_U3PHY_WIDTH_64(p) \
> +       (((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x3 << 16))
> +
> +/*
> + * USB2 PHY Interface enable
> + * These field informs if USB2 PHY interface is implemented:
> + * 0x0 - interface NOT implemented,
> + * 0x1 - interface implemented
> + */
> +#define USB_CAP1_U2PHY_EN(p)   ((p) & BIT(24))
> +/*
> + * USB2 PHY Interface type
> + * These field reflects type of USB2 PHY interface implemented:
> + * 0x0 - UTMI,
> + * 0x1 - ULPI
> + */
> +#define DEV_U2PHY_ULPI(p)      ((p) & BIT(25))
> +/*
> + * USB2 PHY Interface width
> + * These field reflects width of USB2 PHY interface implemented:
> + * 0x0 - 8 bit interface,
> + * 0x1 - 16 bit interface,
> + * Note: The ULPI interface is always 8bit wide.
> + */
> +#define DEV_U2PHY_WIDTH_16(p)  ((p) & BIT(26))
> +/*
> + * OTG Ready
> + * 0x0 - pure device mode
> + * 0x1 - some features and ports for CDNS USB OTG controller are implemented.
> + */
> +#define USB_CAP1_OTG_READY(p)  ((p) & BIT(27))
> +
> +/* USB_CAP2- bitmasks */
> +/*
> + * The actual size of the connected On-chip RAM memory in kB:
> + * - 0 means 256 kB (max supported mem size)
> + * - value other than 0 reflects the mem size in kB
> + */
> +#define USB_CAP2_ACTUAL_MEM_SIZE(p) ((p) & GENMASK(7, 0))
> +/*
> + * Max supported mem size
> + * These field reflects width of on-chip RAM address bus width,
> + * which determines max supported mem size:
> + * 0x0-0x7 - reserved,
> + * 0x8 - support for 4kB mem,
> + * 0x9 - support for 8kB mem,
> + * 0xA - support for 16kB mem,
> + * 0xB - support for 32kB mem,
> + * 0xC - support for 64kB mem,
> + * 0xD - support for 128kB mem,
> + * 0xE - support for 256kB mem,
> + * 0xF - reserved
> + */
> +#define USB_CAP2_MAX_MEM_SIZE(p) ((p) & GENMASK(11, 8))
> +
> +/* USB_CAP3- bitmasks */
> +#define EP_IS_IMPLEMENTED(reg, index) ((reg) & (1 << (index)))
> +
> +/* USB_CAP4- bitmasks */
> +#define EP_SUPPORT_ISO(reg, index) ((reg) & (1 << (index)))
> +
> +/* USB_CAP5- bitmasks */
> +#define EP_SUPPORT_STREAM(reg, index) ((reg) & (1 << (index)))
> +
> +/* USB_CAP6- bitmasks */
> +/* The USBSS-DEV Controller  Internal build number. */
> +#define GET_DEV_VERSION__INTERNAL_NUMBER(p) ((p) & GENMASK(7, 0))
> +/* The USBSS-DEV Controller  version number. */
> +#define GET_DEV_VERSION(p) ((p) & GENMASK(31, 8))
> +
> +/* DBG_LINK1- bitmasks */
> +/*
> + * LFPS_MIN_DET_U1_EXIT value This parameter configures the minimum
> + * time required for decoding the received LFPS as an LFPS.U1_Exit.
> + */
> +#define DBG_LINK1_LFPS_MIN_DET_U1_EXIT(p)      ((p) & GENMASK(7, 0))
> +/*
> + * LFPS_MIN_GEN_U1_EXIT value This parameter configures the minimum time for
> + * phytxelecidle deassertion when LFPS.U1_Exit
> + */
> +#define DBG_LINK1_LFPS_MIN_GEN_U1_EXIT(p)      (((p) << 8) & GENMASK(15, 8))
> +/*
> + * RXDET_BREAK_DIS value This parameter configures terminating the Far-end
> + * Receiver termination detection sequence:
> + * 0: it is possible that USBSS_DEV will terminate Farend receiver
> + *    termination detection sequence
> + * 1: USBSS_DEV will not terminate Far-end receiver termination
> + *    detection sequence
> + */
> +#define DBG_LINK1_RXDET_BREAK_DIS              BIT(16)
> +/* LFPS_GEN_PING value This parameter configures the LFPS.Ping generation */
> +#define DBG_LINK1_LFPS_GEN_PING(p)             (((p) << 17) & GENMASK(21, 17))
> +/*
> + * Set the LFPS_MIN_DET_U1_EXIT value Writing '1' to this bit writes the
> + * LFPS_MIN_DET_U1_EXIT field value to the device. This bit is automatically
> + * cleared. Writing '0' has no effect
> + */
> +#define DBG_LINK1_LFPS_MIN_DET_U1_EXIT_SET     BIT(24)
> +/*
> + * Set the LFPS_MIN_GEN_U1_EXIT value. Writing '1' to this bit writes the
> + * LFPS_MIN_GEN_U1_EXIT field value to the device. This bit is automatically
> + * cleared. Writing '0' has no effect
> + */
> +#define DBG_LINK1_LFPS_MIN_GEN_U1_EXIT_SET     BIT(25)
> +/*
> + * Set the RXDET_BREAK_DIS value Writing '1' to this bit writes
> + * the RXDET_BREAK_DIS field value to the device. This bit is automatically
> + * cleared. Writing '0' has no effect
> + */
> +#define DBG_LINK1_RXDET_BREAK_DIS_SET          BIT(26)
> +/*
> + * Set the LFPS_GEN_PING_SET value Writing '1' to this bit writes
> + * the LFPS_GEN_PING field value to the device. This bit is automatically
> + * cleared. Writing '0' has no effect."
> + */
> +#define DBG_LINK1_LFPS_GEN_PING_SET            BIT(27)
> +
> +#define gadget_to_cdns3_device(g) (container_of(g, struct cdns3_device, gadget))
> +
> +#define ep_to_cdns3_ep(ep) (container_of(ep, struct cdns3_endpoint, endpoint))
> +
> +/*-------------------------------------------------------------------------*/
> +/*
> + * USBSS-DEV DMA interface.
> + */
> +#define TRBS_PER_SEGMENT       40
> +
> +#define ISO_MAX_INTERVAL       10
> +
> +/*
> + *Only for ISOC endpoints - maximum number of TRBs is calculated as
> + * pow(2, bInterval-1) * number of usb requests. It is limitation made by
> + * driver to save memory. Controller must prepare TRB for each ITP even
> + * if bInterval > 1. It's the reason why driver needs so many TRBs for
> + * isochronous endpoints.
> + */
> +#define TRBS_PER_ISOC_SEGMENT  (ISO_MAX_INTERVAL * 8)
> +
> +#define GET_TRBS_PER_SEGMENT(ep_type) ((ep_type) == USB_ENDPOINT_XFER_ISOC ? \
> +                                     TRBS_PER_ISOC_SEGMENT : TRBS_PER_SEGMENT)
> +/**
> + * struct cdns3_trb - represent Transfer Descriptor block.
> + * @buffer:    pointer to buffer data
> + * @length:    length of data
> + * @control:   control flags.
> + *
> + * This structure describes transfer block serviced by DMA module.
> + */
> +struct cdns3_trb {
> +       __le32 buffer;
> +       __le32 length;
> +       __le32 control;
> +};
> +
> +#define TRB_SIZE               (sizeof(struct cdns3_trb))
> +#define TRB_RING_SIZE          (TRB_SIZE * TRBS_PER_SEGMENT)
> +#define TRB_ISO_RING_SIZE      (TRB_SIZE * TRBS_PER_ISOC_SEGMENT)
> +#define TRB_CTRL_RING_SIZE     (TRB_SIZE * 2)
> +
> +/* TRB bit mask */
> +#define TRB_TYPE_BITMASK       GENMASK(15, 10)
> +#define TRB_TYPE(p)            ((p) << 10)
> +#define TRB_FIELD_TO_TYPE(p)   (((p) & TRB_TYPE_BITMASK) >> 10)
> +
> +/* TRB type IDs */
> +/* bulk, interrupt, isoc , and control data stage */
> +#define TRB_NORMAL             1
> +/* TRB for linking ring segments */
> +#define TRB_LINK               6
> +
> +/* Cycle bit - indicates TRB ownership by driver or hw*/
> +#define TRB_CYCLE              BIT(0)
> +/*
> + * When set to '1', the device will toggle its interpretation of the Cycle bit
> + */
> +#define TRB_TOGGLE             BIT(1)
> +
> +/* Interrupt on short packet*/
> +#define TRB_ISP                        BIT(2)
> +/*Setting this bit enables FIFO DMA operation mode*/
> +#define TRB_FIFO_MODE          BIT(3)
> +/* Set PCIe no snoop attribute */
> +#define TRB_CHAIN              BIT(4)
> +/* Interrupt on completion */
> +#define TRB_IOC                        BIT(5)
> +
> +/* stream ID bitmasks. */
> +#define TRB_STREAM_ID(p)       ((p) & GENMASK(31, 16))
> +
> +/* transfer_len bitmasks. */
> +#define TRB_LEN(p)             ((p) & GENMASK(16, 0))
> +
> +/* transfer_len bitmasks - bits 31:24 */
> +#define TRB_BURST_LEN(p)       ((p) & GENMASK(31, 24))
> +
> +/* Data buffer pointer bitmasks*/
> +#define TRB_BUFFER(p)          ((p) & GENMASK(31, 0))
> +
> +/*-------------------------------------------------------------------------*/
> +/* Driver numeric constants */
> +
> +/* Such declaration should be added to ch9.h */
> +#define USB_DEVICE_MAX_ADDRESS         127
> +
> +/* Endpoint init values */
> +#define CDNS3_EP_MAX_PACKET_LIMIT      1024
> +#define CDNS3_EP_MAX_STREAMS           15
> +#define CDNS3_EP0_MAX_PACKET_LIMIT     512
> +
> +/* All endpoints including EP0 */
> +#define CDNS3_ENDPOINTS_MAX_COUNT      32
> +#define CDNS3_EP_ZLP_BUF_SIZE          1024
> +
> +#define CDNS3_EP_BUF_SIZE              2       /* KB */
> +#define CDNS3_ALIGNED_BUF_SIZE         16384   /* Bytes */
> +#define CDNS3_MAX_NUM_DESCMISS_BUF     32
> +#define CDNS3_DESCMIS_BUF_SIZE         2048    /* Bytes */
> +/*-------------------------------------------------------------------------*/
> +/* Used structs */
> +
> +struct cdns3_device;
> +
> +/**
> + * struct cdns3_endpoint - extended device side representation of USB endpoint.
> + * @endpoint: usb endpoint
> + * @pending_req_list: list of requests queuing on transfer ring.
> + * @deferred_req_list: list of requests waiting for queuing on transfer ring.
> + * @descmiss_req_list: list of requests internally allocated by driver (WA1).
> + * @trb_pool: transfer ring - array of transaction buffers
> + * @trb_pool_dma: dma address of transfer ring
> + * @cdns3_dev: device associated with this endpoint
> + * @name: a human readable name e.g. ep1out
> + * @flags: specify the current state of endpoint
> + * @descmis_req: internal transfer object used for getting data from on-chip
> + *     buffer. It can happen only if function driver doesn't send usb_request
> + *     object on time.
> + * @aligned_buff: aligned to 8 bytes data buffer. Buffer address used in
> + *     TRB shall be aligned to 8.
> + * @aligned_dma_addr: dma address of aligned_buff
> + * @dir: endpoint direction
> + * @num: endpoint number (1 - 15)
> + * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK
> + * @interval: interval between packets used for ISOC endpoint.
> + * @free_trbs: number of free TRBs in transfer ring
> + * @num_trbs: number of all TRBs in transfer ring
> + * @pcs: producer cycle state
> + * @ccs: consumer cycle state
> + * @enqueue: enqueue index in transfer ring
> + * @dequeue: dequeue index in transfer ring
> + */
> +struct cdns3_endpoint {
> +       struct usb_ep           endpoint;
> +       struct list_head        pending_req_list;
> +       struct list_head        deferred_req_list;
> +       struct list_head        descmiss_req_list;
> +
> +       struct cdns3_trb        *trb_pool;
> +       dma_addr_t              trb_pool_dma;
> +
> +       struct cdns3_device     *cdns3_dev;
> +       char                    name[20];
> +
> +#define EP_ENABLED             BIT(0)
> +#define EP_STALL               BIT(1)
> +#define EP_WEDGE               BIT(2)
> +#define EP_TRANSFER_STARTED    BIT(3)
> +#define EP_UPDATE_EP_TRBADDR   BIT(4)
> +#define EP_PENDING_REQUEST     BIT(5)
> +#define EP_RING_FULL           BIT(6)
> +#define EP_CLAIMED             BIT(7)
> +#define EP_QUIRK_EXTRA_BUF_DET BIT(8)
> +#define EP_QUIRK_EXTRA_BUF_EN  BIT(9)
> +#define EP_QUIRK_END_TRANSFER  BIT(10)
> +
> +       u32                     flags;
> +
> +       struct cdns3_request    *descmis_req;
> +
> +       void                    *aligned_buff;
> +       dma_addr_t              aligned_dma_addr;
> +       u8                      dir;
> +       u8                      num;
> +       u8                      type;
> +       int                     interval;
> +
> +       int                     free_trbs;
> +       int                     num_trbs;
> +       u8                      pcs;
> +       u8                      ccs;
> +       int                     enqueue;
> +       int                     dequeue;
> +};
> +
> +/**
> + * struct cdns3_request - extended device side representation of usb_request
> + *                        object .
> + * @request: generic usb_request object describing single I/O request.
> + * @priv_ep: extended representation of usb_ep object
> + * @trb: the first TRB association with this request
> + * @start_trb: number of the first TRB in transfer ring
> + * @end_trb: number of the last TRB in transfer ring
> + * @flags: flag specifying special usage of request
> + * @list: used by internally allocated request to add to descmiss_req_list.
> + */
> +struct cdns3_request {
> +       struct usb_request      request;
> +       struct cdns3_endpoint   *priv_ep;
> +       struct cdns3_trb        *trb;
> +       int                     start_trb;
> +       int                     end_trb;
> +#define REQUEST_PENDING                BIT(0)
> +#define REQUEST_INTERNAL       BIT(1)
> +#define REQUEST_INTERNAL_CH    BIT(2)
> +#define REQUEST_ZLP            BIT(3)
> +       u32                     flags;
> +       struct list_head        list;
> +};
> +
> +#define to_cdns3_request(r) (container_of(r, struct cdns3_request, request))
> +
> +/*Stages used during enumeration process.*/
> +#define CDNS3_SETUP_STAGE              0x0
> +#define CDNS3_DATA_STAGE               0x1
> +#define CDNS3_STATUS_STAGE             0x2
> +
> +/**
> + * struct cdns3_device - represent USB device.
> + * @dev: pointer to device structure associated whit this controller
> + * @sysdev: pointer to the DMA capable device
> + * @gadget: device side representation of the peripheral controller
> + * @gadget_driver: pointer to the gadget driver
> + * @dev_ver: device controller version.
> + * @lock: for synchronizing
> + * @regs: base address for device side registers
> + * @setup_buf: used while processing usb control requests
> + * @setup_dma: dma address for setup_buf
> + * @zlp_buf - zlp buffer
> + * @ep0_stage: ep0 stage during enumeration process.
> + * @ep0_data_dir: direction for control transfer
> + * @eps: array of pointers to all endpoints with exclusion ep0
> + * @selected_ep: actually selected endpoint. It's used only to improve
> + *               performance.
> + * @isoch_delay: value from Set Isoch Delay request. Only valid on SS/SSP.
> + * @u1_allowed: allow device transition to u1 state
> + * @u2_allowed: allow device transition to u2 state
> + * @is_selfpowered: device is self powered
> + * @setup_pending: setup packet is processing by gadget driver
> + * @hw_configured_flag: hardware endpoint configuration was set.
> + * @wake_up_flag: allow device to remote up the host
> + * @status_completion_no_call: indicate that driver is waiting for status s
> + *     stage completion. It's used in deferred SET_CONFIGURATION request.
> + * @onchip_mem_allocated_size: actual size of on-chip memory assigned
> + *     to endpoints
> + * @pending_status_wq: workqueue handling status stage for deferred requests.
> + * @pending_status_request: request for which status stage was deferred
> + */
> +struct cdns3_device {
> +       struct device                   *dev;
> +       struct device                   *sysdev;
> +
> +       struct usb_gadget               gadget;
> +       struct usb_gadget_driver        *gadget_driver;
> +
> +#define CDNS_REVISION_V0               0x00024501
> +#define CDNS_REVISION_V1               0x00024509
> +       u32                             dev_ver;
> +
> +       /* generic spin-lock for drivers */
> +       spinlock_t                      lock;
> +
> +       struct cdns3_usb_regs           __iomem *regs;
> +
> +       struct usb_ctrlrequest          *setup_buf;
> +       dma_addr_t                      setup_dma;
> +       void                            *zlp_buf;
> +
> +       u8                              ep0_stage;
> +       int                             ep0_data_dir;
> +
> +       struct cdns3_endpoint           *eps[CDNS3_ENDPOINTS_MAX_COUNT];
> +
> +       u32                             selected_ep;
> +       u16                             isoch_delay;
> +
> +       unsigned                        u1_allowed:1;
> +       unsigned                        u2_allowed:1;
> +       unsigned                        is_selfpowered:1;
> +       unsigned                        setup_pending:1;
> +       int                             hw_configured_flag:1;
> +       int                             wake_up_flag:1;
> +       unsigned                        status_completion_no_call:1;
> +
> +       struct work_struct              pending_status_wq;
> +       struct usb_request              *pending_status_request;
> +
> +       /*in KB */
> +       int                             onchip_mem_allocated_size;
> +};
> +
> +int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
> +void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
> +dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
> +                                struct cdns3_trb *trb);
> +enum usb_device_speed cdns3_get_speed(struct cdns3_device *priv_dev);
> +void cdns3_pending_setup_status_handler(struct work_struct *work);
> +void cdns3_hw_reset_eps_config(struct cdns3_device *priv_dev);
> +void cdns3_set_hw_configuration(struct cdns3_device *priv_dev);
> +void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
> +void cdns3_allow_enable_l1(struct cdns3_device *priv_dev, int enable);
> +struct usb_request *cdns3_next_request(struct list_head *list);
> +int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
> +                         struct usb_request *request);
> +int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep);
> +u8 cdns3_ep_addr_to_index(u8 ep_addr);
> +int cdns3_gadget_ep_set_wedge(struct usb_ep *ep);
> +int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value);
> +struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
> +                                                 gfp_t gfp_flags);
> +void cdns3_gadget_ep_free_request(struct usb_ep *ep,
> +                                 struct usb_request *request);
> +int cdns3_gadget_ep_dequeue(struct usb_ep *ep, struct usb_request *request);
> +void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
> +                          struct cdns3_request *priv_req,
> +                          int status);
> +
> +int cdns3_init_ep0(struct cdns3_device *priv_dev,
> +                  struct cdns3_endpoint *priv_ep);
> +void cdns3_ep0_config(struct cdns3_device *priv_dev);
> +void cdns3_ep_config(struct cdns3_endpoint *priv_ep);
> +void cdns3_check_ep0_interrupt_proceed(struct cdns3_device *priv_dev, int dir);
> +
> +#endif /* __LINUX_CDNS3_GADGET */
> diff --git a/drivers/usb/cdns3/host-export.h b/drivers/usb/cdns3/host-export.h
> new file mode 100644
> index 000000000000..b498a170b7e8
> --- /dev/null
> +++ b/drivers/usb/cdns3/host-export.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver - Host Export APIs
> + *
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + */
> +#ifndef __LINUX_CDNS3_HOST_EXPORT
> +#define __LINUX_CDNS3_HOST_EXPORT
> +
> +#ifdef CONFIG_USB_CDNS3_HOST
> +
> +int cdns3_host_init(struct cdns3 *cdns);
> +void cdns3_host_exit(struct cdns3 *cdns);
> +
> +#else
> +
> +static inline int cdns3_host_init(struct cdns3 *cdns)
> +{
> +       return -ENXIO;
> +}
> +
> +static inline void cdns3_host_exit(struct cdns3 *cdns) { }
> +
> +#endif /* CONFIG_USB_CDNS3_HOST */
> +
> +#endif /* __LINUX_CDNS3_HOST_EXPORT */
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> new file mode 100644
> index 000000000000..b43b0236a885
> --- /dev/null
> +++ b/drivers/usb/cdns3/host.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - host side
> + *
> + * Copyright (C) 2018 Cadence Design Systems.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + *         Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include "core.h"
> +
> +static int __cdns3_host_init(struct cdns3 *cdns)
> +{
> +       struct platform_device *xhci;
> +       int ret;
> +
> +       xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> +       if (!xhci) {
> +               dev_err(cdns->dev, "couldn't allocate xHCI device\n");
> +               return -ENOMEM;
> +       }
> +
> +       xhci->dev.parent = cdns->dev;
> +       cdns->host_dev = xhci;
> +
> +       ret = platform_device_add_resources(xhci, cdns->xhci_res,
> +                                           CDNS3_XHCI_RESOURCES_NUM);
> +       if (ret) {
> +               dev_err(cdns->dev, "couldn't add resources to xHCI device\n");
> +               goto err1;
> +       }
> +
> +       ret = platform_device_add(xhci);
> +       if (ret) {
> +               dev_err(cdns->dev, "failed to register xHCI device\n");
> +               goto err1;
> +       }
> +
> +       return 0;
> +err1:
> +       platform_device_put(xhci);
> +       return ret;
> +}
> +
> +static void cdns3_host_exit(struct cdns3 *cdns)
> +{
> +       platform_device_unregister(cdns->host_dev);
> +       cdns->host_dev = NULL;
> +}
> +
> +int cdns3_host_init(struct cdns3 *cdns)
> +{
> +       struct cdns3_role_driver *rdrv;
> +
> +       rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
> +       if (!rdrv)
> +               return -ENOMEM;
> +
> +       rdrv->start     = __cdns3_host_init;
> +       rdrv->stop      = cdns3_host_exit;
> +       rdrv->state     = CDNS3_ROLE_STATE_INACTIVE;
> +       rdrv->suspend   = NULL;
> +       rdrv->resume    = NULL;
> +       rdrv->name      = "host";
> +
> +       cdns->roles[CDNS3_ROLE_HOST] = rdrv;
> +
> +       return 0;
> +}
> diff --git a/drivers/usb/cdns3/trace.c b/drivers/usb/cdns3/trace.c
> new file mode 100644
> index 000000000000..587ae08e019d
> --- /dev/null
> +++ b/drivers/usb/cdns3/trace.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USBSS device controller driver Trace Support
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#define CREATE_TRACE_POINTS
> +#include "trace.h"
> diff --git a/drivers/usb/cdns3/trace.h b/drivers/usb/cdns3/trace.h
> new file mode 100644
> index 000000000000..f3d7a91fae86
> --- /dev/null
> +++ b/drivers/usb/cdns3/trace.h
> @@ -0,0 +1,389 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * USBSS device controller driver.
> + * Trace support header file.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cdns3
> +
> +#if !defined(__LINUX_CDNS3_TRACE) || defined(TRACE_HEADER_MULTI_READ)
> +#define __LINUX_CDNS3_TRACE
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +#include <asm/byteorder.h>
> +#include <linux/usb/ch9.h>
> +#include "core.h"
> +#include "gadget.h"
> +#include "debug.h"
> +
> +#define CDNS3_MSG_MAX  500
> +
> +DECLARE_EVENT_CLASS(cdns3_log_doorbell,
> +       TP_PROTO(const char *ep_name, u32 ep_trbaddr),
> +       TP_ARGS(ep_name, ep_trbaddr),
> +       TP_STRUCT__entry(
> +               __string(name, ep_name)
> +               __field(u32, ep_trbaddr)
> +       ),
> +       TP_fast_assign(
> +               __assign_str(name, ep_name);
> +               __entry->ep_trbaddr = ep_trbaddr;
> +       ),
> +       TP_printk("//Ding Dong %s, ep_trbaddr %08x", __get_str(name),
> +                 __entry->ep_trbaddr)
> +);
> +
> +DEFINE_EVENT(cdns3_log_doorbell, cdns3_doorbell_ep0,
> +       TP_PROTO(const char *ep_name, u32 ep_trbaddr),
> +       TP_ARGS(ep_name, ep_trbaddr)
> +);
> +
> +DEFINE_EVENT(cdns3_log_doorbell, cdns3_doorbell_epx,
> +       TP_PROTO(const char *ep_name, u32 ep_trbaddr),
> +       TP_ARGS(ep_name, ep_trbaddr)
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_usb_irq,
> +       TP_PROTO(struct cdns3_device *priv_dev, u32 usb_ists),
> +       TP_ARGS(priv_dev, usb_ists),
> +       TP_STRUCT__entry(
> +               __field(enum usb_device_speed, speed)
> +               __field(u32, usb_ists)
> +               __dynamic_array(char, str, CDNS3_MSG_MAX)
> +       ),
> +       TP_fast_assign(
> +               __entry->speed = cdns3_get_speed(priv_dev);
> +               __entry->usb_ists = usb_ists;
> +       ),
> +       TP_printk("%s", cdns3_decode_usb_irq(__get_str(str), __entry->speed,
> +                                            __entry->usb_ists))
> +);
> +
> +DEFINE_EVENT(cdns3_log_usb_irq, cdns3_usb_irq,
> +       TP_PROTO(struct cdns3_device *priv_dev, u32 usb_ists),
> +       TP_ARGS(priv_dev, usb_ists)
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_epx_irq,
> +       TP_PROTO(struct cdns3_device *priv_dev, struct cdns3_endpoint *priv_ep),
> +       TP_ARGS(priv_dev, priv_ep),
> +       TP_STRUCT__entry(
> +               __string(ep_name, priv_ep->name)
> +               __field(u32, ep_sts)
> +               __field(u32, ep_traddr)
> +               __dynamic_array(char, str, CDNS3_MSG_MAX)
> +       ),
> +       TP_fast_assign(
> +               __assign_str(ep_name, priv_ep->name);
> +               __entry->ep_sts = readl(&priv_dev->regs->ep_sts);
> +               __entry->ep_traddr = readl(&priv_dev->regs->ep_traddr);
> +       ),
> +       TP_printk("%s, ep_traddr: %08x",
> +                 cdns3_decode_epx_irq(__get_str(str),
> +                                      __get_str(ep_name),
> +                                      __entry->ep_sts),
> +                 __entry->ep_traddr)
> +);
> +
> +DEFINE_EVENT(cdns3_log_epx_irq, cdns3_epx_irq,
> +       TP_PROTO(struct cdns3_device *priv_dev, struct cdns3_endpoint *priv_ep),
> +       TP_ARGS(priv_dev, priv_ep)
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_ep0_irq,
> +       TP_PROTO(struct cdns3_device *priv_dev,  u32 ep_sts),
> +       TP_ARGS(priv_dev, ep_sts),
> +       TP_STRUCT__entry(
> +               __field(int, ep_dir)
> +               __field(u32, ep_sts)
> +               __dynamic_array(char, str, CDNS3_MSG_MAX)
> +       ),
> +       TP_fast_assign(
> +               __entry->ep_dir = priv_dev->ep0_data_dir;
> +               __entry->ep_sts = ep_sts;
> +       ),
> +       TP_printk("%s", cdns3_decode_ep0_irq(__get_str(str),
> +                                            __entry->ep_dir,
> +                                            __entry->ep_sts))
> +);
> +
> +DEFINE_EVENT(cdns3_log_ep0_irq, cdns3_ep0_irq,
> +       TP_PROTO(struct cdns3_device *priv_dev, u32 ep_sts),
> +       TP_ARGS(priv_dev, ep_sts)
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_ctrl,
> +       TP_PROTO(struct usb_ctrlrequest *ctrl),
> +       TP_ARGS(ctrl),
> +       TP_STRUCT__entry(
> +               __field(u8, bRequestType)
> +               __field(u8, bRequest)
> +               __field(u16, wValue)
> +               __field(u16, wIndex)
> +               __field(u16, wLength)
> +               __dynamic_array(char, str, CDNS3_MSG_MAX)
> +       ),
> +       TP_fast_assign(
> +               __entry->bRequestType = ctrl->bRequestType;
> +               __entry->bRequest = ctrl->bRequest;
> +               __entry->wValue = le16_to_cpu(ctrl->wValue);
> +               __entry->wIndex = le16_to_cpu(ctrl->wIndex);
> +               __entry->wLength = le16_to_cpu(ctrl->wLength);
> +       ),
> +       TP_printk("%s", usb_decode_ctrl(__get_str(str), __entry->bRequestType,
> +                                       __entry->bRequest, __entry->wValue,
> +                                       __entry->wIndex, __entry->wLength)
> +       )
> +);
> +
> +DEFINE_EVENT(cdns3_log_ctrl, cdns3_ctrl_req,
> +       TP_PROTO(struct usb_ctrlrequest *ctrl),
> +       TP_ARGS(ctrl)
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_request,
> +       TP_PROTO(struct cdns3_request *req),
> +       TP_ARGS(req),
> +       TP_STRUCT__entry(
> +               __string(name, req->priv_ep->name)
> +               __field(struct cdns3_request *, req)
> +               __field(unsigned int, actual)
> +               __field(unsigned int, length)
> +               __field(int, status)
> +               __field(int, zero)
> +               __field(int, short_not_ok)
> +               __field(int, no_interrupt)
> +               __field(int, start_trb)
> +               __field(int, end_trb)
> +               __field(struct cdns3_trb *, start_trb_addr)
> +               __field(int, flags)
> +       ),
> +       TP_fast_assign(
> +               __assign_str(name, req->priv_ep->name);
> +               __entry->req = req;
> +               __entry->actual = req->request.actual;
> +               __entry->length = req->request.length;
> +               __entry->status = req->request.status;
> +               __entry->zero = req->request.zero;
> +               __entry->short_not_ok = req->request.short_not_ok;
> +               __entry->no_interrupt = req->request.no_interrupt;
> +               __entry->start_trb = req->start_trb;
> +               __entry->end_trb = req->end_trb;
> +               __entry->start_trb_addr = req->trb;
> +               __entry->flags = req->flags;
> +       ),
> +       TP_printk("%s: req: %p, length: %u/%u %s%s%s, status: %d,"
> +                 " trb: [start:%d, end:%d: virt addr %pa], flags:%x ",
> +               __get_str(name), __entry->req, __entry->actual, __entry->length,
> +               __entry->zero ? "zero | " : "",
> +               __entry->short_not_ok ? "short | " : "",
> +               __entry->no_interrupt ? "no int" : "",
> +               __entry->status,
> +               __entry->start_trb,
> +               __entry->end_trb,
> +               __entry->start_trb_addr,
> +               __entry->flags
> +       )
> +);
> +
> +DEFINE_EVENT(cdns3_log_request, cdns3_alloc_request,
> +       TP_PROTO(struct cdns3_request *req),
> +       TP_ARGS(req)
> +);
> +
> +DEFINE_EVENT(cdns3_log_request, cdns3_free_request,
> +       TP_PROTO(struct cdns3_request *req),
> +       TP_ARGS(req)
> +);
> +
> +DEFINE_EVENT(cdns3_log_request, cdns3_ep_queue,
> +       TP_PROTO(struct cdns3_request *req),
> +       TP_ARGS(req)
> +);
> +
> +DEFINE_EVENT(cdns3_log_request, cdns3_ep_dequeue,
> +       TP_PROTO(struct cdns3_request *req),
> +       TP_ARGS(req)
> +);
> +
> +DEFINE_EVENT(cdns3_log_request, cdns3_gadget_giveback,
> +       TP_PROTO(struct cdns3_request *req),
> +       TP_ARGS(req)
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_trb,
> +       TP_PROTO(struct cdns3_endpoint *priv_ep, struct cdns3_trb *trb),
> +       TP_ARGS(priv_ep, trb),
> +       TP_STRUCT__entry(
> +               __string(name, priv_ep->name)
> +               __field(struct cdns3_trb *, trb)
> +               __field(u32, buffer)
> +               __field(u32, length)
> +               __field(u32, control)
> +               __field(u32, type)
> +       ),
> +       TP_fast_assign(
> +               __assign_str(name, priv_ep->name);
> +               __entry->trb = trb;
> +               __entry->buffer = trb->buffer;
> +               __entry->length = trb->length;
> +               __entry->control = trb->control;
> +               __entry->type = usb_endpoint_type(priv_ep->endpoint.desc);
> +       ),
> +       TP_printk("%s: trb 0x%pa, dma buf: 0x%08x, size: %ld, ctrl: 0x%08x (%s%s%s%s%s%s%s)",
> +               __get_str(name), __entry->trb, __entry->buffer,
> +               TRB_LEN(__entry->length), __entry->control,
> +               __entry->control & TRB_CYCLE ? "C=1, " : "C=0, ",
> +               __entry->control & TRB_TOGGLE ? "T=1, " : "T=0, ",
> +               __entry->control & TRB_ISP ? "ISP, " : "",
> +               __entry->control & TRB_FIFO_MODE ? "FIFO, " : "",
> +               __entry->control & TRB_CHAIN ? "CHAIN, " : "",
> +               __entry->control & TRB_IOC ? "IOC, " : "",
> +               TRB_FIELD_TO_TYPE(__entry->control) == TRB_NORMAL ? "Normal" : "LINK"
> +       )
> +);
> +
> +DEFINE_EVENT(cdns3_log_trb, cdns3_prepare_trb,
> +       TP_PROTO(struct cdns3_endpoint *priv_ep, struct cdns3_trb *trb),
> +       TP_ARGS(priv_ep, trb)
> +);
> +
> +DEFINE_EVENT(cdns3_log_trb, cdns3_complete_trb,
> +       TP_PROTO(struct cdns3_endpoint *priv_ep, struct cdns3_trb *trb),
> +       TP_ARGS(priv_ep, trb)
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_ring,
> +       TP_PROTO(struct cdns3_endpoint *priv_ep),
> +       TP_ARGS(priv_ep),
> +       TP_STRUCT__entry(
> +               __dynamic_array(u8, ring, TRB_RING_SIZE)
> +               __dynamic_array(u8, priv_ep, sizeof(struct cdns3_endpoint))
> +               __dynamic_array(char, buffer,
> +                               (TRBS_PER_SEGMENT * 65) + CDNS3_MSG_MAX)
> +       ),
> +       TP_fast_assign(
> +               memcpy(__get_dynamic_array(priv_ep), priv_ep,
> +                      sizeof(struct cdns3_endpoint));
> +               memcpy(__get_dynamic_array(ring), priv_ep->trb_pool,
> +                      TRB_RING_SIZE);
> +       ),
> +
> +       TP_printk("%s",
> +                 cdns3_dbg_ring((struct cdns3_endpoint *)__get_str(priv_ep),
> +                                (struct cdns3_trb *)__get_str(ring),
> +                                __get_str(buffer)))
> +);
> +
> +DEFINE_EVENT(cdns3_log_ring, cdns3_ring,
> +       TP_PROTO(struct cdns3_endpoint *priv_ep),
> +       TP_ARGS(priv_ep)
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_ep,
> +       TP_PROTO(struct cdns3_endpoint *priv_ep),
> +       TP_ARGS(priv_ep),
> +       TP_STRUCT__entry(
> +               __string(name, priv_ep->name)
> +               __field(unsigned int, maxpacket)
> +               __field(unsigned int, maxpacket_limit)
> +               __field(unsigned int, max_streams)
> +               __field(unsigned int, maxburst)
> +               __field(unsigned int, flags)
> +               __field(unsigned int, dir)
> +               __field(u8, enqueue)
> +               __field(u8, dequeue)
> +       ),
> +       TP_fast_assign(
> +               __assign_str(name, priv_ep->name);
> +               __entry->maxpacket = priv_ep->endpoint.maxpacket;
> +               __entry->maxpacket_limit = priv_ep->endpoint.maxpacket_limit;
> +               __entry->max_streams = priv_ep->endpoint.max_streams;
> +               __entry->maxburst = priv_ep->endpoint.maxburst;
> +               __entry->flags = priv_ep->flags;
> +               __entry->dir = priv_ep->dir;
> +               __entry->enqueue = priv_ep->enqueue;
> +               __entry->dequeue = priv_ep->dequeue;
> +       ),
> +       TP_printk("%s: mps: %d/%d. streams: %d, burst: %d, enq idx: %d, "
> +                 "deq idx: %d, flags %s%s%s%s%s%s%s%s, dir: %s",
> +               __get_str(name), __entry->maxpacket,
> +               __entry->maxpacket_limit, __entry->max_streams,
> +               __entry->maxburst, __entry->enqueue,
> +               __entry->dequeue,
> +               __entry->flags & EP_ENABLED ? "EN | " : "",
> +               __entry->flags & EP_STALL ? "STALL | " : "",
> +               __entry->flags & EP_WEDGE ? "WEDGE | " : "",
> +               __entry->flags & EP_TRANSFER_STARTED ? "STARTED | " : "",
> +               __entry->flags & EP_UPDATE_EP_TRBADDR ? "UPD TRB | " : "",
> +               __entry->flags & EP_PENDING_REQUEST ? "REQ PEN | " : "",
> +               __entry->flags & EP_RING_FULL ? "RING FULL |" : "",
> +               __entry->flags & EP_CLAIMED ?  "CLAIMED " : "",
> +               __entry->dir ? "IN" : "OUT"
> +       )
> +);
> +
> +DEFINE_EVENT(cdns3_log_ep, cdns3_gadget_ep_enable,
> +       TP_PROTO(struct cdns3_endpoint *priv_ep),
> +       TP_ARGS(priv_ep)
> +);
> +
> +DEFINE_EVENT(cdns3_log_ep, cdns3_gadget_ep_disable,
> +       TP_PROTO(struct cdns3_endpoint *priv_ep),
> +       TP_ARGS(priv_ep)
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_request_handled,
> +       TP_PROTO(struct cdns3_request *priv_req, int current_index,
> +                int handled),
> +       TP_ARGS(priv_req, current_index, handled),
> +       TP_STRUCT__entry(
> +               __field(struct cdns3_request *, priv_req)
> +               __field(unsigned int, dma_position)
> +               __field(unsigned int, handled)
> +               __field(unsigned int, dequeue_idx)
> +               __field(unsigned int, enqueue_idx)
> +               __field(unsigned int, start_trb)
> +               __field(unsigned int, end_trb)
> +       ),
> +       TP_fast_assign(
> +               __entry->priv_req = priv_req;
> +               __entry->dma_position = current_index;
> +               __entry->handled = handled;
> +               __entry->dequeue_idx = priv_req->priv_ep->dequeue;
> +               __entry->enqueue_idx = priv_req->priv_ep->enqueue;
> +               __entry->start_trb = priv_req->start_trb;
> +               __entry->end_trb = priv_req->end_trb;
> +       ),
> +       TP_printk("Req: %p %s, DMA pos: %d, ep deq: %d, ep enq: %d,"
> +                 " start trb: %d, end trb: %d",
> +               __entry->priv_req,
> +               __entry->handled ? "handled" : "not handled",
> +               __entry->dma_position, __entry->dequeue_idx,
> +               __entry->enqueue_idx, __entry->start_trb,
> +               __entry->end_trb
> +       )
> +);
> +
> +DEFINE_EVENT(cdns3_log_request_handled, cdns3_request_handled,
> +       TP_PROTO(struct cdns3_request *priv_req, int current_index,
> +                int handled),
> +       TP_ARGS(priv_req, current_index, handled)
> +);
> +#endif /* __LINUX_CDNS3_TRACE */
> +
> +/* this part must be outside header guard */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE trace
> +
> +#include <trace/define_trace.h>
> --
> 2.17.1
>

--000000000000aa40e6057f108708
Content-Type: application/octet-stream; 
	name="0001-usb-cdns3-improve-drd-flow.patch"
Content-Disposition: attachment; 
	filename="0001-usb-cdns3-improve-drd-flow.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jqpxqbmq0>
X-Attachment-Id: f_jqpxqbmq0

RnJvbSBkZDQzYTAzOGI5ZWI1NTNmZmI4NjRkZGVmNzAzZDQxMzU1MjcyYmFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQZXRlciBDaGVuIDxwZXRlci5jaGVuQG54cC5jb20+CkRhdGU6
IFdlZCwgOSBKYW4gMjAxOSAxNzo1MDoxMCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSB1c2I6
IGNkbnMzOiBpbXByb3ZlIGRyZCBmbG93CgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBDaGVuIDxwZXRl
ci5jaGVuQG54cC5jb20+Ci0tLQogZHJpdmVycy91c2IvY2RuczMvS2NvbmZpZyAgICAgICAgICAg
ICB8ICAxMCArCiBkcml2ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZSAgICAgICAgICAgIHwgIDE0ICst
CiBkcml2ZXJzL3VzYi9jZG5zMy9jZG5zMy1pbXguYyAgICAgICAgIHwgNjAwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLW54cC1yZWct
ZGVmLmggfCAxNzQgKysrKysrKysrKwogZHJpdmVycy91c2IvY2RuczMvY29yZS5jICAgICAgICAg
ICAgICB8IDI3MiArKy0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuaCAgICAg
ICAgICAgICAgfCAgMzUgKy0KIGRyaXZlcnMvdXNiL2NkbnMzL2RyZC5jICAgICAgICAgICAgICAg
fCA0ODAgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiBkcml2ZXJzL3VzYi9jZG5zMy9kcmQu
aCAgICAgICAgICAgICAgIHwgIDE0ICstCiBkcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuYyAgICAg
ICAgICAgIHwgIDcwICsrKy0KIGRyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5oICAgICAgICAgICAg
fCAgIDUgKy0KIGRyaXZlcnMvdXNiL2NkbnMzL3RyYWNlLmggICAgICAgICAgICAgfCAgIDQgKy0K
IDExIGZpbGVzIGNoYW5nZWQsIDEyMTAgaW5zZXJ0aW9ucygrKSwgNDY4IGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLWlteC5jCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvY2RuczMtbnhwLXJlZy1kZWYuaAoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL0tjb25maWcgYi9kcml2ZXJzL3VzYi9jZG5zMy9LY29u
ZmlnCmluZGV4IDRhZGZkODc4MTFlOC4uMGU4OWRmMThmMTgwIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3VzYi9jZG5zMy9LY29uZmlnCisrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL0tjb25maWcKQEAgLTQx
LDQgKzQxLDE0IEBAIGNvbmZpZyBVU0JfQ0ROUzNfUENJX1dSQVAKIAkgIElmIHlvdSBjaG9vc2Ug
dG8gYnVpbGQgdGhpcyBkcml2ZXIgYXMgbW9kdWxlIGl0IHdpbGwKIAkgIGJlIGR5bmFtaWNhbGx5
IGxpbmtlZCBhbmQgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIGNkbnMzLXBjaS5rbwogCitjb25maWcg
VVNCX0NETlMzX0lNWF9XUkFQCisJdHJpc3RhdGUgIkNhZGVuY2UgVVNCMyBzdXBwb3J0IG9uIE5Y
UCBpLk1YIHBsYXRmb3JtcyIKKwlkZXBlbmRzIG9uIE9GCisJZGVmYXVsdCBVU0JfQ0ROUzMKKwlo
ZWxwCisJICBJZiB5b3UncmUgdXNpbmcgdGhlIFVTQlNTIENvcmUgSVAgd2l0aCBpLk1YIHBsYXRm
b3JtLCBwbGVhc2Ugc2F5CisJICAnWScgb3IgJ00nIGhlcmUuCisKKwkgIElmIHlvdSBjaG9vc2Ug
dG8gYnVpbGQgdGhpcyBkcml2ZXIgYXMgbW9kdWxlIGl0IHdpbGwKKwkgIGJlIGR5bmFtaWNhbGx5
IGxpbmtlZCBhbmQgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIGNkbnMzLWlteC5rbwogZW5kaWYKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL01ha2VmaWxlIGIvZHJpdmVycy91c2IvY2RuczMv
TWFrZWZpbGUKaW5kZXggM2Y2M2JhYTI0Mjk0Li43YzIxMThiNmI2OTIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvdXNiL2NkbnMzL01ha2VmaWxlCisrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL01ha2VmaWxl
CkBAIC0yLDE1ICsyLDEzIEBACiAjIGRlZmluZV90cmFjZS5oIG5lZWRzIHRvIGtub3cgaG93IHRv
IGZpbmQgb3VyIGhlYWRlcgogQ0ZMQUdTX3RyYWNlLm8JCQkJOj0gLUkkKHNyYykKIAotb2JqLSQo
Q09ORklHX1VTQl9DRE5TMykJCQkrPSBjZG5zMy5vCi1vYmotJChDT05GSUdfVVNCX0NETlMzX1BD
SV9XUkFQKQkrPSBjZG5zMy1wY2kubwotCiBjZG5zMy15CQkJCQk6PSBjb3JlLm8gZHJkLm8gdHJh
Y2UubwotCi1pZm5lcSAoJChDT05GSUdfREVCVUdfRlMpLCkKLQljZG5zMy15CQkJCSs9IGRlYnVn
ZnMubwotZW5kaWYKK29iai0kKENPTkZJR19VU0JfQ0ROUzMpCQkJKz0gY2RuczMubworI2lmbmVx
ICgkKENPTkZJR19ERUJVR19GUyksKQorIwljZG5zMy15CQkJCSs9IGRlYnVnZnMubworI2VuZGlm
CiAKIGNkbnMzLSQoQ09ORklHX1VTQl9DRE5TM19HQURHRVQpCSs9IGdhZGdldC5vIGVwMC5vCiBj
ZG5zMy0kKENPTkZJR19VU0JfQ0ROUzNfSE9TVCkJCSs9IGhvc3QubwotY2RuczMtcGNpLXkJCSAJ
CTo9IGNkbnMzLXBjaS13cmFwLm8KK29iai0kKENPTkZJR19VU0JfQ0ROUzNfUENJX1dSQVApCSs9
IGNkbnMzLXBjaS13cmFwLm8KK29iai0kKENPTkZJR19VU0JfQ0ROUzNfSU1YX1dSQVApCSs9IGNk
bnMzLWlteC5vCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9jZG5zMy1pbXguYyBiL2Ry
aXZlcnMvdXNiL2NkbnMzL2NkbnMzLWlteC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMDAwMC4uNjAwZmFiNzViNjNlCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy91c2Iv
Y2RuczMvY2RuczMtaW14LmMKQEAgLTAsMCArMSw2MDAgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wCisvKgorICogY2RuczMtaW14LmMgLSBpbXggR2x1ZSBsYXllcgorICoK
KyAqIENvcHlyaWdodCAoQykgMjAxNy0yMDE4IE5YUAorICoKKyAqIEF1dGhvcnM6IFBldGVyIENo
ZW4gPHBldGVyLmNoZW5AbnhwLmNvbT4KKyAqLworCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
CisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvb2Yu
aD4KKyNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPgorI2luY2x1ZGUgPGxpbnV4L2lvLmg+
CisjaW5jbHVkZSA8bGludXgvY2xrLmg+CisjaW5jbHVkZSA8bGludXgvdXNiL29mLmg+CisjaW5j
bHVkZSA8bGludXgvdXNiL3BoeS5oPgorI2luY2x1ZGUgPGxpbnV4L2V4dGNvbi5oPgorI2luY2x1
ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4KKyNpbmNsdWRlIDxsaW51eC9yZXNldC1jb250cm9sbGVy
Lmg+CisKKyNpbmNsdWRlICJjZG5zMy1ueHAtcmVnLWRlZi5oIgorI2luY2x1ZGUgImNvcmUuaCIK
KworI2RlZmluZSBVU0IzX0NPUkVfQ1RSTDEgICAgMHgwMAorI2RlZmluZSBVU0IzX0NPUkVfQ1RS
TDIgICAgMHgwNAorI2RlZmluZSBVU0IzX0lOVF9SRUcgICAgICAgMHgwOAorI2RlZmluZSBVU0Iz
X0NPUkVfU1RBVFVTICAgMHgwYworI2RlZmluZSBYSENJX0RFQlVHX0xJTktfU1QgMHgxMAorI2Rl
ZmluZSBYSENJX0RFQlVHX0JVUyAgICAgMHgxNAorI2RlZmluZSBVU0IzX1NTUEhZX0NUUkwxICAg
MHg0MAorI2RlZmluZSBVU0IzX1NTUEhZX0NUUkwyICAgMHg0NAorI2RlZmluZSBVU0IzX1NTUEhZ
X1NUQVRVUyAgMHg0YworI2RlZmluZSBVU0IyX1BIWV9DVFJMMSAgICAgMHg1MAorI2RlZmluZSBV
U0IyX1BIWV9DVFJMMiAgICAgMHg1NAorI2RlZmluZSBVU0IyX1BIWV9TVEFUVVMgICAgMHg1Ywor
CisvKiBSZWdpc3RlciBiaXRzIGRlZmluaXRpb24gKi8KKworLyogVVNCM19DT1JFX0NUUkwxICov
CisjZGVmaW5lIFNXX1JFU0VUX01BU0sJKDB4M2YgPDwgMjYpCisjZGVmaW5lIFBXUl9TV19SRVNF
VAkoMSA8PCAzMSkKKyNkZWZpbmUgQVBCX1NXX1JFU0VUCSgxIDw8IDMwKQorI2RlZmluZSBBWElf
U1dfUkVTRVQJKDEgPDwgMjkpCisjZGVmaW5lIFJXX1NXX1JFU0VUCSgxIDw8IDI4KQorI2RlZmlu
ZSBQSFlfU1dfUkVTRVQJKDEgPDwgMjcpCisjZGVmaW5lIFBIWUFIQl9TV19SRVNFVAkoMSA8PCAy
NikKKyNkZWZpbmUgQUxMX1NXX1JFU0VUCShQV1JfU1dfUkVTRVQgfCBBUEJfU1dfUkVTRVQgfCBB
WElfU1dfUkVTRVQgfCBcCisJCVJXX1NXX1JFU0VUIHwgUEhZX1NXX1JFU0VUIHwgUEhZQUhCX1NX
X1JFU0VUKQorI2RlZmluZSBPQ19ESVNBQkxFCSgxIDw8IDkpCisjZGVmaW5lIE1EQ1RSTF9DTEtf
U0VMCSgxIDw8IDcpCisjZGVmaW5lIE1PREVfU1RSQVBfTUFTSwkoMHg3KQorI2RlZmluZSBERVZf
TU9ERQkoMSA8PCAyKQorI2RlZmluZSBIT1NUX01PREUJKDEgPDwgMSkKKyNkZWZpbmUgT1RHX01P
REUJKDEgPDwgMCkKKworLyogVVNCM19JTlRfUkVHICovCisjZGVmaW5lIENMS18xMjVfUkVRCSgx
IDw8IDI5KQorI2RlZmluZSBMUE1fQ0xLX1JFUQkoMSA8PCAyOCkKKyNkZWZpbmUgREVWVTNfV0FF
S1VQX0VOCSgxIDw8IDE0KQorI2RlZmluZSBPVEdfV0FLRVVQX0VOCSgxIDw8IDEyKQorI2RlZmlu
ZSBERVZfSU5UX0VOICgzIDw8IDgpIC8qIERFViBJTlQgYjk6OCAqLworI2RlZmluZSBIT1NUX0lO
VDFfRU4gKDEgPDwgMCkgLyogSE9TVCBJTlQgYjc6MCAqLworCisvKiBVU0IzX0NPUkVfU1RBVFVT
ICovCisjZGVmaW5lIE1EQ1RSTF9DTEtfU1RBVFVTCSgxIDw8IDE1KQorI2RlZmluZSBERVZfUE9X
RVJfT05fUkVBRFkJKDEgPDwgMTMpCisjZGVmaW5lIEhPU1RfUE9XRVJfT05fUkVBRFkJKDEgPDwg
MTIpCisKKy8qIFVTQjNfU1NQSFlfU1RBVFVTICovCisjZGVmaW5lIFBIWV9SRUZDTEtfUkVRCQko
MSA8PCAwKQorCisjZGVmaW5lIENETlMzX0lNWF9DTEtTX05VTSA1CitzdGF0aWMgaW50IGNkbnMz
X2lteF9zZXRfbW9kZShzdHJ1Y3QgY2RuczMgKmNkbnMpOworCitzdHJ1Y3QgY2RuczNfaW14IHsK
Kwl2b2lkIF9faW9tZW0gKnJlZ3M7CisJdm9pZCBfX2lvbWVtICpwaHlfcmVnczsKKwllbnVtIHVz
Yl9kcl9tb2RlIHJvbGU7CisJc3RydWN0IGRldmljZSAqZGV2OworCXN0cnVjdCBjbGsgKmlteF9j
bGtzW0NETlMzX0lNWF9DTEtTX05VTV07CisJc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2IHJj
ZGV2OworfTsKKworc3RydWN0IGNkbnMzX3BsYXRmb3JtX2RhdGEgY2RuczNfaW14X3BkYXRhID0g
eworCS5zZXRfbW9kZSA9IGNkbnMzX2lteF9zZXRfbW9kZSwKK307CisKKyNpZiAxCitzdGF0aWMg
dm9pZCBjZG5zM191c2JfcGh5X2luaXQodm9pZCBfX2lvbWVtICpyZWdzKQoreworCXUzMiB2YWx1
ZTsKKworCXByX2RlYnVnKCJiZWdpbiBvZiAlc1xuIiwgX19mdW5jX18pOworCisJd3JpdGVsKDB4
MDgzMCwgcmVncyArIFBIWV9QTUFfQ01OX0NUUkwxKTsKKwl3cml0ZWwoMHgxMCwgcmVncyArIFRC
X0FERFJfQ01OX0RJQUdfSFNDTEtfU0VMKTsKKwl3cml0ZWwoMHgwMEYwLCByZWdzICsgVEJfQURE
Ul9DTU5fUExMMF9WQ09DQUxfSU5JVF9UTVIpOworCXdyaXRlbCgweDAwMTgsIHJlZ3MgKyBUQl9B
RERSX0NNTl9QTEwwX1ZDT0NBTF9JVEVSX1RNUik7CisJd3JpdGVsKDB4MDBEMCwgcmVncyArIFRC
X0FERFJfQ01OX1BMTDBfSU5URElWKTsKKwl3cml0ZWwoMHg0YWFhLCByZWdzICsgVEJfQUREUl9D
TU5fUExMMF9GUkFDRElWKTsKKwl3cml0ZWwoMHgwMDM0LCByZWdzICsgVEJfQUREUl9DTU5fUExM
MF9ISUdIX1RIUik7CisJd3JpdGVsKDB4MWVlLCByZWdzICsgVEJfQUREUl9DTU5fUExMMF9TU19D
VFJMMSk7CisJd3JpdGVsKDB4N0YwMywgcmVncyArIFRCX0FERFJfQ01OX1BMTDBfU1NfQ1RSTDIp
OworCXdyaXRlbCgweDAwMjAsIHJlZ3MgKyBUQl9BRERSX0NNTl9QTEwwX0RTTV9ESUFHKTsKKwl3
cml0ZWwoMHgwMDAwLCByZWdzICsgVEJfQUREUl9DTU5fRElBR19QTEwwX09WUkQpOworCXdyaXRl
bCgweDAwMDAsIHJlZ3MgKyBUQl9BRERSX0NNTl9ESUFHX1BMTDBfRkJIX09WUkQpOworCXdyaXRl
bCgweDAwMDAsIHJlZ3MgKyBUQl9BRERSX0NNTl9ESUFHX1BMTDBfRkJMX09WUkQpOworCXdyaXRl
bCgweDAwMDcsIHJlZ3MgKyBUQl9BRERSX0NNTl9ESUFHX1BMTDBfVjJJX1RVTkUpOworCXdyaXRl
bCgweDAwMjcsIHJlZ3MgKyBUQl9BRERSX0NNTl9ESUFHX1BMTDBfQ1BfVFVORSk7CisJd3JpdGVs
KDB4MDAwOCwgcmVncyArIFRCX0FERFJfQ01OX0RJQUdfUExMMF9MRl9QUk9HKTsKKwl3cml0ZWwo
MHgwMDIyLCByZWdzICsgVEJfQUREUl9DTU5fRElBR19QTEwwX1RFU1RfTU9ERSk7CisJd3JpdGVs
KDB4MDAwYSwgcmVncyArIFRCX0FERFJfQ01OX1BTTV9DTEtfQ1RSTCk7CisJd3JpdGVsKDB4MTM5
LCByZWdzICsgVEJfQUREUl9YQ1ZSX0RJQUdfUlhfTEFORV9DQUxfUlNUX1RNUik7CisJd3JpdGVs
KDB4YmVmYywgcmVncyArIFRCX0FERFJfWENWUl9QU01fUkNUUkwpOworCisJd3JpdGVsKDB4Nzc5
OSwgcmVncyArIFRCX0FERFJfVFhfUFNDX0EwKTsKKwl3cml0ZWwoMHg3Nzk4LCByZWdzICsgVEJf
QUREUl9UWF9QU0NfQTEpOworCXdyaXRlbCgweDUwOWIsIHJlZ3MgKyBUQl9BRERSX1RYX1BTQ19B
Mik7CisJd3JpdGVsKDB4MywgcmVncyArIFRCX0FERFJfVFhfRElBR19FQ1RSTF9PVlJEKTsKKwl3
cml0ZWwoMHg1MDliLCByZWdzICsgVEJfQUREUl9UWF9QU0NfQTMpOworCXdyaXRlbCgweDIwOTAs
IHJlZ3MgKyBUQl9BRERSX1RYX1BTQ19DQUwpOworCXdyaXRlbCgweDIwOTAsIHJlZ3MgKyBUQl9B
RERSX1RYX1BTQ19SRFkpOworCisJd3JpdGVsKDB4QTZGRCwgcmVncyArIFRCX0FERFJfUlhfUFND
X0EwKTsKKwl3cml0ZWwoMHhBNkZELCByZWdzICsgVEJfQUREUl9SWF9QU0NfQTEpOworCXdyaXRl
bCgweEE0MTAsIHJlZ3MgKyBUQl9BRERSX1JYX1BTQ19BMik7CisJd3JpdGVsKDB4MjQxMCwgcmVn
cyArIFRCX0FERFJfUlhfUFNDX0EzKTsKKworCXdyaXRlbCgweDIzRkYsIHJlZ3MgKyBUQl9BRERS
X1JYX1BTQ19DQUwpOworCXdyaXRlbCgweDIwMTAsIHJlZ3MgKyBUQl9BRERSX1JYX1BTQ19SRFkp
OworCisJd3JpdGVsKDB4MDAyMCwgcmVncyArIFRCX0FERFJfVFhfVFhDQ19NR05MU19NVUxUXzAw
MCk7CisJd3JpdGVsKDB4MDBmZiwgcmVncyArIFRCX0FERFJfVFhfRElBR19CR1JFRl9QUkVEUlZf
REVMQVkpOworCXdyaXRlbCgweDAwMDIsIHJlZ3MgKyBUQl9BRERSX1JYX1NMQ19DVV9JVEVSX1RN
Uik7CisJd3JpdGVsKDB4MDAxMywgcmVncyArIFRCX0FERFJfUlhfU0lHREVUX0hMX0ZJTFRfVE1S
KTsKKwl3cml0ZWwoMHgwMDAwLCByZWdzICsgVEJfQUREUl9SWF9TQU1QX0RBQ19DVFJMKTsKKwl3
cml0ZWwoMHgxMDA0LCByZWdzICsgVEJfQUREUl9SWF9ESUFHX1NJR0RFVF9UVU5FKTsKKwl3cml0
ZWwoMHg0MDQxLCByZWdzICsgVEJfQUREUl9SWF9ESUFHX0xGUFNERVRfVFVORTIpOworCXdyaXRl
bCgweDA0ODAsIHJlZ3MgKyBUQl9BRERSX1JYX0RJQUdfQlNfVE0pOworCXdyaXRlbCgweDgwMDYs
IHJlZ3MgKyBUQl9BRERSX1JYX0RJQUdfREZFX0NUUkwxKTsKKwl3cml0ZWwoMHgwMDNmLCByZWdz
ICsgVEJfQUREUl9SWF9ESUFHX0lMTF9JUUVfVFJJTTQpOworCXdyaXRlbCgweDU0M2YsIHJlZ3Mg
KyBUQl9BRERSX1JYX0RJQUdfSUxMX0VfVFJJTTApOworCXdyaXRlbCgweDU0M2YsIHJlZ3MgKyBU
Ql9BRERSX1JYX0RJQUdfSUxMX0lRX1RSSU0wKTsKKwl3cml0ZWwoMHgwMDAwLCByZWdzICsgVEJf
QUREUl9SWF9ESUFHX0lMTF9JUUVfVFJJTTYpOworCXdyaXRlbCgweDgwMDAsIHJlZ3MgKyBUQl9B
RERSX1JYX0RJQUdfUlhGRV9UTTMpOworCXdyaXRlbCgweDAwMDMsIHJlZ3MgKyBUQl9BRERSX1JY
X0RJQUdfUlhGRV9UTTQpOworCXdyaXRlbCgweDI0MDgsIHJlZ3MgKyBUQl9BRERSX1JYX0RJQUdf
TEZQU0RFVF9UVU5FKTsKKwl3cml0ZWwoMHgwNWNhLCByZWdzICsgVEJfQUREUl9SWF9ESUFHX0RG
RV9DVFJMMyk7CisJd3JpdGVsKDB4MDI1OCwgcmVncyArIFRCX0FERFJfUlhfRElBR19TQzJDX0RF
TEFZKTsKKwl3cml0ZWwoMHgxZmZmLCByZWdzICsgVEJfQUREUl9SWF9SRUVfVkdBX0dBSU5fTk9E
RkUpOworCisJd3JpdGVsKDB4MDJjNiwgcmVncyArIFRCX0FERFJfWENWUl9QU01fQ0FMX1RNUik7
CisJd3JpdGVsKDB4MDAwMiwgcmVncyArIFRCX0FERFJfWENWUl9QU01fQTBCWVBfVE1SKTsKKwl3
cml0ZWwoMHgwMmM2LCByZWdzICsgVEJfQUREUl9YQ1ZSX1BTTV9BMElOX1RNUik7CisJd3JpdGVs
KDB4MDAxMCwgcmVncyArIFRCX0FERFJfWENWUl9QU01fQTFJTl9UTVIpOworCXdyaXRlbCgweDAw
MTAsIHJlZ3MgKyBUQl9BRERSX1hDVlJfUFNNX0EySU5fVE1SKTsKKwl3cml0ZWwoMHgwMDEwLCBy
ZWdzICsgVEJfQUREUl9YQ1ZSX1BTTV9BM0lOX1RNUik7CisJd3JpdGVsKDB4MDAxMCwgcmVncyAr
IFRCX0FERFJfWENWUl9QU01fQTRJTl9UTVIpOworCXdyaXRlbCgweDAwMTAsIHJlZ3MgKyBUQl9B
RERSX1hDVlJfUFNNX0E1SU5fVE1SKTsKKworCXdyaXRlbCgweDAwMDIsIHJlZ3MgKyBUQl9BRERS
X1hDVlJfUFNNX0EwT1VUX1RNUik7CisJd3JpdGVsKDB4MDAwMiwgcmVncyArIFRCX0FERFJfWENW
Ul9QU01fQTFPVVRfVE1SKTsKKwl3cml0ZWwoMHgwMDAyLCByZWdzICsgVEJfQUREUl9YQ1ZSX1BT
TV9BMk9VVF9UTVIpOworCXdyaXRlbCgweDAwMDIsIHJlZ3MgKyBUQl9BRERSX1hDVlJfUFNNX0Ez
T1VUX1RNUik7CisJd3JpdGVsKDB4MDAwMiwgcmVncyArIFRCX0FERFJfWENWUl9QU01fQTRPVVRf
VE1SKTsKKwl3cml0ZWwoMHgwMDAyLCByZWdzICsgVEJfQUREUl9YQ1ZSX1BTTV9BNU9VVF9UTVIp
OworCisJLyogQ2hhbmdlIHJ4IGRldGVjdCBwYXJhbWV0ZXIgKi8KKwl3cml0ZWwoMHg5NjAsIHJl
Z3MgKyBUQl9BRERSX1RYX1JDVkRFVF9FTl9UTVIpOworCXdyaXRlbCgweDAxZTAsIHJlZ3MgKyBU
Ql9BRERSX1RYX1JDVkRFVF9TVF9UTVIpOworCXdyaXRlbCgweDAwOTAsIHJlZ3MgKyBUQl9BRERS
X1hDVlJfRElBR19MQU5FX0ZDTV9FTl9NR05fVE1SKTsKKworCS8qIFJYREVUX0lOX1AzXzMyS0ha
LCBSZWNlaXZlciBkZXRlY3Qgc2xvdyBjbG9jayBlbmFibGUgKi8KKwl2YWx1ZSA9IHJlYWRsKHJl
Z3MgKyBUQl9BRERSX1RYX1JDVkRFVFNDX0NUUkwpOworCXZhbHVlIHw9IFJYREVUX0lOX1AzXzMy
S0haOworCXdyaXRlbCh2YWx1ZSwgcmVncyArIFRCX0FERFJfVFhfUkNWREVUU0NfQ1RSTCk7CisK
Kwl1ZGVsYXkoMTApOworCisJcHJfZGVidWcoImVuZCBvZiAlc1xuIiwgX19mdW5jX18pOworfQor
I2VuZGlmCitzdGF0aWMgdm9pZCBjZG5zX2lteF9wbGF0X2luaXQoc3RydWN0IGNkbnMzX2lteCAq
aW14KQoreworCXUzMiB2YWx1ZTsKKwlpbnQgdGltZW91dF91cyA9IDEwMDAwMDsKKworCS8qIFdh
aXQgY2xrIHZhbHVlICovCisJdmFsdWUgPSByZWFkbChpbXgtPnJlZ3MgKyBVU0IzX1NTUEhZX1NU
QVRVUyk7CisJd3JpdGVsKHZhbHVlLCBpbXgtPnJlZ3MgKyBVU0IzX1NTUEhZX1NUQVRVUyk7CisJ
dWRlbGF5KDEpOworCXZhbHVlID0gcmVhZGwoaW14LT5yZWdzICsgVVNCM19TU1BIWV9TVEFUVVMp
OworCXdoaWxlICgodmFsdWUgJiAweGYwMDAwMDAwKSAhPSAweGYwMDAwMDAwICYmIHRpbWVvdXRf
dXMtLSA+IDApIHsKKwkJdmFsdWUgPSByZWFkbChpbXgtPnJlZ3MgKyBVU0IzX1NTUEhZX1NUQVRV
Uyk7CisJCWRldl9kYmcoaW14LT5kZXYsICJjbGt2bGQ6MHgleFxuIiwgdmFsdWUpOworCQl1ZGVs
YXkoMSk7CisJfQorCisJaWYgKHRpbWVvdXRfdXMgPD0gMCkKKwkJZGV2X2VycihpbXgtPmRldiwg
IndhaXQgY2xrdmxkIHRpbWVvdXRcbiIpOworCisJLyogU2V0IGFsbCBSZXNldCBiaXRzICovCisJ
dmFsdWUgPSByZWFkbChpbXgtPnJlZ3MgKyBVU0IzX0NPUkVfQ1RSTDEpOworCXZhbHVlIHw9IEFM
TF9TV19SRVNFVDsKKwl3cml0ZWwodmFsdWUsIGlteC0+cmVncyArIFVTQjNfQ09SRV9DVFJMMSk7
CisJdWRlbGF5KDEpOworCisJdmFsdWUgPSByZWFkbChpbXgtPnJlZ3MgKyBVU0IzX0NPUkVfQ1RS
TDEpOworCXZhbHVlICY9IH5QSFlBSEJfU1dfUkVTRVQ7CisJd3JpdGVsKHZhbHVlLCBpbXgtPnJl
Z3MgKyBVU0IzX0NPUkVfQ1RSTDEpOworCisJY2RuczNfdXNiX3BoeV9pbml0KGlteC0+cGh5X3Jl
Z3MpOworCisJdmFsdWUgPSByZWFkbChpbXgtPnJlZ3MgKyBVU0IzX0NPUkVfQ1RSTDEpOworCXZh
bHVlICY9IH5BTExfU1dfUkVTRVQ7CisJd3JpdGVsKHZhbHVlLCBpbXgtPnJlZ3MgKyBVU0IzX0NP
UkVfQ1RSTDEpOworCisjaWYgMAorCWlmIChyb2xlID09IFVTQl9EUl9NT0RFX0hPU1QpIHsKKwkJ
dmFsdWUgPSByZWFkbChpbXgtPnJlZ3MgKyBVU0IzX0NPUkVfQ1RSTDEpOworCQl2YWx1ZSA9ICh2
YWx1ZSAmIH5NT0RFX1NUUkFQX01BU0spIHwgSE9TVF9NT0RFIHwgT0NfRElTQUJMRTsKKwkJd3Jp
dGVsKHZhbHVlLCBpbXgtPnJlZ3MgKyBVU0IzX0NPUkVfQ1RSTDEpOworCQl2YWx1ZSAmPSB+UEhZ
QUhCX1NXX1JFU0VUOworCQl3cml0ZWwodmFsdWUsIGlteC0+cmVncyArIFVTQjNfQ09SRV9DVFJM
MSk7CisJCW1kZWxheSgxKTsKKwkJLyogVE9ETyBjaGVjayB0aGUgc2VxdWVuY2UgKi8KKwkJY2Ru
czNfdXNiX3BoeV9pbml0KGlteC0+cGh5X3JlZ3MpOworCQkvKiBGb3JjZSBCIFNlc3Npb24gVmFs
aWQgYXMgMSAqLworCQl3cml0ZWwoMHgwMDYwLCBpbXgtPnBoeV9yZWdzICsgMHgzODBhNCk7CisJ
CW1kZWxheSgxKTsKKworCQl2YWx1ZSA9IHJlYWRsKGlteC0+cmVncyArIFVTQjNfSU5UX1JFRyk7
CisJCXZhbHVlIHw9IEhPU1RfSU5UMV9FTjsKKwkJd3JpdGVsKHZhbHVlLCBpbXgtPnJlZ3MgKyBV
U0IzX0lOVF9SRUcpOworCisJCXZhbHVlID0gcmVhZGwoaW14LT5yZWdzICsgVVNCM19DT1JFX0NU
UkwxKTsKKwkJdmFsdWUgJj0gfkFMTF9TV19SRVNFVDsKKwkJd3JpdGVsKHZhbHVlLCBpbXgtPnJl
Z3MgKyBVU0IzX0NPUkVfQ1RSTDEpOworCisJCWRldl9kYmcoaW14LT5kZXYsICJ3YWl0IHhoY2lf
cG93ZXJfb25fcmVhZHlcbiIpOworCisJCXZhbHVlID0gcmVhZGwoaW14LT5yZWdzICsgVVNCM19D
T1JFX1NUQVRVUyk7CisJCXRpbWVvdXRfdXMgPSAxMDAwMDA7CisJCXdoaWxlICghKHZhbHVlICYg
SE9TVF9QT1dFUl9PTl9SRUFEWSkgJiYgdGltZW91dF91cy0tID4gMCkgeworCQkJdmFsdWUgPSBy
ZWFkbChpbXgtPnJlZ3MgKyBVU0IzX0NPUkVfU1RBVFVTKTsKKwkJCXVkZWxheSgxKTsKKwkJfQor
CisJCWlmICh0aW1lb3V0X3VzIDw9IDApCisJCQlkZXZfZXJyKGlteC0+ZGV2LCAid2FpdCB4aGNp
X3Bvd2VyX29uX3JlYWR5IHRpbWVvdXRcbiIpOworCisJCS8qCisJCXZhbHVlID0gcmVhZGwoeGhj
aV9yZWdzICsgWEVDUF9QT1JUX0NBUF9SRUcpOworCQl2YWx1ZSB8PSBMUE1fMl9TVEJfU1dJVENI
X0VOOworCQl3cml0ZWwodmFsdWUsIHhoY2lfcmVncyArIFhFQ1BfUE9SVF9DQVBfUkVHKTsKKwkJ
Ki8KKworCQltZGVsYXkoMSk7CisKKwkJZGV2X2RiZyhpbXgtPmRldiwgInN3aXRjaCB0byBob3N0
IHJvbGUgc3VjY2Vzc2Z1bGx5XG4iKTsKKwl9IGVsc2UgaWYgKHJvbGUgPT0gVVNCX0RSX01PREVf
UEVSSVBIRVJBTCkgeworCQl2YWx1ZSA9IHJlYWRsKGlteC0+cmVncyArIFVTQjNfQ09SRV9DVFJM
MSk7CisJLy8JdmFsdWUgPSAodmFsdWUgJiB+TU9ERV9TVFJBUF9NQVNLKSB8IERFVl9NT0RFOwor
CS8vCXdyaXRlbCh2YWx1ZSwgaW14LT5yZWdzICsgVVNCM19DT1JFX0NUUkwxKTsKKwkJdmFsdWUg
Jj0gflBIWUFIQl9TV19SRVNFVDsKKwkJd3JpdGVsKHZhbHVlLCBpbXgtPnJlZ3MgKyBVU0IzX0NP
UkVfQ1RSTDEpOworCisJCWNkbnMzX3VzYl9waHlfaW5pdChpbXgtPnBoeV9yZWdzKTsKKwkJLyog
Rm9yY2UgQiBTZXNzaW9uIFZhbGlkIGFzIDEgKi8KKy8vCQl3cml0ZWwoMHgwMDYwLCBpbXgtPnBo
eV9yZWdzICsgMHgzODBhNCk7CisJCXZhbHVlID0gcmVhZGwoaW14LT5yZWdzICsgVVNCM19JTlRf
UkVHKTsKKwkJdmFsdWUgfD0gREVWX0lOVF9FTjsKKwkJd3JpdGVsKHZhbHVlLCBpbXgtPnJlZ3Mg
KyBVU0IzX0lOVF9SRUcpOworCisJCXZhbHVlID0gcmVhZGwoaW14LT5yZWdzICsgVVNCM19DT1JF
X0NUUkwxKTsKKwkJdmFsdWUgJj0gfkFMTF9TV19SRVNFVDsKKwkJd3JpdGVsKHZhbHVlLCBpbXgt
PnJlZ3MgKyBVU0IzX0NPUkVfQ1RSTDEpOworCisJCWRldl9kYmcoaW14LT5kZXYsICJ3YWl0IGdh
ZGdldF9wb3dlcl9vbl9yZWFkeVxuIik7CisKKwkJdmFsdWUgPSByZWFkbChpbXgtPnJlZ3MgKyBV
U0IzX0NPUkVfU1RBVFVTKTsKKwkJdGltZW91dF91cyA9IDEwMDAwMDsKKwkJd2hpbGUgKCEodmFs
dWUgJiBERVZfUE9XRVJfT05fUkVBRFkpICYmIHRpbWVvdXRfdXMtLSA+IDApIHsKKwkJCXZhbHVl
ID0gcmVhZGwoaW14LT5yZWdzICsgVVNCM19DT1JFX1NUQVRVUyk7CisJCQl1ZGVsYXkoMSk7CisJ
CX0KKworCQlpZiAodGltZW91dF91cyA8PSAwKQorCQkJZGV2X2VycihpbXgtPmRldiwKKwkJCQki
d2FpdCBnYWRnZXRfcG93ZXJfb25fcmVhZHkgdGltZW91dFxuIik7CisKKwkJbWRlbGF5KDEpOwor
CisJCWRldl9kYmcoaW14LT5kZXYsICJzd2l0Y2ggdG8gZ2FkZ2V0IHJvbGUgc3VjY2Vzc2Z1bGx5
XG4iKTsKKwl9CisjZW5kaWYKK30KKworc3RhdGljIGludCBjZG5zM19pbXhfc2V0X21vZGUoc3Ry
dWN0IGNkbnMzICpjZG5zKQoreworCXN0cnVjdCBkZXZpY2UgKmRldiA9IGNkbnMtPmRldi0+cGFy
ZW50OworCXN0cnVjdCBjZG5zM19pbXggKmlteCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOworCWVu
dW0gY2RuczNfcm9sZXMgcm9sZSA9IGNkbnMtPnJvbGU7CisJdTMyIHZhbHVlOworCWludCB0aW1l
b3V0X3VzID0gMTAwMDAwOworCisJc3dpdGNoIChyb2xlKSB7CisJY2FzZSBDRE5TM19ST0xFX0dB
REdFVDoKKwkJZGV2X2luZm8oZGV2LCAiU2V0IGNvbnRyb2xsZXIgdG8gR2FkZ2V0IG1vZGVcbiIp
OworCQl2YWx1ZSA9IHJlYWRsKGlteC0+cmVncyArIFVTQjNfQ09SRV9DVFJMMSk7CisJCXZhbHVl
ID0gKHZhbHVlICYgfk1PREVfU1RSQVBfTUFTSykgfCBERVZfTU9ERTsKKwkJd3JpdGVsKHZhbHVl
LCBpbXgtPnJlZ3MgKyBVU0IzX0NPUkVfQ1RSTDEpOworCisJCXZhbHVlID0gcmVhZGwoaW14LT5y
ZWdzICsgVVNCM19JTlRfUkVHKTsKKwkJdmFsdWUgfD0gREVWX0lOVF9FTjsKKwkJd3JpdGVsKHZh
bHVlLCBpbXgtPnJlZ3MgKyBVU0IzX0lOVF9SRUcpOworCisJCWRldl9kYmcoZGV2LCAid2FpdCBn
YWRnZXRfcG93ZXJfb25fcmVhZHlcbiIpOworCisJCXZhbHVlID0gcmVhZGwoaW14LT5yZWdzICsg
VVNCM19DT1JFX1NUQVRVUyk7CisJCXRpbWVvdXRfdXMgPSAxMDAwMDA7CisJCXdoaWxlICghKHZh
bHVlICYgREVWX1BPV0VSX09OX1JFQURZKSAmJiB0aW1lb3V0X3VzLS0gPiAwKSB7CisJCQl2YWx1
ZSA9IHJlYWRsKGlteC0+cmVncyArIFVTQjNfQ09SRV9TVEFUVVMpOworCQkJdWRlbGF5KDEpOwor
CQl9CisKKwkJaWYgKHRpbWVvdXRfdXMgPD0gMCkKKwkJCWRldl9lcnIoZGV2LCAid2FpdCBnYWRn
ZXRfcG93ZXJfb25fcmVhZHkgdGltZW91dFxuIik7CisJCWJyZWFrOworCWNhc2UgQ0ROUzNfUk9M
RV9IT1NUOgorCQlkZXZfaW5mbyhkZXYsICJTZXQgY29udHJvbGxlciB0byBIb3N0IG1vZGVcbiIp
OworCQl2YWx1ZSA9IHJlYWRsKGlteC0+cmVncyArIFVTQjNfQ09SRV9DVFJMMSk7CisJCXZhbHVl
ID0gKHZhbHVlICYgfk1PREVfU1RSQVBfTUFTSykgfCBIT1NUX01PREUgfCBPQ19ESVNBQkxFOwor
CQl3cml0ZWwodmFsdWUsIGlteC0+cmVncyArIFVTQjNfQ09SRV9DVFJMMSk7CisKKwkJdmFsdWUg
PSByZWFkbChpbXgtPnJlZ3MgKyBVU0IzX0lOVF9SRUcpOworCQl2YWx1ZSB8PSBIT1NUX0lOVDFf
RU47CisJCXdyaXRlbCh2YWx1ZSwgaW14LT5yZWdzICsgVVNCM19JTlRfUkVHKTsKKworCQlkZXZf
ZGJnKGRldiwgIndhaXQgeGhjaV9wb3dlcl9vbl9yZWFkeVxuIik7CisKKwkJdmFsdWUgPSByZWFk
bChpbXgtPnJlZ3MgKyBVU0IzX0NPUkVfU1RBVFVTKTsKKwkJdGltZW91dF91cyA9IDEwMDAwMDsK
KwkJd2hpbGUgKCEodmFsdWUgJiBIT1NUX1BPV0VSX09OX1JFQURZKSAmJiB0aW1lb3V0X3VzLS0g
PiAwKSB7CisJCQl2YWx1ZSA9IHJlYWRsKGlteC0+cmVncyArIFVTQjNfQ09SRV9TVEFUVVMpOwor
CQkJdWRlbGF5KDEpOworCQl9CisKKwkJaWYgKHRpbWVvdXRfdXMgPD0gMCkKKwkJCWRldl9lcnIo
ZGV2LCAid2FpdCB4aGNpX3Bvd2VyX29uX3JlYWR5IHRpbWVvdXRcbiIpOworCQlicmVhazsKKwlj
YXNlIENETlMzX1JPTEVfRU5EOgorCQlkZXZfaW5mbyhkZXYsICJyZXNldCBjb250cm9sbGVyXG4i
KTsKKwkJY2Ruc19pbXhfcGxhdF9pbml0KGlteCk7CisJCWJyZWFrOworCX0KKworCXJldHVybiAw
OworfQorCitzdGF0aWMgaW50IGlteF9nZXRfY2xrcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCit7CisJ
c3RydWN0IGNkbnMzX2lteCAqaW14ID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisJaW50IHJldCA9
IDA7CisKKwlpbXgtPmlteF9jbGtzWzBdID0gZGV2bV9jbGtfZ2V0KGRldiwgInVzYjNfbHBtX2Ns
ayIpOworCWlmIChJU19FUlIoaW14LT5pbXhfY2xrc1swXSkpIHsKKwkJcmV0ID0gUFRSX0VSUihp
bXgtPmlteF9jbGtzWzBdKTsKKwkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IHVzYjNfbHBt
X2NsaywgZXJyPSVkXG4iLCByZXQpOworCQlyZXR1cm4gcmV0OworCX0KKworCWlteC0+aW14X2Ns
a3NbMV0gPSBkZXZtX2Nsa19nZXQoZGV2LCAidXNiM19idXNfY2xrIik7CisJaWYgKElTX0VSUihp
bXgtPmlteF9jbGtzWzFdKSkgeworCQlyZXQgPSBQVFJfRVJSKGlteC0+aW14X2Nsa3NbMV0pOwor
CQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgdXNiM19idXNfY2xrLCBlcnI9JWRcbiIsIHJl
dCk7CisJCXJldHVybiByZXQ7CisJfQorCisJaW14LT5pbXhfY2xrc1syXSA9IGRldm1fY2xrX2dl
dChkZXYsICJ1c2IzX2FjbGsiKTsKKwlpZiAoSVNfRVJSKGlteC0+aW14X2Nsa3NbMl0pKSB7CisJ
CXJldCA9IFBUUl9FUlIoaW14LT5pbXhfY2xrc1syXSk7CisJCWRldl9lcnIoZGV2LCAiRmFpbGVk
IHRvIGdldCB1c2IzX2FjbGssIGVycj0lZFxuIiwgcmV0KTsKKwkJcmV0dXJuIHJldDsKKwl9CisK
KwlpbXgtPmlteF9jbGtzWzNdID0gZGV2bV9jbGtfZ2V0KGRldiwgInVzYjNfaXBnX2NsayIpOwor
CWlmIChJU19FUlIoaW14LT5pbXhfY2xrc1szXSkpIHsKKwkJcmV0ID0gUFRSX0VSUihpbXgtPmlt
eF9jbGtzWzNdKTsKKwkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IHVzYjNfaXBnX2Nsaywg
ZXJyPSVkXG4iLCByZXQpOworCQlyZXR1cm4gcmV0OworCX0KKworCWlteC0+aW14X2Nsa3NbNF0g
PSBkZXZtX2Nsa19nZXQoZGV2LCAidXNiM19jb3JlX3BjbGsiKTsKKwlpZiAoSVNfRVJSKGlteC0+
aW14X2Nsa3NbNF0pKSB7CisJCXJldCA9IFBUUl9FUlIoaW14LT5pbXhfY2xrc1s0XSk7CisJCWRl
dl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCB1c2IzX2NvcmVfcGNsaywgZXJyPSVkXG4iLCByZXQp
OworCQlyZXR1cm4gcmV0OworCX0KKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IGlteF9w
cmVwYXJlX2VuYWJsZV9jbGtzKHN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3QgY2RuczNf
aW14ICppbXggPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwlpbnQgaSwgaiwgcmV0ID0gMDsKKwor
CWZvciAoaSA9IDA7IGkgPCBDRE5TM19JTVhfQ0xLU19OVU07IGkrKykgeworCQlyZXQgPSBjbGtf
cHJlcGFyZV9lbmFibGUoaW14LT5pbXhfY2xrc1tpXSk7CisJCWlmIChyZXQpIHsKKwkJCWRldl9l
cnIoZGV2LAorCQkJCSJGYWlsZWQgdG8gcHJlcGFyZS9lbmFibGUgY2RuczMgY2xrLCBlcnI9JWRc
biIsCisJCQkJcmV0KTsKKwkJCWdvdG8gZXJyOworCQl9CisJfQorCisJcmV0dXJuIHJldDsKK2Vy
cjoKKwlmb3IgKGogPSBpOyBqID4gMDsgai0tKQorCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14
LT5pbXhfY2xrc1tqIC0gMV0pOworCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIHZvaWQgaW14
X2Rpc2FibGVfdW5wcmVwYXJlX2Nsa3Moc3RydWN0IGRldmljZSAqZGV2KQoreworCXN0cnVjdCBj
ZG5zM19pbXggKmlteCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOworCWludCBpOworCisJZm9yIChp
ID0gQ0ROUzNfSU1YX0NMS1NfTlVNIC0gMTsgaSA+PSAwOyBpLS0pCisJCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShpbXgtPmlteF9jbGtzW2ldKTsKK30KKworc3RhdGljIGludCBjZG5zM19pbXhfYXNz
ZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqciwgdW5zaWduZWQgbG9uZyBpZCkKK3sK
KwlzdHJ1Y3QgY2RuczNfaW14ICppbXggPSBjb250YWluZXJfb2Yociwgc3RydWN0IGNkbnMzX2lt
eCwgcmNkZXYpOworCXUzMiB2YWx1ZTsKKworCXZhbHVlID0gcmVhZGwoaW14LT5yZWdzICsgVVNC
M19DT1JFX0NUUkwxKTsKKwlpZiAoaWQgPT0gMCkKKwkJdmFsdWUgJj0gflBIWV9TV19SRVNFVDsK
KwllbHNlIGlmIChpZCA9PSAxKQorCQl2YWx1ZSAmPSB+UEhZQUhCX1NXX1JFU0VUOworCisJd3Jp
dGVsKHZhbHVlLCBpbXgtPnJlZ3MgKyBVU0IzX0NPUkVfQ1RSTDEpOworCXJldHVybiAwOworfQor
CitzdGF0aWMgaW50IGNkbnMzX2lteF9kZWFzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9k
ZXYgKnIsIHVuc2lnbmVkIGxvbmcgaWQpCit7CisJc3RydWN0IGNkbnMzX2lteCAqaW14ID0gY29u
dGFpbmVyX29mKHIsIHN0cnVjdCBjZG5zM19pbXgsIHJjZGV2KTsKKwl1MzIgdmFsdWU7CisKKwl2
YWx1ZSA9IHJlYWRsKGlteC0+cmVncyArIFVTQjNfQ09SRV9DVFJMMSk7CisJaWYgKGlkID09IDAp
CisJCXZhbHVlICY9IH5QSFlfU1dfUkVTRVQ7CisJZWxzZSBpZiAoaWQgPT0gMSkKKwkJdmFsdWUg
Jj0gflBIWUFIQl9TV19SRVNFVDsKKworCXdyaXRlbCh2YWx1ZSwgaW14LT5yZWdzICsgVVNCM19D
T1JFX0NUUkwxKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9j
b250cm9sX29wcyBjZG5zM19pbXhfcmVzZXRfb3BzID0geworCS5hc3NlcnQgPSBjZG5zM19pbXhf
YXNzZXJ0LAorCS5kZWFzc2VydCA9IGNkbnMzX2lteF9kZWFzc2VydCwKK307CisKKy8qKgorICog
Y2RuczNfbnhwX3Byb2JlIC0gcHJvYmUgZm9yIGlteCBnbHVlIGRyaXZlcgorICogQHBkZXY6IFBv
aW50ZXIgdG8gaW14IGdsdWUgcGxhdGZvcm0gZGV2aWNlCisgKgorICogUmV0dXJucyAwIG9uIHN1
Y2Nlc3Mgb3RoZXJ3aXNlIG5lZ2F0aXZlIGVycm5vCisgKi8KK3N0YXRpYyBpbnQgY2RuczNfaW14
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBkZXYtPmRldjsKKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25v
ZGU7CisJc3RydWN0IHJlc291cmNlCSpyZXM7CisJc3RydWN0IGNkbnMzX2lteCAqaW14OworCXZv
aWQgX19pb21lbSAqcmVnczsKKwlpbnQgcmV0OworCXN0cnVjdCBvZl9kZXZfYXV4ZGF0YSBpbXhf
YXV4ZGF0YSA9IHsKKwkJLmNvbXBhdGlibGUgPSAiY2Rucyx1c2IzLTEuMC4wIiwKKwkJLnBsYXRm
b3JtX2RhdGEgPSAmY2RuczNfaW14X3BkYXRhLAorCX07CisKKwlkZXZfZGJnKGRldiwgIiVzIHN0
YXJ0LCBwZGF0YT0weCVwXG4iLCBfX2Z1bmNfXywgJmNkbnMzX2lteF9wZGF0YSk7CisJaWYgKCFu
b2RlKSB7CisJCWRldl9lcnIoZGV2LCAiZGV2aWNlIG5vZGUgbm90IGZvdW5kXG4iKTsKKwkJcmV0
dXJuIC1FSU5WQUw7CisJfQorCisJaW14ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCppbXgp
LCBHRlBfS0VSTkVMKTsKKwlpZiAoIWlteCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlpbXgtPmRl
diA9IGRldjsKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBpbXgpOworCisJcmVzID0gcGxh
dGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKKwlyZWdzID0gZGV2
bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsKKwlpZiAoSVNfRVJSKHJlZ3MpKQorCQlyZXR1
cm4gUFRSX0VSUihyZWdzKTsKKworCWlteC0+cmVncyA9IHJlZ3M7CisKKwlyZXMgPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDEpOworCXJlZ3MgPSBkZXZtX2lv
cmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOworCWlmIChJU19FUlIocmVncykpCisJCXJldHVybiBQ
VFJfRVJSKHJlZ3MpOworCisJaW14LT5waHlfcmVncyA9IHJlZ3M7CisKKwlyZXQgPSBpbXhfZ2V0
X2Nsa3MoZGV2KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJcmV0ID0gaW14X3ByZXBh
cmVfZW5hYmxlX2Nsa3MoZGV2KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisvLwlpbXgt
PnJvbGUgPSB1c2JfZ2V0X2RyX21vZGUoZGV2KTsKKy8vCWRldl9kYmcoZGV2LCAidGhlIGluaXQg
cm9sZSBpcyAlZFxuIiwgaW14LT5yb2xlKTsKKwljZG5zX2lteF9wbGF0X2luaXQoaW14KTsKKwor
CWlteC0+cmNkZXYub3duZXIgPSBUSElTX01PRFVMRTsKKwlpbXgtPnJjZGV2Lm9wcyA9ICZjZG5z
M19pbXhfcmVzZXRfb3BzOworCWlteC0+cmNkZXYub2Zfbm9kZSA9IGRldi0+b2Zfbm9kZTsKKwlp
bXgtPnJjZGV2Lm5yX3Jlc2V0cyA9IDI7CisJcmV0ID0gcmVzZXRfY29udHJvbGxlcl9yZWdpc3Rl
cigmaW14LT5yY2Rldik7CisJaWYgKHJldCkKKwkJZ290byBlcnIxOworCisJcmV0ID0gb2ZfcGxh
dGZvcm1fcG9wdWxhdGUobm9kZSwgTlVMTCwgJmlteF9hdXhkYXRhLCBkZXYpOworCWlmIChyZXQp
IHsKKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gY3JlYXRlIGNuZHMzIGNvcmVcbiIpOworCQln
b3RvIGVycjI7CisJfQorCisJZGV2X2RiZyhkZXYsICJDYWRlbmNlIFVTQjMgY29yZTogcHJvYmUg
c3VjY2VlZFxuIik7CisKKwlyZXR1cm4gMDsKK2VycjI6CisJcmVzZXRfY29udHJvbGxlcl91bnJl
Z2lzdGVyKCZpbXgtPnJjZGV2KTsKK2VycjE6CisJaW14X2Rpc2FibGVfdW5wcmVwYXJlX2Nsa3Mo
ZGV2KTsKKwlyZXR1cm4gcmV0OworfQorCisvKioKKyAqIGNkbnMzX2lteF9yZW1vdmUgLSByZW1v
dmUgZ2x1ZSBpbXggZHJpdmVyCisgKiBAcGRldjogUG9pbnRlciB0byBMaW51eCBwbGF0Zm9ybSBk
ZXZpY2UKKyAqCisgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBvdGhlcndpc2UgbmVnYXRpdmUgZXJy
bm8KKyAqLworc3RhdGljIGludCBjZG5zM19pbXhfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpCit7CisJaW14X2Rpc2FibGVfdW5wcmVwYXJlX2Nsa3MoJnBkZXYtPmRldik7CisJ
cmV0dXJuIDA7Cit9CisKKyNpZmRlZiBDT05GSUdfT0YKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIG9mX2NkbnMzX2lteF9tYXRjaFtdID0geworCXsgLmNvbXBhdGlibGUgPSAibnhw
LGNkbnMzIiB9LAorCXsgfSwKK307CitNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBvZl9jZG5zM19t
YXRjaCk7CisjZW5kaWYKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgY2RuczNfaW14
X2RyaXZlciA9IHsKKwkucHJvYmUJCT0gY2RuczNfaW14X3Byb2JlLAorCS5yZW1vdmUJCT0gY2Ru
czNfaW14X3JlbW92ZSwKKwkuZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSAibnhwLWNkbnMzIiwKKwkJ
Lm9mX21hdGNoX3RhYmxlCT0gb2ZfbWF0Y2hfcHRyKG9mX2NkbnMzX2lteF9tYXRjaCksCisJfSwK
K307CisKK3N0YXRpYyBpbnQgX19pbml0IGNkbnMzX2lteF9yZWdpc3Rlcih2b2lkKQoreworCXJl
dHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmNkbnMzX2lteF9kcml2ZXIpOworfQorbW9k
dWxlX2luaXQoY2RuczNfaW14X3JlZ2lzdGVyKTsKKworc3RhdGljIHZvaWQgX19leGl0IGNkbnMz
X2lteF91bnJlZ2lzdGVyKHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmNk
bnMzX2lteF9kcml2ZXIpOworfQorbW9kdWxlX2V4aXQoY2RuczNfaW14X3VucmVnaXN0ZXIpOwor
CitNT0RVTEVfQUxJQVMoInBsYXRmb3JtOmNkbnMzLW54cCIpOworTU9EVUxFX0FVVEhPUigiUGV0
ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29tPiIpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIp
OworTU9EVUxFX0RFU0NSSVBUSU9OKCJDYWRlbmNlIFVTQjMgaW14IGdsdWUgZHJpdmVyIik7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9jZG5zMy1ueHAtcmVnLWRlZi5oIGIvZHJpdmVy
cy91c2IvY2RuczMvY2RuczMtbnhwLXJlZy1kZWYuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwMDAwMDAuLjRhYzczMDA1YzAyMwotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMv
dXNiL2NkbnMzL2NkbnMzLW54cC1yZWctZGVmLmgKQEAgLTAsMCArMSwxNzQgQEAKKy8qKgorICog
Y2RuczMtbnhwLXJlZy1kZWYuaCAtIG54cCB3cmFwIGxheWVyIHJlZ2lzdGVyIGRlZmluaXRpb24K
KyAqCisgKiBDb3B5cmlnaHQgMjAxNyBOWFAKKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTogeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIg
IG9mCisgKiB0aGUgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0
aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3Ig
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQgaGF2
ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBh
bG9uZyB3aXRoIHRoaXMgcHJvZ3JhbS4gIElmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcv
bGljZW5zZXMvPi4KKyAqLworCisjaWZuZGVmIF9fRFJJVkVSU19VU0JfQ0ROUzNfTlhQX0gKKyNk
ZWZpbmUgX19EUklWRVJTX1VTQl9DRE5TM19OWFBfSAorCisjZGVmaW5lIFVTQjNfQ09SRV9DVFJM
MSAgICAweDAwCisjZGVmaW5lIFVTQjNfQ09SRV9DVFJMMiAgICAweDA0CisjZGVmaW5lIFVTQjNf
SU5UX1JFRyAgICAgICAweDA4CisjZGVmaW5lIFVTQjNfQ09SRV9TVEFUVVMgICAweDBjCisjZGVm
aW5lIFhIQ0lfREVCVUdfTElOS19TVCAweDEwCisjZGVmaW5lIFhIQ0lfREVCVUdfQlVTICAgICAw
eDE0CisjZGVmaW5lIFVTQjNfU1NQSFlfQ1RSTDEgICAweDQwCisjZGVmaW5lIFVTQjNfU1NQSFlf
Q1RSTDIgICAweDQ0CisjZGVmaW5lIFVTQjNfU1NQSFlfU1RBVFVTICAweDRjCisjZGVmaW5lIFVT
QjJfUEhZX0NUUkwxICAgICAweDUwCisjZGVmaW5lIFVTQjJfUEhZX0NUUkwyICAgICAweDU0Cisj
ZGVmaW5lIFVTQjJfUEhZX1NUQVRVUyAgICAweDVjCisKKy8qIFJlZ2lzdGVyIGJpdHMgZGVmaW5p
dGlvbiAqLworCisvKiBVU0IzX0NPUkVfQ1RSTDEgKi8KKyNkZWZpbmUgU1dfUkVTRVRfTUFTSwko
MHgzZiA8PCAyNikKKyNkZWZpbmUgUFdSX1NXX1JFU0VUCSgxIDw8IDMxKQorI2RlZmluZSBBUEJf
U1dfUkVTRVQJKDEgPDwgMzApCisjZGVmaW5lIEFYSV9TV19SRVNFVAkoMSA8PCAyOSkKKyNkZWZp
bmUgUldfU1dfUkVTRVQJKDEgPDwgMjgpCisjZGVmaW5lIFBIWV9TV19SRVNFVAkoMSA8PCAyNykK
KyNkZWZpbmUgUEhZQUhCX1NXX1JFU0VUCSgxIDw8IDI2KQorI2RlZmluZSBBTExfU1dfUkVTRVQJ
KFBXUl9TV19SRVNFVCB8IEFQQl9TV19SRVNFVCB8IEFYSV9TV19SRVNFVCB8IFwKKwkJUldfU1df
UkVTRVQgfCBQSFlfU1dfUkVTRVQgfCBQSFlBSEJfU1dfUkVTRVQpCisjZGVmaW5lIE9DX0RJU0FC
TEUJKDEgPDwgOSkKKyNkZWZpbmUgTURDVFJMX0NMS19TRUwJKDEgPDwgNykKKyNkZWZpbmUgTU9E
RV9TVFJBUF9NQVNLCSgweDcpCisjZGVmaW5lIERFVl9NT0RFCSgxIDw8IDIpCisjZGVmaW5lIEhP
U1RfTU9ERQkoMSA8PCAxKQorI2RlZmluZSBPVEdfTU9ERQkoMSA8PCAwKQorCisvKiBVU0IzX0lO
VF9SRUcgKi8KKyNkZWZpbmUgQ0xLXzEyNV9SRVEJKDEgPDwgMjkpCisjZGVmaW5lIExQTV9DTEtf
UkVRCSgxIDw8IDI4KQorI2RlZmluZSBERVZVM19XQUVLVVBfRU4JKDEgPDwgMTQpCisjZGVmaW5l
IE9UR19XQUtFVVBfRU4JKDEgPDwgMTIpCisjZGVmaW5lIERFVl9JTlRfRU4gKDMgPDwgOCkgLyog
REVWIElOVCBiOTo4ICovCisjZGVmaW5lIEhPU1RfSU5UMV9FTiAoMSA8PCAwKSAvKiBIT1NUIElO
VCBiNzowICovCisKKy8qIFVTQjNfQ09SRV9TVEFUVVMgKi8KKyNkZWZpbmUgTURDVFJMX0NMS19T
VEFUVVMJKDEgPDwgMTUpCisjZGVmaW5lIERFVl9QT1dFUl9PTl9SRUFEWQkoMSA8PCAxMykKKyNk
ZWZpbmUgSE9TVF9QT1dFUl9PTl9SRUFEWQkoMSA8PCAxMikKKworLyogVVNCM19TU1BIWV9TVEFU
VVMgKi8KKyNkZWZpbmUgUEhZX1JFRkNMS19SRVEJCSgxIDw8IDApCisKKworLyogUEhZIHJlZ2lz
dGVyIGRlZmluaXRpb24gKi8KKyNkZWZpbmUgUEhZX1BNQV9DTU5fQ1RSTDEJCQkoMHhDODAwICog
NCkKKyNkZWZpbmUgVEJfQUREUl9DTU5fRElBR19IU0NMS19TRUwJCSgweDAxZTAgKiA0KQorI2Rl
ZmluZSBUQl9BRERSX0NNTl9QTEwwX1ZDT0NBTF9JTklUX1RNUgkoMHgwMDg0ICogNCkKKyNkZWZp
bmUgVEJfQUREUl9DTU5fUExMMF9WQ09DQUxfSVRFUl9UTVIJKDB4MDA4NSAqIDQpCisjZGVmaW5l
IFRCX0FERFJfQ01OX1BMTDBfSU5URElWCSAgICAgICAgICAgICAgICAoMHgwMDk0ICogNCkKKyNk
ZWZpbmUgVEJfQUREUl9DTU5fUExMMF9GUkFDRElWCQkoMHgwMDk1ICogNCkKKyNkZWZpbmUgVEJf
QUREUl9DTU5fUExMMF9ISUdIX1RIUgkJKDB4MDA5NiAqIDQpCisjZGVmaW5lIFRCX0FERFJfQ01O
X1BMTDBfU1NfQ1RSTDEJCSgweDAwOTggKiA0KQorI2RlZmluZSBUQl9BRERSX0NNTl9QTEwwX1NT
X0NUUkwyCQkoMHgwMDk5ICogNCkKKyNkZWZpbmUgVEJfQUREUl9DTU5fUExMMF9EU01fRElBRwkJ
KDB4MDA5NyAqIDQpCisjZGVmaW5lIFRCX0FERFJfQ01OX0RJQUdfUExMMF9PVlJECQkoMHgwMWMy
ICogNCkKKyNkZWZpbmUgVEJfQUREUl9DTU5fRElBR19QTEwwX0ZCSF9PVlJECQkoMHgwMWMwICog
NCkKKyNkZWZpbmUgVEJfQUREUl9DTU5fRElBR19QTEwwX0ZCTF9PVlJECQkoMHgwMWMxICogNCkK
KyNkZWZpbmUgVEJfQUREUl9DTU5fRElBR19QTEwwX1YySV9UVU5FICAgICAgICAgICgweDAxQzUg
KiA0KQorI2RlZmluZSBUQl9BRERSX0NNTl9ESUFHX1BMTDBfQ1BfVFVORSAgICAgICAgICAgKDB4
MDFDNiAqIDQpCisjZGVmaW5lIFRCX0FERFJfQ01OX0RJQUdfUExMMF9MRl9QUk9HICAgICAgICAg
ICAoMHgwMUM3ICogNCkKKyNkZWZpbmUgVEJfQUREUl9DTU5fRElBR19QTEwwX1RFU1RfTU9ERQkJ
KDB4MDFjNCAqIDQpCisjZGVmaW5lIFRCX0FERFJfQ01OX1BTTV9DTEtfQ1RSTAkJKDB4MDA2MSAq
IDQpCisjZGVmaW5lIFRCX0FERFJfWENWUl9ESUFHX1JYX0xBTkVfQ0FMX1JTVF9UTVIJKDB4NDBl
YSAqIDQpCisjZGVmaW5lIFRCX0FERFJfWENWUl9QU01fUkNUUkwJICAgICAgICAgICAgICAgICgw
eDQwMDEgKiA0KQorI2RlZmluZSBUQl9BRERSX1RYX1BTQ19BMAkJICAgICAgICAoMHg0MTAwICog
NCkKKyNkZWZpbmUgVEJfQUREUl9UWF9QU0NfQTEJCSAgICAgICAgKDB4NDEwMSAqIDQpCisjZGVm
aW5lIFRCX0FERFJfVFhfUFNDX0EyCQkgICAgICAgICgweDQxMDIgKiA0KQorI2RlZmluZSBUQl9B
RERSX1RYX1BTQ19BMwkJICAgICAgICAoMHg0MTAzICogNCkKKyNkZWZpbmUgVEJfQUREUl9UWF9E
SUFHX0VDVFJMX09WUkQJCSgweDQxZjUgKiA0KQorI2RlZmluZSBUQl9BRERSX1RYX1BTQ19DQUwJ
CSAgICAgICAgKDB4NDEwNiAqIDQpCisjZGVmaW5lIFRCX0FERFJfVFhfUFNDX1JEWQkJICAgICAg
ICAoMHg0MTA3ICogNCkKKyNkZWZpbmUgVEJfQUREUl9SWF9QU0NfQTAJICAgICAgICAgICAgICAg
ICgweDgwMDAgKiA0KQorI2RlZmluZSBUQl9BRERSX1JYX1BTQ19BMQkgICAgICAgICAgICAgICAg
KDB4ODAwMSAqIDQpCisjZGVmaW5lIFRCX0FERFJfUlhfUFNDX0EyCSAgICAgICAgICAgICAgICAo
MHg4MDAyICogNCkKKyNkZWZpbmUgVEJfQUREUl9SWF9QU0NfQTMJICAgICAgICAgICAgICAgICgw
eDgwMDMgKiA0KQorI2RlZmluZSBUQl9BRERSX1JYX1BTQ19DQUwJICAgICAgICAgICAgICAgICgw
eDgwMDYgKiA0KQorI2RlZmluZSBUQl9BRERSX1JYX1BTQ19SRFkJICAgICAgICAgICAgICAgICgw
eDgwMDcgKiA0KQorI2RlZmluZSBUQl9BRERSX1RYX1RYQ0NfTUdOTFNfTVVMVF8wMDAJCSgweDQw
NTggKiA0KQorI2RlZmluZSBUQl9BRERSX1RYX0RJQUdfQkdSRUZfUFJFRFJWX0RFTEFZCSgweDQx
ZTcgKiA0KQorI2RlZmluZSBUQl9BRERSX1JYX1NMQ19DVV9JVEVSX1RNUgkJKDB4ODBlMyAqIDQp
CisjZGVmaW5lIFRCX0FERFJfUlhfU0lHREVUX0hMX0ZJTFRfVE1SCQkoMHg4MDkwICogNCkKKyNk
ZWZpbmUgVEJfQUREUl9SWF9TQU1QX0RBQ19DVFJMCQkoMHg4MDU4ICogNCkKKyNkZWZpbmUgVEJf
QUREUl9SWF9ESUFHX1NJR0RFVF9UVU5FCQkoMHg4MWRjICogNCkKKyNkZWZpbmUgVEJfQUREUl9S
WF9ESUFHX0xGUFNERVRfVFVORTIJCSgweDgxZGYgKiA0KQorI2RlZmluZSBUQl9BRERSX1JYX0RJ
QUdfQlNfVE0JICAgICAgICAgICAgICAgICgweDgxZjUgKiA0KQorI2RlZmluZSBUQl9BRERSX1JY
X0RJQUdfREZFX0NUUkwxCQkoMHg4MWQzICogNCkKKyNkZWZpbmUgVEJfQUREUl9SWF9ESUFHX0lM
TF9JUUVfVFJJTTQJCSgweDgxYzcgKiA0KQorI2RlZmluZSBUQl9BRERSX1JYX0RJQUdfSUxMX0Vf
VFJJTTAJCSgweDgxYzIgKiA0KQorI2RlZmluZSBUQl9BRERSX1JYX0RJQUdfSUxMX0lRX1RSSU0w
CQkoMHg4MWMxICogNCkKKyNkZWZpbmUgVEJfQUREUl9SWF9ESUFHX0lMTF9JUUVfVFJJTTYJCSgw
eDgxYzkgKiA0KQorI2RlZmluZSBUQl9BRERSX1JYX0RJQUdfUlhGRV9UTTMJCSgweDgxZjggKiA0
KQorI2RlZmluZSBUQl9BRERSX1JYX0RJQUdfUlhGRV9UTTQJCSgweDgxZjkgKiA0KQorI2RlZmlu
ZSBUQl9BRERSX1JYX0RJQUdfTEZQU0RFVF9UVU5FCQkoMHg4MWRkICogNCkKKyNkZWZpbmUgVEJf
QUREUl9SWF9ESUFHX0RGRV9DVFJMMwkJKDB4ODFkNSAqIDQpCisjZGVmaW5lIFRCX0FERFJfUlhf
RElBR19TQzJDX0RFTEFZCQkoMHg4MWUxICogNCkKKyNkZWZpbmUgVEJfQUREUl9SWF9SRUVfVkdB
X0dBSU5fTk9ERkUJCSgweDgxYmYgKiA0KQorI2RlZmluZSBUQl9BRERSX1hDVlJfUFNNX0NBTF9U
TVIJCSgweDQwMDIgKiA0KQorI2RlZmluZSBUQl9BRERSX1hDVlJfUFNNX0EwQllQX1RNUgkJKDB4
NDAwNCAqIDQpCisjZGVmaW5lIFRCX0FERFJfWENWUl9QU01fQTBJTl9UTVIJCSgweDQwMDMgKiA0
KQorI2RlZmluZSBUQl9BRERSX1hDVlJfUFNNX0ExSU5fVE1SCQkoMHg0MDA1ICogNCkKKyNkZWZp
bmUgVEJfQUREUl9YQ1ZSX1BTTV9BMklOX1RNUgkJKDB4NDAwNiAqIDQpCisjZGVmaW5lIFRCX0FE
RFJfWENWUl9QU01fQTNJTl9UTVIJCSgweDQwMDcgKiA0KQorI2RlZmluZSBUQl9BRERSX1hDVlJf
UFNNX0E0SU5fVE1SCQkoMHg0MDA4ICogNCkKKyNkZWZpbmUgVEJfQUREUl9YQ1ZSX1BTTV9BNUlO
X1RNUgkJKDB4NDAwOSAqIDQpCisjZGVmaW5lIFRCX0FERFJfWENWUl9QU01fQTBPVVRfVE1SCQko
MHg0MDBhICogNCkKKyNkZWZpbmUgVEJfQUREUl9YQ1ZSX1BTTV9BMU9VVF9UTVIJCSgweDQwMGIg
KiA0KQorI2RlZmluZSBUQl9BRERSX1hDVlJfUFNNX0EyT1VUX1RNUgkJKDB4NDAwYyAqIDQpCisj
ZGVmaW5lIFRCX0FERFJfWENWUl9QU01fQTNPVVRfVE1SCQkoMHg0MDBkICogNCkKKyNkZWZpbmUg
VEJfQUREUl9YQ1ZSX1BTTV9BNE9VVF9UTVIJCSgweDQwMGUgKiA0KQorI2RlZmluZSBUQl9BRERS
X1hDVlJfUFNNX0E1T1VUX1RNUgkJKDB4NDAwZiAqIDQpCisjZGVmaW5lIFRCX0FERFJfVFhfUkNW
REVUX0VOX1RNUgkgICAgICAgICgweDQxMjIgKiA0KQorI2RlZmluZSBUQl9BRERSX1RYX1JDVkRF
VF9TVF9UTVIJICAgICAgICAoMHg0MTIzICogNCkKKyNkZWZpbmUgVEJfQUREUl9YQ1ZSX0RJQUdf
TEFORV9GQ01fRU5fTUdOX1RNUgkoMHg0MGYyICogNCkKKyNkZWZpbmUgVEJfQUREUl9UWF9SQ1ZE
RVRTQ19DVFJMCSAgICAgICAgKDB4NDEyNCAqIDQpCisKKy8qIFJlZ2lzdGVyIGJpdHMgZGVmaW5p
dGlvbiAqLworCisvKiBUQl9BRERSX1RYX1JDVkRFVFNDX0NUUkwgKi8KKyNkZWZpbmUgUlhERVRf
SU5fUDNfMzJLSFoJCQkoMSA8PCAwKQorCisvKiBPVEcgcmVnaXN0ZXJzIGRlZmluaXRpb24gKi8K
KyNkZWZpbmUgT1RHU1RTCQkweDQKKyNkZWZpbmUgT1RHUkVGQ0xLCTB4YworCisvKiBSZWdpc3Rl
ciBiaXRzIGRlZmluaXRpb24gKi8KKy8qIE9UR1NUUyAqLworI2RlZmluZSBPVEdfTlJEWQkoMSA8
PCAxMSkKKy8qIE9UR1JFRkNMSyAqLworI2RlZmluZSBPVEdfU1RCX0NMS19TV0lUQ0hfRU4JKDEg
PDwgMzEpCisKKy8qIHhIQ0kgcmVnaXN0ZXJzIGRlZmluaXRpb24gICovCisjZGVmaW5lIFhFQ1Bf
UE9SVF9DQVBfUkVHCTB4ODAwMAorI2RlZmluZSBYRUNQX1BNX1BNQ1NSCQkweDgwMTgKKyNkZWZp
bmUgWEVDUF9BVVhfQ1RSTF9SRUcxCTB4ODEyMAorCisvKiBSZWdpc3RlciBiaXRzIGRlZmluaXRp
b24gKi8KKy8qIFhFQ1BfUE9SVF9DQVBfUkVHICovCisjZGVmaW5lIExQTV8yX1NUQl9TV0lUQ0hf
RU4JKDEgPDwgMjUpCisKKy8qIFhFQ1BfQVVYX0NUUkxfUkVHMSAqLworI2RlZmluZSBDRkdfUlhE
RVRfUDNfRU4JCSgxIDw8IDE1KQorCisvKiBYRUNQX1BNX1BNQ1NSICovCisjZGVmaW5lIFBTX01B
U0sJCQkoMyA8PCAwKQorI2RlZmluZSBQU19EMAkJCTAKKyNkZWZpbmUgUFNfRDEJCQkoMSA8PCAw
KQorI2VuZGlmIC8qIF9fRFJJVkVSU19VU0JfQ0ROUzNfTlhQX0ggKi8KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2NkbnMzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYwppbmRleCBk
Mjc0NTg2YWNhMzYuLmNhZGQyNDlmYmRhZiAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvY2RuczMv
Y29yZS5jCisrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYwpAQCAtMTQsODggKzE0LDEzIEBA
CiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CiAjaW5jbHVkZSA8bGludXgvaW50
ZXJydXB0Lmg+CiAjaW5jbHVkZSA8bGludXgvaW8uaD4KLSNpbmNsdWRlIDxsaW51eC9wbV9ydW50
aW1lLmg+CiAKICNpbmNsdWRlICJnYWRnZXQuaCIKICNpbmNsdWRlICJjb3JlLmgiCisjaW5jbHVk
ZSAiZHJkLmgiCiAjaW5jbHVkZSAiaG9zdC1leHBvcnQuaCIKICNpbmNsdWRlICJnYWRnZXQtZXhw
b3J0LmgiCi0jaW5jbHVkZSAiZHJkLmgiCi0jaW5jbHVkZSAiZGVidWcuaCIKLQotc3RhdGljIGlu
bGluZQotc3RydWN0IGNkbnMzX3JvbGVfZHJpdmVyICpjZG5zM19nZXRfY3VycmVudF9yb2xlX2Ry
aXZlcihzdHJ1Y3QgY2RuczMgKmNkbnMpCi17Ci0JV0FSTl9PTihjZG5zLT5yb2xlID49IENETlMz
X1JPTEVfRU5EIHx8ICFjZG5zLT5yb2xlc1tjZG5zLT5yb2xlXSk7Ci0JcmV0dXJuIGNkbnMtPnJv
bGVzW2NkbnMtPnJvbGVdOwotfQotCi1zdGF0aWMgaW5saW5lIGludCBjZG5zM19yb2xlX3N0YXJ0
KHN0cnVjdCBjZG5zMyAqY2RucywgZW51bSBjZG5zM19yb2xlcyByb2xlKQotewotCWludCByZXQ7
Ci0KLQlpZiAoV0FSTl9PTihyb2xlID49IENETlMzX1JPTEVfRU5EKSkKLQkJcmV0dXJuIDA7Ci0K
LQlpZiAoIWNkbnMtPnJvbGVzW3JvbGVdKQotCQlyZXR1cm4gLUVOWElPOwotCi0JaWYgKGNkbnMt
PnJvbGVzW3JvbGVdLT5zdGF0ZSA9PSBDRE5TM19ST0xFX1NUQVRFX0FDVElWRSkKLQkJcmV0dXJu
IDA7Ci0KLQltdXRleF9sb2NrKCZjZG5zLT5tdXRleCk7Ci0JY2Rucy0+cm9sZSA9IHJvbGU7Ci0J
cmV0ID0gY2Rucy0+cm9sZXNbcm9sZV0tPnN0YXJ0KGNkbnMpOwotCWlmICghcmV0KQotCQljZG5z
LT5yb2xlc1tyb2xlXS0+c3RhdGUgPSBDRE5TM19ST0xFX1NUQVRFX0FDVElWRTsKLQltdXRleF91
bmxvY2soJmNkbnMtPm11dGV4KTsKLQlyZXR1cm4gcmV0OwotfQotCi12b2lkIGNkbnMzX3JvbGVf
c3RvcChzdHJ1Y3QgY2RuczMgKmNkbnMpCi17Ci0JZW51bSBjZG5zM19yb2xlcyByb2xlID0gY2Ru
cy0+cm9sZTsKLQotCWlmIChyb2xlID49IENETlMzX1JPTEVfRU5EKSB7Ci0JCVdBUk5fT04ocm9s
ZSA+IENETlMzX1JPTEVfRU5EKTsKLQkJcmV0dXJuOwotCX0KLQotCWlmIChjZG5zLT5yb2xlc1ty
b2xlXS0+c3RhdGUgPT0gQ0ROUzNfUk9MRV9TVEFURV9JTkFDVElWRSkKLQkJcmV0dXJuOwotCi0J
bXV0ZXhfbG9jaygmY2Rucy0+bXV0ZXgpOwotCWNkbnMtPnJvbGVzW3JvbGVdLT5zdG9wKGNkbnMp
OwotCWNkbnMtPnJvbGVzW3JvbGVdLT5zdGF0ZSA9IENETlMzX1JPTEVfU1RBVEVfSU5BQ1RJVkU7
Ci0JbXV0ZXhfdW5sb2NrKCZjZG5zLT5tdXRleCk7Ci19Ci0KLS8qCi0gKiBjZG5zLT5yb2xlIGdl
dHMgZnJvbSBjZG5zM19nZXRfaW5pdGlhbF9yb2xlLCBhbmQgdGhpcyBBUEkgdGVsbHMgcm9sZSBh
dCB0aGUKLSAqIHJ1bnRpbWUuCi0gKiBJZiBib3RoIHJvbGVzIGFyZSBzdXBwb3J0ZWQsIHRoZSBy
b2xlIGlzIHNlbGVjdGVkIGJhc2VkIG9uIHZidXMvaWQuCi0gKiBJdCBjb3VsZCBiZSByZWFkIGZy
b20gT1RHIHJlZ2lzdGVyIG9yIGV4dGVybmFsIGNvbm5lY3Rvci4KLSAqIElmIG9ubHkgc2luZ2xl
IHJvbGUgaXMgc3VwcG9ydGVkLCBvbmx5IG9uZSByb2xlIHN0cnVjdHVyZQotICogaXMgYWxsb2Nh
dGVkLCBjZG5zLT5yb2xlc1tDRE5TM19ST0xFX0hPU1RdIG9yIGNkbnMtPnJvbGVzW0NETlMzX1JP
TEVfR0FER0VUXS4KLSAqLwotc3RhdGljIGVudW0gY2RuczNfcm9sZXMgY2RuczNfZ2V0X2luaXRp
YWxfcm9sZShzdHJ1Y3QgY2RuczMgKmNkbnMpCi17Ci0JaWYgKGNkbnMtPnJvbGVzW0NETlMzX1JP
TEVfSE9TVF0gJiYgY2Rucy0+cm9sZXNbQ0ROUzNfUk9MRV9HQURHRVRdKSB7Ci0JCWlmIChjZG5z
M19pc19ob3N0KGNkbnMpKQotCQkJcmV0dXJuIENETlMzX1JPTEVfSE9TVDsKLQkJaWYgKGNkbnMz
X2lzX2RldmljZShjZG5zKSkKLQkJCXJldHVybiBDRE5TM19ST0xFX0dBREdFVDsKLQl9Ci0JcmV0
dXJuIGNkbnMtPnJvbGVzW0NETlMzX1JPTEVfSE9TVF0KLQkJPyBDRE5TM19ST0xFX0hPU1QKLQkJ
OiBDRE5TM19ST0xFX0dBREdFVDsKLX0KLQotc3RhdGljIHZvaWQgY2RuczNfZXhpdF9yb2xlcyhz
dHJ1Y3QgY2RuczMgKmNkbnMpCi17Ci0JY2RuczNfcm9sZV9zdG9wKGNkbnMpOwotCWNkbnMzX2Ry
ZF9leGl0KGNkbnMpOwotfQorLy8jaW5jbHVkZSAiZGVidWcuaCIKIAogLyoqCiAgKiBjZG5zM19j
b3JlX2luaXRfcm9sZSAtIGluaXRpYWxpemUgcm9sZSBvZiBvcGVyYXRpb24KQEAgLTEwNiwxNjIg
KzMxLDM3IEBAIHN0YXRpYyB2b2lkIGNkbnMzX2V4aXRfcm9sZXMoc3RydWN0IGNkbnMzICpjZG5z
KQogc3RhdGljIGludCBjZG5zM19jb3JlX2luaXRfcm9sZShzdHJ1Y3QgY2RuczMgKmNkbnMpCiB7
CiAJc3RydWN0IGRldmljZSAqZGV2ID0gY2Rucy0+ZGV2OwotCWVudW0gdXNiX2RyX21vZGUgYmVz
dF9kcl9tb2RlOwotCWVudW0gdXNiX2RyX21vZGUgZHJfbW9kZTsKKwllbnVtIHVzYl9kcl9tb2Rl
IGRyX21vZGUgPSBjZG5zLT5kcl9tb2RlOwogCWludCByZXQgPSAwOwogCi0JZHJfbW9kZSA9IHVz
Yl9nZXRfZHJfbW9kZShkZXYpOwotCWNkbnMtPnJvbGUgPSBDRE5TM19ST0xFX0VORDsKLQotCS8q
Ci0JICogSWYgZHJpdmVyIGNhbid0IHJlYWQgbW9kZSBieSBtZWFucyBvZiB1c2JfZ2V0X2RyX21k
b2UgZnVuY3Rpb24gdGhlbgotCSAqIGNob29zZXMgbW9kZSBhY2NvcmRpbmcgd2l0aCBLZXJuZWwg
Y29uZmlndXJhdGlvbi4gVGhpcyBzZXR0aW5nCi0JICogY2FuIGJlIHJlc3RyaWN0ZWQgbGF0ZXIg
ZGVwZW5kaW5nIG9uIHN0cmFwIHBpbiBjb25maWd1cmF0aW9uLgotCSAqLwotCWlmIChkcl9tb2Rl
ID09IFVTQl9EUl9NT0RFX1VOS05PV04pIHsKLQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX1VTQl9D
RE5TM19IT1NUKSAmJgotCQkgICAgSVNfRU5BQkxFRChDT05GSUdfVVNCX0NETlMzX0dBREdFVCkp
Ci0JCQlkcl9tb2RlID0gVVNCX0RSX01PREVfT1RHOwotCQllbHNlIGlmIChJU19FTkFCTEVEKENP
TkZJR19VU0JfQ0ROUzNfSE9TVCkpCi0JCQlkcl9tb2RlID0gVVNCX0RSX01PREVfSE9TVDsKLQkJ
ZWxzZSBpZiAoSVNfRU5BQkxFRChDT05GSUdfVVNCX0NETlMzX0dBREdFVCkpCi0JCQlkcl9tb2Rl
ID0gVVNCX0RSX01PREVfUEVSSVBIRVJBTDsKLQl9Ci0KLQliZXN0X2RyX21vZGUgPSBVU0JfRFJf
TU9ERV9PVEc7Ci0KLQlpZiAoZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcpIHsKLQkJYmVzdF9k
cl9tb2RlID0gY2Rucy0+ZHJfbW9kZTsKLQl9IGVsc2UgaWYgKGNkbnMtPmRyX21vZGUgPT0gVVNC
X0RSX01PREVfT1RHKSB7Ci0JCWJlc3RfZHJfbW9kZSA9IGRyX21vZGU7Ci0JfSBlbHNlIGlmIChj
ZG5zLT5kcl9tb2RlICE9IGRyX21vZGUpIHsKLQkJZGV2X2VycihkZXYsICJJbmNvcnJlY3QgRFJE
IGNvbmZpZ3VyYXRpb25cbiIpOwotCQlyZXR1cm4gLUVJTlZBTDsKLQl9Ci0KLQlkcl9tb2RlID0g
YmVzdF9kcl9tb2RlOwotCiAJaWYgKGRyX21vZGUgPT0gVVNCX0RSX01PREVfT1RHIHx8IGRyX21v
ZGUgPT0gVVNCX0RSX01PREVfSE9TVCkgewogCQlyZXQgPSBjZG5zM19ob3N0X2luaXQoY2Rucyk7
CiAJCWlmIChyZXQpIHsKLQkJCWRldl9lcnIoZGV2LCAiSG9zdCBpbml0aWFsaXphdGlvbiBmYWls
ZWQgd2l0aCAlZFxuIiwKLQkJCQlyZXQpOwotCQkJZ290byBlcnI7CisJCQlpZiAocmV0ID09IC1F
TlhJTykKKwkJCQlkZXZfZGJnKGRldiwgImRvZXNuJ3Qgc3VwcG9ydCBob3N0XG4iKTsKKwkJCWVs
c2UKKwkJCQlyZXR1cm4gcmV0OwogCQl9CiAJfQogCiAJaWYgKGRyX21vZGUgPT0gVVNCX0RSX01P
REVfT1RHIHx8IGRyX21vZGUgPT0gVVNCX0RSX01PREVfUEVSSVBIRVJBTCkgewogCQlyZXQgPSBj
ZG5zM19nYWRnZXRfaW5pdChjZG5zKTsKIAkJaWYgKHJldCkgewotCQkJZGV2X2VycihkZXYsICJE
ZXZpY2UgaW5pdGlhbGl6YXRpb24gZmFpbGVkIHdpdGggJWRcbiIsCi0JCQkJcmV0KTsKLQkJCWdv
dG8gZXJyOworCQkJaWYgKHJldCA9PSAtRU5YSU8pCisJCQkJZGV2X2RiZyhkZXYsICJkb2Vzbid0
IHN1cHBvcnQgZ2FkZ2V0XG4iKTsKKwkJCWVsc2UKKwkJCQlyZXR1cm4gcmV0OwogCQl9CiAJfQog
Ci0JY2Rucy0+ZGVzaXJlZF9kcl9tb2RlID0gZHJfbW9kZTsKLQljZG5zLT5kcl9tb2RlID0gZHJf
bW9kZTsKLQkvKgotCSAqIGRyX21vZGUgY291bGQgYmUgY2hhbmdlIHNvIERSRCBtdXN0IHVwZGF0
ZSBjb250cm9sbGVyCi0JICogY29uZmlndXJhdGlvbgotCSAqLwotCXJldCA9IGNkbnMzX2RyZF91
cGRhdGVfbW9kZShjZG5zKTsKLQotCWNkbnMtPnJvbGUgPSBjZG5zM19nZXRfaW5pdGlhbF9yb2xl
KGNkbnMpOwotCi0JcmV0ID0gY2RuczNfcm9sZV9zdGFydChjZG5zLCBjZG5zLT5yb2xlKTsKLQlp
ZiAocmV0KSB7Ci0JCWRldl9lcnIoZGV2LCAiY2FuJ3Qgc3RhcnQgJXMgcm9sZVxuIiwKLQkJCWNk
bnMzX2dldF9jdXJyZW50X3JvbGVfZHJpdmVyKGNkbnMpLT5uYW1lKTsKLQkJZ290byBlcnI7CisJ
aWYgKCFjZG5zLT5yb2xlc1tDRE5TM19ST0xFX0hPU1RdICYmICFjZG5zLT5yb2xlc1tDRE5TM19S
T0xFX0dBREdFVF0pIHsKKwkJZGV2X2VycihkZXYsICJubyBzdXBwb3J0ZWQgcm9sZXNcbiIpOwor
CQlyZXR1cm4gLUVOT0RFVjsKIAl9CiAKLQlyZXR1cm4gcmV0OwotZXJyOgotCWNkbnMzX2V4aXRf
cm9sZXMoY2Rucyk7CiAJcmV0dXJuIHJldDsKIH0KIAotLyoqCi0gKiBjZHNuM19nZXRfcmVhbF9y
b2xlIC0gZ2V0IHJlYWwgcm9sZSBvZiBjb250cm9sbGVyIGJhc2VkIG9uIGhhcmR3YXJlIHNldHRp
bmdzLgotICogQGNkbnM6IFBvaW50ZXIgdG8gY2RuczMgc3RydWN0dXJlCi0gKgotICogUmV0dXJu
cyByb2xlCi0gKi8KLWVudW0gY2RuczNfcm9sZXMgY2RzbjNfZ2V0X3JlYWxfcm9sZShzdHJ1Y3Qg
Y2RuczMgKmNkbnMpCi17Ci0JZW51bSBjZG5zM19yb2xlcyByb2xlID0gQ0ROUzNfUk9MRV9FTkQ7
Ci0KLQlpZiAoY2Rucy0+Y3VycmVudF9kcl9tb2RlID09IFVTQl9EUl9NT0RFX09URykgewotCQlp
ZiAoY2RuczNfZ2V0X2lkKGNkbnMpKQotCQkJcm9sZSA9IENETlMzX1JPTEVfR0FER0VUOwotCQll
bHNlCi0JCQlyb2xlID0gQ0ROUzNfUk9MRV9IT1NUOwotCX0gZWxzZSB7Ci0JCWlmIChjZG5zM19p
c19ob3N0KGNkbnMpKQotCQkJcm9sZSA9IENETlMzX1JPTEVfSE9TVDsKLQkJaWYgKGNkbnMzX2lz
X2RldmljZShjZG5zKSkKLQkJCXJvbGUgPSBDRE5TM19ST0xFX0dBREdFVDsKLQl9Ci0KLQlyZXR1
cm4gcm9sZTsKLX0KLQotLyoqCi0gKiBjZG5zM19yb2xlX3N3aXRjaCAtIHdvcmsgcXVldWUgaGFu
ZGxlciBmb3Igcm9sZSBzd2l0Y2gKLSAqCi0gKiBAd29yazogd29yayBxdWV1ZSBpdGVtIHN0cnVj
dHVyZQotICoKLSAqIEhhbmRsZXMgYmVsb3cgZXZlbnRzOgotICogLSBSb2xlIHN3aXRjaCBmb3Ig
ZHVhbC1yb2xlIGRldmljZXMKLSAqIC0gQ0ROUzNfUk9MRV9HQURHRVQgPC0tPiBDRE5TM19ST0xF
X0VORCBmb3IgcGVyaXBoZXJhbC1vbmx5IGRldmljZXMKLSAqLwotc3RhdGljIHZvaWQgY2RuczNf
cm9sZV9zd2l0Y2goc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQotewotCWVudW0gY2RuczNfcm9s
ZXMgcm9sZSA9IENETlMzX1JPTEVfRU5EOwotCXN0cnVjdCBjZG5zM19yb2xlX2RyaXZlciAqcm9s
ZV9kcnY7Ci0JZW51bSBjZG5zM19yb2xlcyBjdXJyZW50X3JvbGU7Ci0Jc3RydWN0IGNkbnMzICpj
ZG5zOwotCWludCByZXQgPSAwOwotCi0JY2RucyA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3Qg
Y2RuczMsIHJvbGVfc3dpdGNoX3dxKTsKLQotCS8qIER1cmluZyBzd2l0Y2hpbmcgY2Rucy0+cm9s
ZSBjYW4gYmUgZGlmZmVyZW50IHRoZW4gcm9sZSAqLwotCXJvbGUgPSBjZHNuM19nZXRfcmVhbF9y
b2xlKGNkbnMpOwotCi0Jcm9sZV9kcnYgPSBjZG5zM19nZXRfY3VycmVudF9yb2xlX2RyaXZlcihj
ZG5zKTsKLQotCXBtX3J1bnRpbWVfZ2V0X3N5bmMoY2Rucy0+ZGV2KTsKLQotCS8qIERpc2FibGUg
Y3VycmVudCByb2xlLiBUaGlzIHN0YXRlIGNhbiBiZSBmb3JjZWQgZnJvbSB1c2VyIHNwYWNlLiAq
LwotCWlmIChjZG5zLT5kZWJ1Z19kaXNhYmxlICYmIHJvbGVfZHJ2LT5zdGF0ZSA9PSBDRE5TM19S
T0xFX1NUQVRFX0FDVElWRSkgewotCQljZG5zM19yb2xlX3N0b3AoY2Rucyk7Ci0JCWdvdG8gZXhp
dDsKLQl9Ci0KLQkvKiBEbyBub3RoaW5nIGlmIG5vdGhpbmcgY2hhbmdlZCAqLwotCWlmIChjZG5z
LT5yb2xlID09IHJvbGUgJiYgcm9sZV9kcnYtPnN0YXRlID09IENETlMzX1JPTEVfU1RBVEVfQUNU
SVZFKQotCQlnb3RvIGV4aXQ7Ci0KLQljZG5zM19yb2xlX3N0b3AoY2Rucyk7Ci0KLQlyb2xlID0g
Y2RzbjNfZ2V0X3JlYWxfcm9sZShjZG5zKTsKLQotCWN1cnJlbnRfcm9sZSA9IGNkbnMtPnJvbGU7
Ci0JZGV2X2RiZyhjZG5zLT5kZXYsICJTd2l0Y2hpbmcgcm9sZSIpOwotCi0JcmV0ID0gY2RuczNf
cm9sZV9zdGFydChjZG5zLCByb2xlKTsKLQotCWlmIChyZXQpIHsKLQkJLyogQmFjayB0byBjdXJy
ZW50IHJvbGUgKi8KLQkJZGV2X2VycihjZG5zLT5kZXYsICJzZXQgJWQgaGFzIGZhaWxlZCwgYmFj
ayB0byAlZFxuIiwKLQkJCXJvbGUsIGN1cnJlbnRfcm9sZSk7Ci0JCWNkbnMzX3JvbGVfc3RhcnQo
Y2RucywgY3VycmVudF9yb2xlKTsKLQl9Ci1leGl0OgotCXBtX3J1bnRpbWVfcHV0X3N5bmMoY2Ru
cy0+ZGV2KTsKLX0KLQogLyoqCiAgKiBjZG5zM19wcm9iZSAtIHByb2JlIGZvciBjZG5zMyBjb3Jl
IGRldmljZQogICogQHBkZXY6IFBvaW50ZXIgdG8gY2RuczMgY29yZSBwbGF0Zm9ybSBkZXZpY2UK
QEAgLTI3NiwxMiArNzYsMTMgQEAgc3RhdGljIGludCBjZG5zM19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQogCXZvaWQgX19pb21lbSAqcmVnczsKIAlpbnQgcmV0OwogCisJZGV2
X2RiZyhkZXYsICIlcywgc3RhcnRcbiIsIF9fZnVuY19fKTsKIAljZG5zID0gZGV2bV9remFsbG9j
KGRldiwgc2l6ZW9mKCpjZG5zKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFjZG5zKQogCQlyZXR1cm4g
LUVOT01FTTsKIAogCWNkbnMtPmRldiA9IGRldjsKLQorCWNkbnMtPnBkYXRhID0gZGV2X2dldF9w
bGF0ZGF0YShkZXYpOwogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGNkbnMpOwogCiAJcmVz
ID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfSVJRLCAwKTsKQEAgLTMy
NiwxMSArMTI3LDExIEBAIHN0YXRpYyBpbnQgY2RuczNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikKIAkJfQogCX0KIAotCXBoeV9pbml0KGNkbnMtPnBoeSk7Ci0KLQlJTklUX1dP
UksoJmNkbnMtPnJvbGVfc3dpdGNoX3dxLCBjZG5zM19yb2xlX3N3aXRjaCk7CisJcmV0ID0gcGh5
X2luaXQoY2Rucy0+cGh5KTsKKwlpZiAocmV0KQorCQlnb3RvIGVycjA7CiAKLQlyZXQgPSBjZG5z
M19kcmRfaW5pdChjZG5zKTsKKwlyZXQgPSBjZG5zM19maW5hbGl6ZV9kcl9tb2RlKGNkbnMpOwog
CWlmIChyZXQpCiAJCWdvdG8gZXJyMTsKIApAQCAtMzM4LDIwICsxMzksMjEgQEAgc3RhdGljIGlu
dCBjZG5zM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWlmIChyZXQpCiAJ
CWdvdG8gZXJyMTsKIAotCWNkbnMzX2RlYnVnZnNfaW5pdChjZG5zKTsKLQlkZXZpY2Vfc2V0X3dh
a2V1cF9jYXBhYmxlKGRldiwgdHJ1ZSk7Ci0JcG1fcnVudGltZV9zZXRfYWN0aXZlKGRldik7Ci0J
cG1fcnVudGltZV9lbmFibGUoZGV2KTsKKwlpZiAoY2Rucy0+cm9sZXNbQ0ROUzNfUk9MRV9HQURH
RVRdKSB7CisJCXJldCA9IGNkbnMzX2RyZF9pbml0KGNkbnMpOworCQlpZiAocmV0KSB7CisJCQlk
ZXZfZXJyKGRldiwgImluaXQgb3RnIGZhaWxzLCByZXQgPSAlZFxuIiwgcmV0KTsKKwkJCWdvdG8g
ZXJyMTsKKwkJfQorCX0KIAotCS8qCi0JICogVGhlIGNvbnRyb2xsZXIgbmVlZHMgbGVzcyB0aW1l
IGJldHdlZW4gYnVzIGFuZCBjb250cm9sbGVyIHN1c3BlbmQsCi0JICogYW5kIHdlIGFsc28gbmVl
ZHMgYSBzbWFsbCBkZWxheSB0byBhdm9pZCBmcmVxdWVudGx5IGVudGVyaW5nIGxvdwotCSAqIHBv
d2VyIG1vZGUuCi0JICovCi0JcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVsYXkoZGV2LCAy
MCk7Ci0JcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeShkZXYpOwotCXBtX3J1bnRpbWVfdXNlX2F1
dG9zdXNwZW5kKGRldik7Ci0JZGV2X2RiZyhkZXYsICJDYWRlbmNlIFVTQjMgY29yZTogcHJvYmUg
c3VjY2VlZFxuIik7CisJY2Rucy0+cm9sZSA9IGNkbnMzX2dldF9yb2xlKGNkbnMpOworCXJldCA9
IGNkbnMzX3JvbGVfc3RhcnQoY2RucywgY2Rucy0+cm9sZSk7CisJaWYgKHJldCkgeworCQlkZXZf
ZXJyKGRldiwgImNhbid0IHN0YXJ0ICVzIHJvbGVcbiIsCisJCQljZG5zM19nZXRfY3VycmVudF9y
b2xlX2RyaXZlcihjZG5zKS0+bmFtZSk7CisJCWdvdG8gZXJyMTsKKwl9CiAKIAlyZXR1cm4gMDsK
IApAQCAtMzcxLDExICsxNzMsNyBAQCBzdGF0aWMgaW50IGNkbnMzX3JlbW92ZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQogewogCXN0cnVjdCBjZG5zMyAqY2RucyA9IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKHBkZXYpOwogCi0JcG1fcnVudGltZV9nZXRfc3luYygmcGRldi0+ZGV2KTsKLQlw
bV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7Ci0JcG1fcnVudGltZV9wdXRfbm9pZGxlKCZw
ZGV2LT5kZXYpOwotCWNkbnMzX2RlYnVnZnNfZXhpdChjZG5zKTsKLQljZG5zM19leGl0X3JvbGVz
KGNkbnMpOworCWNkbnMzX3JvbGVfc3RvcChjZG5zKTsKIAlwaHlfZXhpdChjZG5zLT5waHkpOwog
CXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2RuczMvY29yZS5oIGIvZHJp
dmVycy91c2IvY2RuczMvY29yZS5oCmluZGV4IGZiNGIzOTIwNjE1OC4uYTkxMzQyYjFhODY4IDEw
MDY0NAotLS0gYS9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmgKKysrIGIvZHJpdmVycy91c2IvY2Ru
czMvY29yZS5oCkBAIC00MSw2ICs0MSwxMCBAQCBzdHJ1Y3QgY2RuczNfcm9sZV9kcml2ZXIgewog
CWludCBzdGF0ZTsKIH07CiAKK3N0cnVjdCBjZG5zM19wbGF0Zm9ybV9kYXRhIHsKKwlpbnQgKCpz
ZXRfbW9kZSkgKHN0cnVjdCBjZG5zMyAqY2Rucyk7Cit9OworCiAjZGVmaW5lIENETlMzX1hIQ0lf
UkVTT1VSQ0VTX05VTQkyCiAvKioKICAqIHN0cnVjdCBjZG5zMyAtIFJlcHJlc2VudGF0aW9uIG9m
IENhZGVuY2UgVVNCMyBEUkQgY29udHJvbGxlci4KQEAgLTU2LDI4ICs2MCwxNSBAQCBzdHJ1Y3Qg
Y2RuczNfcm9sZV9kcml2ZXIgewogICogQGdhZGdldF9kZXY6IHRoZSBjaGlsZCBnYWRnZXQgZGV2
aWNlIHBvaW50ZXIgZm9yIGNkbnMzIGNvcmUKICAqIEB1c2I6IHBoeSBmb3IgdGhpcyBjb250cm9s
bGVyCiAgKiBAcm9sZV9zd2l0Y2hfd3E6IHdvcmsgcXVldWUgaXRlbSBmb3Igcm9sZSBzd2l0Y2gK
LSAqIEBpbl9scG06IHRoZSBjb250cm9sbGVyIGluIGxvdyBwb3dlciBtb2RlCi0gKiBAd2FrZXVw
X2ludDogdGhlIHdha2V1cCBpbnRlcnJ1cHQKICAqIEBtdXRleDogdGhlIG11dGV4IGZvciBjb25j
dXJyZW50IGNvZGUgYXQgZHJpdmVyCiAgKiBAZHJfbW9kZTogc3VwcG9ydGVkIG1vZGUgb2Ygb3Bl
cmF0aW9uIGl0IGNhbiBiZSBvbmx5IEhvc3QsIG9ubHkgRGV2aWNlCiAgKiAgICAgICAgICAgb3Ig
T1RHIG1vZGUgdGhhdCBhbGxvdyB0byBzd2l0Y2ggYmV0d2VlbiBEZXZpY2UgYW5kIEhvc3QgbW9k
ZS4KICAqICAgICAgICAgICBUaGlzIGZpZWxkIGJhc2VkIG9uIGZpcm13YXJlIHNldHRpbmcsIGtl
cm5lbCBjb25maWd1cmF0aW9uCiAgKiAgICAgICAgICAgYW5kIGhhcmR3YXJlIGNvbmZpZ3VyYXRp
b24uCi0gKiBAY3VycmVudF9kcl9tb2RlOiBjdXJyZW50IG1vZGUgb2Ygb3BlcmF0aW9uIHdoZW4g
aW4gZHVhbC1yb2xlIG1vZGUKLSAqIEBkZXNpcmVkX2RyX21vZGU6IGRlc2lyZWQgbW9kZSBvZiBv
cGVyYXRpb24gd2hlbiBpbiBkdWFsLXJvbGUgbW9kZS4KLSAqICAgICAgICAgICBUaGlzIHZhbHVl
IGNhbiBiZSBjaGFuZ2VkIGR1cmluZyBydW50aW1lLgotICogICAgICAgICAgIEF2YWlsYWJsZSBv
cHRpb25zIGRlcGVuZHMgb24gIGRyX21vZGU6Ci0gKiAgICAgICAgICAgZHJfbW9kZSAgICAgICAg
ICAgICAgICAgfCAgZGVzaXJlZF9kcl9tb2RlIGFuZCBjdXJyZW50X2RyX21vZGUKLSAqICAgICAg
ICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCi0gKiAgICAgICAgICAgVVNCX0RSX01PREVfSE9TVCAgICAgICAgfCBvbmx5
IFVTQl9EUl9NT0RFX0hPU1QKLSAqICAgICAgICAgICBVU0JfRFJfTU9ERV9QRVJJUEhFUkFMICB8
IG9ubHkgVVNCX0RSX01PREVfUEVSSVBIRVJBTAotICogICAgICAgICAgIFVTQl9EUl9NT0RFX09U
RyAgICAgICAgIHwgb25seSBVU0JfRFJfTU9ERV9IT1NUCi0gKiAgICAgICAgICAgVVNCX0RSX01P
REVfT1RHICAgICAgICAgfCBvbmx5IFVTQl9EUl9NT0RFX1BFUklQSEVSQUwKLSAqICAgICAgICAg
ICBVU0JfRFJfTU9ERV9PVEcgICAgICAgICB8IFVTQl9EUl9NT0RFX09URwotICoKLSAqICAgICAg
ICAgICBEZXNpcmVkX2RyX3JvbGUgY2FuIGJlIGNoYW5nZWQgYnkgbWVhbnMgb2YgZGVidWdmcy4K
ICAqIEByb290OiBkZWJ1Z2ZzIHJvb3QgZm9sZGVyIHBvaW50ZXIKICAqIEBkZWJ1Z19kaXNhYmxl
OgorICogQGV4dGNvbjogRXh0ZXJuIGNvbm5lY3RvcgorICogQGV4dGNvbl9uYjogbm90aWZpZXIg
YmxvY2sgZm9yIFR5cGUtQyBleHRlcm4gY29ubmVjdG9yCiAgKi8KIHN0cnVjdCBjZG5zMyB7CiAJ
c3RydWN0IGRldmljZQkJCSpkZXY7CkBAIC0xMDAsMTcgKzkxLDIxIEBAIHN0cnVjdCBjZG5zMyB7
CiAJc3RydWN0IGNkbnMzX2RldmljZQkJKmdhZGdldF9kZXY7CiAJc3RydWN0IHBoeQkJCSpwaHk7
CiAJc3RydWN0IHdvcmtfc3RydWN0CQlyb2xlX3N3aXRjaF93cTsKLQlpbnQJCQkJaW5fbHBtOjE7
Ci0JaW50CQkJCXdha2V1cF9pbnQ6MTsKIAkvKiBtdXRleHQgdXNlZCBpbiB3b3JrcXVldWUqLwog
CXN0cnVjdCBtdXRleAkJCW11dGV4OwogCWVudW0gdXNiX2RyX21vZGUJCWRyX21vZGU7Ci0JZW51
bSB1c2JfZHJfbW9kZQkJY3VycmVudF9kcl9tb2RlOwotCWVudW0gdXNiX2RyX21vZGUJCWRlc2ly
ZWRfZHJfbW9kZTsKIAlzdHJ1Y3QgZGVudHJ5CQkJKnJvb3Q7CiAJaW50CQkJCWRlYnVnX2Rpc2Fi
bGU6MTsKKwlzdHJ1Y3QgZXh0Y29uX2RldiAJCSpleHRjb247CisJc3RydWN0IG5vdGlmaWVyX2Js
b2NrIAkJZXh0Y29uX25iOworCXN0cnVjdCBjZG5zM19wbGF0Zm9ybV9kYXRhIAkqcGRhdGE7CiB9
OwogCi12b2lkIGNkbnMzX3JvbGVfc3RvcChzdHJ1Y3QgY2RuczMgKmNkbnMpOworc3RhdGljIGlu
bGluZSBzdHJ1Y3QgY2RuczNfcm9sZV9kcml2ZXIgKmNkbnMzX2dldF9jdXJyZW50X3JvbGVfZHJp
dmVyKAorCXN0cnVjdCBjZG5zMyAqY2RucykKK3sKKwlXQVJOX09OKGNkbnMtPnJvbGUgPj0gQ0RO
UzNfUk9MRV9FTkQgfHwgIWNkbnMtPnJvbGVzW2NkbnMtPnJvbGVdKTsKKwlyZXR1cm4gY2Rucy0+
cm9sZXNbY2Rucy0+cm9sZV07Cit9CiAKICNlbmRpZiAvKiBfX0xJTlVYX0NETlMzX0NPUkVfSCAq
LwpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2RuczMvZHJkLmMgYi9kcml2ZXJzL3VzYi9jZG5z
My9kcmQuYwppbmRleCBiMGMzMjMwMmViMGIuLjU2ZDJiNGNhMTVmOCAxMDA2NDQKLS0tIGEvZHJp
dmVycy91c2IvY2RuczMvZHJkLmMKKysrIGIvZHJpdmVycy91c2IvY2RuczMvZHJkLmMKQEAgLTQs
OTUgKzQsNTUgQEAKICAqCiAgKiBDb3B5cmlnaHQgKEMpIDIwMTggQ2FkZW5jZS4KICAqCi0gKiBB
dXRob3I6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20KKyAqIEF1dGhvcjogUGF3
ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4KICAqCiAgKi8KICNpbmNsdWRlIDxsaW51
eC9rZXJuZWwuaD4KICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KICNpbmNsdWRlIDxsaW51
eC9kZWxheS5oPgogI2luY2x1ZGUgPGxpbnV4L3VzYi9vdGcuaD4KKyNpbmNsdWRlIDxsaW51eC9l
eHRjb24uaD4KIAogI2luY2x1ZGUgImdhZGdldC5oIgotI2luY2x1ZGUgImRyZC5oIgogI2luY2x1
ZGUgImNvcmUuaCIKKyNpbmNsdWRlICJkcmQuaCIKIAotc3RhdGljIGludCBjZG5zM19kcmRfc3dp
dGNoX2dhZGdldChzdHJ1Y3QgY2RuczMgKmNkbnMsIGludCBvbik7Ci1zdGF0aWMgaW50IGNkbnMz
X2RyZF9zd2l0Y2hfaG9zdChzdHJ1Y3QgY2RuczMgKmNkbnMsIGludCBvbik7Ci0KLS8qKgotICog
Y2RuczNfc2V0X21vZGUgLSBjaGFuZ2UgbW9kZSBvZiBPVEcgQ29yZQotICogQGNkbnM6IHBvaW50
ZXIgdG8gY29udGV4dCBzdHJ1Y3R1cmUKLSAqIEBtb2RlOiBzZWxlY3RlZCBtb2RlIGZyb20gY2Ru
c19yb2xlCi0gKi8KLXZvaWQgY2RuczNfc2V0X21vZGUoc3RydWN0IGNkbnMzICpjZG5zLCBlbnVt
IHVzYl9kcl9tb2RlIG1vZGUpCitzdGF0aWMgaW50IGNkbnMzX2dldF9pZChzdHJ1Y3QgY2RuczMg
KmNkbnMpCiB7Ci0JdTMyIHJlZzsKLQotCWNkbnMtPmN1cnJlbnRfZHJfbW9kZSA9IG1vZGU7Ci0K
LQlzd2l0Y2ggKG1vZGUpIHsKLQljYXNlIFVTQl9EUl9NT0RFX1BFUklQSEVSQUw6Ci0JCWRldl9p
bmZvKGNkbnMtPmRldiwgIlNldCBjb250cm9sbGVyIHRvIEdhZGdldCBtb2RlXG4iKTsKLQkJY2Ru
czNfZHJkX3N3aXRjaF9nYWRnZXQoY2RucywgMSk7Ci0JCWJyZWFrOwotCWNhc2UgVVNCX0RSX01P
REVfSE9TVDoKLQkJZGV2X2luZm8oY2Rucy0+ZGV2LCAiU2V0IGNvbnRyb2xsZXIgdG8gSG9zdCBt
b2RlXG4iKTsKLQkJY2RuczNfZHJkX3N3aXRjaF9ob3N0KGNkbnMsIDEpOwotCQlicmVhazsKLQlj
YXNlIFVTQl9EUl9NT0RFX09URzoKLQkJZGV2X2luZm8oY2Rucy0+ZGV2LCAiU2V0IGNvbnRyb2xs
ZXIgdG8gT1RHIG1vZGVcbiIpOwotCQlpZiAoY2Rucy0+dmVyc2lvbiA9PSBDRE5TM19DT05UUk9M
TEVSX1YxKSB7Ci0JCQlyZWcgPSByZWFkbCgmY2Rucy0+b3RnX3YxX3JlZ3MtPm92ZXJyaWRlKTsK
LQkJCXJlZyB8PSBPVkVSUklERV9JRFBVTExVUDsKLQkJCXdyaXRlbChyZWcsICZjZG5zLT5vdGdf
djFfcmVncy0+b3ZlcnJpZGUpOwotCQl9IGVsc2UgewotCQkJcmVnID0gcmVhZGwoJmNkbnMtPm90
Z192MF9yZWdzLT5jdHJsMSk7Ci0JCQlyZWcgfD0gT1ZFUlJJREVfSURQVUxMVVBfVjA7Ci0JCQl3
cml0ZWwocmVnLCAmY2Rucy0+b3RnX3YwX3JlZ3MtPmN0cmwxKTsKLQkJfQotCi0JCS8qCi0JCSAq
IEhhcmR3YXJlIHNwZWNpZmljYXRpb24gc2F5czogIklEX1ZBTFVFIG11c3QgYmUgdmFsaWQgd2l0
aGluCi0JCSAqIDUwbXMgYWZ0ZXIgaWRwdWxsdXAgaXMgc2V0IHRvICcxIiBzbyBkcml2ZXIgbXVz
dCB3YWl0Ci0JCSAqIDUwbXMgYmVmb3JlIHJlYWRpbmcgdGhpcyBwaW4uCi0JCSAqLwotCQl1c2xl
ZXBfcmFuZ2UoNTAwMDAsIDYwMDAwKTsKLQkJYnJlYWs7Ci0JZGVmYXVsdDoKLQkJY2Rucy0+Y3Vy
cmVudF9kcl9tb2RlID0gVVNCX0RSX01PREVfVU5LTk9XTjsKLQkJZGV2X2VycihjZG5zLT5kZXYs
ICJVbnN1cHBvcnRlZCBtb2RlIG9mIG9wZXJhdGlvbiAlZFxuIiwgbW9kZSk7Ci0JCXJldHVybjsK
LQl9CisJcmV0dXJuICEhKHJlYWRsKCZjZG5zLT5vdGdfcmVncy0+c3RzKSAmIE9UR1NUU19JRF9W
QUxVRSk7CiB9CiAKLWludCBjZG5zM19nZXRfaWQoc3RydWN0IGNkbnMzICpjZG5zKQorc3RhdGlj
IGludCBjZG5zM19nZXRfdmJ1cyhzdHJ1Y3QgY2RuczMgKmNkbnMpCiB7Ci0JaW50IGlkOwotCi0J
aWQgPSByZWFkbCgmY2Rucy0+b3RnX3JlZ3MtPnN0cykgJiBPVEdTVFNfSURfVkFMVUU7Ci0JZGV2
X2RiZyhjZG5zLT5kZXYsICJPVEcgSUQ6ICVkIiwgaWQpOwotCXJldHVybiAgMSA7IC8vaWQ7CisJ
cmV0dXJuICEhKHJlYWRsKCZjZG5zLT5vdGdfcmVncy0+c3RzKSAmIE9UR1NUU19TRVNTSU9OX1ZB
TElEKTsKIH0KIAotaW50IGNkbnMzX2lzX2hvc3Qoc3RydWN0IGNkbnMzICpjZG5zKQorc3RhdGlj
IGludCBjZG5zM19pc19ob3N0KHN0cnVjdCBjZG5zMyAqY2RucykKIHsKLQlpZiAoY2Rucy0+Y3Vy
cmVudF9kcl9tb2RlID09IFVTQl9EUl9NT0RFX0hPU1QpCi0JCXJldHVybiAxOwotCWVsc2UgaWYg
KCFjZG5zM19nZXRfaWQoY2RucykpCisJaWYgKGNkbnMtPmV4dGNvbikgeworCQlpZiAoZXh0Y29u
X2dldF9zdGF0ZShjZG5zLT5leHRjb24sIEVYVENPTl9VU0JfSE9TVCkpCisJCQlyZXR1cm4gMTsK
KwkJZWxzZQorCQkJcmV0dXJuIDA7CisJfSBlbHNlIGlmICghY2RuczNfZ2V0X2lkKGNkbnMpKSB7
CiAJCXJldHVybiAxOwotCi0JcmV0dXJuIDA7CisJfSBlbHNlIHsKKwkJcmV0dXJuIDA7CisJfQog
fQogCi1pbnQgY2RuczNfaXNfZGV2aWNlKHN0cnVjdCBjZG5zMyAqY2RucykKK3N0YXRpYyBpbnQg
Y2RuczNfaXNfZGV2aWNlKHN0cnVjdCBjZG5zMyAqY2RucykKIHsKLQlpZiAoY2Rucy0+Y3VycmVu
dF9kcl9tb2RlID09IFVTQl9EUl9NT0RFX1BFUklQSEVSQUwpCi0JCXJldHVybiAxOwotCWVsc2Ug
aWYgKGNkbnMtPmN1cnJlbnRfZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcpCi0JCWlmIChjZG5z
M19nZXRfaWQoY2RucykpCisJaWYgKGNkbnMtPmV4dGNvbikgeworCQlpZiAoZXh0Y29uX2dldF9z
dGF0ZShjZG5zLT5leHRjb24sIEVYVENPTl9VU0IpKQogCQkJcmV0dXJuIDE7Ci0KLQlyZXR1cm4g
MDsKKwkJZWxzZQorCQkJcmV0dXJuIDA7CisJfSBlbHNlIGlmIChjZG5zM19nZXRfaWQoY2Rucykg
JiYgY2RuczNfZ2V0X3ZidXMoY2RucykpIHsKKwkJcmV0dXJuIDE7CisJfSBlbHNlIHsKKwkJcmV0
dXJuIDA7CisJfQogfQogCiAvKioKQEAgLTEwOCwxMzYgKzY4LDEwNCBAQCBzdGF0aWMgdm9pZCBj
ZG5zM19vdGdfZGlzYWJsZV9pcnEoc3RydWN0IGNkbnMzICpjZG5zKQogICogY2RuczNfb3RnX2Vu
YWJsZV9pcnEgLSBlbmFibGUgaWQgYW5kIHNlc3NfdmFsaWQgaW50ZXJydXB0cwogICogQGNkbnM6
IFBvaW50ZXIgdG8gY29udHJvbGxlciBjb250ZXh0IHN0cnVjdHVyZQogICovCi1zdGF0aWMgdm9p
ZCBjZG5zM19vdGdfZW5hYmxlX2lycShzdHJ1Y3QgY2RuczMgKmNkbnMpCitzdGF0aWMgdm9pZCBj
ZG5zM19lbmFibGVfaWRfaXJxKHN0cnVjdCBjZG5zMyAqY2RucykKIHsKLQl3cml0ZWwoT1RHSUVO
X0lEX0NIQU5HRV9JTlQgfCBPVEdJRU5fVkJVU1ZBTElEX1JJU0VfSU5UIHwKLQkgICAgICAgT1RH
SUVOX1ZCVVNWQUxJRF9GQUxMX0lOVCwgJmNkbnMtPm90Z19yZWdzLT5pZW4pOworCXdyaXRlbChP
VEdJRU5fSURfQ0hBTkdFX0lOVCwgJmNkbnMtPm90Z19yZWdzLT5pZW4pOwogfQogCi0vKioKLSAq
IGNkbnMzX2RyZF9zd2l0Y2hfaG9zdCAtIHN0YXJ0L3N0b3AgaG9zdAotICogQGNkbnM6IFBvaW50
ZXIgdG8gY29udHJvbGxlciBjb250ZXh0IHN0cnVjdHVyZQotICogQG9uOiAxIGZvciBzdGFydCwg
MCBmb3Igc3RvcAotICoKLSAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG90aGVyd2lzZSBuZWdhdGl2
ZSBlcnJubwotICovCi1zdGF0aWMgaW50IGNkbnMzX2RyZF9zd2l0Y2hfaG9zdChzdHJ1Y3QgY2Ru
czMgKmNkbnMsIGludCBvbikKK3N0YXRpYyB2b2lkIGNkbnMzX2VuYWJsZV92YnVzX2lycShzdHJ1
Y3QgY2RuczMgKmNkbnMsIGJvb2wgb24pCiB7Ci0JaW50IHJldDsKLQl1MzIgcmVnID0gT1RHQ01E
X09UR19ESVM7Ci0KLQkvKiBzd2l0Y2ggT1RHIGNvcmUgKi8KLQlpZiAob24pIHsKLQkJd3JpdGVs
KE9UR0NNRF9IT1NUX0JVU19SRVEgfCByZWcsICZjZG5zLT5vdGdfcmVncy0+Y21kKTsKLQotCQlk
ZXZfZGJnKGNkbnMtPmRldiwgIldhaXRpbmcgZm9yIEhvc3QgbW9kZSBpcyB0dXJuZWQgb25cbiIp
OwotCQlyZXQgPSBjZG5zM19oYW5kc2hha2UoJmNkbnMtPm90Z19yZWdzLT5zdHMsIE9UR1NUU19Y
SENJX1JFQURZLAotCQkJCSAgICAgIE9UR1NUU19YSENJX1JFQURZLCAxMDAwMDApOworCXUzMiB2
YWx1ZSA9IHJlYWRsKCZjZG5zLT5vdGdfcmVncy0+aWVuKTsKKwl1MzIgdmJ1cyA9IChPVEdJRU5f
VkJVU1NFU1NfUklTRV9JTlQgfCBPVEdJRU5fVkJVU1NFU1NfRkFMTF9JTlQpOwogCi0JCWlmIChy
ZXQpCi0JCQlyZXR1cm4gcmV0OwotCX0gZWxzZSB7Ci0JCXVzbGVlcF9yYW5nZSgzMCwgNDApOwot
CQl3cml0ZWwoT1RHQ01EX0hPU1RfQlVTX0RST1AgfCBPVEdDTURfREVWX0JVU19EUk9QIHwKLQkJ
ICAgICAgIE9UR0NNRF9ERVZfUE9XRVJfT0ZGIHwgT1RHQ01EX0hPU1RfUE9XRVJfT0ZGLAotCQkg
ICAgICAgJmNkbnMtPm90Z19yZWdzLT5jbWQpOwotCX0KKwlpZiAob24pCisJCXdyaXRlbCh2YWx1
ZSB8IHZidXMsICZjZG5zLT5vdGdfcmVncy0+aWVuKTsKKwllbHNlCisJCXdyaXRlbCh2YnVzICYg
fnZidXMsICZjZG5zLT5vdGdfcmVncy0+aWVuKTsKK30KIAotCXJldHVybiAwOworc3RhdGljIHZv
aWQgY2RuczNfZHJkX3N3aXRjaF9vZmYoc3RydWN0IGNkbnMzICpjZG5zKQoreworCS8qCisJICog
ZHJpdmVyIHNob3VsZCB3YWl0IGF0IGxlYXN0IDEwdXMgYWZ0ZXIgZGlzYWJsaW5nIERldmljZQor
CSAqIGJlZm9yZSB0dXJuaW5nLW9mZiBEZXZpY2UgKERFVl9CVVNfRFJPUCkKKwkgKi8KKwl1c2xl
ZXBfcmFuZ2UoMzAsIDQwKTsKKwl3cml0ZWwoT1RHQ01EX0hPU1RfQlVTX0RST1AgfCBPVEdDTURf
REVWX0JVU19EUk9QIHwKKwkgICAgICAgT1RHQ01EX0RFVl9QT1dFUl9PRkYgfCBPVEdDTURfSE9T
VF9QT1dFUl9PRkYsCisJICAgICAgICZjZG5zLT5vdGdfcmVncy0+Y21kKTsKKwl1c2xlZXBfcmFu
Z2UoMzAwMCwgNDAwMCk7CiB9CiAKLS8qKgotICogY2RuczNfZHJkX3N3aXRjaF9nYWRnZXQgLSBz
dGFydC9zdG9wIGdhZGdldAotICogQGNkbnM6IFBvaW50ZXIgdG8gY29udHJvbGxlciBjb250ZXh0
IHN0cnVjdHVyZQotICogQG9uOiAxIGZvciBzdGFydCwgMCBmb3Igc3RvcAotICoKLSAqIFJldHVy
bnMgMCBvbiBzdWNjZXNzIG90aGVyd2lzZSBuZWdhdGl2ZSBlcnJubwotICovCi1zdGF0aWMgaW50
IGNkbnMzX2RyZF9zd2l0Y2hfZ2FkZ2V0KHN0cnVjdCBjZG5zMyAqY2RucywgaW50IG9uKQorc3Rh
dGljIGludCBjZG5zM19kcmRfc3dpdGNoX29uKHN0cnVjdCBjZG5zMyAqY2RucykKIHsKLQlpbnQg
cmV0OwotCXUzMiByZWcgPSBPVEdDTURfT1RHX0RJUzsKKwlpbnQgcmV0ID0gMDsKKworCWlmIChj
ZG5zLT5yb2xlID09IENETlMzX1JPTEVfR0FER0VUKSB7CisJCWlmIChjZG5zLT5wZGF0YSAmJiBj
ZG5zLT5wZGF0YS0+c2V0X21vZGUpCisJCQljZG5zLT5wZGF0YS0+c2V0X21vZGUoY2Rucyk7CiAK
LQkvKiBzd2l0Y2ggT1RHIGNvcmUgKi8KLQlpZiAob24pIHsKLQkJd3JpdGVsKE9UR0NNRF9ERVZf
QlVTX1JFUSB8IHJlZywgJmNkbnMtPm90Z19yZWdzLT5jbWQpOworCQl3cml0ZWwoT1RHQ01EX0RF
Vl9CVVNfUkVRIHwgT1RHQ01EX09UR19ESVMsCisJCQkmY2Rucy0+b3RnX3JlZ3MtPmNtZCk7CiAK
IAkJZGV2X2RiZyhjZG5zLT5kZXYsICJXYWl0aW5nIGZvciBEZXZpY2UgbW9kZSBpcyB0dXJuZWQg
b25cbiIpOwogCiAJCXJldCA9IGNkbnMzX2hhbmRzaGFrZSgmY2Rucy0+b3RnX3JlZ3MtPnN0cywg
T1RHU1RTX0RFVl9SRUFEWSwKIAkJCQkgICAgICBPVEdTVFNfREVWX1JFQURZLCAxMDAwMDApOwor
CQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwl9IGVsc2UgaWYgKGNkbnMtPnJvbGUgPT0gQ0RO
UzNfUk9MRV9IT1NUKSB7CisJCWlmIChjZG5zLT5wZGF0YSAmJiBjZG5zLT5wZGF0YS0+c2V0X21v
ZGUpCisJCQljZG5zLT5wZGF0YS0+c2V0X21vZGUoY2Rucyk7CisKKwkJd3JpdGVsKE9UR0NNRF9I
T1NUX0JVU19SRVEgfCBPVEdDTURfT1RHX0RJUywgJmNkbnMtPm90Z19yZWdzLT5jbWQpOwogCisJ
CXJldCA9IGNkbnMzX2hhbmRzaGFrZSgmY2Rucy0+b3RnX3JlZ3MtPnN0cywgT1RHU1RTX1hIQ0lf
UkVBRFksCisJCQkJICAgICAgT1RHU1RTX1hIQ0lfUkVBRFksIDEwMDAwMCk7CisJCWRldl9kYmco
Y2Rucy0+ZGV2LCAiV2FpdGluZyBmb3IgSG9zdCBtb2RlIGlzIHR1cm5lZCBvbiwgcmV0PSVkXG4i
LCByZXQpOwogCQlpZiAocmV0KQogCQkJcmV0dXJuIHJldDsKIAl9IGVsc2UgewotCQkvKgotCQkg
KiBkcml2ZXIgc2hvdWxkIHdhaXQgYXQgbGVhc3QgMTB1cyBhZnRlciBkaXNhYmxpbmcgRGV2aWNl
Ci0JCSAqIGJlZm9yZSB0dXJuaW5nLW9mZiBEZXZpY2UgKERFVl9CVVNfRFJPUCkKLQkJICovCi0J
CXVzbGVlcF9yYW5nZSgyMCwgMzApOwotCQl3cml0ZWwoT1RHQ01EX0hPU1RfQlVTX0RST1AgfCBP
VEdDTURfREVWX0JVU19EUk9QIHwKLQkJICAgICAgIE9UR0NNRF9ERVZfUE9XRVJfT0ZGIHwgT1RH
Q01EX0hPU1RfUE9XRVJfT0ZGLAotCQkgICAgICAgJmNkbnMtPm90Z19yZWdzLT5jbWQpOworCQlp
ZiAoY2Rucy0+cGRhdGEgJiYgY2Rucy0+cGRhdGEtPnNldF9tb2RlKQorCQkJY2Rucy0+cGRhdGEt
PnNldF9tb2RlKGNkbnMpOwogCX0KIAotCXJldHVybiAwOworCXJldHVybiByZXQ7CiB9CiAKIC8q
KgogICogY2RuczNfaW5pdF9vdGdfbW9kZSAtIGluaXRpYWxpemUgZHJkIGNvbnRyb2xsZXIKICAq
IEBjZG5zOiBQb2ludGVyIHRvIGNvbnRyb2xsZXIgY29udGV4dCBzdHJ1Y3R1cmUKICAqCi0gKiBS
ZXR1cm5zIDAgb24gc3VjY2VzcyBvdGhlcndpc2UgbmVnYXRpdmUgZXJybm8KICAqLwogc3RhdGlj
IHZvaWQgY2RuczNfaW5pdF9vdGdfbW9kZShzdHJ1Y3QgY2RuczMgKmNkbnMpCiB7CisJdTMyIHJl
ZzsKKwogCWNkbnMzX290Z19kaXNhYmxlX2lycShjZG5zKTsKIAkvKiBjbGVhciBhbGwgaW50ZXJy
dXB0cyAqLwogCXdyaXRlbCh+MCwgJmNkbnMtPm90Z19yZWdzLT5pdmVjdCk7CiAKLQljZG5zM19z
ZXRfbW9kZShjZG5zLCBVU0JfRFJfTU9ERV9PVEcpOwotCi0JaWYgKGNkbnMzX2lzX2hvc3QoY2Ru
cykpCi0JCWNkbnMzX2RyZF9zd2l0Y2hfaG9zdChjZG5zLCAxKTsKLQllbHNlCi0JCWNkbnMzX2Ry
ZF9zd2l0Y2hfZ2FkZ2V0KGNkbnMsIDEpOwotCi0JY2RuczNfb3RnX2VuYWJsZV9pcnEoY2Rucyk7
Ci19CisJY2RuczNfZW5hYmxlX2lkX2lycShjZG5zKTsKKwlpZiAoY2RuczNfZ2V0X2lkKGNkbnMp
ID09IDApCisJCWNkbnMzX2VuYWJsZV92YnVzX2lycShjZG5zLCB0cnVlKTsKIAotLyoqCi0gKiBj
ZG5zM19kcmRfdXBkYXRlX21vZGUgLSBpbml0aWFsaXplIG1vZGUgb2Ygb3BlcmF0aW9uCi0gKiBA
Y2RuczogUG9pbnRlciB0byBjb250cm9sbGVyIGNvbnRleHQgc3RydWN0dXJlCi0gKgotICogUmV0
dXJucyAwIG9uIHN1Y2Nlc3Mgb3RoZXJ3aXNlIG5lZ2F0aXZlIGVycm5vCi0gKi8KLWludCBjZG5z
M19kcmRfdXBkYXRlX21vZGUoc3RydWN0IGNkbnMzICpjZG5zKQotewotCWludCByZXQgPSAwOwot
Ci0JaWYgKGNkbnMtPmRlc2lyZWRfZHJfbW9kZSA9PSBjZG5zLT5jdXJyZW50X2RyX21vZGUpCi0J
CXJldHVybiByZXQ7Ci0KLQljZG5zM19kcmRfc3dpdGNoX2dhZGdldChjZG5zLCAwKTsKLQljZG5z
M19kcmRfc3dpdGNoX2hvc3QoY2RucywgMCk7Ci0KLQlzd2l0Y2ggKGNkbnMtPmRlc2lyZWRfZHJf
bW9kZSkgewotCWNhc2UgVVNCX0RSX01PREVfUEVSSVBIRVJBTDoKLQkJY2RuczNfc2V0X21vZGUo
Y2RucywgVVNCX0RSX01PREVfUEVSSVBIRVJBTCk7Ci0JCWJyZWFrOwotCWNhc2UgVVNCX0RSX01P
REVfSE9TVDoKLQkJY2RuczNfc2V0X21vZGUoY2RucywgVVNCX0RSX01PREVfSE9TVCk7Ci0JCWJy
ZWFrOwotCWNhc2UgVVNCX0RSX01PREVfT1RHOgotCQljZG5zM19pbml0X290Z19tb2RlKGNkbnMp
OwotCQlicmVhazsKLQlkZWZhdWx0OgotCQlkZXZfZXJyKGNkbnMtPmRldiwgIlVuc3VwcG9ydGVk
IG1vZGUgb2Ygb3BlcmF0aW9uICVkXG4iLAotCQkJY2Rucy0+ZHJfbW9kZSk7Ci0JCXJldHVybiAt
RUlOVkFMOworCWlmIChjZG5zLT52ZXJzaW9uID09IENETlMzX0NPTlRST0xMRVJfVjEpIHsKKwkJ
cmVnID0gcmVhZGwoJmNkbnMtPm90Z192MV9yZWdzLT5vdmVycmlkZSk7CisJCXJlZyB8PSBPVkVS
UklERV9JRFBVTExVUDsKKwkJd3JpdGVsKHJlZywgJmNkbnMtPm90Z192MV9yZWdzLT5vdmVycmlk
ZSk7CisJfSBlbHNlIHsKKwkJcmVnID0gcmVhZGwoJmNkbnMtPm90Z192MF9yZWdzLT5jdHJsMSk7
CisJCXJlZyB8PSBPVkVSUklERV9JRFBVTExVUF9WMDsKKwkJd3JpdGVsKHJlZywgJmNkbnMtPm90
Z192MF9yZWdzLT5jdHJsMSk7CiAJfQogCi0JcmV0dXJuIHJldDsKKwkvKgorCSAqIEhhcmR3YXJl
IHNwZWNpZmljYXRpb24gc2F5czogIklEX1ZBTFVFIG11c3QgYmUgdmFsaWQgd2l0aGluCisJICog
NTBtcyBhZnRlciBpZHB1bGx1cCBpcyBzZXQgdG8gJzEiIHNvIGRyaXZlciBtdXN0IHdhaXQKKwkg
KiA1MG1zIGJlZm9yZSByZWFkaW5nIHRoaXMgcGluLgorCSAqLworCXVzbGVlcF9yYW5nZSg1MDAw
MCwgNjAwMDApOwogfQogCiAvKioKQEAgLTI1Myw4ICsxODEsOSBAQCBzdGF0aWMgaXJxcmV0dXJu
X3QgY2RuczNfZHJkX2lycShpbnQgaXJxLCB2b2lkICpkYXRhKQogCWlycXJldHVybl90IHJldCA9
IElSUV9OT05FOwogCXN0cnVjdCBjZG5zMyAqY2RucyA9IGRhdGE7CiAJdTMyIHJlZzsKKwlib29s
IHZidXM7CiAKLQlpZiAoY2Rucy0+ZHJfbW9kZSAhPSBVU0JfRFJfTU9ERV9PVEcpCisJaWYgKGNk
bnMtPmRyX21vZGUgPT0gVVNCX0RSX01PREVfSE9TVCkKIAkJcmV0dXJuIHJldDsKIAogCXJlZyA9
IHJlYWRsKCZjZG5zLT5vdGdfcmVncy0+aXZlY3QpOwpAQCAtMjY2LDIwICsxOTUsNzIgQEAgc3Rh
dGljIGlycXJldHVybl90IGNkbnMzX2RyZF9pcnEoaW50IGlycSwgdm9pZCAqZGF0YSkKIAkJZGV2
X2RiZyhjZG5zLT5kZXYsICJPVEcgSVJROiBuZXcgSUQ6ICVkXG4iLAogCQkJY2RuczNfZ2V0X2lk
KGNkbnMpKTsKIAorCQl3cml0ZWwoT1RHSUVOX0lEX0NIQU5HRV9JTlQsICZjZG5zLT5vdGdfcmVn
cy0+aXZlY3QpOwogCQlxdWV1ZV93b3JrKHN5c3RlbV9mcmVlemFibGVfd3EsICZjZG5zLT5yb2xl
X3N3aXRjaF93cSk7CiAKIAkJcmV0ID0gSVJRX0hBTkRMRUQ7CiAJfQogCi0Jd3JpdGVsKH4wLCAm
Y2Rucy0+b3RnX3JlZ3MtPml2ZWN0KTsKKwlpZiAoKHJlZyAmIE9UR0lFTl9WQlVTU0VTU19SSVNF
X0lOVCkKKwkJfHwgKHJlZyAmIE9UR0lFTl9WQlVTU0VTU19GQUxMX0lOVCkpIHsKKwkJdTMyIHZi
dXNfc3RhdHVzOworCQl2YnVzID0gY2RuczNfZ2V0X3ZidXMoY2Rucyk7CisJCWRldl9kYmcoY2Ru
cy0+ZGV2LCAiT1RHIElSUTogVkJVUyA6ICVkXG4iLCB2YnVzKTsKKwkJdmJ1c19zdGF0dXMgPSB2
YnVzID8gT1RHSUVOX1ZCVVNTRVNTX1JJU0VfSU5UCisJCQk6IE9UR0lFTl9WQlVTU0VTU19GQUxM
X0lOVDsKKwkJd3JpdGVsKHZidXNfc3RhdHVzLCAmY2Rucy0+b3RnX3JlZ3MtPml2ZWN0KTsKKwkJ
cXVldWVfd29yayhzeXN0ZW1fZnJlZXphYmxlX3dxLCAmY2Rucy0+cm9sZV9zd2l0Y2hfd3EpOwor
CQlyZXQgPSBJUlFfSEFORExFRDsKKwl9CisKIAlyZXR1cm4gcmV0OwogfQogCi1pbnQgY2RuczNf
ZHJkX2luaXQoc3RydWN0IGNkbnMzICpjZG5zKQorc3RhdGljIGludCBjZG5zM19leHRjb25fbm90
aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwgdW5zaWduZWQgbG9uZyBldmVudCwKKwkJ
CSAgICAgdm9pZCAqcHRyKQoreworCXN0cnVjdCBjZG5zMyAqY2RucyA9IGNvbnRhaW5lcl9vZihu
Yiwgc3RydWN0IGNkbnMzLCBleHRjb25fbmIpOworCisJcXVldWVfd29yayhzeXN0ZW1fZnJlZXph
YmxlX3dxLCAmY2Rucy0+cm9sZV9zd2l0Y2hfd3EpOworCisJcmV0dXJuIE5PVElGWV9ET05FOwor
fQorCitzdGF0aWMgaW50IGNkbnMzX3JlZ2lzdGVyX2V4dGNvbihzdHJ1Y3QgY2RuczMgKmNkbnMp
Cit7CisJc3RydWN0IGV4dGNvbl9kZXYgKmV4dGNvbjsKKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBj
ZG5zLT5kZXY7CisJaW50IHJldDsKKworCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LT5v
Zl9ub2RlLCAiZXh0Y29uIikpIHsKKwkJZXh0Y29uID0gZXh0Y29uX2dldF9lZGV2X2J5X3BoYW5k
bGUoZGV2LCAwKTsKKwkJaWYgKElTX0VSUihleHRjb24pKQorCQkJcmV0dXJuIFBUUl9FUlIoZXh0
Y29uKTsKKworCQlyZXQgPSBkZXZtX2V4dGNvbl9yZWdpc3Rlcl9ub3RpZmllcihkZXYsIGV4dGNv
biwKKwkJCUVYVENPTl9VU0JfSE9TVCwgJmNkbnMtPmV4dGNvbl9uYik7CisJCWlmIChyZXQgPCAw
KSB7CisJCQlkZXZfZXJyKGRldiwgInJlZ2lzdGVyIEhvc3QgQ29ubmVjdG9yIGZhaWxlZFxuIik7
CisJCQlyZXR1cm4gcmV0OworCQl9CisKKwkJcmV0ID0gZGV2bV9leHRjb25fcmVnaXN0ZXJfbm90
aWZpZXIoZGV2LCBleHRjb24sCisJCQlFWFRDT05fVVNCLCAmY2Rucy0+ZXh0Y29uX25iKTsKKwkJ
aWYgKHJldCA8IDApIHsKKwkJCWRldl9lcnIoZGV2LCAicmVnaXN0ZXIgRGV2aWNlIENvbm5lY3Rv
ciBmYWlsZWRcbiIpOworCQkJcmV0dXJuIHJldDsKKwkJfQorCisJCWNkbnMtPmV4dGNvbiA9IGV4
dGNvbjsKKwkJY2Rucy0+ZXh0Y29uX25iLm5vdGlmaWVyX2NhbGwgPSBjZG5zM19leHRjb25fbm90
aWZpZXI7CisJfQorCisJcmV0dXJuIDA7Cit9CisKK2ludCBjZG5zM19maW5hbGl6ZV9kcl9tb2Rl
KHN0cnVjdCBjZG5zMyAqY2RucykKIHsKIAl2b2lkIF9faW9tZW0gKnJlZ3M7Ci0JaW50IHJldCA9
IDA7Ci0JdTMyIHN0YXRlOwogCiAJcmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShjZG5zLT5k
ZXYsICZjZG5zLT5vdGdfcmVzKTsKIAlpZiAoSVNfRVJSKHJlZ3MpKQpAQCAtMjk5LDYgKzI4MCw3
IEBAIGludCBjZG5zM19kcmRfaW5pdChzdHJ1Y3QgY2RuczMgKmNkbnMpCiAJCWNkbnMtPnZlcnNp
b24gID0gQ0ROUzNfQ09OVFJPTExFUl9WMDsKIAkJY2Rucy0+b3RnX3YxX3JlZ3MgPSBOVUxMOwog
CQljZG5zLT5vdGdfcmVncyA9IHJlZ3M7CisJCXdyaXRlbCgweDEsICZjZG5zLT5vdGdfdjBfcmVn
cy0+c2ltdWxhdGUpOwogCQlkZXZfaW5mbyhjZG5zLT5kZXYsICJEUkQgdmVyc2lvbiB2MCAoJTA4
eClcbiIsCiAJCQkgcmVhZGwoJmNkbnMtPm90Z192MF9yZWdzLT52ZXJzaW9uKSk7CiAJfSBlbHNl
IHsKQEAgLTMxMSwyNyArMjkzLDg3IEBAIGludCBjZG5zM19kcmRfaW5pdChzdHJ1Y3QgY2RuczMg
KmNkbnMpCiAJCQkgcmVhZGwoJmNkbnMtPm90Z192MV9yZWdzLT5yaWQpKTsKIAl9CiAKLQlzdGF0
ZSA9IE9UR1NUU19TVFJBUChyZWFkbCgmY2Rucy0+b3RnX3JlZ3MtPnN0cykpOworCWNkbnMtPmRy
X21vZGUgPSB1c2JfZ2V0X2RyX21vZGUoY2Rucy0+ZGV2KTsKKwlpZiAoY2Rucy0+ZHJfbW9kZSA9
PSBVU0JfRFJfTU9ERV9VTktOT1dOKQorCQljZG5zLT5kcl9tb2RlID0gVVNCX0RSX01PREVfT1RH
OwogCi0JLyogVXBkYXRlIGRyX21vZGUgYWNjb3JkaW5nIHRvIFNUUkFQIGNvbmZpZ3VyYXRpb24u
ICovCi0JY2Rucy0+ZHJfbW9kZSA9IFVTQl9EUl9NT0RFX09URzsKLQlpZiAoc3RhdGUgPT0gT1RH
U1RTX1NUUkFQX0hPU1QpIHsKLQkJZGV2X2luZm8oY2Rucy0+ZGV2LCAiQ29udHJvbGxlciBzdHJh
cHBlZCB0byBIT1NUXG4iKTsKLQkJY2Rucy0+ZHJfbW9kZSA9IFVTQl9EUl9NT0RFX0hPU1Q7Ci0J
fSBlbHNlIGlmIChzdGF0ZSA9PSBPVEdTVFNfU1RSQVBfR0FER0VUKSB7Ci0JCWRldl9pbmZvKGNk
bnMtPmRldiwgIkNvbnRyb2xsZXIgc3RyYXBwZWQgdG8gUEVSSVBIRVJBTFxuIik7Ci0JCWNkbnMt
PmRyX21vZGUgPSBVU0JfRFJfTU9ERV9QRVJJUEhFUkFMOworCXJldHVybiAwOworfQorCitzdGF0
aWMgaW50IGNkbnMzX2RvX3JvbGVfc3dpdGNoKHN0cnVjdCBjZG5zMyAqY2RucywgZW51bSBjZG5z
M19yb2xlcyByb2xlKQoreworCWludCByZXQgPSAwOworCWVudW0gY2RuczNfcm9sZXMgY3VycmVu
dF9yb2xlOworCisJZGV2X2RiZyhjZG5zLT5kZXYsICJjdXJyZW50IHJvbGUgaXMgJWQsIHN3aXRj
aCB0byAlZFxuIiwKKwkJCWNkbnMtPnJvbGUsIHJvbGUpOworCisJaWYgKGNkbnMtPnJvbGUgPT0g
cm9sZSkKKwkJcmV0dXJuIDA7CisKKwljdXJyZW50X3JvbGUgPSBjZG5zLT5yb2xlOworCWNkbnMz
X3JvbGVfc3RvcChjZG5zKTsKKwkvKgorCSAqIC0gRW5hYmxlIHZidXMgaW50ZXJydXB0IGFmdGVy
IGxlYXZpbmcgaG9zdAorCSAqIC0gRGlzYWJsZSB2YnVzIGludGVycnVwdCBiZWZvcmUgZW50ZXJp
bmcgaG9zdAorCSAqLworCisJaWYgKGN1cnJlbnRfcm9sZSA9PSBDRE5TM19ST0xFX0hPU1QpCisJ
CWNkbnMzX2VuYWJsZV92YnVzX2lycShjZG5zLCB0cnVlKTsKKwllbHNlIGlmIChyb2xlID09IENE
TlMzX1JPTEVfSE9TVCkKKwkJY2RuczNfZW5hYmxlX3ZidXNfaXJxKGNkbnMsIGZhbHNlKTsKKwlp
ZiAocm9sZSA9PSBDRE5TM19ST0xFX0VORCkgeworCQkvKiBUT0RPOiBGb3JjZSBCIFNlc3Npb24g
VmFsaWQgYXMgMCAqLworCQlyZXR1cm4gMDsKIAl9CiAKLQljZG5zLT5kZXNpcmVkX2RyX21vZGUg
PSBjZG5zLT5kcl9tb2RlOwotCWNkbnMtPmN1cnJlbnRfZHJfbW9kZSA9IFVTQl9EUl9NT0RFX1VO
S05PV047CisJcmV0ID0gY2RuczNfcm9sZV9zdGFydChjZG5zLCByb2xlKTsKKwlpZiAocmV0KSB7
CisJCS8qIEJhY2sgdG8gY3VycmVudCByb2xlICovCisJCWRldl9lcnIoY2Rucy0+ZGV2LCAic2V0
ICVkIGhhcyBmYWlsZWQsIGJhY2sgdG8gJWRcbiIsCisJCQkJCXJvbGUsIGN1cnJlbnRfcm9sZSk7
CisJCWlmIChyb2xlID09IENETlMzX1JPTEVfSE9TVCkKKwkJCWNkbnMzX2VuYWJsZV92YnVzX2ly
cShjZG5zLCB0cnVlKTsKKwkJcmV0ID0gY2RuczNfcm9sZV9zdGFydChjZG5zLCBjdXJyZW50X3Jv
bGUpOworCX0KIAotCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoY2Rucy0+ZGV2LCBj
ZG5zLT5pcnEsIGNkbnMzX2RyZF9pcnEsCi0JCQkJCU5VTEwsIElSUUZfU0hBUkVELAotCQkJCQlk
ZXZfbmFtZShjZG5zLT5kZXYpLCBjZG5zKTsKKwlyZXR1cm4gcmV0OworfQogCi0JaWYgKHJldCkK
LQkJcmV0dXJuIHJldDsKKy8qKgorICogY2RuczNfcm9sZV9zd2l0Y2ggLSB3b3JrIHF1ZXVlIGhh
bmRsZXIgZm9yIHJvbGUgc3dpdGNoCisgKgorICogQHdvcms6IHdvcmsgcXVldWUgaXRlbSBzdHJ1
Y3R1cmUKKyAqCisgKiBIYW5kbGVzIGJlbG93IGV2ZW50czoKKyAqIC0gUm9sZSBzd2l0Y2ggZm9y
IGR1YWwtcm9sZSBkZXZpY2VzCisgKiAtIENETlMzX1JPTEVfR0FER0VUIDwtLT4gQ0ROUzNfUk9M
RV9FTkQgZm9yIHBlcmlwaGVyYWwtb25seSBkZXZpY2VzCisgKi8KK3N0YXRpYyB2b2lkIGNkbnMz
X3JvbGVfc3dpdGNoKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKK3sKKwlzdHJ1Y3QgY2RuczMg
KmNkbnMgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGNkbnMzLAorCQkJcm9sZV9zd2l0Y2hf
d3EpOworCWJvb2wgZGV2aWNlLCBob3N0OworCisJaG9zdCA9IGNkbnMzX2lzX2hvc3QoY2Rucyk7
CisJZGV2aWNlID0gY2RuczNfaXNfZGV2aWNlKGNkbnMpOworCisJaWYgKGhvc3QpIHsKKwkJaWYg
KGNkbnMtPnJvbGVzW0NETlMzX1JPTEVfSE9TVF0pCisJCQljZG5zM19kb19yb2xlX3N3aXRjaChj
ZG5zLCBDRE5TM19ST0xFX0hPU1QpOworCQlyZXR1cm47CisJfQorCisJaWYgKGRldmljZSkKKwkJ
Y2RuczNfZG9fcm9sZV9zd2l0Y2goY2RucywgQ0ROUzNfUk9MRV9HQURHRVQpOworCWVsc2UKKwkJ
Y2RuczNfZG9fcm9sZV9zd2l0Y2goY2RucywgQ0ROUzNfUk9MRV9FTkQpOworfQorCitpbnQgY2Ru
czNfZHJkX2luaXQoc3RydWN0IGNkbnMzICpjZG5zKQoreworCWludCByZXQ7CisJdTMyIHN0YXRl
OwogCiAJc3RhdGUgPSByZWFkbCgmY2Rucy0+b3RnX3JlZ3MtPnN0cyk7CiAJaWYgKE9UR1NUU19P
VEdfTlJEWShzdGF0ZSkgIT0gMCkgewpAQCAtMzM5LDEyICszODEsODIgQEAgaW50IGNkbnMzX2Ry
ZF9pbml0KHN0cnVjdCBjZG5zMyAqY2RucykKIAkJcmV0dXJuIC1FTk9ERVY7CiAJfQogCi0JcmV0
ID0gY2RuczNfZHJkX3VwZGF0ZV9tb2RlKGNkbnMpOworCUlOSVRfV09SSygmY2Rucy0+cm9sZV9z
d2l0Y2hfd3EsIGNkbnMzX3JvbGVfc3dpdGNoKTsKKwlyZXQgPSBjZG5zM19yZWdpc3Rlcl9leHRj
b24oY2Rucyk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCWNkbnMzX2luaXRfb3RnX21v
ZGUoY2Rucyk7CisKKwlyZXR1cm4gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShjZG5zLT5kZXYs
IGNkbnMtPmlycSwgY2RuczNfZHJkX2lycSwKKwkJCQkJTlVMTCwgSVJRRl9TSEFSRUQsCisJCQkJ
CWRldl9uYW1lKGNkbnMtPmRldiksIGNkbnMpOworfQorCitpbnQgY2RuczNfcm9sZV9zdGFydChz
dHJ1Y3QgY2RuczMgKmNkbnMsIGVudW0gY2RuczNfcm9sZXMgcm9sZSkKK3sKKwlpbnQgcmV0Owor
CisJaWYgKHJvbGUgPj0gQ0ROUzNfUk9MRV9FTkQpIHsKKwkJV0FSTl9PTihyb2xlID4gQ0ROUzNf
Uk9MRV9FTkQpOworCQlyZXR1cm4gMDsKKwl9CisKKwlpZiAoIWNkbnMtPnJvbGVzW3JvbGVdKQor
CQlyZXR1cm4gLUVOWElPOworCisJaWYgKGNkbnMtPnJvbGVzW3JvbGVdLT5zdGF0ZSA9PSBDRE5T
M19ST0xFX1NUQVRFX0FDVElWRSkKKwkJcmV0dXJuIDA7CiAKKwltdXRleF9sb2NrKCZjZG5zLT5t
dXRleCk7CisJY2Rucy0+cm9sZSA9IHJvbGU7CisJY2RuczNfZHJkX3N3aXRjaF9vbihjZG5zKTsK
KwlyZXQgPSBjZG5zLT5yb2xlc1tyb2xlXS0+c3RhcnQoY2Rucyk7CisJaWYgKCFyZXQpCisJCWNk
bnMtPnJvbGVzW3JvbGVdLT5zdGF0ZSA9IENETlMzX1JPTEVfU1RBVEVfQUNUSVZFOworCW11dGV4
X3VubG9jaygmY2Rucy0+bXV0ZXgpOwogCXJldHVybiByZXQ7CiB9CiAKLWludCBjZG5zM19kcmRf
ZXhpdChzdHJ1Y3QgY2RuczMgKmNkbnMpCit2b2lkIGNkbnMzX3JvbGVfc3RvcChzdHJ1Y3QgY2Ru
czMgKmNkbnMpCit7CisJZW51bSBjZG5zM19yb2xlcyByb2xlID0gY2Rucy0+cm9sZTsKKworCWlm
IChyb2xlID49IENETlMzX1JPTEVfRU5EKSB7CisJCVdBUk5fT04ocm9sZSA+IENETlMzX1JPTEVf
RU5EKTsKKwkJcmV0dXJuOworCX0KKworCWlmIChjZG5zLT5yb2xlc1tyb2xlXS0+c3RhdGUgPT0g
Q0ROUzNfUk9MRV9TVEFURV9JTkFDVElWRSkKKwkJcmV0dXJuOworCisJbXV0ZXhfbG9jaygmY2Ru
cy0+bXV0ZXgpOworCWNkbnMtPnJvbGVzW3JvbGVdLT5zdG9wKGNkbnMpOworCWNkbnMtPnJvbGVz
W3JvbGVdLT5zdGF0ZSA9IENETlMzX1JPTEVfU1RBVEVfSU5BQ1RJVkU7CisJY2RuczNfZHJkX3N3
aXRjaF9vZmYoY2Rucyk7CisJbXV0ZXhfdW5sb2NrKCZjZG5zLT5tdXRleCk7Cit9CisKKy8qCisg
KiBjZG5zLT5yb2xlIGdldHMgZnJvbSBjZG5zM19nZXRfcm9sZSwgYW5kIHRoaXMgQVBJIHRlbGxz
IHJvbGUgYXQgdGhlCisgKiBydW50aW1lLgorICogSWYgYm90aCByb2xlcyBhcmUgc3VwcG9ydGVk
LCB0aGUgcm9sZSBpcyBzZWxlY3RlZCBiYXNlZCBvbiB2YnVzL2lkLgorICogSXQgY291bGQgYmUg
cmVhZCBmcm9tIE9URyByZWdpc3RlciBvciBleHRlcm5hbCBjb25uZWN0b3IuCisgKiBJZiBvbmx5
IHNpbmdsZSByb2xlIGlzIHN1cHBvcnRlZCwgb25seSBvbmUgcm9sZSBzdHJ1Y3R1cmUKKyAqIGlz
IGFsbG9jYXRlZCwgY2Rucy0+cm9sZXNbQ0ROUzNfUk9MRV9IT1NUXSBvciBjZG5zLT5yb2xlc1tD
RE5TM19ST0xFX0dBREdFVF0uCisgKi8KK2VudW0gY2RuczNfcm9sZXMgY2RuczNfZ2V0X3JvbGUo
c3RydWN0IGNkbnMzICpjZG5zKQogewotCXJldHVybiBjZG5zM19kcmRfc3dpdGNoX2hvc3QoY2Ru
cywgMCk7CisJaWYgKGNkbnMtPnJvbGVzW0NETlMzX1JPTEVfSE9TVF0gJiYgY2Rucy0+cm9sZXNb
Q0ROUzNfUk9MRV9HQURHRVRdKSB7CisJCWlmIChjZG5zM19pc19ob3N0KGNkbnMpKQorCQkJcmV0
dXJuIENETlMzX1JPTEVfSE9TVDsKKwkJZWxzZSBpZiAoY2RuczNfaXNfZGV2aWNlKGNkbnMpKQor
CQkJcmV0dXJuIENETlMzX1JPTEVfR0FER0VUOworCQllbHNlCisJCQlyZXR1cm4gQ0ROUzNfUk9M
RV9FTkQ7CisJfSBlbHNlIHsKKwkJcmV0dXJuIGNkbnMtPnJvbGVzW0NETlMzX1JPTEVfSE9TVF0K
KwkJCT8gQ0ROUzNfUk9MRV9IT1NUCisJCQk6IENETlMzX1JPTEVfR0FER0VUOworCX0KIH0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL2RyZC5oIGIvZHJpdmVycy91c2IvY2RuczMvZHJk
LmgKaW5kZXggNmEyOWNkY2I0OTJkLi40MmYxNTFkMmY2NTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dXNiL2NkbnMzL2RyZC5oCisrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2RyZC5oCkBAIC0xMSw3ICsx
MSw2IEBACiAKICNpbmNsdWRlIDxsaW51eC91c2Ivb3RnLmg+CiAjaW5jbHVkZSA8bGludXgvcGh5
L3BoeS5oPgotI2luY2x1ZGUgImNvcmUuaCIKIAogLyogIERSRCByZWdpc3RlciBpbnRlcmZhY2Ug
Zm9yIHZlcnNpb24gdjEuICovCiBzdHJ1Y3QgY2RuczNfb3RnX3JlZ3MgewpAQCAtMTAwLDYgKzk5
LDEwIEBAIHN0cnVjdCBjZG5zM19vdGdfY29tbW9uX3JlZ3MgewogLyogT1RHSUVOIC0gYml0bWFz
a3MgKi8KIC8qIElEIGNoYW5nZSBpbnRlcnJ1cHQgZW5hYmxlICovCiAjZGVmaW5lIE9UR0lFTl9J
RF9DSEFOR0VfSU5UCQlCSVQoMCkKKy8qIHNlc3Npb24gdmFsaWQgcmlzZSBkZXRlY3RlZCBpbnRl
cnJ1cHQgZW5hYmxlLiovCisjZGVmaW5lIE9UR0lFTl9WQlVTU0VTU19SSVNFX0lOVAlCSVQoMikK
Ky8qIHNlc3Npb24gdmFsaWQgZmFsbCBkZXRlY3RlZCBpbnRlcnJ1cHQgZW5hYmxlICovCisjZGVm
aW5lIE9UR0lFTl9WQlVTU0VTU19GQUxMX0lOVAlCSVQoMykKIC8qIFZidXN2YWxpZCBmYWxsIGRl
dGVjdGVkIGludGVycnVwdCBlbmFibGUuKi8KICNkZWZpbmUgT1RHSUVOX1ZCVVNWQUxJRF9SSVNF
X0lOVAlCSVQoNCkKIC8qIFZidXN2YWxpZCBmYWxsIGRldGVjdGVkIGludGVycnVwdCBlbmFibGUg
Ki8KQEAgLTE1MiwxMSArMTU1LDEwIEBAIHN0cnVjdCBjZG5zM19vdGdfY29tbW9uX3JlZ3Mgewog
LyogT25seSBmb3IgQ0ROUzNfQ09OVFJPTExFUl9WMCB2ZXJzaW9uICovCiAjZGVmaW5lIE9WRVJS
SURFX0lEUFVMTFVQX1YwCQlCSVQoMjQpCiAKLWludCBjZG5zM19pc19ob3N0KHN0cnVjdCBjZG5z
MyAqY2Rucyk7Ci1pbnQgY2RuczNfaXNfZGV2aWNlKHN0cnVjdCBjZG5zMyAqY2Rucyk7Ci1pbnQg
Y2RuczNfZ2V0X2lkKHN0cnVjdCBjZG5zMyAqY2Rucyk7CiBpbnQgY2RuczNfZHJkX2luaXQoc3Ry
dWN0IGNkbnMzICpjZG5zKTsKLWludCBjZG5zM19kcmRfZXhpdChzdHJ1Y3QgY2RuczMgKmNkbnMp
OwotaW50IGNkbnMzX2RyZF91cGRhdGVfbW9kZShzdHJ1Y3QgY2RuczMgKmNkbnMpOworaW50IGNk
bnMzX2ZpbmFsaXplX2RyX21vZGUoc3RydWN0IGNkbnMzICpjZG5zKTsKK2VudW0gY2RuczNfcm9s
ZXMgY2RuczNfZ2V0X3JvbGUoc3RydWN0IGNkbnMzICpjZG5zKTsKK2ludCBjZG5zM19yb2xlX3N0
YXJ0KHN0cnVjdCBjZG5zMyAqY2RucywgZW51bSBjZG5zM19yb2xlcyByb2xlKTsKK3ZvaWQgY2Ru
czNfcm9sZV9zdG9wKHN0cnVjdCBjZG5zMyAqY2Rucyk7CiAKICNlbmRpZiAvKiBfX0xJTlVYX0NE
TlMzX0RSRCAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMgYi9kcml2
ZXJzL3VzYi9jZG5zMy9nYWRnZXQuYwppbmRleCAwZDk1ZWIwMGJlMzcuLjVlMDRkNzc0MDA4NyAx
MDA2NDQKLS0tIGEvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMKKysrIGIvZHJpdmVycy91c2Iv
Y2RuczMvZ2FkZ2V0LmMKQEAgLTQ5OCw2ICs0OTgsOSBAQCBpbnQgY2RuczNfZXBfcnVuX3RyYW5z
ZmVyKHN0cnVjdCBjZG5zM19lbmRwb2ludCAqcHJpdl9lcCwKIAlpbnQgIG51bV90cmI7CiAJaW50
IGFkZHJlc3M7CiAJaW50IHBjczsKKwlib29sIGRvb3JiZWxsOworCWludCBkbWFfaW5kZXg7CisJ
dTMyIHJlZzsKIAogCWlmIChwcml2X2VwLT50eXBlID09IFVTQl9FTkRQT0lOVF9YRkVSX0lTT0Mp
CiAJCW51bV90cmIgPSBwcml2X2VwLT5pbnRlcnZhbDsKQEAgLTU0MSw2ICs1NDQsMjggQEAgaW50
IGNkbnMzX2VwX3J1bl90cmFuc2ZlcihzdHJ1Y3QgY2RuczNfZW5kcG9pbnQgKnByaXZfZXAsCiAJ
fQogCiAJZmlyc3RfcGNzID0gcHJpdl9lcC0+cGNzID8gVFJCX0NZQ0xFIDogMDsKKwkvKiBhcm0g
dHJhbnNmZXIgb24gc2VsZWN0ZWQgZW5kcG9pbnQgKi8KKwljZG5zM19zZWxlY3RfZXAocHJpdl9l
cC0+Y2RuczNfZGV2LCBhZGRyZXNzKTsKKworCWRvb3JiZWxsID0gISEocmVhZGwoJnByaXZfZGV2
LT5yZWdzLT5lcF9jbWQpICYgRVBfQ01EX0RSRFkpOworCWRtYV9pbmRleCA9IChyZWFkbCgmcHJp
dl9kZXYtPnJlZ3MtPmVwX3RyYWRkcikgLQorCQkJIHByaXZfZXAtPnRyYl9wb29sX2RtYSkgLyBU
UkJfU0laRTsKKworCWlmICghcHJpdl9lcC0+d2Ffc2V0KSB7CisJCWlmIChkb29yYmVsbCAmICgo
cHJpdl9lcC0+ZW5xdWV1ZSA9PSAwCisJCQkJICAgICAmJiBkbWFfaW5kZXggPj0gVFJCU19QRVJf
U0VHTUVOVCAtIDIpIHx8CisJCQkoZG1hX2luZGV4ID09IHByaXZfZXAtPmVucXVldWUpIHx8CisJ
CQkoZG1hX2luZGV4ID09IHByaXZfZXAtPmVucXVldWUgLSAxKSkpIHsKKwkJCXByaXZfZXAtPndh
X2N5Y2xlX2JpdCA9IGZpcnN0X3BjczsKKwkJCXByaXZfZXAtPndhX3NldCA9IDE7CisJCQlwcml2
X2VwLT53YV90cmIgPSB0cmI7CisJCQlmaXJzdF9wY3MgXj0gMHgxOworCQkJcmVnID0gcmVhZGwo
JnByaXZfZGV2LT5yZWdzLT5lcF9zdHNfZW4pOworCQkJcmVnIHw9IEVQX1NUU19UUkJFUlI7CisJ
CQl3cml0ZWwocmVnLCAmcHJpdl9kZXYtPnJlZ3MtPmVwX3N0c19lbik7CisJCX0KKwl9CisKIAog
CWRvIHsKIAkvKiBmaWxsIFRSQiAqLwpAQCAtNTgzLDcgKzYwOCw2IEBAIGludCBjZG5zM19lcF9y
dW5fdHJhbnNmZXIoc3RydWN0IGNkbnMzX2VuZHBvaW50ICpwcml2X2VwLAogCXdtYigpOwogCiAJ
cHJpdl9yZXEtPmZsYWdzIHw9IFJFUVVFU1RfUEVORElORzsKLQogCS8qIGdpdmUgdGhlIFREIHRv
IHRoZSBjb25zdW1lciovCiAJaWYgKHNnX2l0ZXIgPT0gMSkKIAkJdHJiLT5jb250cm9sIHw9IGZp
cnN0X3BjcyB8IFRSQl9JT0MgfCBUUkJfSVNQOwpAQCAtNTkzLDkgKzYxNyw2IEBAIGludCBjZG5z
M19lcF9ydW5fdHJhbnNmZXIoc3RydWN0IGNkbnMzX2VuZHBvaW50ICpwcml2X2VwLAogCXRyYWNl
X2NkbnMzX3ByZXBhcmVfdHJiKHByaXZfZXAsIHByaXZfcmVxLT50cmIpOwogCXRyYWNlX2NkbnMz
X3JpbmcocHJpdl9lcCk7CiAKLQkvKiBhcm0gdHJhbnNmZXIgb24gc2VsZWN0ZWQgZW5kcG9pbnQg
Ki8KLQljZG5zM19zZWxlY3RfZXAocHJpdl9lcC0+Y2RuczNfZGV2LCBhZGRyZXNzKTsKLQogCS8q
CiAJICogRm9yIERNVUxUIG1vZGUgd2UgY2FuIHNldCBhZGRyZXNzIHRvIHRyYW5zZmVyIHJpbmcg
b25seSBvbmNlIGFmdGVyCiAJICogZW5hYmxpbmcgZW5kcG9pbnQuCkBAIC02MDcsMTAgKzYyOCwx
MiBAQCBpbnQgY2RuczNfZXBfcnVuX3RyYW5zZmVyKHN0cnVjdCBjZG5zM19lbmRwb2ludCAqcHJp
dl9lcCwKIAl9CiAKIAkvKmNsZWFyaW5nIFRSQkVSUiBhbmQgRVBfU1RTX0RFU0NNSVMgYmVmb3Jl
IHNldGluZyBEUkRZKi8KLQl3cml0ZWwoRVBfU1RTX1RSQkVSUiB8IEVQX1NUU19ERVNDTUlTLCAm
cHJpdl9kZXYtPnJlZ3MtPmVwX3N0cyk7Ci0JdHJhY2VfY2RuczNfZG9vcmJlbGxfZXB4KHByaXZf
ZXAtPm5hbWUsCi0JCQkJIHJlYWRsKCZwcml2X2Rldi0+cmVncy0+ZXBfdHJhZGRyKSk7Ci0Jd3Jp
dGVsKEVQX0NNRF9EUkRZLCAmcHJpdl9kZXYtPnJlZ3MtPmVwX2NtZCk7CisJaWYgKCFwcml2X2Vw
LT53YV9zZXQpIHsKKwkJd3JpdGVsKEVQX1NUU19UUkJFUlIgfCBFUF9TVFNfREVTQ01JUywgJnBy
aXZfZGV2LT5yZWdzLT5lcF9zdHMpOworCQl3cml0ZWwoRVBfQ01EX0RSRFksICZwcml2X2Rldi0+
cmVncy0+ZXBfY21kKTsKKwkJdHJhY2VfY2RuczNfZG9vcmJlbGxfZXB4KHByaXZfZXAtPm5hbWUs
CisJCQkJCSByZWFkbCgmcHJpdl9kZXYtPnJlZ3MtPmVwX3RyYWRkcikpOworCX0KIAogCXJldHVy
biAwOwogfQpAQCAtODUyLDYgKzg3NSwyOCBAQCBzdGF0aWMgaW50IGNkbnMzX2NoZWNrX2VwX2lu
dGVycnVwdF9wcm9jZWVkKHN0cnVjdCBjZG5zM19lbmRwb2ludCAqcHJpdl9lcCkKIAllcF9zdHNf
cmVnID0gcmVhZGwoJnByaXZfZGV2LT5yZWdzLT5lcF9zdHMpOwogCXdyaXRlbChlcF9zdHNfcmVn
LCAmcHJpdl9kZXYtPnJlZ3MtPmVwX3N0cyk7CiAKKwlpZiAoZXBfc3RzX3JlZyAmIEVQX1NUU19U
UkJFUlIpIHsKKwkJdTMyIHJlZzsKKwkJaWYoIXByaXZfZXAtPndhX3NldCkgeworCQkJcHJpbnRr
KCJub3Qgd2Ffc2V0IGF0IFRSQkVSUlxuIik7CisJCX0gZWxzZSB7CisJCQlwcmludGsoS0VSTl9E
RUJVRyAid2Ffc2V0IGF0IFRSQkVSUlxuIik7CisJCQlwcml2X2VwLT53YV9zZXQgPSAwOworCQkJ
aWYocHJpdl9lcC0+d2FfY3ljbGVfYml0KSB7CisJCQkJcHJpdl9lcC0+d2FfdHJiLT5jb250cm9s
ID0KKwkJCQkJcHJpdl9lcC0+d2FfdHJiLT5jb250cm9sIHwgMHgxOworCQkJfSBlbHNlIHsKKwkJ
CQlwcml2X2VwLT53YV90cmItPmNvbnRyb2wgPQorCQkJCQlwcml2X2VwLT53YV90cmItPmNvbnRy
b2wgJiB+MHgxOworCQkJfQorCisJCQlyZWcgPSByZWFkbCgmcHJpdl9kZXYtPnJlZ3MtPmVwX3N0
c19lbik7CisJCQlyZWcgJj0gfkVQX1NUU19UUkJFUlI7CisJCQl3cml0ZWwocmVnLCAmcHJpdl9k
ZXYtPnJlZ3MtPmVwX3N0c19lbik7CisJCQl3cml0ZWwoRVBfQ01EX0RSRFksICZwcml2X2Rldi0+
cmVncy0+ZXBfY21kKTsKKwkJfQorCX0KKwogCWlmICgoZXBfc3RzX3JlZyAmIEVQX1NUU19JT0Mp
IHx8IChlcF9zdHNfcmVnICYgRVBfU1RTX0lTUCkpIHsKIAkJaWYgKHByaXZfZXAtPmZsYWdzICYg
RVBfUVVJUktfRVhUUkFfQlVGX0VOKSB7CiAJCQlpZiAoZXBfc3RzX3JlZyAmIEVQX1NUU19JU1Ap
CkBAIC05NTEsNiArOTk2LDkgQEAgc3RhdGljIGlycXJldHVybl90IGNkbnMzX2RldmljZV9pcnFf
aGFuZGxlcihpbnQgaXJxLCB2b2lkICpkYXRhKQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJdTMy
IHJlZzsKIAorCWlmIChjZG5zLT5yb2xlICE9IENETlMzX1JPTEVfR0FER0VUKQorCQlyZXR1cm4g
cmV0OworCiAJcHJpdl9kZXYgPSBjZG5zLT5nYWRnZXRfZGV2OwogCXNwaW5fbG9ja19pcnFzYXZl
KCZwcml2X2Rldi0+bG9jaywgZmxhZ3MpOwogCkBAIC0xMjQ5LDcgKzEyOTcsNyBAQCBzdGF0aWMg
aW50IGNkbnMzX2dhZGdldF9lcF9lbmFibGUoc3RydWN0IHVzYl9lcCAqZXAsCiB7CiAJc3RydWN0
IGNkbnMzX2VuZHBvaW50ICpwcml2X2VwOwogCXN0cnVjdCBjZG5zM19kZXZpY2UgKnByaXZfZGV2
OwotCXUzMiByZWcgPSBFUF9TVFNfRU5fVFJCRVJSRU47CisJdTMyIHJlZyA9IDAvKkVQX1NUU19F
Tl9UUkJFUlJFTiovOwogCXUzMiBiRW5kcG9pbnRBZGRyZXNzOwogCXVuc2lnbmVkIGxvbmcgZmxh
Z3M7CiAJaW50IHJldDsKQEAgLTEzMTEsOCArMTM1OSw5IEBAIHN0YXRpYyBpbnQgY2RuczNfZ2Fk
Z2V0X2VwX2VuYWJsZShzdHJ1Y3QgdXNiX2VwICplcCwKIAkgKiBpZiBiZWZvcmUgZmlyc3QgREVT
Q01JU1MgaW50ZXJydXB0IHRoZSBETUEgd2lsbCBiZSBhcm1lZC4KIAkgKi8KIAlpZiAoIXByaXZf
ZXAtPmRpciAmJiBwcml2X2VwLT50eXBlICE9IFVTQl9FTkRQT0lOVF9YRkVSX0lTT0MpIHsKLQkJ
cHJpdl9lcC0+ZmxhZ3MgfD0gRVBfUVVJUktfRVhUUkFfQlVGX0RFVDsKKwkvKglwcml2X2VwLT5m
bGFncyB8PSBFUF9RVUlSS19FWFRSQV9CVUZfREVUOwogCQlyZWcgfD0gRVBfU1RTX0VOX0RFU0NN
SVNFTjsKKwkJKi8KIAl9CiAKIAl3cml0ZWwocmVnLCAmcHJpdl9kZXYtPnJlZ3MtPmVwX3N0c19l
bik7CkBAIC0xMzI1LDYgKzEzNzQsNyBAQCBzdGF0aWMgaW50IGNkbnMzX2dhZGdldF9lcF9lbmFi
bGUoc3RydWN0IHVzYl9lcCAqZXAsCiAJcHJpdl9lcC0+ZmxhZ3MgfD0gRVBfRU5BQkxFRCB8IEVQ
X1VQREFURV9FUF9UUkJBRERSOwogCXByaXZfZXAtPmVucXVldWUgPSAwOwogCXByaXZfZXAtPmRl
cXVldWUgPSAwOworCXByaXZfZXAtPndhX3NldCA9IDA7CiAJcmVnID0gcmVhZGwoJnByaXZfZGV2
LT5yZWdzLT5lcF9zdHMpOwogCXByaXZfZXAtPnBjcyA9ICEhRVBfU1RTX0NDUyhyZWcpOwogCXBy
aXZfZXAtPmNjcyA9ICEhRVBfU1RTX0NDUyhyZWcpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
Y2RuczMvZ2FkZ2V0LmggYi9kcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuaAppbmRleCA0MWNlYzdm
MDg1YWQuLmEwYmNlMTQ5NzI2ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0
LmgKKysrIGIvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmgKQEAgLTg5Nyw3ICs4OTcsNyBAQCBz
dHJ1Y3QgY2RuczNfdXNiX3JlZ3MgewogLyoKICAqIFVTQlNTLURFViBETUEgaW50ZXJmYWNlLgog
ICovCi0jZGVmaW5lIFRSQlNfUEVSX1NFR01FTlQJNDAKKyNkZWZpbmUgVFJCU19QRVJfU0VHTUVO
VCAgICAgICA0MAogCiAjZGVmaW5lIElTT19NQVhfSU5URVJWQUwJMTAKIApAQCAtMTA2Myw2ICsx
MDYzLDkgQEAgc3RydWN0IGNkbnMzX2VuZHBvaW50IHsKIAl1OAkJCWNjczsKIAlpbnQJCQllbnF1
ZXVlOwogCWludAkJCWRlcXVldWU7CisJaW50IAkJCXdhX2N5Y2xlX2JpdDsKKwlib29sCQkJd2Ff
c2V0OworCXN0cnVjdCBjZG5zM190cmIgCSp3YV90cmI7CiB9OwogCiAvKioKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2NkbnMzL3RyYWNlLmggYi9kcml2ZXJzL3VzYi9jZG5zMy90cmFjZS5oCmlu
ZGV4IGYzZDdhOTFmYWU4Ni4uOGU5NzU3NWE2YjAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9j
ZG5zMy90cmFjZS5oCisrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL3RyYWNlLmgKQEAgLTE3OSw3ICsx
NzksNyBAQCBERUNMQVJFX0VWRU5UX0NMQVNTKGNkbnMzX2xvZ19yZXF1ZXN0LAogCQlfX2VudHJ5
LT5mbGFncyA9IHJlcS0+ZmxhZ3M7CiAJKSwKIAlUUF9wcmludGsoIiVzOiByZXE6ICVwLCBsZW5n
dGg6ICV1LyV1ICVzJXMlcywgc3RhdHVzOiAlZCwiCi0JCSAgIiB0cmI6IFtzdGFydDolZCwgZW5k
OiVkOiB2aXJ0IGFkZHIgJXBhXSwgZmxhZ3M6JXggIiwKKwkJICAiIHRyYjogW3N0YXJ0OiVkLCBl
bmQ6JWQ6IHZpcnQgYWRkciAweCVwXSwgZmxhZ3M6JXggIiwKIAkJX19nZXRfc3RyKG5hbWUpLCBf
X2VudHJ5LT5yZXEsIF9fZW50cnktPmFjdHVhbCwgX19lbnRyeS0+bGVuZ3RoLAogCQlfX2VudHJ5
LT56ZXJvID8gInplcm8gfCAiIDogIiIsCiAJCV9fZW50cnktPnNob3J0X25vdF9vayA/ICJzaG9y
dCB8ICIgOiAiIiwKQEAgLTIzNiw3ICsyMzYsNyBAQCBERUNMQVJFX0VWRU5UX0NMQVNTKGNkbnMz
X2xvZ190cmIsCiAJCV9fZW50cnktPmNvbnRyb2wgPSB0cmItPmNvbnRyb2w7CiAJCV9fZW50cnkt
PnR5cGUgPSB1c2JfZW5kcG9pbnRfdHlwZShwcml2X2VwLT5lbmRwb2ludC5kZXNjKTsKIAkpLAot
CVRQX3ByaW50aygiJXM6IHRyYiAweCVwYSwgZG1hIGJ1ZjogMHglMDh4LCBzaXplOiAlbGQsIGN0
cmw6IDB4JTA4eCAoJXMlcyVzJXMlcyVzJXMpIiwKKwlUUF9wcmludGsoIiVzOiB0cmIgMHglcCwg
ZG1hIGJ1ZjogMHglMDh4LCBzaXplOiAlbGQsIGN0cmw6IDB4JTA4eCAoJXMlcyVzJXMlcyVzJXMp
IiwKIAkJX19nZXRfc3RyKG5hbWUpLCBfX2VudHJ5LT50cmIsIF9fZW50cnktPmJ1ZmZlciwKIAkJ
VFJCX0xFTihfX2VudHJ5LT5sZW5ndGgpLCBfX2VudHJ5LT5jb250cm9sLAogCQlfX2VudHJ5LT5j
b250cm9sICYgVFJCX0NZQ0xFID8gIkM9MSwgIiA6ICJDPTAsICIsCi0tIAoyLjE0LjEKCg==
--000000000000aa40e6057f108708
Content-Type: application/octet-stream; name="cdns3.tar.bz2"
Content-Disposition: attachment; filename="cdns3.tar.bz2"
Content-Transfer-Encoding: base64
Content-ID: <f_jqpxqykg1>
X-Attachment-Id: f_jqpxqykg1

QlpoOTFBWSZTWTdSQbQA4C1/vP+8Ba3///////////////9AgAgAAAKAAgCIYNYe+8+OF3z6uAD3
tuzPjAAAAxitABzagESVQA+e7127uL7NPsXbU9sp2d8GX33u+tSe7zndXpd0d333d81926d32dSJ
XtriDRp7nu+LqfA7ckdD7Afc9AKUejFQro0EkgvN0G3HHVYUjoF9h7tW761S973e2W9vffe96h6H
WmmhKBaBpIABR8AHfZPvh99ffYHkD19762t5LffSq72d7vm1311ruLm97vb1883211YLlztVNr24
gA+9nQujIqk8X2FffLoxErWus7NOZ3ZOnx3X3Pe9fX1y9rWqL3cO19fdb77BX33X3n091g8wtttV
7b5DVPVjUUd24tiPJld7huL23Cd32OHK1rvo2nW7ddfXrm2tu2ctm1vt69vu332e4ljWyKB7NabP
ez3nWqzbbx25dcddcEtBumjdjrh0DLXO7qxrsdudwBmune7u9V3alZ3b77fZe5rgADQphxzqqr3e
qHXu11Ns6z67tB49e9jvDbsx93hd7NtXCWubs5cu+88Xbt7jaNcnPM3iW7rujWY0thZRrp1tuvmb
tmwGtve7y7xL3bipr1nTZpz3eOWa3OHXAYpYAbXuqiCDu1s7t3ddyB2K6O7bs+8QCvF3Pu94eMe3
TtD5advrh3ty97Mb205aMAUHrr0aXLFjE9u5s85bU3HdQxu2c+u5r5Wz5sJTSBACAAmgBGQAjTTT
QAIAJpNqeqYho0AGmgAJTQQIQQEaAjCBMU9NT1DJtU8mkDTTIaANAANAAACTSJESaJpkGgk2hU/R
6VP1RvapDaaEyek2UNN6oAGhpoaZGhoAAwk9UpSaIE0noNMRok8TKepmk9IaAyGhoDRoNAAAAAAa
CJERJ6BBoJpMqn+QRT9J7SepNPVPU8p7RTaNGUj2lPyYVP1TPU9U09T9T1Tajyh6ag9qCJIIQINA
k2TQjCNJlU/9CnppNNNqk/U1H6o9qQ9QNDQAAAADfw+YE30EjP2frhCT/fR+y2iGfl+sofXs3EOo
EoGpEZuVEDrRHH3ffCp9+21rExVpa+VPw8NBLS5RJIdyB4/d58DiS3m7M7Jhet4/lqnp09ZX5dhD
2exinoqjJUlRkS0trqK5t02SWFmF2tZWrq8lly3a4mjDSUwUoW7V3VkquVctyUS5rSIFEQuClRLV
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
--000000000000aa40e6057f108708--
