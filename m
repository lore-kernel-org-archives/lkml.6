Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946952AbeCBR5M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:57:12 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34842 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426253AbeCBR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:57:08 -0500
X-Google-Smtp-Source: AG47ELshulfdKYGskHReqCKxr5DrRov4gKvG7Cn5Fii3Vc65jMlM+jUeZ5FR5HcCG8vYVEIe0Vr53g==
Date: Fri, 2 Mar 2018 23:26:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>
Subject: Re: [PATCH v4 04/10] pinctrl: actions: Add Actions S900 pinctrl
 driver
Message-ID: <20180302175657.cnudp24fp3ejevwc@linaro.org>
References: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org>
 <20180302035045.14660-5-manivannan.sadhasivam@linaro.org>
 <CACRpkdYKm9CuKb+0CDwddVK7uJvVKpkR_mubzDe1n2joUom-FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYKm9CuKb+0CDwddVK7uJvVKpkR_mubzDe1n2joUom-FA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Mar 02, 2018 at 02:21:37PM +0100, Linus Walleij wrote:
> On Fri, Mar 2, 2018 at 4:50 AM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
> > Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> > pinctrl, pinmux and pinconf functionalities through a range of registers
> > common to both gpio driver and pinctrl driver.
> >
> > Pinmux functionality is available only for the pin groups while the
> > pinconf functionality is available for both pin groups and individual
> > pins.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Seems like this is pretty much finished.
> 
> Let's see if you can collect some ACKs before we apply it.
> 

Andreas is at Embedded World conference. I hope once he is
back, he will have a look at this patchset.

> Now just minor things remain.
> 
> Random chosen example:
> 
> > +static unsigned int lvds_e_drv_pads[] = {
> > +       LVDS_EEP,
> > +       LVDS_EEN,
> > +       LVDS_EDP,
> > +       LVDS_EDN,
> > +       LVDS_ECP,
> > +       LVDS_ECN,
> > +       LVDS_EBP,
> > +       LVDS_EBN,
> > +};
> > +
> > +static unsigned int sd0_d3_d0_drv_pads[] = {
> > +       SD0_D3,
> > +       SD0_D2,
> > +       SD0_D1,
> > +       SD0_D0,
> > +};
> 
> People (e.g. Torvalds) sometimes get upset with files with too many lines
> in them. This file has a lot of lines. A lot of pin control drivers try to cut
> down the lines with macros, and you do it in some places too,
> would you consider to see if you can cut down these tables with
> macros?
> 
> S900_PADS(LVDS_EEP, LVDS_EEN, LVDS_EDP, LVDS_EDN,
>                     LVDS_ECP, LVDS_ECN, LVDS_EBP, LVDS_EBN);
> S900_PADS(SD0_D3, SD0_D2, SD0_D1, SD0_D0);
> 

I don't think it would be efficient to use macros here. However, I can
align the pads and func definitions in a single line. This will also
save a considerable amount of space.

Thanks,
Mani

> Would be so much more compact.
> 
> It's not the biggest problem though.
> 
> Yours,
> Linus Walleij
