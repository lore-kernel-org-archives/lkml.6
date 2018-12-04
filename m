Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D99FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEB720666
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghZWeoCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEB720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeLDJJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:09:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:56263 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDJJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:09:22 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so14194025itg.5;
        Tue, 04 Dec 2018 01:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hrjj5tua2+mRjQ0OvS5JOGlmFxAl0kbkBqk70ABXb08=;
        b=ghZWeoCBEjYvP18ufNwXPLHszcxmQEHm2lwu44ri4m3PkENT/zDA11Muc/j7syAOQv
         iUUYH/aieS3rLS5wwEw8zRhlhaeKIqZL/5lvVqDWy8E0uH89kW1r81UoXn0qL4LxcH9W
         HmZ/v8EuxJrVSHArzZBP5AecW0Sg/aaQiMK4c8AvYT3FjR6yGrKIYPLfWU69JLXuHUcs
         eS82cfRUsQCnG1gDJXQIeD1SGAo6M3rySOLkVP+7DTh9Fq4ylHgvx4kq4L1jPWaJw/Wc
         xTmXZ01GtjkrkhqUECZjo78BhesJptV6Xh+e7X6Sc1ZS3WD2skZJk6tV9tpBQWAwsBWj
         ACnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hrjj5tua2+mRjQ0OvS5JOGlmFxAl0kbkBqk70ABXb08=;
        b=VobwHqhWkAIMZxW3jCMdTFgD1HCWebbyMuOmvBWBWzqYLhr0vNyoe0SIA9s3Zeqv7Z
         VTs+i74OtH0X05bETVkP5bzgoABgc+Z7YN6glJcaa4F+iSLLYf14FHDbH3El6S9ZdP6F
         zwbJd6QzLvkWL+1P3CShNy1UkgnHyh5hqJabST4/8iV8HqUEXn538yYPH6GnpmFNUsiL
         RVB7rwBPoX1UImiu5AkKSa2k/1eA5fDlvv4ecyEPuNgY5drv+Vt6ZvAmwTgd8lwFZD7K
         2cuAJ3kZgI7aLDaMMEJSz/ZruMA6j1aQ2tg93s5JFcWOYfqbjHro+PBWoi76vwnVKTW0
         OgxA==
X-Gm-Message-State: AA+aEWah/zw552uG6d/KnzvhOZ3ld1+6kkRIdMWft1xy5Hy/Q3gLjjw2
        RdpheTTg67XINuQd4Yowf8McOLoZoVtY7dlm7bk=
X-Google-Smtp-Source: AFSGD/UiBB23/GtDOHM0r5sYnwYCkUmt5O5ywkQZ10JLgM7qn03i03qQVt8KFlRFKOrBaO9iYm/5bGSzE5VpsJ+v3aU=
X-Received: by 2002:a24:fe41:: with SMTP id w62mr11449129ith.23.1543914559712;
 Tue, 04 Dec 2018 01:09:19 -0800 (PST)
MIME-Version: 1.0
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-5-git-send-email-pawell@cadence.com> <5BF7E5E8.3090406@ti.com>
 <BYAPR07MB47093E282D8B60572B4FBE01DDD60@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB47093E282D8B60572B4FBE01DDD60@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Tue, 4 Dec 2018 17:09:07 +0800
Message-ID: <CAL411-oO+Ng6xCF+VQKtvH5-h=Ns6H7fS9zrogF+gRoagpzt6g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
To:     pawell@cadence.com
Cc:     rogerq@ti.com, devicetree@vger.kernel.org,
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

> Hi Roger
>
> >On 18/11/18 12:09, Pawel Laszczak wrote:
> >> Patch adds core.c and core.h file that implements initialization
> >> of platform driver and adds function responsible for selecting,
> >> switching and running appropriate Device/Host mode.
> >>
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> ---
> >>  drivers/usb/cdns3/Makefile |   2 +
> >>  drivers/usb/cdns3/core.c   | 413 +++++++++++++++++++++++++++++++++++++
> >>  drivers/usb/cdns3/core.h   | 100 +++++++++
> >>  3 files changed, 515 insertions(+)
> >>  create mode 100644 drivers/usb/cdns3/core.c
> >>  create mode 100644 drivers/usb/cdns3/core.h
> >>
> >> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> >> index dcdd62003c6a..02d25b23c5d3 100644
> >> --- a/drivers/usb/cdns3/Makefile
> >> +++ b/drivers/usb/cdns3/Makefile
> >> @@ -1,3 +1,5 @@
> >> +obj-$(CONFIG_USB_CDNS3)                     += cdns3.o
> >>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)    += cdns3-pci.o
> >>
> >> +cdns3-y                                     := core.o
> >>  cdns3-pci-y                         := cdns3-pci-wrap.o
> >> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> >> new file mode 100644
> >> index 000000000000..f9055d4da67f
> >> --- /dev/null
> >> +++ b/drivers/usb/cdns3/core.c
> >> @@ -0,0 +1,413 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Cadence USBSS DRD Driver.
> >> + *
> >> + * Copyright (C) 2018 Cadence.
> >> + *
> >> + * Author: Peter Chen <peter.chen@nxp.com>
> >> + *         Pawel Laszczak <pawell@cadence.com>
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/io.h>
> >> +#include <linux/pm_runtime.h>
> >> +
> >> +#include "gadget.h"
> >> +#include "core.h"
> >> +
> >> +static inline struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> >> +{
> >> +    WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
> >> +    return cdns->roles[cdns->role];
> >> +}
> >> +
> >> +static inline int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
> >> +{
> >> +    int ret;
> >> +
> >> +    if (role >= CDNS3_ROLE_END)
> >
> >WARN_ON()?
> I agree.
> >
> >> +            return 0;
> >> +
> >> +    if (!cdns->roles[role])
> >> +            return -ENXIO;
> >> +
> >> +    mutex_lock(&cdns->mutex);
> >> +    cdns->role = role;
> >> +    ret = cdns->roles[role]->start(cdns);
> >> +    mutex_unlock(&cdns->mutex);
> >> +    return ret;
> >> +}
> >> +
> >> +static inline void cdns3_role_stop(struct cdns3 *cdns)
> >> +{
> >> +    enum cdns3_roles role = cdns->role;
> >> +
> >> +    if (role == CDNS3_ROLE_END)
> >
> >WARN_ON(role >= CNDS3_ROLE_END) ?
> I agree
> >
> >> +            return;
> >> +
> >> +    mutex_lock(&cdns->mutex);
> >> +    cdns->roles[role]->stop(cdns);
> >> +    cdns->role = CDNS3_ROLE_END;
> >
> >Why change the role here? You are just stopping the role not changing it.
> >I think cdns->role should remain unchanged, so we can call cdns3_role_start()
> >if required without error.
>
> This line is unnecessary.
>
> >
> >> +    mutex_unlock(&cdns->mutex);
> >> +}
> >> +
> >> +static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
> >> +{
> >> +    if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
> >> +            //TODO: implements selecting device/host mode
> >> +            return CDNS3_ROLE_HOST;
> >> +    }
> >> +    return cdns->roles[CDNS3_ROLE_HOST]
> >> +            ? CDNS3_ROLE_HOST
> >> +            : CDNS3_ROLE_GADGET;
> >
> >Why not just
> >       return cdns->role;
> >
> >I'm wondering if we really need this function
>
> TODO will look likie:
>                 if (cdns3_is_host(cdns))
>                         return CDNS3_ROLE_HOST;
>                 if (cdns3_is_device(cdns))
>                         return CDNS3_ROLE_GADGET;
>
> Function selects initial role. Before invoking it the role is unknown.
> I think that function name should be  changed because current name can be misleading.
>
> I will change it to cdns3_get_initial_role.
> .
> >> +}
> >
> >> +
> >> +/**
> >> + * cdns3_core_init_role - initialize role of operation
> >> + * @cdns: Pointer to cdns3 structure
> >> + *
> >> + * Returns 0 on success otherwise negative errno
> >> + */
> >> +static int cdns3_core_init_role(struct cdns3 *cdns)
> >> +{
> >> +    struct device *dev = cdns->dev;
> >> +    enum usb_dr_mode dr_mode;
> >> +
> >> +    dr_mode = usb_get_dr_mode(dev);
> >> +    cdns->role = CDNS3_ROLE_END;
> >> +
> >> +    /*
> >> +     * If driver can't read mode by means of usb_get_dr_mdoe function then
> >> +     * chooses mode according with Kernel configuration. This setting
> >> +     * can be restricted later depending on strap pin configuration.
> >> +     */
> >> +    if (dr_mode == USB_DR_MODE_UNKNOWN) {
> >> +            if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
> >> +                IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> >> +                    dr_mode = USB_DR_MODE_OTG;
> >> +            else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> >> +                    dr_mode = USB_DR_MODE_HOST;
> >> +            else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> >> +                    dr_mode = USB_DR_MODE_PERIPHERAL;
> >> +    }
> >> +
> >> +    if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> >> +            //TODO: implements host initialization
> >
> >               /* TODO: Add host role */ ?
> >
> >> +    }
> >> +
> >> +    if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
> >> +            //TODO: implements device initialization
> >
> >               /* TODO: Add device role */ ?
> >
> >> +    }
> >> +
> >> +    if (!cdns->roles[CDNS3_ROLE_HOST] && !cdns->roles[CDNS3_ROLE_GADGET]) {
> >> +            dev_err(dev, "no supported roles\n");
> >> +            return -ENODEV;
> >> +    }
> >> +
> >> +    cdns->dr_mode = dr_mode;
> >> +    return 0;
> >> +}
> >> +
> >> +/**
> >> + * cdns3_irq - interrupt handler for cdns3 core device
> >> + *
> >> + * @irq: irq number for cdns3 core device
> >> + * @data: structure of cdns3
> >> + *
> >> + * Returns IRQ_HANDLED or IRQ_NONE
> >> + */
> >> +static irqreturn_t cdns3_irq(int irq, void *data)
> >> +{
> >> +    struct cdns3 *cdns = data;
> >> +    irqreturn_t ret = IRQ_NONE;
> >> +
> >> +    /* Handle device/host interrupt */
> >> +    if (cdns->role != CDNS3_ROLE_END)
> >
> >Is it because of this that you need to set role to END at role_stop?
> >I think it is better to add a state variable to struct cdns3_role_driver, so we can
> >check if it is active or stopped.
> >
> >e.g.
> >       if (cdns3_get_current_role_driver(cdns)->state == CDNS3_ROLE_STATE_ACTIVE)
>
> Ok, I will do it in this way.
> >> +            ret = cdns3_get_current_role_driver(cdns)->irq(cdns);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static void cdns3_remove_roles(struct cdns3 *cdns)
> >
> >Should this be called cdns3_exit_roles() to be opposite of cdns3_init_roles()?
>
> Sounds better.
> I also change cdns3_host_remove to cdns3_host_exit and
> cdns3_gadget_remove to cdns3_gadget_exit.
> >
> >> +{
> >> +    //TODO: implements this function
> >> +}
> >
> >> +
> >> +static int cdns3_do_role_switch(struct cdns3 *cdns, enum cdns3_roles role)
> >> +{
> >> +    enum cdns3_roles current_role;
> >> +    int ret = 0;
> >> +
> >> +    current_role = cdns->role;
> >> +
> >> +    if (role == CDNS3_ROLE_END)
> >> +            return 0;
> >
> >role == END looks like error state. and it should never happen.
> >WARN here?
>
> Ok, will be changed.
> >

Please consider my comments which replied to Roger just now.

> >> +
> >> +    dev_dbg(cdns->dev, "Switching role");
> >> +
> >
> >Don't you have to stop the previous role before starting the new role?
> >
> >> +    ret = cdns3_role_start(cdns, role);
> >> +    if (ret) {
> >> +            /* Back to current role */
> >> +            dev_err(cdns->dev, "set %d has failed, back to %d\n",
> >> +                    role, current_role);
> >> +            ret = cdns3_role_start(cdns, current_role);
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +/**
> >> + * cdns3_role_switch - work queue handler for role switch
> >> + *
> >> + * @work: work queue item structure
> >> + *
> >> + * Handles below events:
> >> + * - Role switch for dual-role devices
> >> + * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
> >> + */
> >> +static void cdns3_role_switch(struct work_struct *work)
> >> +{
> >> +    enum cdns3_roles role = CDNS3_ROLE_END;
> >> +    struct cdns3 *cdns;
> >> +    bool device, host;
> >> +
> >> +    cdns = container_of(work, struct cdns3, role_switch_wq);
> >> +
> >> +    //TODO: implements this functions.
> >> +    //host = cdns3_is_host(cdns);
> >> +    //device = cdns3_is_device(cdns);
> >> +    host = 1;
> >> +    device = 0;
> >> +
> >> +    if (host)
> >> +            role = CDNS3_ROLE_HOST;
> >> +    else if (device)
> >> +            role = CDNS3_ROLE_GADGET;
> >> +
> >> +    if (cdns->desired_dr_mode == cdns->current_dr_mode &&
> >> +        cdns->role == role)
> >> +            return;
> >> +
> >
> >I think all the below code can be moved to cdns3_do_role_switch().
>
> Yes, I agree with you. cdns3_role_stop  should be in cdns3_do_role_switch.
>
> >> +    pm_runtime_get_sync(cdns->dev);
> >> +    cdns3_role_stop(cdns);
> >> +
> >> +    if (host) {
> >> +            if (cdns->roles[CDNS3_ROLE_HOST])
> >> +                    cdns3_do_role_switch(cdns, CDNS3_ROLE_HOST);
> >> +            pm_runtime_put_sync(cdns->dev);
> >> +            return;
> >> +    }
> >> +
> >> +    if (device)
> >> +            cdns3_do_role_switch(cdns, CDNS3_ROLE_GADGET);
> >> +    else
> >> +            cdns3_do_role_switch(cdns, CDNS3_ROLE_END);
> >> +
> >> +    pm_runtime_put_sync(cdns->dev);
> >> +}
> >> +
> >> +/**
> >> + * cdns3_probe - probe for cdns3 core device
> >> + * @pdev: Pointer to cdns3 core platform device
> >> + *
> >> + * Returns 0 on success otherwise negative errno
> >> + */
> >> +static int cdns3_probe(struct platform_device *pdev)
> >> +{
> >> +    struct device *dev = &pdev->dev;
> >> +    struct resource *res;
> >> +    struct cdns3 *cdns;
> >> +    void __iomem *regs;
> >> +    int ret;
> >> +
> >> +    cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> >> +    if (!cdns)
> >> +            return -ENOMEM;
> >> +
> >> +    cdns->dev = dev;
> >> +
> >> +    platform_set_drvdata(pdev, cdns);
> >> +
> >> +    res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >> +    if (!res) {
> >> +            dev_err(dev, "missing IRQ\n");
> >> +            return -ENODEV;
> >> +    }
> >> +    cdns->irq = res->start;
> >> +
> >> +    /*
> >> +     * Request memory region
> >> +     * region-0: xHCI
> >> +     * region-1: Peripheral
> >> +     * region-2: OTG registers
> >> +     */
> >
> >The memory region order is different from the dt-binding.
> >There it is OTG, host(xhci), device (peripheral).
>
> I corrected dt-binding.
> >
> >> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +    regs = devm_ioremap_resource(dev, res);
> >> +
> >> +    if (IS_ERR(regs))
> >> +            return PTR_ERR(regs);
> >> +    cdns->xhci_regs = regs;
> >> +    cdns->xhci_res = res;
> >> +
> >> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >> +    regs = devm_ioremap_resource(dev, res);
> >> +    if (IS_ERR(regs))
> >> +            return PTR_ERR(regs);
> >> +    cdns->dev_regs  = regs;
> >> +
> >> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> >> +    regs = devm_ioremap_resource(dev, res);
> >> +    if (IS_ERR(regs))
> >> +            return PTR_ERR(regs);
> >> +    cdns->otg_regs = regs;
> >> +
> >> +    mutex_init(&cdns->mutex);
> >> +
> >> +    cdns->phy = devm_phy_get(dev, "cdns3,usbphy");
> >
> >"cdns3,usbphy" is not documented in dt-binding.
>
> I assume that I should add  to dt-binding (cdns3-usb.txt) something like:
>  - phys: reference to the USB PHY
>  - phy-names: name of the USB PHY, should be " cdns3,usbphy "
>
> >
> >> +    if (IS_ERR(cdns->phy)) {
> >> +            dev_info(dev, "no generic phy found\n");
> >> +            cdns->phy = NULL;
> >> +            /*
> >> +             * fall through here!
> >> +             * if no generic phy found, phy init
> >> +             * should be done under boot!
> >> +             */
> >
> >No you shouldn't fall through always if it is an error condition.
> >Something like this should work better.
> >
> >        if (IS_ERR(cnds->phy)) {
> >                ret = PTR_ERR(cdns->phy);
> >                if (ret == -ENOSYS || ret == -ENODEV) {
> >                        cdns->phy = NULL;
> >                } else if (ret == -EPROBE_DEFER) {
> >                        return ret;
> >                } else {
> >                        dev_err(dev, "no phy found\n");
> >                        goto err0;
> >                }
> >        }
> >
> >So if PHY was provided in DT, and PHY support/drivers is present
> >and error condition means something is wrong and we have to error out.
> >
> >> +    } else {
> >> +            phy_init(cdns->phy);
> >> +    }
> >
> >You can do phy_init() outside the else.
> >
> Thank you for explanation. I will correct this.
> >> +
> >> +    ret = cdns3_core_init_role(cdns);
> >> +    if (ret)
> >> +            goto err1;
> >> +
> >> +    INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
> >> +    if (ret)
> >> +            goto err2;
> >> +
> >> +    if (ret)
> >> +            goto err2;
> >> +
> >> +    cdns->role = cdns3_get_role(cdns);
> >
> >I think this should move to cd I'll have a some though on ns3_core_init_role().
>
> Ok, I will do it.
> >
> >> +
> >> +    ret = devm_request_irq(dev, cdns->irq, cdns3_irq, IRQF_SHARED,
> >> +                           dev_name(dev), cdns);
> >> +
> >> +    if (ret)
> >> +            goto err2;
> >
> >How about moving request_irq to before cdsn3_core_init_role()?
> >
> >Then you can move cdns3_role_start() as well to core_init_role().
> I'll give it  some though on it, but probably I will probably have to change little other function..
> So the new order should look like this:
>
> cdns3_drd_init
> devm_request_irq
> cdns3_core_init_role, cdns3_get_role, cdns3_role_start
>
> >
> >> +
> >> +    ret = cdns3_role_start(cdns, cdns->role);
> >> +    if (ret) {
> >> +            dev_err(dev, "can't start %s role\n",
> >> +                    cdns3_get_current_role_driver(cdns)->name);
> >> +            goto err2;
> >> +    }
> >> +
> >> +    device_set_wakeup_capable(dev, true);
> >> +    pm_runtime_set_active(dev);
> >> +    pm_runtime_enable(dev);
> >> +
> >> +    /*
> >> +     * The controller needs less time between bus and controller suspend,
> >> +     * and we also needs a small delay to avoid frequently entering low
> >> +     * power mode.
> >> +     */
> >> +    pm_runtime_set_autosuspend_delay(dev, 20);
> >> +    pm_runtime_mark_last_busy(dev);
> >> +    pm_runtime_use_autosuspend(dev);
> >> +    dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
> >> +
> >> +    return 0;
> >> +
> >> +err2:
> >> +    cdns3_remove_roles(cdns);
> >> +err1:
> >
> >phy_exit() ?
> I will add.
> >
> >> +    return ret;
> >> +}
> >> +
> >> +/**
> >> + * cdns3_remove - unbind drd driver and clean up
> >> + * @pdev: Pointer to Linux platform device
> >> + *
> >> + * Returns 0 on success otherwise negative errno
> >> + */
> >> +static int cdns3_remove(struct platform_device *pdev)
> >> +{
> >> +    struct cdns3 *cdns = platform_get_drvdata(pdev);
> >> +
> >> +    pm_runtime_get_sync(&pdev->dev);
> >> +    pm_runtime_disable(&pdev->dev);
> >> +    pm_runtime_put_noidle(&pdev->dev);
> >> +    cdns3_remove_roles(cdns);
> >
> >phy_exit() ?
> I will add.
> >
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +#ifdef CONFIG_OF
> >> +static const struct of_device_id of_cdns3_match[] = {
> >> +    { .compatible = "cdns,usb3" },
> >> +    { },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, of_cdns3_match);
> >> +#endif
> >> +
> >> +#ifdef CONFIG_PM
> >> +
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int cdns3_suspend(struct device *dev)
> >> +{
> >> +    //TODO: implements this function
> >> +    return 0;
> >> +}
> >> +
> >> +static int cdns3_resume(struct device *dev)
> >> +{
> >> +    //TODO: implements this function
> >> +    return 0;
> >> +}
> >> +#endif /* CONFIG_PM_SLEEP */
> >> +static int cdns3_runtime_suspend(struct device *dev)
> >> +{   //TODO: implements this function
> >> +    return 0;
> >> +}
> >> +
> >> +static int cdns3_runtime_resume(struct device *dev)
> >> +{
> >> +    //TODO: implements this function
> >> +    return 0;
> >> +}
> >> +#endif /* CONFIG_PM */
> >> +
> >> +static const struct dev_pm_ops cdns3_pm_ops = {
> >> +    SET_SYSTEM_SLEEP_PM_OPS(cdns3_suspend, cdns3_resume)
> >> +    SET_RUNTIME_PM_OPS(cdns3_runtime_suspend, cdns3_runtime_resume, NULL)
> >> +};
> >> +
> >> +static struct platform_driver cdns3_driver = {
> >> +    .probe          = cdns3_probe,
> >> +    .remove         = cdns3_remove,
> >> +    .driver         = {
> >> +            .name   = "cdns-usb3",
> >> +            .of_match_table = of_match_ptr(of_cdns3_match),
> >> +            .pm     = &cdns3_pm_ops,
> >> +    },
> >> +};
> >> +
> >> +static int __init cdns3_driver_platform_register(void)
> >> +{
> >> +    return platform_driver_register(&cdns3_driver);
> >> +}
> >> +module_init(cdns3_driver_platform_register);
> >> +
> >> +static void __exit cdns3_driver_platform_unregister(void)
> >> +{
> >> +    platform_driver_unregister(&cdns3_driver);
> >> +}
> >> +module_exit(cdns3_driver_platform_unregister);
> >> +
> >> +MODULE_ALIAS("platform:cdns3");
> >> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> >> +MODULE_LICENSE("GPL v2");
> >> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> >> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> >> new file mode 100644
> >> index 000000000000..7c8204fe4d3d
> >> --- /dev/null
> >> +++ b/drivers/usb/cdns3/core.h
> >> @@ -0,0 +1,100 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Cadence USBSS DRD Driver.
> >> + *
> >> + * Copyright (C) 2017 NXP
> >> + * Copyright (C) 2018 Cadence.
> >> + *
> >> + * Authors: Peter Chen <peter.chen@nxp.com>
> >> + *          Pawel Laszczak <pawell@cadence.com>
> >> + */
> >> +#include <linux/usb/otg.h>
> >> +
> >> +#ifndef __LINUX_CDNS3_CORE_H
> >> +#define __LINUX_CDNS3_CORE_H
> >> +
> >> +struct cdns3;
> >> +enum cdns3_roles {
> >> +    CDNS3_ROLE_HOST = 0,
> >> +    CDNS3_ROLE_GADGET,
> >> +    CDNS3_ROLE_END,
> >> +};
> >> +
> >> +/**
> >> + * struct cdns3_role_driver - host/gadget role driver
> >> + * @start: start this role
> >> + * @stop: stop this role
> >> + * @suspend: suspend callback for this role
> >> + * @resume: resume callback for this role
> >> + * @irq: irq handler for this role
> >> + * @name: role name string (host/gadget)
> >> + */
> >> +struct cdns3_role_driver {
> >> +    int (*start)(struct cdns3 *cdns);
> >> +    void (*stop)(struct cdns3 *cdns);
> >> +    int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
> >> +    int (*resume)(struct cdns3 *cdns, bool hibernated);
> >> +    irqreturn_t (*irq)(struct cdns3 *cdns);
> >> +    const char *name;
> >> +};
> >> +
> >> +#define CDNS3_NUM_OF_CLKS   5
> >> +/**
> >> + * struct cdns3 - Representation of Cadence USB3 DRD controller.
> >> + * @dev: pointer to Cadence device struct
> >> + * @xhci_regs: pointer to base of xhci registers
> >> + * @xhci_res: the resource for xhci
> >> + * @dev_regs: pointer to base of dev registers
> >> + * @otg_regs: pointer to base of otg registers
> >> + * @irq: irq number for controller
> >> + * @roles: array of supported roles for this controller
> >> + * @role: current role
> >> + * @host_dev: the child host device pointer for cdns3 core
> >> + * @gadget_dev: the child gadget device pointer for cdns3 core
> >> + * @usb: phy for this controller
> >> + * @role_switch_wq: work queue item for role switch
> >> + * @in_lpm: the controller in low power mode
> >> + * @wakeup_int: the wakeup interrupt
> >> + * @mutex: the mutex for concurrent code at driver
> >> + * @dr_mode: supported mode of operation it can be only Host, only Device
> >> + *           or OTG mode that allow to switch between Device and Host mode.
> >> + *           This field based on hardware configuration and cant't be changed.
> >
> >But dr_mode can be forced in device-tree. So it isn't really only hardware configuration.
> Right, I added dr_mode to dt-binding , so we have STRAP bits in registers and additionally
> optional dr_mode in device-tree. Driver should take into account this two options.
> I will remove this line.
>
> >
> >> + * @current_dr_role: current mode of operation when in dual-role mode
> >> + * @desired_dr_role: desired mode of operation when in dual-role mode.
> >> + *           This value can be changed during runtime.
> >> + *           Available options depends on  dr_mode:
> >> + *           dr_mode                 |  desired_dr_role and current_dr_role
> >> + *           ----------------------------------------------------------------
> >> + *           USB_DR_MODE_HOST        | only USB_DR_MODE_HOST
> >> + *           USB_DR_MODE_PERIPHERAL  | only USB_DR_MODE_PERIPHERAL
> >> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_HOST
> >> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_PERIPHERAL
> >> + *           USB_DR_MODE_OTG         | USB_DR_MODE_OTG
> >
> >Do you need to update the right hand side to reflect ROLEs instead of MODE?
>
> I see that there are incorrect name. There should be mode instead role.
> In structure below the names are correct.
> >

Usually, we have two type of roles: init role and current role
init role is decided by dr_mode from firmware, hardware setting and
kernel configuration together.
It is decided at ->probe, if above three settings haveconflict, we
need show an error.
current role is decided at run time, and only used at dual-role mode.
For peripheral-only and host-only application, the current role equals
to init role.

Peter

> >> + *
> >> + *           Desired_dr_role can be changed by means of debugfs.
> >> + * @root: debugfs root folder pointer
> >> + */
> >> +struct cdns3 {
> >> +    struct device                   *dev;
> >> +    void __iomem                    *xhci_regs;
> >> +    struct resource                 *xhci_res;
> >> +    struct cdns3_usb_regs __iomem   *dev_regs;
> >> +    struct cdns3_otg_regs           *otg_regs;
> >> +    int irq;
> >> +    struct cdns3_role_driver        *roles[CDNS3_ROLE_END];
> >> +    enum cdns3_roles                role;
> >> +    struct device                   *host_dev;
> >> +    struct device                   *gadget_dev;
> >> +    struct phy                      *phy;
> >> +    struct work_struct              role_switch_wq;
> >> +    int                             in_lpm:1;
> >> +    int                             wakeup_int:1;
> >> +    /* mutext used in workqueue*/
> >> +    struct mutex                    mutex;
> >> +    enum usb_dr_mode                dr_mode;
> >> +    enum usb_dr_mode                current_dr_mode;
> >> +    enum usb_dr_mode                desired_dr_mode;
> >> +    struct dentry                   *root;
> >> +};
> >> +
> >> +#endif /* __LINUX_CDNS3_CORE_H */
> >>
> >
> >cheers,
> >-roger
> >--
> >Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> >Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
> Thank for all your comments,
> Cheers,
> Pawel
