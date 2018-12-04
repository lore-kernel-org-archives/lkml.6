Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405ECC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D889A2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhUt1HGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D889A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLDJTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:19:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44517 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:19:01 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so12983205iod.11;
        Tue, 04 Dec 2018 01:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlTEIUk5RGdmKwnQ8TFwBDd7eqxl4e/D207nujMhGlc=;
        b=DhUt1HGunoNy9iA/534h1/767Cetx4YUCmPrBZaTCutLALx6rNM5UaN6WDJu6diWaM
         5saD7sOCBuZorlEp/5IT/59t3Ty3x72s/Fk5Cr1xv8+9PX5/Aa4LKJPDfMzGilNeNqXJ
         GU1mVEVKVExQwWGfKnNLtyBklKCq+h2I5i8zZrCwlGCX+EVtjH1IopgH7TiQHV2Qglvs
         LjLpGhazDed3xWOnR44yrOPCnY1bC1XrnUL1WC33l16GhzOgBZRaKAqbyVFPgUUAcfZJ
         fxCJ36bLOOG6xuLYDQbfFoUCcGCHx/5y1TvYLEaKvJpQk5RyujYYeiRT0TAZtGhfLwgA
         k17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlTEIUk5RGdmKwnQ8TFwBDd7eqxl4e/D207nujMhGlc=;
        b=nBVsyxlwYi1hUoaJuH0Z7eP7zH8Txz9OoCPKiT0Vy7i0pvWu19NV+PD0URY7b2SjuL
         QzfetEvS+V8xXIThuVaeQs0vQekBjSFLebuPhdy43s/puZA5k7lyJVqIMOaMsr4Uqy30
         JazAl9IZvYevNGSm6mQ5N35XxQAs26Xkx6zF3I5U/gJWQUvk/7j/Z+GZzV44yHDtsNwt
         uUBJIPaYNB7vJ0LhvYDlYLlR5M2KyZRnsjt3p3BlmWgsk7rVVHmUuhc1Th/WuzMGQ54p
         pEnFLiFPtd0F3pvCvyhS3aWZF4mJIomyj4rcPg0VvS6oKfYFVz62Tq4RKnK3Lywkl8D4
         QxRA==
X-Gm-Message-State: AA+aEWZaKJjVTCLvlZIxP+634cN/6LpwHuBERhlvADUEE25CuNF/gfN/
        fLNw+SlJ/8ih1NCljYzRk/1LeZqdm9/1KCwj3ss=
X-Google-Smtp-Source: AFSGD/WRoEhip7yaVyljTnwUJrQWXtAsFwUT0wMx+xMoRWnHIijhZymFWdnpZGitA8VT+vq7n0OSy/71uDgFhaEhTr0=
X-Received: by 2002:a5d:8989:: with SMTP id m9mr6813238iol.216.1543915140615;
 Tue, 04 Dec 2018 01:19:00 -0800 (PST)
MIME-Version: 1.0
References: <1542535751-16079-1-git-send-email-pawell@cadence.com> <1542535751-16079-6-git-send-email-pawell@cadence.com>
In-Reply-To: <1542535751-16079-6-git-send-email-pawell@cadence.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Tue, 4 Dec 2018 17:18:47 +0800
Message-ID: <CAL411-q878yGqRNUoLQVmQ7o8=qrVHryorxRnTeJeG8VzUOyZg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/15] usb:cdns3: Added DRD support
To:     pawell@cadence.com
Cc:     devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        lkml <linux-kernel@vger.kernel.org>, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 6:13 PM Pawel Laszczak <pawell@cadence.com> wrote:
>
> Patch adds supports for detecting Host/Device mode.
> Controller has additional OTG register that allow
> implement even whole OTG functionality.
> At this moment patch adds support only for detecting
> the appropriate mode based on strap pins and ID pin.
>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Makefile |   2 +-
>  drivers/usb/cdns3/core.c   |  27 +++--
>  drivers/usb/cdns3/drd.c    | 229 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/cdns3/drd.h    | 122 ++++++++++++++++++++
>  4 files changed, 372 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/usb/cdns3/drd.c
>  create mode 100644 drivers/usb/cdns3/drd.h
>
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index 02d25b23c5d3..e779b2a2f8eb 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_USB_CDNS3)                        += cdns3.o
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)       += cdns3-pci.o
>
> -cdns3-y                                        := core.o
> +cdns3-y                                        := core.o drd.o
>  cdns3-pci-y                            := cdns3-pci-wrap.o
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index f9055d4da67f..dbee4325da7f 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -17,6 +17,7 @@
>
>  #include "gadget.h"
>  #include "core.h"
> +#include "drd.h"
>
>  static inline struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
>  {
> @@ -57,8 +58,10 @@ static inline void cdns3_role_stop(struct cdns3 *cdns)
>  static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
>  {
>         if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
> -               //TODO: implements selecting device/host mode
> -               return CDNS3_ROLE_HOST;
> +               if (cdns3_is_host(cdns))
> +                       return CDNS3_ROLE_HOST;
> +               if (cdns3_is_device(cdns))
> +                       return CDNS3_ROLE_GADGET;
>         }
>         return cdns->roles[CDNS3_ROLE_HOST]
>                 ? CDNS3_ROLE_HOST
> @@ -124,6 +127,12 @@ static irqreturn_t cdns3_irq(int irq, void *data)
>         struct cdns3 *cdns = data;
>         irqreturn_t ret = IRQ_NONE;
>
> +       if (cdns->dr_mode == USB_DR_MODE_OTG) {
> +               ret = cdns3_drd_irq(cdns);
> +               if (ret == IRQ_HANDLED)
> +                       return ret;
> +       }
> +
>         /* Handle device/host interrupt */
>         if (cdns->role != CDNS3_ROLE_END)
>                 ret = cdns3_get_current_role_driver(cdns)->irq(cdns);
> @@ -176,11 +185,8 @@ static void cdns3_role_switch(struct work_struct *work)
>
>         cdns = container_of(work, struct cdns3, role_switch_wq);
>
> -       //TODO: implements this functions.
> -       //host = cdns3_is_host(cdns);
> -       //device = cdns3_is_device(cdns);
> -       host = 1;
> -       device = 0;
> +       host = cdns3_is_host(cdns);
> +       device = cdns3_is_device(cdns);
>
>         if (host)
>                 role = CDNS3_ROLE_HOST;
> @@ -194,6 +200,12 @@ static void cdns3_role_switch(struct work_struct *work)
>         pm_runtime_get_sync(cdns->dev);
>         cdns3_role_stop(cdns);
>
> +       if (cdns->desired_dr_mode != cdns->current_dr_mode) {
> +               cdns3_drd_update_mode(cdns);
> +               host = cdns3_is_host(cdns);
> +               device = cdns3_is_device(cdns);
> +       }
> +
>         if (host) {
>                 if (cdns->roles[CDNS3_ROLE_HOST])
>                         cdns3_do_role_switch(cdns, CDNS3_ROLE_HOST);
> @@ -287,6 +299,7 @@ static int cdns3_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err2;
>
> +       ret = cdns3_drd_init(cdns);
>         if (ret)
>                 goto err2;
>
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> new file mode 100644
> index 000000000000..ac741c80e776
> --- /dev/null
> +++ b/drivers/usb/cdns3/drd.c
> @@ -0,0 +1,229 @@
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
> +       switch (mode) {
> +       case USB_DR_MODE_PERIPHERAL:
> +               dev_info(cdns->dev, "Set controller to Gadget mode\n");
> +               writel(OTGCMD_DEV_BUS_REQ | OTGCMD_OTG_DIS,
> +                      &cdns->otg_regs->cmd);
> +               break;
> +       case USB_DR_MODE_HOST:
> +               dev_info(cdns->dev, "Set controller to Host mode\n");
> +               writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
> +                      &cdns->otg_regs->cmd);
> +               break;
> +       case USB_DR_MODE_OTG:
> +               dev_info(cdns->dev, "Set controller to OTG mode\n");
> +               reg = readl(&cdns->otg_regs->ctrl1);
> +               reg |= OTGCTRL1_IDPULLUP;
> +               writel(reg, &cdns->otg_regs->ctrl1);
> +
> +               /* wait until valid ID (ID_VALUE) can be sampled (50ms). */
> +               mdelay(50);

Usually, each big delay needs well documentation, eg, from hardware's
documentation.
And use sleep delay, eg, msleep or usleep_range.

> +               break;
> +       default:
> +               cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +               dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
> +               return;
> +       }
> +}
> +
> +static int cdns3_otg_get_id(struct cdns3 *cdns)
> +{
> +       int id;
> +
> +       id = readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
> +       dev_dbg(cdns->dev, "OTG ID: %d", id);
> +       return id;
> +}
> +
> +int cdns3_is_host(struct cdns3 *cdns)
> +{
> +       if (cdns->current_dr_mode == USB_DR_MODE_HOST)
> +               return 1;
> +       else if (cdns->current_dr_mode == USB_DR_MODE_OTG)
> +               if (!cdns3_otg_get_id(cdns))
> +                       return 1;
> +
> +       return 0;
> +}
> +
> +int cdns3_is_device(struct cdns3 *cdns)
> +{
> +       if (cdns->current_dr_mode == USB_DR_MODE_PERIPHERAL)
> +               return 1;
> +       else if (cdns->current_dr_mode == USB_DR_MODE_OTG)
> +               if (cdns3_otg_get_id(cdns))
> +                       return 1;
> +
> +       return 0;
> +}
> +

You could move above into cdns_get_role.

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
> +irqreturn_t cdns3_drd_irq(struct cdns3 *cdns)
> +{
> +       irqreturn_t ret = IRQ_NONE;
> +       u32 reg;
> +
> +       if (cdns->dr_mode != USB_DR_MODE_OTG)
> +               return ret;
> +
> +       reg = readl(&cdns->otg_regs->ivect);
> +       if (!reg)
> +               return ret;
> +
> +       if (reg & OTGIEN_ID_CHANGE_INT) {
> +               int id = cdns3_otg_get_id(cdns);
> +
> +               dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
> +                       cdns3_otg_get_id(cdns));
> +
> +               if (id)
> +                       cdns->role = CDNS3_ROLE_GADGET;
> +               else
> +                       cdns->role = CDNS3_ROLE_HOST;
> +
> +               queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       writel(~0, &cdns->otg_regs->ivect);
> +       return IRQ_HANDLED;
> +}
> +
> +int cdns3_drd_init(struct cdns3 *cdns)
> +{
> +       enum usb_dr_mode dr_mode;
> +       int ret = 0;
> +       u32 state;
> +
> +       state = OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
> +
> +       dr_mode = cdns->dr_mode;
> +       if (state == OTGSTS_STRAP_HOST) {
> +               dev_info(cdns->dev, "Controller strapped to HOST\n");
> +               dr_mode = USB_DR_MODE_HOST;
> +               if (cdns->dr_mode != USB_DR_MODE_HOST &&
> +                   cdns->dr_mode != USB_DR_MODE_OTG)
> +                       ret = -EINVAL;
> +       } else if (state == OTGSTS_STRAP_GADGET) {
> +               dev_info(cdns->dev, "Controller strapped to PERIPHERAL\n");
> +               dr_mode = USB_DR_MODE_PERIPHERAL;
> +               if (cdns->dr_mode != USB_DR_MODE_PERIPHERAL &&
> +                   cdns->dr_mode != USB_DR_MODE_OTG)
> +                       ret = -EINVAL;
> +       }
> +
> +       if (ret) {
> +               dev_err(cdns->dev, "Incorrect DRD configuration\n");
> +               return ret;
> +       }
> +
> +       //Updating DR mode according to strap.
> +       cdns->dr_mode = dr_mode;
> +       cdns->desired_dr_mode = dr_mode;
> +       cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +
> +       dev_info(cdns->dev, "Controller Device ID: %08lx, Revision ID: %08lx\n",
> +                CDNS_RID(readl(&cdns->otg_regs->rid)),
> +                CDNS_DID(readl(&cdns->otg_regs->did)));
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
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> new file mode 100644
> index 000000000000..0faa7520ecac
> --- /dev/null
> +++ b/drivers/usb/cdns3/drd.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USB3 DRD part of USBSS driver

Header file

Peter

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
> +/*  DRD register interface. */
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
> +/* CDNS_RID - bitmasks */
> +#define CDNS_RID(p)                    ((p) & GENMASK(15, 0))
> +
> +/* CDNS_VID - bitmasks */
> +#define CDNS_DID(p)                    ((p) & GENMASK(31, 0))
> +
> +/* OTGCMD - bitmasks */
> +/* "Request the bus for Device mode. */
> +#define OTGCMD_DEV_BUS_REQ     BIT(0)
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
> +#define OTGSTSE_XHCI_READYF            BIT(26)
> +/* "Device mode is turned on .*/
> +#define OTGSTS_DEV_READY               BIT(27)
> +
> +/* OTGREFCLK - bitmasks */
> +#define OTGREFCLK_STB_CLK_SWITCH_EN    BIT(31)
> +
> +/* OTGCTRL1 - bitmasks */
> +#define OTGCTRL1_IDPULLUP              BIT(24)
> +
> +int cdns3_is_host(struct cdns3 *cdns);
> +int cdns3_is_device(struct cdns3 *cdns);
> +int cdns3_drd_init(struct cdns3 *cdns);
> +int cdns3_drd_update_mode(struct cdns3 *cdns);
> +irqreturn_t cdns3_drd_irq(struct cdns3 *cdns);
> +
> +#endif /* __LINUX_CDNS3_DRD */
> --
> 2.17.1
>
