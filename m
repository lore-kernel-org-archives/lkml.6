Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D273FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0E620870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA3SRLIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0E620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbeGaQoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbeGaQoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:44:37 -0400
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16977208A4;
        Tue, 31 Jul 2018 15:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533049432;
        bh=C2G/VTpargnf6tdL8iWB6aoQlTL9D49ybkLFPoH6pSE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=FA3SRLIb6Xqsu3thAxGG99YOqJN59vOgOefi9l1ysqk76t1KmuSdZJvVBj6dX3Q8N
         r9aveig65vde0IZ0Oy0u5wrNHKvVjkfjE6lWunB+FlaLl4eXsz2bwHhCfkHzzSCwWZ
         8dLn9DeNA7qzbRqdwSSu2+KTWiMoPsVGXAmT2XN4=
Received: by mail-yw0-f169.google.com with SMTP id t18-v6so5888600ywg.2;
        Tue, 31 Jul 2018 08:03:52 -0700 (PDT)
X-Gm-Message-State: AOUpUlFh9lEWgNq5XQJGF02VtDvGaCWRbz7hIUyrZf5naajD9GlSa/El
        wqvaIaDsMNVKyANRGmVK69VTCNfMAmhMQs6Np4Q=
X-Google-Smtp-Source: AAOMgpejVyRym0Vr3othd98ijvWET8q50NOnT6j7ahEHjL/lovO6tPBf0bPKr3A1MeqyDjrm9i1b/Zy/5aDC9obAYpo=
X-Received: by 2002:a81:a348:: with SMTP id a69-v6mr11028926ywh.142.1533049431228;
 Tue, 31 Jul 2018 08:03:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 08:03:10
 -0700 (PDT)
In-Reply-To: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 31 Jul 2018 10:03:10 -0500
X-Gmail-Original-Message-ID: <CANk1AXSEWcZ7Oqv5pgpwvJRyyFWk5gPtniXa7T+oe6-uywqEqA@mail.gmail.com>
Message-ID: <CANk1AXSEWcZ7Oqv5pgpwvJRyyFWk5gPtniXa7T+oe6-uywqEqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fpga: fpga-mgr: Add readback support
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, kedare06@gmail.com,
        linux-fpga@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nava kishore Manne <navam@xilinx.com>, apandey@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 1:22 AM, Appana Durga Kedareswara rao
<appana.durga.rao@xilinx.com> wrote:

Hi Appana,

There should be some documentation for the debugfs added under
Documentation/driver-api/fpga/

Also there are a lot of #ifdefs that were added due to the
CONFIG_FPGA_MGR_DEBUG_FS.  This has caused a kernel robot complaint.
The way to fix that is to have a separate c file for the debugfs
implementation.  I see a lot of other kernel drivers have done it this
way.  I have an implementation that I haven't submitted yet, it
exposes different functionality (exposing the image firmware file name
and writing to the image file).  It's on the downstream
github.com/altera-opensource repo [1].  I'll clean this up and submit
it to the mailing list, it may take a minute for me to get to that.
Once that's done, your added functionality can be a patch on top of
that.

Alan

[1] https://github.com/altera-opensource/linux-socfpga/blob/socfpga-4.17/drivers/fpga/fpga-mgr-debugfs.c
https://github.com/altera-opensource/linux-socfpga/blob/socfpga-4.17/drivers/fpga/fpga-mgr-debugfs.h


> Inorder to debug issues with fpga's users would
> like to read the fpga configuration information.
> This patch adds readback support for fpga configuration data
> in the framework through debugfs interface.
>
> Usage:
>         cat /sys/kernel/debug/fpga/fpga0/image
>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
> Changes for v4:
> --> None.
> Changes for v3:
> --> None.
> Changes for v2:
> --> Fixed debug attribute path and name as suggested by Alan
> --> Add config entry for DEBUG as suggested by Alan
> --> Fixed trival coding style issues.
>
>  drivers/fpga/Kconfig          |  7 +++++
>  drivers/fpga/fpga-mgr.c       | 68 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h |  5 ++++
>  3 files changed, 80 insertions(+)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 53d3f55..838ad4e 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -11,6 +11,13 @@ menuconfig FPGA
>
>  if FPGA
>
> +config FPGA_MGR_DEBUG_FS
> +       tristate "FPGA Debug fs"
> +       select DEBUG_FS
> +       help
> +         FPGA manager debug provides support for reading fpga configuration
> +         information.
> +
>  config FPGA_MGR_SOCFPGA
>         tristate "Altera SOCFPGA FPGA Manager"
>         depends on ARCH_SOCFPGA || COMPILE_TEST
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 9939d2c..4bea860 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -484,6 +484,48 @@ void fpga_mgr_put(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
>
> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
> +#include <linux/debugfs.h>
> +
> +static int fpga_mgr_read(struct seq_file *s, void *data)
> +{
> +       struct fpga_manager *mgr = (struct fpga_manager *)s->private;
> +       int ret = 0;
> +
> +       if (!mgr->mops->read)
> +               return -ENOENT;
> +
> +       if (!mutex_trylock(&mgr->ref_mutex))
> +               return -EBUSY;
> +
> +       if (mgr->state != FPGA_MGR_STATE_OPERATING) {
> +               ret = -EPERM;
> +               goto err_unlock;
> +       }
> +
> +       /* Read the FPGA configuration data from the fabric */
> +       ret = mgr->mops->read(mgr, s);
> +       if (ret)
> +               dev_err(&mgr->dev, "Error while reading configuration data from FPGA\n");
> +
> +err_unlock:
> +       mutex_unlock(&mgr->ref_mutex);
> +
> +       return ret;
> +}
> +
> +static int fpga_mgr_read_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, fpga_mgr_read, inode->i_private);
> +}
> +
> +static const struct file_operations fpga_mgr_ops_image = {
> +       .owner = THIS_MODULE,
> +       .open = fpga_mgr_read_open,
> +       .read = seq_read,
> +};
> +#endif
> +
>  /**
>   * fpga_mgr_lock - Lock FPGA manager for exclusive use
>   * @mgr:       fpga manager
> @@ -581,6 +623,29 @@ int fpga_mgr_register(struct device *dev, const char *name,
>         if (ret)
>                 goto error_device;
>
> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
> +       struct dentry *d, *parent;
> +
> +       mgr->dir = debugfs_create_dir("fpga", NULL);
> +       if (!mgr->dir)
> +               goto error_device;
> +
> +       parent = mgr->dir;
> +       d = debugfs_create_dir(mgr->dev.kobj.name, parent);
> +       if (!d) {
> +               debugfs_remove_recursive(parent);
> +               goto error_device;
> +       }
> +
> +       parent = d;
> +       d = debugfs_create_file("image", 0644, parent, mgr,
> +                               &fpga_mgr_ops_image);
> +       if (!d) {
> +               debugfs_remove_recursive(mgr->dir);
> +               goto error_device;
> +       }
> +#endif
> +
>         dev_info(&mgr->dev, "%s registered\n", mgr->name);
>
>         return 0;
> @@ -604,6 +669,9 @@ void fpga_mgr_unregister(struct device *dev)
>
>         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>
> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
> +       debugfs_remove_recursive(mgr->dir);
> +#endif
>         /*
>          * If the low level driver provides a method for putting fpga into
>          * a desired state upon unregister, do it.
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 3c6de23..e9e17a9 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -114,6 +114,7 @@ struct fpga_image_info {
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
>   * @write_complete: set FPGA to operating state after writing is done
> + * @read: optional: read FPGA configuration information
>   * @fpga_remove: optional: Set FPGA into a specific state during driver remove
>   * @groups: optional attribute groups.
>   *
> @@ -131,6 +132,7 @@ struct fpga_manager_ops {
>         int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
>         int (*write_complete)(struct fpga_manager *mgr,
>                               struct fpga_image_info *info);
> +       int (*read)(struct fpga_manager *mgr, struct seq_file *s);
>         void (*fpga_remove)(struct fpga_manager *mgr);
>         const struct attribute_group **groups;
>  };
> @@ -151,6 +153,9 @@ struct fpga_manager {
>         enum fpga_mgr_states state;
>         const struct fpga_manager_ops *mops;
>         void *priv;
> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
> +       struct dentry *dir;
> +#endif
>  };
>
>  #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
