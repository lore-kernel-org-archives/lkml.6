Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C8FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5306920A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5306920A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeHPWAH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:00:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37148 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeHPWAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:00:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so2475662pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 11:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a6ij+bf7DST9/Xq6u9FGxT57TJzPh/2P04GETxyy5hA=;
        b=sw8gEe9EvckelvEdRI+zDQrq3TepUKX3xiqwj0O0AIyBKx1vTS10jrWX5XnnTO92j+
         3TWdRvwJIEWa/Lb8GCy/YkJI7b1JlWwfJomuBWcdTTMCWpPZow/MNesQxlMMxPUSkeH7
         hYLbNiT+mK5n/1ebnqp/PwEX94uVtcmeXsvbv7R02MjCtZMGB5uXpx8JhvMIYMqlkzOg
         7o2/11FfoEkoXXjk30ez2zyGljW+pMHpEEw1GedSGmCBCeBInUxftq643Pjv9KPmAp20
         K3psIjcexZhLokfvR9gFy15jNY3vvV8fWZy/x/iLZl9DhbE/VDvPyh+vTEHdqjv4Ft0Z
         +lbQ==
X-Gm-Message-State: AOUpUlFV+xedyPmGoRf/Finzu+cWVnzZAq8IFyaDRFDV1acvgYzRkmwu
        biAHrWbDHVYzvFHnYgtuPLiOSQ==
X-Google-Smtp-Source: AA+uWPziBlVFkGYGb8UuD5BPvr3IkOQhI463rqknOOWrUOerFUcr0xvugbb2yGisBd25DCkMMA+1Ew==
X-Received: by 2002:a63:cf10:: with SMTP id j16-v6mr30069722pgg.238.1534445994338;
        Thu, 16 Aug 2018 11:59:54 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id x1-v6sm37965pgr.59.2018.08.16.11.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 11:59:53 -0700 (PDT)
Date:   Thu, 16 Aug 2018 11:59:52 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Message-ID: <20180816185952.GA3932@archbook>
References: <20180815220958.3606-1-atull@kernel.org>
 <20180815220958.3606-2-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180815220958.3606-2-atull@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

comments inline. While I see how this is useful, I have the
suspicion that from the moment this gets merged vendor kernels
will just default to use this ...

On Wed, Aug 15, 2018 at 05:09:58PM -0500, Alan Tull wrote:
> From: Alan Tull <atull@opensource.altera.com>
> 
> Implement DebugFS for the FPGA Manager Framework for
> debugging and developmental use.
> 
> Enabled by CONFIG_FPGA_MGR_DEBUG_FS
> 
> Each FPGA gets its own directory such as
>  <debugfs>/fpga_manager/fpga0 and three files:
> 
>  * [RW] flags          = flags as defined in fpga-mgr.h
>  * [RW] firmware_name  = write/read back name of FPGA image
>                          firmware file to program
>  * [WO] image          = write-only file for directly writing
>                          fpga image w/o firmware layer
>  * [RW] config_complete_timeout_us = maximum for the FPGA to
>                          go to the operating state after
> 			 programming
> 
> The debugfs is implemented in a separate fpga_mgr_debugfs.c
> file, but the FPGA manager core is still built as one
> module.  Note the name change from fpga-mgr.ko to fpga_mgr.ko.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/Kconfig            |   7 ++
>  drivers/fpga/Makefile           |   4 +-
>  drivers/fpga/fpga-mgr-debugfs.c | 221 ++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/fpga-mgr-debugfs.h |  22 ++++
>  drivers/fpga/fpga-mgr.c         |   8 ++
>  include/linux/fpga/fpga-mgr.h   |   3 +
>  6 files changed, 264 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.c
>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.h
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 1ebcef4..600924d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -9,6 +9,13 @@ menuconfig FPGA
>  	  kernel.  The FPGA framework adds a FPGA manager class and FPGA
>  	  manager drivers.
>  
> +config FPGA_MGR_DEBUG_FS
> +       bool "FPGA Manager DebugFS"
> +       depends on FPGA && DEBUG_FS
> +       help
> +         Say Y here if you want to expose a DebugFS interface for the
> +	 FPGA Manager Framework.
> +
>  if FPGA
>  
>  config FPGA_MGR_SOCFPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 7a2d73b..62910cc 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -4,7 +4,9 @@
>  #
>  
>  # Core FPGA Manager Framework
> -obj-$(CONFIG_FPGA)			+= fpga-mgr.o
> +obj-$(CONFIG_FPGA)			+= fpga_mgr.o
> +fpga_mgr-y				:= fpga-mgr.o
> +fpga_mgr-$(CONFIG_FPGA_MGR_DEBUG_FS)	+= fpga-mgr-debugfs.o
>  
>  # FPGA Manager Drivers
>  obj-$(CONFIG_FPGA_MGR_ALTERA_CVP)	+= altera-cvp.o
> diff --git a/drivers/fpga/fpga-mgr-debugfs.c b/drivers/fpga/fpga-mgr-debugfs.c
> new file mode 100644
> index 0000000..f2fdf58
> --- /dev/null
> +++ b/drivers/fpga/fpga-mgr-debugfs.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FPGA Manager DebugFS
> + *
> + *  Copyright (C) 2016-2018 Intel Corporation.  All rights reserved.
> + */
> +#include <linux/debugfs.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +static struct dentry *fpga_mgr_debugfs_root;
> +
> +struct fpga_mgr_debugfs {
> +	struct dentry *debugfs_dir;
> +	struct fpga_image_info *info;
> +};
> +
> +static ssize_t fpga_mgr_firmware_write_file(struct file *file,
> +					    const char __user *user_buf,
> +					    size_t count, loff_t *ppos)
> +{
> +	struct fpga_manager *mgr = file->private_data;
> +	struct fpga_mgr_debugfs *debugfs = mgr->debugfs;
> +	struct device *dev = &mgr->dev;
> +	char *buf;
> +	int ret;
> +
> +	ret = fpga_mgr_lock(mgr);
> +	if (ret) {
> +		dev_err(dev, "FPGA manager is busy\n");
> +		return -EBUSY;
> +	}
> +
> +	buf = devm_kzalloc(dev, count, GFP_KERNEL);
> +	if (!buf) {
> +		fpga_mgr_unlock(mgr);
> +		return -ENOMEM;
> +	}
> +
> +	if (copy_from_user(buf, user_buf, count)) {
> +		fpga_mgr_unlock(mgr);
> +		devm_kfree(dev, buf);
> +		return -EFAULT;
> +	}
> +
> +	buf[count] = 0;
> +	if (buf[count - 1] == '\n')
> +		buf[count - 1] = 0;
> +
> +	/* Release previous firmware name (if any). Save current one. */
> +	if (debugfs->info->firmware_name)
> +		devm_kfree(dev, debugfs->info->firmware_name);
> +	debugfs->info->firmware_name = buf;
> +
> +	ret = fpga_mgr_load(mgr, debugfs->info);
> +	if (ret)
> +		dev_err(dev, "fpga_mgr_load returned with value %d\n", ret);
> +
> +	fpga_mgr_unlock(mgr);
> +
> +	return count;
> +}
> +
> +static ssize_t fpga_mgr_firmware_read_file(struct file *file,
> +					   char __user *user_buf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct fpga_manager *mgr = file->private_data;
> +	struct fpga_mgr_debugfs *debugfs = mgr->debugfs;
> +	char *buf;
> +	int ret;
> +
> +	if (!debugfs->info->firmware_name)
> +		return 0;
> +
> +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = snprintf(buf, PAGE_SIZE, "%s\n", debugfs->info->firmware_name);
snip:
---->8->8->8-----
> +	if (ret < 0) {
> +		kfree(buf);
> +		return ret;
> +	}
---->8->8->8-----
just replace with:
	if (ret < 0)
		goto out;
> +
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);

out:
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static const struct file_operations fpga_mgr_firmware_fops = {
> +	.open = simple_open,
> +	.read = fpga_mgr_firmware_read_file,
> +	.write = fpga_mgr_firmware_write_file,
> +	.llseek = default_llseek,
> +};
> +
> +static ssize_t fpga_mgr_image_write_file(struct file *file,
> +					 const char __user *user_buf,
> +					 size_t count, loff_t *ppos)
> +{
> +	struct fpga_manager *mgr = file->private_data;
> +	struct fpga_mgr_debugfs *debugfs = mgr->debugfs;
> +	struct device *dev = &mgr->dev;
> +	char *buf;
> +	int ret;
> +
> +	dev_info(dev, "writing %zu bytes to %s\n", count, mgr->name);
> +
> +	ret = fpga_mgr_lock(mgr);
> +	if (ret) {
> +		dev_err(dev, "FPGA manager is busy\n");
> +		return -EBUSY;
> +	}
> +
> +	buf = kzalloc(count, GFP_KERNEL);
> +	if (!buf) {
> +		fpga_mgr_unlock(mgr);
> +		return -ENOMEM;
> +	}
> +
> +	if (copy_from_user(buf, user_buf, count)) {
> +		fpga_mgr_unlock(mgr);
> +		kfree(buf);
> +		return -EFAULT;
> +	}
> +
> +	/* If firmware interface was previously used, forget it. */
> +	if (debugfs->info->firmware_name)
> +		devm_kfree(dev, debugfs->info->firmware_name);
> +	debugfs->info->firmware_name = NULL;
> +
> +	debugfs->info->buf = buf;
> +	debugfs->info->count = count;
> +
> +	ret = fpga_mgr_load(mgr, debugfs->info);
> +	if (ret)
> +		dev_err(dev, "fpga_mgr_load returned with value %d\n", ret);
> +
> +	fpga_mgr_unlock(mgr);
> +
> +	debugfs->info->buf = NULL;
> +	debugfs->info->count = 0;

Is that ordering between unlock() and setting those correct?
> +
> +	kfree(buf);
> +
> +	return count;
> +}
> +
> +static const struct file_operations fpga_mgr_image_fops = {
> +	.open = simple_open,
> +	.write = fpga_mgr_image_write_file,
> +	.llseek = default_llseek,
> +};
> +
> +void fpga_mgr_debugfs_add(struct fpga_manager *mgr)
> +{
> +	struct device *dev = &mgr->dev;
> +	struct fpga_mgr_debugfs *debugfs;
> +	struct fpga_image_info *info;
> +
> +	if (!fpga_mgr_debugfs_root)
> +		return;
> +
> +	debugfs = kzalloc(sizeof(*debugfs), GFP_KERNEL);
> +	if (!debugfs)
> +		return;
> +
> +	info = fpga_image_info_alloc(dev);
> +	if (!info) {
> +		kfree(debugfs);
> +		return;
> +	}
> +	debugfs->info = info;
> +
> +	debugfs->debugfs_dir = debugfs_create_dir(dev_name(dev),
> +						  fpga_mgr_debugfs_root);
> +
> +	debugfs_create_file("firmware_name", 0600, debugfs->debugfs_dir, mgr,
> +			    &fpga_mgr_firmware_fops);
> +
> +	debugfs_create_file("image", 0200, debugfs->debugfs_dir, mgr,
> +			    &fpga_mgr_image_fops);
> +
> +	debugfs_create_u32("flags", 0600, debugfs->debugfs_dir, &info->flags);
> +
> +	debugfs_create_u32("config_complete_timeout_us", 0600,
> +			   debugfs->debugfs_dir,
> +			   &info->config_complete_timeout_us);
> +
> +	mgr->debugfs = debugfs;
> +}
> +
> +void fpga_mgr_debugfs_remove(struct fpga_manager *mgr)
> +{
> +	struct fpga_mgr_debugfs *debugfs = mgr->debugfs;
> +
> +	if (!fpga_mgr_debugfs_root)
> +		return;
> +
> +	debugfs_remove_recursive(debugfs->debugfs_dir);
> +
> +	/* this function also frees debugfs->info->firmware_name */
> +	fpga_image_info_free(debugfs->info);
> +
> +	kfree(debugfs);
> +}
> +
> +void fpga_mgr_debugfs_init(void)
> +{
> +	fpga_mgr_debugfs_root = debugfs_create_dir("fpga_manager", NULL);
> +	if (!fpga_mgr_debugfs_root)
> +		pr_warn("fpga_mgr: Failed to create debugfs root\n");
> +}
> +
> +void fpga_mgr_debugfs_uninit(void)
> +{
> +	debugfs_remove_recursive(fpga_mgr_debugfs_root);
> +}
> diff --git a/drivers/fpga/fpga-mgr-debugfs.h b/drivers/fpga/fpga-mgr-debugfs.h
> new file mode 100644
> index 0000000..17cd3eb
> --- /dev/null
> +++ b/drivers/fpga/fpga-mgr-debugfs.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef _LINUX_FPGA_MGR_DEBUGFS_H
> +#define _LINUX_FPGA_MGR_DEBUGFS_H
> +
> +#if IS_ENABLED(CONFIG_FPGA_MGR_DEBUG_FS)
> +
> +void fpga_mgr_debugfs_add(struct fpga_manager *mgr);
> +void fpga_mgr_debugfs_remove(struct fpga_manager *mgr);
> +void fpga_mgr_debugfs_init(void);
> +void fpga_mgr_debugfs_uninit(void);
> +
> +#else
> +
> +void fpga_mgr_debugfs_add(struct fpga_manager *mgr) {}
> +void fpga_mgr_debugfs_remove(struct fpga_manager *mgr) {}
> +void fpga_mgr_debugfs_init(void) {}
> +void fpga_mgr_debugfs_uninit(void) {}
> +
> +#endif /* CONFIG_FPGA_MGR_DEBUG_FS */
> +
> +#endif /*_LINUX_FPGA_MGR_DEBUGFS_H */
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index c8684bc..66eb6f6 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/scatterlist.h>
>  #include <linux/highmem.h>
> +#include "fpga-mgr-debugfs.h"
>  
>  static DEFINE_IDA(fpga_mgr_ida);
>  static struct class *fpga_mgr_class;
> @@ -698,6 +699,8 @@ int fpga_mgr_register(struct fpga_manager *mgr)
>  	if (ret)
>  		goto error_device;
>  
> +	fpga_mgr_debugfs_add(mgr);
> +
>  	dev_info(&mgr->dev, "%s registered\n", mgr->name);
>  
>  	return 0;
> @@ -722,6 +725,8 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  {
>  	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>  
> +	fpga_mgr_debugfs_remove(mgr);
> +
>  	/*
>  	 * If the low level driver provides a method for putting fpga into
>  	 * a desired state upon unregister, do it.
> @@ -748,11 +753,14 @@ static int __init fpga_mgr_class_init(void)
>  	fpga_mgr_class->dev_groups = fpga_mgr_groups;
>  	fpga_mgr_class->dev_release = fpga_mgr_dev_release;
>  
> +	fpga_mgr_debugfs_init();
> +
>  	return 0;
>  }
>  
>  static void __exit fpga_mgr_class_exit(void)
>  {
> +	fpga_mgr_debugfs_uninit();
>  	class_destroy(fpga_mgr_class);
>  	ida_destroy(&fpga_mgr_ida);
>  }
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 777c502..e8f2159 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -170,6 +170,9 @@ struct fpga_manager {
>  	struct fpga_compat_id *compat_id;
>  	const struct fpga_manager_ops *mops;
>  	void *priv;
> +#if IS_ENABLED(CONFIG_FPGA_MGR_DEBUG_FS)
> +	void *debugfs;
> +#endif
>  };
>  
>  #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
> -- 
> 2.7.4
> 

Thanks,

Moritz
