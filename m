Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C74208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neUTvp0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C74208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934073AbeGIRlT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:41:19 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38377 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933607AbeGIRko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:40:44 -0400
Received: by mail-yw0-f193.google.com with SMTP id r3-v6so6833135ywc.5;
        Mon, 09 Jul 2018 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQY0U7J5HcdHqw8eToZex0ft7dydWeDTVicbxmiCyL0=;
        b=neUTvp0kAC1IeHDsPYFA4OBl+JnswUMnHd9KmaN5p8WyNzhFblxYcd6WCYXuMHObAa
         z0xI1tPEuEi/zf6L/43MiTViu/yQuv8ug3R3qY/3PQ7GqdqATA1mQcfVLfHEl5JbjjJq
         TZmPrHJvjo3jq2yrUkYOFe/drw60SyIE4HppVsU2zOqYS42+olmAV/omy8feXmEkmYgK
         UwBIZ/kP9WEdJ3b13y/CpYoBm34Cw/KAo9txYheFMkglppVbBTtihmvvOGQgfbNCbgFh
         fBd8Fby+ZvjFEo5ubaHI/8WEiX0AYam7hf0Uy5IzsjYukZnhVWNJbFznN0pOYq3yTVKX
         UPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQY0U7J5HcdHqw8eToZex0ft7dydWeDTVicbxmiCyL0=;
        b=FJA1f5FZZOIWK/zpcbRM/5UmX16YQHmxbRM/RHKjKsxcBhyYF45jqnyJ2K8KXEFjWq
         vgevLSwEB4h5XQcw9pCNzfMpaqUYXf+Ac2Ihe3OvHK+9I6uDjA/y0Xh9Y8Z2PNBiWzKz
         y/7XTzl4nVJVqopvBbmX2FZVsbZO2QCjJ0mTNlOcl2wtjIcXItXBZnMW1cc3oPDV63uq
         +/NzuIei79nsu01nbLHBthkEWbNLoIHKqNZUbXdl9y5/JYdtKJhX12XQ92qyQxhDXQbI
         85rJvBtGmjcqZEVVuaWSU4PEqlh7rh+4LqIsi7LaO76LweSTVQ5103e05Z0SA4H9waZU
         mwgg==
X-Gm-Message-State: APt69E1yGuu23tjdXfSUDuTezdYZwuNvjFHD2ih2rQoqXf6le/xfNjzn
        Voywd+xOKs/9oqcTwYQ+3sc=
X-Google-Smtp-Source: AAOMgpd4AZXzyJJWYw43Pz1XBl/VsdbEe42blR/RLH9nmB2DvmfVkUjIplrOwU8H0u2A9WYTse44sg==
X-Received: by 2002:a81:22c3:: with SMTP id i186-v6mr10310283ywi.309.1531158043214;
        Mon, 09 Jul 2018 10:40:43 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id 200-v6sm7401199ywo.54.2018.07.09.10.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 10:40:42 -0700 (PDT)
Date:   Mon, 9 Jul 2018 13:40:36 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter interface
Message-ID: <20180709174026.GA29186@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
 <20180707151622.GB410@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180707151622.GB410@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 05:16:22PM +0200, Greg KH wrote:
>On Thu, Jun 21, 2018 at 05:07:08PM -0400, William Breathitt Gray wrote:
>> This patch introduces the Generic Counter interface for supporting
>> counter devices.
>> 
>> In the context of the Generic Counter interface, a counter is defined as
>> a device that reports one or more "counts" based on the state changes of
>> one or more "signals" as evaluated by a defined "count function."
>> 
>> Driver callbacks should be provided to communicate with the device: to
>> read and write various Signals and Counts, and to set and get the
>> "action mode" and "count function" for various Synapses and Counts
>> respectively.
>> 
>> To support a counter device, a driver must first allocate the available
>> Counter Signals via counter_signal structures. These Signals should
>> be stored as an array and set to the signals array member of an
>> allocated counter_device structure before the Counter is registered to
>> the system.
>> 
>> Counter Counts may be allocated via counter_count structures, and
>> respective Counter Signal associations (Synapses) made via
>> counter_synapse structures. Associated counter_synapse structures are
>> stored as an array and set to the the synapses array member of the
>> respective counter_count structure. These counter_count structures are
>> set to the counts array member of an allocated counter_device structure
>> before the Counter is registered to the system.
>> 
>> A counter device is registered to the system by passing the respective
>> initialized counter_device structure to the counter_register function;
>> similarly, the counter_unregister function unregisters the respective
>> Counter. The devm_counter_register and devm_counter_unregister functions
>> serve as device memory-managed versions of the counter_register and
>> counter_unregister functions respectively.
>> 
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> ---
>>  MAINTAINERS                       |    7 +
>>  drivers/Kconfig                   |    2 +
>>  drivers/Makefile                  |    1 +
>>  drivers/counter/Kconfig           |   18 +
>>  drivers/counter/Makefile          |    8 +
>>  drivers/counter/generic-counter.c | 1519 +++++++++++++++++++++++++++++
>>  include/linux/counter.h           |  534 ++++++++++
>>  7 files changed, 2089 insertions(+)
>>  create mode 100644 drivers/counter/Kconfig
>>  create mode 100644 drivers/counter/Makefile
>>  create mode 100644 drivers/counter/generic-counter.c
>>  create mode 100644 include/linux/counter.h
>
>First cut of review, does counter.h really have to be that big?  It
>feels like some of the "internal" functions and structures could be
>local to drivers/counter/ right?

Most of the functions and structures in counter.h are used by driver
callbacks to interact with the Generic Counter interface, and thus need
to be exposed. There are some helper functions (for example, the
counter_count_enum_read and counter_count_enum_write functions) which
are not expected to be used directly by drivers, but as prepackaged
functionality to populate macros (COUNTER_COUNT_ENUM in this case); in
these cases, it is still necessary to expose these functions because the
exposed macros are dependent on them.

However, having such a large header file can be difficult for a human to
parse and debug. Would it make sense for me to break this single large
header file into several smaller header files by categories (e.g.
counter_signal.h, counter_count.h, counter_count_enum.h, etc.), and
use include lines to form a more concise counter.h header file?

>> +menuconfig COUNTER
>> +	tristate "Counter support"
>> +	help
>> +	  Provides Generic Counter interface support for counter devices.
>> +
>> +	  Counter devices are prevalent within a diverse spectrum of industries.
>> +	  The ubiquitous presence of these devices necessitates a common
>> +	  interface and standard of interaction and exposure. This driver API
>> +	  attempts to resolve the issue of duplicate code found among existing
>> +	  counter device drivers by providing a generic counter interface for
>> +	  consumption. The Generic Counter interface enables drivers to support
>> +	  and expose a common set of components and functionality present in
>> +	  counter devices.
>
>No need to explain an "API" in a Kconfig help text, which is for a user
>of the kernel, not for someone writing kernel code.  Odds are individual
>drivers will need to select this, or are you going to depend on this
>option?

I'm not sure if there will be situation where a user will want to
compile generic-counter.c without a counter device driver, so we can go
with the select style for now unless a need comes up for depend. I'll
simplify the Kconfig text according.

>> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
>> new file mode 100644
>> index 000000000000..ad1ba7109cdc
>> --- /dev/null
>> +++ b/drivers/counter/Makefile
>> @@ -0,0 +1,8 @@
>> +#
>> +# Makefile for Counter devices
>> +#
>> +
>> +# When adding new entries keep the list in alphabetical order
>
>Why does it matter?  :)

Fair point, I'll take this comment out.

>> +
>> +obj-$(CONFIG_COUNTER) += counter.o
>> +counter-y := generic-counter.o
>
>Why not just call your .c file, "counter.c" to keep this simple?

This is a hold over from when counter.c was composed of multiple files.
I'll rename generic-counter.c to counter.c in order to simplify this
line.

>> diff --git a/drivers/counter/generic-counter.c b/drivers/counter/generic-counter.c
>> new file mode 100644
>> index 000000000000..483826c8ce01
>> --- /dev/null
>> +++ b/drivers/counter/generic-counter.c
>> @@ -0,0 +1,1519 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>
>Please use the normal SPDX identifiers we are using, as described in the
>kernel documentation.  We aren't ready to use the "new" ones just yet.
>
>> +/*
>> + * Generic Counter interface
>> + * Copyright (C) 2017 William Breathitt Gray
>
>It's 2018 now :)

No problem, I'll update the year text as well as the SPDX identifiers
throughout the files in this patchset.

>> + */
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/export.h>
>> +#include <linux/fs.h>
>> +#include <linux/gfp.h>
>> +#include <linux/idr.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/printk.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/counter.h>
>
>Why a blank line?

I'll clean this up.

>> +
>> +const char *const count_direction_str[2] = {
>> +	[COUNT_DIRECTION_FORWARD] = "forward",
>> +	[COUNT_DIRECTION_BACKWARD] = "backward"
>> +};
>> +EXPORT_SYMBOL(count_direction_str);
>
>I have to ask, for all of these, why not EXPORT_SYMBOL_GPL()?

This was an oversight: I intend for all of these to be
EXPORT_SYMBOL_GPL. I'll fix these in the next revision.

>> +
>> +const char *const count_mode_str[4] = {
>> +	[COUNT_MODE_NORMAL] = "normal",
>> +	[COUNT_MODE_RANGE_LIMIT] = "range limit",
>> +	[COUNT_MODE_NON_RECYCLE] = "non-recycle",
>> +	[COUNT_MODE_MODULO_N] = "modulo-n"
>> +};
>> +EXPORT_SYMBOL(count_mode_str);
>
>And why do you need to export strings?

The idea is to provide a lookup table of string constants so that driver
callbacks return consistent count_mode values to userspace. The
count_mode sysfs attribute is implemented via a counter_count_enum_ext
structure which takes an array of possible string options available, so
that is why this particular string array is exported. The driver
callbacks interact only with the index defines (COUNT_MODE_NORMAL,
COUNT_MODE_RANGE_LIMIT, etc.), while the respective string constants are
found in the array and supplied to/from userspace via the predefined
Generic Counter counter_count_enum_read/counter_count_enum_write
functions.

>> +
>> +ssize_t counter_signal_enum_read(struct counter_device *counter,
>> +				 struct counter_signal *signal, void *priv,
>> +				 char *buf)
>> +{
>> +	const struct counter_signal_enum_ext *const e = priv;
>> +	int err;
>> +	size_t index;
>> +
>> +	if (!e->get)
>> +		return -EINVAL;
>
>How can e->get not be set?  Shouldn't you just not have called into this
>if so?

e->get is a callback provided by the driver and may not be set. This
configuration is possible if the device does not provide a read
functionality for its options, but does permit write operations for
those options.

counter_signal_enum_read is used as a helper function to build the
COUNTER_SIGNAL_ENUM macro (as the read callback). Since
COUNTER_SIGNAL_ENUM is intended to be general, the
counter_signal_enum_read is set as the read callback unconditionally --
this means e->get can't be checked before but must instead be checked
from within to handle cases where the device does not support reads.

>> +
>> +	err = e->get(counter, signal, &index);
>> +	if (err)
>> +		return err;
>> +
>> +	if (index >= e->num_items)
>> +		return -EINVAL;
>> +
>> +	return scnprintf(buf, PAGE_SIZE, "%s\n", e->items[index]);
>
>No need to do the scnprintf() crud, it's a sysfs file, a simple
>sprintf() works just fine.  Yeah, it makes people nervous, and it should :)

Okay, I'll use sprintf in these situations.

>> +}
>> +EXPORT_SYMBOL(counter_signal_enum_read);
>
>sysfs attribute files really should be EXPORT_SYMBOL_GPL() please.
>
>> +
>> +ssize_t counter_signal_enum_write(struct counter_device *counter,
>> +				  struct counter_signal *signal, void *priv,
>> +				  const char *buf, size_t len)
>> +{
>> +	const struct counter_signal_enum_ext *const e = priv;
>> +	ssize_t index;
>> +	int err;
>> +
>> +	if (!e->set)
>> +		return -EINVAL;
>
>Again, how can this be true?

This is the same situation as counter_signal_enum_read, but for write
operations instead of reads.

>> +
>> +	index = __sysfs_match_string(e->items, e->num_items, buf);
>> +	if (index < 0)
>> +		return index;
>> +
>> +	err = e->set(counter, signal, index);
>> +	if (err)
>> +		return err;
>> +
>> +	return len;
>> +}
>> +EXPORT_SYMBOL(counter_signal_enum_write);
>> +
>> +ssize_t counter_signal_enum_available_read(struct counter_device *counter,
>> +					   struct counter_signal *signal,
>> +					   void *priv, char *buf)
>> +{
>> +	const struct counter_signal_enum_ext *const e = priv;
>> +	size_t i;
>> +	size_t len = 0;
>> +
>> +	if (!e->num_items)
>> +		return 0;
>> +
>> +	for (i = 0; i < e->num_items; i++)
>> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
>> +			e->items[i]);
>
>a list of items?  In sysfs?  Are you _SURE_ you want to do that?

I'm modeling this behavior on the IIO *_available sysfs attributes. I
realize sysfs attributes are suppose to display only a single piece of
information, but I believe this is acceptable in this case due the
existing usage present in IIO. I'm open to a different design, but I
think a list is the most straight-forward way to expose the available
options provided by the device.

>> +
>> +	return len;
>> +}
>> +EXPORT_SYMBOL(counter_signal_enum_available_read);
>> +
>> +ssize_t counter_count_enum_read(struct counter_device *counter,
>> +				struct counter_count *count, void *priv,
>> +				char *buf)
>> +{
>> +	const struct counter_count_enum_ext *const e = priv;
>> +	int err;
>> +	size_t index;
>> +
>> +	if (!e->get)
>> +		return -EINVAL;
>
>
>Same comment everywhere for this...
>
>let's skip lower in the files...
>
>> +static int counter_attribute_create(
>> +	struct counter_device_attr_group *const group,
>> +	const char *const prefix,
>> +	const char *const name,
>> +	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
>> +			char *buf),
>> +	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
>> +			 const char *buf, size_t len),
>
>Typedefs for these function pointers are good to have.
>
>> +	void *const component)
>
>That's a crazy list of parameters...

These are a bit verbose, so I'll rework it with some typedefs to
simplify this parameter list.

>> +{
>> +	struct counter_device_attr *counter_attr;
>> +	struct device_attribute *dev_attr;
>> +	int err;
>> +	struct list_head *const attr_list = &group->attr_list;
>> +
>> +	/* Allocate a Counter device attribute */
>> +	counter_attr = kzalloc(sizeof(*counter_attr), GFP_KERNEL);
>> +	if (!counter_attr)
>> +		return -ENOMEM;
>> +	dev_attr = &counter_attr->dev_attr;
>> +
>> +	sysfs_attr_init(&dev_attr->attr);
>> +
>> +	/* Configure device attribute */
>> +	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", prefix, name);
>> +	if (!dev_attr->attr.name) {
>> +		err = -ENOMEM;
>> +		goto err_free_counter_attr;
>> +	}
>> +	if (show) {
>> +		dev_attr->attr.mode |= 0444;
>> +		dev_attr->show = show;
>> +	}
>> +	if (store) {
>> +		dev_attr->attr.mode |= 0200;
>> +		dev_attr->store = store;
>> +	}
>> +
>> +	/* Store associated Counter component with attribute */
>> +	counter_attr->component = component;
>> +
>> +	/* Keep track of the attribute for later cleanup */
>> +	list_add(&counter_attr->l, attr_list);
>> +	group->num_attr++;
>
>So you are dynamically creating sysfs attributes?  Why not just have one
>big group and only enable them if needed?  That would make things a lot
>simpler, right?

Counter device drivers are permitted to supply their own extension
structures to enable the configuration of various miscellaneous features
provided by the device; since these may be extensions are unique to each
driver, the respective sysfs attributes must be dynamically generated
because they are not known by the Generic Counter system beforehand.

In order to avoid code duplication, I also leverage this function to
generate the standard Generic Counter interface sysfs attributes as
well; that's why you see all components end up here regardless of
whether they are standard or extensions.

>> +struct signal_comp_t {
>
>"_t"???

These are helper containers to hold component-relevant data to pass down
when using the generic counter_attribute_create to generate the sysfs
attributes. The *_t naming convention may not be appropriate for this
case, so I can rename them to *_container or something along those
lines.

>> +	struct counter_signal	*signal;
>> +};
>> +
>> +static ssize_t counter_signal_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct counter_device *const counter = dev_get_drvdata(dev);
>> +	const struct counter_device_attr *const devattr = to_counter_attr(attr);
>> +	const struct signal_comp_t *const component = devattr->component;
>> +	struct counter_signal *const signal = component->signal;
>> +	int err;
>> +	struct signal_read_value val = { .buf = buf };
>> +
>> +	err = counter->ops->signal_read(counter, signal, &val);
>> +	if (err)
>> +		return err;
>> +
>> +	return val.len;
>> +}
>> +
>> +struct name_comp_t {
>
>"_t"???
>
>Same for the rest of this file...
>
>> diff --git a/include/linux/counter.h b/include/linux/counter.h
>> new file mode 100644
>> index 000000000000..88fc82ee30a7
>> --- /dev/null
>> +++ b/include/linux/counter.h
>> @@ -0,0 +1,534 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>
>Same identifier issue.
>
>> +/*
>> + * Counter interface
>> + * Copyright (C) 2017 William Breathitt Gray
>
>2018!
>
>And again, it looks like this file can be a lot smaller, but I don't see
>a user of it just yet, so I don't really know...
>
>thanks,
>
>greg k-h

I'll make the updates noted in a version 8 submission, but I'll wait to
submit it until you have a chance to review the rest of this current
patchset. The counter device drivers in this directory (104-quad-8.c,
stm32-lptimer-cnt.c, stm32-timer-cnt.c) should give you an idea of how
the counter.h file is used at the moment.

Thank you,

William Breathitt Gray
