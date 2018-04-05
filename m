Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3493453-1522952863-2-672115813768174913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522952862; b=rKgfwatA+mEjchNZJ/P6wHJe4xHYxw+jw0fVKGNtxwFTCs0LrT
    b/7hkloD0sPC3TMo5k5iH2HXNQsUJ8sYtjmivdf4cjCNSNusqKpXbuFKbhJ8KmyA
    +dN6Td+hooD6BaPux1X+9WIS2mLtxwWS13CtS2Brkl0Kf74iXnvrrjPFidhbGm8M
    zOZ7v1P+2FRC1Ozn4qbGDO8rheiBXzd5Vwqxof9ZvuJM5X100mXHAH0RAQm0x7nY
    irdMkPLnSGdIYb7UpKd2HEWB9VDHkbGLI6aKbPC+1mw+6ISkPEk/K4710tzCAqS2
    CkEJlfuJrP6YdNZ5S3Q4JTC5CiBz6Gv5UV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522952862; bh=DUm3827z8QVDQ4cOZXftv9c+8rE0lcB+ucobXyRw/O
    k=; b=JI1fXpnjBYlYNFFU5Fu47kvsiConFR2/JGA8sZGdUDfZvK7txGmZdPEove
    VO1JRJGM1T/NCxklPLo4G5BesHJa2jVgc+7cV8rLgMHxLntyk4/uPt/WQ24ZFxJ7
    Le8TO9GtjJzKL+1i5iZkJcGIOUlss+rSLxVhX8Ouu8dG72qL/s9kudDD4NFi/O2Q
    dzdi/6APTDdYnJjsPnMfbRPyj5w11S/E9BQm/UA+htvqLgIZwQ2r9N8oavzic6mt
    l1o7LIKX5lryrPB0Hr1x/+esSCx6eo2i5f0XxjyTQ1Jt/zwSYx0/C9icWCop6qwC
    J7JB1rSbaD5PWlg9qUxEhQgZOvjg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLUwEFl6vQ2EIGOtjvY21rUjgfqkx5F2Mv4gkwkZjrDKB4gsy3HHteifvWrJtPEueEhgLjAP7svdtwtbjT2101795rvi4JwiCbsMm5duFXOszFh1fMei
    v2CCPp9DMZS3yCnSRRMamgdwrh1kTTYgoComNa6Eekvo0GYODCMHyuiycUhM9rjPLuP1VqOP2UFKvHeKr6vrvnKCM5EsHIrC8SlzotDDDRiYh5EQFvwreVcM
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=xZAQ2BBQRKYPNH4jEggA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeDES1k (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 14:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbeDES1j (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 5 Apr 2018 14:27:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC176217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AIpwx48cyCwtSAt42nYHYU0p0rUipuNwmbkx65MNB9QE2iHPG9V6M8VjopzynE8c6ij7PSwIhLU83cQPKwokl6ZgiEw=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-21-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-21-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 5 Apr 2018 13:26:57 -0500
X-Gmail-Original-Message-ID: <CANk1AXSgd4ySjCqiTyMA4vaOq4jByhLOot02GCLMmgoQSye49Q@mail.gmail.com>
Message-ID: <CANk1AXSgd4ySjCqiTyMA4vaOq4jByhLOot02GCLMmgoQSye49Q@mail.gmail.com>
Subject: Re: [PATCH v4 20/24] fpga: dfl: add FPGA Accelerated Function Unit
 driver basic framework
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

One minor thing below.

> On DFL FPGA devices, the Accelerated Function Unit (AFU), can be
> reprogrammed for different functions. It connects to the FPGA
> infrastructure("blue bistream") via a Port. Port CSRs are implemented
> separately from the AFU CSRs to provide control and status of the Port.
> Once valid green bitstream is programmed into the AFU, it allows access
> to the AFU CSRs in the AFU MMIO space.
>
> This patch only implements basic driver framework for AFU, including
> device file operation framework.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
> v3: rename driver to dfl-afu-main.c
> v4: rename to dfl-port and fix SPDX license issue.
> ---
>  drivers/fpga/Kconfig        |   9 +++
>  drivers/fpga/Makefile       |   2 +
>  drivers/fpga/dfl-afu-main.c | 159 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 drivers/fpga/dfl-afu-main.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 65d54a4..4c6b45f 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -168,6 +168,15 @@ config FPGA_DFL_FME_REGION
>         help
>           Say Y to enable FPGA Region driver for FPGA Management Engine.
>
> +config FPGA_DFL_AFU
> +       tristate "FPGA DFL AFU Driver"
> +       depends on FPGA_DFL
> +       help
> +         This is the driver for FPGA Accelerated Function Unit (AFU) which
> +         implements AFU and Port management features. A User AFU connects
> +         to the FPGA infrastructure via a Port. There may be more than 1
> +         Port/AFU per DFL based FPGA device.
> +
>  config FPGA_DFL_PCI
>         tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
>         depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 163894e..5c9607b 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -34,8 +34,10 @@ obj-$(CONFIG_FPGA_DFL_FME)           += dfl-fme.o
>  obj-$(CONFIG_FPGA_DFL_FME_MGR)         += dfl-fme-mgr.o
>  obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)      += dfl-fme-br.o
>  obj-$(CONFIG_FPGA_DFL_FME_REGION)      += dfl-fme-region.o
> +obj-$(CONFIG_FPGA_DFL_AFU)             += dfl-afu.o
>
>  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
> +dfl-afu-objs := dfl-afu-main.o
>
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)             += dfl-pci.o
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> new file mode 100644
> index 0000000..70db28c
> --- /dev/null
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA Accelerated Function Unit (AFU)
> + *
> + * Copyright (C) 2017 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Wu Hao <hao.wu@intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *   Joseph Grecco <joe.grecco@intel.com>
> + *   Enno Luebbers <enno.luebbers@intel.com>
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Henry Mitchel <henry.mitchel@intel.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "dfl.h"
> +
> +static int port_hdr_init(struct platform_device *pdev, struct feature *feature)
> +{
> +       dev_dbg(&pdev->dev, "PORT HDR Init.\n");
> +
> +       return 0;
> +}
> +
> +static void port_hdr_uinit(struct platform_device *pdev,
> +                          struct feature *feature)
> +{
> +       dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
> +}
> +
> +static const struct feature_ops port_hdr_ops = {
> +       .init = port_hdr_init,
> +       .uinit = port_hdr_uinit,
> +};
> +
> +static struct feature_driver port_feature_drvs[] = {
> +       {
> +               .id = PORT_FEATURE_ID_HEADER,
> +               .ops = &port_hdr_ops,
> +       },
> +       {
> +               .ops = NULL,
> +       }
> +};
> +
> +static int afu_open(struct inode *inode, struct file *filp)
> +{
> +       struct platform_device *fdev = fpga_inode_to_feature_dev(inode);
> +       struct feature_platform_data *pdata;
> +       int ret;
> +
> +       pdata = dev_get_platdata(&fdev->dev);
> +       if (WARN_ON(!pdata))
> +               return -ENODEV;
> +
> +       ret = feature_dev_use_begin(pdata);
> +       if (ret)
> +               return ret;
> +
> +       dev_dbg(&fdev->dev, "Device File Open\n");
> +       filp->private_data = fdev;
> +
> +       return 0;
> +}
> +
> +static int afu_release(struct inode *inode, struct file *filp)
> +{
> +       struct platform_device *pdev = filp->private_data;
> +       struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +
> +       dev_dbg(&pdev->dev, "Device File Release\n");
> +
> +       feature_dev_use_end(pdata);
> +
> +       return 0;
> +}
> +
> +static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +       struct platform_device *pdev = filp->private_data;
> +       struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +       struct feature *f;
> +       long ret;
> +
> +       dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
> +
> +       switch (cmd) {
> +       default:
> +               /*
> +                * Let sub-feature's ioctl function to handle the cmd
> +                * Sub-feature's ioctl returns -ENODEV when cmd is not
> +                * handled in this sub feature, and returns 0 and other
> +                * error code if cmd is handled.
> +                */
> +               fpga_dev_for_each_feature(pdata, f)
> +                       if (f->ops && f->ops->ioctl) {
> +                               ret = f->ops->ioctl(pdev, f, cmd, arg);
> +                               if (ret == -ENODEV)
> +                                       continue;
> +                               else
> +                                       return ret;

The continue..else isn't needed.  Could just be
if (ret != -ENODEV)
        return ret;

Thanks,
Alan

> +                       }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static const struct file_operations afu_fops = {
> +       .owner = THIS_MODULE,
> +       .open = afu_open,
> +       .release = afu_release,
> +       .unlocked_ioctl = afu_ioctl,
> +};
> +
> +static int afu_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       dev_dbg(&pdev->dev, "%s\n", __func__);
> +
> +       ret = fpga_dev_feature_init(pdev, port_feature_drvs);
> +       if (ret)
> +               return ret;
> +
> +       ret = fpga_register_dev_ops(pdev, &afu_fops, THIS_MODULE);
> +       if (ret)
> +               fpga_dev_feature_uinit(pdev);
> +
> +       return ret;
> +}
> +
> +static int afu_remove(struct platform_device *pdev)
> +{
> +       dev_dbg(&pdev->dev, "%s\n", __func__);
> +
> +       fpga_dev_feature_uinit(pdev);
> +       fpga_unregister_dev_ops(pdev);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver afu_driver = {
> +       .driver = {
> +               .name    = FPGA_FEATURE_DEV_PORT,
> +       },
> +       .probe   = afu_probe,
> +       .remove  = afu_remove,
> +};
> +
> +module_platform_driver(afu_driver);
> +
> +MODULE_DESCRIPTION("FPGA Accelerated Function Unit driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:dfl-port");
> --
> 2.7.4
>
