Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D51C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38372087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ocdt+uBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38372087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLDKqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:46:19 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49656 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDKqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:46:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB4AkCw8028646;
        Tue, 4 Dec 2018 04:46:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543920372;
        bh=R1yKLBmdJys6hh7yvq8gRSTq+QAAxvCGv1gm9K0j4wc=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=ocdt+uBNeLdoeIOAllzY4rB2fgpKX77gQB/UCc60g6kUjkNnvGxc9Z7YUPEq0D2wC
         Six+TammpY15nXyRA9RwVYDtFWoBbf1S/kMOQGeC8A7Nyg4j0C+ibjeBVbp9I+3qr/
         uZl/Stjdy2oDKXw7xHmnnKAv9byK4QACTADHpeY4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB4AkCGI120835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 04:46:12 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 04:46:10 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 04:46:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB4Ak73w009716;
        Tue, 4 Dec 2018 04:46:07 -0600
Subject: Re: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
To:     Peter Chen <hzpeterchen@gmail.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-5-git-send-email-pawell@cadence.com>
 <5BF7E5E8.3090406@ti.com>
 <CAL411-rWc23fbP0Ny9Kfdpe9ESUSVt5X00G1uFjJf+rj-2jWzg@mail.gmail.com>
CC:     <pawell@cadence.com>, <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nsekhar@ti.com>,
        <nm@ti.com>, <sureshp@cadence.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C065AEE.4010205@ti.com>
Date:   Tue, 4 Dec 2018 12:46:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CAL411-rWc23fbP0Ny9Kfdpe9ESUSVt5X00G1uFjJf+rj-2jWzg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/18 10:50, Peter Chen wrote:
>>> + * Cadence USBSS DRD Driver.
>>> + *
>>> + * Copyright (C) 2018 Cadence.
>>> + *
>>> + * Author: Peter Chen <peter.chen@nxp.com>
>>> + *         Pawel Laszczak <pawell@cadence.com>
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/pm_runtime.h>
>>> +
>>> +#include "gadget.h"
>>> +#include "core.h"
>>> +
>>> +static inline struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
>>> +{
>>> +     WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
>>> +     return cdns->roles[cdns->role];
>>> +}
>>> +
>>> +static inline int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
>>> +{
>>> +     int ret;
>>> +
>>> +     if (role >= CDNS3_ROLE_END)
>>
>> WARN_ON()?
>>
>>> +             return 0;
>>> +
>>> +     if (!cdns->roles[role])
>>> +             return -ENXIO;
>>> +
>>> +     mutex_lock(&cdns->mutex);
>>> +     cdns->role = role;
>>> +     ret = cdns->roles[role]->start(cdns);
>>> +     mutex_unlock(&cdns->mutex);
>>> +     return ret;
>>> +}
>>> +
>>> +static inline void cdns3_role_stop(struct cdns3 *cdns)
>>> +{
>>> +     enum cdns3_roles role = cdns->role;
>>> +
>>> +     if (role == CDNS3_ROLE_END)
>>
>> WARN_ON(role >= CNDS3_ROLE_END) ?
>>
>>> +             return;
>>> +
>>> +     mutex_lock(&cdns->mutex);
>>> +     cdns->roles[role]->stop(cdns);
>>> +     cdns->role = CDNS3_ROLE_END;
>>
>> Why change the role here? You are just stopping the role not changing it.
>> I think cdns->role should remain unchanged, so we can call cdns3_role_start()
>> if required without error.
>>
> 
> The current version of this IP has some issues to detect vbus status correctly,
> we have to force vbus status accordingly, so we need a status to indicate
> vbus disconnection, and add some code to let controller know vbus
> removal, in that case, the controller's state machine can be correct.
> So, we increase one role 'CDNS3_ROLE_END' to for this purpose.
> 
> CDNS3_ROLE_GADGET: gadget mode and VBUS on
> CDNS3_ROLE_HOST: host mode and VBUS on
> CDNS3_ROLE_END: VBUS off, eg either host or device cable on the port.
> 
> So, we may start role from CDNS3_ROLE_END at probe when nothing is connected,
> and need to set role as CDNS3_ROLE_END at ->stop for further handling at
> role switch routine.

OK. but still this (changing to ROLE_END) must be moved to the role switch routine
and the explanation you just mentioned must be added there.

> 
>>> +     mutex_unlock(&cdns->mutex);
>>> +}
>>> +
>>> +static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
>>> +{
>>> +     if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
>>> +             //TODO: implements selecting device/host mode
>>> +             return CDNS3_ROLE_HOST;
>>> +     }
>>> +     return cdns->roles[CDNS3_ROLE_HOST]
>>> +             ? CDNS3_ROLE_HOST
>>> +             : CDNS3_ROLE_GADGET;
>>
>> Why not just
>>         return cdns->role;
>>
>> I'm wondering if we really need this function.
> 
> cdns->role gets from cdns3_get_role, and this API tells role at the runtime.
> If both roles are supported, the role is decided by external
> conditions, eg, vbus/id
> or external connector. If only single role is supported, only one role structure
> is allocated, cdns->roles[CDNS3_ROLE_HOST] or cdns->roles[CDNS3_ROLE_GADGET]
> 

How about adding this description in function documentation.

>>> +}
>>
>>> +
>>> +/**
>>> + * cdns3_core_init_role - initialize role of operation
>>> + * @cdns: Pointer to cdns3 structure
>>> + *
>>> + * Returns 0 on success otherwise negative errno
>>> + */
>>> +static int cdns3_core_init_role(struct cdns3 *cdns)
>>> +{
>>> +     struct device *dev = cdns->dev;
>>> +     enum usb_dr_mode dr_mode;
>>> +
>>> +     dr_mode = usb_get_dr_mode(dev);
>>> +     cdns->role = CDNS3_ROLE_END;
>>> +
>>> +     /*
>>> +      * If driver can't read mode by means of usb_get_dr_mdoe function then
>>> +      * chooses mode according with Kernel configuration. This setting
>>> +      * can be restricted later depending on strap pin configuration.
>>> +      */
>>> +     if (dr_mode == USB_DR_MODE_UNKNOWN) {
>>> +             if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
>>> +                 IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
>>> +                     dr_mode = USB_DR_MODE_OTG;
>>> +             else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
>>> +                     dr_mode = USB_DR_MODE_HOST;
>>> +             else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
>>> +                     dr_mode = USB_DR_MODE_PERIPHERAL;
>>> +     }
>>> +
>>> +     if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
>>> +             //TODO: implements host initialization
>>
>>                 /* TODO: Add host role */ ?
>>
>>> +     }
>>> +
>>> +     if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
>>> +             //TODO: implements device initialization
>>
>>                 /* TODO: Add device role */ ?
>>
> 
> Yes, it needs to allocate cdns->roles[CDNS3_ROLE_HOST] and
> cdns->roles[CDNS3_ROLE_GADGET].
> 
>>> +     }
>>> +
>>> +     if (!cdns->roles[CDNS3_ROLE_HOST] && !cdns->roles[CDNS3_ROLE_GADGET]) {
>>> +             dev_err(dev, "no supported roles\n");
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     cdns->dr_mode = dr_mode;
> 
> Pawel, why dr_mode needs to be introduced?
> 
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * cdns3_irq - interrupt handler for cdns3 core device
>>> + *
>>> + * @irq: irq number for cdns3 core device
>>> + * @data: structure of cdns3
>>> + *
>>> + * Returns IRQ_HANDLED or IRQ_NONE
>>> + */
>>> +static irqreturn_t cdns3_irq(int irq, void *data)
>>> +{
>>> +     struct cdns3 *cdns = data;
>>> +     irqreturn_t ret = IRQ_NONE;
>>> +
>>> +     /* Handle device/host interrupt */
>>> +     if (cdns->role != CDNS3_ROLE_END)
>>
>> Is it because of this that you need to set role to END at role_stop?
>> I think it is better to add a state variable to struct cdns3_role_driver, so we can
>> check if it is active or stopped.
>>
>> e.g.
>>         if (cdns3_get_current_role_driver(cdns)->state == CDNS3_ROLE_STATE_ACTIVE)
>>
>>> +             ret = cdns3_get_current_role_driver(cdns)->irq(cdns);
>>> +
>>> +     return ret;
>>> +}
>>> +
> 
>  CDNS3_ROLE_END is introduced from above comments, we don't
> need another flag for it.
> If cdns->role == CDNS3_ROLE_END, it handles VBUS and ID interrupt.
> 
>>> +static void cdns3_remove_roles(struct cdns3 *cdns)
>>
>> Should this be called cdns3_exit_roles() to be opposite of cdns3_init_roles()?
>>
> 
> It is planed to called when at ->remove.
>>> +{
>>> +     //TODO: implements this function
>>> +}
>>
>>> +
>>> +static int cdns3_do_role_switch(struct cdns3 *cdns, enum cdns3_roles role)
>>> +{
>>> +     enum cdns3_roles current_role;
>>> +     int ret = 0;
>>> +
>>> +     current_role = cdns->role;
>>> +
>>> +     if (role == CDNS3_ROLE_END)
>>> +             return 0;
>>
>> role == END looks like error state. and it should never happen.
>> WARN here?
>>
> 
> See my comments above.
> 
>>> +
>>> +     dev_dbg(cdns->dev, "Switching role");
>>> +
>>
>> Don't you have to stop the previous role before starting the new role?
>>
> 
> Yes, it is needed. Pawel may simply some flows to suit his platform.
> 
>>> +     ret = cdns3_role_start(cdns, role);
>>> +     if (ret) {
>>> +             /* Back to current role */
>>> +             dev_err(cdns->dev, "set %d has failed, back to %d\n",
>>> +                     role, current_role);
>>> +             ret = cdns3_role_start(cdns, current_role);
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +/**
>>> + * cdns3_role_switch - work queue handler for role switch
>>> + *
>>> + * @work: work queue item structure
>>> + *
>>> + * Handles below events:
>>> + * - Role switch for dual-role devices
>>> + * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
>>> + */
>>> +static void cdns3_role_switch(struct work_struct *work)
>>> +{
>>> +     enum cdns3_roles role = CDNS3_ROLE_END;
>>> +     struct cdns3 *cdns;
>>> +     bool device, host;
>>> +
>>> +     cdns = container_of(work, struct cdns3, role_switch_wq);
>>> +
>>> +     //TODO: implements this functions.
>>> +     //host = cdns3_is_host(cdns);
>>> +     //device = cdns3_is_device(cdns);
>>> +     host = 1;
>>> +     device = 0;
>>> +
>>> +     if (host)
>>> +             role = CDNS3_ROLE_HOST;
>>> +     else if (device)
>>> +             role = CDNS3_ROLE_GADGET;
>>> +
>>> +     if (cdns->desired_dr_mode == cdns->current_dr_mode &&
>>> +         cdns->role == role)
>>> +             return;
>>> +
>>
>> I think all the below code can be moved to cdns3_do_role_switch().
>>
>>> +     pm_runtime_get_sync(cdns->dev);
>>> +     cdns3_role_stop(cdns);
>>> +
>>> +     if (host) {
>>> +             if (cdns->roles[CDNS3_ROLE_HOST])
>>> +                     cdns3_do_role_switch(cdns, CDNS3_ROLE_HOST);
>>> +             pm_runtime_put_sync(cdns->dev);
>>> +             return;
>>> +     }
>>> +
>>> +     if (device)
>>> +             cdns3_do_role_switch(cdns, CDNS3_ROLE_GADGET);
>>> +     else
>>> +             cdns3_do_role_switch(cdns, CDNS3_ROLE_END);
>>> +
>>> +     pm_runtime_put_sync(cdns->dev);
>>> +}
>>> +
>>> +/**
>>> + * cdns3_probe - probe for cdns3 core device
>>> + * @pdev: Pointer to cdns3 core platform device
>>> + *
>>> + * Returns 0 on success otherwise negative errno
>>> + */
>>> +static int cdns3_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     struct resource *res;
>>> +     struct cdns3 *cdns;
>>> +     void __iomem *regs;
>>> +     int ret;
>>> +
>>> +     cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
>>> +     if (!cdns)
>>> +             return -ENOMEM;
>>> +
>>> +     cdns->dev = dev;
>>> +
>>> +     platform_set_drvdata(pdev, cdns);
>>> +
>>> +     res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>> +     if (!res) {
>>> +             dev_err(dev, "missing IRQ\n");
>>> +             return -ENODEV;
>>> +     }
>>> +     cdns->irq = res->start;
>>> +
>>> +     /*
>>> +      * Request memory region
>>> +      * region-0: xHCI
>>> +      * region-1: Peripheral
>>> +      * region-2: OTG registers
>>> +      */
>>
>> The memory region order is different from the dt-binding.
>> There it is OTG, host(xhci), device (peripheral).
>>
>>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +     regs = devm_ioremap_resource(dev, res);
>>> +
>>> +     if (IS_ERR(regs))
>>> +             return PTR_ERR(regs);
>>> +     cdns->xhci_regs = regs;
>>> +     cdns->xhci_res = res;
>>> +
>>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>> +     regs = devm_ioremap_resource(dev, res);
>>> +     if (IS_ERR(regs))
>>> +             return PTR_ERR(regs);
>>> +     cdns->dev_regs  = regs;
>>> +
>>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
>>> +     regs = devm_ioremap_resource(dev, res);
>>> +     if (IS_ERR(regs))
>>> +             return PTR_ERR(regs);
>>> +     cdns->otg_regs = regs;
>>> +
>>> +     mutex_init(&cdns->mutex);
>>> +
>>> +     cdns->phy = devm_phy_get(dev, "cdns3,usbphy");
>>
>> "cdns3,usbphy" is not documented in dt-binding.
>>
>>> +     if (IS_ERR(cdns->phy)) {
>>> +             dev_info(dev, "no generic phy found\n");
>>> +             cdns->phy = NULL;
>>> +             /*
>>> +              * fall through here!
>>> +              * if no generic phy found, phy init
>>> +              * should be done under boot!
>>> +              */
>>
>> No you shouldn't fall through always if it is an error condition.
>> Something like this should work better.
>>
>>         if (IS_ERR(cnds->phy)) {
>>                 ret = PTR_ERR(cdns->phy);
>>                 if (ret == -ENOSYS || ret == -ENODEV) {
>>                         cdns->phy = NULL;
>>                 } else if (ret == -EPROBE_DEFER) {
>>                         return ret;
>>                 } else {
>>                         dev_err(dev, "no phy found\n");
>>                         goto err0;
>>                 }
>>         }
>>
>> So if PHY was provided in DT, and PHY support/drivers is present
>> and error condition means something is wrong and we have to error out.
>>
>>> +     } else {
>>> +             phy_init(cdns->phy);
>>> +     }
>>
>> You can do phy_init() outside the else.
>>
>>> +
>>> +     ret = cdns3_core_init_role(cdns);
>>> +     if (ret)
>>> +             goto err1;
>>> +
>>> +     INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
>>> +     if (ret)
>>> +             goto err2;
>>> +
>>> +     if (ret)
>>> +             goto err2;
>>> +
>>> +     cdns->role = cdns3_get_role(cdns);
>>
>> I think this should move to cdns3_core_init_role().
>>
> 
> I agree.
> 
>>> +
>>> +     ret = devm_request_irq(dev, cdns->irq, cdns3_irq, IRQF_SHARED,
>>> +                            dev_name(dev), cdns);
>>> +
>>> +     if (ret)
>>> +             goto err2;
>>
>> How about moving request_irq to before cdsn3_core_init_role()?
>>
>> Then you can move cdns3_role_start() as well to core_init_role().
>>
> 
> Usually, we request irq after hardware initialization has finished, if not,
> there may unexpected interrupt.

Doesn't kernel warn if interrupt happens and there is no handler?
To avoid that I was suggesting to request_irq first.

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
