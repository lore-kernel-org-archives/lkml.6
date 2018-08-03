Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F743C4646A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27ED217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I6dqzYg3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CbxIXI7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27ED217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeHCXhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:37:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbeHCXhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:37:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E8FB60B11; Fri,  3 Aug 2018 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533332335;
        bh=EaCHpydieVWPjpUzRF9JgMA3EGF20z9mnqbbGDENUlU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=I6dqzYg3D88WVVuXkInDqkba2e4uTlPwnJ8egzl1HEXPD/GBicyORfw1nY8elAJza
         1xjpiEhlA/klj4QodbaCs142Cxv2rRX/n+raI38x8bfa/c4gnKDiCoFv/AkY7kvfzq
         EO3aXbR80G/4hTUZItsAF37MuUOtdW4fZN11rdRU=
Received: from MSHETTELW10 (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mshettel@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73865602B7;
        Fri,  3 Aug 2018 21:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533332326;
        bh=EaCHpydieVWPjpUzRF9JgMA3EGF20z9mnqbbGDENUlU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=CbxIXI7NM3c1lv5vauw7WrvFiN0p6SE/XabdUEy/J/edSiaBnAR8DyeBVysDlQq2q
         5OXtcm9HD+rDS+KYvNFKZ6+b8GQ9yrO1BXxOBZt91QlsYzxPnyHwxsLbUr05b+eYBT
         TAJ9E9gbZHwqb+dFaOvqSRfnHHcucCE1uN2JwfdE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73865602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mshettel@codeaurora.org
From:   <mshettel@codeaurora.org>
To:     "'Boris Brezillon'" <boris.brezillon@bootlin.com>,
        "'Wolfram Sang'" <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        "'Jonathan Corbet'" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Arnd Bergmann'" <arnd@arndb.de>
Cc:     "'Przemyslaw Sroka'" <psroka@cadence.com>,
        "'Arkadiusz Golec'" <agolec@cadence.com>,
        "'Alan Douglas'" <adouglas@cadence.com>,
        "'Bartosz Folta'" <bfolta@cadence.com>,
        "'Damian Kos'" <dkos@cadence.com>,
        "'Alicja Jurasik-Urbaniak'" <alicja@cadence.com>,
        "'Cyprian Wronka'" <cwronka@cadence.com>,
        "'Suresh Punnoose'" <sureshp@cadence.com>,
        "'Rafal Ciepiela'" <rafalc@cadence.com>,
        "'Thomas Petazzoni'" <thomas.petazzoni@bootlin.com>,
        "'Nishanth Menon'" <nm@ti.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Pawel Moll'" <pawel.moll@arm.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Ian Campbell'" <ijc+devicetree@hellion.org.uk>,
        "'Kumar Gala'" <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Vitor Soares'" <Vitor.Soares@synopsys.com>,
        "'Geert Uytterhoeven'" <geert@linux-m68k.org>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Xiang Lin'" <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, "'Sekhar Nori'" <nsekhar@ti.com>,
        "'Przemyslaw Gaj'" <pgaj@cadence.com>,
        "'Peter Rosin'" <peda@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com> <20180719152930.3715-2-boris.brezillon@bootlin.com>
In-Reply-To: <20180719152930.3715-2-boris.brezillon@bootlin.com>
Subject: RE: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Date:   Fri, 3 Aug 2018 15:38:43 -0600
Message-ID: <023901d42b72$5bc329d0$13497d70$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQLh1kGT5Auakb1PwCJMAhFmZ+eW1wGMehXjoobRXFA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/2018 9:29 AM, Boris Brezillon wrote:
> Add core infrastructure to support I3C in Linux and document it.
> 
> This infrastructure is not complete yet and will be extended over
> time.
> 
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices:
> 
> - all functions used to send I3C/I2C frames must be called in
>   non-atomic context. Mainly done this way to ease implementation, but
>   this is still open to discussion. Please let me know if you think
>   it's worth considering an asynchronous model here
> - the bus element is a separate object and is not implicitly described
>   by the master (as done in I2C). The reason is that I want to be able
>   to handle multiple master connected to the same bus and visible to
>   Linux.
>   In this situation, we should only have one instance of the device and
>   not one per master, and sharing the bus object would be part of the
>   solution to gracefully handle this case.
>   I'm not sure we will ever need to deal with multiple masters
>   controlling the same bus and exposed under Linux, but separating the
>   bus and master concept is pretty easy, hence the decision to do it
>   like that.
>   The other benefit of separating the bus and master concepts is that
>   master devices appear under the bus directory in sysfs.
> - I2C backward compatibility has been designed to be transparent to I2C
>   drivers and the I2C subsystem. The I3C master just registers an I2C
>   adapter which creates a new I2C bus. I'd say that, from a
>   representation PoV it's not ideal because what should appear as a
>   single I3C bus exposing I3C and I2C devices here appears as 2
>   different busses connected to each other through the parenting (the
>   I3C master is the parent of the I2C and I3C busses).
>   On the other hand, I don't see a better solution if we want something
>   that is not invasive.
> 
> Missing features in this preliminary version:
> - I3C HDR modes are not supported
> - no support for multi-master and the associated concepts (mastership
>   handover, support for secondary masters, ...)
> - I2C devices can only be described using DT because this is the only
>   use case I have. However, the framework can easily be extended with
>   ACPI and board info support
> - I3C slave framework. This has been completely omitted, but shouldn't
>   have a huge impact on the I3C framework because I3C slaves don't see
>   the whole bus, it's only about handling master requests and generating
>   IBIs. Some of the struct, constant and enum definitions could be
>   shared, but most of the I3C slave framework logic will be different
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v6:
> - Add I3C/I2C dev descriptors to simplify I3C driver controllers when
>   migrating resources from on I3C device slot to anoter
> - Add I3C error codes and return them when doing SDR/priv and CCC
>   transfers. This allows us to properly detect when no devices acked
>   a CCC command, which in some cases is a valid situation (no I3C
>   devices on the bus)
> - Remove __packed specifiers where unneeded
> - Allocate all IBI slots in one call using kcalloc()
> 
> Changes in v5:
> - Rename the address sysfs entry into dynamic_address to clarify things
> - Document that we expect buffers passed to i3c_device_do_priv_xfers()
>   to be DMA-able
> - Fix DEFSLVS CCC command
> - s/2017/2018/ in copyright headers
> - Fix SPDX header in internals.h
> - Fix coding style issues
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - Fix locking issues
> - Explicitly include a bunch of headers (reported by Randy Dunlap)
> - Rename {i2c,i3c}-scl-frequency DT prop into {i2c,i3c}-scl-hz
> - Do not use BIT() macro in mod_devicetable.h
> - Fix typos
> - Fix/enhance some kernel doc headers
> - Rework the bus initialization code to simplify master drivers
> - Assign dynamic address with SETDASA if the device has a static
>   address and the DT has a valid assigned-address property
> - Rework the LVR extraction in DT parsing code
> - Add code to detect when a device is re-attached to the bus after
>   losing its dynamic address. In this case we know try to re-assign the
>   old address, and most importantly, the I3C device driver sees the same
>   device instance, not a new one
> - Add an ->i2c_funcs() hook to let the master declare which I2C features
>   it supports
> - Unexport a few functions
> - Remove support for HDR mode since we have no real user yet
> 
> Changes in v2:
> - Fix a bunch of mistake I made with the device model (pointed by GKH)
> - Move the documentation out of this commit (pointed by GKH)
> - only source drivers/i3c/master/Kconfig when CONFIG_I3C is enabled
>   (pointed by GKH)
> - Add IBI infrastructure
> - Add helpers to ease support for Hot Join (most of the logic is
>   delegated to I3C controller drivers)
> - move the doc out of this commit to improve readability
> - Fix a few bugs in device probing/remove (detected after trying to
>   load/unload modules in various orders)
> - Add a module_i3c_i2c_driver() macro to ease integration of drivers
>   for devices that support both I3C and I2C mode
> ---
>  drivers/Kconfig                 |    2 +
>  drivers/Makefile                |    2 +-
>  drivers/i3c/Kconfig             |   24 +
>  drivers/i3c/Makefile            |    4 +
>  drivers/i3c/core.c              |  606 ++++++++++++
>  drivers/i3c/device.c            |  233 +++++
>  drivers/i3c/internals.h         |   36 +
>  drivers/i3c/master.c            | 2058
> +++++++++++++++++++++++++++++++++++++++
>  drivers/i3c/master/Kconfig      |    0
>  drivers/i3c/master/Makefile     |    0
>  include/linux/i3c/ccc.h         |  385 ++++++++
>  include/linux/i3c/device.h      |  331 +++++++
>  include/linux/i3c/master.h      |  652 +++++++++++++
>  include/linux/mod_devicetable.h |   17 +
>  14 files changed, 4349 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/i3c/Kconfig
>  create mode 100644 drivers/i3c/Makefile
>  create mode 100644 drivers/i3c/core.c
>  create mode 100644 drivers/i3c/device.c
>  create mode 100644 drivers/i3c/internals.h
>  create mode 100644 drivers/i3c/master.c
>  create mode 100644 drivers/i3c/master/Kconfig
>  create mode 100644 drivers/i3c/master/Makefile
>  create mode 100644 include/linux/i3c/ccc.h
>  create mode 100644 include/linux/i3c/device.h
>  create mode 100644 include/linux/i3c/master.h
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 95b9ccc08165..80f6aebc896f 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -55,6 +55,8 @@ source "drivers/char/Kconfig"
> 
>  source "drivers/i2c/Kconfig"
> 
> +source "drivers/i3c/Kconfig"
> +
>  source "drivers/spi/Kconfig"
> 
>  source "drivers/spmi/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 24cd47014657..999239dc29d4 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -111,7 +111,7 @@ obj-$(CONFIG_SERIO)		+= input/serio/
>  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
>  obj-$(CONFIG_INPUT)		+= input/
>  obj-$(CONFIG_RTC_LIB)		+= rtc/
> -obj-y				+= i2c/ media/
> +obj-y				+= i2c/ i3c/ media/
>  obj-$(CONFIG_PPS)		+= pps/
>  obj-y				+= ptp/
>  obj-$(CONFIG_W1)		+= w1/
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> new file mode 100644
> index 000000000000..30a441506f61
> --- /dev/null
> +++ b/drivers/i3c/Kconfig
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +menuconfig I3C
> +	tristate "I3C support"
> +	select I2C
> +	help
> +	  I3C is a serial protocol standardized by the MIPI alliance.
> +
> +	  It's supposed to be backward compatible with I2C while providing
> +	  support for high speed transfers and native interrupt support
> +	  without the need for extra pins.
> +
> +	  The I3C protocol also standardizes the slave device types and is
> +	  mainly designed to communicate with sensors.
> +
> +	  If you want I3C support, you should say Y here and also to the
> +	  specific driver for your bus adapter(s) below.
> +
> +	  This I3C support can also be built as a module.  If so, the module
> +	  will be called i3c.
> +
> +if I3C
> +source "drivers/i3c/master/Kconfig"
> +endif # I3C
> diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
> new file mode 100644
> index 000000000000..3b6d1502d6e6
> --- /dev/null
> +++ b/drivers/i3c/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +i3c-y				:= core.o device.o master.o
> +obj-$(CONFIG_I3C)		+= i3c.o
> +obj-$(CONFIG_I3C)		+= master/
> diff --git a/drivers/i3c/core.c b/drivers/i3c/core.c
> new file mode 100644
> index 000000000000..5c62192ff876
> --- /dev/null
> +++ b/drivers/i3c/core.c
> @@ -0,0 +1,606 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon <boris.brezillon@bootlin.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/rwsem.h>
> +#include <linux/slab.h>
> +
> +#include "internals.h"
> +
> +static DEFINE_IDR(i3c_bus_idr);
> +static DEFINE_MUTEX(i3c_core_lock);
> +
> +/**
> + * i3c_bus_maintenance_lock - Lock the bus for a maintenance operation
> + * @bus: I3C bus to take the lock on
> + *
> + * This function takes the bus lock so that no other operations can occur
on
> + * the bus. This is needed for all kind of bus maintenance operation,
like
> + * - enabling/disabling slave events
> + * - re-triggering DAA
> + * - changing the dynamic address of a device
> + * - relinquishing mastership
> + * - ...
> + *
> + * The reason for this kind of locking is that we don't want drivers and
core
> + * logic to rely on I3C device information that could be changed behind
their
> + * back.
> + */
> +void i3c_bus_maintenance_lock(struct i3c_bus *bus)
> +{
> +	down_write(&bus->lock);
> +}
> +EXPORT_SYMBOL_GPL(i3c_bus_maintenance_lock);
> +
> +/**
> + * i3c_bus_maintenance_unlock - Release the bus lock after a maintenance
> + *			      operation
> + * @bus: I3C bus to release the lock on
> + *
> + * Should be called when the bus maintenance operation is done. See
> + * i3c_bus_maintenance_lock() for more details on what these
> maintenance
> + * operations are.
> + */
> +void i3c_bus_maintenance_unlock(struct i3c_bus *bus)
> +{
> +	up_write(&bus->lock);
> +}
> +EXPORT_SYMBOL_GPL(i3c_bus_maintenance_unlock);
> +
> +/**
> + * i3c_bus_normaluse_lock - Lock the bus for a normal operation
> + * @bus: I3C bus to take the lock on
> + *
> + * This function takes the bus lock for any operation that is not a
> maintenance
> + * operation (see i3c_bus_maintenance_lock() for a non-exhaustive list of
> + * maintenance operations). Basically all communications with I3C devices
> are
> + * normal operations (HDR, SDR transfers or CCC commands that do not
> change bus
> + * state or I3C dynamic address).
> + *
> + * Note that this lock is not guaranteeing serialization of normal
operations.
> + * In other words, transfer requests passed to the I3C master can be
> submitted
> + * in parallel and I3C master drivers have to use their own locking to
make
> + * sure two different communications are not inter-mixed, or access to
the
> + * output/input queue is not done while the engine is busy.
> + */
> +void i3c_bus_normaluse_lock(struct i3c_bus *bus)
> +{
> +	down_read(&bus->lock);
> +}
> +EXPORT_SYMBOL_GPL(i3c_bus_normaluse_lock);
> +
> +/**
> + * i3c_bus_normaluse_unlock - Release the bus lock after a normal
> operation
> + * @bus: I3C bus to release the lock on
> + *
> + * Should be called when a normal operation is done. See
> + * i3c_bus_normaluse_lock() for more details on what these normal
> operations
> + * are.
> + */
> +void i3c_bus_normaluse_unlock(struct i3c_bus *bus)
> +{
> +	up_read(&bus->lock);
> +}
> +EXPORT_SYMBOL_GPL(i3c_bus_normaluse_unlock);
> +
> +static ssize_t bcr_show(struct device *dev,
> +			struct device_attribute *da,
> +			char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cdev->bus);
> +	ret = sprintf(buf, "%x\n", i3cdev->desc->info.bcr);
> +	i3c_bus_normaluse_unlock(i3cdev->bus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(bcr);
> +
> +static ssize_t dcr_show(struct device *dev,
> +			struct device_attribute *da,
> +			char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cdev->bus);
> +	ret = sprintf(buf, "%x\n", i3cdev->desc->info.dcr);
> +	i3c_bus_normaluse_unlock(i3cdev->bus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(dcr);
> +
> +static ssize_t pid_show(struct device *dev,
> +			struct device_attribute *da,
> +			char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cdev->bus);
> +	ret = sprintf(buf, "%llx\n", i3cdev->desc->info.pid);
> +	i3c_bus_normaluse_unlock(i3cdev->bus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(pid);
> +
> +static ssize_t dynamic_address_show(struct device *dev,
> +				    struct device_attribute *da,
> +				    char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cdev->bus);
> +	ret = sprintf(buf, "%02x\n", i3cdev->desc->info.dyn_addr);
> +	i3c_bus_normaluse_unlock(i3cdev->bus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(dynamic_address);
> +
> +static const char * const hdrcap_strings[] = {
> +	"hdr-ddr", "hdr-tsp", "hdr-tsl",
> +};
> +
> +static ssize_t hdrcap_show(struct device *dev,
> +			   struct device_attribute *da,
> +			   char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	ssize_t offset = 0, ret;
> +	unsigned long caps;
> +	int mode;
> +
> +	i3c_bus_normaluse_lock(i3cdev->bus);
> +	caps = i3cdev->desc->info.hdr_cap;
> +	for_each_set_bit(mode, &caps, 8) {
> +		if (mode >= ARRAY_SIZE(hdrcap_strings))
> +			break;
> +
> +		if (!hdrcap_strings[mode])
> +			continue;
> +
> +		ret = sprintf(buf + offset, offset ? " %s" : "%s",
> +			      hdrcap_strings[mode]);
> +		if (ret < 0)
> +			goto out;
> +
> +		offset += ret;
> +	}
> +
> +	ret = sprintf(buf + offset, "\n");
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = offset + ret;
> +
> +out:
> +	i3c_bus_normaluse_unlock(i3cdev->bus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(hdrcap);
> +
> +static struct attribute *i3c_device_attrs[] = {
> +	&dev_attr_bcr.attr,
> +	&dev_attr_dcr.attr,
> +	&dev_attr_pid.attr,
> +	&dev_attr_dynamic_address.attr,
> +	&dev_attr_hdrcap.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(i3c_device);
> +
> +static int i3c_device_uevent(struct device *dev, struct kobj_uevent_env
> *env)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_device_info devinfo;
> +	u16 manuf, part, ext;
> +
> +	i3c_device_get_info(i3cdev, &devinfo);
> +	manuf = I3C_PID_MANUF_ID(devinfo.pid);
> +	part = I3C_PID_PART_ID(devinfo.pid);
> +	ext = I3C_PID_EXTRA_INFO(devinfo.pid);
> +
> +	if (I3C_PID_RND_LOWER_32BITS(devinfo.pid))
> +		return add_uevent_var(env,
> "MODALIAS=i3c:dcr%02Xmanuf%04X",
> +				      devinfo.dcr, manuf);
> +
> +	return add_uevent_var(env,
> +
> "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04xext%04x",
> +			      devinfo.dcr, manuf, part, ext);
> +}
> +
> +const struct device_type i3c_device_type = {
> +	.groups	= i3c_device_groups,
> +	.uevent = i3c_device_uevent,
> +};
> +
> +const struct device_type i3c_master_type = {
> +	.groups	= i3c_device_groups,
> +};
> +
> +static const struct i3c_device_id *
> +i3c_device_match_id(struct i3c_device *i3cdev,
> +		    const struct i3c_device_id *id_table)
> +{
> +	struct i3c_device_info devinfo;
> +	const struct i3c_device_id *id;
> +
> +	i3c_device_get_info(i3cdev, &devinfo);
> +
> +	/*
> +	 * The lower 32bits of the provisional ID is just filled with a
random
> +	 * value, try to match using DCR info.
> +	 */
> +	if (!I3C_PID_RND_LOWER_32BITS(devinfo.pid)) {
> +		u16 manuf = I3C_PID_MANUF_ID(devinfo.pid);
> +		u16 part = I3C_PID_PART_ID(devinfo.pid);
> +		u16 ext_info = I3C_PID_EXTRA_INFO(devinfo.pid);
> +
> +		/* First try to match by manufacturer/part ID. */
> +		for (id = id_table; id->match_flags != 0; id++) {
> +			if ((id->match_flags &
> I3C_MATCH_MANUF_AND_PART) !=
> +			    I3C_MATCH_MANUF_AND_PART)
> +				continue;
> +
> +			if (manuf != id->manuf_id || part != id->part_id)
> +				continue;
> +
> +			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> +			    ext_info != id->extra_info)
> +				continue;
> +
> +			return id;
> +		}
> +	}
> +
> +	/* Fallback to DCR match. */
> +	for (id = id_table; id->match_flags != 0; id++) {
> +		if ((id->match_flags & I3C_MATCH_DCR) &&
> +		    id->dcr == devinfo.dcr)
> +			return id;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int i3c_device_match(struct device *dev, struct device_driver
*drv)
> +{
> +	struct i3c_device *i3cdev;
> +	struct i3c_driver *i3cdrv;
> +
> +	if (dev->type != &i3c_device_type)
> +		return 0;
> +
> +	i3cdev = dev_to_i3cdev(dev);
> +	i3cdrv = drv_to_i3cdrv(drv);
> +	if (i3c_device_match_id(i3cdev, i3cdrv->id_table))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int i3c_device_probe(struct device *dev)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
> +
> +	return driver->probe(i3cdev);
> +}
> +
> +static int i3c_device_remove(struct device *dev)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
> +	int ret;
> +
> +	ret = driver->remove(i3cdev);
> +	if (ret)
> +		return ret;
> +
> +	i3c_device_free_ibi(i3cdev);
> +
> +	return ret;
> +}
> +
> +struct bus_type i3c_bus_type = {
> +	.name = "i3c",
> +	.match = i3c_device_match,
> +	.probe = i3c_device_probe,
> +	.remove = i3c_device_remove,
> +};
> +
> +enum i3c_addr_slot_status i3c_bus_get_addr_slot_status(struct i3c_bus
> *bus,
> +						       u16 addr)
> +{
> +	int status, bitpos = addr * 2;
> +
> +	if (addr > I2C_MAX_ADDR)
> +		return I3C_ADDR_SLOT_RSVD;
> +
> +	status = bus->addrslots[bitpos / BITS_PER_LONG];
> +	status >>= bitpos % BITS_PER_LONG;
> +
> +	return status & I3C_ADDR_SLOT_STATUS_MASK;
> +}
> +
> +void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> +				  enum i3c_addr_slot_status status)
> +{
> +	int bitpos = addr * 2;
> +	unsigned long *ptr;
> +
> +	if (addr > I2C_MAX_ADDR)
> +		return;
> +
> +	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
> +	*ptr &= ~(I3C_ADDR_SLOT_STATUS_MASK << (bitpos %
> BITS_PER_LONG));
> +	*ptr |= status << (bitpos % BITS_PER_LONG);
> +}
> +
> +bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
> +{
> +	enum i3c_addr_slot_status status;
> +
> +	status = i3c_bus_get_addr_slot_status(bus, addr);
> +
> +	return status == I3C_ADDR_SLOT_FREE;
> +}
> +
> +int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
> +{
> +	enum i3c_addr_slot_status status;
> +	u8 addr;
> +
> +	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> +		status = i3c_bus_get_addr_slot_status(bus, addr);
> +		if (status == I3C_ADDR_SLOT_FREE)
> +			return addr;
> +	}
> +
> +	return -ENOMEM;
> +}
> +
> +static void i3c_bus_init_addrslots(struct i3c_bus *bus)
> +{
> +	int i;
> +
> +	/* Addresses 0 to 7 are reserved. */
> +	for (i = 0; i < 8; i++)
> +		i3c_bus_set_addr_slot_status(bus, i,
> I3C_ADDR_SLOT_RSVD);
> +
> +	/*
> +	 * Reserve broadcast address and all addresses that might collide
> +	 * with the broadcast address when facing a single bit error.
> +	 */
> +	i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR,
> +				     I3C_ADDR_SLOT_RSVD);
> +	for (i = 0; i < 7; i++)
> +		i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR ^
> BIT(i),
> +					     I3C_ADDR_SLOT_RSVD);
> +}
> +
> +static const char * const i3c_bus_mode_strings[] = {
> +	[I3C_BUS_MODE_PURE] = "pure",
> +	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
> +	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
> +};
> +
> +static ssize_t mode_show(struct device *dev,
> +			 struct device_attribute *da,
> +			 char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cbus);
> +	if (i3cbus->mode < 0 ||
> +	    i3cbus->mode > ARRAY_SIZE(i3c_bus_mode_strings) ||
> +	    !i3c_bus_mode_strings[i3cbus->mode])
> +		ret = sprintf(buf, "unknown\n");
> +	else
> +		ret = sprintf(buf, "%s\n", i3c_bus_mode_strings[i3cbus-
> >mode]);
> +	i3c_bus_normaluse_unlock(i3cbus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(mode);
> +
> +static ssize_t current_master_show(struct device *dev,
> +				   struct device_attribute *da,
> +				   char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cbus);
> +	ret = sprintf(buf, "%d-%llx\n", i3cbus->id,
> +		      i3cbus->cur_master->info.pid);
> +	i3c_bus_normaluse_unlock(i3cbus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(current_master);
> +
> +static ssize_t i3c_scl_frequency_show(struct device *dev,
> +				      struct device_attribute *da,
> +				      char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cbus);
> +	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i3c);
> +	i3c_bus_normaluse_unlock(i3cbus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(i3c_scl_frequency);
> +
> +static ssize_t i2c_scl_frequency_show(struct device *dev,
> +				      struct device_attribute *da,
> +				      char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cbus);
> +	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i2c);
> +	i3c_bus_normaluse_unlock(i3cbus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(i2c_scl_frequency);
> +
> +static struct attribute *i3c_busdev_attrs[] = {
> +	&dev_attr_mode.attr,
> +	&dev_attr_current_master.attr,
> +	&dev_attr_i3c_scl_frequency.attr,
> +	&dev_attr_i2c_scl_frequency.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(i3c_busdev);
> +
> +static void i3c_busdev_release(struct device *dev)
> +{
> +	struct i3c_bus *bus = container_of(dev, struct i3c_bus, dev);
> +
> +	WARN_ON(!list_empty(&bus->devs.i2c) || !list_empty(&bus-
> >devs.i3c));
> +
> +	mutex_lock(&i3c_core_lock);
> +	idr_remove(&i3c_bus_idr, bus->id);
> +	mutex_unlock(&i3c_core_lock);
> +
> +	of_node_put(bus->dev.of_node);
> +	kfree(bus);
> +}
> +
> +static const struct device_type i3c_busdev_type = {
> +	.groups	= i3c_busdev_groups,
> +};
> +
> +void i3c_bus_unref(struct i3c_bus *bus)
> +{
> +	put_device(&bus->dev);
> +}
> +
> +struct i3c_bus *i3c_bus_create(struct device *parent)
> +{
> +	struct i3c_bus *i3cbus;
> +	int ret;
> +
> +	i3cbus = kzalloc(sizeof(*i3cbus), GFP_KERNEL);
> +	if (!i3cbus)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init_rwsem(&i3cbus->lock);
> +	INIT_LIST_HEAD(&i3cbus->devs.i2c);
> +	INIT_LIST_HEAD(&i3cbus->devs.i3c);
> +	i3c_bus_init_addrslots(i3cbus);
> +	i3cbus->mode = I3C_BUS_MODE_PURE;
> +	i3cbus->dev.parent = parent;
> +	i3cbus->dev.of_node = of_node_get(parent->of_node);
> +	i3cbus->dev.bus = &i3c_bus_type;
> +	i3cbus->dev.type = &i3c_busdev_type;
> +	i3cbus->dev.release = i3c_busdev_release;
> +
> +	mutex_lock(&i3c_core_lock);
> +	ret = idr_alloc(&i3c_bus_idr, i3cbus, 0, 0, GFP_KERNEL);
> +	mutex_unlock(&i3c_core_lock);
> +	if (ret < 0)
> +		goto err_free_bus;
> +
> +	i3cbus->id = ret;
> +	device_initialize(&i3cbus->dev);
> +
> +	return i3cbus;
> +
> +err_free_bus:
> +	kfree(i3cbus);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +void i3c_bus_unregister(struct i3c_bus *bus)
> +{
> +	device_unregister(&bus->dev);
> +}
> +
> +int i3c_bus_register(struct i3c_bus *i3cbus)
> +{
> +	struct i2c_dev_desc *desc;
> +
> +	i3c_bus_for_each_i2cdev(i3cbus, desc) {
> +		switch (desc->boardinfo->lvr & I3C_LVR_I2C_INDEX_MASK) {
> +		case I3C_LVR_I2C_INDEX(0):
> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_FAST)
> +				i3cbus->mode =
> I3C_BUS_MODE_MIXED_FAST;
> +			break;
> +
> +		case I3C_LVR_I2C_INDEX(1):
> +		case I3C_LVR_I2C_INDEX(2):
> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_SLOW)
> +				i3cbus->mode =
> I3C_BUS_MODE_MIXED_SLOW;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!i3cbus->scl_rate.i3c)
> +		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> +
> +	if (!i3cbus->scl_rate.i2c) {
> +		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
> +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
> +		else
> +			i3cbus->scl_rate.i2c =
> I3C_BUS_I2C_FM_PLUS_SCL_RATE;
> +	}
> +
> +	/*
> +	 * I3C/I2C frequency may have been overridden, check that user-
> provided
> +	 * values are not exceeding max possible frequency.
> +	 */
> +	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
> +	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE) {
> +		return -EINVAL;
> +	}
> +
> +	dev_set_name(&i3cbus->dev, "i3c-%d", i3cbus->id);
> +
> +	return device_add(&i3cbus->dev);
> +}
> +
> +static int __init i3c_init(void)
> +{
> +	return bus_register(&i3c_bus_type);
> +}
> +subsys_initcall(i3c_init);
> +
> +static void __exit i3c_exit(void)
> +{
> +	idr_destroy(&i3c_bus_idr);
> +	bus_unregister(&i3c_bus_type);
> +}
> +module_exit(i3c_exit);
> +
> +MODULE_AUTHOR("Boris Brezillon <boris.brezillon@bootlin.com>");
> +MODULE_DESCRIPTION("I3C core");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> new file mode 100644
> index 000000000000..69cc040c3a1c
> --- /dev/null
> +++ b/drivers/i3c/device.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon <boris.brezillon@bootlin.com>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bug.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +
> +#include "internals.h"
> +
> +/**
> + * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to
a
> + *				specific device
> + *
> + * @dev: device with which the transfers should be done
> + * @xfers: array of transfers
> + * @nxfers: number of transfers
> + *
> + * Initiate one or several private SDR transfers with @dev.
> + *
> + * This function can sleep and thus cannot be called in atomic context.
> + *
> + * Return: 0 in case of success, a negative error core otherwise.
> + */
> +int i3c_device_do_priv_xfers(struct i3c_device *dev,
> +			     struct i3c_priv_xfer *xfers,
> +			     int nxfers)
> +{
> +	int ret, i;
> +
> +	if (nxfers < 1)
> +		return 0;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		if (!xfers[i].len || !xfers[i].data.in)
> +			return -EINVAL;
> +	}
> +
> +	i3c_bus_normaluse_lock(dev->bus);
> +	ret = i3c_dev_do_priv_xfers_locked(dev->desc, xfers, nxfers);
> +	i3c_bus_normaluse_unlock(dev->bus);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
> +
> +/**
> + * i3c_device_get_info() - get I3C device information
> + *
> + * @dev: device we want information on
> + * @info: the information object to fill in
> + *
> + * Retrieve I3C dev info.
> + */
> +void i3c_device_get_info(struct i3c_device *dev,
> +			 struct i3c_device_info *info)
> +{
> +	if (!info)
> +		return;
> +
> +	i3c_bus_normaluse_lock(dev->bus);
> +	if (dev->desc)
> +		*info = dev->desc->info;
> +	i3c_bus_normaluse_unlock(dev->bus);
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_get_info);
> +
> +/**
> + * i3c_device_disable_ibi() - Disable IBIs coming from a specific device
> + * @dev: device on which IBIs should be disabled
> + *
> + * This function disable IBIs coming from a specific device and wait for
> + * all pending IBIs to be processed.
> + *
> + * Return: 0 in case of success, a negative error core otherwise.
> + */
> +int i3c_device_disable_ibi(struct i3c_device *dev)
> +{
> +	int ret = -ENOENT;
> +
> +	i3c_bus_normaluse_lock(dev->bus);
> +	if (dev->desc) {
> +		mutex_lock(&dev->desc->ibi_lock);
> +		ret = i3c_dev_disable_ibi_locked(dev->desc);
> +		mutex_unlock(&dev->desc->ibi_lock);
> +	}
> +	i3c_bus_normaluse_unlock(dev->bus);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_disable_ibi);
> +
> +/**
> + * i3c_device_enable_ibi() - Enable IBIs coming from a specific device
> + * @dev: device on which IBIs should be enabled
> + *
> + * This function enable IBIs coming from a specific device and wait for
> + * all pending IBIs to be processed. This should be called on a device
> + * where i3c_device_request_ibi() has succeeded.
> + *
> + * Note that IBIs from this device might be received before this function
> + * returns to its caller.
> + *
> + * Return: 0 in case of success, a negative error core otherwise.
> + */
> +int i3c_device_enable_ibi(struct i3c_device *dev)
> +{
> +	int ret = -ENOENT;
> +
> +	i3c_bus_normaluse_lock(dev->bus);
> +	if (dev->desc) {
> +		mutex_lock(&dev->desc->ibi_lock);
> +		ret = i3c_dev_enable_ibi_locked(dev->desc);
> +		mutex_unlock(&dev->desc->ibi_lock);
> +	}
> +	i3c_bus_normaluse_unlock(dev->bus);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_enable_ibi);
> +
> +/**
> + * i3c_device_request_ibi() - Request an IBI
> + * @dev: device for which we should enable IBIs
> + * @req: setup requested for this IBI
> + *
> + * This function is responsible for pre-allocating all resources needed
to
> + * process IBIs coming from @dev. When this function returns, the IBI is
not
> + * enabled until i3c_device_enable_ibi() is called.
> + *
> + * Return: 0 in case of success, a negative error core otherwise.
> + */
> +int i3c_device_request_ibi(struct i3c_device *dev,
> +			   const struct i3c_ibi_setup *req)
> +{
> +	int ret = -ENOENT;
> +
> +	if (!req->handler || !req->num_slots)
> +		return -EINVAL;
> +
> +	i3c_bus_normaluse_lock(dev->bus);
> +	if (dev->desc) {
> +		mutex_lock(&dev->desc->ibi_lock);
> +		ret = i3c_dev_request_ibi_locked(dev->desc, req);
> +		mutex_unlock(&dev->desc->ibi_lock);
> +	}
> +	i3c_bus_normaluse_unlock(dev->bus);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_request_ibi);
> +
> +/**
> + * i3c_device_free_ibi() - Free all resources needed for IBI handling
> + * @dev: device on which you want to release IBI resources
> + *
> + * This function is responsible for de-allocating resources previously
> + * allocated by i3c_device_request_ibi(). It should be called after
disabling
> + * IBIs with i3c_device_disable_ibi().
> + */
> +void i3c_device_free_ibi(struct i3c_device *dev)
> +{
> +	i3c_bus_normaluse_lock(dev->bus);
> +	if (dev->desc) {
> +		mutex_lock(&dev->desc->ibi_lock);
> +		i3c_dev_free_ibi_locked(dev->desc);
> +		mutex_unlock(&dev->desc->ibi_lock);
> +	}
> +	i3c_bus_normaluse_unlock(dev->bus);
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
> +
> +/**
> + * i3cdev_to_dev() - Returns the device embedded in @i3cdev
> + * @i3cdev: I3C device
> + *
> + * Return: a pointer to a device object.
> + */
> +struct device *i3cdev_to_dev(struct i3c_device *i3cdev)
> +{
> +	return &i3cdev->dev;
> +}
> +EXPORT_SYMBOL_GPL(i3cdev_to_dev);
> +
> +/**
> + * dev_to_i3cdev() - Returns the I3C device containing @dev
> + * @dev: device object
> + *
> + * Return: a pointer to an I3C device object.
> + */
> +struct i3c_device *dev_to_i3cdev(struct device *dev)
> +{
> +	return container_of(dev, struct i3c_device, dev);
> +}
> +EXPORT_SYMBOL_GPL(dev_to_i3cdev);
> +
> +/**
> + * i3c_driver_register_with_owner() - register an I3C device driver
> + *
> + * @drv: driver to register
> + * @owner: module that owns this driver
> + *
> + * Register @drv to the core.
> + *
> + * Return: 0 in case of success, a negative error core otherwise.
> + */
> +int i3c_driver_register_with_owner(struct i3c_driver *drv, struct module
> *owner)
> +{
> +	drv->driver.owner = owner;
> +	drv->driver.bus = &i3c_bus_type;
> +
> +	return driver_register(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(i3c_driver_register_with_owner);
> +
> +/**
> + * i3c_driver_unregister() - unregister an I3C device driver
> + *
> + * @drv: driver to unregister
> + *
> + * Unregister @drv.
> + */
> +void i3c_driver_unregister(struct i3c_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(i3c_driver_unregister);
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> new file mode 100644
> index 000000000000..ced88435466f
> --- /dev/null
> +++ b/drivers/i3c/internals.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon <boris.brezillon@bootlin.com>
> + */
> +
> +#ifndef I3C_INTERNALS_H
> +#define I3C_INTERNALS_H
> +
> +#include <linux/i3c/master.h>
> +
> +extern struct bus_type i3c_bus_type;
> +extern const struct device_type i3c_master_type;
> +extern const struct device_type i3c_device_type;
> +
> +void i3c_bus_unref(struct i3c_bus *bus);
> +struct i3c_bus *i3c_bus_create(struct device *parent);
> +void i3c_bus_unregister(struct i3c_bus *bus);
> +int i3c_bus_register(struct i3c_bus *i3cbus);
> +int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr);
> +bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr);
> +void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> +				  enum i3c_addr_slot_status status);
> +enum i3c_addr_slot_status i3c_bus_get_addr_slot_status(struct i3c_bus
> *bus,
> +						       u16 addr);
> +
> +int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
> +				 struct i3c_priv_xfer *xfers,
> +				 int nxfers);
> +int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);
> +int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
> +int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
> +			       const struct i3c_ibi_setup *req);
> +void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
> +#endif /* I3C_INTERNAL_H */
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> new file mode 100644
> index 000000000000..d04e9ff9c850
> --- /dev/null
> +++ b/drivers/i3c/master.c
> @@ -0,0 +1,2058 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon <boris.brezillon@bootlin.com>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bug.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +#include "internals.h"
> +
> +static struct i3c_master_controller *
> +i2c_adapter_to_i3c_master(struct i2c_adapter *adap)
> +{
> +	return container_of(adap, struct i3c_master_controller, i2c);
> +}
> +
> +static struct i2c_adapter *
> +i3c_master_to_i2c_adapter(struct i3c_master_controller *master)
> +{
> +	return &master->i2c;
> +}
> +
> +static void i3c_master_free_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	kfree(dev);
> +}
> +
> +static struct i2c_dev_desc *
> +i3c_master_alloc_i2c_dev(struct i3c_master_controller *master,
> +			 const struct i2c_dev_boardinfo *boardinfo)
> +{
> +	struct i2c_dev_desc *dev;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev->common.master = master;
> +	dev->boardinfo = boardinfo;
> +
> +	return dev;
> +}
> +
> +static int i3c_master_send_ccc_cmd_locked(struct i3c_master_controller
> *master,
> +					  struct i3c_ccc_cmd *cmd)
> +{
> +	int ret;
> +
> +	if (!cmd || !master)
> +		return -EINVAL;
> +
> +	if (WARN_ON(master->init_done &&
> +		    !rwsem_is_locked(&master->bus->lock)))
> +		return -EINVAL;
> +
> +	if (!master->ops->send_ccc_cmd)
> +		return -ENOTSUPP;
> +
> +	if ((cmd->id & I3C_CCC_DIRECT) && (!cmd->dests || !cmd->ndests))
> +		return -EINVAL;
> +
> +	if (master->ops->supports_ccc_cmd &&
> +	    !master->ops->supports_ccc_cmd(master, cmd))
> +		return -ENOTSUPP;
> +
> +	ret = master->ops->send_ccc_cmd(master, cmd);
> +	if (ret) {
> +		if (cmd->err != I3C_ERROR_UNKNOWN)
> +			return cmd->err;
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct i2c_dev_desc *
> +i3c_master_find_i2c_dev_by_addr(const struct i3c_master_controller
> *master,
> +				u16 addr)
> +{
> +	struct i2c_dev_desc *dev;
> +
> +	i3c_bus_for_each_i2cdev(master->bus, dev) {
> +		if (dev->boardinfo->base.addr == addr)
> +			return dev;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * i3c_master_get_free_addr() - get a free address on the bus
> + * @master: I3C master object
> + * @start_addr: where to start searching
> + *
> + * This function must be called with the bus lock held in write mode.
> + *
> + * Return: the first free address starting at @start_addr (included) or -
> ENOMEM
> + * if there's no more address available.
> + */
> +int i3c_master_get_free_addr(struct i3c_master_controller *master,
> +			     u8 start_addr)
> +{
> +	return i3c_bus_get_free_addr(master->bus, start_addr);
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_get_free_addr);
> +
> +static void i3c_device_release(struct device *dev)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +
> +	WARN_ON(i3cdev->desc);
> +
> +	of_node_put(i3cdev->dev.of_node);
> +	kfree(i3cdev);
> +}
> +
> +static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	kfree(dev);
> +}
> +
> +static struct i3c_dev_desc *
> +i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
> +			 const struct i3c_device_info *info)
> +{
> +	struct i3c_dev_desc *dev;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev->common.master = master;
> +	dev->info = *info;
> +	mutex_init(&dev->ibi_lock);
> +
> +	return dev;
> +}
> +
> +static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
> +				    u8 addr)
> +{
> +	struct i3c_ccc_cmd_dest dest = { };
> +	struct i3c_ccc_cmd cmd = { };
> +	enum i3c_addr_slot_status addrstat;
> +
> +	if (!master)
> +		return -EINVAL;
> +
> +	addrstat = i3c_bus_get_addr_slot_status(master->bus, addr);
> +	if (addr != I3C_BROADCAST_ADDR && addrstat !=
> I3C_ADDR_SLOT_I3C_DEV)
> +		return -EINVAL;
> +
> +	dest.addr = addr;
> +	cmd.dests = &dest;
> +	cmd.ndests = 1;
> +	cmd.rnw = false;
> +	cmd.id = I3C_CCC_RSTDAA(addr == I3C_BROADCAST_ADDR);
> +
> +	return i3c_master_send_ccc_cmd_locked(master, &cmd);
> +}
> +
> +/**
> + * i3c_master_entdaa_locked() - start a DAA (Dynamic Address Assignment)
> + *				procedure
> + * @master: master used to send frames on the bus
> + *
> + * Send a ENTDAA CCC command to start a DAA procedure.
> + *
> + * Note that this function only sends the ENTDAA CCC command, all the
> logic
> + * behind dynamic address assignment has to be handled in the I3C master
> + * driver.
> + *
> + * This function must be called with the bus lock held in write mode.
> + *
> + * Return: 0 in case of success, a positive I3C error code if the error
is
> + * one of the official Mx error codes, and a negative error code
otherwise.
> + */
> +int i3c_master_entdaa_locked(struct i3c_master_controller *master)
> +{
> +	struct i3c_ccc_cmd_dest dest = { };
> +	struct i3c_ccc_cmd cmd = { };
> +
> +	dest.addr = I3C_BROADCAST_ADDR;
> +	cmd.dests = &dest;
> +	cmd.ndests = 1;
> +	cmd.rnw = false;
> +	cmd.id = I3C_CCC_ENTDAA;
> +
> +	return i3c_master_send_ccc_cmd_locked(master, &cmd);
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_entdaa_locked);
> +
> +/**
> + * i3c_master_disec_locked() - send a DISEC CCC command
> + * @master: master used to send frames on the bus
> + * @addr: a valid I3C slave address or %I3C_BROADCAST_ADDR
> + * @evts: events to disable
> + *
> + * Send a DISEC CCC command to disable some or all events coming from a
> + * specific slave, or all devices if @addr is %I3C_BROADCAST_ADDR.
> + *
> + * This function must be called with the bus lock held in write mode.
> + *
> + * Return: 0 in case of success, a positive I3C error code if the error
is
> + * one of the official Mx error codes, and a negative error code
otherwise.
> + */
> +int i3c_master_disec_locked(struct i3c_master_controller *master, u8
addr,
> +			    u8 evts)
> +{
> +	struct i3c_ccc_events events = {
> +		.events = evts,
> +	};
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = addr,
> +		.payload.len = sizeof(events),
> +		.payload.data = &events,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.id = I3C_CCC_DISEC(addr == I3C_BROADCAST_ADDR),
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +
> +	return i3c_master_send_ccc_cmd_locked(master, &cmd);
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_disec_locked);
> +
> +/**
> + * i3c_master_enec_locked() - send an ENEC CCC command
> + * @master: master used to send frames on the bus
> + * @addr: a valid I3C slave address or %I3C_BROADCAST_ADDR
> + * @evts: events to disable
> + *
> + * Sends an ENEC CCC command to enable some or all events coming from a
> + * specific slave, or all devices if @addr is %I3C_BROADCAST_ADDR.
> + *
> + * This function must be called with the bus lock held in write mode.
> + *
> + * Return: 0 in case of success, a positive I3C error code if the error
is
> + * one of the official Mx error codes, and a negative error code
otherwise.
> + */
> +int i3c_master_enec_locked(struct i3c_master_controller *master, u8 addr,
> +			   u8 evts)
> +{
> +	struct i3c_ccc_events events = {
> +		.events = evts,
> +	};
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = addr,
> +		.payload.len = sizeof(events),
> +		.payload.data = &events,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.id = I3C_CCC_ENEC(addr == I3C_BROADCAST_ADDR),
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +
> +	return i3c_master_send_ccc_cmd_locked(master, &cmd);
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_enec_locked);
> +
> +/**
> + * i3c_master_defslvs_locked() - send a DEFSLVS CCC command
> + * @master: master used to send frames on the bus
> + *
> + * Send a DEFSLVS CCC command containing all the devices known to the
> @master.
> + * This is useful when you have secondary masters on the bus to propagate
> + * device information.
> + *
> + * This should be called after all I3C devices have been discovered (in
other
> + * words, after the DAA procedure has finished) and instantiated in
> + * &i3c_master_controller_ops->bus_init().
> + * It should also be called if a master ACKed an Hot-Join request and
> assigned
> + * a dynamic address to the device joining the bus.
> + *
> + * This function must be called with the bus lock held in write mode.
> + *
> + * Return: 0 in case of success, a positive I3C error code if the error
is
> + * one of the official Mx error codes, and a negative error code
otherwise.
> + */
> +int i3c_master_defslvs_locked(struct i3c_master_controller *master)
> +{
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = I3C_BROADCAST_ADDR,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.id = I3C_CCC_DEFSLVS,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +	struct i3c_ccc_defslvs *defslvs;
> +	struct i3c_ccc_dev_desc *desc;
> +	struct i3c_dev_desc *i3cdev;
> +	struct i2c_dev_desc *i2cdev;
> +	struct i3c_bus *bus;
> +	bool send = false;
> +	int ndevs = 0, ret;
> +
> +	if (!master)
> +		return -EINVAL;
> +
> +	bus = i3c_master_get_bus(master);
> +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
> +		ndevs++;
> +
> +		if (i3cdev == master->this)
> +			continue;
> +
> +		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) ==
> +		    I3C_BCR_I3C_MASTER)
> +			send = true;
> +	}
> +
> +	/* No other master on the bus, skip DEFSLVS. */
> +	if (!send)
> +		return 0;
> +
> +	i3c_bus_for_each_i2cdev(bus, i2cdev)
> +		ndevs++;
> +
> +	dest.payload.len = sizeof(*defslvs) +
> +			   ((ndevs - 1) * sizeof(struct i3c_ccc_dev_desc));
> +	defslvs = kzalloc(dest.payload.len, GFP_KERNEL);
> +	if (!defslvs)
> +		return -ENOMEM;
> +
> +	dest.payload.data = defslvs;
> +
> +	defslvs->count = ndevs;
> +	defslvs->master.bcr = master->this->info.bcr;
> +	defslvs->master.dcr = master->this->info.dcr;
> +	defslvs->master.dyn_addr = master->this->info.dyn_addr << 1;
> +	defslvs->master.static_addr = I3C_BROADCAST_ADDR << 1;
> +
> +	desc = defslvs->slaves;
> +	i3c_bus_for_each_i2cdev(bus, i2cdev) {
> +		desc->lvr = i2cdev->boardinfo->lvr;
> +		desc->static_addr = i2cdev->boardinfo->base.addr << 1;
> +		desc++;
> +	}
> +
> +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
> +		/* Skip the I3C dev representing this master. */
> +		if (i3cdev == master->this)
> +			continue;
> +
> +		desc->bcr = i3cdev->info.bcr;
> +		desc->dcr = i3cdev->info.dcr;
> +		desc->dyn_addr = i3cdev->info.dyn_addr << 1;
> +		desc->static_addr = i3cdev->info.static_addr << 1;
> +		desc++;
> +	}
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	kfree(defslvs);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_defslvs_locked);
> +
> +static int i3c_master_setdasa_locked(struct i3c_master_controller
*master,
> +				     u8 static_addr, u8 dyn_addr)
> +{
> +	struct i3c_ccc_setda setda = {
> +		.addr = dyn_addr << 1,
> +	};
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = static_addr,
> +		.payload.len = sizeof(setda),
> +		.payload.data = &setda,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.rnw = false,
> +		.id = I3C_CCC_SETDASA,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +
> +	if (!dyn_addr || !static_addr)
> +		return -EINVAL;
> +
> +	return i3c_master_send_ccc_cmd_locked(master, &cmd);
> +}
> +
> +static int i3c_master_setnewda_locked(struct i3c_master_controller
> *master,
> +				      u8 oldaddr, u8 newaddr)
> +{
> +	struct i3c_ccc_setda setda = {
> +		.addr = newaddr << 1,
> +	};
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = oldaddr,
> +		.payload.len = sizeof(setda),
> +		.payload.data = &setda,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.rnw = false,
> +		.id = I3C_CCC_SETNEWDA,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +
> +	if (!oldaddr || !newaddr)
> +		return -EINVAL;
> +
> +	return i3c_master_send_ccc_cmd_locked(master, &cmd);
> +}
> +
> +static int i3c_master_getmrl_locked(struct i3c_master_controller *master,
> +				    struct i3c_device_info *info)
> +{
> +	struct i3c_ccc_mrl mrl;
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = info->dyn_addr,
> +		.payload.len = sizeof(mrl),
> +		.payload.data = &mrl,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.rnw = true,
> +		.id = I3C_CCC_GETMRL,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +	int ret;
> +
> +	/*
> +	 * When the device does not have IBI payload GETMRL only returns 2
> +	 * bytes of data.
> +	 */
> +	if (!(info->bcr & I3C_BCR_IBI_PAYLOAD))
> +		dest.payload.len -= 1;
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	if (dest.payload.len != sizeof(mrl))
> +		return -EIO;
> +
> +	info->max_read_len = be16_to_cpu(mrl.read_len);
> +
> +	if (info->bcr & I3C_BCR_IBI_PAYLOAD)
> +		info->max_ibi_len = mrl.ibi_len;
> +
> +	return 0;
> +}
> +
> +static int i3c_master_getmwl_locked(struct i3c_master_controller *master,
> +				    struct i3c_device_info *info)
> +{
> +	struct i3c_ccc_mwl mwl;
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = info->dyn_addr,
> +		.payload.len = sizeof(mwl),
> +		.payload.data = &mwl,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.rnw = true,
> +		.id = I3C_CCC_GETMWL,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +	int ret;
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	if (dest.payload.len != sizeof(mwl))
> +		return -EIO;
> +
> +	info->max_write_len = be16_to_cpu(mwl.len);
> +
> +	return 0;
> +}
> +
> +static int i3c_master_getmxds_locked(struct i3c_master_controller
> *master,
> +				     struct i3c_device_info *info)
> +{
> +	struct i3c_ccc_getmxds getmaxds;
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = info->dyn_addr,
> +		.payload.len = sizeof(getmaxds),
> +		.payload.data = &getmaxds,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.rnw = true,
> +		.id = I3C_CCC_GETMXDS,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +	int ret;
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	if (dest.payload.len != 2 && dest.payload.len != 5)
> +		return -EIO;
> +
> +	info->max_read_ds = getmaxds.maxrd;
> +	info->max_read_ds = getmaxds.maxwr;
> +	if (dest.payload.len == 5)
> +		info->max_read_turnaround = getmaxds.maxrdturn[0] |
> +					    ((u32)getmaxds.maxrdturn[1] <<
8)
> |
> +					    ((u32)getmaxds.maxrdturn[2] <<
> 16);
> +
> +	return 0;
> +}
> +
> +static int i3c_master_gethdrcap_locked(struct i3c_master_controller
> *master,
> +				       struct i3c_device_info *info)
> +{
> +	struct i3c_ccc_gethdrcap gethdrcap;
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = info->dyn_addr,
> +		.payload.len = sizeof(gethdrcap),
> +		.payload.data = &gethdrcap,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.rnw = true,
> +		.id = I3C_CCC_GETHDRCAP,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +	int ret;
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	if (dest.payload.len != 1)
> +		return -EIO;
> +
> +	info->hdr_cap = gethdrcap.modes;
> +
> +	return 0;
> +}
> +
> +static int i3c_master_getpid_locked(struct i3c_master_controller *master,
> +				    struct i3c_device_info *info)
> +{
> +	struct i3c_ccc_getpid getpid;
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = info->dyn_addr,
> +		.payload.len = sizeof(struct i3c_ccc_getpid),
> +		.payload.data = &getpid,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.rnw = true,
> +		.id = I3C_CCC_GETPID,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +	int ret, i;
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	info->pid = 0;
> +	for (i = 0; i < sizeof(getpid.pid); i++) {
> +		int sft = (sizeof(getpid.pid) - i - 1) * 8;
> +
> +		info->pid |= (u64)getpid.pid[i] << sft;
> +	}
> +
> +	return 0;
> +}
> +
> +static int i3c_master_getbcr_locked(struct i3c_master_controller *master,
> +				    struct i3c_device_info *info)
> +{
> +	struct i3c_ccc_getbcr getbcr;
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = info->dyn_addr,
> +		.payload.len = sizeof(struct i3c_ccc_getbcr),
> +		.payload.data = &getbcr,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.rnw = true,
> +		.id = I3C_CCC_GETBCR,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +	int ret;
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	info->bcr = getbcr.bcr;
> +
> +	return 0;
> +}
> +
> +static int i3c_master_getdcr_locked(struct i3c_master_controller *master,
> +				    struct i3c_device_info *info)
> +{
> +	struct i3c_ccc_getdcr getdcr;
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = info->dyn_addr,
> +		.payload.len = sizeof(struct i3c_ccc_getdcr),
> +		.payload.data = &getdcr,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.rnw = true,
> +		.id = I3C_CCC_GETDCR,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +	int ret;
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	info->dcr = getdcr.dcr;
> +
> +	return 0;
> +}
> +
> +static int i3c_master_retrieve_dev_info(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> +	enum i3c_addr_slot_status slot_status;
> +	int ret;
> +
> +	if (!dev->info.dyn_addr)
> +		return -EINVAL;
> +
> +	slot_status = i3c_bus_get_addr_slot_status(master->bus,
> +						   dev->info.dyn_addr);
> +	if (slot_status == I3C_ADDR_SLOT_RSVD ||
> +	    slot_status == I3C_ADDR_SLOT_I2C_DEV)
> +		return -EINVAL;
> +
> +	ret = i3c_master_getpid_locked(master, &dev->info);
> +	if (ret)
> +		return ret;
> +
> +	ret = i3c_master_getbcr_locked(master, &dev->info);
> +	if (ret)
> +		return ret;
> +
> +	ret = i3c_master_getdcr_locked(master, &dev->info);
> +	if (ret)
> +		return ret;
> +
> +	if (dev->info.bcr & I3C_BCR_MAX_DATA_SPEED_LIM) {
> +		ret = i3c_master_getmxds_locked(master, &dev->info);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD)
> +		dev->info.max_ibi_len = 1;
> +
> +	i3c_master_getmrl_locked(master, &dev->info);
> +	i3c_master_getmwl_locked(master, &dev->info);
> +
> +	if (dev->info.bcr & I3C_BCR_HDR_CAP) {
> +		ret = i3c_master_gethdrcap_locked(master, &dev->info);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void i3c_master_put_i3c_addrs(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> +
> +	if (dev->info.static_addr)
> +		i3c_bus_set_addr_slot_status(master->bus,
> +					     dev->info.static_addr,
> +					     I3C_ADDR_SLOT_FREE);
> +
> +	if (dev->info.dyn_addr)
> +		i3c_bus_set_addr_slot_status(master->bus, dev-
> >info.dyn_addr,
> +					     I3C_ADDR_SLOT_FREE);
> +
> +	if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
> +		i3c_bus_set_addr_slot_status(master->bus, dev-
> >info.dyn_addr,
> +					     I3C_ADDR_SLOT_FREE);
> +}
> +
> +static int i3c_master_get_i3c_addrs(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> +	enum i3c_addr_slot_status status;
> +
> +	if (!dev->info.static_addr && !dev->info.dyn_addr)
> +		return 0;
> +
> +	if (dev->info.static_addr) {
> +		status = i3c_bus_get_addr_slot_status(master->bus,
> +
dev->info.static_addr);
> +		if (status != I3C_ADDR_SLOT_FREE)
> +			return -EBUSY;
> +
> +		i3c_bus_set_addr_slot_status(master->bus,
> +					     dev->info.static_addr,
> +					     I3C_ADDR_SLOT_I3C_DEV);
> +	}
> +
> +	/*
> +	 * ->init_dyn_addr should have been reserved before that, so, if
> we're
> +	 * trying to apply a pre-reserved dynamic address, we should not try
> +	 * to reserve the address slot a second time.
> +	 */
> +	if (dev->info.dyn_addr &&
> +	    (!dev->boardinfo ||
> +	     dev->boardinfo->init_dyn_addr != dev->info.dyn_addr)) {
> +		status = i3c_bus_get_addr_slot_status(master->bus,
> +						      dev->info.dyn_addr);
> +		if (status != I3C_ADDR_SLOT_FREE)
> +			goto err_release_static_addr;
> +
> +		i3c_bus_set_addr_slot_status(master->bus, dev-
> >info.dyn_addr,
> +					     I3C_ADDR_SLOT_I3C_DEV);
> +	}
> +
> +	return 0;
> +
> +err_release_static_addr:
> +	if (dev->info.static_addr)
> +		i3c_bus_set_addr_slot_status(master->bus,
> +					     dev->info.static_addr,
> +					     I3C_ADDR_SLOT_FREE);
> +
> +	return -EBUSY;
> +}
> +
> +static int i3c_master_attach_i3c_dev(struct i3c_master_controller
*master,
> +				     struct i3c_dev_desc *dev)
> +{
> +	int ret;
> +
> +	/*
> +	 * We don't attach devices to the controller until they are
> +	 * addressable on the bus.
> +	 */
> +	if (!dev->info.static_addr && !dev->info.dyn_addr)
> +		return 0;
> +
> +	ret = i3c_master_get_i3c_addrs(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Do not attach the master device itself. */
> +	if (master->this != dev && master->ops->attach_i3c_dev) {
> +		ret = master->ops->attach_i3c_dev(dev);
> +		if (ret) {
> +			i3c_master_put_i3c_addrs(dev);
> +			return ret;
> +		}
> +	}
> +
> +	list_add_tail(&dev->common.node, &master->bus->devs.i3c);
> +
> +	return 0;
> +}
> +
> +static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
> +				       u8 old_dyn_addr)
> +{
> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> +	enum i3c_addr_slot_status status;
> +	int ret;
> +
> +	if (dev->info.dyn_addr != old_dyn_addr) {
> +		status = i3c_bus_get_addr_slot_status(master->bus,
> +						      dev->info.dyn_addr);
> +		if (status != I3C_ADDR_SLOT_FREE)
> +			return -EBUSY;
> +		i3c_bus_set_addr_slot_status(master->bus,
> +					     dev->info.dyn_addr,
> +					     I3C_ADDR_SLOT_I3C_DEV);
> +	}
> +
> +	if (master->ops->reattach_i3c_dev) {
> +		ret = master->ops->reattach_i3c_dev(dev, old_dyn_addr);
> +		if (ret) {
> +			i3c_master_put_i3c_addrs(dev);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void i3c_master_detach_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> +
> +	/* Do not detach the master device itself. */
> +	if (master->this != dev && master->ops->detach_i3c_dev)
> +		master->ops->detach_i3c_dev(dev);
> +
> +	i3c_master_put_i3c_addrs(dev);
> +	list_del(&dev->common.node);
> +}
> +
> +static int i3c_master_attach_i2c_dev(struct i3c_master_controller
*master,
> +				     struct i2c_dev_desc *dev)
> +{
> +	int ret;
> +
> +	if (master->ops->attach_i2c_dev) {
> +		ret = master->ops->attach_i2c_dev(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	list_add_tail(&dev->common.node, &master->bus->devs.i2c);
> +
> +	return 0;
> +}
> +
> +static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *master = i2c_dev_get_master(dev);
> +
> +	list_del(&dev->common.node);
> +
> +	if (master->ops->detach_i2c_dev)
> +		master->ops->detach_i2c_dev(dev);
> +}
> +
> +static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> +	struct i3c_device_info info;
> +	int ret;
> +
> +	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
> +	    !dev->boardinfo->static_addr)
> +		return;
> +
> +	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
> +					dev->boardinfo->init_dyn_addr);
> +	if (ret)
> +		return;
> +
> +	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
> +	ret = i3c_master_reattach_i3c_dev(dev, 0);
> +	if (ret)
> +		return;
> +
> +	ret = i3c_master_retrieve_dev_info(dev);
> +	if (ret)
> +		goto err_rstdaa;
> +
> +	dev->info = info;
> +
> +	return;
> +
> +err_rstdaa:
> +	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
> +}
> +
> +static void
> +i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
> +{
> +	struct i3c_dev_desc *desc;
> +	int ret;
> +
> +	if (!master->init_done)
> +		return;
> +
> +	i3c_bus_for_each_i3cdev(master->bus, desc) {
> +		if (desc->dev || !desc->info.dyn_addr)
> +			continue;
> +
> +		desc->dev = kzalloc(sizeof(*desc->dev), GFP_KERNEL);
> +		if (!desc->dev)
> +			continue;
> +
> +		desc->dev->bus = master->bus;
> +		desc->dev->desc = desc;
> +		desc->dev->dev.parent = &master->bus->dev;
> +		if (desc == master->this)
> +			desc->dev->dev.type = &i3c_master_type;
> +		else
> +			desc->dev->dev.type = &i3c_device_type;
> +		desc->dev->dev.bus = &i3c_bus_type;
> +		desc->dev->dev.release = i3c_device_release;
> +		dev_set_name(&desc->dev->dev, "%d-%llx", master->bus-
> >id,
> +			     desc->info.pid);
> +
> +		if (desc->boardinfo)
> +			desc->dev->dev.of_node = desc->boardinfo-
> >of_node;
> +
> +		pr_info("%s:%i\n", __func__, __LINE__);
> +		if (ret)
> +			dev_err(master->parent,
> +				"Failed to add I3C device (err = %d)\n",
ret);
> +	}
> +}

The compiler gives a warning that "ret" may be used uninitialized in the
above function, which is true since "ret" is never assigned a value.  Also,
I wonder about the "pr_info" call here, should there be a more detailed
message here about the device being registered, other than the file name and
line number?

Otherwise, I have gone through the code in the process of writing the first
iteration of the Qualcomm I3C master driver, and overall the framework looks
good.  Will update with any additional feedback I have.


--
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a
Linux Foundation Collaborative Project

