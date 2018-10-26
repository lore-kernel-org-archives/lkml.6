Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E83C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 04:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FA020665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 04:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FA020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeJZNSS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:18:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51187 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeJZNSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:18:18 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gFtxO-00086J-FM
        for linux-kernel@vger.kernel.org; Fri, 26 Oct 2018 04:42:46 +0000
Received: by mail-pl1-f198.google.com with SMTP id a16-v6so2773827plm.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 21:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ukpQml7mKeDfATLRezKGv/y7n3uRnAUmB2ZNd9yNLlI=;
        b=tIUK5iMapWIyrhXCbDBNUUktDng0FmugKEmLsjo+TWmz2ZeTuVNOFmXr12+cn137jv
         SeGq6DHAu+6X8/tuSdlCtXan7XvN4hfSexWY4f3dN3Xe/zy8EaaBtAc8ZKL1uWhU+ozS
         YYBzt1Z4i28hDe7uAWWtmZZfV0deGtFLrh4nl96YnM54ehgHcD7NO+AAHcbAe5xaGZdk
         87kVLELp9NQJo4+RgiHrd5g6WAy8Zqk9funxYT522zGqcdzaIUugOXCHn8dqVu9CBl9i
         yZ0N63q85EUKNzWvBlz/1SCyh6ogbS3T3IQMjYQ0+l7kjNhV+tG4ypBK7q4bT67Lt3CA
         v3xQ==
X-Gm-Message-State: AGRZ1gIn5USGCZri2A6yUJbamaWZvrEZ8Oz0EXcT8RZ0nadyX4YKJu51
        5RgJtNBX4v6ExkX1nIkOp5NFE3scIL2qnpKcB2pBYXRoIAOoDpxBjOWrUjcjRg20Yxj3IZNkV9Q
        QyMZew17XybqXKgisOBCDNG6mlG1RMWxre3PBXvV47g==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr2028165pgj.410.1540528964728;
        Thu, 25 Oct 2018 21:42:44 -0700 (PDT)
X-Google-Smtp-Source: AJdET5dsjgItj8KnrhgiYUGpCgmvts/EuWD21g3xjYFZNkgJ/iSsSqDST697OdiAbUuFuC0iDly55Q==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr2028144pgj.410.1540528964156;
        Thu, 25 Oct 2018 21:42:44 -0700 (PDT)
Received: from [10.101.46.95] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id c124-v6sm16645974pfa.119.2018.10.25.21.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 21:42:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [v5] i2c: Add PCI and platform drivers for the AMD MP2 I2C
 controller
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20181024155926.GA15866@syn-yoga530>
Date:   Fri, 26 Oct 2018 12:42:38 +0800
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <031771E0-AF01-4923-B4A9-5A1228BEC032@canonical.com>
References: <20181024155926.GA15866@syn-yoga530>
To:     Elie Morisse <syniurge@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 24, 2018, at 11:59 PM, Elie Morisse <syniurge@gmail.com> wrote:
> 
> This contains two drivers:
> * i2c-amd-plat-mp2: platform driver managing an i2c adapter (one of
> the two busses of the MP2) and routing any i2c read/write command to
> the PCI driver.
> * i2c-amd-pci-mp2: PCI driver communicating through the C2P/P2C
> mailbox registers, or through DMA for more than 32 bytes transfers.
> 
> This is major rework of the patch submitted by Nehal-bakulchandra Shah
> from AMD (https://patchwork.kernel.org/patch/10597369/).
> 
> Most of the event handling of v2/v3 was rewritten since it couldn't work
> if more than one bus was enabled, and contains many more fixes listed
> in the patch changelog.
> 
> With those changes both the touchpad and the touchscreen of the
> Ryzen-based Lenovo Yoga 530 which lie in separate busses work beautifully.
> 
> Signed-off-by: Elie Morisse <syniurge@gmail.com>

Re-test v5 on Dell Latitude 5495, works good.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
> Changes since v1:(https://www.spinics.net/lists/linux-i2c/msg34650.html)
> -> Add fix for IOMMU
> -> Add depedency of ACPI
> -> Add locks to avoid the crash
> 
> Changes since v2:(https://patchwork.ozlabs.org/patch/961270/)
> 
> -> fix for review comments
> -> fix for more than 32 bytes write issue
> 
> Changes since v3 (https://patchwork.kernel.org/patch/10597369/) by Elie M.:
> 
> -> support more than one bus/adapter
> -> support more than one slave per bus
> -> use the bus speed specified by the slaves declared in the DSDT instead of
>   assuming speed == 400kbits/s
> -> instead of kzalloc'ing a buffer for every less than 32 bytes reads, simply
>   use i2c_msg.buf
> -> fix buffer overreads/overflows when (<=32 bytes) message lengths aren't a
>   multiple of 4 by using memcpy_fromio and memcpy_toio
> -> use streaming DMA mappings instead of allocating a coherent DMA buffer for
>   every >32 bytes read/write
> -> properly check for timeouts during i2c_amd_xfer and increase it from 50
>   jiffies to 250 msecs (which is more in line with other drivers)
> -> complete amd_i2c_dev.msg even if the device doesn't return a xxx_success
>   event, instead of stalling i2c_amd_xfer
> -> removed the spinlock and mdelay during i2c_amd_pci_configure, I didn't see
>   the point since it's already waiting for a i2c_busenable_complete event
> -> add an adapter-specific mutex lock for i2c_amd_xfer, since we don't want
>   parallel calls writing to AMD_C2P_MSG0 (or AMD_C2P_MSG1)
> -> add a global mutex lock for registers AMD_C2P_MSG2 to AMD_C2P_MSG9,  which
>   are shared across the two busses/adapters
> -> add MODULE_DEVICE_TABLE to automatically load i2c-amd-platdrv if the DSDT
>   enumerates devices with the "AMDI0011" HID
> -> set maximum length of reads/writes to 4095 (event's length field is 12 bits)
> -> basic PM support
> -> style corrections to match the kernel code style, and tried to reduce code
>   duplication whenever possible
> 
> Changes since v4 (https://marc.info/?l=linux-kernel&m=154031133019835) by Elie M.:
> 
> -> fix missing typecast warning
> -> removed the duplicated entry in Kconfig
> 
> MAINTAINERS                           |   6 +
> drivers/i2c/busses/Kconfig            |  15 +
> drivers/i2c/busses/Makefile           |   2 +
> drivers/i2c/busses/i2c-amd-pci-mp2.c  | 633 ++++++++++++++++++++++++++
> drivers/i2c/busses/i2c-amd-pci-mp2.h  | 219 +++++++++
> drivers/i2c/busses/i2c-amd-plat-mp2.c | 362 +++++++++++++++
> 6 files changed, 1237 insertions(+)
> create mode 100644 drivers/i2c/busses/i2c-amd-pci-mp2.c
> create mode 100644 drivers/i2c/busses/i2c-amd-pci-mp2.h
> create mode 100644 drivers/i2c/busses/i2c-amd-plat-mp2.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ac000cc006d..8ff2bddc1ac2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -791,6 +791,12 @@ F:	drivers/gpu/drm/amd/include/vi_structs.h
> F:	drivers/gpu/drm/amd/include/v9_structs.h
> F:	include/uapi/linux/kfd_ioctl.h
> 
> +AMD MP2 I2C DRIVER
> +M:	Elie Morisse <syniurge@gmail.com>
> +L:	linux-i2c@vger.kernel.org
> +S:	Maintained
> +F:	drivers/i2c/busses/i2c-amd-*-mp2*
> +
> AMD POWERPLAY
> M:	Rex Zhu <rex.zhu@amd.com>
> M:	Evan Quan <evan.quan@amd.com>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 451d4ae50e66..e20f2d1ce381 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -77,6 +77,21 @@ config I2C_AMD8111
> 	  This driver can also be built as a module.  If so, the module
> 	  will be called i2c-amd8111.
> 
> +config I2C_AMD_MP2_PCI
> +	tristate
> +	depends on PCI
> +
> +config I2C_AMD_MP2_PLATFORM
> +	tristate "AMD MP2 Platform"
> +	select I2C_AMD_MP2_PCI
> +	depends on ACPI
> +	help
> +	  If you say yes to this option, support will be included for the AMD MP2
> +	  PCI I2C adapter.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-amd-plat-mp2.
> +
> config I2C_HIX5HD2
> 	tristate "Hix5hd2 high-speed I2C driver"
> 	depends on ARCH_HISI || ARCH_HIX5HD2 || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 18b26af82b1c..16ef646d7ef5 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -32,6 +32,8 @@ obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
> 
> # Embedded system I2C/SMBus host controller drivers
> obj-$(CONFIG_I2C_ALTERA)	+= i2c-altera.o
> +obj-$(CONFIG_I2C_AMD_MP2_PCI)	+= i2c-amd-pci-mp2.o
> +obj-$(CONFIG_I2C_AMD_MP2_PLATFORM)	+= i2c-amd-plat-mp2.o
> obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
> obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
> obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
> diff --git a/drivers/i2c/busses/i2c-amd-pci-mp2.c b/drivers/i2c/busses/i2c-amd-pci-mp2.c
> new file mode 100644
> index 000000000000..2b8d635a03a9
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-amd-pci-mp2.c
> @@ -0,0 +1,633 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * AMD PCIe MP2 Communication Driver
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *          Elie Morisse <syniurge@gmail.com>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include "i2c-amd-pci-mp2.h"
> +
> +#define DRIVER_NAME	"pcie_mp2_amd"
> +#define DRIVER_DESC	"AMD(R) PCI-E MP2 Communication Driver"
> +#define DRIVER_VER	"1.0"
> +
> +static const struct file_operations amd_mp2_debugfs_info;
> +static struct dentry *debugfs_dir;
> +
> +#define write64 _write64
> +static inline void _write64(u64 val, void __iomem *mmio)
> +{
> +	writel(val, mmio);
> +	writel(val >> 32, mmio + sizeof(u32));
> +}
> +
> +#define read64 _read64
> +static inline u64 _read64(void __iomem *mmio)
> +{
> +	u64 low, high;
> +
> +	low = readl(mmio);
> +	high = readl(mmio + sizeof(u32));
> +	return low | (high << 32);
> +}
> +
> +static int amd_mp2_cmd(struct amd_mp2_dev *privdata,
> +		       union i2c_cmd_base i2c_cmd_base)
> +{
> +	void __iomem *reg;
> +
> +	if (i2c_cmd_base.s.bus_id > 1) {
> +		dev_err(ndev_dev(privdata), "%s Invalid bus id\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	reg = privdata->mmio + ((i2c_cmd_base.s.bus_id == 1) ?
> +				AMD_C2P_MSG1 : AMD_C2P_MSG0);
> +	writel(i2c_cmd_base.ul, reg);
> +
> +	return 0;
> +}
> +
> +int amd_mp2_connect(struct amd_i2c_common *i2c_common, bool enable)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(i2c_common->pci_dev);
> +	union i2c_cmd_base i2c_cmd_base;
> +
> +	dev_dbg(ndev_dev(privdata), "%s id: %d\n", __func__,
> +		i2c_common->bus_id);
> +
> +	i2c_common->reqcmd = enable ? i2c_enable : i2c_disable;
> +
> +	i2c_cmd_base.ul = 0;
> +	i2c_cmd_base.s.i2c_cmd = i2c_common->reqcmd;
> +	i2c_cmd_base.s.bus_id = i2c_common->bus_id;
> +	i2c_cmd_base.s.i2c_speed = i2c_common->i2c_speed;
> +
> +	return amd_mp2_cmd(privdata, i2c_cmd_base);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_connect);
> +
> +int amd_mp2_read(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(i2c_common->pci_dev);
> +	union i2c_cmd_base i2c_cmd_base;
> +
> +	dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> +		i2c_common->rw_cfg.slave_addr, i2c_common->bus_id);
> +
> +	i2c_common->reqcmd = i2c_read;
> +
> +	i2c_cmd_base.s.i2c_cmd = i2c_common->reqcmd;
> +	i2c_cmd_base.s.bus_id = i2c_common->bus_id;
> +	i2c_cmd_base.s.i2c_speed = i2c_common->i2c_speed;
> +	i2c_cmd_base.s.slave_addr = i2c_common->rw_cfg.slave_addr;
> +	i2c_cmd_base.s.length = i2c_common->rw_cfg.length;
> +
> +	/* there is only one data mailbox for two i2c adapters */
> +	mutex_lock(&privdata->c2p_lock);
> +
> +	if (i2c_common->rw_cfg.length <= 32) {
> +		i2c_cmd_base.s.mem_type = use_c2pmsg;
> +		if (!i2c_common->rw_cfg.buf) {
> +			dev_err(ndev_dev(privdata), "%s no mem for buf received\n",
> +				__func__);
> +			return -ENOMEM;
> +		}
> +	} else {
> +		i2c_cmd_base.s.mem_type = use_dram;
> +		write64((u64)i2c_common->rw_cfg.dma_addr,
> +			privdata->mmio + AMD_C2P_MSG2);
> +	}
> +
> +	return amd_mp2_cmd(privdata, i2c_cmd_base);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_read);
> +
> +int amd_mp2_write(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(i2c_common->pci_dev);
> +	union i2c_cmd_base i2c_cmd_base;
> +
> +	dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> +		i2c_common->rw_cfg.slave_addr, i2c_common->bus_id);
> +
> +	i2c_common->reqcmd = i2c_write;
> +
> +	i2c_cmd_base.s.i2c_cmd = i2c_common->reqcmd;
> +	i2c_cmd_base.s.bus_id = i2c_common->bus_id;
> +	i2c_cmd_base.s.i2c_speed = i2c_common->i2c_speed;
> +	i2c_cmd_base.s.slave_addr = i2c_common->rw_cfg.slave_addr;
> +	i2c_cmd_base.s.length = i2c_common->rw_cfg.length;
> +
> +	/* there is only one data mailbox for two i2c adapters */
> +	mutex_lock(&privdata->c2p_lock);
> +
> +	if (i2c_common->rw_cfg.length <= 32) {
> +		i2c_cmd_base.s.mem_type = use_c2pmsg;
> +		memcpy_toio(privdata->mmio + AMD_C2P_MSG2,
> +			    i2c_common->rw_cfg.buf,
> +			    i2c_common->rw_cfg.length);
> +	} else {
> +		i2c_cmd_base.s.mem_type = use_dram;
> +		write64((u64)i2c_common->rw_cfg.dma_addr,
> +			privdata->mmio + AMD_C2P_MSG2);
> +	}
> +
> +	return amd_mp2_cmd(privdata, i2c_cmd_base);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_write);
> +
> +static void amd_mp2_pci_do_work(struct work_struct *work)
> +{
> +	struct amd_i2c_common *i2c_common = work_amd_i2c_common(work);
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(i2c_common->pci_dev);
> +	int sts = i2c_common->eventval.r.status;
> +	int res = i2c_common->eventval.r.response;
> +	int len = i2c_common->eventval.r.length;
> +	u32 slave_addr = i2c_common->eventval.r.slave_addr;
> +
> +	if (len != i2c_common->rw_cfg.length)
> +		dev_err(ndev_dev(privdata),
> +			"length %d in event doesn't match buffer length %d!\n",
> +			len, i2c_common->rw_cfg.length);
> +	if (slave_addr != i2c_common->rw_cfg.slave_addr)
> +		dev_err(ndev_dev(privdata),
> +			"unexpected slave address %x (expected: %x)!\n",
> +			slave_addr, i2c_common->rw_cfg.slave_addr);
> +
> +	if (res != command_success) {
> +		if (res == command_failed)
> +			dev_err(ndev_dev(privdata), "i2c command failed!\n");
> +		else
> +			dev_err(ndev_dev(privdata), "invalid response to i2c command!\n");
> +		return;
> +	}
> +
> +	switch (i2c_common->reqcmd) {
> +	case i2c_read:
> +		if (sts == i2c_readcomplete_event) {
> +			if (len <= 32)
> +				memcpy_fromio(i2c_common->rw_cfg.buf,
> +					      privdata->mmio + AMD_C2P_MSG2,
> +					      i2c_common->rw_cfg.length);
> +		} else if (sts == i2c_readfail_event) {
> +			dev_err(ndev_dev(privdata), "i2c read failed!\n");
> +		} else {
> +			dev_err(ndev_dev(privdata), "invalid i2c status after read!\n");
> +		}
> +
> +		i2c_common->ops->read_complete(&i2c_common->eventval);
> +		break;
> +	case i2c_write:
> +		if (sts == i2c_writefail_event)
> +			dev_err(ndev_dev(privdata), "i2c write failed!\n");
> +		else if (sts != i2c_writecomplete_event)
> +			dev_err(ndev_dev(privdata), "invalid i2c status after write!\n");
> +
> +		i2c_common->ops->write_complete(&i2c_common->eventval);
> +		break;
> +	case i2c_enable:
> +		if (sts == i2c_busdisable_failed)
> +			dev_err(ndev_dev(privdata), "i2c bus enable failed!\n");
> +		else if (sts != i2c_busenable_complete)
> +			dev_err(ndev_dev(privdata), "invalid i2c status after bus enable!\n");
> +
> +		i2c_common->ops->connect_complete(&i2c_common->eventval);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void amd_mp2_pci_work(struct work_struct *work)
> +{
> +	struct amd_i2c_common *i2c_common = work_amd_i2c_common(work);
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(i2c_common->pci_dev);
> +	enum i2c_cmd cmd = i2c_common->reqcmd;
> +
> +	amd_mp2_pci_do_work(work);
> +
> +	i2c_common->reqcmd = i2c_none;
> +
> +	if (cmd == i2c_read || cmd == i2c_write)
> +		mutex_unlock(&privdata->c2p_lock);
> +}
> +
> +static irqreturn_t amd_mp2_irq_isr(int irq, void *dev)
> +{
> +	struct amd_mp2_dev *privdata = dev;
> +	struct amd_i2c_common *i2c_common;
> +	u32 val;
> +	unsigned int bus_id;
> +	void __iomem *reg;
> +	unsigned long flags;
> +	enum irqreturn ret = IRQ_NONE;
> +
> +	raw_spin_lock_irqsave(&privdata->lock, flags);
> +
> +	for (bus_id = 0; bus_id < 2; bus_id++) {
> +		reg = privdata->mmio + ((bus_id == 0) ?
> +					AMD_P2C_MSG1 : AMD_P2C_MSG2);
> +		val = readl(reg);
> +		if (val != 0) {
> +			i2c_common = privdata->plat_common[bus_id];
> +			if (!i2c_common)
> +				continue;
> +			i2c_common->eventval.ul = val;
> +
> +			writel(0, reg);
> +			writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> +
> +			if (i2c_common->reqcmd != i2c_none)
> +				schedule_delayed_work(&i2c_common->work, 0);
> +
> +			ret = IRQ_HANDLED;
> +		}
> +	}
> +
> +	raw_spin_unlock_irqrestore(&privdata->lock, flags);
> +	return ret;
> +}
> +
> +int amd_i2c_register_cb(struct pci_dev *pci_dev,
> +			struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
> +
> +	if (i2c_common->bus_id > 1)
> +		return -EINVAL;
> +	privdata->plat_common[i2c_common->bus_id] = i2c_common;
> +
> +	INIT_DELAYED_WORK(&i2c_common->work, amd_mp2_pci_work);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_i2c_register_cb);
> +
> +int amd_i2c_unregister_cb(struct pci_dev *pci_dev,
> +			  struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
> +
> +	cancel_delayed_work_sync(&i2c_common->work);
> +	privdata->plat_common[i2c_common->bus_id] = NULL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_i2c_unregister_cb);
> +
> +static ssize_t amd_mp2_debugfs_read(struct file *filp, char __user *ubuf,
> +				    size_t count, loff_t *offp)
> +{
> +	struct amd_mp2_dev *privdata;
> +	void __iomem *mmio;
> +	u8 *buf;
> +	size_t buf_size;
> +	ssize_t ret, off;
> +	u32 v32;
> +
> +	privdata = filp->private_data;
> +	mmio = privdata->mmio;
> +	buf_size = min(count, (size_t)0x800);
> +	buf = kmalloc(buf_size, GFP_KERNEL);
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	off = 0;
> +	off += scnprintf(buf + off, buf_size - off,
> +			"Mp2 Device Information:\n");
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			"========================\n");
> +	off += scnprintf(buf + off, buf_size - off,
> +			"\tMP2 C2P Message Register Dump:\n\n");
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG0);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG0 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG1);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG1 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG2);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG2 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG3);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG3 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG4);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG4 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG5);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG5 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG6);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG6 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG7);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG7 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG8);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG8 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_C2P_MSG9);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_C2P_MSG9 -\t\t\t%#06x\n", v32);
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			"\n\tMP2 P2C Message Register Dump:\n\n");
> +
> +	v32 = readl(privdata->mmio + AMD_P2C_MSG1);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_P2C_MSG1 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_P2C_MSG2);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_P2C_MSG2 -\t\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_P2C_MSG_INTEN);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_P2C_MSG_INTEN -\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_P2C_MSG_INTSTS);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_P2C_MSG_INTSTS -\t\t%#06x\n", v32);
> +
> +	ret = simple_read_from_buffer(ubuf, count, offp, buf, off);
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static void amd_mp2_init_debugfs(struct amd_mp2_dev *privdata)
> +{
> +	if (!debugfs_dir) {
> +		privdata->debugfs_dir = NULL;
> +		privdata->debugfs_info = NULL;
> +	} else {
> +		privdata->debugfs_dir = debugfs_create_dir(ndev_name(privdata),
> +							   debugfs_dir);
> +		if (!privdata->debugfs_dir) {
> +			privdata->debugfs_info = NULL;
> +		} else {
> +			privdata->debugfs_info = debugfs_create_file
> +				("info", 0400, privdata->debugfs_dir,
> +					privdata, &amd_mp2_debugfs_info);
> +		}
> +	}
> +}
> +
> +static void amd_mp2_deinit_debugfs(struct amd_mp2_dev *privdata)
> +{
> +	debugfs_remove_recursive(privdata->debugfs_dir);
> +}
> +
> +static void amd_mp2_clear_reg(struct amd_mp2_dev *privdata)
> +{
> +	int reg = 0;
> +
> +	for (reg = AMD_C2P_MSG0; reg <= AMD_C2P_MSG9; reg += 4)
> +		writel(0, privdata->mmio + reg);
> +
> +	for (reg = AMD_P2C_MSG0; reg <= AMD_P2C_MSG2; reg += 4)
> +		writel(0, privdata->mmio + reg);
> +}
> +
> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata,
> +			    struct pci_dev *pci_dev)
> +{
> +	int rc;
> +	int bar_index = 2;
> +	resource_size_t size, base;
> +
> +	pci_set_drvdata(pci_dev, privdata);
> +
> +	rc = pci_enable_device(pci_dev);
> +	if (rc)
> +		goto err_pci_enable;
> +
> +	rc = pci_request_regions(pci_dev, DRIVER_NAME);
> +	if (rc)
> +		goto err_pci_regions;
> +
> +	pci_set_master(pci_dev);
> +
> +	rc = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		rc = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32));
> +		if (rc)
> +			goto err_dma_mask;
> +		dev_warn(ndev_dev(privdata), "Cannot DMA highmem\n");
> +	}
> +
> +	rc = pci_set_consistent_dma_mask(pci_dev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		rc = pci_set_consistent_dma_mask(pci_dev, DMA_BIT_MASK(32));
> +		if (rc)
> +			goto err_dma_mask;
> +		dev_warn(ndev_dev(privdata), "Cannot DMA consistent highmem\n");
> +	}
> +
> +	base = pci_resource_start(pci_dev, bar_index);
> +	size = pci_resource_len(pci_dev, bar_index);
> +	dev_dbg(ndev_dev(privdata), "Base addr:%zx size:%zx\n",
> +		(size_t)base, (size_t)size);
> +
> +	mutex_init(&privdata->c2p_lock);
> +	privdata->mmio = ioremap(base, size);
> +	if (!privdata->mmio) {
> +		rc = -EIO;
> +		goto err_dma_mask;
> +	}
> +
> +	/* Try to set up intx irq */
> +	raw_spin_lock_init(&privdata->lock);
> +	pci_intx(pci_dev, 1);
> +	rc = request_irq(pci_dev->irq, amd_mp2_irq_isr, IRQF_SHARED,
> +			 "mp2_irq_isr", privdata);
> +	if (rc)
> +		goto err_intx_request;
> +
> +	return 0;
> +
> +err_intx_request:
> +	return rc;
> +err_dma_mask:
> +	pci_clear_master(pci_dev);
> +	pci_release_regions(pci_dev);
> +err_pci_regions:
> +	pci_disable_device(pci_dev);
> +err_pci_enable:
> +	pci_set_drvdata(pci_dev, NULL);
> +	return rc;
> +}
> +
> +static void amd_mp2_pci_deinit(struct amd_mp2_dev *privdata)
> +{
> +	struct pci_dev *pci_dev = ndev_pdev(privdata);
> +
> +	pci_iounmap(pci_dev, privdata->mmio);
> +
> +	pci_clear_master(pci_dev);
> +	pci_release_regions(pci_dev);
> +	pci_disable_device(pci_dev);
> +	pci_set_drvdata(pci_dev, NULL);
> +}
> +
> +static int amd_mp2_pci_probe(struct pci_dev *pci_dev,
> +			     const struct pci_device_id *id)
> +{
> +	struct amd_mp2_dev *privdata;
> +	int rc;
> +
> +	dev_info(&pci_dev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> +		 (int)pci_dev->vendor, (int)pci_dev->device,
> +		 (int)pci_dev->revision);
> +
> +	privdata = kzalloc(sizeof(*privdata), GFP_KERNEL);
> +	if (!privdata) {
> +		rc = -ENOMEM;
> +		goto err_dev;
> +	}
> +
> +	privdata->pci_dev = pci_dev;
> +
> +	rc = amd_mp2_pci_init(privdata, pci_dev);
> +	if (rc)
> +		goto err_pci_init;
> +	dev_dbg(&pci_dev->dev, "pci init done.\n");
> +
> +	amd_mp2_init_debugfs(privdata);
> +	dev_info(&pci_dev->dev, "MP2 device registered.\n");
> +	return 0;
> +
> +err_pci_init:
> +	kfree(privdata);
> +err_dev:
> +	dev_err(&pci_dev->dev, "Memory Allocation Failed\n");
> +	return rc;
> +}
> +
> +static void amd_mp2_pci_remove(struct pci_dev *pci_dev)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
> +	unsigned int bus_id;
> +
> +	for (bus_id = 0; bus_id < 2; bus_id++)
> +		if (privdata->plat_common[bus_id])
> +			amd_i2c_unregister_cb(pci_dev,
> +					      privdata->plat_common[bus_id]);
> +
> +	amd_mp2_deinit_debugfs(privdata);
> +	amd_mp2_clear_reg(privdata);
> +	free_irq(pci_dev->irq, privdata);
> +	pci_intx(pci_dev, 0);
> +	amd_mp2_pci_deinit(privdata);
> +	kfree(privdata);
> +}
> +
> +static const struct file_operations amd_mp2_debugfs_info = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = amd_mp2_debugfs_read,
> +};
> +
> +static const struct pci_device_id amd_mp2_pci_tbl[] = {
> +	{PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int amd_mp2_pci_device_suspend(struct pci_dev *pci_dev,
> +				      pm_message_t mesg)
> +{
> +	int ret;
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
> +
> +	if (!privdata)
> +		return -EINVAL;
> +
> +	ret = pci_save_state(pci_dev);
> +	if (ret) {
> +		dev_err(ndev_dev(privdata),
> +			"pci_save_state failed = %d\n", ret);
> +		return ret;
> +	}
> +
> +	pci_enable_wake(pci_dev, PCI_D3hot, 0);
> +	pci_disable_device(pci_dev);
> +	pci_set_power_state(pci_dev, pci_choose_state(pci_dev, mesg));
> +
> +	return 0;
> +}
> +
> +static int amd_mp2_pci_device_resume(struct pci_dev *pci_dev)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
> +
> +	if (!privdata)
> +		return -EINVAL;
> +
> +	pci_set_power_state(pci_dev, PCI_D0);
> +	pci_restore_state(pci_dev);
> +
> +	if (pci_enable_device(pci_dev) < 0) {
> +		dev_err(ndev_dev(privdata), "pci_enable_device failed\n");
> +		return -EIO;
> +	}
> +
> +	pci_enable_wake(pci_dev, PCI_D3hot, 0);
> +
> +	return 0;
> +}
> +#endif
> +
> +static struct pci_driver amd_mp2_pci_driver = {
> +	.name		= DRIVER_NAME,
> +	.id_table	= amd_mp2_pci_tbl,
> +	.probe		= amd_mp2_pci_probe,
> +	.remove		= amd_mp2_pci_remove,
> +#ifdef CONFIG_PM_SLEEP
> +	.suspend		= amd_mp2_pci_device_suspend,
> +	.resume			= amd_mp2_pci_device_resume,
> +#endif
> +};
> +
> +static int __init amd_mp2_pci_driver_init(void)
> +{
> +	pr_info("%s: %s Version: %s\n", DRIVER_NAME, DRIVER_DESC, DRIVER_VER);
> +
> +	if (debugfs_initialized())
> +		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +
> +	return pci_register_driver(&amd_mp2_pci_driver);
> +}
> +module_init(amd_mp2_pci_driver_init);
> +
> +static void __exit amd_mp2_pci_driver_exit(void)
> +{
> +	pci_unregister_driver(&amd_mp2_pci_driver);
> +	debugfs_remove_recursive(debugfs_dir);
> +}
> +module_exit(amd_mp2_pci_driver_exit);
> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_VERSION(DRIVER_VER);
> +MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
> +MODULE_AUTHOR("Elie Morisse <syniurge@gmail.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/i2c/busses/i2c-amd-pci-mp2.h b/drivers/i2c/busses/i2c-amd-pci-mp2.h
> new file mode 100644
> index 000000000000..35814d4bb8a0
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-amd-pci-mp2.h
> @@ -0,0 +1,219 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * AMD PCIe MP2 Communication Driver
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *          Elie Morisse <syniurge@gmail.com>
> + */
> +
> +#ifndef I2C_AMD_PCI_MP2_H
> +#define I2C_AMD_PCI_MP2_H
> +
> +#include <linux/pci.h>
> +
> +#define PCI_DEVICE_ID_AMD_MP2	0x15E6
> +
> +struct amd_i2c_common;
> +
> +enum {
> +	/* MP2 C2P Message Registers */
> +	AMD_C2P_MSG0 = 0x10500,			/* MP2 Message for I2C0 */
> +	AMD_C2P_MSG1 = 0x10504,			/* MP2 Message for I2C1 */
> +	AMD_C2P_MSG2 = 0x10508,			/* DRAM Address Lo / Data 0 */
> +	AMD_C2P_MSG3 = 0x1050c,			/* DRAM Address HI / Data 1 */
> +	AMD_C2P_MSG4 = 0x10510,			/* Data 2 */
> +	AMD_C2P_MSG5 = 0x10514,			/* Data 3 */
> +	AMD_C2P_MSG6 = 0x10518,			/* Data 4 */
> +	AMD_C2P_MSG7 = 0x1051c,			/* Data 5 */
> +	AMD_C2P_MSG8 = 0x10520,			/* Data 6 */
> +	AMD_C2P_MSG9 = 0x10524,			/* Data 7 */
> +
> +	/* MP2 P2C Message Registers */
> +	AMD_P2C_MSG0 = 0x10680,			/* Do not use */
> +	AMD_P2C_MSG1 = 0x10684,			/* I2C0 interrupt register */
> +	AMD_P2C_MSG2 = 0x10688,			/* I2C1 interrupt register */
> +	AMD_P2C_MSG3 = 0x1068C,			/* MP2 debug info */
> +	AMD_P2C_MSG_INTEN = 0x10690,	/* MP2 interrupt gen register */
> +	AMD_P2C_MSG_INTSTS = 0x10694,	/* Interrupt status */
> +};
> +
> +/* Command register data structures */
> +
> +#define i2c_none (-1)
> +enum i2c_cmd {
> +	i2c_read = 0,
> +	i2c_write,
> +	i2c_enable,
> +	i2c_disable,
> +	number_of_sensor_discovered,
> +	is_mp2_active,
> +	invalid_cmd = 0xF,
> +};
> +
> +enum speed_enum {
> +	speed100k = 0,
> +	speed400k = 1,
> +	speed1000k = 2,
> +	speed1400k = 3,
> +	speed3400k = 4
> +};
> +
> +enum mem_type {
> +	use_dram = 0,
> +	use_c2pmsg = 1,
> +};
> +
> +/**
> + * union i2c_cmd_base : bit access of C2P commands
> + * @i2c_cmd: bit 0..3 i2c R/W command
> + * @bus_id: bit 4..7 i2c bus index
> + * @slave_addr: bit 8..15 slave address
> + * @length: bit 16..27 read/write length
> + * @i2c_speed: bit 28..30 bus speed
> + * @mem_type: bit 31 0-DRAM; 1-C2P msg o/p
> + */
> +union i2c_cmd_base {
> +	u32 ul;
> +	struct {
> +		enum i2c_cmd i2c_cmd : 4;
> +		u8 bus_id : 4;
> +		u32 slave_addr : 8;
> +		u32 length : 12;
> +		enum speed_enum i2c_speed : 3;
> +		enum mem_type mem_type : 1;
> +	} s;
> +};
> +
> +/* Response - Response of SFI */
> +enum response_type {
> +	invalid_response = 0,
> +	command_success = 1,
> +	command_failed = 2,
> +};
> +
> +/* Status - Command ID to indicate a command */
> +enum status_type {
> +	i2c_readcomplete_event = 0,
> +	i2c_readfail_event = 1,
> +	i2c_writecomplete_event = 2,
> +	i2c_writefail_event = 3,
> +	i2c_busenable_complete = 4,
> +	i2c_busenable_failed = 5,
> +	i2c_busdisable_complete = 6,
> +	i2c_busdisable_failed = 7,
> +	invalid_data_length = 8,
> +	invalid_slave_address = 9,
> +	invalid_i2cbus_id = 10,
> +	invalid_dram_addr = 11,
> +	invalid_command = 12,
> +	mp2_active = 13,
> +	numberof_sensors_discovered_resp = 14,
> +	i2c_bus_notinitialized
> +};
> +
> +/**
> + * union i2c_event : bit access of P2C events
> + * @response: bit 0..1 i2c response type
> + * @status: bit 2..6 status_type
> + * @mem_type: bit 7 0-DRAM; 1-C2P msg o/p
> + * @bus_id: bit 8..11 i2c bus id
> + * @length: bit 12..23 message length
> + * @slave_addr: bit 24-31 slave address
> + */
> +union i2c_event {
> +	u32 ul;
> +	struct {
> +		enum response_type response : 2;
> +		enum status_type status : 5;
> +		enum mem_type mem_type : 1;
> +		u8 bus_id : 4;
> +		u32 length : 12;
> +		u32 slave_addr : 8;
> +	} r;
> +};
> +
> +/**
> + * struct i2c_rw_config - i2c read/write settings
> + * @slave_addr: slave address
> + * @length: message length
> + * @buf: buffer address
> + * @dma_addr: if length > 32, holds the DMA buffer address
> + */
> +struct i2c_rw_config {
> +	u16 slave_addr;
> +	u32 length;
> +	u32 *buf;
> +	dma_addr_t dma_addr;
> +};
> +
> +/**
> + * struct amd_i2c_pci_ops - platdrv hooks
> + */
> +struct amd_i2c_pci_ops {
> +	int (*read_complete)(union i2c_event *event);
> +	int (*write_complete)(union i2c_event *event);
> +	int (*connect_complete)(union i2c_event *event);
> +};
> +
> +/**
> + * struct amd_i2c_common - per bus/i2c adapter context, shared
> + *		between the pci and the platform driver
> + * @eventval: MP2 event value set by the IRQ handler to be processed
> + *		by the worker
> + * @ops: platdrv hooks
> + * @rw_cfg: settings for reads/writes
> + * @work: delayed worker struct
> + * @reqcmd: i2c command type requested by platdrv
> + * @requested: true if the interrupt answered a request from platdrv
> + * @bus_id: bus index
> + * @i2c_speed: i2c bus speed determined by the slowest slave
> + */
> +struct amd_i2c_common {
> +	union i2c_event eventval;
> +	const struct amd_i2c_pci_ops *ops;
> +	struct pci_dev *pci_dev;
> +	struct i2c_rw_config rw_cfg;
> +	struct delayed_work work;
> +	enum i2c_cmd reqcmd;
> +	u8 bus_id;
> +	enum speed_enum i2c_speed;
> +};
> +
> +/**
> + * struct amd_mp2_dev - per PCI device context
> + * @pci_dev: PCI driver node
> + * @plat_common: MP2 devices may have up to two busses,
> + *		each bus corresponding to an i2c adapter
> + * @mmio: iommapped registers
> + * @lock: interrupt spinlock
> + * @c2p_lock: controls access to the C2P mailbox shared between
> + *		the two adapters
> + */
> +struct amd_mp2_dev {
> +	struct pci_dev *pci_dev;
> +	struct amd_i2c_common *plat_common[2];
> +	void __iomem *mmio;
> +	raw_spinlock_t lock;
> +	struct mutex c2p_lock;
> +	struct dentry *debugfs_dir;
> +	struct dentry *debugfs_info;
> +};
> +
> +int amd_mp2_read(struct amd_i2c_common *i2c_common);
> +int amd_mp2_write(struct amd_i2c_common *i2c_common);
> +int amd_mp2_connect(struct amd_i2c_common *i2c_common, bool enable);
> +
> +int amd_i2c_register_cb(struct pci_dev *pci_dev,
> +			struct amd_i2c_common *i2c_common);
> +int amd_i2c_unregister_cb(struct pci_dev *pci_dev,
> +			  struct amd_i2c_common *i2c_common);
> +
> +#define ndev_pdev(ndev) ((ndev)->pci_dev)
> +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
> +#define work_amd_i2c_common(__work) \
> +	container_of(__work, struct amd_i2c_common, work.work)
> +#define event_amd_i2c_common(__event) \
> +	container_of(__event, struct amd_i2c_common, eventval)
> +
> +#endif
> diff --git a/drivers/i2c/busses/i2c-amd-plat-mp2.c b/drivers/i2c/busses/i2c-amd-plat-mp2.c
> new file mode 100644
> index 000000000000..0911a2491074
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-amd-plat-mp2.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * AMD MP2 I2C Platform Driver
> + *
> + * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
> + *          Elie Morisse <syniurge@gmail.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +
> +#include "i2c-amd-pci-mp2.h"
> +#define DRIVER_NAME "i2c-amd-plat-mp2"
> +
> +#define AMD_MP2_I2C_MAX_RW_LENGTH ((1 << 12) - 1)
> +#define AMD_I2C_TIMEOUT (msecs_to_jiffies(250))
> +
> +/**
> + * struct amd_i2c_dev - MP2 bus/i2c adapter context
> + * @i2c_common: shared context with the MP2 pci driver
> + * @pdev: platform driver node
> + * @adapter: i2c adapter
> + * @xfer_lock: xfer lock
> + * @completion: xfer completion object
> + */
> +struct amd_i2c_dev {
> +	struct amd_i2c_common i2c_common;
> +	struct platform_device *pdev;
> +	struct i2c_adapter adapter;
> +	struct mutex xfer_lock;
> +	struct completion msg_complete;
> +	struct i2c_msg *msg_buf;
> +	bool is_configured;
> +};
> +
> +static const struct i2c_adapter_quirks amd_i2c_dev_quirks = {
> +	.max_read_len = AMD_MP2_I2C_MAX_RW_LENGTH,
> +	.max_write_len = AMD_MP2_I2C_MAX_RW_LENGTH,
> +};
> +
> +#define amd_i2c_dev_common(__common) \
> +	container_of(__common, struct amd_i2c_dev, i2c_common)
> +
> +static int i2c_amd_read_completion(union i2c_event *event)
> +{
> +	struct amd_i2c_common *i2c_common = event_amd_i2c_common(event);
> +	struct amd_i2c_dev *i2c_dev = amd_i2c_dev_common(i2c_common);
> +
> +	if (event->r.status == i2c_readcomplete_event) {
> +		if (event->r.length > 32) {
> +			pr_devel("%s:%s virt:%p dma_addr:%zx\n",
> +				 DRIVER_NAME, __func__,
> +				 i2c_common->rw_cfg.buf,
> +				 (size_t)i2c_common->rw_cfg.dma_addr);
> +
> +			memcpy(i2c_dev->msg_buf->buf, i2c_common->rw_cfg.buf,
> +			       event->r.length);
> +		}
> +
> +		pr_devel("%s:%s readdata:%*ph\n",
> +			 DRIVER_NAME, __func__, event->r.length,
> +			 i2c_common->rw_cfg.buf);
> +	}
> +
> +	complete(&i2c_dev->msg_complete);
> +
> +	return 0;
> +}
> +
> +static int i2c_amd_write_completion(union i2c_event *event)
> +{
> +	struct amd_i2c_common *i2c_common = event_amd_i2c_common(event);
> +	struct amd_i2c_dev *i2c_dev = amd_i2c_dev_common(i2c_common);
> +
> +	complete(&i2c_dev->msg_complete);
> +
> +	return 0;
> +}
> +
> +static int i2c_amd_connect_completion(union i2c_event *event)
> +{
> +	struct amd_i2c_common *i2c_common = event_amd_i2c_common(event);
> +	struct amd_i2c_dev *i2c_dev = amd_i2c_dev_common(i2c_common);
> +
> +	complete(&i2c_dev->msg_complete);
> +
> +	return 0;
> +}
> +
> +static const struct amd_i2c_pci_ops data_handler = {
> +		.read_complete = i2c_amd_read_completion,
> +		.write_complete = i2c_amd_write_completion,
> +		.connect_complete = i2c_amd_connect_completion,
> +};
> +
> +static int i2c_amd_pci_configure(struct amd_i2c_dev *i2c_dev)
> +{
> +	struct amd_i2c_common *i2c_common = &i2c_dev->i2c_common;
> +
> +	amd_i2c_register_cb(i2c_common->pci_dev, i2c_common);
> +	i2c_common->ops = &data_handler;
> +
> +	return 0;
> +}
> +
> +static int i2c_amd_pci_xconnect(struct amd_i2c_dev *dev, bool enable)
> +{
> +	struct amd_i2c_common *i2c_common = &dev->i2c_common;
> +	unsigned long timeout;
> +
> +	reinit_completion(&dev->msg_complete);
> +	amd_mp2_connect(i2c_common, enable);
> +	timeout = wait_for_completion_timeout(&dev->msg_complete,
> +					      AMD_I2C_TIMEOUT);
> +	if (timeout == 0) {
> +		pr_err(" i2c connect timed out pdev->name=%s\n",
> +		       dev->pdev->name);
> +		mutex_unlock(&dev->xfer_lock);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int i2c_amd_xfer_msg(struct amd_i2c_dev *dev, struct i2c_msg *pmsg)
> +{
> +	struct amd_i2c_common *i2c_common = &dev->i2c_common;
> +	unsigned long timeout;
> +	bool is_read = pmsg->flags & I2C_M_RD;
> +	enum dma_data_direction dma_direction = is_read ?
> +			DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +
> +	reinit_completion(&dev->msg_complete);
> +
> +	i2c_common->rw_cfg.slave_addr = pmsg->addr;
> +	i2c_common->rw_cfg.buf = (u32 *)pmsg->buf;
> +	i2c_common->rw_cfg.length = pmsg->len;
> +	dev->msg_buf = pmsg;
> +
> +	if (pmsg->len > 32) {
> +		i2c_common->rw_cfg.dma_addr = dma_map_single
> +			(&i2c_common->pci_dev->dev,
> +			pmsg->buf,
> +			pmsg->len,
> +			dma_direction);
> +
> +		if (dma_mapping_error(&i2c_common->pci_dev->dev,
> +				      i2c_common->rw_cfg.dma_addr)) {
> +			dev_err(&dev->pdev->dev, "Error in mapping dma buffer %p\n",
> +				pmsg->buf);
> +			return -EIO;
> +		}
> +	}
> +
> +	if (is_read)
> +		amd_mp2_read(i2c_common);
> +	else
> +		amd_mp2_write(i2c_common);
> +
> +	timeout = wait_for_completion_timeout
> +				(&dev->msg_complete, AMD_I2C_TIMEOUT);
> +	if (timeout == 0) {
> +		pr_err(" i2c %s timed out pdev->name=%s\n",
> +		       is_read ? "read" : "write",
> +		       dev->pdev->name);
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (pmsg->len > 32)
> +		dma_unmap_single(&i2c_common->pci_dev->dev,
> +				 i2c_common->rw_cfg.dma_addr,
> +				 pmsg->len,
> +				 dma_direction);
> +
> +	return 0;
> +}
> +
> +static int i2c_amd_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	struct amd_i2c_dev *dev = i2c_get_adapdata(adap);
> +	int i;
> +	struct i2c_msg *pmsg;
> +	int err;
> +
> +	mutex_lock(&dev->xfer_lock);
> +
> +	if (dev->is_configured == 0) {
> +		i2c_amd_pci_configure(dev);
> +		i2c_amd_pci_xconnect(dev, true);
> +		dev->is_configured = 1;
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		pmsg = &msgs[i];
> +		err = i2c_amd_xfer_msg(dev, pmsg);
> +		if (err)
> +			break;
> +	}
> +
> +	mutex_unlock(&dev->xfer_lock);
> +
> +	if (err)
> +		return err;
> +	return num;
> +}
> +
> +static u32 i2c_amd_func(struct i2c_adapter *a)
> +{
> +	return I2C_FUNC_I2C;
> +}
> +
> +static const struct i2c_algorithm i2c_amd_algorithm = {
> +	.master_xfer = i2c_amd_xfer,
> +	.functionality = i2c_amd_func,
> +};
> +
> +static enum speed_enum i2c_amd_get_bus_speed(struct platform_device *pdev)
> +{
> +	u32 acpi_speed;
> +	int i;
> +	static const u32 supported_speeds[] = {
> +		0, 100000, 400000, 1000000, 1400000, 3400000
> +	};
> +
> +	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
> +	/* round down to the lowest standard speed */
> +	for (i = 1; i < ARRAY_SIZE(supported_speeds); i++) {
> +		if (acpi_speed < supported_speeds[i])
> +			break;
> +	}
> +	acpi_speed = supported_speeds[i - 1];
> +
> +	switch (acpi_speed) {
> +	case 100000:
> +		return speed100k;
> +	case 400000:
> +		return speed400k;
> +	case 1000000:
> +		return speed1000k;
> +	case 1400000:
> +		return speed1400k;
> +	case 3400000:
> +		return speed3400k;
> +	default:
> +		return speed400k;
> +	}
> +}
> +
> +static int i2c_amd_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct amd_i2c_dev *i2c_dev;
> +	struct device *dev = &pdev->dev;
> +	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
> +	struct acpi_device *adev;
> +	const char *uid;
> +
> +	i2c_dev = devm_kzalloc(dev, sizeof(*i2c_dev), GFP_KERNEL);
> +	if (!i2c_dev)
> +		return -ENOMEM;
> +
> +	i2c_dev->pdev = pdev;
> +
> +	if (!acpi_bus_get_device(handle, &adev)) {
> +		pr_devel(" i2c0  uid=%s\n", adev->pnp.unique_id);
> +		uid = adev->pnp.unique_id;
> +
> +		if (uid && strcmp(uid, "0") == 0) {
> +			i2c_dev->i2c_common.bus_id = 0;
> +		} else if (uid && strcmp(uid, "1") == 0) {
> +			i2c_dev->i2c_common.bus_id = 1;
> +		} else {
> +			if (uid)
> +				pr_err("incorrect UID/bus id \"%s\"!\n", uid);
> +			else
> +				pr_err("missing UID/bus id!\n");
> +			return -EINVAL;
> +		}
> +		pr_devel(" bus id is %u\n", i2c_dev->i2c_common.bus_id);
> +
> +		i2c_dev->i2c_common.i2c_speed = i2c_amd_get_bus_speed(pdev);
> +	} else {
> +		i2c_dev->i2c_common.i2c_speed = speed400k;
> +	}
> +
> +	/* setup i2c adapter description */
> +	i2c_dev->adapter.owner = THIS_MODULE;
> +	i2c_dev->adapter.algo = &i2c_amd_algorithm;
> +	i2c_dev->adapter.quirks = &amd_i2c_dev_quirks;
> +	i2c_dev->adapter.dev.parent = dev;
> +	i2c_dev->adapter.algo_data = i2c_dev;
> +	ACPI_COMPANION_SET(&i2c_dev->adapter.dev, ACPI_COMPANION(&pdev->dev));
> +	i2c_dev->adapter.dev.of_node = dev->of_node;
> +	snprintf(i2c_dev->adapter.name, sizeof(i2c_dev->adapter.name), "%s-%s",
> +		 "i2c_dev-i2c", dev_name(pdev->dev.parent));
> +
> +	i2c_dev->i2c_common.pci_dev = pci_get_device
> +		(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MP2, NULL);
> +
> +	if (!i2c_dev->i2c_common.pci_dev) {
> +		pr_err("%s Could not find MP2 PCI device for i2c adapter\n",
> +		       __func__);
> +		return -EINVAL;
> +	}
> +	platform_set_drvdata(pdev, i2c_dev);
> +
> +	i2c_set_adapdata(&i2c_dev->adapter, i2c_dev);
> +
> +	init_completion(&i2c_dev->msg_complete);
> +	mutex_init(&i2c_dev->xfer_lock);
> +
> +	/* and finally attach to i2c layer */
> +	ret = i2c_add_adapter(&i2c_dev->adapter);
> +
> +	if (ret < 0)
> +		pr_err(" i2c add adapter failed =%d", ret);
> +
> +	return ret;
> +}
> +
> +static int i2c_amd_remove(struct platform_device *pdev)
> +{
> +	struct amd_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
> +	struct amd_i2c_common *i2c_common = &i2c_dev->i2c_common;
> +
> +	i2c_amd_pci_xconnect(i2c_dev, false);
> +
> +	amd_i2c_unregister_cb(i2c_common->pci_dev, i2c_common);
> +	i2c_del_adapter(&i2c_dev->adapter);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id i2c_amd_acpi_match[] = {
> +		{ "AMDI0011" },
> +		{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, i2c_amd_acpi_match);
> +
> +static struct platform_driver amd_i2c_plat_driver = {
> +		.probe = i2c_amd_probe,
> +		.remove = i2c_amd_remove,
> +		.driver = {
> +				.name = "i2c_amd_plat_mp2",
> +				.acpi_match_table = ACPI_PTR
> +						(i2c_amd_acpi_match),
> +		},
> +};
> +
> +module_platform_driver(amd_i2c_plat_driver);
> +
> +MODULE_DESCRIPTION("AMD MP2 I2C Platform Driver");
> +MODULE_AUTHOR("Nehal Shah <nehal-bakulchandra.shah@amd.com>");
> +MODULE_AUTHOR("Elie Morisse <syniurge@gmail.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> -- 
> 2.17.1
> 

