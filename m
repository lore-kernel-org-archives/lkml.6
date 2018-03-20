Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2284343-1521578000-2-10616448162927718317
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521577999; b=r4MpZ7Pv6NPtbcWtUfw4zuRGkErK/W7COo+sdf4X2smr4Qp
    1vxy+IfymvDWScCkN1W63BinwB4oYCjukPCbLdu3If7WCL//cXEimTj/rLuv7lt6
    ky916u5TRBJSS1M00km97eYFRvZ7ZAC1z27i7+epiMSZ7Ypum+LZLQuqKn+QjnjB
    55ppAx3yIn58leKiZKVMWJazORCeRZPOVncg5j3YFs4aGmtzCyz41G2hPO5sBojm
    S7pFKLnD5v6ZHU/mbf5bbrW1ztINDp8NAVDptlUX+ViU7OWHn78A8yGiiNXqhEwI
    9WwhLgXnm1BTw3iy6/mUWGpa3KrFb2kGa51KlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521577999; bh=ci37xQHwxe5tGe1WN60/o6LNePntsTqHe2cavN
    J690g=; b=PLldeYMzXPstWGL/0d83FFrYB9uL3S3maHV9ol6EpSa+j5omzn+ZQx
    zEcDVnY295GtAmPfsm+Msn1AEHh0sjgCSdn8/DiH47PwrJjPQDQZ3a2v5OxQr3eL
    KoSGdgqyR9hMJP/+J2RfZFqXcwNa1cBFO+tHcOlKx+RMzqeuKl0krQmOzKWGdcXP
    9fhwHKzd8xMlfOnA14cmPkcmKh5XVjKGAyxoBGCISqTnYNQRKy6vEkpoX+raAyQB
    WDX8vKPGREgG6w5NeUQpWU2Iz1+VJjLIXYpeg+pfJ+zOSLXAIYdet60lTZsnyrar
    OrwmeJDssTS9xduo4DJYz4AreTvNdAlQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeCTUdS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 16:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbeCTUdQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 16:33:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA3E2178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELuZ+e2+K69nhL/TUq13VLu7AFQIBxh9Xu7Wzem5W9zuwfQnuz8THfKaepktCmf6aTbVRHS2/bASZAJ+rY1MXPI=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-17-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-17-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 20 Mar 2018 15:32:34 -0500
X-Gmail-Original-Message-ID: <CANk1AXSG08+=2pbhfiUV+mATO3F=MmDmmsc3ZFq5Eo7=WGOWag@mail.gmail.com>
Message-ID: <CANk1AXSG08+=2pbhfiUV+mATO3F=MmDmmsc3ZFq5Eo7=WGOWag@mail.gmail.com>
Subject: Re: [PATCH v4 16/24] fpga: dfl: add fpga manager platform driver for FME
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

Elsewhere we discussed moving #defines used only in this driver either
to this .c file or to a similarly named .h file.  A couple minor
things below.

> This patch adds fpga manager driver for FPGA Management Engine (FME). It
> implements fpga_manager_ops for FPGA Partial Reconfiguration function.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
> v3: rename driver to dfl-fpga-fme-mgr
>     implemented status callback for fpga manager
>     rebased due to fpga api changes
> v4: rename to dfl-fme-mgr, and fix SPDX license issue
>     add pr_credit comments and improve dev_err message
>     remove interface_id sysfs interface
>     include dfl-fme-pr.h instead of dfl.h
> ---
>  drivers/fpga/Kconfig       |   6 +
>  drivers/fpga/Makefile      |   1 +
>  drivers/fpga/dfl-fme-mgr.c | 290 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 297 insertions(+)
>  create mode 100644 drivers/fpga/dfl-fme-mgr.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 103d5e2..89f76e8 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -150,6 +150,12 @@ config FPGA_DFL_FME
>           FPGA platform level management features. There shall be 1 FME
>           per DFL based FPGA device.
>
> +config FPGA_DFL_FME_MGR
> +       tristate "FPGA DFL FME Manager Driver"
> +       depends on FPGA_DFL_FME
> +       help
> +         Say Y to enable FPGA Manager driver for FPGA Management Engine.
> +
>  config FPGA_DFL_PCI
>         tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
>         depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 3c44fc9..f82814a 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_OF_FPGA_REGION)          += of-fpga-region.o
>  # FPGA Device Feature List Support
>  obj-$(CONFIG_FPGA_DFL)                 += dfl.o
>  obj-$(CONFIG_FPGA_DFL_FME)             += dfl-fme.o
> +obj-$(CONFIG_FPGA_DFL_FME_MGR)         += dfl-fme-mgr.o
>
>  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
>
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> new file mode 100644
> index 0000000..2f92c29
> --- /dev/null
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FPGA Manager Driver for FPGA Management Engine (FME)
> + *
> + * Copyright (C) 2017 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Kang Luwei <luwei.kang@intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *   Wu Hao <hao.wu@intel.com>
> + *   Joseph Grecco <joe.grecco@intel.com>
> + *   Enno Luebbers <enno.luebbers@intel.com>
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Christopher Rauer <christopher.rauer@intel.com>
> + *   Henry Mitchel <henry.mitchel@intel.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/iopoll.h>
> +#include <linux/fpga/fpga-mgr.h>
> +
> +#include "dfl-fme-pr.h"
> +
> +#define PR_WAIT_TIMEOUT   8000000
> +#define PR_HOST_STATUS_IDLE    0
> +
> +struct fme_mgr_priv {
> +       void __iomem *ioaddr;
> +       u64 pr_error;
> +};
> +
> +static u64 pr_error_to_mgr_status(u64 err)
> +{
> +       u64 status = 0;
> +
> +       if (err & FME_PR_ERR_OPERATION_ERR)
> +               status |= FPGA_MGR_STATUS_OPERATION_ERR;
> +       if (err & FME_PR_ERR_CRC_ERR)
> +               status |= FPGA_MGR_STATUS_CRC_ERR;
> +       if (err & FME_PR_ERR_INCOMPATIBLE_BS)
> +               status |= FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR;
> +       if (err & FME_PR_ERR_PROTOCOL_ERR)
> +               status |= FPGA_MGR_STATUS_IP_PROTOCOL_ERR;
> +       if (err & FME_PR_ERR_FIFO_OVERFLOW)
> +               status |= FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR;
> +
> +       return status;
> +}
> +
> +static u64 fme_mgr_pr_error_handle(void __iomem *fme_pr)
> +{
> +       u64 pr_status, pr_error;
> +
> +       pr_status = readq(fme_pr + FME_PR_STS);
> +       if (!(pr_status & FME_PR_STS_PR_STS))
> +               return 0;
> +
> +       pr_error = readq(fme_pr + FME_PR_ERR);
> +       writeq(pr_error, fme_pr + FME_PR_ERR);
> +
> +       return pr_error;
> +}
> +
> +static int fme_mgr_write_init(struct fpga_manager *mgr,
> +                             struct fpga_image_info *info,
> +                             const char *buf, size_t count)
> +{
> +       struct device *dev = &mgr->dev;
> +       struct fme_mgr_priv *priv = mgr->priv;
> +       void __iomem *fme_pr = priv->ioaddr;
> +       u64 pr_ctrl, pr_status;
> +
> +       if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> +               dev_err(dev, "only supports partial reconfiguration.\n");
> +               return -EINVAL;
> +       }
> +
> +       dev_dbg(dev, "resetting PR before initiated PR\n");
> +
> +       pr_ctrl = readq(fme_pr + FME_PR_CTRL);
> +       pr_ctrl |= FME_PR_CTRL_PR_RST;
> +       writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
> +
> +       if (readq_poll_timeout(fme_pr + FME_PR_CTRL, pr_ctrl,
> +                              pr_ctrl & FME_PR_CTRL_PR_RSTACK, 1,
> +                              PR_WAIT_TIMEOUT)) {
> +               dev_err(dev, "PR Reset ACK timeout\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       pr_ctrl = readq(fme_pr + FME_PR_CTRL);
> +       pr_ctrl &= ~FME_PR_CTRL_PR_RST;
> +       writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
> +
> +       dev_dbg(dev,
> +               "waiting for PR resource in HW to be initialized and ready\n");
> +
> +       if (readq_poll_timeout(fme_pr + FME_PR_STS, pr_status,
> +                              (pr_status & FME_PR_STS_PR_STS) ==
> +                              FME_PR_STS_PR_STS_IDLE, 1, PR_WAIT_TIMEOUT)) {
> +               dev_err(dev, "PR Status timeout\n");
> +               priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
> +               return -ETIMEDOUT;
> +       }
> +
> +       dev_dbg(dev, "check and clear previous PR error\n");
> +       priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
> +       if (priv->pr_error)
> +               dev_dbg(dev, "previous PR error detected %llx\n",
> +                       (unsigned long long)priv->pr_error);
> +
> +       dev_dbg(dev, "set PR port ID\n");
> +
> +       pr_ctrl = readq(fme_pr + FME_PR_CTRL);
> +       pr_ctrl &= ~FME_PR_CTRL_PR_RGN_ID;
> +       pr_ctrl |= FIELD_PREP(FME_PR_CTRL_PR_RGN_ID, info->region_id);
> +       writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
> +
> +       return 0;
> +}
> +
> +static int fme_mgr_write(struct fpga_manager *mgr,
> +                        const char *buf, size_t count)
> +{
> +       struct device *dev = &mgr->dev;
> +       struct fme_mgr_priv *priv = mgr->priv;
> +       void __iomem *fme_pr = priv->ioaddr;
> +       u64 pr_ctrl, pr_status, pr_data;
> +       int delay = 0, pr_credit, i = 0;
> +
> +       dev_dbg(dev, "start request\n");
> +
> +       pr_ctrl = readq(fme_pr + FME_PR_CTRL);
> +       pr_ctrl |= FME_PR_CTRL_PR_START;
> +       writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
> +
> +       dev_dbg(dev, "pushing data from bitstream to HW\n");
> +
> +       /*
> +        * driver can push data to PR hardware using PR_DATA register once HW
> +        * has enough pr_credit (> 1), pr_credit reduces one for every 32bit
> +        * pr data write to PR_DATA register. If pr_credit <= 1, driver needs
> +        * to wait for enough pr_credit from hardware by polling.
> +        */
> +       pr_status = readq(fme_pr + FME_PR_STS);
> +       pr_credit = FIELD_GET(FME_PR_STS_PR_CREDIT, pr_status);
> +
> +       while (count > 0) {
> +               while (pr_credit <= 1) {
> +                       if (delay++ > PR_WAIT_TIMEOUT) {
> +                               dev_err(dev, "PR_CREDIT timeout\n");
> +                               return -ETIMEDOUT;
> +                       }
> +                       udelay(1);
> +
> +                       pr_status = readq(fme_pr + FME_PR_STS);
> +                       pr_credit = FIELD_GET(FME_PR_STS_PR_CREDIT, pr_status);
> +               }
> +
> +               if (count >= 4) {
> +                       pr_data = 0;
> +                       pr_data |= FIELD_PREP(FME_PR_DATA_PR_DATA_RAW,
> +                                             *(((u32 *)buf) + i));
> +                       writeq(pr_data, fme_pr + FME_PR_DATA);
> +                       count -= 4;
> +                       pr_credit--;
> +                       i++;
> +               } else {
> +                       WARN_ON(1);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int fme_mgr_write_complete(struct fpga_manager *mgr,
> +                                 struct fpga_image_info *info)
> +{
> +       struct device *dev = &mgr->dev;
> +       struct fme_mgr_priv *priv = mgr->priv;
> +       void __iomem *fme_pr = priv->ioaddr;
> +       u64 pr_ctrl;
> +
> +       pr_ctrl = readq(fme_pr + FME_PR_CTRL);
> +       pr_ctrl |= FME_PR_CTRL_PR_COMPLETE;
> +       writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
> +
> +       dev_dbg(dev, "green bitstream push complete\n");
> +       dev_dbg(dev, "waiting for HW to release PR resource\n");
> +
> +       if (readq_poll_timeout(fme_pr + FME_PR_CTRL, pr_ctrl,
> +                              !(pr_ctrl & FME_PR_CTRL_PR_START), 1,
> +                              PR_WAIT_TIMEOUT)) {
> +               dev_err(dev, "PR Completion ACK timeout.\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       dev_dbg(dev, "PR operation complete, checking status\n");
> +       priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
> +       if (priv->pr_error) {
> +               dev_dbg(dev, "PR error detected %llx\n",
> +                       (unsigned long long)priv->pr_error);
> +               return -EIO;
> +       }
> +
> +       dev_dbg(dev, "PR done successfully\n");
> +
> +       return 0;
> +}
> +
> +static enum fpga_mgr_states fme_mgr_state(struct fpga_manager *mgr)
> +{
> +       return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static u64 fme_mgr_status(struct fpga_manager *mgr)
> +{
> +       struct fme_mgr_priv *priv = mgr->priv;
> +
> +       return pr_error_to_mgr_status(priv->pr_error);
> +}
> +
> +static const struct fpga_manager_ops fme_mgr_ops = {
> +       .write_init = fme_mgr_write_init,
> +       .write = fme_mgr_write,
> +       .write_complete = fme_mgr_write_complete,
> +       .state = fme_mgr_state,
> +       .status = fme_mgr_status,
> +};
> +
> +static int fme_mgr_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct fme_mgr_priv *priv;
> +       struct fpga_manager *mgr;
> +       struct resource *res;
> +       int ret;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv->ioaddr = devm_ioremap(dev, res->start, resource_size(res));

How about using devm_ioremap_resourc(dev, res) here instead?

> +       if (IS_ERR(priv->ioaddr))
> +               return PTR_ERR(priv->ioaddr);
> +
> +       mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
> +
> +       mgr->name = "DFL FPGA Manager";
> +       mgr->mops = &fme_mgr_ops;
> +       mgr->priv = priv;
> +       mgr->parent = dev;
> +       platform_set_drvdata(pdev, mgr);
> +
> +       ret = fpga_mgr_register(mgr);
> +       if (ret)
> +               dev_err(dev, "unable to register FPGA manager\n");
> +
> +       return ret;

You can probably just do "return fpga_mgr_register(mgr);" here.

Thanks,
Alan

> +}
> +
> +static int fme_mgr_remove(struct platform_device *pdev)
> +{
> +       struct fpga_manager *mgr = platform_get_drvdata(pdev);
> +
> +       fpga_mgr_unregister(mgr);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver fme_mgr_driver = {
> +       .driver = {
> +               .name    = FPGA_DFL_FME_MGR,
> +       },
> +       .probe   = fme_mgr_probe,
> +       .remove  = fme_mgr_remove,
> +};
> +
> +module_platform_driver(fme_mgr_driver);
> +
> +MODULE_DESCRIPTION("FPGA Manager for DFL FPGA Management Engine");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:dfl-fme-mgr");
> --
> 2.7.4
>
