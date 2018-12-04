Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C11C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE365214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3INz8z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE365214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbeLDIuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:50:40 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40885 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLDIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:50:40 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so13181704ita.5;
        Tue, 04 Dec 2018 00:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPvdq8J2yGb83a1zzElHocqVWn+yILD+nA5xn3NFg6M=;
        b=f3INz8z5d6OyJmdL0AqLl2WTu1/szLzehVTfcxA32O7jIPWe8Vo+33MROcHjMWCqfd
         Wu1DI5hae0kFmPr/gJ4qWNfSblb8H5q6iJI5BMK5/vFOFoY7JlN+cCPgruYut5pwUnLl
         I/yGqb8S9+JvQfrhDwbpe7QQ0YSYUC+v0BZRk2krZaSNEzg1fdSzQPYCStiO03nDdaAb
         bhfuIkZ8y9KG0vNo4ECrtJ0/HhBPh4mlktD4dLLto38qxBMhnKQYEMAiaEikjPWYMBeL
         HLMOjohlOsfIPeCXaGbw63ArpBwKJcbNM3aTetzSfGxLgxnk+26vwhbvTNdbSVReW1t8
         vn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPvdq8J2yGb83a1zzElHocqVWn+yILD+nA5xn3NFg6M=;
        b=GBaGYaGRlOcrrKDjWHpsP80YZEhn66dPoPxpkHjj4I5tMekhtzBghf3UmulgwZ05aE
         rfUNPvrBbhelDMYnYjvkjtNJeI/EwxvOvSiJr07EcNf3lqv26Vqru16x+9yXhjt1kKAO
         baZBaws5PoUlV6leGeyaVdP5s41wy9RE3SjnYp/R7Z3lllyR1wXe9VZiUj81rfOYExRl
         7pY6EzcsIVvJ0y7Dk7z/lz038xCHDZ7wApBuHR8KHlvUgyBWKc5sAUC+B5m9pvntbVm+
         iWrjioUtbK8boxuGQ6/83YZnC9Zby0pnTqzxPC1vSLim7FjcgvIHs6YBTIbUXleGxJFn
         2P+g==
X-Gm-Message-State: AA+aEWalFuYkYe7eGcMUruL82FhS/kqMXTmrm3aiHyX6aHVI854xwIT+
        yd87mDjvH6NbVVMe31nY2biFDaYWlYe5MtZ4UXg=
X-Google-Smtp-Source: AFSGD/W8m/mTj+Z2+xThS1ZKQ0kfzdMViJoUqAGwuDlMkI2sHByObGh55CqHJngMp7zDSQhqv75GmO8K6TmpoK5QvGI=
X-Received: by 2002:a24:c601:: with SMTP id j1mr4374045itg.130.1543913437922;
 Tue, 04 Dec 2018 00:50:37 -0800 (PST)
MIME-Version: 1.0
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-5-git-send-email-pawell@cadence.com> <5BF7E5E8.3090406@ti.com>
In-Reply-To: <5BF7E5E8.3090406@ti.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Tue, 4 Dec 2018 16:50:25 +0800
Message-ID: <CAL411-rWc23fbP0Ny9Kfdpe9ESUSVt5X00G1uFjJf+rj-2jWzg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
To:     rogerq@ti.com
Cc:     pawell@cadence.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        adouglas@cadence.com, jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com,
        sureshp@cadence.com, peter.chen@nxp.com, pjez@cadence.com,
        kurahul@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > + * Cadence USBSS DRD Driver.
> > + *
> > + * Copyright (C) 2018 Cadence.
> > + *
> > + * Author: Peter Chen <peter.chen@nxp.com>
> > + *         Pawel Laszczak <pawell@cadence.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#include "gadget.h"
> > +#include "core.h"
> > +
> > +static inline struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> > +{
> > +     WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
> > +     return cdns->roles[cdns->role];
> > +}
> > +
> > +static inline int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
> > +{
> > +     int ret;
> > +
> > +     if (role >= CDNS3_ROLE_END)
>
> WARN_ON()?
>
> > +             return 0;
> > +
> > +     if (!cdns->roles[role])
> > +             return -ENXIO;
> > +
> > +     mutex_lock(&cdns->mutex);
> > +     cdns->role = role;
> > +     ret = cdns->roles[role]->start(cdns);
> > +     mutex_unlock(&cdns->mutex);
> > +     return ret;
> > +}
> > +
> > +static inline void cdns3_role_stop(struct cdns3 *cdns)
> > +{
> > +     enum cdns3_roles role = cdns->role;
> > +
> > +     if (role == CDNS3_ROLE_END)
>
> WARN_ON(role >= CNDS3_ROLE_END) ?
>
> > +             return;
> > +
> > +     mutex_lock(&cdns->mutex);
> > +     cdns->roles[role]->stop(cdns);
> > +     cdns->role = CDNS3_ROLE_END;
>
> Why change the role here? You are just stopping the role not changing it.
> I think cdns->role should remain unchanged, so we can call cdns3_role_start()
> if required without error.
>

The current version of this IP has some issues to detect vbus status correctly,
we have to force vbus status accordingly, so we need a status to indicate
vbus disconnection, and add some code to let controller know vbus
removal, in that case, the controller's state machine can be correct.
So, we increase one role 'CDNS3_ROLE_END' to for this purpose.

CDNS3_ROLE_GADGET: gadget mode and VBUS on
CDNS3_ROLE_HOST: host mode and VBUS on
CDNS3_ROLE_END: VBUS off, eg either host or device cable on the port.

So, we may start role from CDNS3_ROLE_END at probe when nothing is connected,
and need to set role as CDNS3_ROLE_END at ->stop for further handling at
role switch routine.

> > +     mutex_unlock(&cdns->mutex);
> > +}
> > +
> > +static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
> > +{
> > +     if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
> > +             //TODO: implements selecting device/host mode
> > +             return CDNS3_ROLE_HOST;
> > +     }
> > +     return cdns->roles[CDNS3_ROLE_HOST]
> > +             ? CDNS3_ROLE_HOST
> > +             : CDNS3_ROLE_GADGET;
>
> Why not just
>         return cdns->role;
>
> I'm wondering if we really need this function.

cdns->role gets from cdns3_get_role, and this API tells role at the runtime.
If both roles are supported, the role is decided by external
conditions, eg, vbus/id
or external connector. If only single role is supported, only one role structure
is allocated, cdns->roles[CDNS3_ROLE_HOST] or cdns->roles[CDNS3_ROLE_GADGET]

> > +}
>
> > +
> > +/**
> > + * cdns3_core_init_role - initialize role of operation
> > + * @cdns: Pointer to cdns3 structure
> > + *
> > + * Returns 0 on success otherwise negative errno
> > + */
> > +static int cdns3_core_init_role(struct cdns3 *cdns)
> > +{
> > +     struct device *dev = cdns->dev;
> > +     enum usb_dr_mode dr_mode;
> > +
> > +     dr_mode = usb_get_dr_mode(dev);
> > +     cdns->role = CDNS3_ROLE_END;
> > +
> > +     /*
> > +      * If driver can't read mode by means of usb_get_dr_mdoe function then
> > +      * chooses mode according with Kernel configuration. This setting
> > +      * can be restricted later depending on strap pin configuration.
> > +      */
> > +     if (dr_mode == USB_DR_MODE_UNKNOWN) {
> > +             if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
> > +                 IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> > +                     dr_mode = USB_DR_MODE_OTG;
> > +             else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> > +                     dr_mode = USB_DR_MODE_HOST;
> > +             else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> > +                     dr_mode = USB_DR_MODE_PERIPHERAL;
> > +     }
> > +
> > +     if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> > +             //TODO: implements host initialization
>
>                 /* TODO: Add host role */ ?
>
> > +     }
> > +
> > +     if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
> > +             //TODO: implements device initialization
>
>                 /* TODO: Add device role */ ?
>

Yes, it needs to allocate cdns->roles[CDNS3_ROLE_HOST] and
cdns->roles[CDNS3_ROLE_GADGET].

> > +     }
> > +
> > +     if (!cdns->roles[CDNS3_ROLE_HOST] && !cdns->roles[CDNS3_ROLE_GADGET]) {
> > +             dev_err(dev, "no supported roles\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     cdns->dr_mode = dr_mode;

Pawel, why dr_mode needs to be introduced?

> > +     return 0;
> > +}
> > +
> > +/**
> > + * cdns3_irq - interrupt handler for cdns3 core device
> > + *
> > + * @irq: irq number for cdns3 core device
> > + * @data: structure of cdns3
> > + *
> > + * Returns IRQ_HANDLED or IRQ_NONE
> > + */
> > +static irqreturn_t cdns3_irq(int irq, void *data)
> > +{
> > +     struct cdns3 *cdns = data;
> > +     irqreturn_t ret = IRQ_NONE;
> > +
> > +     /* Handle device/host interrupt */
> > +     if (cdns->role != CDNS3_ROLE_END)
>
> Is it because of this that you need to set role to END at role_stop?
> I think it is better to add a state variable to struct cdns3_role_driver, so we can
> check if it is active or stopped.
>
> e.g.
>         if (cdns3_get_current_role_driver(cdns)->state == CDNS3_ROLE_STATE_ACTIVE)
>
> > +             ret = cdns3_get_current_role_driver(cdns)->irq(cdns);
> > +
> > +     return ret;
> > +}
> > +

 CDNS3_ROLE_END is introduced from above comments, we don't
need another flag for it.
If cdns->role == CDNS3_ROLE_END, it handles VBUS and ID interrupt.

> > +static void cdns3_remove_roles(struct cdns3 *cdns)
>
> Should this be called cdns3_exit_roles() to be opposite of cdns3_init_roles()?
>

It is planed to called when at ->remove.
> > +{
> > +     //TODO: implements this function
> > +}
>
> > +
> > +static int cdns3_do_role_switch(struct cdns3 *cdns, enum cdns3_roles role)
> > +{
> > +     enum cdns3_roles current_role;
> > +     int ret = 0;
> > +
> > +     current_role = cdns->role;
> > +
> > +     if (role == CDNS3_ROLE_END)
> > +             return 0;
>
> role == END looks like error state. and it should never happen.
> WARN here?
>

See my comments above.

> > +
> > +     dev_dbg(cdns->dev, "Switching role");
> > +
>
> Don't you have to stop the previous role before starting the new role?
>

Yes, it is needed. Pawel may simply some flows to suit his platform.

> > +     ret = cdns3_role_start(cdns, role);
> > +     if (ret) {
> > +             /* Back to current role */
> > +             dev_err(cdns->dev, "set %d has failed, back to %d\n",
> > +                     role, current_role);
> > +             ret = cdns3_role_start(cdns, current_role);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * cdns3_role_switch - work queue handler for role switch
> > + *
> > + * @work: work queue item structure
> > + *
> > + * Handles below events:
> > + * - Role switch for dual-role devices
> > + * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
> > + */
> > +static void cdns3_role_switch(struct work_struct *work)
> > +{
> > +     enum cdns3_roles role = CDNS3_ROLE_END;
> > +     struct cdns3 *cdns;
> > +     bool device, host;
> > +
> > +     cdns = container_of(work, struct cdns3, role_switch_wq);
> > +
> > +     //TODO: implements this functions.
> > +     //host = cdns3_is_host(cdns);
> > +     //device = cdns3_is_device(cdns);
> > +     host = 1;
> > +     device = 0;
> > +
> > +     if (host)
> > +             role = CDNS3_ROLE_HOST;
> > +     else if (device)
> > +             role = CDNS3_ROLE_GADGET;
> > +
> > +     if (cdns->desired_dr_mode == cdns->current_dr_mode &&
> > +         cdns->role == role)
> > +             return;
> > +
>
> I think all the below code can be moved to cdns3_do_role_switch().
>
> > +     pm_runtime_get_sync(cdns->dev);
> > +     cdns3_role_stop(cdns);
> > +
> > +     if (host) {
> > +             if (cdns->roles[CDNS3_ROLE_HOST])
> > +                     cdns3_do_role_switch(cdns, CDNS3_ROLE_HOST);
> > +             pm_runtime_put_sync(cdns->dev);
> > +             return;
> > +     }
> > +
> > +     if (device)
> > +             cdns3_do_role_switch(cdns, CDNS3_ROLE_GADGET);
> > +     else
> > +             cdns3_do_role_switch(cdns, CDNS3_ROLE_END);
> > +
> > +     pm_runtime_put_sync(cdns->dev);
> > +}
> > +
> > +/**
> > + * cdns3_probe - probe for cdns3 core device
> > + * @pdev: Pointer to cdns3 core platform device
> > + *
> > + * Returns 0 on success otherwise negative errno
> > + */
> > +static int cdns3_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct resource *res;
> > +     struct cdns3 *cdns;
> > +     void __iomem *regs;
> > +     int ret;
> > +
> > +     cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> > +     if (!cdns)
> > +             return -ENOMEM;
> > +
> > +     cdns->dev = dev;
> > +
> > +     platform_set_drvdata(pdev, cdns);
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +     if (!res) {
> > +             dev_err(dev, "missing IRQ\n");
> > +             return -ENODEV;
> > +     }
> > +     cdns->irq = res->start;
> > +
> > +     /*
> > +      * Request memory region
> > +      * region-0: xHCI
> > +      * region-1: Peripheral
> > +      * region-2: OTG registers
> > +      */
>
> The memory region order is different from the dt-binding.
> There it is OTG, host(xhci), device (peripheral).
>
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     regs = devm_ioremap_resource(dev, res);
> > +
> > +     if (IS_ERR(regs))
> > +             return PTR_ERR(regs);
> > +     cdns->xhci_regs = regs;
> > +     cdns->xhci_res = res;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +     regs = devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(regs))
> > +             return PTR_ERR(regs);
> > +     cdns->dev_regs  = regs;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> > +     regs = devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(regs))
> > +             return PTR_ERR(regs);
> > +     cdns->otg_regs = regs;
> > +
> > +     mutex_init(&cdns->mutex);
> > +
> > +     cdns->phy = devm_phy_get(dev, "cdns3,usbphy");
>
> "cdns3,usbphy" is not documented in dt-binding.
>
> > +     if (IS_ERR(cdns->phy)) {
> > +             dev_info(dev, "no generic phy found\n");
> > +             cdns->phy = NULL;
> > +             /*
> > +              * fall through here!
> > +              * if no generic phy found, phy init
> > +              * should be done under boot!
> > +              */
>
> No you shouldn't fall through always if it is an error condition.
> Something like this should work better.
>
>         if (IS_ERR(cnds->phy)) {
>                 ret = PTR_ERR(cdns->phy);
>                 if (ret == -ENOSYS || ret == -ENODEV) {
>                         cdns->phy = NULL;
>                 } else if (ret == -EPROBE_DEFER) {
>                         return ret;
>                 } else {
>                         dev_err(dev, "no phy found\n");
>                         goto err0;
>                 }
>         }
>
> So if PHY was provided in DT, and PHY support/drivers is present
> and error condition means something is wrong and we have to error out.
>
> > +     } else {
> > +             phy_init(cdns->phy);
> > +     }
>
> You can do phy_init() outside the else.
>
> > +
> > +     ret = cdns3_core_init_role(cdns);
> > +     if (ret)
> > +             goto err1;
> > +
> > +     INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
> > +     if (ret)
> > +             goto err2;
> > +
> > +     if (ret)
> > +             goto err2;
> > +
> > +     cdns->role = cdns3_get_role(cdns);
>
> I think this should move to cdns3_core_init_role().
>

I agree.

> > +
> > +     ret = devm_request_irq(dev, cdns->irq, cdns3_irq, IRQF_SHARED,
> > +                            dev_name(dev), cdns);
> > +
> > +     if (ret)
> > +             goto err2;
>
> How about moving request_irq to before cdsn3_core_init_role()?
>
> Then you can move cdns3_role_start() as well to core_init_role().
>

Usually, we request irq after hardware initialization has finished, if not,
there may unexpected interrupt.

Peter

> > +
> > +     ret = cdns3_role_start(cdns, cdns->role);
> > +     if (ret) {
> > +             dev_err(dev, "can't start %s role\n",
> > +                     cdns3_get_current_role_driver(cdns)->name);
> > +             goto err2;
> > +     }
> > +
> > +     device_set_wakeup_capable(dev, true);
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_enable(dev);
> > +
> > +     /*
> > +      * The controller needs less time between bus and controller suspend,
> > +      * and we also needs a small delay to avoid frequently entering low
> > +      * power mode.
> > +      */
> > +     pm_runtime_set_autosuspend_delay(dev, 20);
> > +     pm_runtime_mark_last_busy(dev);
> > +     pm_runtime_use_autosuspend(dev);
> > +     dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
> > +
> > +     return 0;
> > +
> > +err2:
> > +     cdns3_remove_roles(cdns);
> > +err1:
>
> phy_exit() ?
>
> > +     return ret;
> > +}
> > +
> > +/**
> > + * cdns3_remove - unbind drd driver and clean up
> > + * @pdev: Pointer to Linux platform device
> > + *
> > + * Returns 0 on success otherwise negative errno
> > + */
> > +static int cdns3_remove(struct platform_device *pdev)
> > +{
> > +     struct cdns3 *cdns = platform_get_drvdata(pdev);
> > +
> > +     pm_runtime_get_sync(&pdev->dev);
> > +     pm_runtime_disable(&pdev->dev);
> > +     pm_runtime_put_noidle(&pdev->dev);
> > +     cdns3_remove_roles(cdns);
>
> phy_exit() ?
>
> > +
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id of_cdns3_match[] = {
> > +     { .compatible = "cdns,usb3" },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, of_cdns3_match);
> > +#endif
> > +
> > +#ifdef CONFIG_PM
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int cdns3_suspend(struct device *dev)
> > +{
> > +     //TODO: implements this function
> > +     return 0;
> > +}
> > +
> > +static int cdns3_resume(struct device *dev)
> > +{
> > +     //TODO: implements this function
> > +     return 0;
> > +}
> > +#endif /* CONFIG_PM_SLEEP */
> > +static int cdns3_runtime_suspend(struct device *dev)
> > +{    //TODO: implements this function
> > +     return 0;
> > +}
> > +
> > +static int cdns3_runtime_resume(struct device *dev)
> > +{
> > +     //TODO: implements this function
> > +     return 0;
> > +}
> > +#endif /* CONFIG_PM */
> > +
> > +static const struct dev_pm_ops cdns3_pm_ops = {
> > +     SET_SYSTEM_SLEEP_PM_OPS(cdns3_suspend, cdns3_resume)
> > +     SET_RUNTIME_PM_OPS(cdns3_runtime_suspend, cdns3_runtime_resume, NULL)
> > +};
> > +
> > +static struct platform_driver cdns3_driver = {
> > +     .probe          = cdns3_probe,
> > +     .remove         = cdns3_remove,
> > +     .driver         = {
> > +             .name   = "cdns-usb3",
> > +             .of_match_table = of_match_ptr(of_cdns3_match),
> > +             .pm     = &cdns3_pm_ops,
> > +     },
> > +};
> > +
> > +static int __init cdns3_driver_platform_register(void)
> > +{
> > +     return platform_driver_register(&cdns3_driver);
> > +}
> > +module_init(cdns3_driver_platform_register);
> > +
> > +static void __exit cdns3_driver_platform_unregister(void)
> > +{
> > +     platform_driver_unregister(&cdns3_driver);
> > +}
> > +module_exit(cdns3_driver_platform_unregister);
> > +
> > +MODULE_ALIAS("platform:cdns3");
> > +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> > diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> > new file mode 100644
> > index 000000000000..7c8204fe4d3d
> > --- /dev/null
> > +++ b/drivers/usb/cdns3/core.h
> > @@ -0,0 +1,100 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Cadence USBSS DRD Driver.
> > + *
> > + * Copyright (C) 2017 NXP
> > + * Copyright (C) 2018 Cadence.
> > + *
> > + * Authors: Peter Chen <peter.chen@nxp.com>
> > + *          Pawel Laszczak <pawell@cadence.com>
> > + */
> > +#include <linux/usb/otg.h>
> > +
> > +#ifndef __LINUX_CDNS3_CORE_H
> > +#define __LINUX_CDNS3_CORE_H
> > +
> > +struct cdns3;
> > +enum cdns3_roles {
> > +     CDNS3_ROLE_HOST = 0,
> > +     CDNS3_ROLE_GADGET,
> > +     CDNS3_ROLE_END,
> > +};
> > +
> > +/**
> > + * struct cdns3_role_driver - host/gadget role driver
> > + * @start: start this role
> > + * @stop: stop this role
> > + * @suspend: suspend callback for this role
> > + * @resume: resume callback for this role
> > + * @irq: irq handler for this role
> > + * @name: role name string (host/gadget)
> > + */
> > +struct cdns3_role_driver {
> > +     int (*start)(struct cdns3 *cdns);
> > +     void (*stop)(struct cdns3 *cdns);
> > +     int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
> > +     int (*resume)(struct cdns3 *cdns, bool hibernated);
> > +     irqreturn_t (*irq)(struct cdns3 *cdns);
> > +     const char *name;
> > +};
> > +
> > +#define CDNS3_NUM_OF_CLKS    5
> > +/**
> > + * struct cdns3 - Representation of Cadence USB3 DRD controller.
> > + * @dev: pointer to Cadence device struct
> > + * @xhci_regs: pointer to base of xhci registers
> > + * @xhci_res: the resource for xhci
> > + * @dev_regs: pointer to base of dev registers
> > + * @otg_regs: pointer to base of otg registers
> > + * @irq: irq number for controller
> > + * @roles: array of supported roles for this controller
> > + * @role: current role
> > + * @host_dev: the child host device pointer for cdns3 core
> > + * @gadget_dev: the child gadget device pointer for cdns3 core
> > + * @usb: phy for this controller
> > + * @role_switch_wq: work queue item for role switch
> > + * @in_lpm: the controller in low power mode
> > + * @wakeup_int: the wakeup interrupt
> > + * @mutex: the mutex for concurrent code at driver
> > + * @dr_mode: supported mode of operation it can be only Host, only Device
> > + *           or OTG mode that allow to switch between Device and Host mode.
> > + *           This field based on hardware configuration and cant't be changed.
>
> But dr_mode can be forced in device-tree. So it isn't really only hardware configuration.
>
> > + * @current_dr_role: current mode of operation when in dual-role mode
> > + * @desired_dr_role: desired mode of operation when in dual-role mode.
> > + *           This value can be changed during runtime.
> > + *           Available options depends on  dr_mode:
> > + *           dr_mode                 |  desired_dr_role and current_dr_role
> > + *           ----------------------------------------------------------------
> > + *           USB_DR_MODE_HOST        | only USB_DR_MODE_HOST
> > + *           USB_DR_MODE_PERIPHERAL  | only USB_DR_MODE_PERIPHERAL
> > + *           USB_DR_MODE_OTG         | only USB_DR_MODE_HOST
> > + *           USB_DR_MODE_OTG         | only USB_DR_MODE_PERIPHERAL
> > + *           USB_DR_MODE_OTG         | USB_DR_MODE_OTG
>
> Do you need to update the right hand side to reflect ROLEs instead of MODE?
>
> > + *
> > + *           Desired_dr_role can be changed by means of debugfs.
> > + * @root: debugfs root folder pointer
> > + */
> > +struct cdns3 {
> > +     struct device                   *dev;
> > +     void __iomem                    *xhci_regs;
> > +     struct resource                 *xhci_res;
> > +     struct cdns3_usb_regs __iomem   *dev_regs;
> > +     struct cdns3_otg_regs           *otg_regs;
> > +     int irq;
> > +     struct cdns3_role_driver        *roles[CDNS3_ROLE_END];
> > +     enum cdns3_roles                role;
> > +     struct device                   *host_dev;
> > +     struct device                   *gadget_dev;
> > +     struct phy                      *phy;
> > +     struct work_struct              role_switch_wq;
> > +     int                             in_lpm:1;
> > +     int                             wakeup_int:1;
> > +     /* mutext used in workqueue*/
> > +     struct mutex                    mutex;
> > +     enum usb_dr_mode                dr_mode;
> > +     enum usb_dr_mode                current_dr_mode;
> > +     enum usb_dr_mode                desired_dr_mode;
> > +     struct dentry                   *root;
> > +};
> > +
> > +#endif /* __LINUX_CDNS3_CORE_H */
> >
>
> cheers,
> -roger
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
