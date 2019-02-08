Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D11C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5F52081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DX/FbTXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBHSse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:48:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54770 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBHSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:48:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so4812649wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 10:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+VP3cHELnyHess42hEOHNbFixiY1xQYRelQi9B1tzE=;
        b=DX/FbTXOBRD2ckfhsy6bj9FfMJhU3Pz5wURwRcpeSQAVLXnBebGngCMdIG7A+sqBet
         Lvx4u9BXt/FRtKyjEBYiiqlO6bfkhx3qDTa56L2GQVXXDpiitrR2sOL/NwLw2pDnwDr2
         xaG5/47zL17DhgA8tKWH+3v4dRePImU6UaFBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+VP3cHELnyHess42hEOHNbFixiY1xQYRelQi9B1tzE=;
        b=ljAu4NO2fFG8QDwpIvvLg/UntUMq/cWkGBkCfxYXSd2NnJ9qg+DmH9+zSatZYECh7D
         uytbOjUu8r0dClpLAwR1yS4Lgxwh44jdE1DRvzuEQVEx/I043HO3VU0Ne4bM/qBGzek3
         s9NUGdhL931rQF3a2bmj7zxZKT14bHWd2JO1Ruunxo8B+iMfT7H1pHj6QrUvH0uSz6Gi
         lgSMpyoiIUCXGaUjYW7gI9m5/1gcxIjqcBqVcEgIJMow7Wl74xjkQ/gVx1KdxvUunsDn
         JYesvAFOgxvdj41szFlQAdLVICzBjp6Tt0y2LuSuZpncS41KtymSrAvYsJRqeB7V/vNu
         RXFQ==
X-Gm-Message-State: AHQUAuZqpoFSCsnRUFNSvYO6yuFkkTWhc742i+Gvstm3JWeQDf9PMSWV
        +8ncKnR8n+ZWXUTI9OQTxMOz2VxqbFY9XrDXIoQ+Jw==
X-Google-Smtp-Source: AHgI3IaU2gkl64zrCIP3VQ4uJVdIZ9vWst4/YG92yZJCVYOAnrCi/MbZiwyoHU6ehfXK2gPiEhzcSroOiKRSWOFUJ2k=
X-Received: by 2002:a5d:4487:: with SMTP id j7mr11933922wrq.83.1549651712042;
 Fri, 08 Feb 2019 10:48:32 -0800 (PST)
MIME-Version: 1.0
References: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
 <1549347534-11320-3-git-send-email-srinath.mannam@broadcom.com>
 <6392f206-9db2-5506-9e5d-cdf2b784d32e@linux.intel.com> <CABe79T4wLea8hBML4Xejv3YH3eAFfXqgnB8+udr-Xo_ZdTn0xA@mail.gmail.com>
 <d176e6bf-10b8-374c-1739-47bc98d12f09@linux.intel.com>
In-Reply-To: <d176e6bf-10b8-374c-1739-47bc98d12f09@linux.intel.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Sat, 9 Feb 2019 00:18:20 +0530
Message-ID: <CABe79T5ptsgJVOiSZtsCKjOCSu+pTedvoCVvXaZ9Ph-PaL1k4w@mail.gmail.com>
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

Thanks for comments, Please find my comments below inline.

On Fri, Feb 8, 2019 at 6:00 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 07.02.2019 17:17, Srinath Mannam wrote:
> > Hi Mathias,
> >
> > Thanks for review, please see my comments below inline.
> >
> > On Thu, Feb 7, 2019 at 8:32 PM Mathias Nyman
> > <mathias.nyman@linux.intel.com> wrote:
> >>
> >> On 05.02.2019 08:18, Srinath Mannam wrote:
> >>> Add a quirk to reset xHCI port PHY on port disconnect event.
> >>> Stingray USB HS PHY has an issue, that USB High Speed device detected
> >>> at Full Speed after the same port has connected to Full speed device.
> >>> This problem can be resolved with that port PHY reset on disconnect.
> >>>
> >>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> >>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> >>> ---
> >>>    drivers/usb/core/hcd.c       |  6 ++++++
> >>>    drivers/usb/core/phy.c       | 21 +++++++++++++++++++++
> >>>    drivers/usb/core/phy.h       |  1 +
> >>>    drivers/usb/host/xhci-plat.c |  3 +++
> >>>    drivers/usb/host/xhci-ring.c |  9 ++++++---
> >>>    drivers/usb/host/xhci.h      |  1 +
> >>>    include/linux/usb/hcd.h      |  1 +
> >>>    7 files changed, 39 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> >>> index 015b126..e2b87a6 100644
> >>> --- a/drivers/usb/core/hcd.c
> >>> +++ b/drivers/usb/core/hcd.c
> >>> @@ -2663,6 +2663,12 @@ int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1)
> >>>        return hcd->driver->find_raw_port_number(hcd, port1);
> >>>    }
> >>>
> >>> +int usb_hcd_phy_port_reset(struct usb_hcd *hcd, int port)
> >>> +{
> >>> +     return usb_phy_roothub_port_reset(hcd->phy_roothub, port);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(usb_hcd_phy_port_reset);
> >>> +
> >>>    static int usb_hcd_request_irqs(struct usb_hcd *hcd,
> >>>                unsigned int irqnum, unsigned long irqflags)
> >>>    {
> >>> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> >>> index 38b2c77..c64767d 100644
> >>> --- a/drivers/usb/core/phy.c
> >>> +++ b/drivers/usb/core/phy.c
> >>> @@ -162,6 +162,27 @@ void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
> >>>    }
> >>>    EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
> >>>
> >>> +int usb_phy_roothub_port_reset(struct usb_phy_roothub *phy_roothub, int port)
> >>> +{
> >>> +     struct usb_phy_roothub *roothub_entry;
> >>> +     struct list_head *head;
> >>> +     int i = 0;
> >>> +
> >>> +     if (!phy_roothub)
> >>> +             return -EINVAL;
> >>> +
> >>> +     head = &phy_roothub->list;
> >>> +
> >>> +     list_for_each_entry(roothub_entry, head, list) {
> >>> +             if (i == port)
> >>> +                     return phy_reset(roothub_entry->phy);
> >>> +             i++;
> >>> +     }
> >>
> >> I'm not that familiar with SoC's that have several PHYs per controller,
> >> but this looks odd.
> >>
> >> For the above code to work wouldn't it require that each port has their own PHY,
> >> and the PHYs are added to the list of usb_phy_roothub is in the same order as usb ports?
> >>
> >> Or is there something I don't understand here?
> >>
> > In our SOC (Stingray), xHCI controller has three ports and each port
> > connected to separate PHY.
> > Stingray xHCI controller supports both SS and HS ports and connected
> > separate PHYs.
> > We passed PHY phandlers in xHCI DT node in the order of port numbers.
> > as shown below xHCI DT node.
> > So that all PHYs added to usb_phy_roothub are in order of port numbers.
> >   xhci1: usb@11000 {
> >                          compatible = "generic-xhci";
> >                          reg = <0x00011000 0x1000>;
> >                          interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
> >                          phys = <&usb1_phy1>, <&usbphy2>, <&usb1_phy0>;
> >                          phy-names = "phy0", "phy1", "phy2";
> >                          dma-coherent;
> >                          status = "disabled";
> > };
> > But we have issue with HS PHYs, so that those PHYs are required to reset.
>
> This is very specific to your SOC.
> A quick grep shows most xhci controllers have one or two PHYs in total.
>
> The suggested usb_phy_roothub_port_reset() above will only work for your SOC.
Yes, and Cavium SOC also has similar issue need to reset PLL.
> I think it would be better to have a stingray specific quirk/workaround where you
> can find the right PHY to reset based on somthing like port number and PHY name.
>
The tricky part is we need to reset HS PHY after port disconnect so
that PORT to PHY translation is required.
We have two xHCI controllers in our SOC, one has two ports with two
PHYs (SS + HS) and other has three ports with three PHYs (SS + HS +
HS).
All HS PHYs have this issue, we need to reset HS PHYs after disconnect
of its corresponding port.
In existing framework all phy pointers are listed in primary hcd based
on index using "devm_of_phy_get_by_index" so can rely on index number
rather PHY name?
> For a generic solution we would need a better way to map usb ports to the PHY it uses.
Can I add phy pointer and its details in "struct xhci_port" structure
while initialization to get phy pointer from xhci_port?
>
Regards,
Srinath.



> -Mathias
