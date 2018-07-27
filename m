Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F245C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C9B20647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ib2DEEUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C9B20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389622AbeG0WUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:20:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43481 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389368AbeG0WUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:20:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so5511678ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3RL5bCVT93au98AI9eCX3hsMgGk5r/5A3RNnI20+Rs=;
        b=Ib2DEEUykfo57gMamroUkhLN/lonwzeIDi09F3D8ebmU93Ove2OtYXYN6UnjKjBrmC
         oywSe6NMiqmdQ9a35Qjuw2bGR0qE1CtfC4og5VuM5d30xREY4kW1W+DpYtSZY84s4ufe
         IfmIIP55nX/xgpfn/vDs+CTxd9dLHqWvgXhg4UtIYLaQu1xJN6EnJrUZp4/OTo7s3Y4d
         6ZJKX4tj/jp5NZsAdYcRsyUi0HfCF9titK3VO1X7EXHKKV/IX2qRiRdd01ia2J7rofHD
         946T9mHvGhVqMADNQAE9ujs5zvmDNT7zoOe4kxyvlW6y2nmJ2Wx1aYJE5oaiQ3HzV1av
         XTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3RL5bCVT93au98AI9eCX3hsMgGk5r/5A3RNnI20+Rs=;
        b=Q+ZUEju3Jo3/w1MW+YgidVrUfJHZ9YnAT3twUJXsewmv10XXIl2YnQbJllKekQ82SP
         K+AuRHlNsgMuGm3MQ6mul69sz/ttwh6jZjv0+Iyn0FwbRd3YeY62GDuaWX+XTK3UgBdM
         727Iflz+yzoZlwNdM4NfTRwRgr2wxULyhliqgsLFMU4yAwuLdOmGpVx51CLv4V0TAWnB
         eH59cSaTCds2/hg9eBvNj4uDSYgXPNcs5RsrJMnuirJq0FjSmAyoPk6/zPXPob8QjWWO
         dxgAzqtBN0l56INBcwqrMb0W+2a11+BDLzr+uHCxcem2+lwNU0+TJN9TBa35EDtyJvOY
         YsUA==
X-Gm-Message-State: AOUpUlHqm7OP+uakxcgwU4tdjQEIePeSy3Qtb4N6a9xKUtdcqRjPv5oK
        MxGVtIiMqusixD5EufDOa3P3E9AysZWoqjG8DLqoTg==
X-Google-Smtp-Source: AAOMgpc7y+w3jyr+Vh9aCeqmyN+mFc5+As2pYzRUKV2RKqCVcU55GMSspGl+ooyiTJ+iEVYfHcEg8mthB7P2xcsKbdo=
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr5810428ljf.36.1532724984312;
 Fri, 27 Jul 2018 13:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180719230633.243666-1-rkir@google.com>
In-Reply-To: <20180719230633.243666-1-rkir@google.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Fri, 27 Jul 2018 13:56:12 -0700
Message-ID: <CAOGAQerLXMqLOvEat_vTQYPJkO-g4UkbbhYwLpoVeNpxYE4qyw@mail.gmail.com>
Subject: Re: [PATCH] platform: goldfish: Retire pdev_bus
To:     gregkh@linuxfoundation.org
Cc:     Todd Kjos <tkjos@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

the get_maintainer script gave only the mailing list. Do you happen to
know if I need to mail my change somewhere else?

Regards,
Roman.
On Thu, Jul 19, 2018 at 4:07 PM <rkir@google.com> wrote:
>
> From: Roman Kiryanov <rkir@google.com>
>
> Not used by goldfish.
>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  drivers/platform/goldfish/Kconfig    |   5 -
>  drivers/platform/goldfish/Makefile   |   1 -
>  drivers/platform/goldfish/pdev_bus.c | 232 ---------------------------
>  3 files changed, 238 deletions(-)
>  delete mode 100644 drivers/platform/goldfish/pdev_bus.c
>
> diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
> index fefbb8370da0..479031aa4f88 100644
> --- a/drivers/platform/goldfish/Kconfig
> +++ b/drivers/platform/goldfish/Kconfig
> @@ -10,11 +10,6 @@ menuconfig GOLDFISH
>
>  if GOLDFISH
>
> -config GOLDFISH_BUS
> -       bool "Goldfish platform bus"
> -       ---help---
> -         This is a virtual bus to host Goldfish Android Virtual Devices.
> -
>  config GOLDFISH_PIPE
>         tristate "Goldfish virtual device for QEMU pipes"
>         ---help---
> diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
> index d3487125838c..e0c202df9674 100644
> --- a/drivers/platform/goldfish/Makefile
> +++ b/drivers/platform/goldfish/Makefile
> @@ -1,5 +1,4 @@
>  #
>  # Makefile for Goldfish platform specific drivers
>  #
> -obj-$(CONFIG_GOLDFISH_BUS)     += pdev_bus.o
>  obj-$(CONFIG_GOLDFISH_PIPE)    += goldfish_pipe.o
> diff --git a/drivers/platform/goldfish/pdev_bus.c b/drivers/platform/goldfish/pdev_bus.c
> deleted file mode 100644
> index dd9ea463c2a4..000000000000
> --- a/drivers/platform/goldfish/pdev_bus.c
> +++ /dev/null
> @@ -1,232 +0,0 @@
> -/*
> - * Copyright (C) 2007 Google, Inc.
> - * Copyright (C) 2011 Intel, Inc.
> - * Copyright (C) 2013 Intel, Inc.
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/io.h>
> -
> -#define PDEV_BUS_OP_DONE        (0x00)
> -#define PDEV_BUS_OP_REMOVE_DEV  (0x04)
> -#define PDEV_BUS_OP_ADD_DEV     (0x08)
> -
> -#define PDEV_BUS_OP_INIT        (0x00)
> -
> -#define PDEV_BUS_OP             (0x00)
> -#define PDEV_BUS_GET_NAME       (0x04)
> -#define PDEV_BUS_NAME_LEN       (0x08)
> -#define PDEV_BUS_ID             (0x0c)
> -#define PDEV_BUS_IO_BASE        (0x10)
> -#define PDEV_BUS_IO_SIZE        (0x14)
> -#define PDEV_BUS_IRQ            (0x18)
> -#define PDEV_BUS_IRQ_COUNT      (0x1c)
> -#define PDEV_BUS_GET_NAME_HIGH  (0x20)
> -
> -struct pdev_bus_dev {
> -       struct list_head list;
> -       struct platform_device pdev;
> -       struct resource resources[0];
> -};
> -
> -static void goldfish_pdev_worker(struct work_struct *work);
> -
> -static void __iomem *pdev_bus_base;
> -static unsigned long pdev_bus_addr;
> -static unsigned long pdev_bus_len;
> -static u32 pdev_bus_irq;
> -static LIST_HEAD(pdev_bus_new_devices);
> -static LIST_HEAD(pdev_bus_registered_devices);
> -static LIST_HEAD(pdev_bus_removed_devices);
> -static DECLARE_WORK(pdev_bus_worker, goldfish_pdev_worker);
> -
> -
> -static void goldfish_pdev_worker(struct work_struct *work)
> -{
> -       int ret;
> -       struct pdev_bus_dev *pos, *n;
> -
> -       list_for_each_entry_safe(pos, n, &pdev_bus_removed_devices, list) {
> -               list_del(&pos->list);
> -               platform_device_unregister(&pos->pdev);
> -               kfree(pos);
> -       }
> -       list_for_each_entry_safe(pos, n, &pdev_bus_new_devices, list) {
> -               list_del(&pos->list);
> -               ret = platform_device_register(&pos->pdev);
> -               if (ret)
> -                       pr_err("goldfish_pdev_worker failed to register device, %s\n",
> -                                                               pos->pdev.name);
> -               list_add_tail(&pos->list, &pdev_bus_registered_devices);
> -       }
> -}
> -
> -static void goldfish_pdev_remove(void)
> -{
> -       struct pdev_bus_dev *pos, *n;
> -       u32 base;
> -
> -       base = readl(pdev_bus_base + PDEV_BUS_IO_BASE);
> -
> -       list_for_each_entry_safe(pos, n, &pdev_bus_new_devices, list) {
> -               if (pos->resources[0].start == base) {
> -                       list_del(&pos->list);
> -                       kfree(pos);
> -                       return;
> -               }
> -       }
> -       list_for_each_entry_safe(pos, n, &pdev_bus_registered_devices, list) {
> -               if (pos->resources[0].start == base) {
> -                       list_del(&pos->list);
> -                       list_add_tail(&pos->list, &pdev_bus_removed_devices);
> -                       schedule_work(&pdev_bus_worker);
> -                       return;
> -               }
> -       };
> -       pr_err("goldfish_pdev_remove could not find device at %x\n", base);
> -}
> -
> -static int goldfish_new_pdev(void)
> -{
> -       struct pdev_bus_dev *dev;
> -       u32 name_len;
> -       u32 irq = -1, irq_count;
> -       int resource_count = 2;
> -       u32 base;
> -       char *name;
> -
> -       base = readl(pdev_bus_base + PDEV_BUS_IO_BASE);
> -
> -       irq_count = readl(pdev_bus_base + PDEV_BUS_IRQ_COUNT);
> -       name_len = readl(pdev_bus_base + PDEV_BUS_NAME_LEN);
> -       if (irq_count)
> -               resource_count++;
> -
> -       dev = kzalloc(sizeof(*dev) +
> -               sizeof(struct resource) * resource_count +
> -               name_len + 1 + sizeof(*dev->pdev.dev.dma_mask), GFP_ATOMIC);
> -       if (dev == NULL)
> -               return -ENOMEM;
> -
> -       dev->pdev.num_resources = resource_count;
> -       dev->pdev.resource = (struct resource *)(dev + 1);
> -       dev->pdev.name = name = (char *)(dev->pdev.resource + resource_count);
> -       dev->pdev.dev.coherent_dma_mask = ~0;
> -       dev->pdev.dev.dma_mask = (void *)(dev->pdev.name + name_len + 1);
> -       *dev->pdev.dev.dma_mask = ~0;
> -
> -#ifdef CONFIG_64BIT
> -       writel((u32)((u64)name>>32), pdev_bus_base + PDEV_BUS_GET_NAME_HIGH);
> -#endif
> -       writel((u32)(unsigned long)name, pdev_bus_base + PDEV_BUS_GET_NAME);
> -       name[name_len] = '\0';
> -       dev->pdev.id = readl(pdev_bus_base + PDEV_BUS_ID);
> -       dev->pdev.resource[0].start = base;
> -       dev->pdev.resource[0].end = base +
> -                               readl(pdev_bus_base + PDEV_BUS_IO_SIZE) - 1;
> -       dev->pdev.resource[0].flags = IORESOURCE_MEM;
> -       if (irq_count) {
> -               irq = readl(pdev_bus_base + PDEV_BUS_IRQ);
> -               dev->pdev.resource[1].start = irq;
> -               dev->pdev.resource[1].end = irq + irq_count - 1;
> -               dev->pdev.resource[1].flags = IORESOURCE_IRQ;
> -       }
> -
> -       pr_debug("goldfish_new_pdev %s at %x irq %d\n", name, base, irq);
> -       list_add_tail(&dev->list, &pdev_bus_new_devices);
> -       schedule_work(&pdev_bus_worker);
> -
> -       return 0;
> -}
> -
> -static irqreturn_t goldfish_pdev_bus_interrupt(int irq, void *dev_id)
> -{
> -       irqreturn_t ret = IRQ_NONE;
> -
> -       while (1) {
> -               u32 op = readl(pdev_bus_base + PDEV_BUS_OP);
> -
> -               switch (op) {
> -               case PDEV_BUS_OP_REMOVE_DEV:
> -                       goldfish_pdev_remove();
> -                       ret = IRQ_HANDLED;
> -                       break;
> -
> -               case PDEV_BUS_OP_ADD_DEV:
> -                       goldfish_new_pdev();
> -                       ret = IRQ_HANDLED;
> -                       break;
> -
> -               case PDEV_BUS_OP_DONE:
> -               default:
> -                       return ret;
> -               }
> -       }
> -}
> -
> -static int goldfish_pdev_bus_probe(struct platform_device *pdev)
> -{
> -       int ret;
> -       struct resource *r;
> -
> -       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (r == NULL)
> -               return -EINVAL;
> -
> -       pdev_bus_addr = r->start;
> -       pdev_bus_len = resource_size(r);
> -
> -       pdev_bus_base = ioremap(pdev_bus_addr, pdev_bus_len);
> -       if (pdev_bus_base == NULL) {
> -               ret = -ENOMEM;
> -               dev_err(&pdev->dev, "unable to map Goldfish MMIO.\n");
> -               goto free_resources;
> -       }
> -
> -       r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -       if (r == NULL) {
> -               ret = -ENOENT;
> -               goto free_map;
> -       }
> -
> -       pdev_bus_irq = r->start;
> -
> -       ret = request_irq(pdev_bus_irq, goldfish_pdev_bus_interrupt,
> -                               IRQF_SHARED, "goldfish_pdev_bus", pdev);
> -       if (ret) {
> -               dev_err(&pdev->dev, "unable to request Goldfish IRQ\n");
> -               goto free_map;
> -       }
> -
> -       writel(PDEV_BUS_OP_INIT, pdev_bus_base + PDEV_BUS_OP);
> -       return 0;
> -
> -free_map:
> -       iounmap(pdev_bus_base);
> -free_resources:
> -       release_mem_region(pdev_bus_addr, pdev_bus_len);
> -       return ret;
> -}
> -
> -static struct platform_driver goldfish_pdev_bus_driver = {
> -       .probe = goldfish_pdev_bus_probe,
> -       .driver = {
> -               .name = "goldfish_pdev_bus"
> -       }
> -};
> -builtin_platform_driver(goldfish_pdev_bus_driver);
> --
> 2.18.0.203.gfac676dfb9-goog
>
