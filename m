Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D73C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F582075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F582075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeIEHuI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:50:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43738 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeIEHuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:50:08 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so10898342oib.10;
        Tue, 04 Sep 2018 20:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9fgVoKoxTbTBiACKz0/xMs2QuyKTvwQBMxGnvdzug7U=;
        b=lSEuxfL0QZlvwcKKmeNJLJdEFNrs4EC1nF4oSWnuOr8pXC08uYJzkWJ6DP33xw5K1A
         Tk/iaTT2bzFsJtl459cBvDiv4NlzxIVC4qZfwjGSnfm6uREofyRYyx231vJf2ntuvViY
         vjEFNJ4w5uIr3RNHu74cPVefmQBtvwP58IxONovGuKDMUMYHqsL12cAau3YB9T9YEqWx
         vLfSMfMyuDk/uengULgGsSoFHHI0siz0CqRYZ24wc//IZyK5S6n7++cfixKD6OrAfDw/
         i4bVQknqsgfki4VeHD0OLXqwJXJII+/haEnKLgYnXiOdiBQ4wJAsIYAqlD1B+mxYfUCy
         n9jw==
X-Gm-Message-State: APzg51CcmPLCwu5HDkEm152RohfukG0FKXxaYRMh7ragohvnh8+X8CsY
        f3VFQoyVWCW1pRoapRx6JH9GMdi0COM=
X-Google-Smtp-Source: ANB0VdaDNm+NIo5yB75jl7f1CTkkBCRpCAl+IPzFcEmh69smsG3UUWRNWm8oU3igudeNSZ7cUsvMjg==
X-Received: by 2002:aca:5e42:: with SMTP id s63-v6mr26011332oib.134.1536117725294;
        Tue, 04 Sep 2018 20:22:05 -0700 (PDT)
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id b125-v6sm1718352oia.38.2018.09.04.20.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 20:22:04 -0700 (PDT)
Received: by mail-oi0-f50.google.com with SMTP id k81-v6so10926416oib.9;
        Tue, 04 Sep 2018 20:22:04 -0700 (PDT)
X-Received: by 2002:aca:1119:: with SMTP id 25-v6mr26404716oir.297.1536117724506;
 Tue, 04 Sep 2018 20:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180831035219.31619-1-ran.wang_1@nxp.com> <20180831035219.31619-3-ran.wang_1@nxp.com>
 <be39f5ea8c9046b0bf1f6bbfe935fae4@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <be39f5ea8c9046b0bf1f6bbfe935fae4@HXTBJIDCEMVIW02.hxtcorp.net>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 4 Sep 2018 22:21:53 -0500
X-Gmail-Original-Message-ID: <CADRPPNQN=27+pOSckxvwSuBJoFaz7pT+Z6h07Wu3Liz5ao5kkA@mail.gmail.com>
Message-ID: <CADRPPNQN=27+pOSckxvwSuBJoFaz7pT+Z6h07Wu3Liz5ao5kkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
To:     dongsheng.wang@hxt-semitech.com
Cc:     Ran Wang <ran.wang_1@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 9:58 PM Wang, Dongsheng
<dongsheng.wang@hxt-semitech.com> wrote:
>
> Please change your comments style.

Although this doesn't get into the Linux kernel coding style
documentation yet, Linus seems changed his mind to prefer // than /*
*/ comment style now.  https://lkml.org/lkml/2017/11/25/133   So the
// style should be acceptable for now.

>
> On 2018/8/31 11:56, Ran Wang wrote:
> > The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> > Control and Power Management), which performs all device-level
> > tasks associated with power management such as wakeup source control.
> >
> > This driver depends on FSL platform PM driver framework which help to
> > isolate user and PM service provider (such as RCPM driver).
> >
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> > Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/soc/fsl/Kconfig   |    6 ++
> >  drivers/soc/fsl/Makefile  |    1 +
> >  drivers/soc/fsl/ls-rcpm.c |  153 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 160 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/soc/fsl/ls-rcpm.c
> >
> > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> > index 6517412..882330d 100644
> > --- a/drivers/soc/fsl/Kconfig
> > +++ b/drivers/soc/fsl/Kconfig
> > @@ -30,3 +30,9 @@ config FSL_PLAT_PM
> >         have to know the implement details of wakeup function it require.
> >         Besides, it is also easy for service side to upgrade its logic when
> >         design changed and remain user side unchanged.
> > +
> > +config LS_RCPM
> > +     bool "Freescale RCPM support"
> > +     depends on (FSL_PLAT_PM)
> > +     help
> > +       This feature is to enable specified wakeup source for system sleep.
> > diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> > index 8f9db23..43ff71a 100644
> > --- a/drivers/soc/fsl/Makefile
> > +++ b/drivers/soc/fsl/Makefile
> > @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)            += qe/
> >  obj-$(CONFIG_CPM)                    += qe/
> >  obj-$(CONFIG_FSL_GUTS)                       += guts.o
> >  obj-$(CONFIG_FSL_PLAT_PM)    += plat_pm.o
> > +obj-$(CONFIG_LS_RCPM)                += ls-rcpm.o

Probably use "_" instead of "-" for alignment.

> > diff --git a/drivers/soc/fsl/ls-rcpm.c b/drivers/soc/fsl/ls-rcpm.c
> > new file mode 100644
> > index 0000000..b0feb88
> > --- /dev/null
> > +++ b/drivers/soc/fsl/ls-rcpm.c
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// plat_pm.c - Freescale Layerscape RCPM driver

The file name here is not the same as the real file name.

> > +//
> > +// Copyright 2018 NXP
> > +//
> > +// Author: Ran Wang <ran.wang_1@nxp.com>,

Where do you need the comma in the end?

> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/slab.h>
> > +#include <soc/fsl/plat_pm.h>
> > +
> > +#define MAX_COMPATIBLE_NUM   10
> > +
> > +struct rcpm_t {
> > +     struct device *dev;
> > +     void __iomem *ippdexpcr_addr;
> > +     bool big_endian;        /* Big/Little endian of RCPM module */
> > +};
> > +
> > +// rcpm_handle - Configure RCPM reg according to wake up source request
> > +// @user_dev: pointer to user's device struct
> > +// @flag: to enable(true) or disable(false) wakeup source
> > +// @handle_priv: pointer to struct rcpm_t instance
> > +//
> > +// Return 0 on success other negative errno

Although Linus preferred this // comment style.  I'm not sure if this
will be handled correctly by the kernel-doc compiler.
https://www.kernel.org/doc/html/v4.18/doc-guide/kernel-doc.html

> > +static int rcpm_handle(struct device *user_dev, bool flag, void *handle_priv)
> > +{
> > +     struct rcpm_t *rcpm;
> > +     bool big_endian;
> > +     const char  *dev_compatible_array[MAX_COMPATIBLE_NUM];
> > +     void __iomem *ippdexpcr_addr;
> > +     u32 ippdexpcr;
> > +     u32 set_bit;
> > +     int ret, num, i;
> > +
> > +     rcpm = handle_priv;
> > +     big_endian = rcpm->big_endian;
> > +     ippdexpcr_addr = rcpm->ippdexpcr_addr;
> > +
> > +     num = device_property_read_string_array(user_dev, "compatible",
> > +                     dev_compatible_array, MAX_COMPATIBLE_NUM);
> > +     if (num < 0)
> > +             return num;
> > +
> > +     for (i = 0; i < num; i++) {
> > +             if (!device_property_present(rcpm->dev,
> > +                                     dev_compatible_array[i]))
> > +                     continue;
> > +             else {
> Remove this else.
> > +                     ret = device_property_read_u32(rcpm->dev,
> > +                                     dev_compatible_array[i], &set_bit);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     if (!device_property_present(rcpm->dev,
> > +                                             dev_compatible_array[i]))
> This has been checked. Continue ? or return ENODEV？
> > +                             return -ENODEV;
> > +                     else {
> Remove this else.
> > +                             ret = device_property_read_u32(rcpm->dev,
> > +                                             dev_compatible_array[i], &set_bit);
> > +                             if (ret)
> > +                                     return ret;
> > +
> > +                             if (big_endian)
> > +                                     ippdexpcr = ioread32be(ippdexpcr_addr);
> > +                             else
> > +                                     ippdexpcr = ioread32(ippdexpcr_addr);
> > +
> > +                             if (flag)
> > +                                     ippdexpcr |= set_bit;
> > +                             else
> > +                                     ippdexpcr &= ~set_bit;
> > +
> > +                             if (big_endian) {
> > +                                     iowrite32be(ippdexpcr, ippdexpcr_addr);
> > +                                     ippdexpcr = ioread32be(ippdexpcr_addr);
> > +                             } else
> if (x) {
> ....
> ....
> }  else {
>
> }
> > +                                     iowrite32(ippdexpcr, ippdexpcr_addr);
> > +
> > +                             return 0;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return -ENODEV;
> > +}
> > +
> > +static int ls_rcpm_probe(struct platform_device *pdev)
> > +{
> > +     struct resource *r;
> > +     struct rcpm_t *rcpm;
> > +
> > +     r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!r)
> > +             return -ENODEV;
> > +
> > +     rcpm = kmalloc(sizeof(*rcpm), GFP_KERNEL);
> kzalloc is better.
> > +     if (!rcpm)
> > +             return -ENOMEM;
> > +
> > +     rcpm->big_endian = device_property_read_bool(&pdev->dev, "big-endian");
> > +
> > +     rcpm->ippdexpcr_addr = devm_ioremap_resource(&pdev->dev, r);
> > +     if (IS_ERR(rcpm->ippdexpcr_addr))
> > +             return PTR_ERR(rcpm->ippdexpcr_addr);
> > +
> > +     rcpm->dev = &pdev->dev;
> > +     platform_set_drvdata(pdev, rcpm);
> > +
> > +     return register_fsl_platform_wakeup_source(rcpm_handle, rcpm);
> > +}
> > +
> > +static int ls_rcpm_remove(struct platform_device *pdev)
> > +{
> > +     struct rcpm_t   *rcpm;
> Not need a table.
>
> Cheers,
> -Dongsheng
>
> > +
> > +     rcpm = platform_get_drvdata(pdev);
> > +     deregister_fsl_platform_wakeup_source(rcpm);
> > +     kfree(rcpm);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id ls_rcpm_of_match[] = {
> > +     { .compatible = "fsl,qoriq-rcpm-2.1", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, ls_rcpm_of_match);
> > +
> > +static struct platform_driver ls_rcpm_driver = {
> > +     .driver = {
> > +             .name = "ls-rcpm",
> > +             .of_match_table = ls_rcpm_of_match,
> > +     },
> > +     .probe = ls_rcpm_probe,
> > +     .remove = ls_rcpm_remove,
> > +};
> > +
> > +static int __init ls_rcpm_init(void)
> > +{
> > +     return platform_driver_register(&ls_rcpm_driver);
> > +}
> > +subsys_initcall(ls_rcpm_init);
> > +
> > +static void __exit ls_rcpm_exit(void)
> > +{
> > +     platform_driver_unregister(&ls_rcpm_driver);
> > +}
> > +module_exit(ls_rcpm_exit);
>
>
