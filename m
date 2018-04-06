Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1200889-1523013355-2-7003566034703155444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523013355; b=X+Ik3YPQszLpIFW7GaU1O0jVrC80PrUL+shQvkSu248f+mi7Gp
    y5VOQzeTXcP3GzY0y4iwTU8Aj5HgKTbiJQX3xC3mEnw/cByBCqlRppw4ke/Mqo7Q
    3D+s8JVZAA46n36JEd/Vsgycd/nq8bK+dEJI1jbA7E9AeCPsufAmNjCXIb+q86BV
    Ot35Z5IY5JkehZCIcInT6uKeij+YdD1GrpP+OiLfFvzPIKiCg7B9dwBExxM2eWnl
    sLwpfEqehuqsvpX/08XmJBU78HIokbQ0oORMi9kydE10P758VjBeVmsofmHZ96r0
    jhk/Ecef+5kqUY5xb9qKC+yDVHFKo5haq1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523013355; bh=ks8HaNJ9wIHXgYpZLEj/9qnsA12LMU
    MRaqCJmtMQtBw=; b=Wh+w6oC+EP+0CzD2gsr7594JK5xk6/zojPeHWxWosk2zYu
    fmNurP9Win99gSY9YFxV+AF1Z4ovltl6QOFEhyvvb1Q77/CIAbSD+UnSekbQRy8M
    F/B9sjKr8eu672jN09Uf+v0uPZaqUplW7pP+sNMQlZhu9GQ1EgegKIjYVvFg76fW
    XYjLviH2tz1NPV2fH9Q1Q9+wspQtZp+/WxdWqHQLBprQ/enVRxh1tlSOR8N/Htdj
    JQPElhLPuut0C+y3F+LBkuLuRAJ6eEPAKjgxovWn6Bgk3chIg4pFYjitC0TRLB3W
    /6xqOLvsE/RT/T1fbtS3mzZ/mEAkYdQRH8JTrmDg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEqGHouRYEMLhZOua7nQr4ODy7+NT30CicfguTQn0fKFlVUNH7nVnOMBfgQRxAjite57+h1wkO2I34bczfZ5QVzbqbhCUV8GWs/klGtyMYqydVFoCJR6
    dzUzALKQqgGo8EkDut/GS5Z5A+CLGD3Cq/na8oW7ZwujBP9FJQHr1uPrQGLb800PJ25ZvYpDuXdWXGNyALltillFDlHHwzcJ82bgno6SjaYsiTtfYffZAN0y
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=OV1AzFSQLN5PEUKYy3AA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeDFLPw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 07:15:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:5867 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeDFLPv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Apr 2018 07:15:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="218153639"
Date: Fri, 6 Apr 2018 19:05:36 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v4 20/24] fpga: dfl: add FPGA Accelerated Function Unit
 driver basic framework
Message-ID: <20180406110536.GC32345@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-21-git-send-email-hao.wu@intel.com>
 <CANk1AXSgd4ySjCqiTyMA4vaOq4jByhLOot02GCLMmgoQSye49Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSgd4ySjCqiTyMA4vaOq4jByhLOot02GCLMmgoQSye49Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 01:26:57PM -0500, Alan Tull wrote:
> On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> One minor thing below.
> 
> > On DFL FPGA devices, the Accelerated Function Unit (AFU), can be
> > reprogrammed for different functions. It connects to the FPGA
> > infrastructure("blue bistream") via a Port. Port CSRs are implemented
> > separately from the AFU CSRs to provide control and status of the Port.
> > Once valid green bitstream is programmed into the AFU, it allows access
> > to the AFU CSRs in the AFU MMIO space.
> >
> > This patch only implements basic driver framework for AFU, including
> > device file operation framework.
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ---
> > v3: rename driver to dfl-afu-main.c
> > v4: rename to dfl-port and fix SPDX license issue.
> > ---
> >  drivers/fpga/Kconfig        |   9 +++
> >  drivers/fpga/Makefile       |   2 +
> >  drivers/fpga/dfl-afu-main.c | 159 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 170 insertions(+)
> >  create mode 100644 drivers/fpga/dfl-afu-main.c
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 65d54a4..4c6b45f 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -168,6 +168,15 @@ config FPGA_DFL_FME_REGION
> >         help
> >           Say Y to enable FPGA Region driver for FPGA Management Engine.
> >
> > +config FPGA_DFL_AFU
> > +       tristate "FPGA DFL AFU Driver"
> > +       depends on FPGA_DFL
> > +       help
> > +         This is the driver for FPGA Accelerated Function Unit (AFU) which
> > +         implements AFU and Port management features. A User AFU connects
> > +         to the FPGA infrastructure via a Port. There may be more than 1
> > +         Port/AFU per DFL based FPGA device.
> > +
> >  config FPGA_DFL_PCI
> >         tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
> >         depends on PCI && FPGA_DFL
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 163894e..5c9607b 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -34,8 +34,10 @@ obj-$(CONFIG_FPGA_DFL_FME)           += dfl-fme.o
> >  obj-$(CONFIG_FPGA_DFL_FME_MGR)         += dfl-fme-mgr.o
> >  obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)      += dfl-fme-br.o
> >  obj-$(CONFIG_FPGA_DFL_FME_REGION)      += dfl-fme-region.o
> > +obj-$(CONFIG_FPGA_DFL_AFU)             += dfl-afu.o
> >
> >  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
> > +dfl-afu-objs := dfl-afu-main.o
> >
> >  # Drivers for FPGAs which implement DFL
> >  obj-$(CONFIG_FPGA_DFL_PCI)             += dfl-pci.o
> > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > new file mode 100644
> > index 0000000..70db28c
> > --- /dev/null
> > +++ b/drivers/fpga/dfl-afu-main.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for FPGA Accelerated Function Unit (AFU)
> > + *
> > + * Copyright (C) 2017 Intel Corporation, Inc.
> > + *
> > + * Authors:
> > + *   Wu Hao <hao.wu@intel.com>
> > + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > + *   Joseph Grecco <joe.grecco@intel.com>
> > + *   Enno Luebbers <enno.luebbers@intel.com>
> > + *   Tim Whisonant <tim.whisonant@intel.com>
> > + *   Ananda Ravuri <ananda.ravuri@intel.com>
> > + *   Henry Mitchel <henry.mitchel@intel.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +#include "dfl.h"
> > +
> > +static int port_hdr_init(struct platform_device *pdev, struct feature *feature)
> > +{
> > +       dev_dbg(&pdev->dev, "PORT HDR Init.\n");
> > +
> > +       return 0;
> > +}
> > +
> > +static void port_hdr_uinit(struct platform_device *pdev,
> > +                          struct feature *feature)
> > +{
> > +       dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
> > +}
> > +
> > +static const struct feature_ops port_hdr_ops = {
> > +       .init = port_hdr_init,
> > +       .uinit = port_hdr_uinit,
> > +};
> > +
> > +static struct feature_driver port_feature_drvs[] = {
> > +       {
> > +               .id = PORT_FEATURE_ID_HEADER,
> > +               .ops = &port_hdr_ops,
> > +       },
> > +       {
> > +               .ops = NULL,
> > +       }
> > +};
> > +
> > +static int afu_open(struct inode *inode, struct file *filp)
> > +{
> > +       struct platform_device *fdev = fpga_inode_to_feature_dev(inode);
> > +       struct feature_platform_data *pdata;
> > +       int ret;
> > +
> > +       pdata = dev_get_platdata(&fdev->dev);
> > +       if (WARN_ON(!pdata))
> > +               return -ENODEV;
> > +
> > +       ret = feature_dev_use_begin(pdata);
> > +       if (ret)
> > +               return ret;
> > +
> > +       dev_dbg(&fdev->dev, "Device File Open\n");
> > +       filp->private_data = fdev;
> > +
> > +       return 0;
> > +}
> > +
> > +static int afu_release(struct inode *inode, struct file *filp)
> > +{
> > +       struct platform_device *pdev = filp->private_data;
> > +       struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +
> > +       dev_dbg(&pdev->dev, "Device File Release\n");
> > +
> > +       feature_dev_use_end(pdata);
> > +
> > +       return 0;
> > +}
> > +
> > +static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > +{
> > +       struct platform_device *pdev = filp->private_data;
> > +       struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +       struct feature *f;
> > +       long ret;
> > +
> > +       dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
> > +
> > +       switch (cmd) {
> > +       default:
> > +               /*
> > +                * Let sub-feature's ioctl function to handle the cmd
> > +                * Sub-feature's ioctl returns -ENODEV when cmd is not
> > +                * handled in this sub feature, and returns 0 and other
> > +                * error code if cmd is handled.
> > +                */
> > +               fpga_dev_for_each_feature(pdata, f)
> > +                       if (f->ops && f->ops->ioctl) {
> > +                               ret = f->ops->ioctl(pdev, f, cmd, arg);
> > +                               if (ret == -ENODEV)
> > +                                       continue;
> > +                               else
> > +                                       return ret;
> 
> The continue..else isn't needed.  Could just be
> if (ret != -ENODEV)
>         return ret;

Agree, will fix this in the next version. Thanks.

Hao

> 
> Thanks,
> Alan
> 
> > +                       }
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static const struct file_operations afu_fops = {
> > +       .owner = THIS_MODULE,
> > +       .open = afu_open,
> > +       .release = afu_release,
> > +       .unlocked_ioctl = afu_ioctl,
> > +};
> > +
> > +static int afu_probe(struct platform_device *pdev)
> > +{
> > +       int ret;
> > +
> > +       dev_dbg(&pdev->dev, "%s\n", __func__);
> > +
> > +       ret = fpga_dev_feature_init(pdev, port_feature_drvs);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = fpga_register_dev_ops(pdev, &afu_fops, THIS_MODULE);
> > +       if (ret)
> > +               fpga_dev_feature_uinit(pdev);
> > +
> > +       return ret;
> > +}
> > +
> > +static int afu_remove(struct platform_device *pdev)
> > +{
> > +       dev_dbg(&pdev->dev, "%s\n", __func__);
> > +
> > +       fpga_dev_feature_uinit(pdev);
> > +       fpga_unregister_dev_ops(pdev);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver afu_driver = {
> > +       .driver = {
> > +               .name    = FPGA_FEATURE_DEV_PORT,
> > +       },
> > +       .probe   = afu_probe,
> > +       .remove  = afu_remove,
> > +};
> > +
> > +module_platform_driver(afu_driver);
> > +
> > +MODULE_DESCRIPTION("FPGA Accelerated Function Unit driver");
> > +MODULE_AUTHOR("Intel Corporation");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:dfl-port");
> > --
> > 2.7.4
> >
