Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3493453-1522953369-2-220946980383223335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522953368; b=dsbLpWfaXW+UKtbcxSvZ5S7j6vEa0UUse71YQP7vgOQFekp2FF
    ztalukgPldikjTnANqswK/oP5MLwZvIEWOfSBDglZVFPpsJ0VVL08AkpM2D2b9dd
    SLoK2R0xgAjvyUBiBwubWrj+TGNQYhZLVFHxS2n8PDeUO4QFensg0XF6pDVcoE8N
    tl4kHGUGio4ODC7fabBQyMHqB91z2938Rf8M3wrhgjoYudztbWx5tQRvQN+qHfYe
    MmV0Ki4RGDDMDgpKcb6TNmzUNizBFDhVIQjgmisC5S7bo8NUp0Mz1PabtjLahtLV
    OuUa59D1QmR2ty4KjVs8RnHw/udxP4AqVMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522953368; bh=E2TWMoLCCHWI7mNFOppQW0pC+iuHeWdJKwQj46Ev7z
    k=; b=h1+Wr2ZUSVPhUyPCVqYv/+e/U3s0NWUycQlTMc51C5a4pDUumNUs0+vP+6
    98QAKEO78n7lb9IdiDXJ84N94kqx/GBXUX/6uJ+W4wzidHsoa6wDmN7/mEI+WlrW
    m+gFJLDhFl8LyMsviti3mmA9OgN83rg+el3upCo7Oei+YpyfPbkdRllGglls5ctr
    OwQyrtSRSJNno+ghV3DFm8fet9QKhf0VfWCrVblA3HB2wHOdabMvAaW8KcWNf4oG
    F1D/BxY2Og4vBaBU2zNFE+JyiHJvm8epBs1XscKJKffNv2ybwRMnCm7fnOaX0jzu
    L4ONgmSgx6JtmcrtUmIAlu2x/WTw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfDIMSXl0s+LMvtiwNyBXaeBq6vt/lTA0Tq4F890PJzXT5ZqaLi053R0XqYwiyDp0YtPD5hFIMvrLPB7BvFgOdJsGOEr4RWZV0soFNEf76wYrIoQD1ZLC
    YXMEaAPDVixuuE/FtJljrUmdN72iM+YDM5Pvg5ScdRUvs3Fpbnu2AABOS71tEUdsGGV2Aw1lA4zLTv7orQYQNGHOrwJwg9DvKRWEDxGpkbe3E66w+R7n2ugk
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=_7LLW5jbodoAwVwztI8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeDESgH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 14:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751705AbeDESgG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 5 Apr 2018 14:36:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86040217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AIpwx48pes3XjFfrAmhLSWHirATcelxNmFIf1YZT1EXG5g/U3bcBulMbWSiACArZO7h58n513LCgr56UhNk1MfXS3Io=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-11-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-11-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 5 Apr 2018 13:35:24 -0500
X-Gmail-Original-Message-ID: <CANk1AXQidwWhHfHd-usQVdK3jZbJuB3y8=NK7y5K_h_8eJhjAg@mail.gmail.com>
Message-ID: <CANk1AXQidwWhHfHd-usQVdK3jZbJuB3y8=NK7y5K_h_8eJhjAg@mail.gmail.com>
Subject: Re: [PATCH v4 10/24] fpga: dfl: add FPGA Management Engine driver
 basic framework
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

> From: Kang Luwei <luwei.kang@intel.com>
>
> The FPGA Management Engine (FME) provides power, thermal management,
> performance counters, partial reconfiguration and other functions. For each
> function, it is packaged into a private feature linked to the FME feature
> device in the 'Device Feature List'. It's a platform device created by
> DFL framework.
>
> This patch adds the basic framework of FME platform driver. It defines
> sub feature drivers to handle the different sub features, including init,
> uinit and ioctl. It also registers the file operations for the device file.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
> v3: rename driver from intel-fpga-fme to dfl-fme
>     rename Kconfig from INTEL_FPGA_FME to FPGA_DFL_FME
> v4: fix SPDX license issue, use dfl-fme as module name
> ---
>  drivers/fpga/Kconfig        |  10 +++
>  drivers/fpga/Makefile       |   3 +
>  drivers/fpga/dfl-fme-main.c | 158 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+)
>  create mode 100644 drivers/fpga/dfl-fme-main.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 87f3d44..103d5e2 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -140,6 +140,16 @@ config FPGA_DFL
>           Gate Array (FPGA) solutions which implement Device Feature List.
>           It provides enumeration APIs, and feature device infrastructure.
>
> +config FPGA_DFL_FME
> +       tristate "FPGA DFL FME Driver"
> +       depends on FPGA_DFL
> +       help
> +         The FPGA Management Engine (FME) is a feature device implemented
> +         under Device Feature List (DFL) framework. Select this option to
> +         enable the platform device driver for FME which implements all
> +         FPGA platform level management features. There shall be 1 FME
> +         per DFL based FPGA device.
> +
>  config FPGA_DFL_PCI
>         tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
>         depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 4375630..fbd1c85 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -30,6 +30,9 @@ obj-$(CONFIG_OF_FPGA_REGION)          += of-fpga-region.o
>
>  # FPGA Device Feature List Support
>  obj-$(CONFIG_FPGA_DFL)                 += dfl.o
> +obj-$(CONFIG_FPGA_DFL_FME)             += dfl-fme.o
> +
> +dfl-fme-objs := dfl-fme-main.o
>
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)             += dfl-pci.o
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> new file mode 100644
> index 0000000..ebe6b52
> --- /dev/null
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA Management Engine (FME)
> + *
> + * Copyright (C) 2017 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Kang Luwei <luwei.kang@intel.com>
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
> +static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
> +{
> +       dev_dbg(&pdev->dev, "FME HDR Init.\n");
> +
> +       return 0;
> +}
> +
> +static void fme_hdr_uinit(struct platform_device *pdev, struct feature *feature)
> +{
> +       dev_dbg(&pdev->dev, "FME HDR UInit.\n");
> +}
> +
> +static const struct feature_ops fme_hdr_ops = {
> +       .init = fme_hdr_init,
> +       .uinit = fme_hdr_uinit,
> +};
> +
> +static struct feature_driver fme_feature_drvs[] = {
> +       {
> +               .id = FME_FEATURE_ID_HEADER,
> +               .ops = &fme_hdr_ops,
> +       },
> +       {
> +               .ops = NULL,
> +       },
> +};
> +
> +static int fme_open(struct inode *inode, struct file *filp)
> +{
> +       struct platform_device *fdev = fpga_inode_to_feature_dev(inode);
> +       struct feature_platform_data *pdata = dev_get_platdata(&fdev->dev);
> +       int ret;
> +
> +       if (WARN_ON(!pdata))
> +               return -ENODEV;
> +
> +       ret = feature_dev_use_begin(pdata);
> +       if (ret)
> +               return ret;
> +
> +       dev_dbg(&fdev->dev, "Device File Open\n");
> +       filp->private_data = pdata;
> +
> +       return 0;
> +}
> +
> +static int fme_release(struct inode *inode, struct file *filp)
> +{
> +       struct feature_platform_data *pdata = filp->private_data;
> +       struct platform_device *pdev = pdata->dev;
> +
> +       dev_dbg(&pdev->dev, "Device File Release\n");
> +       feature_dev_use_end(pdata);
> +
> +       return 0;
> +}
> +
> +static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +       struct feature_platform_data *pdata = filp->private_data;
> +       struct platform_device *pdev = pdata->dev;
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
> +               fpga_dev_for_each_feature(pdata, f) {
> +                       if (f->ops && f->ops->ioctl) {
> +                               ret = f->ops->ioctl(pdev, f, cmd, arg);
> +                               if (ret == -ENODEV)
> +                                       continue;
> +                               else
> +                                       return ret;

continue and else aren't needed.  Could be

if (ret != -ENODEV)
        return ret;

Alan

> +                       }
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static const struct file_operations fme_fops = {
> +       .owner          = THIS_MODULE,
> +       .open           = fme_open,
> +       .release        = fme_release,
> +       .unlocked_ioctl = fme_ioctl,
> +};
> +
> +static int fme_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       ret = fpga_dev_feature_init(pdev, fme_feature_drvs);
> +       if (ret)
> +               goto exit;
> +
> +       ret = fpga_register_dev_ops(pdev, &fme_fops, THIS_MODULE);
> +       if (ret)
> +               goto feature_uinit;
> +
> +       return 0;
> +
> +feature_uinit:
> +       fpga_dev_feature_uinit(pdev);
> +exit:
> +       return ret;
> +}
> +
> +static int fme_remove(struct platform_device *pdev)
> +{
> +       fpga_dev_feature_uinit(pdev);
> +       fpga_unregister_dev_ops(pdev);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver fme_driver = {
> +       .driver = {
> +               .name    = FPGA_FEATURE_DEV_FME,
> +       },
> +       .probe   = fme_probe,
> +       .remove  = fme_remove,
> +};
> +
> +module_platform_driver(fme_driver);
> +
> +MODULE_DESCRIPTION("FPGA Management Engine driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:dfl-fme");
> --
> 2.7.4
>
