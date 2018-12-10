Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22647C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3EE2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKvHdNQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3EE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeLJCMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:12:52 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54671 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeLJCMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 21:12:51 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so15139939ita.4;
        Sun, 09 Dec 2018 18:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Og1uaRxJh0Rp9cXcJUtdP1WBd+9All/3Lpb76ynmCBw=;
        b=TKvHdNQK2CMz5Fzyt22qpMdVKw7BsgZ+maijY6EGQQlqnrQiK8oGun9iNFcGrz/tYS
         0+qW0R+ypSpL7OSxkf/wcoBm89AdxnzqNY/eednK0VaB0OAoxdlB2OBgQRBSzJnsHHIU
         9/3LSLKjtf4asdvggoGOhXeY2nrbbg+Vpzz2tYSlWK4CI+DlTTR1ayFVHM7iLGxAV6MB
         tYvVY6gFfpfN6VhQJHuCNpt7bgdMAByN4rZmYoMMm0CyDIBbY9ZBLfX3cXdnZzbX5lW6
         9MQa0ycsMxViHGfBARBRzRTeHWokea7T0xa+7h88LD+m0IJEV5lqRrujSpVMxum/Vhz9
         F0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Og1uaRxJh0Rp9cXcJUtdP1WBd+9All/3Lpb76ynmCBw=;
        b=EdpWcMCA4PJA0yleh/OR55lBlBaO5Vr0xu1B05yL/JZ1MUdDt6dRkNAjBddK2hEuER
         +vbOt6ji+Gj5APcrc6dfHke+FXg6slwtCtvYkPWMFM8d8xng9ni63eOh9nIfiQ045RnG
         nILLexQHiXER4XtkBehGRiI9C1+lBtBQdqWN+RiXwGUe+W6UCT5maNoiy3Qk9dFNy/wM
         bIjCWvSzMD4JfzfAv0JyUE/RWuz2nWM8ZzclbVE3eBDo+kwMrzTKXRF2ABWi6xnNCAjW
         JSP2hvqVQ/5dv/o87DiPiG+FN6PuHNw3TCuJCsdLB6x1QJ5KAKAo2/+i1KgQLRvhm0xK
         YCLA==
X-Gm-Message-State: AA+aEWaqnEWz4wHBEr7wwUxhSGnct4d4iYQM1TKEohKagpQE/0oQl6LD
        X8OmhrRGQRaVysN9dSZ0d48ogkaSbQp3/1tUGSU=
X-Google-Smtp-Source: AFSGD/Xa5kt3u3OQqhyNtOGvR8b1SPquDxW03xBmVhUN7EKjCCYWm6+EXFxHHNwIgA5dbmKTlsU9gyDJLlX3H4unvJQ=
X-Received: by 2002:a24:6b90:: with SMTP id v138mr8838446itc.86.1544407970038;
 Sun, 09 Dec 2018 18:12:50 -0800 (PST)
MIME-Version: 1.0
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-9-git-send-email-pawell@cadence.com> <5BFE8883.7090802@ti.com>
In-Reply-To: <5BFE8883.7090802@ti.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Mon, 10 Dec 2018 10:12:38 +0800
Message-ID: <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part
 of the API
To:     rogerq@ti.com
Cc:     pawell@cadence.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        adouglas@cadence.com, jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com,
        sureshp@cadence.com, peter.chen@nxp.com, pjez@cadence.com,
        kurahul@cadence.com, balbi@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static struct cdns3_endpoint *cdns3_find_available_ss_ep(struct cdns3_device *priv_dev,
> > +                                                      struct usb_endpoint_descriptor *desc)
>
> why is this function called ss_ep? This doesn't seem like only for superspeed endpoints.
>

Yes, it is for all speed.

> > +{
> > +     struct usb_ep *ep;
> > +     struct cdns3_endpoint *priv_ep;
> > +
> > +     list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
> > +             unsigned long num;
> > +             int ret;
> > +             /* ep name pattern likes epXin or epXout */
> > +             char c[2] = {ep->name[2], '\0'};
> > +
> > +             ret = kstrtoul(c, 10, &num);
> > +             if (ret)
> > +                     return ERR_PTR(ret);
> > +
> > +             priv_ep = ep_to_cdns3_ep(ep);
> > +             if (cdns3_ep_dir_is_correct(desc, priv_ep)) {
> > +                     if (!(priv_ep->flags & EP_USED)) {
> > +                             priv_ep->num  = num;
> > +                             priv_ep->flags |= EP_USED;
> > +                             return priv_ep;
> > +                     }
> > +             }
> > +     }
> > +     return ERR_PTR(-ENOENT);
> > +}
> > +
> > +static struct usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
> > +                                         struct usb_endpoint_descriptor *desc,
> > +                                         struct usb_ss_ep_comp_descriptor *comp_desc)
> > +{
> > +     struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> > +     struct cdns3_endpoint *priv_ep;
> > +     unsigned long flags;
> > +
> > +     priv_ep = cdns3_find_available_ss_ep(priv_dev, desc);
> > +     if (IS_ERR(priv_ep)) {
> > +             dev_err(&priv_dev->dev, "no available ep\n");
> > +             return NULL;
> > +     }
> > +
> > +     dev_dbg(&priv_dev->dev, "match endpoint: %s\n", priv_ep->name);
> > +
> > +     spin_lock_irqsave(&priv_dev->lock, flags);
> > +     priv_ep->endpoint.desc = desc;
> > +     priv_ep->dir  = usb_endpoint_dir_in(desc) ? USB_DIR_IN : USB_DIR_OUT;
> > +     priv_ep->type = usb_endpoint_type(desc);
> > +
> > +     list_add_tail(&priv_ep->ep_match_pending_list,
> > +                   &priv_dev->ep_match_list);
> > +     spin_unlock_irqrestore(&priv_dev->lock, flags);
> > +     return &priv_ep->endpoint;
> > +}
>
> Why do you need a custom match_ep?
> doesn't usb_ep_autoconfig suffice?
>
> You can check if EP is claimed or not by checking the ep->claimed flag.
>

It is a special requirement for this IP, the EP type and MaxPacketSize
changing can't be done at runtime, eg, at ep->enable. See below commit
for detail.

    usb: cdns3: gadget: configure all endpoints before set configuration

    Cadence IP has one limitation that all endpoints must be configured
    (Type & MaxPacketSize) before setting configuration through hardware
    register, it means we can't change endpoints configuration after
    set_configuration.

    In this patch, we add non-control endpoint through usb_ss->ep_match_list,
    which is added when the gadget driver uses usb_ep_autoconfig to configure
    specific endpoint; When the udc driver receives set_configurion request,
    it goes through usb_ss->ep_match_list, and configure all endpoints
    accordingly.

    At usb_ep_ops.enable/disable, we only enable and disable endpoint through
    ep_cfg register which can be changed after set_configuration, and do
    some software operation accordingly.


> > +
> > +/**
> > + * cdns3_gadget_get_frame Returns number of actual ITP frame
> > + * @gadget: gadget object
> > + *
> > + * Returns number of actual ITP frame
> > + */
> > +static int cdns3_gadget_get_frame(struct usb_gadget *gadget)
> > +{
> > +     struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> > +
> > +     return readl(&priv_dev->regs->usb_iptn);
> > +}
> > +
> > +static int cdns3_gadget_wakeup(struct usb_gadget *gadget)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int cdns3_gadget_set_selfpowered(struct usb_gadget *gadget,
> > +                                     int is_selfpowered)
> > +{
> > +     struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&priv_dev->lock, flags);
> > +     gadget->is_selfpowered = !!is_selfpowered;
> > +     spin_unlock_irqrestore(&priv_dev->lock, flags);
> > +     return 0;
> > +}
> > +
> > +static int cdns3_gadget_pullup(struct usb_gadget *gadget, int is_on)
> > +{
> > +     struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> > +
> > +     if (!priv_dev->start_gadget)
> > +             return 0;
> > +
> > +     if (is_on)
> > +             writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
> > +     else
> > +             writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
> > +
> > +     return 0;
> > +}
> > +
> >  static void cdns3_gadget_config(struct cdns3_device *priv_dev)
> >  {
> >       struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
> > @@ -74,6 +231,95 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
> >       writel(USB_CONF_DEVEN, &regs->usb_conf);
> >  }
> >
> > +/**
> > + * cdns3_gadget_udc_start Gadget start
> > + * @gadget: gadget object
> > + * @driver: driver which operates on this gadget
> > + *
> > + * Returns 0 on success, error code elsewhere
> > + */
> > +static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
> > +                               struct usb_gadget_driver *driver)
> > +{
> > +     struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> > +     unsigned long flags;
> > +
> > +     if (priv_dev->gadget_driver) {
> > +             dev_err(&priv_dev->dev, "%s is already bound to %s\n",
> > +                     priv_dev->gadget.name,
> > +                     priv_dev->gadget_driver->driver.name);
> > +             return -EBUSY;
> > +     }
>
> Not sure if this check is required. UDC core should be doing that.
>

Yes, UDC core has done this.

> > +
> > +     spin_lock_irqsave(&priv_dev->lock, flags);
> > +     priv_dev->gadget_driver = driver;
> > +     if (!priv_dev->start_gadget)
> > +             goto unlock;
> > +
> > +     cdns3_gadget_config(priv_dev);
> > +unlock:
> > +     spin_unlock_irqrestore(&priv_dev->lock, flags);
> > +     return 0;
> > +}
> > +
> > +/**
> > + * cdns3_gadget_udc_stop Stops gadget
> > + * @gadget: gadget object
> > + *
> > + * Returns 0
> > + */
> > +static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
> > +{
> > +     struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> > +     struct cdns3_endpoint *priv_ep, *temp_ep;
> > +     u32 bEndpointAddress;
> > +     struct usb_ep *ep;
> > +     int ret = 0;
> > +     int i;
> > +
> > +     priv_dev->gadget_driver = NULL;
> > +     list_for_each_entry_safe(priv_ep, temp_ep, &priv_dev->ep_match_list,
> > +                              ep_match_pending_list) {
> > +             list_del(&priv_ep->ep_match_pending_list);
> > +             priv_ep->flags &= ~EP_USED;
> > +     }
> > +
> > +     priv_dev->onchip_mem_allocated_size = 0;
> > +     priv_dev->out_mem_is_allocated = 0;
> > +     priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> > +
> > +     for (i = 0; i < priv_dev->ep_nums ; i++)
> > +             cdns3_free_trb_pool(priv_dev->eps[i]);
> > +
> > +     if (!priv_dev->start_gadget)
> > +             return 0;
>
> This looks tricky. Why do we need this flag?

We only start the gadget (enable clocks) when the VBUS is on, so if we load
class driver without VBUS, we only do  software .bind but without
hardware operation.

>
> > +
> > +     list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
> > +             priv_ep = ep_to_cdns3_ep(ep);
> > +             bEndpointAddress = priv_ep->num | priv_ep->dir;
> > +             cdns3_select_ep(priv_dev, bEndpointAddress);
> > +             writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> > +             ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
> > +                                   EP_CMD_EPRST, 0, 100);
> > +     }
> > +
> > +     /* disable interrupt for device */
> > +     writel(0, &priv_dev->regs->usb_ien);
> > +     writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
>
> where are you requesting the interrupt? Looks like it should be done in
> udc_start() no?
>

Yes, it is at udc_start.

Peter

> > +
> > +     return ret;
> > +}
>
> Can we combine cdns3_gadget_udc_start() and cdns3_gadget_udc_start()
> with cdns3_gadget_start() and cdns3_gadget_stop() respectively so that
> cdns3_gadget_config() and cleanup() is done at one place.
>
> > +
> > +static const struct usb_gadget_ops cdns3_gadget_ops = {
> > +     .get_frame = cdns3_gadget_get_frame,
> > +     .wakeup = cdns3_gadget_wakeup,
> > +     .set_selfpowered = cdns3_gadget_set_selfpowered,
> > +     .pullup = cdns3_gadget_pullup,
> > +     .udc_start = cdns3_gadget_udc_start,
> > +     .udc_stop = cdns3_gadget_udc_stop,
> > +     .match_ep = cdns3_gadget_match_ep,
> > +};
> > +
> >  /**
> >   * cdns3_init_ep Initializes software endpoints of gadget
> >   * @cdns3: extended gadget object
> > @@ -184,8 +430,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
> >       /* fill gadget fields */
> >       priv_dev->gadget.max_speed = USB_SPEED_SUPER;
> >       priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> > -     //TODO: Add implementation of cdns3_gadget_ops
> > -     //priv_dev->gadget.ops = &cdns3_gadget_ops;
> > +     priv_dev->gadget.ops = &cdns3_gadget_ops;
> >       priv_dev->gadget.name = "usb-ss-gadget";
> >       priv_dev->gadget.sg_supported = 1;
> >       priv_dev->is_connected = 0;
> >
>
> cheers,
> -roger
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
