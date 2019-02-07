Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E542C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680142190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ef/p43L+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBGPRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:17:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51060 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGPRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:17:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id z5so253114wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6nYbk9CfPOAf3jV4FS+0waz/Vh9XejXm1uS2dqF/hU=;
        b=ef/p43L+DfaK/3/XJz9rI92id63xSN+v5mt3Mf7foy1nvv2MR3Ew+6qF3tMnheQIU9
         oJGalN6tos++BnnhnE3UZFsS6R7oMr9VgGF9hZ7kXlI6RuER1rnyOBJEMd8SZbTF+Yd7
         Lyr2iQfE//T6LylYVTovoOvLBL32Yn42iEdhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6nYbk9CfPOAf3jV4FS+0waz/Vh9XejXm1uS2dqF/hU=;
        b=kh20PSJnxFWaqAK8RIjk/IrE/LStE3RQ7pXKbgb+pAE7GSqg+ySmYvuEfRGV6eSAeX
         J3pqPw/iqQLZdpjgO7Bwga0lQ2u6NWMfI6e0OHmXVFESIy3QVsXBsr8zpT2wLNP/TRWM
         69D3UuSSUWHXBRHFqgMXfCaHVQuIYMRwk3TRjQ07QKaNOhlJLZxvz0hd3cb2Jznj5aFK
         c+is3ZrExfJUuIelw7fk2unzc3mi5NaZKiua57TQFFCp7DI9KY3dGTq7eGLI60vwokv7
         BaFHmB8OImUFmfaCdA25RTSAKa07g31FfiTGpUXCC6rO+6AVtxCrVVgFlHNpCDuCpUq+
         a0MQ==
X-Gm-Message-State: AHQUAuZw/O8A/3kcpPRJcY+RFfxE32WgjRAZ38wY7C6XdSh1qIjeqkcb
        6sQ6H0jn/dV4zbIFh/YksOL9JoXG1YuGfarkeC9HKg==
X-Google-Smtp-Source: AHgI3Iaks6FDiEYiE95lePN9/mnwz6dALiqSGtYZg59OqczYKaZ9V9csnpbKPQkS7HMy/oi4jC4pPhS0j7LR16H9Ja4=
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr7670003wmc.21.1549552667171;
 Thu, 07 Feb 2019 07:17:47 -0800 (PST)
MIME-Version: 1.0
References: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
 <1549347534-11320-3-git-send-email-srinath.mannam@broadcom.com> <6392f206-9db2-5506-9e5d-cdf2b784d32e@linux.intel.com>
In-Reply-To: <6392f206-9db2-5506-9e5d-cdf2b784d32e@linux.intel.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 7 Feb 2019 20:47:34 +0530
Message-ID: <CABe79T4wLea8hBML4Xejv3YH3eAFfXqgnB8+udr-Xo_ZdTn0xA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: xhci: Add quirk to reset xHCI port PHY
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

Thanks for review, please see my comments below inline.

On Thu, Feb 7, 2019 at 8:32 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 05.02.2019 08:18, Srinath Mannam wrote:
> > Add a quirk to reset xHCI port PHY on port disconnect event.
> > Stingray USB HS PHY has an issue, that USB High Speed device detected
> > at Full Speed after the same port has connected to Full speed device.
> > This problem can be resolved with that port PHY reset on disconnect.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > ---
> >   drivers/usb/core/hcd.c       |  6 ++++++
> >   drivers/usb/core/phy.c       | 21 +++++++++++++++++++++
> >   drivers/usb/core/phy.h       |  1 +
> >   drivers/usb/host/xhci-plat.c |  3 +++
> >   drivers/usb/host/xhci-ring.c |  9 ++++++---
> >   drivers/usb/host/xhci.h      |  1 +
> >   include/linux/usb/hcd.h      |  1 +
> >   7 files changed, 39 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index 015b126..e2b87a6 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -2663,6 +2663,12 @@ int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1)
> >       return hcd->driver->find_raw_port_number(hcd, port1);
> >   }
> >
> > +int usb_hcd_phy_port_reset(struct usb_hcd *hcd, int port)
> > +{
> > +     return usb_phy_roothub_port_reset(hcd->phy_roothub, port);
> > +}
> > +EXPORT_SYMBOL_GPL(usb_hcd_phy_port_reset);
> > +
> >   static int usb_hcd_request_irqs(struct usb_hcd *hcd,
> >               unsigned int irqnum, unsigned long irqflags)
> >   {
> > diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> > index 38b2c77..c64767d 100644
> > --- a/drivers/usb/core/phy.c
> > +++ b/drivers/usb/core/phy.c
> > @@ -162,6 +162,27 @@ void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
> >   }
> >   EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
> >
> > +int usb_phy_roothub_port_reset(struct usb_phy_roothub *phy_roothub, int port)
> > +{
> > +     struct usb_phy_roothub *roothub_entry;
> > +     struct list_head *head;
> > +     int i = 0;
> > +
> > +     if (!phy_roothub)
> > +             return -EINVAL;
> > +
> > +     head = &phy_roothub->list;
> > +
> > +     list_for_each_entry(roothub_entry, head, list) {
> > +             if (i == port)
> > +                     return phy_reset(roothub_entry->phy);
> > +             i++;
> > +     }
>
> I'm not that familiar with SoC's that have several PHYs per controller,
> but this looks odd.
>
> For the above code to work wouldn't it require that each port has their own PHY,
> and the PHYs are added to the list of usb_phy_roothub is in the same order as usb ports?
>
> Or is there something I don't understand here?
>
In our SOC (Stingray), xHCI controller has three ports and each port
connected to separate PHY.
Stingray xHCI controller supports both SS and HS ports and connected
separate PHYs.
We passed PHY phandlers in xHCI DT node in the order of port numbers.
as shown below xHCI DT node.
So that all PHYs added to usb_phy_roothub are in order of port numbers.
 xhci1: usb@11000 {
                        compatible = "generic-xhci";
                        reg = <0x00011000 0x1000>;
                        interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
                        phys = <&usb1_phy1>, <&usbphy2>, <&usb1_phy0>;
                        phy-names = "phy0", "phy1", "phy2";
                        dma-coherent;
                        status = "disabled";
};
But we have issue with HS PHYs, so that those PHYs are required to reset.

Regards,
Srinath.
> -Mathias
>
