Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D3CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAE320859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmPsI3D8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfAQWiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:38:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42657 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfAQWiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:38:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so12827739wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 14:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lN2rae8wyVAor90vR3Fuv6iYQRV6+kCDtSkz6R9rQ4Q=;
        b=CmPsI3D8ecOulLP6isxpm0wKkhNOw4vQlvnARk3ePmXCH7AITNrDYBQKtl+k1S3fQS
         zHAnugWsAlXXivQjaRbUPiCfoQCDXNjcp0I+t/eqHKq2f5+/8/6+HniaLoztkEEOU2Qc
         IGkW7+JP5v3xRVK2AD0geHPmx5uFCZ5dUyr3+0mlRvGT983fQEcXlOy68ZhxMa97wgOd
         NifTZfFzorFmXsvqttrG7IzCiklSibu8WuWD3oy2CHsVObnFVV0n91TaYAkQYIWf3dW/
         oZV5flsrjEA7J+WDYEWiku/Fr5xBrwBE6OtXl4vWqowC4i+QN628QeuvgZ7yZ/ha9SAv
         gcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lN2rae8wyVAor90vR3Fuv6iYQRV6+kCDtSkz6R9rQ4Q=;
        b=RpXOxl8QvOfgJb2wdKD75jvSLXrhCdLDTXXYJagCosU5xtbwhl3FaGfb81q4jF7TJE
         pKllB8/9eVlIKPHNYTvPctkf0FFqpO2vxbQCdBlXWbL6q679ozA/yMXIwyc2fJq/AhMw
         CjK7t257E21PB9YkVeIJmEqpp6qqPyXBZox3rDNYuMmV3iEvShpNYD+b5nW4W191HwTT
         YMC/d/iWPIM57Ue6Jy7kfP3OMX3Qjkv54wA54olGlYgPmt9r33MHWWHlb6iemB/n5xjx
         NTD5/O2kwRMT/WH42ZvMc4KuNBGBYx4VeS0wrZ34DvOb0EBafSHIXHriZXLKtBe1NvYk
         +0qw==
X-Gm-Message-State: AJcUukffqjFluZyAuiqiu+Zpya2u5pgJPt3J4Y3SqTTvY+xTc0D6fhrn
        vqJyo9qW9X7K3INVeps0Gdw1aM3mhI/Ocd0VlLw=
X-Google-Smtp-Source: ALg8bN6cIhT26uiySCgu7FPFPGRBP+ONv4qG3nWR69zW5vjNrTz3nXYaJh/Ui3m2NvFtwrYtVWO7V8r68/i5A6dqtCQ=
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr13059920wrx.259.1547764697654;
 Thu, 17 Jan 2019 14:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
 <20181220010700.8598-3-andrew.smirnov@gmail.com> <1547743553.4009.16.camel@pengutronix.de>
In-Reply-To: <1547743553.4009.16.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 17 Jan 2019 14:38:06 -0800
Message-ID: <CAHQ1cqG+3K+SKptZJ-FQ6xAa+2LMs_W24TEgqyV+9kR_iAz+cg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
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

On Thu, Jan 17, 2019 at 8:45 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Andrey,
>
> sorry for the delay. Thank you for the update, apart from the comments
> below, the list now looks to be complete.
>
> On Wed, 2018-12-19 at 17:06 -0800, Andrey Smirnov wrote:
> > The driver now supports i.MX8MQ, so update bindings accordingly.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  .../bindings/reset/fsl,imx7-src.txt           |  7 +-
> >  include/dt-bindings/reset/imx8mq-reset.h      | 64 +++++++++++++++++++
> >  2 files changed, 69 insertions(+), 2 deletions(-)
> >  create mode 100644 include/dt-bindings/reset/imx8mq-reset.h
> >
> > diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > index 1ab1d109318e..2ecf33815d18 100644
> > --- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > @@ -5,7 +5,9 @@ Please also refer to reset.txt in this directory for common reset
> >  controller binding usage.
> >
> >  Required properties:
> > -- compatible: Should be "fsl,imx7d-src", "syscon"
> > +- compatible:
> > +     - For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
> > +     - For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
> >  - reg: should be register base and length as documented in the
> >    datasheet
> >  - interrupts: Should contain SRC interrupt
> > @@ -44,4 +46,5 @@ Example:
> >
> >
> >  For list of all valid reset indicies see
> > -<dt-bindings/reset/imx7-reset.h>
> > +<dt-bindings/reset/imx7-reset.h> for i.MX7 and
> > +<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
> > diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
> > new file mode 100644
> > index 000000000000..57c592498aa0
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/imx8mq-reset.h
> > @@ -0,0 +1,64 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2018 Zodiac Inflight Innovations
> > + *
> > + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> > + */
> > +
> > +#ifndef DT_BINDING_RESET_IMX8MQ_H
> > +#define DT_BINDING_RESET_IMX8MQ_H
> > +
> > +#define IMX8MQ_RESET_A53_CORE_POR_RESET0     0
> > +#define IMX8MQ_RESET_A53_CORE_POR_RESET1     1
> > +#define IMX8MQ_RESET_A53_CORE_POR_RESET2     2
> > +#define IMX8MQ_RESET_A53_CORE_POR_RESET3     3
> > +#define IMX8MQ_RESET_A53_CORE_RESET0         4
> > +#define IMX8MQ_RESET_A53_CORE_RESET1         5
> > +#define IMX8MQ_RESET_A53_CORE_RESET2         6
> > +#define IMX8MQ_RESET_A53_CORE_RESET3         7
> > +#define IMX8MQ_RESET_A53_DBG_RESET0          8
> > +#define IMX8MQ_RESET_A53_DBG_RESET1          9
> > +#define IMX8MQ_RESET_A53_DBG_RESET2          10
> > +#define IMX8MQ_RESET_A53_DBG_RESET3          11
> > +#define IMX8MQ_RESET_A53_ETM_RESET0          12
> > +#define IMX8MQ_RESET_A53_ETM_RESET1          13
> > +#define IMX8MQ_RESET_A53_ETM_RESET2          14
> > +#define IMX8MQ_RESET_A53_ETM_RESET3          15
> > +#define IMX8MQ_RESET_A53_SOC_DBG_RESET               16
> > +#define IMX8MQ_RESET_A53_L2RESET             17
> > +#define IMX8MQ_RESET_SW_NON_SCLR_M4C_RST     18
>                            ^^^^^^^^
>
> This might be an implementation detail. The reset line is
> (SW_?)M4C_RST. I suppose the self-clearing SW_M4C_RST bit could be used
> to implement .reset() functionality for the same line if needed.
>

I was using literal bit names for reset lines. In this case this is a
bit 0 of SRC_M4RCR.

> What about the self-clearing SW_M4P_RST bit? Has that been left out on
> purpose?

Since they are self-clearing they'd require a separate .reset
function. I have no use-case for them at this moment and no way to
test it, so I left them out.

>
> > +#define IMX8MQ_RESET_OTG1_PHY_RESET          19
> > +#define IMX8MQ_RESET_OTG2_PHY_RESET          20
> > +#define IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N   21
> > +#define IMX8MQ_RESET_MIPI_DSI_RESET_N                22
> > +#define IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N    23
> > +#define IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N    24
> > +#define IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N   25
> > +#define IMX8MQ_RESET_PCIEPHY                 26
> > +#define IMX8MQ_RESET_PCIEPHY_PERST           27
> > +#define IMX8MQ_RESET_PCIE_CTRL_APPS_EN               28
> > +#define IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF  29
>
> To be honest, I don't like these two, I'm not convinced anymore that
> they actually qualify as reset signals. To me it looks like this is
> something that the PCIe glue code should handle via syscon like i.MX6.
> Leonard, Lucas, what do you think?

OK, one thing to keep in mind about this is that those bits are
already exposed for i.MX7D and I think (correct me if I am wrong)
there's no going back there. PCIe driver already has the code to use
those on i.MX7D and, due to high degree of similarity, i.MX8MQ
actually re-uses the same codepath (at least for
IMX8MQ_RESET_PCIE_CTRL_APPS_EN).

Thanks,
Andrey Smirnov
