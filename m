Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573BDC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D423218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HFl9AVoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfBZXhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:37:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43818 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfBZXhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:37:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so6951147pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQPNuH91rmiyJb7nOJZlncM/U/2KFpqxxvqDfgerZuk=;
        b=HFl9AVoJXt4c075wUUHYkw7pBHqYfXZWu/eQQigJWajAWM3f2zwjeMEM/9Ce0Vj082
         pfZsrf+fGehPeYJRr7yXof4a7vuDFGxhjElwJsjBZSsA8lcHA8Wn3E0QDOCIBr2Ks1KF
         zc9535Y3w7EnS1uhaQN6dNBYuPbyg3zq6WSDuxXoD4H/uLqeMS7EYabw9h1ZWmoUKfYe
         Hb5l2K9tyL6kBMNPFd+eDv0n/FAmztQCRSj2oVdChOw7QZtsLQDYvnv2QoOqhcClvDdh
         UpZy9gLSSIZLgxWNEkWypF9h20iQa/EPbXULTHdV+3MSu9poicYhUdBLAMk4lYriziib
         bbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQPNuH91rmiyJb7nOJZlncM/U/2KFpqxxvqDfgerZuk=;
        b=F2OObgajbk/ZhnIZPNoWWbb6z6eJQaxvZONdPyiG4IRzAnPQ67r4rs31uenWqH1o7S
         TSaKigs6Ijpqw+2eYW4vlzp/ApRzjEb8AAU3FJx+u8xV6GF3L8REgdrTF1GjHN9iRobb
         vynf7dhn0VdofVnzAqPvB1kENofeneF1I7WQl/iWscw3smDOQ7sTVn4HOZ7YlCRqKeNY
         JiBhp5LWbdvIPmWWa0kmumu5XSZT5D60/jYq/ORZmXXW2DcuaK77vSis38inTJjXD12c
         eqvYz9IZr6/OYuXatrzI3E8TdD4anyPDoIDvZrjyyuLFked7JkLAc7UgkLDpWcgQR5aq
         /KeA==
X-Gm-Message-State: AHQUAuYWrdCl/D+3tLqrmWjk5pT5AwF7oW9cC2a0X4cWP0Dzhxs4lwhC
        aCjACH4+zuMtSHAS7AKOSRa6obI0K+t/rCmMcwRCCZQ1cHs=
X-Google-Smtp-Source: AHgI3IZpNTep8OoQRXuud9meI89KdW/ZpzSJ9OhHPSbBlICTw+tHk7ILnLKNfWJ3Xn2rye5gHzpdiuQXvGMIiwj4jOU=
X-Received: by 2002:a63:f74c:: with SMTP id f12mr26967604pgk.195.1551224229131;
 Tue, 26 Feb 2019 15:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20190226233611.140636-1-venture@google.com>
In-Reply-To: <20190226233611.140636-1-venture@google.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 26 Feb 2019 15:36:57 -0800
Message-ID: <CAO=notxc8UPbLmcmrd+gnSFfGoGJ2ybewgOuJUyBPgMQaqYS1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drivers/misc: Add Aspeed P2A control driver
To:     Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 3:36 PM Patrick Venture <venture@google.com> wrote:
>
> The ASPEED AST2400, and AST2500 in some configurations include a
> PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> in the BMC's physical address space.  This feature is especially useful
> when using this bridge to send large files to the BMC.
>
> The host may use this to send down a firmware image by staging data at a
> specific memory address, and in a coordinated effort with the BMC's
> software stack and kernel, transmit the bytes.
>
> This driver enables the BMC to unlock the PCI bridge on demand, and
> configure it via ioctl to allow the host to write bytes to an agreed
> upon location.  In the primary use-case, the region to use is known
> apriori on the BMC, and the host requests this information.  Once this
> request is received, the BMC's software stack will enable the bridge and
> the region and then using some software flow control (possibly via IPMI
> packets), copy the bytes down.  Once the process is complete, the BMC
> will disable the bridge and unset any region involved.
>
> The default behavior of this bridge when present is: enabled and all
> regions marked read-write.  This driver will fix the regions to be
> read-only and then disable the bridge entirely.
>
> The memory regions protected are:
>  * BMC flash MMIO window
>  * System flash MMIO windows
>  * SOC IO (peripheral MMIO)
>  * DRAM
>
> The DRAM region itself is all of DRAM and cannot be further specified.
> Once the PCI bridge is enabled, the host can read all of DRAM, and if
> the DRAM section is write-enabled, then it can write to all of it.
>
> Signed-off-by: Patrick Venture <venture@google.com>
> Change-Id: I56da837e061556bb1e57d0aca0678d1cab0561f2
> ---
> Changes for v2:
> - Dropped unused reads.
> - Moved call to disable bridge to before registering device.
> - Switch from using regs to using a syscon regmap. <<< IN PROGRESS
> - Updated the commit message. <<< TODO
> - Updated the bit flipped for SCU180_ENP2A
> - Dropped boolean region_specified variable.
> - Renamed p2a_ctrl in _probe to misc_ctrl per suggestion.
> - Renamed aspeed_p2a_region_search to aspeed_p2a_region_acquire
> - Updated commit message.
> ---
>  drivers/misc/Kconfig                 |   8 +
>  drivers/misc/Makefile                |   1 +
>  drivers/misc/aspeed-p2a-ctrl.c       | 454 +++++++++++++++++++++++++++
>  include/uapi/linux/aspeed-p2a-ctrl.h |  46 +++
>  4 files changed, 509 insertions(+)
>  create mode 100644 drivers/misc/aspeed-p2a-ctrl.c
>  create mode 100644 include/uapi/linux/aspeed-p2a-ctrl.h
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f417b06e11c5..9de1bafe5606 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -485,6 +485,14 @@ config VEXPRESS_SYSCFG
>           bus. System Configuration interface is one of the possible means
>           of generating transactions on this bus.
>
> +config ASPEED_P2A_CTRL
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> +       tristate "Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC bridge control"
> +       help
> +         Control Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC mappings through
> +         ioctl()s, the driver also provides an interface for userspace mappings to
> +         a pre-defined region.
> +
>  config ASPEED_LPC_CTRL
>         depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
>         tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e39ccbbc1b3a..57577aee354f 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG) += vexpress-syscfg.o
>  obj-$(CONFIG_CXL_BASE)         += cxl/
>  obj-$(CONFIG_ASPEED_LPC_CTRL)  += aspeed-lpc-ctrl.o
>  obj-$(CONFIG_ASPEED_LPC_SNOOP) += aspeed-lpc-snoop.o
> +obj-$(CONFIG_ASPEED_P2A_CTRL)  += aspeed-p2a-ctrl.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)        += pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)             += ocxl/
>  obj-y                          += cardreader/
> diff --git a/drivers/misc/aspeed-p2a-ctrl.c b/drivers/misc/aspeed-p2a-ctrl.c
> new file mode 100644
> index 000000000000..7be36fccb662
> --- /dev/null
> +++ b/drivers/misc/aspeed-p2a-ctrl.c
> @@ -0,0 +1,454 @@
> +/*
> + * Copyright 2019 Google Inc
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * Provides a simple driver to control the ASPEED P2A interface which allows
> + * the host to read and write to various regions of the BMC's memory.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/aspeed-p2a-ctrl.h>
> +
> +#define DEVICE_NAME    "aspeed-p2a-ctrl"
> +
> +/* SCU2C is a Misc. Control Register. */
> +#define SCU2C 0x2c
> +/* SCU180 is the PCIe Configuration Setting Control Register. */
> +#define SCU180 0x180
> +/* Bit 1 controls the P2A bridge, while bit 0 controls the entire VGA device
> + * on the PCI bus. */
> +#define SCU180_ENP2A BIT(1)
> +
> +/* The ast2400/2500 both have six ranges. */
> +#define P2A_REGION_COUNT 6
> +
> +struct region {
> +       u32 min;
> +       u32 max;
> +       u32 bit;
> +};
> +
> +struct aspeed_p2a_model_data {
> +       /* min, max, bit */
> +       struct region regions[P2A_REGION_COUNT];
> +};
> +
> +struct aspeed_p2a_ctrl {
> +       struct miscdevice miscdev;
> +       struct regmap *regmap;
> +
> +       const struct aspeed_p2a_model_data *config;
> +
> +       /* Access to these needs to be locked, held via probe, mapping ioctl,
> +        * and release, remove.
> +        */
> +       struct mutex tracking;
> +       u32 readers;
> +       u32 readerwriters[P2A_REGION_COUNT];
> +
> +       phys_addr_t mem_base;
> +       resource_size_t mem_size;
> +};
> +
> +static inline u32 aspeed_p2a_read(void __iomem *base)
> +{
> +       return readl((void *)base);
> +}
> +
> +static inline void aspeed_p2a_write(void __iomem *base, u32 val)
> +{
> +       writel(val, (void *)base);
> +}

Just noticed I forgot to delete these.  Will send out v3.

> +
> +struct aspeed_p2a_user {
> +       struct file *file;
> +       struct aspeed_p2a_ctrl *parent;
> +
> +       /** The entire memory space is opened for reading once the bridge is
> +        * enabled, therefore this needs only to be tracked once per user.
> +        * If any user has it open for read, the bridge must stay enabled.
> +        */
> +       u32 read;
> +
> +       /** Each entry of the array corresponds to a P2A Region.  If the user
> +        * opens for read or readwrite, the reference goes up here.  On release,
> +        * this array is walked and references adjusted accordingly.
> +        */
> +       u32 readwrite[P2A_REGION_COUNT];
> +};
> +
> +static void aspeed_p2a_enable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
> +{
> +       regmap_update_bits(p2a_ctrl->regmap, SCU180, SCU180_ENP2A, SCU180_ENP2A);
> +}
> +
> +static void aspeed_p2a_disable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
> +{
> +       regmap_update_bits(p2a_ctrl->regmap, SCU180, SCU180_ENP2A, 0);
> +}
> +
> +static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct aspeed_p2a_user *priv = file->private_data;
> +       struct aspeed_p2a_ctrl *ctrl = priv->parent;
> +
> +       if (ctrl->mem_base == 0 && ctrl->mem_size == 0)
> +               return -EINVAL;
> +
> +       unsigned long vsize = vma->vm_end - vma->vm_start;
> +       pgprot_t prot = vma->vm_page_prot;
> +
> +       if (vma->vm_pgoff + vsize > ctrl->mem_base + ctrl->mem_size)
> +               return -EINVAL;
> +
> +       /* ast2400/2500 AHB accesses are not cache coherent */
> +       prot = pgprot_noncached(prot);
> +
> +       if (remap_pfn_range(vma, vma->vm_start,
> +               (ctrl->mem_base >> PAGE_SHIFT) + vma->vm_pgoff,
> +               vsize, prot))
> +               return -EAGAIN;
> +
> +       return 0;
> +}
> +
> +static void aspeed_p2a_region_acquire(struct aspeed_p2a_user *priv,
> +               struct aspeed_p2a_ctrl *ctrl,
> +               struct aspeed_p2a_ctrl_mapping *map)
> +{
> +       int i;
> +       u32 base, end;
> +       u32 value;
> +
> +       base = map->addr;
> +       end = map->addr + (map->length - 1);
> +
> +       /* If the value is a legal u32, it will find a match. */
> +       for (i = 0; i < P2A_REGION_COUNT; i++) {
> +               const struct region *curr = &ctrl->config->regions[i];
> +
> +               /* If the top of this region is lower than your base, skip it.
> +                */
> +               if (curr->max < base)
> +                       continue;
> +
> +               /* If the bottom of this region is higher than your end, bail.
> +                */
> +               if (curr->min > end)
> +                       break;
> +               /* Lock this and update it, therefore it someone else is
> +                * closing their file out, this'll preserve the increment.
> +                */
> +               mutex_lock(&ctrl->tracking);
> +               ctrl->readerwriters[i] += 1;
> +               mutex_unlock(&ctrl->tracking);
> +
> +               /* Track with the user, so when they close their file, we can
> +                * decrement properly.
> +                */
> +               priv->readwrite[i] += 1;
> +
> +               /* Enable the region as read-write. */
> +               regmap_update_bits(ctrl->regmap, SCU2C, curr->bit, 0);
> +       }
> +}
> +
> +static long aspeed_p2a_ioctl(struct file *file, unsigned int cmd,
> +               unsigned long data)
> +{
> +       struct aspeed_p2a_user *priv = file->private_data;
> +       struct aspeed_p2a_ctrl *ctrl = priv->parent;
> +       void __user *arg = (void __user *)data;
> +       struct aspeed_p2a_ctrl_mapping map;
> +
> +       switch (cmd) {
> +       case ASPEED_P2A_CTRL_IOCTL_SET_WINDOW:
> +               if (copy_from_user(&map, arg, sizeof(map)))
> +                       return -EFAULT;
> +
> +               /* If they want a region to be read-only, since the entire
> +                * region is read-only once enabled, we just need to track this
> +                * user wants to read from the bridge, and if it's not enabled.
> +                * Enable it.
> +                */
> +               if (map.flags == ASPEED_P2A_CTRL_READ_ONLY) {
> +                       mutex_lock(&ctrl->tracking);
> +                       ctrl->readers += 1;
> +                       mutex_unlock(&ctrl->tracking);
> +
> +                       /* Track with the user, so when they close their file,
> +                        * we can decrement properly.
> +                        */
> +                       priv->read += 1;
> +               } else if (map.flags == ASPEED_P2A_CTRL_READWRITE) {
> +                       aspeed_p2a_region_acquire(priv, ctrl, &map);
> +               } else {
> +                       /* Invalid map flags. */
> +                       return -EINVAL;
> +               }
> +
> +               aspeed_p2a_enable_bridge(ctrl);
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +
> +/**
> + * When a user opens this file, we create a structure to track their mappings.
> + *
> + * A user can map a region as read-only (bridge enabled), or read-write (bit
> + * flipped, and bridge enabled).  Either way, this tracking is used, s.t. when
> + * they release the device references are handled.
> + *
> + * The bridge is not enabled until a user calls an ioctl to map a region,
> + * simply opening the device does not enable it.
> + */
> +static int aspeed_p2a_open(struct inode *inode, struct file *file)
> +{
> +       struct aspeed_p2a_user *priv;
> +
> +       priv = kmalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->file = file;
> +       priv->read = 0;
> +       memset(priv->readwrite, 0, sizeof(priv->readwrite));
> +
> +       /* The file's private_data is initialized to the p2a_ctrl. */
> +       priv->parent = file->private_data;
> +
> +       /* Set the file's private_data to the user's data. */
> +       file->private_data = priv;
> +
> +       return 0;
> +}
> +
> +/**
> + * This will close the users mappings.  It will go through what they had opened
> + * for readwrite, and decrement those counts.  If at the end, this is the last
> + * user, it'll close the bridge.
> + */
> +static int aspeed_p2a_release(struct inode *inode, struct file *file)
> +{
> +       int i;
> +       u32 value;
> +       u32 bits = 0;
> +       bool open_regions = false;
> +       struct aspeed_p2a_user *priv = file->private_data;
> +
> +       /* Lock others from changing these values until everything is updated
> +        * in one pass */
> +       mutex_lock(&priv->parent->tracking);
> +
> +       priv->parent->readers -= priv->read;;
> +
> +       for (i = 0; i < P2A_REGION_COUNT; i++) {
> +               priv->parent->readerwriters[i] -= priv->readwrite[i];
> +
> +               if (priv->parent->readerwriters[i] > 0)
> +                       open_regions = true;
> +               else
> +                       bits |= priv->parent->config->regions[i].bit;
> +       }
> +
> +       /* Setting a bit to 1 disables the region, so let's just OR with the
> +        * above to disable any.
> +        */
> +
> +       /* Note, if another user is trying to ioctl, they can't grab tracking,
> +        * and therefore can't grab either register mutex.
> +        * If another user is trying to close, they can't grab tracking either.
> +        */
> +       regmap_update_bits(priv->parent->regmap, SCU2C, bits, bits);
> +
> +       /* If parent->readers is zero and open windows is 0, disable the
> +        * bridge.
> +        */
> +       if (!open_regions && priv->parent->readers == 0)
> +               aspeed_p2a_disable_bridge(priv->parent);
> +
> +       mutex_unlock(&priv->parent->tracking);
> +
> +       kfree(priv);
> +
> +       return 0;
> +}
> +
> +static const struct file_operations aspeed_p2a_ctrl_fops = {
> +       .owner = THIS_MODULE,
> +       .mmap = aspeed_p2a_mmap,
> +       .unlocked_ioctl = aspeed_p2a_ioctl,
> +       .open = aspeed_p2a_open,
> +       .release = aspeed_p2a_release,
> +};
> +
> +/** The regions are controlled by SCU2C */
> +static void aspeed_p2a_disable_all(struct aspeed_p2a_ctrl *p2a_ctrl)
> +{
> +       int i;
> +       u32 value = 0;
> +       u32 curr_value;
> +
> +       for (i = 0; i < P2A_REGION_COUNT; i++)
> +               value |= p2a_ctrl->config->regions[i].bit;
> +
> +       regmap_update_bits(p2a_ctrl->regmap, SCU2C, value, value);
> +
> +       /* Disable the bridge. */
> +       aspeed_p2a_disable_bridge(p2a_ctrl);
> +}
> +
> +static int aspeed_p2a_ctrl_probe(struct platform_device *pdev)
> +{
> +       struct aspeed_p2a_ctrl *misc_ctrl;
> +       struct device *dev;
> +       struct resource *res, resm;
> +       struct device_node *node;
> +       int rc = 0;
> +
> +       dev = &pdev->dev;
> +
> +       misc_ctrl = devm_kzalloc(dev, sizeof(*misc_ctrl), GFP_KERNEL);
> +       if (!misc_ctrl)
> +               return -ENOMEM;
> +
> +       mutex_init(&misc_ctrl->tracking);
> +       misc_ctrl->readers = 0;
> +       memset(misc_ctrl->readerwriters, 0, sizeof(misc_ctrl->readerwriters));
> +
> +       misc_ctrl->mem_size = 0;
> +       misc_ctrl->mem_base = 0;
> +
> +       /* optional. */
> +       node = of_parse_phandle(dev->of_node, "memory-region", 0);
> +       if (node) {
> +               rc = of_address_to_resource(node, 0, &resm);
> +               of_node_put(node);
> +               if (rc) {
> +                       dev_err(dev, "Couldn't address to resource for reserved memory\n");
> +                       return -ENOMEM;
> +               }
> +
> +               misc_ctrl->mem_size = resource_size(&resm);
> +               misc_ctrl->mem_base = resm.start;
> +       }
> +       node = of_parse_phandle(dev->of_node, "syscon", 0);
> +       if (!node)
> +               dev_err(dev, "Couldn't find syscon property\n");
> +
> +       misc_ctrl->regmap = syscon_node_to_regmap(node);
> +       of_node_put(node);
> +
> +       misc_ctrl->config = of_device_get_match_data(dev);
> +
> +       dev_set_drvdata(&pdev->dev, misc_ctrl);
> +
> +       aspeed_p2a_disable_all(misc_ctrl);
> +
> +       misc_ctrl->miscdev.minor = MISC_DYNAMIC_MINOR;
> +       misc_ctrl->miscdev.name = DEVICE_NAME;
> +       misc_ctrl->miscdev.fops = &aspeed_p2a_ctrl_fops;
> +       misc_ctrl->miscdev.parent = dev;
> +       rc = misc_register(&misc_ctrl->miscdev);
> +       if (rc) {
> +               dev_err(dev, "Unable to register device\n");
> +               goto err;
> +       }
> +
> +err:
> +       return rc;
> +}
> +
> +static int aspeed_p2a_ctrl_remove(struct platform_device *pdev)
> +{
> +       struct aspeed_p2a_ctrl *p2a_ctrl = dev_get_drvdata(&pdev->dev);
> +
> +       misc_deregister(&p2a_ctrl->miscdev);
> +
> +       return 0;
> +}
> +
> +/*
> + * bit | SCU2C | ast2400
> + *  25 | DRAM  | 0x40000000 - 0x5FFFFFFF
> + *  24 | SPI   | 0x30000000 - 0x3FFFFFFF
> + *  23 | SOC   | 0x18000000 - 0x1FFFFFFF, 0x60000000 - 0xFFFFFFFF
> + *  22 | FLASH | 0x00000000 - 0x17FFFFFF, 0x20000000 - 0x2FFFFFFF
> + *
> + * bit | SCU2C | ast2500
> + *  25 | DRAM  | 0x80000000 - 0xFFFFFFFF
> + *  24 | SPI   | 0x60000000 - 0x7FFFFFFF
> + *  23 | SOC   | 0x10000000 - 0x1FFFFFFF, 0x40000000 - 0x5FFFFFFF
> + *  22 | FLASH | 0x00000000 - 0x0FFFFFFF, 0x20000000 - 0x3FFFFFFF
> + */
> +
> +#define SCU2C_DRAM     BIT(25)
> +#define SCU2C_SPI      BIT(24)
> +#define SCU2C_SOC      BIT(23)
> +#define SCU2C_FLASH    BIT(22)
> +
> +static const struct aspeed_p2a_model_data ast2400_model_data = {
> +       .regions = {
> +               {0x00000000, 0x17FFFFFF, SCU2C_FLASH},
> +               {0x18000000, 0x1FFFFFFF, SCU2C_SOC},
> +               {0x20000000, 0x2FFFFFFF, SCU2C_FLASH},
> +               {0x30000000, 0x3FFFFFFF, SCU2C_SPI},
> +               {0x40000000, 0x5FFFFFFF, SCU2C_DRAM},
> +               {0x60000000, 0xFFFFFFFF, SCU2C_SOC},
> +       }
> +};
> +
> +static const struct aspeed_p2a_model_data ast2500_model_data = {
> +       .regions = {
> +               {0x00000000, 0x0FFFFFFF, SCU2C_FLASH},
> +               {0x10000000, 0x1FFFFFFF, SCU2C_SOC},
> +               {0x20000000, 0x3FFFFFFF, SCU2C_FLASH},
> +               {0x40000000, 0x5FFFFFFF, SCU2C_SOC},
> +               {0x60000000, 0x7FFFFFFF, SCU2C_SPI},
> +               {0x80000000, 0xFFFFFFFF, SCU2C_DRAM},
> +       }
> +};
> +
> +static const struct of_device_id aspeed_p2a_ctrl_match[] = {
> +       { .compatible = "aspeed,ast2400-p2a-ctrl",
> +         .data = &ast2400_model_data },
> +       { .compatible = "aspeed,ast2500-p2a-ctrl",
> +         .data = &ast2500_model_data },
> +       { },
> +};
> +
> +static struct platform_driver aspeed_p2a_ctrl_driver = {
> +       .driver = {
> +               .name           = DEVICE_NAME,
> +               .of_match_table = aspeed_p2a_ctrl_match,
> +       },
> +       .probe = aspeed_p2a_ctrl_probe,
> +       .remove = aspeed_p2a_ctrl_remove,
> +};
> +
> +module_platform_driver(aspeed_p2a_ctrl_driver);
> +
> +MODULE_DEVICE_TABLE(of, aspeed_p2a_ctrl_match);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Patrick Venture <venture@google.com>");
> +MODULE_DESCRIPTION("Control for aspeed 2400/2500 P2A VGA HOST to BMC mappings");
> diff --git a/include/uapi/linux/aspeed-p2a-ctrl.h b/include/uapi/linux/aspeed-p2a-ctrl.h
> new file mode 100644
> index 000000000000..473b62efb94c
> --- /dev/null
> +++ b/include/uapi/linux/aspeed-p2a-ctrl.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Copyright 2019 Google Inc
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * Provides a simple driver to control the ASPEED P2A interface which allows
> + * the host to read and write to various regions of the BMC's memory.
> + */
> +
> +#ifndef _UAPI_LINUX_ASPEED_P2A_CTRL_H
> +#define _UAPI_LINUX_ASPEED_P2A_CTRL_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define ASPEED_P2A_CTRL_READ_ONLY 0
> +#define ASPEED_P2A_CTRL_READWRITE 1
> +
> +/*
> + * This driver provides a mechanism for enabling or disabling the read-write
> + * property of specific windows into the ASPEED BMC's memory.
> + *
> + * A user can map a region of the BMC's memory as read-only or read-write, with
> + * the caveat that once any region is mapped, all regions are unlocked for
> + * reading.
> + */
> +
> +/**
> + * Unlock a region of BMC physical memory for access from the host.
> + */
> +struct aspeed_p2a_ctrl_mapping {
> +       __u32 addr;
> +       __u32 length;
> +       __u32 flags;
> +};
> +
> +#define __ASPEED_P2A_CTRL_IOCTL_MAGIC 0xb3
> +
> +#define ASPEED_P2A_CTRL_IOCTL_SET_WINDOW _IOW(__ASPEED_P2A_CTRL_IOCTL_MAGIC, \
> +               0x00, struct aspeed_p2a_ctrl_mapping)
> +
> +#endif /* _UAPI_LINUX_ASPEED_P2A_CTRL_H */
> --
> 2.21.0.rc2.261.ga7da99ff1b-goog
>
