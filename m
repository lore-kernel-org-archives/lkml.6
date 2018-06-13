Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F5DFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02E4208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02E4208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935728AbeFMONK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:13:10 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41723 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935656AbeFMONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:13:07 -0400
Received: by mail-ot0-f194.google.com with SMTP id d19-v6so3109466oti.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 07:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uw5vDOV7Qvf6+RFsBwK1nwVInUnkHLHN9J5YiP1AX38=;
        b=T+K56oJbywjFy6FNke8P8k5HOKTsoc8h6rkSGtuwiNCvbcqjOHWGVI9oTBzm9qvC/K
         qLBF0p+ki3KGcr3kqD6rA+EAAPL/YsYdvOpSgPSmNy3aJfxWDpYrBPk1JEJUcvs8bJtQ
         bOW9VUZeRvog3BrduXNhSogJ2Qmo+EdB4dreYuDmco1bAkRA+1ldurTQtFUqDefxQyCM
         L7hUCsbuPLpkb0ZiKpfGk1dIyQgDIfpgbhV9cNUdvnrbJpaSEybucDXwhAuYM+xHShjw
         BIajSj+vKPQMBbg9fGZe1SbU/D+f5oj6pH+cL24ajDXcQEKFNLoABjED6+iBG2fY8Xnu
         J28w==
X-Gm-Message-State: APt69E07MPWuiYc+IdvmhNOeMyDibgvKf1v7ggQtPI06mq4tG4iR8vLR
        ub1Jwb9AO+22/IzBoxud+58BPQ==
X-Google-Smtp-Source: ADUXVKKHUJtFAVPb9N30vHckWsh1JNK5AZTmsZJ/phD9uj3z9tXH7woD/tu0CXBsnWbmuGR3QFvUyw==
X-Received: by 2002:a9d:3df6:: with SMTP id l109-v6mr3392536otc.78.1528899186905;
        Wed, 13 Jun 2018 07:13:06 -0700 (PDT)
Received: from localhost ([130.164.62.61])
        by smtp.gmail.com with ESMTPSA id q10-v6sm1254392oth.70.2018.06.13.07.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 07:13:05 -0700 (PDT)
Date:   Wed, 13 Jun 2018 07:13:04 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v6 14/29] fpga: dfl: add FPGA Management Engine driver
 basic framework
Message-ID: <20180613141304.GC3866@archbook>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-15-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528798243-2029-15-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:10:28PM +0800, Wu Hao wrote:
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
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v3: rename driver from intel-fpga-fme to dfl-fme
>     rename Kconfig from INTEL_FPGA_FME to FPGA_DFL_FME
> v4: fix SPDX license issue, use dfl-fme as module name
> v5: rebase, due to DFL framework naming changes on functions and data structures.
>     fix uinit order in remove function.
>     remove else block in fme_ioctl function per suggestion from Alan.
> v6: fix copyright time, rebase and add Acked-by from Alan.
> ---
>  drivers/fpga/Kconfig        |  10 +++
>  drivers/fpga/Makefile       |   3 +
>  drivers/fpga/dfl-fme-main.c | 158 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+)
>  create mode 100644 drivers/fpga/dfl-fme-main.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5faab48..45e9220 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -146,6 +146,16 @@ config FPGA_DFL
>  	  Gate Array (FPGA) solutions which implement Device Feature List.
>  	  It provides enumeration APIs, and feature device infrastructure.
>  
> +config FPGA_DFL_FME
> +	tristate "FPGA DFL FME Driver"
> +	depends on FPGA_DFL
> +	help
> +	  The FPGA Management Engine (FME) is a feature device implemented
> +	  under Device Feature List (DFL) framework. Select this option to
> +	  enable the platform device driver for FME which implements all
> +	  FPGA platform level management features. There shall be 1 FME
> +	  per DFL based FPGA device.
> +
>  config FPGA_DFL_PCI
>  	tristate "FPGA DFL PCIe Device Driver"
>  	depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 02e0253..db11f34 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -31,6 +31,9 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
>  
>  # FPGA Device Feature List Support
>  obj-$(CONFIG_FPGA_DFL)			+= dfl.o
> +obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
> +
> +dfl-fme-objs := dfl-fme-main.o
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> new file mode 100644
> index 0000000..a2ae9b3
> --- /dev/null
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA Management Engine (FME)
> + *
> + * Copyright (C) 2017-2018 Intel Corporation, Inc.
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
> +static int fme_hdr_init(struct platform_device *pdev,
> +			struct dfl_feature *feature)
> +{
> +	dev_dbg(&pdev->dev, "FME HDR Init.\n");
> +
> +	return 0;
> +}
> +
> +static void fme_hdr_uinit(struct platform_device *pdev,
> +			  struct dfl_feature *feature)
> +{
> +	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
> +}
> +
> +static const struct dfl_feature_ops fme_hdr_ops = {
> +	.init = fme_hdr_init,
> +	.uinit = fme_hdr_uinit,
> +};
> +
> +static struct dfl_feature_driver fme_feature_drvs[] = {
> +	{
> +		.id = FME_FEATURE_ID_HEADER,
> +		.ops = &fme_hdr_ops,
> +	},
> +	{
> +		.ops = NULL,
> +	},
> +};
> +
> +static int fme_open(struct inode *inode, struct file *filp)
> +{
> +	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&fdev->dev);
> +	int ret;
> +
> +	if (WARN_ON(!pdata))
> +		return -ENODEV;
> +
> +	ret = dfl_feature_dev_use_begin(pdata);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(&fdev->dev, "Device File Open\n");
> +	filp->private_data = pdata;
> +
> +	return 0;
> +}
> +
> +static int fme_release(struct inode *inode, struct file *filp)
> +{
> +	struct dfl_feature_platform_data *pdata = filp->private_data;
> +	struct platform_device *pdev = pdata->dev;
> +
> +	dev_dbg(&pdev->dev, "Device File Release\n");
> +	dfl_feature_dev_use_end(pdata);
> +
> +	return 0;
> +}
> +
> +static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	struct dfl_feature_platform_data *pdata = filp->private_data;
> +	struct platform_device *pdev = pdata->dev;
> +	struct dfl_feature *f;
> +	long ret;
> +
> +	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
> +
> +	switch (cmd) {
> +	default:
> +		/*
> +		 * Let sub-feature's ioctl function to handle the cmd
> +		 * Sub-feature's ioctl returns -ENODEV when cmd is not
> +		 * handled in this sub feature, and returns 0 and other
> +		 * error code if cmd is handled.
> +		 */
> +		dfl_fpga_dev_for_each_feature(pdata, f) {
> +			if (f->ops && f->ops->ioctl) {
> +				ret = f->ops->ioctl(pdev, f, cmd, arg);
> +				if (ret != -ENODEV)
> +					return ret;
> +			}
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct file_operations fme_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= fme_open,
> +	.release	= fme_release,
> +	.unlocked_ioctl = fme_ioctl,
> +};
> +
> +static int fme_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = dfl_fpga_dev_feature_init(pdev, fme_feature_drvs);
> +	if (ret)
> +		goto exit;
> +
> +	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
> +	if (ret)
> +		goto feature_uinit;
> +
> +	return 0;
> +
> +feature_uinit:
> +	dfl_fpga_dev_feature_uinit(pdev);
> +exit:
> +	return ret;
> +}
> +
> +static int fme_remove(struct platform_device *pdev)
> +{
> +	dfl_fpga_dev_ops_unregister(pdev);
> +	dfl_fpga_dev_feature_uinit(pdev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver fme_driver = {
> +	.driver	= {
> +		.name    = DFL_FPGA_FEATURE_DEV_FME,
> +	},
> +	.probe   = fme_probe,
> +	.remove  = fme_remove,
> +};
> +
> +module_platform_driver(fme_driver);
> +
> +MODULE_DESCRIPTION("FPGA Management Engine driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:dfl-fme");
> -- 
> 1.8.3.1
> 
Thanks,
Moritz
