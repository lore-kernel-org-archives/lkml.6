Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A24C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F3921721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwtxgGl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfBGVWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:22:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55298 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGVWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:22:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so1362583wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsHTNSJE/lKlDQS3n1W69xmTT6S2j6VecvSVZDrzC3I=;
        b=FwtxgGl0UjVOeLNcPo67MLwfL80S8JGKV8HgdwW8XHnL/xkNEL+VAf26R9tum5qEQF
         XcgaDrLWNi9yHRxrwWJ0oEObWcDhcO8nY9tu5sgtthFuMvi1gx/z6C3HsQfJh3EI8qdd
         M9S8eXTHPdMJgWJAYk4pgEA1TRW1/v38p5elLcrVUpqfzW0RAFH9dTqx0S1WN4E5bQdH
         FNR27scsTuIFE61bmca8UotJJiVsQXVSX1GO6TRtQCols83/ZCl0I+l6FrLn6objuDrY
         VQ8qt+VcNFGDB3dBpZA40PgI7QuqLEVBwHCy7GgbFN3hHIny/Uy11J5WAwVNnzLtGCte
         jklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsHTNSJE/lKlDQS3n1W69xmTT6S2j6VecvSVZDrzC3I=;
        b=ggLcqr3e1iIcmnUFyRbd3jKX4lmntWBrSHHKt2QqZNNxJdCF3FgdSKFXTAvcvr/6wU
         +qfPT98ccA4tztYPpwm64Kw3836FbenSihaviEfBCVe2GC4M3TLjLVmIhNoPIhaGafHQ
         zISn9q5+eJZNlBMZQQ6mJ4I3PrCLQVNxsC1N0iF+xMZU1ca1kJzZrFqhVuJ9cdFgFm/Q
         MkB/smfs4dIBkFCjLRTbfuwaOAsl6VA9m/ZTcGKlW7YTbtpYgcLJF8kDD0qmLy4Ll/F9
         AwxBNuE7s6ONYqjBPSvHYgaG2D6GEpZc8HcIGbxQtPXZPPmqhcCqaMqk8IpBQMED7m6Z
         mccQ==
X-Gm-Message-State: AHQUAuYFUYElFcrOkp/ZxgmGUARcFaGJSV3p9++g5F8s9FRJadiRmTk+
        8vr6n6JOUDZEd3pXFbcWu79F3Nic32TwWjX3m3c=
X-Google-Smtp-Source: AHgI3Ib3H9iLE7uj5xKcChBKx8AaIe6sqt//BqWFTM9rYSOMVQpTT00qo6os+xAai6MpP7IfNdlQBSSJwUtGmyDiMWI=
X-Received: by 2002:a1c:760c:: with SMTP id r12mr8291706wmc.127.1549574554687;
 Thu, 07 Feb 2019 13:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
 <20190131204333.31846-5-andrew.smirnov@gmail.com> <1549549676.2544.79.camel@pengutronix.de>
In-Reply-To: <1549549676.2544.79.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 7 Feb 2019 13:22:23 -0800
Message-ID: <CAHQ1cqGOtGb1mt7BCm_DaKoJn=6=atauipgt6Dg2-doSEoj_tg@mail.gmail.com>
Subject: Re: [RFC 4/5] arm64: dts: Add nodes for PCIe IP blocks
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 6:27 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Donnerstag, den 31.01.2019, 12:43 -0800 schrieb Andrey Smirnov:
> > Add nodes for two PCIe controllers found on i.MX8MQ.
> >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 68 +++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 89babc531380..d20e5c7e21a3 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -6,6 +6,7 @@
> >
> >  #include <dt-bindings/clock/imx8mq-clock.h>
> >  #include <dt-bindings/power/imx8mq-power.h>
> > +#include <dt-bindings/reset/imx8mq-reset.h>
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include "imx8mq-pinfunc.h"
> > @@ -539,6 +540,73 @@
> >                       };
> >
> >       };
> >
> > +             pcie0: pcie@33800000 {
> > +                     compatible = "fsl,imx8mq-pcie";
> > +                     reg = <0x33800000 0x400000>,
> > +                           <0x1ff00000 0x80000>;
> > +                     reg-names = "dbi", "config";
> > +                     #address-cells = <3>;
> > +                     #size-cells = <2>;
> > +                     device_type = "pci";
> > +                     bus-range = <0x00 0xff>;
> > +                     ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
> > +                               0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
> > +                     num-lanes = <1>;
> > +                     interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* eDMA */
>
> I don't think this IRQ is documented in any binding yet.
>

A leftover from vendor tree. Will drop in v2.

> > +                     interrupt-names = "msi";
> > +                     #interrupt-cells = <1>;
> > +                     interrupt-map-mask = <0 0 0 0x7>;
> > +                     interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
> > +                              <&clk IMX8MQ_CLK_PCIE1_AUX>,
>
> This is not the PCIe bus clock. The bus clock is whatever drives the
> ref clock of the external bus. So on the i.MX8M-EVK this would be the
> fixed clock generated by U1302.
>
> The right thing to properly describe the HW is to extend the PCIe
> driver to look for the aux clock on i.MX8M, just like we do with the
> axi_inbound_clk on i.MX6SX.
>

OK, will update it in v2 and send a corresponding patch to PCI tree
once everything is agreed upon.

Thanks,
Andrey Smirnov
