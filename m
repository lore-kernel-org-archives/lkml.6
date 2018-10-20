Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313BBECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA40214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="RtPT6U+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA40214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJTJkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:40:41 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41616 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeJTJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:40:41 -0400
Received: by mail-yb1-f194.google.com with SMTP id e16-v6so13986032ybk.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 18:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfBCY+jVm4meyIF8di3VTswfLB3IYpoyXhqqSGzYHKM=;
        b=RtPT6U+jllUQt+zhl5SoXN1ejmWfx2rvWy3loHdvFuUSHZXRjumN3UlqfVCkQYAbTS
         eXJz/f6aHsu2foDvM3JzWdiUYJin0CBzfxkwFMl3SOqhfTjjGjxILhbEMmTg9txm8Iyq
         dYcfl9HTlCkOmQAU2KiSy+9uOt0gIFeBCmCtUHbpgzBdjA11S4yIjEXGnJ6GNHKxXxXt
         PgVTtVQQDQqyLTMG1oPjlO9FarrKZ+WbAAPwoCikodwLmex7E4M8tBnkZhrmvhSYikaj
         AFquzD9iTNHfUT4LpKPgLzae1kKU868M0u4+Bjo6TsBFB0bNvJm7xtSrX9JhRzbiSWWh
         gGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfBCY+jVm4meyIF8di3VTswfLB3IYpoyXhqqSGzYHKM=;
        b=mxBf6YoyqWwD1nTh7B0UtDMf7INj0tZVsJI/y9xYuNH4P/d9py574Xz/jTAtLLQXWG
         5CTZCNzMq17M3KFLC3O0zNKa25T50ueRGgspG1v137bTUKuAKUMeRMCicguP9n8PRMbr
         FiSDL02ikD5EbGZ1Et/uo518WWvT7ywHiV/QTO+G0lY5QaSE8pt64bnxJskHNZ91DcM/
         Bg9llEFdEP+QZUB0k3LQpXmxMZdei3AfL0Z3eK+x/iWcqLe9vgCBPvNQouIg95Q0Ffzl
         Bzw5+jlsKUo+wyey8f+5L7ePriPTXXRJcQDBNyCw0aLxtr4eOk43x2qVeEY9IH8c8cVL
         aSBQ==
X-Gm-Message-State: ABuFfoiMzXd5HEBSCzfwD7TJ6aZZj2J+gO7pTiz5B7yapTMdLOXNBUAW
        DwZwmuRy/wVDqGpPchiaES3Uhj5PKPTXlbjQhFBx/g==
X-Google-Smtp-Source: ACcGV61D6KaNWWRM5t6f0tqnFBuL+bCcjV3h4YQq4Jp+5ijKOADFYjubK/zl+LaCpm/r0aAJ265J/9dpZhiLzDroSf4=
X-Received: by 2002:a25:948:: with SMTP id u8-v6mr23962381ybm.301.1539999123896;
 Fri, 19 Oct 2018 18:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181020084805.29103-1-nava.manne@xilinx.com> <20181020084805.29103-4-nava.manne@xilinx.com>
 <CAJYdmePxnkG=3iJC5Lewq3n3zFGTKASJX7ceUEufBvOJogCfdA@mail.gmail.com>
In-Reply-To: <CAJYdmePxnkG=3iJC5Lewq3n3zFGTKASJX7ceUEufBvOJogCfdA@mail.gmail.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Fri, 19 Oct 2018 18:31:52 -0700
Message-ID: <CAAtXAHdP6z5NG+EAvW_N_RfcPv59e15hkd83AR-L3RDBrLMvcQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     nava.manne@xilinx.com, Alan Tull <atull@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>, rajanv@xilinx.com,
        Jolly Shah <jollys@xilinx.com>, linux-fpga@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chinnikishore369@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 2:33 PM Moritz Fischer
<moritz.fischer.private@gmail.com> wrote:
>
> Hi Nava,
>
> Looks good to me, a couple of nits inline below.
>
> On Fri, Oct 19, 2018 at 1:50 AM Nava kishore Manne
> <nava.manne@xilinx.com> wrote:
> >
> > This patch adds FPGA Manager support for the Xilinx
> > ZynqMp chip.
>
> Isn't it ZynqMP ?
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v1:
> >                 -None.
> >
> > Changes for RFC-V2:
> >                 -Updated the Fpga Mgr registrations call's
> >                  to 4.18
> >
> >  drivers/fpga/Kconfig       |   9 +++
> >  drivers/fpga/Makefile      |   1 +
> >  drivers/fpga/zynqmp-fpga.c | 159 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 169 insertions(+)
> >  create mode 100644 drivers/fpga/zynqmp-fpga.c
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 1ebcef4bab5b..26ebbcf3d3a3 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -56,6 +56,15 @@ config FPGA_MGR_ZYNQ_FPGA
> >         help
> >           FPGA manager driver support for Xilinx Zynq FPGAs.
> >
> > +config FPGA_MGR_ZYNQMP_FPGA
> > +       tristate "Xilinx Zynqmp FPGA"
> > +       depends on ARCH_ZYNQMP || COMPILE_TEST
> > +       help
> > +         FPGA manager driver support for Xilinx ZynqMP FPGAs.
> > +         This driver uses processor configuration port(PCAP)
> This driver uses *the* processor configuration port.
>
> > +         to configure the programmable logic(PL) through PS
> > +         on ZynqMP SoC.
> > +
> >  config FPGA_MGR_XILINX_SPI
> >         tristate "Xilinx Configuration over Slave Serial (SPI)"
> >         depends on SPI
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 7a2d73ba7122..3488ebbaee46 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)    += socfpga-a10.o
> >  obj-$(CONFIG_FPGA_MGR_TS73XX)          += ts73xx-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)      += xilinx-spi.o
> >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)       += zynq-fpga.o
> > +obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)     += zynqmp-fpga.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
> >
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > new file mode 100644
> > index 000000000000..2760d7e3872a
> > --- /dev/null
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2018 Xilinx, Inc.
> > + */
> > +
> > +#include <linux/dma-mapping.h>
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/string.h>
> > +#include <linux/firmware/xlnx-zynqmp.h>
> > +
> > +/* Constant Definitions */
> > +#define IXR_FPGA_DONE_MASK     0X00000008U
> > +
> > +/**
> > + * struct zynqmp_fpga_priv - Private data structure
> > + * @dev:       Device data structure
> > + * @flags:     flags which is used to identify the bitfile type
> > + */
> > +struct zynqmp_fpga_priv {
> > +       struct device *dev;
> > +       u32 flags;
> > +};
> > +
> > +static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
> > +                                     struct fpga_image_info *info,
> > +                                     const char *buf, size_t size)
> > +{
> > +       struct zynqmp_fpga_priv *priv;
> > +
> > +       priv = mgr->priv;
> > +       priv->flags = info->flags;
> > +
> > +       return 0;
> > +}
> > +
> > +static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> > +                                const char *buf, size_t size)
> > +{
> > +       struct zynqmp_fpga_priv *priv;
> > +       char *kbuf;
> > +       dma_addr_t dma_addr;
> > +       int ret;
> > +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>
> Reverse xmas-tree please, i.e. long lines first.
>
> > +
> > +       if (!eemi_ops || !eemi_ops->fpga_load)
> > +               return -ENXIO;
> > +
> > +       priv = mgr->priv;
> > +
> > +       kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
> > +       if (!kbuf)
> > +               return -ENOMEM;
> > +
> > +       memcpy(kbuf, buf, size);
> > +
> > +       wmb(); /* ensure all writes are done before initiate FW call */
> > +
> > +       ret = eemi_ops->fpga_load(dma_addr, size, priv->flags);

Don't you have to do anything with the flags? Is it really just a
pass-through of
FPGA manager flags to eemi calls?

Don't you want to make partial bitstreams e.g. use a flags value that
you export in your
firmware header (xlnx-zynqmp.h) and set those based on what flags get passed in,
i.e. explicitely translate FPGA Manager flags to your firmware flags?

Thanks,

Moritz
